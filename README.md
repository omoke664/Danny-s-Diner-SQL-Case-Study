# 🍜 Danny's Diner SQL Case Study

This project is based on an interactive case study designed to test your SQL and analytical skills. The goal is to extract meaningful insights from a small restaurant's transactional database.

## 📚 Project Overview

Danny has started a small diner and wants to use data to better understand his customers. This case study involves analyzing menu items, customer behavior, loyalty programs, and rewards using structured SQL queries.

### 🎯 Objectives

- Analyze customer spending and visits
- Track item popularity and customer preferences
- Evaluate the impact of a membership loyalty program
- Calculate customer reward points based on dynamic rules

## 🗃️ Database Schema

Three main tables are used in this project:

### `sales`
| Column       | Type      | Description              |
|--------------|-----------|--------------------------|
| customer_id  | VARCHAR   | Unique customer ID       |
| order_date   | DATE      | Date of the purchase     |
| product_id   | INTEGER   | Purchased product ID     |

### `menu`
| Column       | Type      | Description             |
|--------------|-----------|-------------------------|
| product_id   | INTEGER   | Product ID              |
| product_name | VARCHAR   | Name of the menu item   |
| price        | INTEGER   | Price of the item       |

### `members`
| Column       | Type      | Description              |
|--------------|-----------|--------------------------|
| customer_id  | VARCHAR   | Customer who joined      |
| join_date    | DATE      | Date of joining the program |

## 🧠 Key SQL Insights

- 💰 **Total spending** by each customer.
- 📅 **Number of visits** per customer.
- 🥇 **First item purchased** by each customer.
- 🔥 **Most purchased item** overall and per customer.
- 🚀 **First post-membership purchase** by customer.
- 🧾 **Spending before membership**.
- 💳 **Points calculation**, with rules like:
  - 10 points per $1 spent
  - 2x multiplier on Sushi
  - 2x multiplier on all items in the first week after joining

## 🔍 Sample Business Questions Answered

- What is the total amount each customer spent at the restaurant?
- What was the most popular item overall and for each customer?
- How many loyalty points does each customer earn under different reward conditions?
- How did the membership program affect customer behavior?

## 📦 Setup Instructions

1. Run the SQL commands in `dannys_dinner.sql` to create and populate the database.
2. Execute the provided queries in your SQL IDE or command line to explore the data.
3. Modify and extend queries to perform deeper analysis.

## 🛠️ Technologies Used

- SQL (MySQL)
- Relational Databases
- Analytical Window Functions (e.g., `ROW_NUMBER()`)
- Common Table Expressions (CTEs)

## 📝 Notes

This project is inspired by the [Danny Ma's 8 Week SQL Challenge](https://8weeksqlchallenge.com/case-study-1/), with custom modifications.

---

## 📁 Files

- `dannys_dinner.sql`: DDL and DML for tables
- SQL scripts: Answers to all case study questions
- `README.md`: Documentation and context

---

## 🙌 Acknowledgements

Thanks to [Danny Ma](https://github.com/DataWithDanny) for the creative SQL challenges and resources that make learning data analytics practical and fun.

---

## 📬 Contact

For questions, feedback, or collaboration:

- GitHub: omoke664 (https://github.com/omoke664)
- Email: omokeleywes@gmail.com

