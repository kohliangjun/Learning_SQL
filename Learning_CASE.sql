SELECT
    count(job_id) AS number_of_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'On-site'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category

-- Problem 

SELECT name, job_title,
    CASE 
        WHEN salary_year_avg < 48000 THEN 'LOW'
        WHEN salary_year_avg > 80000 THEN 'HIGH'
        ELSE 'STANDARD'
    END AS annual_salary
FROM job_postings_fact
JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE salary_year_avg IS NOT NULL 
    AND job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC
