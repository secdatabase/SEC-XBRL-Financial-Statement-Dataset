CREATE EXTERNAL TABLE sec_financial_statements.report_presentation_section(
  cik                           INT        ,
  filing_date                   DATE       ,
  accession_number_int          BIGINT     ,
  section_sequence_id           BIGINT     ,
  statement_type                VARCHAR(3) ,
  report_section_description    STRING)
CLUSTERED BY (accession_number_int) 
INTO 16 BUCKETS
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://dataset.secdatabase.com/sec_financial_statements/parquet/report_presentation_section'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'parquet.compression'='SNAPPY');  

