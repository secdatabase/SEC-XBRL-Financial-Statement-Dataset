-- alter the tables location to point to the latest data set.

-- run the sql statement one by one in Athena.

ALTER TABLE sec_financial_statements.company_submission
SET location 's3://dataset.secdatabase.com/sec_financial_statements/parquet/20200930/company_submission';

ALTER TABLE sec_financial_statements.report_presentation_section
SET location 's3://dataset.secdatabase.com/sec_financial_statements/parquet/20200930/report_presentation_section';

ALTER TABLE sec_financial_statements.data_point
SET location 's3://dataset.secdatabase.com/sec_financial_statements/parquet/20200930/data_point';

ALTER TABLE sec_financial_statements.data_point_snapshot
SET location 's3://dataset.secdatabase.com/sec_financial_statements/parquet/20200930/data_point_snapshot';

ALTER TABLE sec_financial_statements.data_point_revision
SET location 's3://dataset.secdatabase.com/sec_financial_statements/parquet/20200930/data_point_revision';

ALTER TABLE sec_financial_statements.report_presentation_line_item
SET location 's3://dataset.secdatabase.com/sec_financial_statements/parquet/20200930/report_presentation_line_item';

ALTER TABLE sec_financial_statements.segment
SET location 's3://dataset.secdatabase.com/sec_financial_statements/parquet/20200930/segment';
