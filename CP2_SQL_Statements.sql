
PRAGMA FOREIGN_KEYS = OFF;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Assignment;
DROP TABLE IF EXISTS Comment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Email;
DROP TABLE IF EXISTS StudentAssignment;
DROP TABLE IF EXISTS StudentCourse;
DROP TABLE IF EXISTS Submission;
PRAGMA FOREIGN_KEYS = ON;

CREATE TABLE IF NOT EXISTS Account(

    id INTEGER PRIMARY KEY,
    acc_type TEXT,
    email TEXT,
    password TEXT

);

CREATE TABLE IF NOT EXISTS Course(

    professor_id INTEGER,
    name TEXT,
    description TEXT,
    start_date TEXT DEFAULT (DATETIME('now', 'start of month')),
    end_date TEXT DEFAULT (DATETIME('now', '+4 month')),
    id PRIMARY KEY,

    FOREIGN KEY (professor_id) REFERENCES Account(id)
);

CREATE TABLE IF NOT EXISTS StudentCourse(

    id INTEGER,
    student_id INTEGER,
    course_id INTEGER,
    enroll_date TEXT DEFAULT (DATE('now')),

    FOREIGN KEY (student_id) REFERENCES Account(id),
    FOREIGN KEY (course_id) REFERENCES Course(id)
);


CREATE TABLE IF NOT EXISTS Assignment(
    id INTEGER PRIMARY KEY,
    course_id INTEGER,
    title TEXT,
    description TEXT,
    points INTEGER DEFAULT 0,
    available_date TEXT DEFAULT (DATE('now')),
    due_date TEXT DEFAULT (DATE('now', '+7 days')),

    FOREIGN KEY (course_id) REFERENCES Course(id)

);

CREATE TABLE IF NOT EXISTS StudentAssignment(
    student_id INTEGER,
    assignment_id INTEGER,
    grade INTEGER DEFAULT 0,
    grade_time TEXT DEFAULT (DATE('now')),
    id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 1,

    FOREIGN KEY (student_id) REFERENCES Account(id),
    FOREIGN KEY (assignment_id) REFERENCES Assignment(id)
);

CREATE TABLE IF NOT EXISTS Submission(

    id INTEGER DEFAULT 0,
    studentAssignment_id INTEGER,
    content TEXT,
    create_time TEXT DEFAULT (DATETIME('now')),

    FOREIGN KEY (studentAssignment_id) REFERENCES StudentAssignment(id)
);

CREATE TABLE IF NOT EXISTS Comment(
    id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 1,
    account_id INTEGER,
    studentAssignment_id INTEGER,
    content TEXT,
    create_time TEXT DEFAULT (DATETIME('now')),

    FOREIGN KEY (account_id) REFERENCES Account(id),
    FOREIGN KEY (studentAssignment_id) REFERENCES StudentAssignment(id)

);

CREATE TABLE IF NOT EXISTS Email(

    id INTEGER PRIMARY KEY DEFAULT 1,
    comment_id INTEGER,
    title TEXT,
    body TEXT,
    recipient TEXT,
    send_status INTEGER DEFAULT 0,
    last_sent_time TEXT DEFAULT (DATETIME('now')),

    FOREIGN KEY (comment_id) REFERENCES Comment(id)
);



INSERT INTO Account VALUES (1234,'professor', 'teacher1@fiu.edu', 1234);
INSERT INTO Account VALUES (3214,'student', 'student1@fiu.edu', 3214);
INSERT INTO Account VALUES (4321,'student', 'student2@fiu.edu', 4321);
INSERT INTO Account VALUES (2314,'student', 'student3@fiu.edu', 2314);

--INSERT INTO Course(professor_id, 'name', description, id)
    --VALUES ((SELECT id FROM Account WHERE id=1234), 'Naphtali Rishe', 'DBMS', 789);

INSERT INTO Course(professor_id, 'name', description, id)
    VALUES (1234, 'Naphtali Rishe', 'DBMS', 789);

INSERT INTO Course(professor_id, 'name', description, id)
    VALUES (1234, 'Naphtali Rishe', 'ADV DBMS', 6789);

INSERT INTO StudentCourse(id,student_id, course_id)
    VALUES  (1,3214, 789);

INSERT INTO StudentCourse(id,student_id, course_id)
    VALUES  (2,4321,789);

INSERT INTO StudentCourse(id,student_id, course_id)
    VALUES  (3,2314,789);



INSERT INTO  Assignment(id, course_id, title, description)
    VALUES (1, 789, 'Homework1', 'Intro to DBMS');

INSERT INTO  Assignment(id, course_id, title, description)
    VALUES (2, 789, 'Homework2', 'DBMS SQL');

INSERT INTO  Assignment(id, course_id, title, description)
    VALUES (3, 6789, 'Homework1', 'Advance SQL');



