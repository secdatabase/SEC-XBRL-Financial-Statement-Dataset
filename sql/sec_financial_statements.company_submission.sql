CREATE EXTERNAL TABLE sec_financial_statements.company_submission(
  accession_number_int                               BIGINT       , -- The integer version of accession number
  accession_number                                   CHAR(20)     , -- The 20-character string assigned by the SEC to each EDGAR submission
  cik                                                INT          , -- Central Index Key
  company_name                                       VARCHAR(150) ,
  filing_date                                        DATE         ,
  document_type                                      VARCHAR(15)  ,
  document_period_end_date                           DATE         ,
  current_fiscal_year_end_date                       VARCHAR(7)   ,
  document_fiscal_year_focus                         INT          ,
  document_fiscal_period_focus                       VARCHAR(2)   ,
  current_fiscal_year_end_month                      INT          ,
  amendment_flag                                     BOOLEAN      ,
  assigned_sic                                       INT          , -- Standard Industrial Classification
  irs_number                                         VARCHAR(10)  ,
  state_of_incorporation                             VARCHAR(2)   ,
  mailing_address_street1                            VARCHAR(40)  ,
  mailing_address_street2                            VARCHAR(40)  ,
  mailing_address_city                               VARCHAR(30)  ,
  mailing_address_state                              VARCHAR(2)   ,
  mailing_address_zip                                VARCHAR(10)  ,
  business_address_street1                           VARCHAR(40)  ,
  business_address_street2                           VARCHAR(40)  ,
  business_address_city                              VARCHAR(30)  ,
  business_address_state                             VARCHAR(2)   ,
  business_address_zip                               VARCHAR(10)  ,
  mailing_phone_number                               VARCHAR(20)  ,
  business_phone_number                              VARCHAR(20))
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://dataset.secdatabase.com/sec_financial_statements/parquet/company_submission'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'parquet.compression'='SNAPPY');
  
