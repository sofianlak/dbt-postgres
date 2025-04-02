WITH customer_data AS (
    SELECT 
        id,
        UPPER(name) AS name_uppercase,
        email,
        age,
        city
    FROM {{ source('openfood', 'customers') }}
),
age_groups AS (
    SELECT 
        CASE 
            WHEN age < 18 THEN 'Under 18'
            WHEN age BETWEEN 18 AND 30 THEN '18-30'
            WHEN age BETWEEN 31 AND 50 THEN '31-50'
            WHEN age > 50 THEN 'Above 50'
        END AS age_group,
        id
    FROM customer_data
)

SELECT 
    cd.id,
    cd.name_uppercase,
    cd.email,
    cd.age,
    cd.city,
    ag.age_group
FROM customer_data cd
JOIN age_groups ag
    ON cd.id = ag.id