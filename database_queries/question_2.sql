-- Which month in 2022 has had the highest revenue?
--- July
SELECT 
    EXTRACT(MONTH FROM orders.order_date::DATE) AS month,
    SUM(dim_product.sale_price * dim_product.cost_price)::numeric AS total_revenue
FROM 
    orders
JOIN 
    dim_product ON orders.product_code = dim_product.product_code
WHERE 
    EXTRACT(YEAR FROM orders.order_date::DATE) = 2022
GROUP BY 
    EXTRACT(MONTH FROM orders.order_date::DATE), EXTRACT(YEAR FROM orders.order_date::DATE)
ORDER BY 
    total_revenue DESC
LIMIT 1;