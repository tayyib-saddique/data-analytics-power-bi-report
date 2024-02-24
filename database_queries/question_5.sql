SELECT
    dim_product.category,
    SUM((dim_product.sale_price - dim_product.cost_price)*orders.product_quantity) AS total_profit,
    dim_store.country_region
FROM
    dim_store 
JOIN
    orders ON dim_store.store_code = orders.store_code
JOIN
    dim_product ON orders.product_code = dim_product.product_code
WHERE
    dim_store.country_region = 'Wiltshire' AND EXTRACT(YEAR FROM orders.order_date::DATE) = 2021
GROUP BY
    dim_product.category,
    dim_store.country_region
ORDER BY
    total_profit DESC
LIMIT 1;