/* CSCI 6622 - Quiz 1 - Howard Zhou
A tutoring service needs a database to record information on students and their
tutors.
The database records each student's unique ID number, first name, last name, and
birthdate.
For each tutor, the database records a unique employee ID number, first name, last
name, and the date he/she/they started working.
The database also tracks each tutoring session. A tutoring session involves exactly
one student and exactly one tutor;
sessions start at the top of the hour and last a maximum of one hour.
For each session, the database tracks the date and time of the start of the
session,
the tutor and student involved and how many minutes the session lasted.
Please write SQL statements to create the database and the tables. Make judicious
choices for data types, and try to enforce the underlying business
constraints in the DBMS, e.g. a tutor or a student can be in one session at a given
time, a session cannot last more than an hour, etc.
Upload an sql file that contains the creation statements. */
/*
Student
Unique ID number
FirstName
LastName
Birthdate
Tutor
unique Employee ID,
FirstName
LastName
DateStarted
Database tracks each tutoring session:
- date and time of start of session
- involves one student and one tutor
- how many minutes the session lasted 1hr max
*/
--Create Student Table
CREATE DATABASE tutoring_quiz1_hz;
USE tutoring;
CREATE TABLE Student (
StudentID SMALLINT UNSIGNED AUTO_INCREMENT,
FirstName VARCHAR(64) NOT NULL,
LastName VARCHAR(64) NOT NULL,
Birthdate DATE,
PRIMARY KEY (StudentID)
);
-- Create Tutor Table
CREATE TABLE Tutor (
EmployeeID SMALLINT UNSIGNED AUTO_INCREMENT,
FirstName VARCHAR(64) NOT NULL,
LastName VARCHAR(64) NOT NULL,
DateStarted DATE,
PRIMARY KEY (EmployeeID)
);
-- Create Sessions Table to track each tutoring session
CREATE TABLE Session (
SessionNumber INT UNSIGNED AUTO_INCREMENT,
SessionStart DATETIME NOT NULL CHECK (MINUTE(SessionStart) = 0),
StudentID SMALLINT NOT NULL,
TutorID SMALLINT NOT NULL,
Duration_min SMALLINT CHECK (Duration <=60) ,
PRIMARY KEY (SessionNumber),
FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
FOREIGN KEY (TutorID) REFERENCES Tutor(EmployeeID),

-- must have for full marks from profession
  PRIMARY KEY (StudentID, TutorID, Session_date, SessionStart)
  UNIQUE KEY (SessionDawte, SessionStartHour, TutorID)
  UNIQUE KEY (StudentId, SessionDate, SessionStartHour)
);
