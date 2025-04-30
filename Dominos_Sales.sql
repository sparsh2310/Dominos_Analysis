 create database  dominos_sales_db;
 
 select * from pizza_sales;
 
 -- Total Revenue
 select concat('$ ',round(sum(unit_price * quantity),2)) as Total_Revenue from pizza_sales;
 
 -- Total No. Orders
 select count(distinct order_id) as Total_No_Orders from pizza_sales;
 
 -- Avg order values
 select concat('$ ',round(sum(total_price)/ count(distinct order_id),2)) as Avg_Order_Value from pizza_sales;

-- Total Pizza Sold
select sum(quantity) as Total_Pizza_Sold from pizza_sales; 

-- Avg Pizza's per Order
select concat('$ ', round(sum(quantity)/count(distinct order_id),2)) as Avg_pizza_per_Order from pizza_sales;



 
 select date(order_date) as Order_Day,count(distinct order_id) as Total_Order from pizza_sales group by 1  ;

SELECT 
    DAY(order_date) AS Order_Day,  -- Extracts the day from the order_date column
    COUNT(DISTINCT order_id) AS Total_Order -- Counts unique order IDs per day
FROM 
    pizza_sales 
GROUP BY 1; 
 
 /*
 describe pizza_sales;
 
 alter table pizza_sales
modify column  order_date date;
SELECT order_date FROM pizza_sales WHERE STR_TO_DATE(order_date, '%Y-%m-%d') IS NULL;

UPDATE pizza_sales  
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y')  
WHERE order_date IS NOT NULL;

UPDATE pizza_sales  
SET order_date = STR_TO_DATE(order_date, '%m/%d/%Y')  
WHERE order_date IS NOT NULL;
 
 
 ALTER TABLE pizza_sales MODIFY COLUMN order_date DATE;     */


-- weekly Order Placed 
 select dayofweek(order_date) as Day_No,
		dayname(order_date) as Day,
		count(distinct order_id) as Order_placed
		from pizza_sales
		group by Day_No,Day
        order by Day_No;
            
            
select  case
			when dayofweek(order_date)=1 then "Monday"
            when dayofweek(order_date)=2 then "Tuesday"
            when dayofweek(order_date)=3 then "Wednesday"
            when dayofweek(order_date)=4 then "Thursday"
            when dayofweek(order_date)=5 then "Friday"
            when dayofweek(order_date)=6 then "Saturday"
            else "Sunday"
            end as Day, count(distinct order_id) as Order_Placed
			from pizza_sales
			group by 1 
ORDER BY FIELD(Day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday','Sunday');




select dayname(order_date), case
			when dayofweek(order_date)=1 then "Monday"
            when dayofweek(order_date)=2 then "Tuesday"
            when dayofweek(order_date)=3 then "Wednesday"
            when dayofweek(order_date)=4 then "Thursday"
            when dayofweek(order_date)=5 then "Friday"
            when dayofweek(order_date)=6 then "Saturday"
            else "Sunday"
            end as Day, count(distinct order_id) 
			from pizza_sales
			group by 1,2 order by 1;
           
          
-- hourly Trend for Orders

/*alter table pizza_sales
modify column order_time time;

UPDATE pizza_sales
SET order_time = STR_TO_DATE(order_time, '%H:%i %s');

UPDATE pizza_sales
SET order_time = STR_TO_DATE(order_time, '%H:%i:%p');

UPDATE pizza_sales
SET order_time = STR_TO_DATE(order_time, '%H:%i:%p'); */

select hour(order_time) as Order_Hour,
	   count(distinct order_id) as Order_Placed 
       from pizza_sales
       group by 1;



-- Percentage sales by pizza category

select * from pizza_sales;

SELECT 
    pizza_category, 
    SUM(total_price) AS Total_Sales,
    (SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales) * 100) AS Percentage_Sales
FROM pizza_sales
GROUP BY pizza_category;

SELECT SUM(total_price) FROM pizza_sales;


-- Percentage sales by pizza Size


SELECT 
    pizza_size, 
    SUM(total_price) AS Total_Sales,
    (SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales) * 100) AS Percentage_Sales
FROM pizza_sales
GROUP BY pizza_size;

SELECT SUM(total_price) FROM pizza_sales;

-- Total qty sold By Pizza Category

select pizza_category,sum(quantity)as Total_Qty_Sold from pizza_sales 
			group by 1;
            
-- Top 5 pizzas
select pizza_name_id,sum(quantity) as Total_Pizza_sold from pizza_sales
			group by 1
            order by 2 desc limit 5;
            
-- Bottom 5 pizzas

select pizza_name_id,sum(quantity) as Total_Pizza_sold from pizza_sales
			group by 1
            order by 2 asc limit 5;

            
		
            
 