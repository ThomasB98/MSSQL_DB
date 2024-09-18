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

EXEC insertSingleEmp 'charli', 98000, '2021-07-13';

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

ALTER TABLE employee.employee_payroll
ADD Gender CHAR(1)  
    CONSTRAINT CK_Gender CHECK (Gender IN ('M', 'F'));

UPDATE 
    employee.employee_payroll
SET 
    Gender ='M' 
WHERE 
    name = 'Bile' or name='charli';


SELECT SUM(salary) as TotalSalary,
    AVG(salary) as AverageSalary,
    MIN(salary) as MinSalary,
    MAX(salary) as MaxSalary,
    COUNT(Gender) as GenderCount
FROM
    employee.employee_payroll
WHERE
    Gender ='M'
GROUP BY 
    Gender;