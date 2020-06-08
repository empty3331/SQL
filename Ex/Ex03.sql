select salary, 
       first_Name
from employees;

--평균값 구하기,데이터 총 건수 구하기
select round(avg(salary),0),
       count(*)--row의 갯수(null포함)
from employees;

select count(manager_id)--컬럼 데이터의 갯수(null제외)
from employees;

select count(*), count(commission_pct)
from employees;


select count(*)
from employees
where salary > 16000;

--데이터의 합계
select count(*), sum(salary)
from employees;


--
select count(*), sum(salary), avg(salary)
from employees;

select count(*), sum(salary), avg(nvl(salary,0))
from employees;

--최댓값,최소값
select count(*), max(salary), min(salary)
from employees;

--group by
select department_id, avg(salary)
from employees
group by department_id
order by department_id asc;

select department_id, job_id, count(*), sum(salary)
from employees
group by department_id, job_id;


--예제문제1
select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary) > 20000
and department_id = 100;

--CASE ~ END 문
SELECT employee_id, 
       salary,
	 CASE WHEN job_id = 'AC_ACCOUNT' THEN salary + salary * 0.1
             WHEN job_id = 'SA_REP'     THEN salary + salary * 0.2
		   WHEN job_id = 'ST_CLERK'   THEN salary + salary * 0.3
            ELSE salary
	 END realSalary
FROM employees;

--DECODE 문
SELECT employee_id, 
       salary,
	 DECODE( job_id, 'AC_ACCOUNT', salary + salary * 0.1,
                        'SA_REP',     salary + salary * 0.2,
		              'ST_CLERK',   salary + salary * 0.3,
               salary ) realSalary
FROM employees;

--예제문제2
SELECT first_name,
       department_id,
       CASE WHEN department_id BETWEEN 10 and 50 THEN 'A-TEAM'
            WHEN department_id BETWEEN 60 and 100 THEN 'B-TEAM'	
            WHEN department_id BETWEEN 110 and 150 THEN 'C-TEAM'	
            ELSE '팀없음'
       END team
FROM employees
ORDER BY team ASC;




