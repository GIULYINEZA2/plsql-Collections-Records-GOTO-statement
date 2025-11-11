
SET SERVEROUTPUT ON SIZE UNLIMITED;
SET DEFINE OFF;

DECLARE
    -- ========================================
    -- COLLECTION TYPE DEFINITIONS
    -- ========================================
    
    -- VARRAY: Fixed-size array for course grades (max 6 courses)
    TYPE grade_varray IS VARRAY(6) OF NUMBER(5,2);
    
    -- Nested Table: Dynamic list for student remarks/warnings
    TYPE remarks_table IS TABLE OF VARCHAR2(200);
    
    -- Associative Array: Department-wise statistics
    -- FIXED precision (was NUMBER(4,2), now NUMBER(10,2))
    TYPE dept_stats_array IS TABLE OF NUMBER(10,2) INDEX BY VARCHAR2(50);
    
    -- ========================================
    -- RECORD TYPE DEFINITIONS
    -- ========================================
    
    TYPE student_performance_rec IS RECORD (
        student_id NUMBER,
        full_name VARCHAR2(100),
        department VARCHAR2(50),
        grades grade_varray,
        gpa NUMBER(4,2),
        total_credits NUMBER,
        status VARCHAR2(20),
        remarks remarks_table
    );
    
    TYPE students_table IS TABLE OF student_performance_rec;
    
    -- ========================================
    -- VARIABLE DECLARATIONS
    -- ========================================
    
    v_students students_table := students_table();
    v_dept_stats dept_stats_array;
    v_student student_performance_rec;
    v_grade_sum NUMBER := 0;
    v_credit_sum NUMBER := 0;
    v_course_count NUMBER := 0;
    v_dept_count NUMBER := 0;
    v_error_count NUMBER := 0;
    
    CURSOR c_students IS
        SELECT s.student_id, s.first_name, s.last_name, s.department
        FROM students s
        ORDER BY s.department, s.student_id;
    
    CURSOR c_grades(p_student_id NUMBER) IS
        SELECT e.grade, c.credits
        FROM enrollments e
        JOIN courses c ON e.course_id = c.course_id
        WHERE e.student_id = p_student_id
        ORDER BY e.enrollment_id;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('   STUDENT GRADE MANAGEMENT SYSTEM');
    DBMS_OUTPUT.PUT_LINE('   Using Collections, Records & GOTO Statements');
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('');
    
    FOR student_rec IN c_students LOOP
        BEGIN
            v_student.student_id := student_rec.student_id;
            v_student.full_name := student_rec.first_name || ' ' || student_rec.last_name;
            v_student.department := student_rec.department;
            v_student.grades := grade_varray();
            v_student.remarks := remarks_table();
            
            v_grade_sum := 0;
            v_credit_sum := 0;
            v_course_count := 0;
            
            <<fetch_grades>>
            FOR grade_rec IN c_grades(student_rec.student_id) LOOP
                v_course_count := v_course_count + 1;
                
                IF v_course_count > 6 THEN
                    v_student.remarks.EXTEND;
                    v_student.remarks(v_student.remarks.COUNT) := 
                        'WARNING: Enrolled in more than 6 courses';
                    GOTO skip_grade_processing;
                END IF;
                
                IF grade_rec.grade < 0 OR grade_rec.grade > 100 THEN
                    v_student.remarks.EXTEND;
                    v_student.remarks(v_student.remarks.COUNT) := 
                        'ERROR: Invalid grade detected';
                    v_error_count := v_error_count + 1;
                    GOTO skip_grade_processing;
                END IF;
                
                v_student.grades.EXTEND;
                v_student.grades(v_course_count) := grade_rec.grade;
                v_grade_sum := v_grade_sum + (grade_rec.grade * grade_rec.credits);
                v_credit_sum := v_credit_sum + grade_rec.credits;
                
                <<skip_grade_processing>>
                NULL;
            END LOOP;
            
            IF v_credit_sum = 0 THEN
                v_student.remarks.EXTEND;
                v_student.remarks(v_student.remarks.COUNT) := 'No valid grades found';
                GOTO skip_student;
            END IF;
            
            v_student.gpa := ROUND(v_grade_sum / v_credit_sum, 2);
            v_student.total_credits := v_credit_sum;
            
            IF v_student.gpa >= 85 THEN
                v_student.status := 'EXCELLENT';
                GOTO add_excellence_remark;
            ELSIF v_student.gpa >= 70 THEN
                v_student.status := 'GOOD';
                GOTO add_good_remark;
            ELSIF v_student.gpa >= 60 THEN
                v_student.status := 'SATISFACTORY';
                GOTO add_warning_remark;
            ELSE
                v_student.status := 'AT RISK';
                GOTO add_intervention_remark;
            END IF;
            
            <<add_excellence_remark>>
            v_student.remarks.EXTEND;
            v_student.remarks(v_student.remarks.COUNT) := 'Eligible for Dean''s List';
            GOTO finalize_student;
            
            <<add_good_remark>>
            v_student.remarks.EXTEND;
            v_student.remarks(v_student.remarks.COUNT) := 'Good academic standing';
            GOTO finalize_student;
            
            <<add_warning_remark>>
            v_student.remarks.EXTEND;
            v_student.remarks(v_student.remarks.COUNT) := 'Monitor academic progress';
            GOTO finalize_student;
            
            <<add_intervention_remark>>
            v_student.remarks.EXTEND;
            v_student.remarks(v_student.remarks.COUNT) := 'URGENT: Academic intervention required';
            v_student.remarks.EXTEND;
            v_student.remarks(v_student.remarks.COUNT) := 'Schedule meeting with academic advisor';
            
            <<finalize_student>>
            v_students.EXTEND;
            v_students(v_students.COUNT) := v_student;
            
            <<skip_student>>
            NULL;
            
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error processing student ' || 
                    student_rec.student_id || ': ' || SQLERRM);
                v_error_count := v_error_count + 1;
        END;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('INDIVIDUAL STUDENT REPORTS');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    
    FOR i IN 1..v_students.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_students(i).student_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_students(i).full_name);
        DBMS_OUTPUT.PUT_LINE('Department: ' || v_students(i).department);
        DBMS_OUTPUT.PUT_LINE('GPA: ' || v_students(i).gpa);
        DBMS_OUTPUT.PUT_LINE('Total Credits: ' || v_students(i).total_credits);
        DBMS_OUTPUT.PUT_LINE('Status: ' || v_students(i).status);
        
        DBMS_OUTPUT.PUT('Grades: ');
        FOR j IN 1..v_students(i).grades.COUNT LOOP
            DBMS_OUTPUT.PUT(v_students(i).grades(j) || ' ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        
        IF v_students(i).remarks.COUNT > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Remarks:');
            FOR j IN 1..v_students(i).remarks.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE('  - ' || v_students(i).remarks(j));
            END LOOP;
        END IF;
        
        IF v_dept_stats.EXISTS(v_students(i).department) THEN
            v_dept_stats(v_students(i).department) := 
                v_dept_stats(v_students(i).department) + v_students(i).gpa;
        ELSE
            v_dept_stats(v_students(i).department) := v_students(i).gpa;
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('DEPARTMENT STATISTICS (Associative Array)');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    
    DECLARE
        v_dept_name VARCHAR2(50);
    BEGIN
        v_dept_name := v_dept_stats.FIRST;
        WHILE v_dept_name IS NOT NULL LOOP
            v_dept_count := 0;
            FOR i IN 1..v_students.COUNT LOOP
                IF v_students(i).department = v_dept_name THEN
                    v_dept_count := v_dept_count + 1;
                END IF;
            END LOOP;
            
            DBMS_OUTPUT.PUT_LINE('Department: ' || v_dept_name);
            DBMS_OUTPUT.PUT_LINE('  Average GPA: ' || 
                ROUND(v_dept_stats(v_dept_name) / v_dept_count, 2));
            DBMS_OUTPUT.PUT_LINE('  Total Students: ' || v_dept_count);
            DBMS_OUTPUT.PUT_LINE('');
            
            v_dept_name := v_dept_stats.NEXT(v_dept_name);
        END LOOP;
    END;
    
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('SYSTEM SUMMARY');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Students Processed: ' || v_students.COUNT);
    DBMS_OUTPUT.PUT_LINE('Errors Encountered: ' || v_error_count);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=================================================');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CRITICAL ERROR: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
END;
/
