SELECT COUNT(*) FROM supply_chain;
-- Total Orders, Sales & Profit
select 
	count(order_id) as total_orders,
    Round(sum(Sales),2) as total_sales, 
    Round(sum(order_profit_per_order),2) as total_profit
    From supply_chain;
    
    -- Average Delivery Time
    select round(Avg(delivery_time),2) as avg_delivery_time
    from supply_chain;
    
    -- Delay Percentage
    
    select 
    Round((sum(is_delayed)/count(*))*100,2) as delay_percentage
    from supply_chain;

-- Region-wise Performance  | which region is worst performing 
SELECT 
    market,
    COUNT(*) AS total_orders,
    ROUND(AVG(delivery_time),2) AS avg_delivery_time,
    ROUND((SUM(is_delayed)/COUNT(*))*100,2) AS delay_pct
FROM supply_chain
GROUP BY market
ORDER BY delay_pct DESC;

-- Shipping Mode Analysis || Which shipping mode is slowest?
select
	shipping_mode, 
    count(*) As total_orders,
    Round(avg(delivery_time),2) AS avg_delivery_time,
    Round(Sum(is_delayed)*100.0 / count(*),2) as delayed_pct
    From supply_chain
    group by shipping_mode
    order by delayed_pct DESC;
    
 -- Category Performance 
 Select Category_name, 
 round(Sum(sales),2) As total_sales, 
 round(sum(order_profit_per_order),2) As total_order_profit,
 round(avg(delivery_time),2) as avg_delivery_time
 from supply_chain
 group by category_name
 Order by total_sales DESC;
 
 -- Monthly Trend
 select 
	date_format(Order_date, '%Y-%M') as month,
    count(*) as total_orders,
    ROUND(AVG(delivery_time),2) AS avg_delivery_time,
    Round(Sum(is_delayed) *100.0 / count(*),2) as delay_pct
From supply_chain
group by month
order by month;

-- High Delay Regions Only
select 
market, 
count(*) as total_orders, 
Round(sum(is_delayed) *100.0 / count(*) , 2) as delay_pct
from supply_chain
group by market
having delay_pct > 40
order by delay_pct desc; 