CREATE EXTERNAL TABLE sec_financial_statements.data_point_revision(
  datapoint_id              BIGINT ,
  accession_number_int      BIGINT ,
  filing_date               DATE   ,
  string_value              STRING ,
  numeric_value             DOUBLE)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://dataset.secdatabase.com/sec_financial_statements/parquet/20200930/data_point_revision'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'parquet.compression'='SNAPPY');