INSERT INTO StudentAssignment(student_id, assignment_id)
    VALUES (3214, 1);

INSERT INTO Submission(id, studentAssignment_id,content)
    VALUES (1, 1, 'homework1.pdf');

INSERT INTO Comment(account_id,studentAssignment_id,content)
    VALUES (3214, 1, 'Here is homework 1');

INSERT INTO Submission(id, studentAssignment_id,content)
    VALUES (2, 1, 'homework1_revise.pdf');

INSERT INTO Comment(account_id,studentAssignment_id,content)
    VALUES (3214, 1, 'I did a mistake on homework 1 please look at this revise 1');

INSERT INTO StudentAssignment(student_id, assignment_id)
    VALUES (3214, 2);

INSERT INTO Submission(id, studentAssignment_id,content)
    VALUES (1, 2, 'homework2.pdf');

INSERT INTO Comment(account_id,studentAssignment_id,content)
    VALUES (3214, 2, 'Here is homework 2');

INSERT INTO Submission(id, studentAssignment_id,content)
    VALUES (2, 2, 'homework2_revise.pdf');

INSERT INTO Comment(account_id,studentAssignment_id,content)
    VALUES (3214, 2, 'I did a mistake on homework 2 please look at this revise 1');

--------------------------------------------------------------------------------------
INSERT INTO StudentAssignment(student_id, assignment_id)
    VALUES (4321, 1);

INSERT INTO Submission(id, studentAssignment_id,content)
    VALUES (1, 1, 'homework1.pdf');

INSERT INTO Comment(account_id,studentAssignment_id,content)
    VALUES (4321, 1, 'Here is homework 1');

INSERT INTO Submission(id, studentAssignment_id,content)
    VALUES (2, 1, 'homework1_revise.pdf');

INSERT INTO Comment(account_id,studentAssignment_id,content)
    VALUES (4321, 1, 'I did a mistake on homework 1 please look at this revise 1');

INSERT INTO StudentAssignment(student_id, assignment_id)
    VALUES (4321, 2);

INSERT INTO Submission(id, studentAssignment_id,content)
    VALUES (1, 2, 'homework2.pdf');

INSERT INTO Comment(account_id,studentAssignment_id,content)
    VALUES (4321, 2, 'Here is homework 2');

INSERT INTO Submission(id, studentAssignment_id,content)
    VALUES (2, 2, 'homework2_revise.pdf');

INSERT INTO Comment(account_id,studentAssignment_id,content)
    VALUES (4321, 2, 'I did a mistake on homework 2 please look at this revise 1');
--INSERT INTO StudentAssignment(student_id, assignment_id)
    --VALUES (4321, 1);

--INSERT INTO Comment(account_id,studentAssignment_id,content)
    --VALUES (4321, 1, 'Here is homework 1');

--INSERT INTO StudentAssignment(student_id, assignment_id)
   --VALUES (4321, 1);

--INSERT INTO Comment(account_id,studentAssignment_id,content)
    --VALUES (4321, 1, 'I did a mistake on homework 1 please look at this revise 1');

SELECT * FROM Assignment;
SELECT * FROM Assignment WHERE course_id = 789;
SELECT * FROM Assignment WHERE course_id = (SELECT id FROM Course WHERE professor_id=1234 and description='DBMS');


SELECT * FROM StudentAssignment;
SELECT * FROM StudentAssignment WHERE assignment_id = 1 and student_id=3214;
SELECT * FROM StudentAssignment WHERE assignment_id = (SELECT id FROM Assignment WHERE title = 'Homework1')
    and student_id=3214;
SELECT * FROM StudentAssignment WHERE assignment_id = (SELECT id FROM Assignment WHERE id = 1) and student_id=3214;
SELECT * FROM StudentAssignment
    WHERE assignment_id = (SELECT id FROM Assignment
        WHERE course_id = (SELECT id FROM Course
            WHERE professor_id=1234 and description='DBMS') and title='Homework1') and student_id=3214;;

SELECT * FROM Submission;
SELECT * FROM Submission WHERE studentAssignment_id = 1;
SELECT * FROM Submission WHERE studentAssignment_id = (SELECT id FROM Assignment WHERE title='Homework1');

SELECT * FROM Comment;
SELECT * FROM Comment WHERE account_id=3214 and studentAssignment_id=1;
SELECT * FROM Comment WHERE account_id=3214 and studentAssignment_id=(SELECT id FROM Assignment WHERE title='Homework1');

UPDATE StudentAssignment
    SET grade=90, grade_time=DATE('now')
WHERE assignment_id=1 and student_id=3214;

INSERT INTO Email(comment_id, title, body, recipient,send_status)
    VALUES (2,'Homework 1 grade', 'good job on homework 1', 'student1@fiu.edu', 1);

SELECT * FROM Email;