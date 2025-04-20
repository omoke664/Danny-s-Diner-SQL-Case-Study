CREATE DATABASE dannys_dinner;

USE dannys_dinner;

CREATE TABLE sales(
	customer_id VARCHAR(1),
    order_date DATE,
    product_id INTEGER
);

INSERT INTO sales
(customer_id, order_date, product_id)
VALUES
	('A', '2021-01-01', '1'),
	('A', '2021-01-01', '2'),
	('A', '2021-01-07', '2'),
	('A', '2021-01-10', '3'),
	('A', '2021-01-11', '3'),
	('A', '2021-01-11', '3'),
	('B', '2021-01-01', '2'),
	('B', '2021-01-02', '2'),
	('B', '2021-01-04', '1'),
	('B', '2021-01-11', '1'),
	('B', '2021-01-16', '3'),
	('B', '2021-02-01', '3'),
	('C', '2021-01-01', '3'),
	('C', '2021-01-01', '3'),
	('C', '2021-01-07', '3');
  
CREATE TABLE menu(
	product_id INTEGER,
    product_name VARCHAR(5),
    price INTEGER
);

INSERT INTO menu
(product_id, product_name, price)
VALUES
(1, 'Sushi', 10),
(2, 'Curry', 15),
(3, 'Ramen', 12);

CREATE TABLE members(
	customer_id VARCHAR(1),
    join_date DATE 
);

INSERT INTO members
(customer_id, join_date)
VALUES
('A', '2021-01-07'),
('B', '2021-01-09');

-- Case Study Questions
-- What is the total amount each customer spent at the restaurant?
SELECT 
sales.customer_id,  SUM(price)
FROM sales
JOIN menu 
ON sales.product_id = menu.product_id
GROUP BY customer_id
ORDER BY SUM(price) DESC;

-- How many days has each customer visited the restaurant
SELECT customer_id, COUNT( order_date)
FROM sales
GROUP BY customer_id;

-- What was the first item from the menu purchased by each customer
SELECT 
 sales.customer_id, MIN(menu.product_name) AS first_product
FROM sales
JOIN menu
ON sales.product_id = menu.product_id
WHERE sales.order_date = (
	SELECT MIN(order_date)
    FROM sales
    WHERE customer_id = sales.customer_id)
GROUP BY customer_id;

-- What is the most purchased item on the menu and how many times was it purchased by all customers
-- Step 1: Find the most purchased item overall
WITH most_purchased_item AS (
    SELECT 
        s.product_id,
        m.product_name,
        COUNT(*) AS total_purchases
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
    GROUP BY s.product_id, m.product_name
    ORDER BY total_purchases DESC
    LIMIT 1
)
SELECT 
    s.customer_id,
    m.product_name,
    COUNT(*) AS times_purchased
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN most_purchased_item mpi ON s.product_id = mpi.product_id
GROUP BY s.customer_id, m.product_name;

-- Which item was the most popular for each customer
SELECT 
s.customer_id, m.product_name, COUNT(s.product_id) 
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id, product_name;

WITH customer_item_counts AS (
	SELECT 
		s.customer_id,
        m.product_name,
        COUNT(*) AS times_purchased,
        ROW_NUMBER() OVER (
			PARTITION BY s.customer_id
            ORDER BY COUNT(*) DESC
		) AS rn
	FROM sales s 
    JOIN menu m ON s.product_id = m.product_id
    GROUP BY s.customer_id, m.product_name
)
SELECT 
	customer_id,
    product_name,
    times_purchased
FROM customer_item_counts
WHERE rn = 1;

-- which items was purchased first by the customer after they became a member


WITH post_member_purchases AS (
	SELECT 
		s.customer_id,
        m.product_name,
        s.order_date,
        ROW_NUMBER() OVER(
			PARTITION BY s.customer_id
            ORDER BY s.order_date ASC
		) AS rn
        FROM sales s 
        JOIN menu m ON s.product_id = m.product_id
        JOIN members mb ON s.customer_id = mb.customer_id
        WHERE s.order_date > mb.join_date
	)
SELECT customer_id, product_name, order_date
FROM post_member_purchases
WHERE rn = 1;

-- what is the total items and amount spent for each member before they became a member
SELECT s.customer_id, COUNT(s.product_id), SUM(m.price)
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.order_date < mb.join_date
GROUP BY s.customer_id;

-- if each $1 spent equates to 10 points and suchi has a 2X points multiplier -
-- how many points would each customer have?
SELECT 
	s.customer_id,
    SUM(
		CASE
			WHEN m.product_name = 'Sushi' THEN m.price * 10 * 2
            ELSE m.price * 10
		END
        ) AS total_points
FROM sales s 
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY total_points DESC;

-- in the first week after a customer joins the program (including their join date) 
-- they earn 2X points on all items, not just sushi- how many points do Customer A and B have at the end of January?
SELECT 
	s.customer_id,
		SUM(
			CASE
				WHEN s.order_date BETWEEN mb.join_date AND DATE_ADD(mb.join_date, INTERVAL 6 DAY)
					THEN m.price * 10 * 2
                    
				WHEN m.product_name = 'Sushi'
					THEN m.price * 10 * 2
                    
				ELSE m.price * 10
			END
		) AS total_points
FROM sales s 
JOIN menu m ON s.product_id = m.product_id 
JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.customer_id IN ('A', 'B') 
	AND s.order_date <= '2021-01-31'
GROUP BY s.customer_id
ORDER BY total_points DESC;
  
