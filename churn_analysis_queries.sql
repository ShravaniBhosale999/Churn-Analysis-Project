SELECT * FROM cleaned_churn LIMIT 5;



-- Query 1: Overall Churn Rate
SELECT 
  ROUND(100.0 * 
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2
  ) AS churn_rate_percentage
FROM cleaned_churn;


-- 2. Churn Rate by Contract Type
SELECT 
  contract,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM cleaned_churn
GROUP BY contract
ORDER BY churn_rate_percent DESC;


-- 3. Average Monthly Charges by Churn Status
SELECT 
  churn,
  ROUND(AVG(monthlycharges), 2) AS avg_monthly_charge
FROM cleaned_churn
GROUP BY churn;

-- 4. Churn Rate by Tenure Group
SELECT 
  tenure_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 2) AS churn_rate
FROM (
  SELECT *,
    CASE 
      WHEN tenure <= 12 THEN '0-1 year'
      WHEN tenure <= 24 THEN '1-2 years'
      WHEN tenure <= 48 THEN '2-4 years'
      ELSE '4+ years'
    END AS tenure_group
  FROM cleaned_churn
) AS sub
GROUP BY tenure_group
ORDER BY churn_rate DESC;

  
  
  -- 5. Churn Rate by Internet Service Type
SELECT 
  internetservice,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM cleaned_churn
GROUP BY internetservice;

-- 6. Churn Rate by Paperless Billing
SELECT 
  paperlessbilling,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 2) AS churn_rate
FROM cleaned_churn
GROUP BY paperlessbilling
ORDER BY churn_rate DESC;

