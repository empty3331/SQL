select * from employees;

select * from departments;

select employee_id, first_name, last_name from employees;

--이름,전화번호,입사일,연봉
select first_name, phone_number, hire_date , salary from employees;

select first_name, 
        last_name, 
        salary, 
        phone_number, 
        email, 
        hire_date 
from employees;

SELECT employee_id as empNo,
       first_name "E-name",
       salary as "급여"
FROM employees;

--예제문제1
select first_name"이름",
       phone_number"전화번호",
       hire_date"입사일",
       salary"급여"
from employees;

--예제문제2
select employee_id"사원번호",
       first_name"이름",
       last_name"성",
       salary"급여",
       phone_number"전화번호",
       email"이메일",
       hire_date"입사일"
from employees;

--칼럼 합치기
select first_name || ' hire date is '|| hire_date as empInfo
from employees;

--산술연산자
select first_name, salary, salary*12, (salary+300)*12
from employees;

--예제문제3
select first_name||'-'||last_name as"성명",
       salary as "급여",
       salary*12 as "연봉",
       salary*12+5000 as "연봉2",
       phone_number as "전화번호"
from employees;

--비교연산자 where
select first_name
from employees
where department_id = 100;

--예제문제4
select first_name, salary
from employees
where first_name = 'Lex';

--예제문제5
select first_name, salary
from employees
where salary >= 15000;

--예제문제6
select first_name, hire_date
from employees
where hire_date >= '07/01/01';

--예제문제7
select first_name, salary
from employees
where salary >= 14000
and salary <= 17000;

--예제문제8
select first_name, hire_date
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

--between
select first_name, salary
from employees
where salary between 14000 and 17000;

--여러조건 검색
select first_name, last_name, salary
from employees
where first_name in ('Neena', 'Lex', 'John');


select first_name, last_name, salary
from employees
where first_name  ='John'
or first_name  = 'Lex'
or first_name ='Neena';

--예제문제9
select first_name, salary
from employees
where salary in (2100,3100,4100,5100);


--like 사용
select first_name, last_name, salary
from employees
where first_name like 'L___';

--예제문제10 >이름에 am이 포함된 사람
select first_name, salary
from employees
where first_name like '%am%';

--예제문제11 > 두번째 글자가 a인사람
select first_name, salary
from employees
where first_name like '_a%';

--예제문제12 > 네번째 글자가 a인사람
select first_name, salary
from employees
where first_name like '___a%';

--예제문제13 > 네글자 이름을 가지고 있고,끝에서 두번째 글자가 a인사람
select first_name, salary
from employees
where first_name like '__a_';

-- null
select first_name, salary, commission_pct, salary*commission_pct
from employees
where salary BETWEEN 13000 and 15000;

select first_name, salary,commission_pct
from employees
where commission_pct is null;

--예제문제14
select first_name, salary, commission_pct
from employees
where commission_pct is not null;

--예제문제15
select first_name, commission_pct, manager_id
from employees
where commission_pct is null
and manager_id is null;

--order by절
select first_name, salary
from employees
where salary >= 9000
order by salary desc, first_name desc;

--예제문제16번
select  department_id, salary,first_name
from employees
where salary >= 1000
order by department_id asc, salary desc;