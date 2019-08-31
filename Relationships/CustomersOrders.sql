CREATE TABLE customers 
    (
        id INT AUTO_INCREMENT PRIMARY KEY,
        first_name VARCHAR(40),
        last_name VARCHAR(40),
        email VARCHAR(40)
    );

CREATE TABLE orders
    (
        id INT AUTO_INCREMENT PRIMARY KEY,
        order_date DATE,
        amount DECIMAL (8,2),
        customer_id INT,
        FOREIGN KEY(customer_id) REFERENCES customers(id)
    );
    
INSERT INTO customers (first_name, last_name, email)
    VALUES 
        ("Boy", "George", "george@gmail.com"),
        ("George", "Michael", "gm@gmail.com"),
        ("David", "Bowie", "david@gmail.com"),
        ("Blue", "Steele", "blue@gmail.com"),
        ("Bette", "Davis", "bette@aol.com");

INSERT INTO orders (order_date, amount, customer_id)
    VALUES 
        ("2016/02/10", 99.99, 1),
        ("2017/11/11", 35.50, 1),
        ("2014/12/12", 800.67, 2),
        ("2015/01/03", 12.50, 2),
        ("1999/04/11", 450.25, 5);
        
INSERT INTO orders (order_date, amount, customer_id)
    VALUES 
        ("2016/02/10", 56.43, 45),
        (CURDATE(), 59.20, 109);
      
/*This won't make it into the table because the customer_id of 98 doesn't exist
INSERT INTO orders (order_date, amount, customer_id)
    VALUES 
        ("2016/06/06", 933.67, 98);
*/

SELECT * FROM orders WHERE customer_id = (SELECT id from customers WHERE last_name="George");

/* First time working with Joins

SELECT * FROM customers, orders;


*/

/* Implicit Inner Join

SELECT * FROM customers, orders WHERE  customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount FROM customers, orders WHERE  customers.id = orders.customer_id;

*/

/* Explicit Inner Join

Correct way of doing things. 
SELECT something FROM a table and JOIN another table ON a condition. 

SELECT * FROM customers
    JOIN orders
        ON customers.id = orders.customer_id;
        
SELECT first_name, last_name, order_date, amount FROM customers
    JOIN orders
        ON customers.id = orders.customer_id;

*/

/* Random JOIN - no reason for these  

SELECT * FROM customers
    JOIN orders
        ON customers.id = orders.id;

SELECT first_name, last_name, order_date, amount FROM customers
    JOIN orders
        ON customers.id = orders.customer_id
            ORDER BY amount;

SELECT first_name, last_name, order_date, amount 
FROM customers
JOIN orders
        ON customers.id = orders.customer_id
GROUP BY orders.customer_id;

SELECT 
    first_name, 
    last_name, 
    order_date, 
    SUM(amount) AS total_spent 
FROM customers
JOIN orders
        ON customers.id = orders.customer_id
GROUP BY orders.customer_id;

SELECT 
    first_name, 
    last_name, 
    order_date, 
    SUM(amount) AS total_spent 
FROM customers
JOIN orders
        ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

*/


/* Left JOIN - will taking everything from left (first) table and will try to implement what it overlaps on the second table

SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;
    
SELECT 
    first_name, 
    last_name,  
    SUM(amount) 
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id;

SELECT 
    first_name, 
    last_name,  
    IFNULL(SUM(amount),0) AS total_spent 
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent DESC;

*/

/* RIGHT JOIN

SELECT * FROM customers 
RIGHT JOIN orders 
    ON customers.id = orders.customer_id;
    
SELECT * FROM customers 
RIGHT JOIN orders 
    ON customers.id = orders.customer_id
ORDER BY amount;

SELECT * FROM customers 
RIGHT JOIN orders 
    ON customers.id = orders.customer_id
ORDER BY amount DESC;

SELECT 
    IFNULL(first_name,"MISSING") AS first,
    IFNULL(last_name,"USER") AS last,
    order_date,
    amount, 
    SUM(amount) AS "Total Amount"
FROM customers 
RIGHT JOIN orders 
    ON customers.id = orders.customer_id
GROUP BY customer_id;

SELECT 
    IFNULL(first_name,"MISSING") AS first,
    IFNULL(last_name,"USER") AS last,
    order_date,
    amount, 
    SUM(amount) AS "Total Amount"
FROM customers 
RIGHT JOIN orders 
    ON customers.id = orders.customer_id
GROUP BY first_name, last_name;


*/

/* How to delete a customer and the orders associated with them 
If we just try to delete a customer we won't be able to because of the foreign key constraint.
It's called ON DELETE CASCADE

You need to add 
ON DELETE CASCADE 
underneath the FOREIGN KEY 

CREATE TABLE orders
    (
        id INT AUTO_INCREMENT PRIMARY KEY,
        order_date DATE,
        amount DECIMAL (8,2),
        customer_id INT,
        FOREIGN KEY(customer_id) 
            REFERENCES customers(id)
            ON DELETE CASCADE
    );


*/

/* EXERCISES

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    first_name VARCHAR(30)
    );
    
CREATE TABLE papers (
    title VARCHAR(60),
    grade DECIMAL (5,2), 
    student_id INT,
    FOREIGN KEY(student_id)
        REFERENCES students(id)
        ON DELETE CASCADE
    );

--seeing their inner JOIN
SELECT * FROM students 
JOIN papers 
    WHERE students.id = papers.student_id;
    
--seeing their inner JOIN, printing out specific items, and ordering them 
SELECT 
    first_name AS First,
    title AS Title,
    grade AS Grade
FROM students 
JOIN papers 
    WHERE students.id = papers.student_id
ORDER BY Grade DESC;

--seeing NULL for Student who don't have papers, printing out specific items, and ordering them
SELECT 
    first_name AS First,
    title AS Title,
    grade AS Grade
FROM students 
LEFT JOIN papers 
    ON students.id = papers.student_id;
    
--seeing NULL for Student who don't have papers, printing out specific items, ordering them, and changing their NULL values
SELECT 
    first_name AS First,
    IFNULL(title, "MISSING") AS Title,
    IFNULL(grade,0) AS Grade
FROM students 
LEFT JOIN papers 
    ON students.id = papers.student_id;

--seeing NULL for Student who don't have papers, printing out specific items, changing their NULL values, and Averaging grades
SELECT 
    first_name,
    IFNULL(AVG(grade),0)
FROM students 
LEFT JOIN papers 
    ON students.id = papers.student_id
GROUP BY students.id;

--seeing NULL for Student who don't have papers, printing out specific items, changing their NULL values, Averaging grades, show Passing or Failing, and Order Them 
SELECT 
    first_name,
    IFNULL(AVG(grade),0) AS Average,
    CASE 
        WHEN AVG(grade) >= 75 THEN "PASSING"
        ELSE "FAILING"
    END AS passing_status
FROM students 
LEFT JOIN papers 
    ON students.id = papers.student_id
GROUP BY students.id
ORDER BY Average DESC;
    

*/