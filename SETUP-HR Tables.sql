#Human resources Create Tables

DROP TABLE IF EXISTS dependents;
DROP TABLE IF EXISTS jobhist;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS countries;
DROP TABLE IF EXISTS regions;

CREATE TABLE regions (
	region_id INTEGER PRIMARY KEY,
	region_name CHARACTER VARYING (25)
);

CREATE TABLE countries (
	country_id CHARACTER (2) PRIMARY KEY,
	country_name CHARACTER VARYING (40),
	region_id INTEGER NOT NULL,
	Foreign Key (region_id) REFERENCES regions(region_id) ON DELETE CASCADE ON UPDATE RESTRICT
);


CREATE TABLE locations (
	location_id INTEGER PRIMARY KEY,
	street_address CHARACTER VARYING (40),
	postal_code CHARACTER VARYING (12),
	city CHARACTER VARYING (30) NOT NULL,
	state_province CHARACTER VARYING (25),
	country_id CHARACTER (2) NOT NULL,
	FOREIGN KEY (country_id) REFERENCES countries (country_id) 	ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE departments (
	department_id INTEGER PRIMARY KEY,
	department_name CHARACTER VARYING (30) NOT NULL,
	location_id INTEGER,
	FOREIGN KEY (location_id) REFERENCES locations (location_id) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE jobs (
	job_id INTEGER PRIMARY KEY,
	job_title CHARACTER VARYING (35) NOT NULL,
	min_salary NUMERIC (8, 2),
	max_salary NUMERIC (8, 2)
);

CREATE TABLE employees (
	employee_id INTEGER PRIMARY KEY,
	first_name CHARACTER VARYING (20),
	last_name CHARACTER VARYING (25) NOT NULL,
	email CHARACTER VARYING (100) NOT NULL,
	phone_number CHARACTER VARYING (20),
	hire_date DATE NOT NULL,
	job_id INTEGER NOT NULL,
	salary NUMERIC (8, 2) NOT NULL,
	manager_id INTEGER,
	department_id INTEGER,
	FOREIGN KEY (job_id) REFERENCES jobs (job_id) 	ON DELETE CASCADE
    ON UPDATE RESTRICT,
	FOREIGN KEY (department_id) REFERENCES departments (department_id) 	ON DELETE CASCADE
    ON UPDATE RESTRICT,
	FOREIGN KEY (manager_id) REFERENCES employees (employee_id) ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE jobhist (
    employee_id           INTEGER,
    startdate       DATE NOT NULL,
    enddate         DATE,
    job_id          INTEGER ,
    salary          NUMERIC(8,2),
    department_id  INTEGER,
    changedesc      CHARACTER VARYING (80),

    CONSTRAINT jobhist_ref_dept_fk FOREIGN KEY (department_id)
        REFERENCES departments (department_id) ON DELETE set null,
    CONSTRAINT jobhist_jobs_fk FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE set null,
    CONSTRAINT jobhist_date_chk CHECK (startdate <= enddate),
    CONSTRAINT PRIMARY KEY (employee_id, startdate),
    CONSTRAINT jobhist_ref_emp_fk FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id) ON DELETE CASCADE

);

  


CREATE TABLE dependents (
	dependent_id INTEGER PRIMARY KEY,
	first_name CHARACTER VARYING (50) NOT NULL,
	last_name CHARACTER VARYING (50) NOT NULL,
	relationship CHARACTER VARYING (25) NOT NULL,
	employee_id INTEGER NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE ON UPDATE RESTRICT
);