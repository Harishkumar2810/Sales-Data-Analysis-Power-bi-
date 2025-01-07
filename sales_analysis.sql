select * from sales_data;
select * from people;
select * from returns;

-- the total number of orders placed
select count("Order ID") from sales_data;

-- the total revenue generated from sales
select sum(sales) as total_amount from sales_data;

-- Identify the highest-priced pizza
select 'Product Name', max(sales), Category, 'Sub-Category' from sales_data group by 1,3,4;

-- all categories in sales data.
select Category from sales_data;

-- sales greater than average salaries
SELECT Category, SUM(Sales) AS total_sales FROM sales_data
WHERE Sales > (SELECT AVG(sales) FROM sales_data)
GROUP BY Category;

-- Highest sales categories
select Category, sum(Sales),  max(Quantity) from sales_data group by Category limit 1;

-- Join the sales data and return table using order id as a primary key
select * from sales_data SD join returns ON SD.`Order Id` = returns.`Order ID` order by 'row id' asc;

-- change date format from text to YYYY-MM--DD 
UPDATE sales_data SET `order date` = STR_TO_DATE(`order date`, '%d-%b-%y');

update sales_data set `ship date` = str_to_date(`ship date`, '%d-%b-%y');

select datediff(`ship date`,`order date`) from sales_data;
--
-- Group the orders by date and calculate the total number of ordered per day.
select `order date`, sum(`quantity`) ordered_per_day from sales_data group by `Order Date`;

-- Determine the top 3 most ordered Category types based on profit.
select distinct(`Sub-Category`) from sales_data;
select count(distinct(`Sub-Category`)) from sales_data;
select `Sub-Category`, max(Profit) revenue from sales_data group by 1 order by revenue desc limit 8;

-- Calculate the price contribution of each item

select `Category`, sum(
price)as price from(select `Category`,`sub-Category`,round((Sales/Quantity)-Profit,2) price from sales_data) ss group by 1;

select `Customer Name` from sales_data where `Customer Name`>=(select `Customer Name`,(`Customer Name`) from sales_data group by 1)