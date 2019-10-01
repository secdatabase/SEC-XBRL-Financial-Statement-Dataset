## 1. company_submission

 Data Point                    | Data Type    |Key| Description                                      
 ------------------------------|--------------|---|--------------------
 accession_number_int          | BIGINT       |*  |The integer version of accession number, used as the key.
 accession_number              | CHAR(20)     |   |The 20-character string assigned by the SEC to each EDGAR submission to each EDGAR submission.
 cik                           | INT          |   |Central Index Key (CIK). Ten digit number assigned by the Commission to each registrant that submits filings.
 company_name                  | VARCHAR(150) |   |Name of registrant. This corresponds to the name of the legal entity as recorded in EDGAR as of the filing date.
 filing_date                   | DATE         |   |The date of the registrant's filing with the Commission.
 document_type                 | VARCHAR(15)  |   |The submission type of the registrant's filing
 document_period_end_date      | DATE         |   |Balance Sheet Date.
 current_fiscal_year_end_date  | VARCHAR(7)   |   |Fiscal Year End Date.
 document_fiscal_year_focus    | INT          |   |Fiscal Year Focus (as defined in EFM Ch. 6).
 document_fiscal_period_focus  | VARCHAR(2)   |   |Fiscal Period Focus (as defined in EFM Ch. 6) within Fiscal Year. The 10-Q for the 1st, 2nd and 3rd quarters would have a fiscal period focus of Q1, Q2 (or H1), and Q3 (or M9) respectively, and a 10-K would have a fiscal period focus of FY.
 current_fiscal_year_end_month | INT          |   |Current Fiscal Year End Month.
 amendment_flag                | BOOLEAN      |   |If the submission is an amendment to previous filings.
 assigned_sic                  | INT          |   |Standard Industrial Classification (SIC). Four digit code assigned by the Commission as of the filing date, indicating the registrant's type of business.
 irs_number                    | VARCHAR(10)  |   |Employee Identification Number, 9 digit identification number assigned by the Internal Revenue Service to business entities operating in the United States.
 state_of_incorporation        | VARCHAR(2)   |   |The state or province of incopration, if the country is within US or CA.
 mailing_address_street1       | VARCHAR(40)  |   |The first line of the street of the registrant's mailing address.
 mailing_address_street2       | VARCHAR(40)  |   |The second line of the street of the registrant's mailing address.
 mailing_address_city          | VARCHAR(30)  |   |The city of the registrant's mailing address.
 mailing_address_state         | VARCHAR(2)   |   |The state or province of the registrant's mailing address, if field mailing country is US or CA.
 mailing_address_zip           | VARCHAR(10)  |   |The zip code of the registrant's mailing address.
 business_address_street1      | VARCHAR(40)  |   |The first line of the street of the registrant's business address.
 business_address_street2      | VARCHAR(40)  |   |The second line of the street of the registrant's business address.
 business_address_city         | VARCHAR(30)  |   |The city of the registrant's business address.
 business_address_state        | VARCHAR(2)   |   |The state or province of the registrant's business address, if field business country is US or CA.
 business_address_zip          | VARCHAR(10)  |   |The zip code of the registrant's business address.
 mailing_phone_number          | VARCHAR(20)  |   |The phone number of the registrant's mailing address.
 business_phone_number         | VARCHAR(20)  |   |The phone number of the registrant's business address.


## 2. data_point

 Data Point                    | Data Type    |Key| Description                                      
 ------------------------------|--------------|---|--------------------
  cik                          |INT           |   |Central Index Key (CIK). Ten digit number assigned by the Commission to each registrant that submits filings.
  accession_number_int         |BIGINT        |   |The integer version of accession number.
  filing_date                  |DATE          |   |The date of the registrant's filing with the Commission.
  datapoint_id                 |BIGINT        | * |Internal id used by secdatabase.com to track each data point.
  datapoint_name               |VARCHAR(1024) |   |The unique identifier (name) for a data point in a specific taxonomy release.
  version                      |VARCHAR(50)   |   |For a standard data point in a specific taxonomy, an identifier for the taxonomy.
  segment_label                |VARCHAR(1000) |   |The label for the segment.
  segment_hash                 |VARCHAR(50)   |   |The hexadecimal key for the dimensional-segment information in the Segment data set. Can be used to identify same segment across different submissions.
  start_date                   |DATE          |   |The period start date for the data value.
  end_date                     |DATE          |   |The period end date for the data value.
  period_month                 |BIGINT        |   |The count of the number of months represented by the data value, rounded to the nearest whole number.
  string_value                 |STRING        |   |The data value in string format as reported.
  numeric_value                |DOUBLE        |   |The numeric format of the data value, if it is a number. It is stored in double precision to be used for calculation.
  decimals                     |INT           |   |The value of the fact "decimals" attribute, to indicate the rounding of the data value.
  unit                         |STRING        |   |The unit for the data value
  footnotes                    |STRING	      |   |The plain text of any superscripted footnotes on the value, if any, as shown on the statement page. No truncation.


