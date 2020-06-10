--SubQuery(단일행)
SELECT first_name,
       salary
FROM employees
where salary>(SELECT salary
              FROM employees
              WHERE first_name='Den');

--예제문제1
SELECT first_name,
       salary,
       employee_id
FROM employees
where salary = (SELECT min(salary)
                FROM employees);
                
--예제문제2
SELECT first_name,
       salary
FROM employees
where salary < (SELECT avg(salary)
                FROM employees);

--SubQuery(다중행)                
select first_name, salary
from employees
where salary in (select salary
                  from employees
                  where department_id = 110); 
                  
--예제문제3
/*SELECT
    *
FROM employees
WHERE department_id = 100
AND 12008*/


SELECT employee_id,
       first_name,
       salary,
       department_id
FROM employees
where (department_id,salary) in (SELECT department_id,max(salary)
                                 FROM employees
                                 GROUP BY department_id);

SELECT department_id,max(salary)
FROM employees
GROUP BY department_id;

-- (100 12008)
-- 30 11000
--90 24000

--any(or)--8300보다 큰
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE salary >ANY(SELECT salary
                  FROM employees
                  WHERE department_id =110);
                  
--all(and)--12008보다 큰
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE salary >ALL(SELECT salary
                  FROM employees
                  WHERE department_id =110);
 
 --테이블   
select e.department_id, e.employee_id, e.first_name, e.salary
from employees e, (SELECT department_id, max(salary)salary
                   FROM employees
                   GROUP BY department_id)s
WHERE e.department_id = s.department_id
and e.salary = s.salary;

--rownum--

--1단계:정렬에서 문제발생
SELECT ROWNUM,
       employee_id,
       first_name,
       salary
FROM employees
ORDER BY salary DESC;

--2단계:정렬부터해보기
SELECT ROWNUM,
       e.employee_id,
       e.first_name,
       e.salary
FROM (SELECT employee_id,
             first_name,
             salary
             FROM employees
             ORDER BY salary DESC)e;
             
--3단계 : where절 때문에 안됨(rownum 2 이상일때)
SELECT ROWNUM,
       e.employee_id,
       e.first_name,
       e.salary
FROM (SELECT employee_id,
             first_name,
             salary
             FROM employees
             ORDER BY salary DESC)e
WHERE ROWNUM <=5
AND ROWNUM >= 2;

--
SELECT w.rn,
       w.employee_id,
       w.first_name,
       w.salary
FROM (SELECT ROWNUM rn,
       e.employee_id,
       e.first_name,
       e.salary
       FROM (SELECT employee_id,
             first_name,
             salary
             FROM employees
             ORDER BY salary DESC)e)w
WHERE rn>= 2
and rn<= 5;