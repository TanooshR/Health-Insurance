# Health-Insurance
Actuarial analysis of 4,500 health insurance claims using SQL to evaluate claim frequency, severity, utilization, and trends across patients, providers, and claim types.
# Health Insurance Claims Analysis

## Overview
An actuarial analysis of **4,500 health insurance claims** using SQL to evaluate claim frequency, claim severity, healthcare utilization, and differences across patients, providers, and claim characteristics.

## Objectives

Determine: 
- Overall claim frequency and claim severity
- Claim costs by claim type and status
- Differences in claim severity across provider specialties
- Healthcare utilization across patient age groups
- Geographic differences in claim costs
- Patient and provider claim patterns
- High-cost claims and procedures
- Trends in claims over time

## Dataset
The dataset contains **4,500 health insurance claims** with information including:

- Claim ID
- Patient ID
- Provider ID
- Claim amount
- Claim date
- Diagnosis code
- Procedure code
- Patient age and gender
- Provider specialty
- Claim status
- Patient income
- Marital status
- Employment status
- Provider location
- Claim type
- Claim submission method

The dataset is included in the repository as:

`enhanced_health_insurance_claims.csv`



## SQL Techniques Utilized 

### Basic SQL
- `SELECT`
- `WHERE`
- `ORDER BY`
- `LIMIT`
- `DISTINCT`

### Aggregation & Analysis
- `COUNT`
- `SUM`
- `AVG`
- `MIN`
- `MAX`
- `GROUP BY`
- `HAVING`

### Intermediate SQL
- `CASE WHEN`
- Subqueries
- `COALESCE`
- NULL handling

### Advanced SQL
- Common Table Expressions (`CTEs`)
- Window functions
- `RANK()`
- `ROW_NUMBER()`
- `PARTITION BY`

## Project Purpose

This project was developed to strengthen practical SQL skills while applying them to an insurance-focused dataset. The analysis emphasizes concepts relevant to actuarial and insurance analytics, including claim frequency, claim severity, utilization, and cost variation.
