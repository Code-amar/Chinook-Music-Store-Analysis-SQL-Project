-- BATCH: PROFESSIONAL CERTIFICATE COURSE IN DATA SCIENCE - SEPTEMBER 2025
-- SUBMISSION BY: AMAR
-- PROJECT: CHINOOK MUSIC STORE
-- SKILL USED: MYSQL WORKBENCH
-- DOCUMENTATION FOR: OBJECTIVE QUESTIONS AND SUBJECTIVE QUESTIONS

-- ****** SCHEMA ******
use chinook;
select * from album; -- album_id, title, artist_id
select * from artist; -- artist_id, name
select * from customer; -- customer_id, first_name, last_name, company, address, city, state, country, postal_code, phone, fax, email, support_rep_id
select * from employee; -- employee_id, last_name, first_name, title, reports_to, birthdate, hire_date, address, city, state, country, postal_code, phone, fax, email
select * from genre; -- genre_id, name
select * from invoice; -- invoice_id, customer_id, invoice_date, billing_address, billing_city, billing_state, billing_country, billing_postal_code, total
select * from invoice_line; -- invoice_line_id, invoice_id, track_id, unit_price, quantity
select * from media_type; -- media_type_id, name
select * from playlist; -- playlist_id, name
select * from playlist_track; -- playlist_id, track_id
select * from track; -- track_id, name, album_id, media_type_id, genre_id, composer, milliseconds, bytes, unit_price


-- ********** OBJECTIVE QUESTIONS **********

-- ---------------------------------------------------------------------------------------------------
## Q1. Does any table have missing values or duplicates? If yes how would you handle it ?
-- ---------------------------------------------------------------------------------------------------


-- **** NULL VALUES CHECK *****

-- Checking for Null Values in album table
SELECT * 
FROM album 
WHERE album_id IS NULL 
OR title IS NULL 
OR artist_id IS NULL; -- no missing values found 

-- Checking for Null Values in artist table
SELECT * 
FROM artist 
WHERE artist_id IS NULL 
OR name IS NULL; -- no missing values found 

-- Checking for Null Values in customer table 
SELECT * 
FROM customer 
WHERE first_name IS NULL 
   OR last_name IS NULL 
   OR company IS NULL 
   OR address IS NULL 
   OR city IS NULL 
   OR state IS NULL 
   OR country IS NULL 
   OR postal_code IS NULL 
   OR phone IS NULL 
   OR fax IS NULL 
   OR email IS NULL 
   OR support_rep_id IS NULL; -- missing values found
   
-- Checking for Null Values in employee table 
SELECT * 
FROM employee
WHERE last_name IS NULL 
   OR first_name IS NULL 
   OR title IS NULL 
   OR reports_to IS NULL 
   OR birthdate IS NULL 
   OR hire_date IS NULL 
   OR address IS NULL 
   OR city IS NULL 
   OR state IS NULL 
   OR country IS NULL 
   OR postal_code IS NULL 
   OR phone IS NULL 
   OR fax IS NULL 
   OR email IS NULL; -- missing value found

-- Checking for Null Values in genre table 
SELECT * 
FROM genre 
WHERE genre_id IS NULL 
OR name IS NULL;  -- no missing values found 

-- Checking for Null Values in invoice table 
SELECT * 
FROM invoice 
WHERE invoice_id IS NULL 
OR customer_id IS NULL 
OR invoice_date IS NULL 
OR billing_address IS NULL 
OR billing_city IS NULL 
OR billing_state IS NULL 
OR billing_country IS NULL 
OR billing_postal_code IS NULL 
OR total IS NULL;   -- no missing values found 

-- Checking for Null Values in invoice_line table
SELECT * 
FROM invoice_line 
WHERE invoice_line_id IS NULL 
OR invoice_id IS NULL 
OR track_id IS NULL 
OR unit_price IS NULL 
OR quantity IS NULL;   -- no missing values found 

-- Checking for Null Values in media_type table
SELECT * 
FROM media_type 
WHERE media_type_id IS NULL 
OR name IS NULL;  -- no missing values found 

-- Checking for Null Values in playlist table
SELECT * FROM playlist 
WHERE playlist_id IS NULL 
OR name IS NULL;  -- no missing values found 

-- Checking for Null Values in playlist_track table
SELECT * FROM playlist_track 
WHERE playlist_id IS NULL 
OR track_id IS NULL;  -- no missing values found 

