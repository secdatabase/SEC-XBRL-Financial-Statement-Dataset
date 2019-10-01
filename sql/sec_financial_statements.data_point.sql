CREATE EXTERNAL TABLE sec_financial_statements.data_point(
  cik                      INT           ,
  accession_number_int     BIGINT        ,
  filing_date              DATE          ,
  datapoint_id             BIGINT        ,
  datapoint_name           VARCHAR(1024) ,
  version                  VARCHAR(50)   ,
  segment_label            VARCHAR(1000) ,
  segment_hash             VARCHAR(50)   ,
  start_date               DATE          ,
  end_date                 DATE          ,
  period_month             BIGINT        ,
  string_value             STRING        ,
  numeric_value            DOUBLE        ,
  decimals                 INT           ,
  unit                     STRING        ,
  footnotes                STRING
  )
CLUSTERED BY (accession_number_int) 
INTO 240 BUCKETS
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://dataset.secdatabase.com/sec_financial_statements/parquet/data_point'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'parquet.compression'='SNAPPY');
