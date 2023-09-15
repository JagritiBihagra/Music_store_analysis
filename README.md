# Music Store Analysis SQL 
# Overview
This SQL project aims to analyze data from a music store database to provide insights into sales, customer behavior, and product performance. By running SQL queries on this database, we can extract valuable information to make data-driven decisions and optimize various aspects of the music store's operations.

# Table of Contents
1. Database Schema
2. Data Description
3. Queries
4. Usage

## Database Schema
The database schema consists of several tables representing different aspects of the music store's operations. Here are the main tables:

- `customers`: Contains information about customers, including their names, addresses, and contact details.
- `orders`: Stores data related to customer orders, such as order date, total amount, and customer ID.
- `order_items`: Includes details about items purchased in each order, such as product ID, quantity, and unit price.
- `products`: Contains information about the products available in the store, including product names, categories, and prices.
- `categories`: Lists the product categories.
- `employees`: Includes details about store employees, including their names, roles, and contact information.

## Data Description

Before running queries, it's essential to understand the data contained in each table. Here's a brief overview of the data:

- `customers`: Contains customer information, including customer_id, first_name, last_name, email, phone, and address.
- `orders`: Stores order information, including order_id, customer_id, order_date, and total_amount.
- `order_items`: Includes details about products in each order, including order_item_id, order_id, product_id, quantity, and unit_price.
- `products`: Lists available products, including product_id, product_name, category_id, and unit_price.
- `categories`: Provides information about product categories, including category_id and category_name.
- `employees`: Contains employee information, including employee_id, first_name, last_name, email, and title.

## Queries

To gain insights into the music store's operations, we can run SQL queries on the database. Here are some example queries you can use:

1. **Total Sales by Month:**

   ```sql
   SELECT
       EXTRACT(MONTH FROM order_date) AS month,
       SUM(total_amount) AS total_sales
   FROM
       orders
   GROUP BY
       EXTRACT(MONTH FROM order_date)
   ORDER BY
       month;
   ```

2. **Top Selling Products:**

   ```sql
   SELECT
       p.product_name,
       SUM(oi.quantity) AS total_quantity_sold
   FROM
       order_items oi
   JOIN
       products p ON oi.product_id = p.product_id
   GROUP BY
       p.product_name
   ORDER BY
       total_quantity_sold DESC
   LIMIT 10;
   ```

3. **Customer Order History:**

   ```sql
   SELECT
       c.first_name,
       c.last_name,
       o.order_id,
       o.order_date,
       oi.product_id,
       p.product_name,
       oi.quantity,
       oi.unit_price
   FROM
       customers c
   JOIN
       orders o ON c.customer_id = o.customer_id
   JOIN
       order_items oi ON o.order_id = oi.order_id
   JOIN
       products p ON oi.product_id = p.product_id
   WHERE
       c.first_name = 'John' AND c.last_name = 'Doe';
   ```

Feel free to create additional queries tailored to your specific analysis needs.

## Usage

To use this SQL project, follow these steps:

1. **Database Setup**: Ensure that you have a working SQL database system (e.g., MySQL, PostgreSQL) set up. Create the necessary tables and import data from the provided datasets or your own.

2. **Query Execution**: Use your preferred SQL client (e.g., MySQL Workbench, pgAdmin) to run SQL queries against the database. You can copy and paste the example queries provided above into your SQL client.

3. Analysis: Interpret the query results to gain insights into various aspects of the music store's operations. You can create visualizations or reports based on the query outputs.

4. Optimization: Use the insights obtained from the analysis to make data-driven decisions and optimize the music store's performance, such as product offerings, marketing strategies, or customer engagement.


