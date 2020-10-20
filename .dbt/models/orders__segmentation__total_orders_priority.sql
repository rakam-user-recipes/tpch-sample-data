{{
  config(
   
    schema = "RAKAM_AGGREGATES",
    alias = "ORDERS$TOTAL_ORDERS_PRIORITY",
    materialized = "incremental"
  )
}}
SELECT 
    "orders"."O_ORDERDATE" AS "o_orderdate",
    "orders"."O_ORDERPRIORITY" AS "o_orderpriority",
    "orders"."O_SHIPPRIORITY" AS "o_shippriority",
    count(1) AS "count_of_rows"
FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" AS "orders"


GROUP BY
    1,  2,  3 

ORDER BY 
    1 DESC, 
    4 DESC 
                           {% if is_incremental() %}
                              where "orders"."O_ORDERDATE" > (select max("orders"."O_ORDERDATE") from {{ this }})
                           {% endif %}