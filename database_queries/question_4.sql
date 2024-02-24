-- Create a view where the rows are the store types 
-- and the columns are the total sales, 
-- percentage of total sales and the count of orders

WITH new_view AS 
    (SELECT
        SUM(dim_product.sale_price * orders.product_quantity)::numeric AS total_sales,
        COUNT(orders.order_date_uuid) AS count_orders,
        dim_store.store_type as store_type
    FROM orders
        JOIN dim_product on dim_product.product_code = orders.product_code
        JOIN dim_store on dim_store.store_code = orders.store_code
    GROUP BY dim_store.store_type), 
    total_sales AS
    (SELECT
        SUM(new_view.total_sales) AS total_sales
    FROM new_view)

SELECT 
    new_view.store_type,
    new_view.total_sales,
    new_view.count_orders,
    ROUND((new_view.total_sales/(SELECT total_sales FROM total_sales))*100::numeric,2) AS perc_sales
FROM new_view