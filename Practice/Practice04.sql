/*문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.(56건)*/
SELECT count(salary)
FROM employees
WHERE salary < (SELECT avg(salary)
                     FROM employees);
                     

/*문제2. 
평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요 
(51건)*/
SELECT e.employee_id "직원번호",
       e.first_name"이름",
       e.salary"급여",
       am.a "평균급여",
       am.m "최대급여"
FROM employees e,(SELECT 
                         round(avg(salary),0)a,
                         max(salary)m
                 FROM employees )am
WHERE e.salary BETWEEN a and m
ORDER BY e.salary ASC;
                 
                 
/*문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요
(1건)*/
SELECT de.location_id,
       lo.street_address,
       lo.postal_code,
       lo.city,
       lo.state_province,
       lo.country_id
FROM  (SELECT department_id,
              first_name,
              last_name
              FROM employees
              WHERE first_name ='Steven'
              AND last_name = 'King')em,departments de, locations lo
WHERE em.department_id = de.department_id
AND lo.location_id = de.location_id;


/*문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요  -ANY연산자 사용(74건)*/
SELECT employee_id,
       first_name,
       salary
FROM employees 
WHERE salary <ANY (SELECT salary
                FROM employees
                WHERE job_id = 'ST_MAN')
ORDER BY salary DESC;


/*문제5. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요(11건)*/

--조건절비교
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.department_id
FROM employees e
WHERE (e.salary,e.department_id) in (SELECT max(salary)ms,
                                            department_id md
                                            FROM employees
                                            GROUP BY department_id)
ORDER BY e.salary DESC;


--테이블조인
SELECT e.employee_id,
       e.first_name,
       e.salary,
       e.department_id
FROM employees e,(SELECT department_id md,
                  max(salary)ms
                 FROM employees
                 GROUP BY department_id)max
WHERE e.salary = max.ms
AND e.department_id = max.md
ORDER BY e.salary DESC;
                                 

/*문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 (19건)*/

SELECT jo.job_title,
       jojo.salary
FROM jobs jo,(SELECT job_id,
                     sum(salary)salary
              FROM employees 
              GROUP BY job_id) jojo
WHERE jo.job_id = jojo.job_id
ORDER BY jojo.salary DESC;


/*문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
(38건)*/
SELECT e.employee_id,
       e.first_name,
       e.salary
FROM employees e,(SELECT  avg(salary) asa,
                          department_id 
                FROM employees
                GROUP BY department_id)ae
WHERE e.department_id = ae.department_id
AND e.salary > ae.asa;


/*문제8
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요*/

SELECT real.rn,
       real.employee_id,
       real.first_name,
       real.salary,
       real.hire_date
FROM (SELECT ROWNUM rn,
             em.employee_id,
             em.first_name,
             em.salary,
             em.hire_date
      FROM (SELECT employee_id,
                   first_name,
                   salary,
                   hire_date
            FROM employees
            ORDER BY hire_date ASC)em)real
WHERE real.rn >= 11
AND real.rn <= 15;