-- Checking for Null Values in track table
SELECT * 
FROM track
WHERE name IS NULL 
   OR album_id IS NULL
   OR media_type_id IS NULL 
   OR genre_id IS NULL 
   OR composer IS NULL 
   OR milliseconds IS NULL 
   OR bytes IS NULL 
   OR unit_price IS NULL; -- missing values found
   
-- Handling Missing Values : 
SET SQL_SAFE_UPDATES = 0;
UPDATE customer SET company = 'Unknown' WHERE company IS NULL;  
UPDATE customer SET state = 'None' WHERE state IS NULL; 
UPDATE customer SET phone = '+0 000 000 0000' WHERE phone IS NULL;
UPDATE customer SET fax = '+0 000 000 0000' WHERE fax IS NULL;
UPDATE customer SET postal_code = '0' WHERE postal_code IS NULL;
UPDATE employee SET reports_to ='0' WHERE reports_to IS NULL;
UPDATE track SET composer = 'Unknown' WHERE composer IS NULL;
   
  -- **** DUPLICATE VALUES CHECK *****

-- Checking for duplicate values in album table --
SELECT 
  album_id, 
  title, 
  artist_id, 
  COUNT(*) AS total_count 
FROM album 
GROUP BY album_id, title, artist_id 
HAVING COUNT(*) > 1; -- no duplicate values found 

-- Checking for duplicate values in artist table --
SELECT 
  artist_id, 
  name,
  COUNT(*) AS total_count 
FROM artist 
GROUP BY artist_id, name 
HAVING COUNT(*) > 1; -- no duplicate values found

-- Checking for duplicate values in customer table --
SELECT *, 
 COUNT(*) AS total_count 
FROM customer 
GROUP BY customer_id, email 
HAVING COUNT(*) > 1;   -- no duplicate values found 

-- Checking for duplicate values in employee table --
SELECT *, 
 COUNT(*) AS total_count 
FROM employee 
GROUP BY employee_id, email 
HAVING COUNT(*) > 1;   -- no duplicate values found

-- Checking for duplicate values in genre table --
SELECT *, 
 COUNT(*) AS total_genre_count 
FROM genre 
GROUP BY genre_id, name 
HAVING COUNT(*) > 1;   -- no duplicate values found 

-- Checking for duplicate values in invoice table --
SELECT *, 
 COUNT(*) AS total_count 
 FROM invoice 
GROUP BY customer_id, invoice_id 
HAVING COUNT(*) > 1;   -- no duplicate values found 

-- Checking for duplicate values in invoice_line table --
SELECT *, COUNT(*) AS total_count 
FROM invoice_line 
GROUP BY invoice_line_id 
HAVING COUNT(*) > 1;   -- no duplicate values found

-- Checking for duplicate values in media_type table --
SELECT *, COUNT(*) AS total_count 
FROM media_type 
GROUP BY media_type_id, name 
HAVING COUNT(*) > 1;  -- no duplicate values found 

-- Checking for duplicate values in playlist table --
SELECT *, 
 COUNT(*) AS total_count 
FROM playlist 
GROUP BY playlist_id, name 
HAVING COUNT(*) > 1;    -- no duplicate values found

-- Checking for duplicate values in playlist_track table --
SELECT *, COUNT(*) AS total_count 
FROM playlist_track 
GROUP BY playlist_id, track_id 
HAVING COUNT(*) > 1;   -- no duplicate values found

-- Checking for duplicate values in track table --
SELECT *, COUNT(*) AS total_count 
FROM track 
GROUP BY track_id, unit_price 
HAVING COUNT(*) > 1;

-- ---------------------------------------------------------------------------------------------------
## Q2. Find the top-selling tracks and top artist in the USA and identify their most famous genres.
-- ---------------------------------------------------------------------------------------------------

-- ***** Top Selling Track in USA *****

	SELECT 
    t.track_id,
	t.name AS track_name,	
	SUM(il.quantity) AS total_sold,
	g.name AS genre,
	a.name AS artist
FROM
	invoice_line il
	INNER JOIN invoice i ON il.invoice_id = i.invoice_id
	INNER JOIN customer c ON i.customer_id = c.customer_id
	INNER JOIN track t ON il.track_id = t.track_id
	INNER JOIN album al ON t.album_id = al.album_id
	INNER JOIN artist a ON al.artist_id = a.artist_id
	INNER JOIN genre g ON t.genre_id = g.genre_id
