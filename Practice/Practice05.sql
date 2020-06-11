/*문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.(45건)*/
SELECT e.first_name,
       e.manager_id,
       e.commission_pct,
       e.salary
FROM employees e,(SELECT first_name,
                         manager_id,
                         commission_pct,
                         salary,
                         employee_id
                  FROM employees
                  WHERE manager_id is not null
                  AND commission_pct is null) maco
WHERE e.employee_id = maco.employee_id
AND e.salary > 3000
ORDER BY e.salary ASC;


/*문제2. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)*/
SELECT e.employee_id"직원번호",
       e.first_name"이름",
       e.salary"급여",
       to_char(e.hire_date,'yyyy-mm-dd')"입사일",
       REPLACE(e.phone_number,'.','-')"전화번호",
       e.department_id"부서번호"
FROM employees e
WHERE (department_id, salary) in (SELECT department_id,
                                         max(salary)
                                  FROM employees
                                  GROUP BY department_id)
ORDER BY e.salary DESC;


/*문제3
매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
(9건)*/
SELECT kiki.maid"매니저아이디",
       kiki.mafir"매니저이름",
       round(avg(e.salary),1)"매니저별평균급여",
       min(e.salary)"매니저별최소급여",
       max(e.salary)"매니저별최대급여"      
FROM employees e,(SELECT em.employee_id emid,
                        em.first_name,
                        em.manager_id,
                        em.hire_date,
                        ma.first_name mafir,
                        ma.employee_id maid,
                        ma.salary masa
                FROM employees em,employees ma
                WHERE em.manager_id = ma.employee_id
                AND em.hire_date>'05/01/01')kiki
WHERE e.employee_id = kiki.emid
GROUP BY kiki.mafir,kiki.maid
HAVING round(avg(e.salary),1)>=5000
ORDER BY round(avg(e.salary),1) DESC;


/*문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)*/
SELECT em.employee_id"사번",
       em.first_name"이름",
       em.department_id"부서명",
       ma.first_name"매니저이름"
FROM employees em,employees ma
WHERE em.manager_id = ma.employee_id;


/*문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요*/
SELECT emp.rn,
       emp.employee_id,
       emp.department_name,
       emp.department_name,
       emp.salary,
       emp.hire_date
FROM (SELECT ROWNUM rn,
               em.employee_id,
               em.department_name,
               em.salary,
               em.hire_date
        FROM (SELECT e.employee_id,
                     e.first_name,
                     d.department_name,
                     e.salary,
                     e.hire_date
              FROM employees e,departments d
              WHERE e.department_id = d.department_id
              AND hire_date>'2005/12/31'
              ORDER BY e.hire_date ASC)em)emp
where emp.rn >= 11
and emp.rn <= 20;


/*문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?*/
SELECT e.first_name||' '||last_name "이름",
       e.salary"연봉",
       d.department_name"부서이름",
       e.hire_date
FROM employees e, departments d ,(SELECT max(hire_date)eee
                                  FROM employees)emax
WHERE e.department_id = d.department_id(+)
AND e.hire_date = emax.eee;


/*문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.*/

SELECT em.employee_id"사번",
       em.first_name"이름",
       em.last_name"성",
       em.salary"급여",
       ms.sal"평균연봉",
       jo.job_title"직업명"
FROM employees em, jobs jo,
                            (SELECT department_id,
                                    avg(salary)sal
                            FROM employees
                            GROUP BY department_id)ass,
                            (SELECT max(avg(salary))sal
                            FROM employees
                            GROUP BY department_id)ms
WHERE em.department_id = ass.department_id
AND em.job_id = jo.job_id
AND ms.sal = ass.sal;


/*문제8.
평균 급여(salary)가 가장 높은 부서는?*/
SELECT d.department_name
FROM departments d ,(SELECT department_id,
                            avg(salary) sal
                    FROM employees
                    GROUP BY department_id)em,
                    (SELECT max(avg(salary)) sal 
                    FROM employees
                    GROUP BY department_id)emm
WHERE d.department_id = em.department_id
AND em.sal = emm.sal;


/*문제9.평균 급여(salary)가 가장 높은 지역은?*/

--방법1
SELECT regi.region_name
FROM regions regi,(SELECT re.region_name arere,
                           avg(em.salary) sal
                    FROM employees em, departments de, locations lo, countries co,regions re
                    WHERE em.department_id = de.department_id
                    AND lo.location_id = de.location_id
                    AND lo.country_id = co.country_id
                    AND re.region_id = co.region_id
                    GROUP BY re.region_name)avg_re,
                    (SELECT max(avg(em.salary))sal
                    FROM employees em, departments de, locations lo, countries co,regions re
                    WHERE em.department_id = de.department_id
                    AND lo.location_id = de.location_id
                    AND lo.country_id = co.country_id
                    AND re.region_id = co.region_id
                    GROUP BY re.region_name)max_re
WHERE regi.region_name = avg_re.arere
AND max_re.sal = avg_re.sal;

--방법2
SELECT rena
FROM (SELECT ROWNUM rn,
               rena,
               sal
        FROM (SELECT re.region_name rena,
                     avg(em.salary) sal
                FROM employees em, departments de, locations lo, countries co,regions re
                WHERE em.department_id = de.department_id
                AND lo.location_id = de.location_id
                AND lo.country_id = co.country_id
                AND re.region_id = co.region_id
                GROUP BY re.region_name
                ORDER BY sal DESC))
WHERE rn = 1;


/*문제10.평균 급여(salary)가 가장 높은 업무는?*/
SELECT jt
FROM (SELECT ROWNUM rn,
               jt,
               ass
        FROM (SELECT j.job_title jt,
                       avg(e.salary) ass
                FROM employees e, jobs j
                WHERE j.job_id = e.job_id
                GROUP BY j.job_title
                ORDER BY ass DESC))
WHERE rn =1;