## 3.data_point_snapshot

 Data Point             | Data Type    |Key| Description                                      
 -----------------------|--------------|---|--------------------
  cik                   | INT          |  |Central Index Key (CIK). Ten digit number assigned by the Commission to each registrant that submits filings.
  accession_number_int  | BIGINT       |  |The integer version of accession number.
  filing_date           | DATE         |  |The date of the registrant's filing with the Commission.
  datapoint_id          | BIGINT       |* |Internal id used by secdatabase.com to track each data point.
  datapoint_name        | VARCHAR(1024)|  |The unique identifier (name) for a data point in a specific taxonomy release.
  version               | VARCHAR(50)  |  |For a standard data point in a specific taxonomy, an identifier for the taxonomy.
  segment_label         | VARCHAR(1000)|  |The label for the segment.
  segment_hash          | VARCHAR(50)  |  |The hexadecimal key for the dimensional-segment information in the Segment data set. Can be used to identify same segment across different submissions.
  start_date            | DATE         |  |The period start date for the data value.
  end_date              | DATE         |  |The period end date for the data value.
  period_month          | BIGINT       |  |The count of the number of months represented by the data value, rounded to the nearest whole number.
  string_value          | STRING       |  |The data value in string format as reported.
  numeric_value         | DOUBLE       |  |The numeric format of the data value, if it is a number. It is stored in double precision to be used for calculation.
  decimals              | INT          |  |The value of the fact "decimals" attribute, to indicate the rounding of the data value.
  unit                  | STRING       |  |The unit for the data value
  footnotes             | STRING       |  |The plain text of any superscripted footnotes on the value, if any, as shown on the statement page. No truncation.
  revision_num          | BIGINT)      |  |The number of revision for the data points. Revisions can be found at data_point_revision data set.

## 4.report_presentation_section

 Data Point                    | Data Type   |Key| Description                                      
 ------------------------------|-------------|---|--------------------
  cik                          | INT         |   | Central Index Key (CIK). Ten digit number assigned by the Commission to each registrant that submits filings.
  filing_date                  | DATE        |   | The date of the registrant's filing with the Commission.
  accession_number_int         | BIGINT      | * | The integer version of accession number.
  section_sequence_id          | BIGINT      | * | The sequential number indicates the as reported section order within a report. Together with accession_number_int to uniquely identify each section.
  statement_type               | VARCHAR(3)  |   | The financial statement location to which the value of the "report" field pertains. ()
  report_section_description   | STRING      |   | The description for the reported section.


##  5.report_presentation_line_item

 Data Point                    | Data Type    |Key| Description                                      
 ------------------------------|--------------|---|--------------------
  accession_number_int         | BIGINT       | * | The integer version of accession number.
  section_sequence_id          | BIGINT       | * | The sequential number indicates the as reported section order within a report. Together with accession_number_int to uniquely identify each section.
  line_item_sequence           | INT          | * | Represents the data point's presentation line order for a given section.
  parent_datapoint_name        | VARCHAR(1024)|   | The nique identifier (name) for parent of the data point, in the tree structure presentation.
  datapoint_name               | VARCHAR(1024)|   | The unique identifier (name) for a data point in a specific taxonomy release.
  preferred_label_role         | VARCHAR(1024)|   | The prefered label role in the report.
  datapoint_label              | STRING       |   | The prefered label for the data point.
  datapoint_id                 | BIGINT       |   | Internal id used by secdatabase.com to track each data point.
  

## 6. segment
 Data Point                    | Data Type    |Key| Description                                      
 ------------------------------|--------------|---|--------------------
  segment_hash                 | VARCHAR(50)  |*  | The hexadecimal key for the dimensional-segment information. Can be used to identify same segment across different submissions.
  segment                      | VARCHAR(1000)|   | The string version of the dimensional-segment information.

## 7. data_point_revision
 Data Point                    | Data Type    |Key| Description                                      
 ------------------------------|--------------|---|--------------------
  datapoint_id                 |  BIGINT      | * | Internal id used by secdatabase.com to track each data point.
  accession_number_int         |  BIGINT      | * | The integer version of accession number.
  filing_date                  |  DATE        |   | The date of the registrant's filing with the Commission.
  string_value                 |  STRING      |   | The data value in string format as reported.
  numeric_value                |  DOUBLE      |   | The numeric format of the data value, if it is a number. It is stored in double precision to be used for calculation.