WHERE c.country = 'USA'
GROUP BY t.track_id, t.name, g.name, a.name
ORDER BY total_sold DESC
LIMIT 10;

-- *****Top Artist in USA and Most Famous Genres of the Top Artist *****

SELECT 
	a.artist_id,
	a.name AS artist_name,
	g.name AS genre_name,
	SUM(il.quantity) AS total_sold
FROM
	invoice_line il
	INNER JOIN invoice i ON il.invoice_id = i.invoice_id
	INNER JOIN customer c ON i.customer_id = c.customer_id
	INNER JOIN track t ON il.track_id = t.track_id
	INNER JOIN album al ON t.album_id = al.album_id
	INNER JOIN artist a ON al.artist_id = a.artist_id
	INNER JOIN genre g ON t.genre_id = g.genre_id
WHERE c.country = 'USA'
GROUP BY a.artist_id, a.name, g.name
ORDER BY total_sold DESC
LIMIT 1;

-- ---------------------------------------------------------------------------------------------------
## Q3. What is the customer demographic breakdown (age, gender, location) of Chinook's customer base?
-- ---------------------------------------------------------------------------------------------------

WITH customer_information_cte as (
	SELECT 
		customer_id,
		first_name,
		last_name,
		city,
		state,
		country
	FROM customer
)	
SELECT
	country,
	state,
	city,
	COUNT(customer_id) as total_customers
FROM customer_information_cte
GROUP BY country, state, city
ORDER BY country, state, city;

-- ---------------------------------------------------------------------------------------------------
## Q4. Calculate the total revenue and number of invoices for each country, state, and city:
-- ---------------------------------------------------------------------------------------------------

SELECT
	c.country,
    state,
    c.city,
    SUM(i.total) as total_revenue,
    COUNT(i.invoice_id) as number_of_invoices
FROM customer c 
INNER JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.country, c.state, c.city
ORDER BY total_revenue DESC, number_of_invoices DESC;

-- ---------------------------------------------------------------------------------------------------
## Q5. Find the top 5 customers by total revenue in each country.
-- ---------------------------------------------------------------------------------------------------

WITH customer_wise_revenue as(
	SELECT
		c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) as customers,
        c.country,
        SUM(i.total) as total_revenue
	FROM customer c 
	INNER JOIN invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, customers, c.country
	ORDER BY c.country, total_revenue
),
ranked_customers as (
	SELECT
		customer_id,
        customers,
        country,
        total_revenue,
        RANK() OVER (PARTITION BY country ORDER BY total_revenue desc) as customer_rank
	FROM customer_wise_revenue
)	
SELECT 
	customer_id,
	customers,
	country,
	total_revenue,
    customer_rank
FROM ranked_customers
WHERE customer_rank <= 5
ORDER BY country, customer_rank;

-- ---------------------------------------------------------------------------------------------------
## Q6. Identify the top-selling track for each customer.
-- ---------------------------------------------------------------------------------------------------

WITH Customer_track as (
	SELECT
		c.customer_id,
		CONCAT(c.first_name, ' ', c.last_name) as customers,
		SUM(il.quantity) as total_quantity
	FROM customer c 
	INNER JOIN invoice i ON c.customer_id = i.customer_id
	INNER JOIN invoice_line il ON i.invoice_id = il.invoice_id
	INNER JOIN track t ON t.track_id = il.track_id
	GROUP BY c.customer_id, customers
),
ranked_track as(
	SELECT
		Customer_track.customer_id,
        Customer_track.customers,
        Customer_track.total_quantity,
        t.track_id,
        t.name as track_name,
        ROW_NUMBER() OVER 
        (PARTITION BY Customer_track.customer_id ORDER BY Customer_track.total_quantity DESC) as track_rank
	FROM Customer_track
	INNER JOIN invoice i ON Customer_track.customer_id = i.customer_id
	INNER JOIN invoice_line il ON i.invoice_id = il.invoice_id
	INNER JOIN track t ON t.track_id = il.track_id
)        
SELECT 
	customer_id,
    customers,
    track_id,
    track_name,
    total_quantity
