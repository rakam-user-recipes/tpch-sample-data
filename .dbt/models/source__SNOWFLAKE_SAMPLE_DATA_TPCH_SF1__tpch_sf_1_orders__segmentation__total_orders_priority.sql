{{
  config(
   
    alias = "SOURCE__SNOWFLAKE_SAMPLE_DATA_TPCH_SF1__TPCH_SF_1_ORDERS__TOTAL_ORDERS_PRIORITY",
    materialized = "table"
  )
}}
SELECT 
    CONVERT_TIMEZONE('UTC', source__SNOWFLAKE_SAMPLE_DATA_TPCH_SF1__tpch_sf_1_orders.o_orderdate) AS o_orderdate,
    source__SNOWFLAKE_SAMPLE_DATA_TPCH_SF1__tpch_sf_1_orders.o_shippriority AS o_shippriority,
    source__SNOWFLAKE_SAMPLE_DATA_TPCH_SF1__tpch_sf_1_orders.o_orderpriority AS o_orderpriority,
    count(1) AS count_of_rows,
    hll_accumulate(source__SNOWFLAKE_SAMPLE_DATA_TPCH_SF1__tpch_sf_1_orders.o_orderkey) AS unique_orders
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS AS source__SNOWFLAKE_SAMPLE_DATA_TPCH_SF1__tpch_sf_1_orders


GROUP BY
    1,  2,  3 

