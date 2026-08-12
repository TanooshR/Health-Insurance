--Basic Overview 
-- Total number of claims
SELECT 
  COUNT(*) AS total_claims
FROM claims;

-- Number of unique patients
SELECT 
  COUNT(DISTINCT PatientID) AS unique_patients
FROM claims;

-- Number of unique providers
SELECT 
  COUNT(DISTINCT ProviderID) AS unique_providers
FROM claims;

-- Number of unique diagnoses
SELECT 
  COUNT(DISTINCT DiagnosisCode) AS unique_diagnoses
FROM claims;

-- Number of unique procedures
SELECT 
  COUNT(DISTINCT ProcedureCode) AS unique_procedures
FROM claims;

-- Total claim amount
SELECT
    SUM(ClaimAmount) AS total_claim_amount
FROM claims;

-- Average claim amount (claim severity)
SELECT
    AVG(ClaimAmount) AS average_claim_amount
FROM claims;

-- Minimum and maximum claim amounts
SELECT
    MIN(ClaimAmount) AS minimum_claim,
    MAX(ClaimAmount) AS maximum_claim
FROM claims;

--Median claim amount
SELECT
    AVG(ClaimAmount) AS median_claim_amount
FROM (
    SELECT
        ClaimAmount,
        ROW_NUMBER() OVER (ORDER BY ClaimAmount) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM claims
)
WHERE row_num IN (
    (total_rows + 1) / 2,
    (total_rows + 2) / 2
);




--Claim Type Overview
--Number of claims by claim type
SELECT
    ClaimType,
    COUNT(*) AS claim_count
FROM claims
GROUP BY ClaimType
ORDER BY claim_count DESC;

-- Average claim amount by claim type
SELECT
    ClaimType,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY ClaimType
ORDER BY average_claim_amount DESC;

-- Claim types with more than 500 claims
SELECT
    ClaimType,
    COUNT(*) AS claim_count
FROM claims
GROUP BY ClaimType
HAVING COUNT(*) > 500
ORDER BY claim_count DESC;

-- Number of claims by status
SELECT
    ClaimStatus,
    COUNT(*) AS claim_count
FROM claims
GROUP BY ClaimStatus
ORDER BY claim_count DESC;

-- Claim amount by status
SELECT
    ClaimStatus,
    COUNT(*) AS claim_count,
    SUM(ClaimAmount) AS total_claim_amount,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY ClaimStatus
ORDER BY average_claim_amount DESC;

-- Percentage of claims by status
SELECT
    ClaimStatus,
    COUNT(*) AS claim_count,
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*) FROM claims),
        2
    ) AS percentage_of_claims
FROM claims
GROUP BY ClaimStatus
ORDER BY percentage_of_claims DESC;




-- Provider Speciality Overview 
-- Claims by provider specialty
SELECT
    ProviderSpecialty,
    COUNT(*) AS claim_count
FROM claims
GROUP BY ProviderSpecialty
ORDER BY claim_count DESC;

-- Claim severity by provider specialty
SELECT
    ProviderSpecialty,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY ProviderSpecialty
ORDER BY average_claim_amount DESC;

-- Specialties with average claims above the overall average
SELECT
    ProviderSpecialty,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY ProviderSpecialty
HAVING AVG(ClaimAmount) > (
    SELECT AVG(ClaimAmount)
    FROM claims
)
ORDER BY average_claim_amount DESC;




-- Patient Age Overview 
-- Average claim amount by patient age
SELECT
    PatientAge,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY PatientAge
ORDER BY PatientAge;


-- Create age groups and analyze claims
SELECT
    CASE
        WHEN PatientAge < 18 THEN 'Under 18'
        WHEN PatientAge BETWEEN 18 AND 29 THEN '18-29'
        WHEN PatientAge BETWEEN 30 AND 44 THEN '30-44'
        WHEN PatientAge BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY age_group
ORDER BY average_claim_amount DESC;


--Gender Overview
SELECT
    PatientGender,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY PatientGender
ORDER BY average_claim_amount DESC;