FROM ranked_track
WHERE track_rank = 1
ORDER BY total_quantity DESC;

-- ---------------------------------------------------------------------------------------------------
## Q7. Are there any patterns or trends in customer purchasing behavior (e.g., frequency of purchases, 
 --    preferred payment methods, average order value)?
-- ---------------------------------------------------------------------------------------------------

-- ***** Frequency of Purchases *****
SELECT
	c.customer_id,
	CONCAT(c.first_name, ' ', c.last_name) as customers,
	YEAR(i.invoice_date) AS year,
	COUNT(i.invoice_id) AS purchase_count
FROM customer c
INNER JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, customers, YEAR(i.invoice_date)
ORDER BY c.customer_id, customers, YEAR(i.invoice_date);

-- ***** Calculate the average order value for each customer *****
SELECT
	c.customer_id,
	CONCAT(c.first_name, ' ', c.last_name) as customers,
    ROUND(AVG(i.total), 2) AS avg_order_value
FROM customer c 
INNER JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, customers
ORDER BY avg_order_value desc;

-- ---------------------------------------------------------------------------------------------------
## Q8. What is the customer churn rate?
-- ---------------------------------------------------------------------------------------------------
WITH MostRecentInvoice AS (
    SELECT MAX(invoice_date) AS most_recent_invoice_date
    FROM invoice
),
CutoffDate AS (
    SELECT DATE_SUB(most_recent_invoice_date, INTERVAL 1 YEAR) AS cutoff_date
    FROM MostRecentInvoice
),
ChurnedCustomers AS (
    SELECT 
        c.customer_id,
        COALESCE(c.first_name, ' ',c.last_name) as customers,
        MAX(i.invoice_date) AS last_purchase_date
    FROM customer c
	LEFT JOIN invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, customers
    HAVING MAX(i.invoice_date) IS NULL OR MAX(i.invoice_date) < (SELECT cutoff_date FROM CutoffDate)
)
-- Churn Rate Calculation
SELECT (SELECT COUNT(*) FROM ChurnedCustomers) / (SELECT COUNT(*) FROM customer) * 100 AS churn_rate;

-- ---------------------------------------------------------------------------------------------------
## Q9. Calculate the percentage of total sales contributed by each genre in the USA and identify the 
--     best-selling genres and artists.
-- ---------------------------------------------------------------------------------------------------

WITH genre_sales AS (
    SELECT 
        g.name AS genre_name,
        SUM(il.unit_price * il.quantity) AS genre_revenue
    FROM invoice i
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
    WHERE i.billing_country = 'USA'
    GROUP BY g.name
),
artist_sales AS (
    SELECT 
        ar.name AS artist_name,
        g.name AS genre_name,
        SUM(il.unit_price * il.quantity) AS artist_revenue
    FROM invoice i
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN album al ON t.album_id = al.album_id
    JOIN artist ar ON al.artist_id = ar.artist_id
    JOIN genre g ON t.genre_id = g.genre_id
    WHERE i.billing_country = 'USA'
    GROUP BY ar.name, g.name
)
SELECT 
    gs.genre_name,
    ROUND(gs.genre_revenue * 100 / (SELECT SUM(genre_revenue) FROM genre_sales), 2) AS genre_percentage,
    (SELECT artist_name 
     FROM artist_sales a 
     WHERE a.genre_name = gs.genre_name 
     ORDER BY a.artist_revenue DESC 
     LIMIT 1) AS top_artist
FROM genre_sales gs
ORDER BY genre_percentage DESC;

-- ---------------------------------------------------------------------------------------------------
## Q10. Find customers who have purchased tracks from at least 3 different genres.
-- ---------------------------------------------------------------------------------------------------
SELECT 
    c.customer_id,
	CONCAT(c.first_name, ' ', c.last_name) as customers,
    COUNT(DISTINCT g.genre_id) AS genre_count
FROM customer c
INNER JOIN invoice i ON c.customer_id = i.customer_id
INNER JOIN invoice_line il ON i.invoice_id = il.invoice_id
INNER JOIN track t ON il.track_id = t.track_id
INNER JOIN genre g ON t.genre_id = g.genre_id
GROUP BY c.customer_id, customers
HAVING COUNT(DISTINCT g.genre_id) >= 3
ORDER BY genre_count DESC;

