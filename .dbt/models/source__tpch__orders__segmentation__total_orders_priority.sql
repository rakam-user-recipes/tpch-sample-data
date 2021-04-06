{{
  config(
   
    schema = "EVENTS",
    alias = "SOURCE__TPCH__ORDERS__TOTAL_ORDERS_PRIORITY",
    materialized = "incremental"
  )
}}
SELECT * FROM (SELECT 
    CONVERT_TIMEZONE('UTC', source__tpch__orders.o_orderdate) AS o_orderdate,
    source__tpch__orders.o_shippriority AS o_shippriority,
    source__tpch__orders.o_orderpriority AS o_orderpriority,
    count(*) AS count_of_rows,
    hll_accumulate(source__tpch__orders.o_orderkey) AS unique_orders
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS AS source__tpch__orders


GROUP BY
    1,  2,  3 

) AS t
                            {% if is_incremental() %}
                               WHERE source__tpch__orders.o_orderdate > (select max(o_orderdate) from {{ this }})
                            {% endif %}