**Question 1:**
Retrieve all records from the science_classroom table.
Select * from science_classroom;

**Question 2:**
Find the names of all students who scored more than 60 marks in science.
select name from science_classroom where science_marks>60;

**Question 3:**
Retrieve all student records who scored between 35 and 60 marks (inclusive).
select * from science_classroom where science_marks>35 and  science_marks<60;

**Question 4:**
Find all students who scored either 35 marks or less, or 60 marks or more.
select * from science_classroom where  science_marks<=35 or science_marks>=60;









