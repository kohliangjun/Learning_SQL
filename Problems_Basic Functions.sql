-- PRACTICE (1.1)
-- average "salary_hour_avg" where posted date is more than june 1st and grouped by schedule type

SELECT 
    ROUND(AVG(salary_hour_avg), 2),
    job_schedule_type
FROM
    job_postings_fact
WHERE 
    job_posted_date > '2023-06-01' 
    AND salary_hour_avg IS NOT NULL 
    AND job_schedule_type IS NOT NULL
GROUP BY 
    job_schedule_type
;

-- PRACTICE (1.2)
-- average "salary_year_avg" where posted date is more than june 1st and grouped by schedule type

SELECT 
    ROUND(AVG(salary_year_avg), 2),
    job_schedule_type
FROM
    job_postings_fact
WHERE 
    job_posted_date > '2023-06-01' 
    AND salary_year_avg IS NOT NULL 
    AND job_schedule_type IS NOT NULL
GROUP BY 
    job_schedule_type
;

-- PRACTICE (2.1)
-- count "job id" group and order by month

SELECT
    COUNT(job_id) AS count_job,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'EDT') AS month
FROM
    job_postings_fact
GROUP BY month
ORDER BY month 
;


-- PRACTICE (3.1)
-- company names that offer health insurance, whose job postings are made in Q2

SELECT
    name,
    job_health_insurance,
    EXTRACT(MONTH FROM job_posted_date) AS posting_month
FROM job_postings_fact
JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_health_insurance IS TRUE
    AND job_posted_date > '2023-04-30'
    AND job_posted_date < '2023-09-01'
ORDER BY posting_month