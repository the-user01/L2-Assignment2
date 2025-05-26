## Question And Answers

1. **What is PostgreSQL?**
   **Ans:** Postgres is a free open source database system that helps store, manage, and organize data using SQL query. It is also known for being powerful, reliable and easy to use.

2. **What is the purpose of a database schema in PostgreSQL?**
   **Ans:** A scheme in PostgreSQL is like a folder that helps to organize tables and other data. It keeps things neat and avoid name conflicts and also make it easier to manage the database.

3. **Explain the Primary Key and Foreign Key concepts in PostgreSQL.**
   **Ans:** 
   **Primary Key:** A Primary key is used to identify each row in a table. The value of primary key must be unique and not NULL and also the value must not duplicate. 

    For Example,
      <pre lang="markdown">```sql CREATE TABLE students (
    Student_id SERIAL PRIMARY KEY,
    name VARCHAR(50)
    ); ```</pre>
    Above code student_id is a primary key, this why there wont be any student data with same id.

    **Foreign Key:** Foreign Key is used to connect two tables. If the primary key is used in another table that will be a foreign key. 
    For Example,
    <pre lang="markdown">```sql CREATE TABLE marks (
    marks_id INT PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    grade_marks VARCHAR(50)
    );```</pre>
    Here the student_id works as a primary key. It joints the two table students and marks.

4. **What is the difference between the VARCHAR and CHAR data types?**
   **Ans:** The VARCHAR and CHAR are used to store text. Though they both store text they work in a different way. The VARCHAR(n) is used for text that can be up to n character long and it only uses as much space as needed.
    On the other hand, CHAR(n) always takes up exactly n characters even if the text is shorter. The extra space fills with blank space.

5. **Explain the purpose of the WHERE clause in a SELECT statement.**
   **Ans:** 
    The WHERE clause is used in a SELECT statement to filter data. It selects only the rows that match specific condition. It provides the conditional data that a user need.
    For Example,
    <pre lang="markdown"> SELECT * FROM students
    WHERE age > 18;</pre>
    This command shows all the students information whose age is more than 18.

