/*단일행 함수*/

--문자열 함수

--가상의 테이블
SELECT initcap('aaaaaaaaa')
FROM dual; 

--initcap():첫글자만 대문자로 만듦
SELECT email ,
       initcap(email)
FROM employees;

SELECT email ,
       initcap('aaaaaaaaa')
FROM employees;

SELECT email, initcap(email), department_id
FROM employees
WHERE department_id = 100;

--lower(컬럼명) / upper(컬럼명)
SELECT lower('aAaAaA'), upper('aAaAaA')
FROM dual;

SELECT first_name, lower(first_name), upper(first_name)
FROM employees
WHERE department_id = 100;

--substr(컬럼명,시작위치,글자수)
SELECT substr('abcdefg',-3,3)
FROM dual;

SELECT first_name,
       substr(first_name,1,3),
       substr(first_name,-3,2)
FROM employees;

--lpad(컬럼명,자리수,'채울문자')
SELECT first_name,
       lpad(first_name,10,'*'),
       rpad(first_name,10,'*%')
FROM employees;

--replace(컬럼명,문자1,문자2)
select first_name, 
       replace(first_name, 'a', '*') 
from employees
where department_id =100;

select first_name, 
       replace(first_name, 'a', '*'), 
       replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id =100;



SELECT ltrim('               aaaaaaaaaaa              ') || '----',
       rtrim('               aaaaaaaaaaa              ') || '----',
       trim('               aaaaaaaaaaa              ')|| '----'
FROM dual;

--
select round(123.346, 2) "r2",
       round(123.456, 0) "r0",
       round(123.456, -1) "r-1"
from dual;

select TRUNC(123.346, 2) as"r2",
 TRUNC(123.456, 0) "r0",
 TRUNC(123.456, -1) "r-1"
from dual;

--
select sysdate
from dual;

select sysdate
from employees;

select sysdate,
      hire_date,
      months_between(sysdate, '1995-3-12') 
from employees
where department_id = 110;

--
select first_name, to_char(salary*12, '$999,999.99') "SAL",
       to_char(9876, '99999'),
       to_char(9876, '099999'),
       to_char(9876, '$9999')
from employees
where department_id =110;

--
select sysdate, 
       to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from dual;


select commission_pct, nvl(commission_pct, 0)
from employees;

select commission_pct, nvl2(commission_pct, 100, 0)
from employees;


