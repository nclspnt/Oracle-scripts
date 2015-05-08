@display_configuration.sql

select 
SQL_ID,
PARSING_SCHEMA_NAME,
HASH_VALUE,
CHILD_NUMBER,
ELAPSED_TIME,
EXECUTIONS,
PLAN_HASH_VALUE,
LAST_LOAD_TIME,
SQL_TEXT
from gv$sql
where sql_id = '&sql_id.' 
;