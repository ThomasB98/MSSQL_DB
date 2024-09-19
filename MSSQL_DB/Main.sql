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

ALTER TABLE employee.employee_payroll
ADD 
    phone_number VARCHAR(50),
    address VARCHAR(255),
    department VARCHAR(200) NOT NULL DEFAULT 'Unknown',  -- Apply NOT NULL here
    CONSTRAINT CK_PhoneNumber CHECK (
        phone_number LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
    );

ALTER TABLE employee.employee_payroll
ADD CONSTRAINT DF_Address DEFAULT 'Unknown' FOR address;

ALTER TABLE
    employee.employee_payroll
ADD 
    basic_pay FLOAT,
    deductions FLOAT,
    taxable_pay FLOAT,
    income_tax FLOAT,
    net_pay float;

ALTER TABLE employee.employee_payroll
DROP CONSTRAINT CK_PhoneNumber;

SELECT * FROM employee.employee_payroll;

ALTER TABLE employee.employee_payroll
DROP CONSTRAINT DF__employee___salar__37A5467C;

Alter TABLE employee.employee_payroll
DROP COLUMN salary;

ALTER TABLE employee.employee_payroll
DROP 
    CONSTRAINT DF_Address,
    CONSTRAINT DF_basic_pay,
    CONSTRAINT DF_deductions,
    CONSTRAINT DF_taxable_pay,
    CONSTRAINT DF_income_tax,
    CONSTRAINT DF_net_pay;

DELETE FROM employee.employee_payroll;

INSERT INTO employee.employee_payroll
(name,Gender,start_date,phone_number,address,department,basic_pay,deductions,taxable_pay,income_tax)
VALUES
    ('Terisa','F','2018-01-03','8669325065','pune','Sales',3000000.00,1000000.00,200000.00,500000.00);

SELECT * FROM employee.employee_payroll;