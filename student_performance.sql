-- Student Performance Analysis System
-- Author: Garvit Batra
-- Description: Demonstrates SQL skills with table creation, data insertion, and queries.

-- Drop tables if they already exist
DROP TABLE IF EXISTS ExamResults;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Courses;

-- Create Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    department VARCHAR(30),
    year_of_study INT
);

-- Create Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT
);

-- Create ExamResults table
CREATE TABLE ExamResults (
    result_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert sample Students
INSERT INTO Students VALUES
(1, 'Aarav Sharma', 'ECE', 2),
(2, 'Priya Verma', 'CSE', 3),
(3, 'Rohit Gupta', 'IT', 1),
(4, 'Neha Singh', 'CSE', 4),
(5, 'Vikas Kumar', 'ECE', 2),
(6, 'Ananya Jain', 'IT', 3),
(7, 'Rajat Mehta', 'CSE', 1),
(8, 'Simran Kaur', 'ECE', 4),
(9, 'Aman Yadav', 'IT', 2),
(10, 'Kriti Bansal', 'CSE', 3);

-- Insert sample Courses
INSERT INTO Courses VALUES
(101, 'Database Systems', 4),
(102, 'Operating Systems', 3),
(103, 'Data Structures', 4),
(104, 'Machine Learning', 3),
(105, 'Computer Networks', 3);

-- Insert sample ExamResults
INSERT INTO ExamResults VALUES
(1, 1, 101, 85),
(2, 1, 102, 78),
(3, 1, 103, 92),
(4, 2, 101, 88),
(5, 2, 104, 90),
(6, 3, 102, 65),
(7, 3, 105, 72),
(8, 4, 101, 95),
(9, 4, 103, 89),
(10, 5, 102, 55),
(11, 5, 105, 48),
(12, 6, 103, 76),
(13, 6, 104, 84),
(14, 7, 101, 36),
(15, 7, 102, 42),
(16, 8, 105, 93),
(17, 8, 104, 87),
(18, 9, 103, 58),
(19, 9, 104, 49),
(20, 10, 102, 91);

-- ================= Sample Queries =================

-- 1. Top 3 students overall by average marks
SELECT s.student_name, AVG(e.marks) AS avg_marks
FROM Students s
JOIN ExamResults e ON s.student_id = e.student_id
GROUP BY s.student_id
ORDER BY avg_marks DESC
LIMIT 3;

-- 2. Average marks per course
SELECT c.course_name, AVG(e.marks) AS avg_marks
FROM Courses c
JOIN ExamResults e ON c.course_id = e.course_id
GROUP BY c.course_id;

-- 3. Students failing in any course (marks < 40)
SELECT DISTINCT s.student_name, e.marks
FROM Students s
JOIN ExamResults e ON s.student_id = e.student_id
WHERE e.marks < 40;

-- 4. Highest scorer per course
SELECT c.course_name, s.student_name, e.marks
FROM ExamResults e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE e.marks = (
    SELECT MAX(marks)
    FROM ExamResults
    WHERE course_id = c.course_id
);
