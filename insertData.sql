INSERT INTO students VALUES (1, 'Kevin', 'Ndayishimiye', 'Computer Science', 2023);
INSERT INTO students VALUES (2, 'Linda', 'Uwimana', 'Information Technology', 2023);
INSERT INTO students VALUES (3, 'Patrick', 'Habimana', 'Business Administration', 2024);
INSERT INTO students VALUES (4, 'Sarah', 'Iradukunda', 'Engineering', 2023);
INSERT INTO students VALUES (5, 'James', 'Mutabazi', 'Computer Science', 2024);



INSERT INTO courses VALUES (201, 'Introduction to Programming', 3);
INSERT INTO courses VALUES (202, 'Network Fundamentals', 3);
INSERT INTO courses VALUES (203, 'Systems Analysis and Design', 4);
INSERT INTO courses VALUES (204, 'Computer Architecture', 3);
INSERT INTO courses VALUES (205, 'Human-Computer Interaction', 4);



INSERT INTO enrollments VALUES (1, 1, 201, 83.5);
INSERT INTO enrollments VALUES (2, 1, 202, 90.0);
INSERT INTO enrollments VALUES (3, 1, 203, 79.5);

INSERT INTO enrollments VALUES (4, 2, 201, 67.0);
INSERT INTO enrollments VALUES (5, 2, 202, 59.5);
INSERT INTO enrollments VALUES (6, 2, 203, 72.0);

INSERT INTO enrollments VALUES (7, 3, 201, 88.0);
INSERT INTO enrollments VALUES (8, 3, 202, 92.5);

INSERT INTO enrollments VALUES (9, 4, 203, 48.0);
INSERT INTO enrollments VALUES (10, 4, 204, 55.0);

INSERT INTO enrollments VALUES (11, 5, 201, 96.0);
INSERT INTO enrollments VALUES (12, 5, 205, 87.0);

COMMIT;




