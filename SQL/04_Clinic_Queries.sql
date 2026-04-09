 -- SECTION B 
-- q1)

SELECT sales_channel,
       SUM(amount) AS total_revenue
FROM clinic_sales
WHERE datetime >= '2021-01-01'
  AND datetime < '2022-01-01'
GROUP BY sales_channel;

-- q2)
SELECT uid,
       SUM(amount) AS total_spent
FROM clinic_sales
WHERE datetime >= '2021-01-01'
  AND datetime < '2022-01-01'
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-- q3)
WITH revenue AS (
    SELECT 
        DATE_TRUNC('month', datetime) AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE datetime >= '2021-01-01'
      AND datetime < '2022-01-01'
    GROUP BY DATE_TRUNC('month', datetime)
),
expenses_cte AS (
    SELECT 
        DATE_TRUNC('month', datetime) AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE datetime >= '2021-01-01'
      AND datetime < '2022-01-01'
    GROUP BY DATE_TRUNC('month', datetime)
)

SELECT r.month,
       r.total_revenue,
       COALESCE(e.total_expense, 0) AS total_expense,
       (r.total_revenue - COALESCE(e.total_expense, 0)) AS profit,
       CASE 
           WHEN (r.total_revenue - COALESCE(e.total_expense, 0)) > 0 THEN 'Profitable'
           ELSE 'Not Profitable'
       END AS status
FROM revenue r
LEFT JOIN expenses_cte e ON r.month = e.month;

-- q4)

WITH profit_data AS (
    SELECT 
        c.city,
        cs.cid,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e 
        ON cs.cid = e.cid
        AND DATE_TRUNC('month', cs.datetime) = DATE_TRUNC('month', e.datetime)
    WHERE cs.datetime >= '2021-09-01'
      AND cs.datetime < '2021-10-01'
    GROUP BY c.city, cs.cid
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM profit_data
)

SELECT *
FROM ranked
WHERE rnk = 1;

-- q5)

WITH profit_data AS (
    SELECT 
        c.state,
        cs.cid,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e 
        ON cs.cid = e.cid
        AND DATE_TRUNC('month', cs.datetime) = DATE_TRUNC('month', e.datetime)
    WHERE cs.datetime >= '2021-09-01'
      AND cs.datetime < '2021-10-01'
    GROUP BY c.state, cs.cid
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM profit_data
)

SELECT *
FROM ranked
WHERE rnk = 2;