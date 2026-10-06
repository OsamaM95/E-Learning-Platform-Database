-- =======================================================
-- Project Name: E-Learning Platform Database
-- Prepared by: Eng. Osama Mohamed
-- Execution Date: June 17, 2026
-- =======================================================

-- 1. Create and use the database
CREATE DATABASE LearningDB;
GO
USE LearningDB;
GO

-- 2. Create tables and define relationships (Schema)

-- A. Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    EnrollmentDate DATETIME DEFAULT GETDATE()
);

-- B. Instructors Table
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Expertise NVARCHAR(100)
);

-- C. Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    CourseName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

-- D. Enrollments and Grades Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATETIME DEFAULT GETDATE(),
    Grade NVARCHAR(5),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
GO

-- 3. Populate tables with sample data (Data Insertion)

-- Insert Instructors
INSERT INTO Instructors (FirstName, LastName, Email, Expertise) VALUES 
('Ahmed', 'Ali', 'ahmed.ali@email.com', 'C# & .NET'),
('Mohamed', 'Sayed', 'mohamed.sayed@email.com', 'SQL Databases');

-- Insert Courses
INSERT INTO Courses (CourseName, Description, InstructorID) VALUES 
('Back-End Development', 'Learn C# and ASP.NET Core from scratch', 1),
('SQL Server Basics', 'Learn database design and queries', 2);

-- Insert Students
INSERT INTO Students (FirstName, LastName, Email) VALUES 
('Osama', 'Mohamed', 'osama@email.com'),
('Youssef', 'Amr', 'youssef@email.com');

-- Enroll students in courses and assign grades
INSERT INTO Enrollments (StudentID, CourseID, Grade) VALUES 
(1, 1, 'A'),   
(1, 2, 'A+'),  
(2, 1, 'B');   
GO

-- 4. Comprehensive query and final report generation (Reporting)
SELECT 
    E.EnrollmentID AS [رقم التسجيل],
    S.FirstName + ' ' + S.LastName AS [اسم الطالب],
    C.CourseName AS [اسم الكورس],
    I.FirstName + ' ' + I.LastName AS [اسم المدرس],
    E.Grade AS [التقدير],
    E.EnrollmentDate AS [تاريخ التسجيل]
FROM Enrollments E
INNER JOIN Students S ON E.StudentID = S.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID
INNER JOIN Instructors I ON C.InstructorID = I.InstructorID;
GO