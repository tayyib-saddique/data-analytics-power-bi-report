-- Which German store type had the highest revenue for 2022?
--- Local
SELECT 
    dim_store.store_type,
    SUM(dim_product.sale_price - dim_product.cost_price) AS total_revenue
FROM 
    orders
JOIN 
    dim_product ON orders.product_code = dim_product.product_code
JOIN 
    dim_store ON orders.store_code = dim_store.store_code
WHERE 
    EXTRACT(YEAR FROM orders.order_date::DATE) = 2022 AND dim_store.country = 'Germany'
GROUP BY 
    dim_store.store_type
ORDER BY 
    total_revenue DESC
LIMIT 1;