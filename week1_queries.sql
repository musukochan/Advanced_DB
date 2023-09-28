/* query 1*/
SELECT 
CONCAT(e.first_name , ' ',e.last_name) AS EmployeeName,
CONCAT(d.first_name , ' ',d.last_name) AS DependentName
FROM employees e
JOIN dependents d ON e.employee_id = d.employee_id;

/* query 2*/
SELECT 
CONCAT(e.first_name , ' ',e.last_name) AS EmployeeName,
CONCAT(d.first_name , ' ',d.last_name) AS DependentName,
e.department_id AS Department
FROM employees e
JOIN dependents d ON e.employee_id = d.employee_id
ORDER BY e.department_id;
