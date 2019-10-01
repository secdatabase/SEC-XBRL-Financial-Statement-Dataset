# SEC-XBRL-Financial-Statement-Dataset
## *Optimized for Athena and Redshift Spectrum Access*

The SEC Financial Statement Dataset provides the text and detailed numeric information from all financial statements and their full notes. The Dataset is extracted from corporate annual and quarterly reports filed with the SEC using XBRL since January 2009. 

The data sets have been optimized in both table structures and storage format to be used specifically in AWS big data eco-system. SECDatabase.com evaluated multiple cloud platforms, and found that Athena, Redshift, and Glue really unleash our productivities.

## Who build the dataset
[SECDatabase.com](https://www.secdatabase.com) created dataset, and updated it regularly for the community.

## How is this dataset different from [dataset](https://console.cloud.google.com/marketplace/details/sec-public-data-bq/sec-public-dataset) hosted on Google Cloud Platform
The dataset on Google Bigquery is based on Dataset published by SEC (See next section), and is stale - the latest filing data is as of June 2018.

## How the dataset is different from dataset on SEC website
SECDatabase.com initially use the dataset published by SEC first but unfortunately it has many limitations. SECDatabase.com eventually decide to build a new, complete dataset in an easy to consume format. This dataset has numerous improvements over the dataset on SEC website in the aspects of data accuracy, coverage, and ease of data usage. Here are some examples:
1. text and notes data are in full-length without truncation. The dataset published by SEC trimmed footnote to 512 chars, and string value to 2048 chars only.
2. Report segment information are added to the data points directly.
3. Include the start_date and end_date for each data point to reflect the period more accurately.
4. Eliminated the needs to understand the convoluted XBRL convention as much as possible, so that Data Scientist can focus on the data itself to derived the value.
5. Support the tracing of the data point back to its original filing and specific section.
6. Support the tracing of data point revision.


## How large is the dataset
As of August 31, 2019, the dataset covers:
1. All XBRL filings since 2009.
2. 12.6k companies.
3. 239.7k annual and quarterly reports.
4. 192.5 million data points.
5. 20GB+ compressed in Parquet.

# How to access dataset via Athena
## 1. Signing in your AWS Account, and go to Athena Query Editor page.
![image](https://user-images.githubusercontent.com/55612745/65563569-a22ef280-df0f-11e9-8927-b94b3d83d348.png)

## 2. Copy the content in _sec_financial_statements.sql_ file to Query Editor window, and click **Run query** to create the Athena Database **sec_financial_statements**:
```
  CREATE DATABASE sec_financial_statements;
```
## 3. In the same way, copy the contents from the following table scripts, and run them one by one.

```
  sec_financial_statements.company_submission.sql
  sec_financial_statements.report_presentation_section.sql
  sec_financial_statements.data_point.sql
  sec_financial_statements.data_point_snapshot.sql
  sec_financial_statements.data_point_revision.sql
  sec_financial_statements.report_presentation_line_item.sql
  sec_financial_statements.segment.sql
  ```

## How to download the data in txt format using Athena
With Athena you can easily convert the data in the tables, or the query results, to CSV/TSV and store them in your own S3 bucket. For example, the following Athena query will store the content in table _company_submission_ a tsv file in S3:
```
CREATE TABLE sec_financial_statements.company_submission_tsv
  WITH (
      format = 'textfile'
      ,external_location = 's3://path/to/your/bucket/folder/'
      ,field_delimiter ='\t'
      ) AS
  SELECT * FROM sec_financial_statements.company_submission
```

## How to Access the Data using Redshift Spectrum
Once you have completed the steps of setting up the database and tables in Athena, you can simply reference it through Redshift Spectrum. You can run the following query in Redshift:

```
CREATE EXTERNAL SCHEMA sec_financial_statements
FROM data CATALOG DATABASE 'sec_financial_statements' iam_role 'arn:aws:iam::your-account-number:role/your-role-used-by-redshift'
```
You will see the redshift spectrum sec_financial_statements is created with all the tables under it.


# Table Contents
## 1. company_submission

The submissions data set contains summary information about an entire EDGAR submission. Some fields were sourced directly from EDGAR submission information, while other fields of data were sourced from the XBRL submission. Description of each field can be foud in the table schema file.

Let's use filings for [CHEVRON CORP](https://research.secdatabase.com/CIK/93410/Company-Name/CHEVRON-CORP) as example, let's find all the Annual Reports for Chevron in this dataset:
```
SELECT *
FROM sec_financial_statements.company_submission
WHERE company_name LIKE '%CHEVRON%'
	AND document_type = '10-K'
ORDER BY filing_date DESC
```
There are 10 Annual Reports filed to SEC from 2010-02-25 to 2019-02-22

```
accession_number_int|accession_number    |cik  |company_name|filing_date|document_type|document_period_end_date|current_fiscal_year_end_date|document_fiscal_year_focus|document_fiscal_period_focus|current_fiscal_year_end_month|amendment_flag|assigned_sic|irs_number|state_of_incorporation|mailing_address_street1   |mailing_address_street2|mailing_address_city|mailing_address_state|mailing_address_zip|business_address_street1  |business_address_street2|business_address_city|business_address_state|business_address_zip|mailing_phone_number|business_phone_number|
--------------------|--------------------|-----|------------|-----------|-------------|------------------------|----------------------------|--------------------------|----------------------------|-----------------------------|--------------|------------|----------|----------------------|--------------------------|-----------------------|--------------------|---------------------|-------------------|--------------------------|------------------------|---------------------|----------------------|--------------------|--------------------|---------------------|
       9341019000008|0000093410-19-000008|93410|CHEVRON CORP| 2019-02-22|10-K         |              2018-12-31|--12-31                     |                      2018|FY                          |                           12|false         |        2911|940890210 |DE                    |6001 BOLLINGER CANYON ROAD|                       |SAN RAMON           |CA                   |94583              |6001 BOLLINGER CANYON ROAD|                        |SAN RAMON            |CA                    |94583               |                    |925-842-1000         |
       9341018000010|0000093410-18-000010|93410|CHEVRON CORP| 2018-02-22|10-K         |              2017-12-31|--12-31                     |                      2017|FY                          |                           12|false         |        2911|940890210 |DE                    |6001 BOLLINGER CANYON ROAD|                       |SAN RAMON           |CA                   |94583              |6001 BOLLINGER CANYON ROAD|                        |SAN RAMON            |CA                    |94583               |                    |925-842-1000         |
       9341017000013|0000093410-17-000013|93410|CHEVRON CORP| 2017-02-23|10-K         |              2016-12-31|--12-31                     |                      2016|FY                          |                           12|false         |        2911|940890210 |DE                    |6001 BOLLINGER CANYON ROAD|                       |SAN RAMON           |CA                   |94583              |6001 BOLLINGER CANYON ROAD|                        |SAN RAMON            |CA                    |94583               |                    |925-842-2815         |
       9341016000049|0000093410-16-000049|93410|CHEVRON CORP| 2016-02-25|10-K         |              2015-12-31|--12-31                     |                      2015|FY                          |                           12|false         |        2911|940890210 |DE                    |6001 BOLLINGER CANYON ROAD|                       |SAN RAMON           |CA                   |94583              |6001 BOLLINGER CANYON ROAD|                        |SAN RAMON            |CA                    |94583               |                    |925-842-1000         |
       9341015000010|0000093410-15-000010|93410|CHEVRON CORP| 2015-02-20|10-K         |              2014-12-31|--12-31                     |                      2014|FY                          |                           12|false         |        2911|940890210 |DE                    |6001 BOLLINGER CANYON ROAD|                       |SAN RAMON           |CA                   |94583              |6001 BOLLINGER CANYON ROAD|                        |SAN RAMON            |CA                    |94583               |                    |925-842-1000         |
       9341014000011|0000093410-14-000011|93410|CHEVRON CORP| 2014-02-21|10-K         |              2013-12-31|--12-31                     |                      2013|FY                          |                           12|false         |        2911|940890210 |DE                    |6001 BOLLINGER CANYON ROAD|                       |SAN RAMON           |CA                   |94583              |6001 BOLLINGER CANYON ROAD|                        |SAN RAMON            |CA                    |94583               |                    |925-842-1000         |
       9341013000003|0000093410-13-000003|93410|CHEVRON CORP| 2013-02-22|10-K         |              2012-12-31|--12-31                     |                      2012|FY                          |                           12|false         |        2911|940890210 |DE                    |6001 BOLLINGER CANYON ROAD|                       |SAN RAMON           |CA                   |94583              |6001 BOLLINGER CANYON ROAD|                        |SAN RAMON            |CA                    |94583               |                    |925-842-1000         |
      95012312002976|0000950123-12-002976|93410|CHEVRON CORP| 2012-02-23|10-K         |              2011-12-31|--12-31                     |                      2011|FY                          |                           12|false         |        2911|940890210 |DE                    |6001 BOLLINGER CANYON ROAD|                       |SAN RAMON           |CA                   |94583              |6001 BOLLINGER CANYON ROAD|                        |SAN RAMON            |CA                    |94583               |                    |925-842-1000         |
      95012311017688|0000950123-11-017688|93410|CHEVRON CORP| 2011-02-24|10-K         |              2010-12-31|--12-31                     |                      2010|FY                          |                           12|false         |        2911|940890210 |DE                    |6001 BOLLINGER CANYON ROAD|                       |SAN RAMON           |CA                   |94583              |6001 BOLLINGER CANYON ROAD|                        |SAN RAMON            |CA                    |94583               |                    |925-842-1000         |
      95012310016846|0000950123-10-016846|93410|CHEVRON CORP| 2010-02-25|10-K         |              2009-12-31|--12-31                     |                          |                            |                           12|false         |        2911|940890210 |DE                    |6001 BOLLINGER CANYON ROAD|                       |SAN RAMON           |CA                   |94583              |6001 BOLLINGER CANYON ROAD|                        |SAN RAMON            |CA                    |94583               |                    |925-842-1000         |
```
When we navigate the filings at https://research.secdatabase.com/CIK/93410/Company-Name/CHEVRON-CORP, we can confirm all the Annual Reports before year 2010 are not in XBRL format, and thus not covered by this data set. 

## 2. report_presentation_section
This table contains all the sections within a given report. For example, for the Annual Reported filed on 2019-02-22, the accession_number_int = 9341019000008:
```
SELECT *
FROM sec_financial_statements.report_presentation_section
WHERE accession_number_int = 9341019000008
ORDER BY section_sequence_id
```
Here are the top 10 records:
```
cik  |filing_date|accession_number_int|section_sequence_id|statement_type|report_section_description                                                   |
-----|-----------|--------------------|-------------------|--------------|-----------------------------------------------------------------------------|
93410| 2019-02-22|       9341019000008|                  1|              |Document - Document and Entity Information                                   |
93410| 2019-02-22|       9341019000008|                  2|I             |Statement - Consolidated Statement of Income                                 |
93410| 2019-02-22|       9341019000008|                  3|IP            |Statement - Consolidated Statement of Income (Parenthetical)                 |
93410| 2019-02-22|       9341019000008|                  4|CI            |Statement - Consolidated Statement of Comprehensive Income                   |
93410| 2019-02-22|       9341019000008|                  5|B             |Statement - Consolidated Balance Sheet                                       |
93410| 2019-02-22|       9341019000008|                  6|BP            |Statement - Consolidated Balance Sheet (Parenthetical)                       |
93410| 2019-02-22|       9341019000008|                  7|C             |Statement - Consolidated Statement of Cash Flows                             |
93410| 2019-02-22|       9341019000008|                  8|SE            |Statement - Consolidated Statement of Equity                                 |
93410| 2019-02-22|       9341019000008|                  9|SEP           |Statement - Consolidated Statement of Equity (Parenthetical)                 |
93410| 2019-02-22|       9341019000008|                 10|              |Disclosure - Summary of Significant Accounting Policies                      |
```

You can see the same [section sequence](https://www.sec.gov/cgi-bin/viewer?action=view&cik=93410&accession_number=0000093410-19-000008):
![image](https://user-images.githubusercontent.com/55612745/65810940-cc361e00-e176-11e9-8639-d7af9cc4784f.png)

We want to point out that we use the following statement(section) type abbreviation:
```
I     -  Statement of Income
IP    -  Statement of Income (Parenthetical)
CI    -  Statement of Comprehensive Income
CIP   -  Statement of Comprehensive Income (Parenthetical)
B     -  Balance Sheet
BP    -  Balance Sheet (Parenthetical)
C     -  Statement of Cash Flows
CP    -  Statement of Cash Flows (Parenthetical)
SE    -  Statement of Equity
SEP   -  Statement of Equity (Parenthetical)
```
The data dictionary can be found in docs folder.

## 3. data_point
This table contains all the data point and values since the first XBRL filing in 2009. Using CHEVRON CORP (cik= 93410), let's find its filing history for total current asset (AssetsCurrent) as of Dec 31, 2015
```
SELECT *
FROM sec_financial_statements.data_point
WHERE cik = 93410
	AND datapoint_name = 'AssetsCurrent'
	AND end_date = cast('2015-12-31' AS DATE)
	AND segment_hash IS NULL
```
We can see the data point were shown 5 time in different filings:
```
cik  |accession_number_int|filing_date|datapoint_id|datapoint_name|version     |segment_label|segment_hash|start_date|end_date  |period_month|string_value|numeric_value|decimals|unit|footnotes|
-----|--------------------|-----------|------------|--------------|------------|-------------|------------|----------|----------|------------|------------|-------------|--------|----|---------|
93410|       9341017000013| 2017-02-23|   806133190|AssetsCurrent |us-gaap/2016|             |            |          |2015-12-31|            |34430000000 |     3.443E10|      -6|USD |         |
93410|       9341016000083| 2016-11-03|   770339982|AssetsCurrent |us-gaap/2016|             |            |          |2015-12-31|            |34430000000 |     3.443E10|      -6|USD |         |
93410|       9341016000070| 2016-08-04|   716548821|AssetsCurrent |us-gaap/2016|             |            |          |2015-12-31|            |34430000000 |     3.443E10|      -6|USD |         |
93410|       9341016000056| 2016-05-05|   688429758|AssetsCurrent |us-gaap/2015|             |            |          |2015-12-31|            |34430000000 |     3.443E10|      -6|USD |         |
93410|       9341016000049| 2016-02-25|   646793196|AssetsCurrent |us-gaap/2015|             |            |          |2015-12-31|            |35347000000 |    3.5347E10|      -6|USD |         |
```


## 4. report_presentation_line_item
The table contains the line item sequence for each report section. The data points grouping and relationship can be found here. Thare are many important usage with this table. For example, let's try to get the Document and Entity Information of 10K report for Chevron filed in Feb 2019 (accession_number_int = 9341019000008, section_sequence_id = 1):


```
SELECT li.parent_datapoint_name
	,datapoint_label
	,end_date
	,start_date
	,period_month
	,dp.string_value
FROM sec_financial_statements.report_presentation_line_item li
INNER JOIN sec_financial_statements.data_point dp
	ON li.datapoint_id = dp.datapoint_id
WHERE li.accession_number_int = 9341019000008
	AND section_sequence_id = 1
ORDER BY line_item_sequence ASC
	,end_date DESC
```

You can see the result matches the screenshot:
```
parent_datapoint_name               |datapoint_label                        |end_date  |start_date|period_month|string_value           |
------------------------------------|---------------------------------------|----------|----------|------------|-----------------------|
DocumentAndEntityInformationAbstract|Entity Registrant Name                 |2018-12-31|2018-01-01|          12|CHEVRON CORP           |
DocumentAndEntityInformationAbstract|Entity Central Index Key               |2018-12-31|2018-01-01|          12|0000093410             |
DocumentAndEntityInformationAbstract|Document Type                          |2018-12-31|2018-01-01|          12|10-K                   |
DocumentAndEntityInformationAbstract|Document Period End Date               |2018-12-31|2018-01-01|          12|2018-12-31             |
DocumentAndEntityInformationAbstract|Amendment Flag                         |2018-12-31|2018-01-01|          12|false                  |
DocumentAndEntityInformationAbstract|Entity Emerging Growth Company         |2018-12-31|2018-01-01|          12|false                  |
DocumentAndEntityInformationAbstract|Entity Small Business                  |2018-12-31|2018-01-01|          12|false                  |
DocumentAndEntityInformationAbstract|Document Fiscal Year Focus             |2018-12-31|2018-01-01|          12|2018                   |
DocumentAndEntityInformationAbstract|Document Fiscal Period Focus           |2018-12-31|2018-01-01|          12|FY                     |
DocumentAndEntityInformationAbstract|Current Fiscal Year End Date           |2018-12-31|2018-01-01|          12|--12-31                |
DocumentAndEntityInformationAbstract|Entity Well-known Seasoned Issuer      |2018-12-31|2018-01-01|          12|Yes                    |
DocumentAndEntityInformationAbstract|Entity Voluntary Filers                |2018-12-31|2018-01-01|          12|No                     |
DocumentAndEntityInformationAbstract|Entity Current Reporting Status        |2018-12-31|2018-01-01|          12|Yes                    |
DocumentAndEntityInformationAbstract|Entity Filer Category                  |2018-12-31|2018-01-01|          12|Large Accelerated Filer|
DocumentAndEntityInformationAbstract|Entity Public Float                    |2018-06-29|          |            |242200000000           |
DocumentAndEntityInformationAbstract|Entity Common Stock, Shares Outstanding|2019-02-11|          |            |1900062760             |
DocumentAndEntityInformationAbstract|Entity Shell Company                   |2018-12-31|2018-01-01|          12|false                  |

```

## 5. segment
Segment table will provide more information for the segment defined. Using Annual Report for CHEVRON CORP filed on  as eample, let's find its segment information for ProfitLoss:


```
SELECT cik, accession_number_int, filing_date, datapoint_name, end_date, start_date, period_month, string_value, segment_label, s.segment
FROM sec_financial_statements.data_point dp
INNER JOIN sec_financial_statements.segment s
	ON dp.segment_hash = s.segment_hash
WHERE dp.accession_number_int = 9341019000008
	AND end_date = cast('2018-12-31' AS DATE)
	AND datapoint_name LIKE '%ProfitLoss'

```
We can see three segment brekdowns:
```
cik  |accession_number_int|filing_date|datapoint_name|end_date  |start_date|period_month|string_value|segment_label           |segment                                         |
-----|--------------------|-----------|--------------|----------|----------|------------|------------|------------------------|------------------------------------------------|
93410|       9341019000008| 2019-02-22|ProfitLoss    |2018-12-31|2018-01-01|          12|14824000000 |Parent                  |StatementEquityComponents=Parent                |
93410|       9341019000008| 2019-02-22|ProfitLoss    |2018-12-31|2018-01-01|          12|36000000    |Noncontrolling Interests|StatementEquityComponents=NoncontrollingInterest|
93410|       9341019000008| 2019-02-22|ProfitLoss    |2018-12-31|2018-01-01|          12|14824000000 |Retained Earnings       |StatementEquityComponents=RetainedEarnings      |
```

## 6. data_point_snapshot
This information in this table is derived from as reported data_point table. Each data point will have only one last effective value at its earliest reporting date. 
Let's use the AssetsCurrent as of 2015-12-31 for CHAVRON CORP again. In data_point table we have:

```
cik  |accession_number_int|filing_date|datapoint_id|datapoint_name|version     |segment_label|segment_hash|start_date|end_date  |period_month|string_value|numeric_value|decimals|unit|footnotes|
-----|--------------------|-----------|------------|--------------|------------|-------------|------------|----------|----------|------------|------------|-------------|--------|----|---------|
93410|       9341017000013| 2017-02-23|   806133190|AssetsCurrent |us-gaap/2016|             |            |          |2015-12-31|            |34430000000 |     3.443E10|      -6|USD |         |
93410|       9341016000083| 2016-11-03|   770339982|AssetsCurrent |us-gaap/2016|             |            |          |2015-12-31|            |34430000000 |     3.443E10|      -6|USD |         |
93410|       9341016000070| 2016-08-04|   716548821|AssetsCurrent |us-gaap/2016|             |            |          |2015-12-31|            |34430000000 |     3.443E10|      -6|USD |         |
93410|       9341016000056| 2016-05-05|   688429758|AssetsCurrent |us-gaap/2015|             |            |          |2015-12-31|            |34430000000 |     3.443E10|      -6|USD |         |
93410|       9341016000049| 2016-02-25|   646793196|AssetsCurrent |us-gaap/2015|             |            |          |2015-12-31|            |35347000000 |    3.5347E10|      -6|USD |         |
```
Let's take a look at data_point_snapshot:

```
SELECT *
FROM sec_financial_statements.data_point_snapshot
WHERE cik = 93410
	AND datapoint_name = 'AssetsCurrent'
	AND end_date = cast('2015-12-31' AS DATE)
	AND segment_hash IS NULL
```
You can see only the the last value changes on 2016-05-05 are kept:
```
cik  |accession_number_int|filing_date|datapoint_id|datapoint_name|version     |segment_label|segment_hash|start_date|end_date  |period_month|string_value|numeric_value|decimals|unit|footnotes|revision_num|
-----|--------------------|-----------|------------|--------------|------------|-------------|------------|----------|----------|------------|------------|-------------|--------|----|---------|------------|
93410|       9341016000056| 2016-05-05|   688429758|AssetsCurrent |us-gaap/2015|             |            |          |2015-12-31|            |34430000000 |     3.443E10|      -6|USD |         |           1|
```
So where is  the value as of 2016-02-25? Actually it is kept in the revision history in next table:

## 7. data_point_revision
This table will archive all the revised/restated value. As in the previous example, we use its datapoint_id to find its revision history:

```
SELECT *
FROM sec_financial_statements.data_point_revision
WHERE datapoint_id = 688429758

```
We can see the value before the revision, and the correspoinding report:
```
datapoint_id|accession_number_int|filing_date|string_value|numeric_value|
------------|--------------------|-----------|------------|-------------|
   688429758|       9341016000049| 2016-02-25|35347000000 |    3.5347E10|
```
