DROP TABLE IF EXISTS FactExamResults;
DROP TABLE IF EXISTS TimeDim;
DROP TABLE IF EXISTS StudentDim;
DROP TABLE IF EXISTS ExamDim;

/* Create the Time dimension table*/
CREATE TABLE TimeDim (
    TimeID INT PRIMARY KEY,
    ExamDate DATE,
    Year INT,
    Quarter INT,
    Month INT,
    Day INT
);

/* Populate the Time dimension with data*/
INSERT INTO TimeDim (TimeID, ExamDate, Year, Quarter, Month, Day)
SELECT
    DISTINCT ROW_NUMBER() OVER (ORDER BY ExamDate) AS TimeID,
    ExamDate,
    YEAR(ExamDate) AS Year,
    QUARTER(ExamDate) AS Quarter,
    MONTH(ExamDate) AS Month,
    DAY(ExamDate) AS Day
FROM ExamResults;


/* Create Student Dim Table*/
CREATE TABLE StudentDim(
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(255) ,
    LastName VARCHAR(255) 
);


/* Populate the StudentDim table*/
insert into StudentDim (StudentID) SELECT StudentID from Students;
Update StudentDim  set Firstname=
                           (Select firstname from Students
where StudentDim.StudentID=Students.StudentID);
Update StudentDim  set Lastname=
                           (Select lastname from Students
where StudentDim.StudentID=Students.StudentID);



/* Create the FactExamResults fact table*/
CREATE TABLE FactExamResults (
                                 FactID INT PRIMARY KEY AUTO_INCREMENT,
                                 TimeID INT,
                                 StudentID INT,
                                 ExamID INT,
                                 Score DECIMAL(5, 2),
                                 Grade CHAR(1),
                                 FOREIGN KEY (TimeID) REFERENCES TimeDim (TimeID),
                                 FOREIGN KEY (StudentID) REFERENCES StudentDim(StudentID)
);






