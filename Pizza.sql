use pizza;
Select * from pizza_sales;
select count(quantity) from pizza_sales;
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Pizza_sales'
  AND COLUMN_NAME = 'Order_date';
alter table Pizza_sales
modify column order_date date;
UPDATE pizza_sales
SET Order_date = STR_TO_DATE(order_date, '%d-%m-%Y');
alter table pizza_sales
modify column Order_time time;
UPDATE Pizza_sales
SET Order_time = STR_TO_DATE(Order_time, '%H:%i:%s');
#A.Categorical Values
#1. Total Revenue
select cast(Sum(total_price) as decimal(10,2)) as Total_Revenue from Pizza_sales;

#2. Average Order Value
select Cast(sum(total_price)/count(distinct order_id) as decimal(10,2)) as Avg_Order_value from Pizza_sales;

#3. Total Pizzas Sold
select sum(Quantity) from Pizza_sales;

#4. Total Orders
select count(distinct order_id) from Pizza_sales;

#5. Average Pizzas Per Order
select count(pizza_id)/count(distinct order_id) from pizza_sales;

#B.Daily Trend for Total Orders

select dayname(order_date) as Day, count(distinct order_id) as Total_order
from Pizza_sales
group by Day
order by Total_order desc;

#C. Monthly Trend for Orders

select monthname(order_date) as Month, count(distinct order_id) as Total_order
from Pizza_sales
group by Month
order by Total_order desc;

#D. % of Sales by Pizza Category

SELECT 
    Pizza_category,
    round(SUM(total_price)) AS total_sales,
    round((SUM(Total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100) AS sales_percentage
FROM 
    pizza_sales
GROUP BY 
    Pizza_category;
    
#E. % of Sales by Pizza Size

    Select Pizza_size,
    round(sum(Total_price)) as Total_revenue,
    format((SUm(Total_price)/(select sum(total_price)from Pizza_sales))*100,2) as Per
    from Pizza_sales
    group by Pizza_size;

#F. Total Pizzas Sold by Pizza Category

    select pizza_category, count(quantity) as Qty from pizza_sales
    group by pizza_category;

#G. Top 5 Pizzas by Revenue

select Pizza_name, cast(Sum(total_price) as decimal(10,2)) as Total_Revenue
from Pizza_sales
group by Pizza_name
order by Total_revenue desc
limit 5;

#H. Bottom 5 Pizzas by Revenue

select Pizza_name, cast(Sum(total_price) as decimal(10,2)) as Total_Revenue
from Pizza_sales
group by Pizza_name
order by Total_revenue Asc
limit 5;

#I. Top 5 Pizzas by Quantity

select Pizza_name, Sum(quantity) as Total_Quantity
from Pizza_sales
group by Pizza_name
order by Total_quantity desc
limit 5;

#J. Bottom 5 Pizzas by Quantity

select Pizza_name, Sum(quantity) as Total_Quantity
from Pizza_sales
group by Pizza_name
order by Total_quantity asc
limit 5;

#K. Top 5 Pizzas by Total Orders

select Pizza_name, count(distinct Order_id) as Order_count
from Pizza_sales
group by Pizza_name
order by Order_count desc
limit 5;

#L. Borrom 5 Pizzas by Total Orders

select Pizza_name, count(distinct Order_id) as Order_count
from Pizza_sales
group by Pizza_name
order by Order_count asc
limit 5;
