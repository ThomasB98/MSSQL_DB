--Ability to create a payroll service database

CREATE DATABASE payroll_service;

SELECT name 
FROM sys.databases;

CREATE TABLE employee.employee_payroll(
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NUll,
    salary Int NOT NULL DEFAULT 10000,
    start_date DATE NOT NULL
);

