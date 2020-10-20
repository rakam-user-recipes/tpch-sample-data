{
  name : "orders",
  target : {
    database : "SNOWFLAKE_SAMPLE_DATA",
    schema : "TPCH_SF1",
    table : "ORDERS"
  },
  mappings : {
    eventTimestamp: 'o_orderdate',
    userId: 'o_custkey'
  },
  dimensions : {
    o_orderkey : {
      type : "decimal",
      column : "O_ORDERKEY"
    },
    o_custkey : {
      type : "decimal",
      column : "O_CUSTKEY"
    },
    o_orderstatus : {
      type : "string",
      column : "O_ORDERSTATUS"
    },
    o_totalprice : {
      type : "decimal",
      column : "O_TOTALPRICE"
    },
    o_orderdate : {
      type : "date",
      column : "O_ORDERDATE"
    },
    o_orderpriority : {
      type : "string",
      column : "O_ORDERPRIORITY"
    },
    o_clerk : {
      type : "string",
      column : "O_CLERK"
    },
    o_shippriority : {
      type : "decimal",
      column : "O_SHIPPRIORITY"
    },
    o_comment : {
      type : "string",
      column : "O_COMMENT"
    }
  },
  measures : {
    count_of_rows : {
      aggregation : "count",
      type : "double"
    },
    sum_of_o_orderkey : {
      dimension : "o_orderkey",
      aggregation : "sum",
      type : "double"
    },
    sum_of_o_custkey : {
      dimension : "o_custkey",
      aggregation : "sum",
      type : "double"
    },
    sum_of_o_totalprice : {
      dimension : "o_totalprice",
      aggregation : "sum",
      type : "double"
    },
    sum_of_o_shippriority : {
      dimension : "o_shippriority",
      aggregation : "sum",
      type : "double"
    }
  },
  materializes: {
    segmentation: {
      total_orders_priority: {
        measures: ['count_of_rows'],
        dimensions: ['o_orderdate', 'o_orderpriority', 'o_shippriority']
      }
    }
  }
}