-- ---------------------------------------------------------------------------------------------------
## Q11. Rank genres based on their sales performance in the USA.
-- ---------------------------------------------------------------------------------------------------
WITH genre_sales_in_usa AS (
	SELECT
		g.genre_id,
		g.name AS genre_name,
		SUM(il.unit_price * il.quantity) AS total_genre_sales
	FROM genre g
	INNER JOIN track t ON g.genre_id = t.genre_id
	INNER JOIN invoice_line il ON t.track_id = il.track_id 
	INNER JOIN invoice i ON il.invoice_id = i.invoice_id
	INNER JOIN customer c ON i.customer_id = c.customer_id
	WHERE c.country = 'USA'
	GROUP BY g.genre_id, g.name
)        
SELECT
	genre_id,
    genre_name,
    total_genre_sales,
    RANK() OVER (ORDER BY total_genre_sales DESC) AS genre_rank
FROM genre_sales_in_usa
ORDER BY genre_rank;
   
 -- ---------------------------------------------------------------------------------------------------
## Q12. Identify customers who have not made a purchase in the last 3 months.
-- ---------------------------------------------------------------------------------------------------  

WITH inactive_customers AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        MAX(i.invoice_date) AS last_purchase_date,
        SUM(i.total) AS total_revenue
    FROM customer c
    LEFT JOIN invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
    HAVING MAX(i.invoice_date) < DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
)

SELECT *
FROM inactive_customers;

--  ***** END OF OBJECTIVE QUESTIONS *****

## ======================================================================= SUBJECTIVE QUESTIONS =======================================================================

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Q1. Recommend the three albums from the new record label that should be prioritised for advertising and promotion in the USA based on genre sales analysis.
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT
	g.genre_id,
	g.name AS genre_name,
	al.album_id,
	al.title AS new_record_label,
	SUM(il.unit_price * il.quantity) AS total_genre_sales,
	DENSE_RANK() OVER (ORDER BY SUM(il.unit_price * il.quantity) DESC) AS Ranking
FROM genre g
INNER JOIN track t ON g.genre_id = t.genre_id
INNER JOIN invoice_line il ON t.track_id = il.track_id 
INNER JOIN invoice i ON il.invoice_id = i.invoice_id
INNER JOIN customer c ON i.customer_id = c.customer_id
INNER JOIN album al on t.album_id = al.album_id
WHERE c.country = 'USA'
GROUP BY g.genre_id, g.name, al.album_id, al.title
ORDER BY total_genre_sales DESC
LIMIT 3;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Q2. Determine the top-selling genres in countries other than the USA and identify any commonalities or differences.
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT
    i.billing_country,
    g.name AS genre_name,
    SUM(il.unit_price*il.quantity) AS total_sales
FROM invoice_line il
JOIN track t ON t.track_id = il.track_id
JOIN genre g ON g.genre_id = t.genre_id
JOIN invoice i ON i.invoice_id = il.invoice_id
WHERE i.billing_country != 'USA'
GROUP BY i.billing_country, g.name
ORDER BY i.billing_country, total_sales DESC;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Q3. Customer Purchasing Behavior Analysis: How do the purchasing habits (frequency, basket size, spending amount) of long-term customers differ from those of new 
--     customers? What insights can these patterns provide about customer loyalty and retention strategies?
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

WITH CustomerMetrics AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        MIN(DATE(i.invoice_date)) AS first_purchase_date,
        MAX(DATE(i.invoice_date)) AS last_purchase_date,
        COUNT(DISTINCT i.invoice_id) AS purchase_frequency,
        ROUND(AVG(il.quantity), 0) AS avg_basket_size,
        ROUND(AVG(i.total), 2) AS avg_spending_amount,
        DATEDIFF(MAX(i.invoice_date), MIN(i.invoice_date)) AS tenure_days,
        CASE 
            WHEN DATEDIFF(MAX(i.invoice_date), MIN(i.invoice_date)) > 1000 THEN 'Long Term'
            ELSE 'New'
        END AS customer_type
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    GROUP BY c.customer_id, customer_name
)
SELECT *
FROM CustomerMetrics
ORDER BY customer_id;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Q4. Product Affinity Analysis: Which music genres, artists, or albums are frequently purchased together by customers? How can this information guide product 
--     recommendations and cross-selling initiatives?
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Genre Co-Purchases
SELECT 
    g1.name AS genre_1, 
    g2.name AS genre_2, 
    COUNT(*) AS times_bought_together