-- Income Overview 
-- Average claim amount by income level
SELECT
    CASE
        WHEN PatientIncome < 50000 THEN 'Under $50K'
        WHEN PatientIncome BETWEEN 50000 AND 99999 THEN '$50K-$99K'
        WHEN PatientIncome BETWEEN 100000 AND 149999 THEN '$100K-$149K'
        ELSE '$150K+'
    END AS income_group,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY income_group
ORDER BY average_claim_amount DESC;




-- Marriage and Employment 
-- Claims by marital status
SELECT
    PatientMaritalStatus,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY PatientMaritalStatus
ORDER BY average_claim_amount DESC;


-- Claims by employment status
SELECT
    PatientEmploymentStatus,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY PatientEmploymentStatus
ORDER BY average_claim_amount DESC;




-- Submission Method 
SELECT
    ClaimSubmissionMethod,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY ClaimSubmissionMethod
ORDER BY average_claim_amount DESC;


-- Location
SELECT
    ProviderLocation,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY ProviderLocation
ORDER BY average_claim_amount DESC;



-- Most common diagnoses
SELECT
    DiagnosisCode,
    COUNT(*) AS claim_count
FROM claims
GROUP BY DiagnosisCode
ORDER BY claim_count DESC
LIMIT 10;


-- Most expensive diagnoses by average claim
SELECT
    DiagnosisCode,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY DiagnosisCode
HAVING COUNT(*) >= 10
ORDER BY average_claim_amount DESC
LIMIT 10;


-- Procedure overview 
-- Most common procedures
SELECT
    ProcedureCode,
    COUNT(*) AS procedure_count
FROM claims
GROUP BY ProcedureCode
ORDER BY procedure_count DESC
LIMIT 10;


-- Procedures with highest average claim amounts
SELECT
    ProcedureCode,
    COUNT(*) AS procedure_count,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY ProcedureCode
HAVING COUNT(*) >= 10
ORDER BY average_claim_amount DESC
LIMIT 10;



-- Date Overview 
-- Claims by year
SELECT
    strftime('%Y', ClaimDate) AS claim_year,
    COUNT(*) AS claim_count,
    SUM(ClaimAmount) AS total_claim_amount,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY claim_year
ORDER BY claim_year;


-- Claims by month
SELECT
    strftime('%Y-%m', ClaimDate) AS claim_month,
    COUNT(*) AS claim_count,
    SUM(ClaimAmount) AS total_claim_amount,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY claim_month
ORDER BY claim_month;




-- Patients with the highest total claim amounts
SELECT
    PatientID,
    COUNT(*) AS claim_count,
    SUM(ClaimAmount) AS total_claim_amount,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY PatientID
ORDER BY total_claim_amount DESC
LIMIT 10;


-- Patients with multiple claims
SELECT
    PatientID,
    COUNT(*) AS claim_count,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY PatientID
HAVING COUNT(*) > 1
ORDER BY claim_count DESC;



-- Providers with the highest total claim amounts
SELECT
    ProviderID,
    COUNT(*) AS claim_count,
    SUM(ClaimAmount) AS total_claim_amount,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY ProviderID
ORDER BY total_claim_amount DESC
LIMIT 10;


-- Providers with at least 10 claims
SELECT
    ProviderID,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS average_claim_amount,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY ProviderID
HAVING COUNT(*) >= 10
ORDER BY average_claim_amount DESC;



-- Claims above the overall average
SELECT
    ClaimID,
    PatientID,
    ClaimAmount,
    ClaimType
FROM claims
WHERE ClaimAmount > (
    SELECT AVG(ClaimAmount)
    FROM claims
)
ORDER BY ClaimAmount DESC;


-- Specialties with above-average claim severity
SELECT
    ProviderSpecialty,
    AVG(ClaimAmount) AS average_claim_amount
FROM claims
GROUP BY ProviderSpecialty
HAVING AVG(ClaimAmount) > (
    SELECT AVG(ClaimAmount)
    FROM claims
)
ORDER BY average_claim_amount DESC;


-- CTE
-- Calculate claim statistics by specialty
WITH specialty_stats AS (
    SELECT
        ProviderSpecialty,
        COUNT(*) AS claim_count,
        AVG(ClaimAmount) AS average_claim_amount,
        SUM(ClaimAmount) AS total_claim_amount
    FROM claims
    GROUP BY ProviderSpecialty
)

