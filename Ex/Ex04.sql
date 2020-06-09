SELECT *
FROM departments; --27

SELECT *
FROM employees; --107
-------------------------------------------------

SELECT em.employee_id,
       em.first_name,
       em.department_id,
       de.department_id,
       de.department_name
FROM employees em, departments de
WHERE em.department_id = de.department_id;


SELECT count(*)
FROM employees, departments;

--예제문제1
SELECT em.first_name,
       jo.job_title
FROM employees em, jobs jo
WHERE em.job_id = jo.job_id;

--예제문제2
SELECT em.first_name,
       jo.job_title,
       de.department_name,
       em.department_id, --확인용
       de.department_id, --확인용
       em.job_id, --확인용
       jo.job_id --확인용
FROM employees em, jobs jo, departments de
WHERE em.job_id = jo.job_id
AND em.department_id = de.department_id;

--left outer join
select e.department_id, e.first_name, d.department_name
  from employees e left outer join departments d
    on e.department_id = d.department_id ; 
    
select e.department_id, e.first_name, d.department_name
  from employees e, departments d
 where e.department_id = d.department_id(+) ;

--right outer join
select e.department_id, e.first_name, d.department_name
  from employees e right outer join departments d
    on e.department_id = d.department_id ; 
    
select e.department_id, e.first_name, d.department_name
  from employees e, departments d
 where e.department_id(+) = d.department_id ; 
 
 --full outer join
select e.department_id, e.first_name, d.department_name
  from employees e full outer join departments d
    on e.department_id = d.department_id ; 