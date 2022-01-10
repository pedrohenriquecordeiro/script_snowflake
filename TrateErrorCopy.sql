 // Create new stage which contains a file with errors
 CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage_errorex
    url='s3://bucketsnowflakes4'
 
 
 // Create example table
 CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));
 
 // Demonstrating error message
 COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv');
    
// erro message : 
// Numeric value 'one thousand' is not recognized File 'OrderDetails_error.csv', 
// line 2, character 14 Row 1, column "ORDERS_EX"["PROFIT":3] If you would like to continue loading 
// when an error is encountered, use other values such as 'SKIP_FILE' or 'CONTINUE' for the ON_ERROR option. 
// For more information on loading options, please run 'info loading_data' in a SQL client.

  
// Error handling using the CONTINUE - jump rows with erro
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv')
    ON_ERROR = 'CONTINUE'; 
    

// Error handling using the ABORT_STATEMENT (default) - break all process
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'ABORT_STATEMENT';


// Error handling using the SKIP_FILE - skip file that contains a erro
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE';
    
    
// Error handling using the SKIP_FILE_<number> - skip file that contains a <number> erros
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE_2';    
    
     
// Error handling using the SKIP_FILE_<number> - skip file that contains <percentage of total>% error
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE_0.5%'; 
  