FROM invoice_line AS il1
JOIN invoice_line AS il2 
ON il1.invoice_id = il2.invoice_id 
AND il1.track_id <> il2.track_id
JOIN track AS t1 
ON il1.track_id = t1.track_id
JOIN track AS t2 
ON il2.track_id = t2.track_id
JOIN genre AS g1 
ON t1.genre_id = g1.genre_id
JOIN genre AS g2 
ON t2.genre_id = g2.genre_id
GROUP BY genre_1, genre_2
ORDER BY times_bought_together DESC
LIMIT 10;

-- Artist Co-Purchases 
SELECT 
    ar1.name AS artist_1, 
    ar2.name AS artist_2, 
    COUNT(*) AS times_bought_together
FROM invoice_line AS il1
JOIN invoice_line AS il2 
ON il1.invoice_id = il2.invoice_id 
AND il1.track_id <> il2.track_id
JOIN track AS t1 
ON il1.track_id = t1.track_id
JOIN track AS t2 
ON il2.track_id = t2.track_id
JOIN album AS al1 
ON t1.album_id = al1.album_id
JOIN album AS al2 
ON t2.album_id = al2.album_id
JOIN artist AS ar1 
ON al1.artist_id = ar1.artist_id
JOIN artist AS ar2 
ON al2.artist_id = ar2.artist_id
GROUP BY artist_1, artist_2
ORDER BY times_bought_together DESC
LIMIT 10;

-- Album Co-Purchases  
SELECT 
    al1.title AS album_1, 
    al2.title AS album_2, 
    COUNT(*) AS times_bought_together
FROM invoice_line AS il1
JOIN invoice_line AS il2 
ON il1.invoice_id = il2.invoice_id 
AND il1.track_id <> il2.track_id
JOIN track AS t1 
ON il1.track_id = t1.track_id
JOIN track AS t2 
ON il2.track_id = t2.track_id
JOIN album AS al1 
ON t1.album_id = al1.album_id
JOIN album AS al2 
ON t2.album_id = al2.album_id
GROUP BY album_1, album_2
ORDER BY times_bought_together DESC
LIMIT 10;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Q5. Regional Market Analysis: Do customer purchasing behaviors and churn rates vary across different geographic regions or store locations? How might these correlate
--     with local demographic or economic factors?
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

WITH last_purchase AS (
    SELECT 
        customer_id,
        billing_country AS region,
        MAX(invoice_date) AS last_order_date
    FROM invoice
    GROUP BY customer_id, billing_country
),
dataset_end AS (
    SELECT MAX(invoice_date) AS max_date FROM invoice
)
SELECT 
    l.region, 
    COUNT(DISTINCT l.customer_id) AS total_customers,
    SUM(CASE WHEN l.last_order_date < DATE_SUB(d.max_date, INTERVAL 6 MONTH) THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN l.last_order_date < DATE_SUB(d.max_date, INTERVAL 6 MONTH) THEN 1 ELSE 0 END) * 100.0 
        / COUNT(DISTINCT l.customer_id), 
    2) AS churn_rate
FROM last_purchase l
CROSS JOIN dataset_end d
GROUP BY l.region
ORDER BY churned_customers DESC; 

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Q6. Customer Risk Profiling: Based on customer profiles (age, gender, location, purchase history), which customer segments are more likely to churn or pose a higher 
--     risk of reduced spending? What factors contribute to this risk?
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
WITH customer_summary AS (
    SELECT 
        c.customer_id,
        c.country,
        COUNT(i.invoice_id) AS total_orders,
        SUM(il.unit_price * il.quantity) AS total_spent,
        MAX(i.invoice_date) AS last_purchase_date,
        DATEDIFF(CURRENT_DATE, MAX(i.invoice_date)) AS days_since_last_purchase
    FROM customer c
    LEFT JOIN invoice i ON c.customer_id = i.customer_id
    LEFT JOIN invoice_line il ON i.invoice_id = il.invoice_id
    GROUP BY c.customer_id, c.country
),
customer_risk AS (
    SELECT 
        customer_id,
        country,
        total_orders,
        total_spent,
        last_purchase_date,
        days_since_last_purchase,
        CASE
            WHEN days_since_last_purchase > 180 THEN 'High Risk'
            WHEN days_since_last_purchase BETWEEN 90 AND 180 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS churn_risk,
        CASE
            WHEN total_spent < 100 THEN 'Low Value'
            WHEN total_spent BETWEEN 100 AND 500 THEN 'Medium Value'
            ELSE 'High Value'
        END AS value_segment
    FROM customer_summary
)
SELECT *
FROM customer_risk
ORDER BY churn_risk DESC, total_spent ASC;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Q7. Customer Lifetime Value Modeling: How can you leverage customer data (tenure, purchase history, engagement) to predict the lifetime value of different customer 
--     segments? This could inform targeted marketing and loyalty program strategies. Can you observe any common characteristics or purchase patterns among customers 
--     who have stopped purchasing?
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

