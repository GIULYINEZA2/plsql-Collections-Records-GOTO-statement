-- Create Students Table
CREATE TABLE students (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department VARCHAR2(50),
    enrollment_year NUMBER(4)
);

-- Create Courses Table
CREATE TABLE courses (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(100),
    credits NUMBER(1)
);

-- Create Enrollments Table
CREATE TABLE enrollments (
    enrollment_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    course_id NUMBER,
    grade NUMBER(5,2),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
