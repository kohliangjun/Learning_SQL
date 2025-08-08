SELECT name AS company_name
FROM company_dim
WHERE company_id IN(
    SELECT 
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
)

-- CTW example 

-- Creating a temporary table with CTE
WITH company_job_count AS (
    SELECT 
        company_id, 
        COUNT(*) AS total_jobs
    FROM 
        job_postings_fact
    GROUP BY
        company_id
)

-- Joining the company dim table with the temporary table 
-- to get the total count of jobs per company
SELECT 
    company_dim.name AS company_name, 
    company_job_count.total_jobs
FROM company_dim
JOIN company_job_count ON company_dim.company_id = company_job_count.company_id
ORDER BY company_job_count.total_jobs DESC

-- Problem 7

WITH remote_job_skills AS(
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE job_postings.job_work_from_home = True AND job_postings.job_title_short = 'Data Analyst'
    GROUP BY skill_id
)

SELECT 
    remote_job_skills.skill_id,
    skills,
    remote_job_skills.skill_count
FROM 
    remote_job_skills
JOIN skills_dim AS skill ON remote_job_skills.skill_id = skill.skill_id
ORDER BY skill_count DESC
LIMIT 5
