CREATE TABLE employees (
    id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    middle_name VARCHAR(20),
    age INT NOT NULL,
    current_status VARCHAR(20) NOT NULL DEFAULT "employed",
    PRIMARY KEY(id)
);

INSERT INTO employees(first_name, last_name, middle_name, age, current_status) VALUES
("Imelda", "MEJIA", NULL, 26, "unemployed");