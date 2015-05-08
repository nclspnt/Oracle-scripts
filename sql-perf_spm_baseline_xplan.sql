@display_configuration.sql


select *
from table(DBMS_XPLAN.DISPLAY_SQL_PLAN_BASELINE( sql_handle => '&sql_handle.' , plan_name => '&plan_name.' ) )
;