SELECT
    ProviderSpecialty,
    claim_count,
    average_claim_amount,
    total_claim_amount
FROM specialty_stats
WHERE claim_count >= 10
ORDER BY average_claim_amount DESC;


-- CTE for patient claim totals
WITH patient_totals AS (
    SELECT
        PatientID,
        COUNT(*) AS claim_count,
        SUM(ClaimAmount) AS total_claim_amount
    FROM claims
    GROUP BY PatientID
)

SELECT
    PatientID,
    claim_count,
    total_claim_amount
FROM patient_totals
WHERE total_claim_amount > (
    SELECT AVG(total_claim_amount)
    FROM patient_totals
)
ORDER BY total_claim_amount DESC;



-- Rank claims within each provider specialty
SELECT
    ClaimID,
    ProviderSpecialty,
    ClaimAmount,
    RANK() OVER (
        PARTITION BY ProviderSpecialty
        ORDER BY ClaimAmount DESC
    ) AS claim_rank
FROM claims;


-- Top 3 claims within each specialty
WITH ranked_claims AS (
    SELECT
        ClaimID,
        ProviderSpecialty,
        ClaimAmount,
        RANK() OVER (
            PARTITION BY ProviderSpecialty
            ORDER BY ClaimAmount DESC
        ) AS claim_rank
    FROM claims
)

SELECT
    ClaimID,
    ProviderSpecialty,
    ClaimAmount,
    claim_rank
FROM ranked_claims
WHERE claim_rank <= 3
ORDER BY ProviderSpecialty, claim_rank;


-- Average claim amount by specialty while keeping individual claims
SELECT
    ClaimID,
    ProviderSpecialty,
    ClaimAmount,
    AVG(ClaimAmount) OVER (
        PARTITION BY ProviderSpecialty
    ) AS specialty_average_claim
FROM claims;


-- Difference between individual claim and specialty average
SELECT
    ClaimID,
    ProviderSpecialty,
    ClaimAmount,
    AVG(ClaimAmount) OVER (
        PARTITION BY ProviderSpecialty
    ) AS specialty_average,
    ClaimAmount -
        AVG(ClaimAmount) OVER (
            PARTITION BY ProviderSpecialty
        ) AS difference_from_specialty_average
FROM claims
ORDER BY difference_from_specialty_average DESC;



-- Number claims within each specialty
SELECT
    ClaimID,
    ProviderSpecialty,
    ClaimAmount,
    ROW_NUMBER() OVER (
        PARTITION BY ProviderSpecialty
        ORDER BY ClaimAmount DESC
    ) AS claim_number
FROM claims;



-- Check for missing claim amounts
SELECT COUNT(*) AS missing_claim_amounts
FROM claims
WHERE ClaimAmount IS NULL;


-- Check for missing provider specialties
SELECT COUNT(*) AS missing_specialties
FROM claims
WHERE ProviderSpecialty IS NULL;


-- Replace missing claim amounts with zero
SELECT
    ClaimID,
    COALESCE(ClaimAmount, 0) AS claim_amount
FROM claims;



-- ACTUARIAL SUMMARY 
-- Overall claims summary
SELECT
    COUNT(*) AS claim_count,
    SUM(ClaimAmount) AS total_claim_amount,
    AVG(ClaimAmount) AS claim_severity,
    MIN(ClaimAmount) AS minimum_claim,
    MAX(ClaimAmount) AS maximum_claim
FROM claims;


-- Claim frequency by claim type
SELECT
    ClaimType,
    COUNT(*) AS claim_frequency,
    AVG(ClaimAmount) AS claim_severity
FROM claims
GROUP BY ClaimType
ORDER BY claim_frequency DESC;


-- Severity by claim status
SELECT
    ClaimStatus,
    COUNT(*) AS claim_count,
    AVG(ClaimAmount) AS claim_severity,
    SUM(ClaimAmount) AS total_claim_amount
FROM claims
GROUP BY ClaimStatus
ORDER BY claim_severity DESC;
