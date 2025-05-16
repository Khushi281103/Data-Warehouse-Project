📒 Data Catalog for Gold Layer
🔎 Overview
The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of dimension tables and fact tables that capture key business metrics.

📁 1. gold.dim_customers
Purpose:
Stores customer details enriched with demographic and geographic data.

Schema:
Column Name	Data Type	Description
customer_key	INT	Surrogate key uniquely identifying each customer record.
customer_id	INT	Unique numerical identifier assigned to each customer.
customer_number	NVARCHAR(50)	Alphanumeric identifier for tracking and referencing customers.
first_name	NVARCHAR(50)	The customer's first name.
last_name	NVARCHAR(50)	The customer's last name or family name.
country	NVARCHAR(50)	The customer's country of residence (e.g., 'Australia').
marital_status	NVARCHAR(50)	Marital status (e.g., 'Married', 'Single').
gender	NVARCHAR(50)	Gender of the customer (e.g., 'Male', 'Female', 'n/a').
birthdate	DATE	Date of birth (format: YYYY-MM-DD, e.g., 1971-10-06).
create_date	DATE	Date and time when the customer record was created.

📁 2. gold.dim_products
Purpose:
Provides information about products and their key attributes.

Schema:
Column Name	Data Type	Description
product_key	INT	Surrogate key uniquely identifying each product.
product_id	INT	Unique product identifier for internal tracking.
product_number	NVARCHAR(50)	Structured alphanumeric code representing the product.
product_name	NVARCHAR(50)	Descriptive name of the product (includes color, size, etc.).
category_id	NVARCHAR(50)	Identifier for the product's category.
category	NVARCHAR(50)	Broader classification of the product (e.g., Bikes, Components).
subcategory	NVARCHAR(50)	Detailed classification of the product within the category.
maintenance_required	NVARCHAR(50)	Indicates if maintenance is required (e.g., 'Yes', 'No').
cost	INT	Base cost of the product in whole currency units.
product_line	NVARCHAR(50)	Product line/series (e.g., Road, Mountain).
start_date	DATE	Date when the product became available.

📁 3. gold.fact_sales
Purpose:
Captures transactional sales data for analytical purposes.

Schema:
Column Name	Data Type	Description
order_number	NVARCHAR(50)	Unique alphanumeric identifier for each sales order (e.g., 'SO54496').
product_key	INT	Foreign key linking to dim_products.
customer_key	INT	Foreign key linking to dim_customers.
order_date	DATE	Date when the order was placed.
shipping_date	DATE	Date when the order was shipped.
due_date	DATE	Date when the payment was due.
sales_amount	INT	Total value of the sale in currency units (e.g., 25).
quantity	INT	Number of units ordered.
price	INT	Unit price of the product in currency units.
