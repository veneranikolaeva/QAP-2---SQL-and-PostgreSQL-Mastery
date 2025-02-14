CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    school_enrollment_date DATE NOT NULL
);

CREATE TABLE professors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) UNIQUE NOT NULL,
    course_description TEXT,
    professor_id INTEGER REFERENCES professors(id) ON DELETE CASCADE
);

CREATE TABLE enrollments (
    student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES courses(id) ON DELETE CASCADE,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO professors (first_name, last_name, department) VALUES
('Alfred', 'Hitchcock', 'Film Studies'),
('Jane', 'Austen', 'English'),
('Albert', 'Einstein', 'Physics'),
('Marie', 'Curie', 'Chemistry');

-- Inserting courses
INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Physics 101', 'Introduction to Physics', 3),
('English Literature', 'Survey of English Literature', 2),
('Film History', 'History of Cinema', 1);

-- Inserting students
INSERT INTO students (first_name, last_name, email, school_enrollment_date) VALUES
('Alice', 'Smith', 'alice.smith@example.com', '2024-09-01'),
('Bob', 'Johnson', 'bob.johnson@example.com', '2024-09-01'),
('Charlie', 'Brown', 'charlie.brown@example.com', '2024-09-01'),
('Diana', 'Davis', 'diana.davis@example.com', '2024-09-01'),
('Eve', 'Wilson', 'eve.wilson@example.com', '2024-09-01');


-- Inserting enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-09-10'),
(1, 2, '2024-09-10'),
(2, 1, '2024-09-10'),
(3, 3, '2024-09-10'),
(4, 2, '2024-09-10'),
(5,3, '2024-09-10');

UPDATE students SET email = 'alice.newmail@example.com' WHERE id = 1;

DELETE FROM enrollments WHERE student_id = 1 AND course_id = 2;