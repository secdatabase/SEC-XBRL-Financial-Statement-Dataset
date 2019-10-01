CREATE EXTERNAL TABLE sec_financial_statements.report_presentation_line_item(
  accession_number_int      BIGINT        ,
  section_sequence_id       BIGINT        ,
  line_item_sequence        INT           ,
  parent_datapoint_name     VARCHAR(1024) ,
  datapoint_name            VARCHAR(1024) ,
  preferred_label_role      VARCHAR(1024) ,
  datapoint_label           STRING        ,
  datapoint_id              BIGINT)
CLUSTERED BY (accession_number_int) 
INTO 240 BUCKETS
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://dataset.secdatabase.com/sec_financial_statements/parquet/report_presentation_line_item'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'parquet.compression'='SNAPPY');
