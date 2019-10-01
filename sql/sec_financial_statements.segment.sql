CREATE EXTERNAL TABLE sec_financial_statements.segment(
  segment_hash VARCHAR(50), 
  segment      VARCHAR(1000)
)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://dataset.secdatabase.com/sec_financial_statements/parquet/segment'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'parquet.compression'='SNAPPY');
