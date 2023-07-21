SELECT * FROM hr;

ALTER TABLE hr
CHANGE ï»¿id id varchar(20) NULL;

DESCRIBE hr;

-- to make updates but after done updating set to 1 
SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE 
    WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

UPDATE hr
SET hire_date = CASE 
    WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

UPDATE hr
SET termdate = DATE(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate !='';

UPDATE hr
SET termdate = CASE 
    WHEN termdate LIKE '%/%' THEN date_format(str_to_date(termdate, '%Y/%m/%d'), '%Y-%m-%d')
    WHEN termdate LIKE '%-%' THEN date_format(str_to_date(termdate, '%Y-%m-%d'), '%Y-%m-%d')
    ELSE NULL
END;


ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR,birthdate,CURDATE());

SELECT birthdate,age FROM hr;

SELECT 
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM hr;

SELECT count(*) FROM hr WHERE age <=18
