-- Section A
-- q1)   
SELECT user_id, room_no
FROM (
    SELECT user_id, room_no,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) AS rn
    FROM bookings
) t
WHERE rn = 1;

-- q2)
SELECT bc.booking_id,
       SUM(i.item_rate * bc.item_quantity) AS total_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE EXTRACT(MONTH FROM bc.bill_date) = 11
  AND EXTRACT(YEAR FROM bc.bill_date) = 2021
GROUP BY bc.booking_id;

-- q3)
SELECT bc.bill_id,
       SUM(i.item_rate * bc.item_quantity) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE EXTRACT(MONTH FROM bc.bill_date) = 10 AND EXTRACT (YEAR FROM bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING SUM(i.item_rate * bc.item_quantity) > 1000;

-- q4)

WITH item_orders AS (
    SELECT 
        DATE_TRUNC('month', bill_date) AS month,
        item_id,
        SUM(item_quantity) AS total_qty,

        RANK() OVER (
            PARTITION BY DATE_TRUNC('month', bill_date)
            ORDER BY SUM(item_quantity) DESC
        ) AS rnk_desc,

        RANK() OVER (
            PARTITION BY DATE_TRUNC('month', bill_date)
            ORDER BY SUM(item_quantity) ASC
        ) AS rnk_asc

    FROM booking_commercials
    WHERE bill_date >= '2021-01-01'
      AND bill_date < '2022-01-01'
    GROUP BY DATE_TRUNC('month', bill_date), item_id
)

SELECT *
FROM item_orders
WHERE rnk_desc = 1 OR rnk_asc = 1;


-- q5)

WITH monthly_bills AS (
    SELECT 
        b.user_id,
        DATE_TRUNC('month', bc.bill_date) AS month,
        SUM(i.item_rate * bc.item_quantity) AS total_bill
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE bc.bill_date >= '2021-01-01'
      AND bc.bill_date < '2022-01-01'
    GROUP BY b.user_id, DATE_TRUNC('month', bc.bill_date)
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY total_bill DESC) AS rnk
    FROM monthly_bills
)

SELECT *
FROM ranked
WHERE rnk = 2;





