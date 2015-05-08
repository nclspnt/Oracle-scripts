@display_configuration.sql
set longc 1000000 long 1000000
SET LINESIZE 1000
SET PAGESIZE 0
SET TRIM ON
SET TRIMSPOOL ON
SET ECHO OFF
SET FEEDBACK OFF

def v_sql_id="&sql_id."

col v_curr_date new_value v_curr_date  
select ''||to_char(sysdate, 'yy_mm_dd_hh24_mi') v_curr_date from dual ;

spool sql_detail_&v_sql_id._&v_curr_date..html

select DBMS_SQLTUNE.REPORT_SQL_DETAIL( sql_id => '&v_sql_id.', report_level => 'ALL' ) from dual ;

spool off


prompt spool file is 'sql_detail_&v_sql_id._&v_curr_date..html'