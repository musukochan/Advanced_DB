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

/* query 3*/
SELECT
    department_id,
    COUNT(*) AS EmployeeCount
FROM
    employees
GROUP BY
    department_id;


/* query 4*/
SELECT
    d.department_name AS Department,
    COUNT(e.employee_id) AS EmployeeCount
FROM
    departments AS d
LEFT JOIN
    employees AS e ON d.department_id = e.department_id
GROUP BY
    d.department_name;

 /* query 5*/   
SELECT city, count(employee_id)
FROM locations
JOIN 
(SELECT employee_id, location_id FROM employees JOIN departments USING (department_id)) as de
USING (location_id)
GROUP BY (location_id)
ORDER BY city;

