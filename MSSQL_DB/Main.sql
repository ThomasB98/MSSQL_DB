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

CREATE PROCEDURE insertSingleEmp
    @empName VARCHAR(50),
    @empSalary INT,
    @empStartDate DATE
AS
BEGIN 
    INSERT INTO 
         employee.employee_payroll(name,salary,start_date)
    VALUES
        (@empName,@empSalary,@empStartDate)
END;

EXEC insertSingleEmp 'John Doe', 12000, '2024-09-18';

SELECT * FROM employee.employee_payroll;

CREATE PROCEDURE getEmpSalaryByName
    @empName VARCHAR(50)
AS
BEGIN
    SELECT 
        salary
    FROM 
        employee.employee_payroll
    WHERE
        name=@empName;
END;

EXEC getEmpSalaryByName 'John Doe';

CREATE PROCEDURE empBtwParticularDate
    @startDate Date 
AS
BEGIN
    SELECT
        * 
    FROM employee.employee_payroll
    WHERE start_date BETWEEN @startDate
    AND CAST(GETDATE() AS DATE);
END;


EXEC empBtwParticularDate '2024-01-01';