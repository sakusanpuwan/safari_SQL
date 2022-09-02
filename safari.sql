CREATE TABLE enclosure(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    capacity INT,
    closedForMaintenance boolean
);

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    age INT,
    enclosure_id INT REFERENCES enclosure(id)
);

CREATE TABLE staff (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    employeeNumber INT
);

CREATE TABLE assignment(
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES staff(id),
    enclosure_id INT REFERENCES enclosure(id),
    day VARCHAR(255)
);

INSERT INTO enclosure (name,capacity,closedForMaintenance) VALUES ('big cat field',20,false);
INSERT INTO enclosure (name,capacity,closedForMaintenance) VALUES ('reptiles',60,true);
INSERT INTO enclosure (name,capacity,closedForMaintenance) VALUES ('penguins',10,false);
INSERT INTO enclosure (name,capacity,closedForMaintenance) VALUES ('sea animals',50,true);

INSERT INTO animals (name,type,age,enclosure_id) VALUES ('Tony','Tiger',59,1);
INSERT INTO animals (name,type,age,enclosure_id) VALUES ('Charlie','Crocodile',67,2);
INSERT INTO animals (name,type,age,enclosure_id) VALUES ('Patrick','Penguin',9,3);
INSERT INTO animals (name,type,age,enclosure_id) VALUES ('Sandra','Shark',59,4);

INSERT INTO staff (name,employeeNumber) VALUES ('Captain Rik',12345);
INSERT INTO staff (name,employeeNumber) VALUES ('Chief Steve',17456);
INSERT INTO staff (name,employeeNumber) VALUES ('Captain Julia',46547);
INSERT INTO staff (name,employeeNumber) VALUES ('Chief Susan',83654);

INSERT INTO assignment (employee_id,enclosure_id,day) VALUES (1,1,'Tuesday');
INSERT INTO assignment (employee_id,enclosure_id,day) VALUES (2,2,'Friday');
INSERT INTO assignment (employee_id,enclosure_id,day) VALUES (3,3,'Monday');
INSERT INTO assignment (employee_id,enclosure_id,day) VALUES (4,4,'Thursday');


-- MVP TASK 1
SELECT animals.name , enclosure.name
FROM animals
INNER JOIN enclosure
ON enclosure.id = animals.enclosure_id;

-- MVP TASK 2
SELECT staff.name, enclosure.name
FROM staff
INNER JOIN assignment
ON staff.id = assignment.employee_id
INNER JOIN enclosure
ON enclosure.id = assignment.enclosure_id;

-- EXTENSION 1
SELECT staff.name, enclosure.name
FROM staff
INNER JOIN assignment
ON staff.id = assignment.employee_id
INNER JOIN enclosure
ON enclosure.id = assignment.enclosure_id
WHERE closedformaintenance = true;

-- EXTENSION 2
SELECT enclosure.name
FROM animals
INNER JOIN enclosure
ON enclosure.id = animals.enclosure_id
ORDER BY animals.age DESC, animals.name DESC
LIMIT 1;

-- EXTENSION 3
SELECT COUNT(animals.type), assignment.employee_id
FROM animals
INNER JOIN enclosure
ON enclosure.id = animals.enclosure_id
INNER JOIN assignment 
ON assignment.enclosure_id = animals.enclosure_id
GROUP BY animals.type, assignment.employee_id

-- EXTENSION 4
SELECT COUNT(assignment.employee_id), enclosure.id
FROM animals
INNER JOIN enclosure
ON enclosure.id = animals.enclosure_id
INNER JOIN assignment 
ON assignment.enclosure_id = animals.enclosure_id
GROUP BY assignment.employee_id, enclosure.id