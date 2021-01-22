{{
  config(
   
    schema = "RAKAM_AGGREGATES",
    alias = "ORDERS__TOTAL_ORDERS_PRIORITY",
    materialized = "incremental"
  )
}}
SELECT * FROM (SELECT 
    CONVERT_TIMEZONE('UTC', orders.O_ORDERDATE) AS o_orderdate,
    orders.O_SHIPPRIORITY AS o_shippriority,
    orders.O_ORDERPRIORITY AS o_orderpriority,
    count(1) AS count_of_rows
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS AS orders


GROUP BY
    1,  2,  3 

) AS t
                            {% if is_incremental() %}
                               WHERE CONVERT_TIMEZONE('UTC', orders.O_ORDERDATE) > (select max(o_orderdate) from {{ this }})
                            {% endif %}