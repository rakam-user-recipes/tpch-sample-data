{{
  config(
   
    alias = "SOURCE__TPCH__ORDERS__TOTAL_ORDERS_PRIORITY",
    materialized = "table"
  )
}}
SELECT 
    CONVERT_TIMEZONE('UTC', source__tpch__orders.o_orderdate) AS o_orderdate,
    source__tpch__orders.o_shippriority AS o_shippriority,
    source__tpch__orders.o_orderpriority AS o_orderpriority,
    count(1) AS count_of_rows,
    hll_accumulate(source__tpch__orders.o_orderkey) AS unique_orders
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS AS source__tpch__orders


GROUP BY
    1,  2,  3 

