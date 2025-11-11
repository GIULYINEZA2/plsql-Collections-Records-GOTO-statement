-- Check students
SELECT * FROM students;

-- Check courses
SELECT * FROM courses;

-- Check enrollments with details
SELECT 
    s.first_name || ' ' || s.last_name AS student_name,
    c.course_name,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.student_id;