WITH CustomerMetrics AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.country,
        MIN(i.invoice_date) AS first_purchase_date,
        MAX(i.invoice_date) AS last_purchase_date,
        DATEDIFF(MAX(i.invoice_date), MIN(i.invoice_date)) + 1 AS tenure_days,
        COUNT(i.invoice_id) AS purchase_frequency,
        SUM(i.total) AS total_spent,
        ROUND(SUM(i.total) / COUNT(i.invoice_id), 2) AS avg_order_value,
        DATEDIFF(CURRENT_DATE, MAX(i.invoice_date)) AS days_since_last_purchase
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.country
)
SELECT
    customer_id,
    customer_name,
    country,
    tenure_days,
    purchase_frequency,
    total_spent,
    avg_order_value,
    days_since_last_purchase,
    CASE 
        WHEN days_since_last_purchase > 180 THEN 'Churned'
        WHEN days_since_last_purchase > 30 THEN 'At-Risk'
        ELSE 'Active'
    END AS customer_status,       -- Churn segmentation 
    ROUND((total_spent / tenure_days) * 365, 2) AS estimated_clv_1year,
    ROUND(total_spent / tenure_days, 2) AS revenue_per_day     -- Basic CLV estimation
FROM CustomerMetrics
ORDER BY days_since_last_purchase DESC;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Q10. How can you alter the "Albums" table to add a new column named "ReleaseYear" of type INTEGER to store the release year of each album?
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE Album
ADD COLUMN ReleaseYear INT;
select * from Album;

UPDATE album
SET ReleaseYear = 2017
WHERE album_id = 1;

UPDATE album
SET ReleaseYear = 2017
WHERE album_id = 2;

UPDATE album
SET ReleaseYear = 2017
WHERE album_id = 3;

UPDATE album
SET ReleaseYear = 2017
WHERE album_id = 4;

UPDATE album
SET ReleaseYear = 2017
WHERE album_id = 5;

UPDATE album
SET ReleaseYear = 2018
WHERE album_id = 6;

UPDATE album
SET ReleaseYear = 2018
WHERE album_id = 7;

UPDATE album
SET ReleaseYear = 2018
WHERE album_id = 8;

UPDATE album
SET ReleaseYear = 2018
WHERE album_id = 9;

UPDATE album
SET ReleaseYear = 2018
WHERE album_id = 10;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Q11. Chinook is interested in understanding the purchasing behavior of customers based on their geographical location. 
-- They want to know the average total amount spent by customers from each country, along with the number of customers and the average number of tracks purchased per customer. 
-- Write an SQL query to provide this information.
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
WITH tracks_per_customer AS (
    SELECT 
        i.customer_id,
        SUM(il.quantity) AS total_tracks
    FROM invoice i
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    GROUP BY i.customer_id
),
customer_spending AS (
    SELECT 
        c.country,
        c.customer_id,
        SUM(i.total) AS total_spent,
        tpc.total_tracks
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN tracks_per_customer tpc ON c.customer_id = tpc.customer_id
    GROUP BY c.country, c.customer_id, tpc.total_tracks
)
SELECT 
    cs.country,
    COUNT(DISTINCT cs.customer_id) AS number_of_customers,
    ROUND(AVG(cs.total_spent),2) AS average_amount_spent_per_customer,
    ROUND(AVG(cs.total_tracks),2) AS average_tracks_purchased_per_customer
FROM customer_spending cs
GROUP BY cs.country
ORDER BY average_amount_spent_per_customer DESC;



## ***** END OF SUBJECTIVE QUESTIONS ***** 

