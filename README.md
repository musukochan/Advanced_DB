# Advanced_DB
lab work for advanced DB module
docker-compose up -d
docker compose down
Stop Current Codespace
git add .
git commit -m "Your commit message here"
git push


1.
INSERT INTO FactExamResults (STUDENT_ID, EXAM_ID, RESULT, FACTID)
SELECT
    er.STUDENT_ID,
    er.EXAM_ID,
    er.RESULT,
    NEXT VALUE FOR FACTID_SEQ
FROM
    ExamResults er;

2.
CREATE TABLE ExamDim (
    EXAM_ID INT PRIMARY KEY,
    EXAM_NAME VARCHAR(255),
    DEPARTMENT_NAME VARCHAR(255),
    COURSE_NAME VARCHAR(255),
    PROFESSOR_NAME VARCHAR(255)
);

3.
INSERT INTO ExamDim (EXAM_ID, EXAM_NAME, DEPARTMENT_NAME, COURSE_NAME, PROFESSOR_NAME)
VALUES
    (1, 'Exam 1', 'Department A', 'Course X', 'Professor 1'),
    (2, 'Exam 2', 'Department B', 'Course Y', 'Professor 2'),
    -- Add more exam records as needed
;

