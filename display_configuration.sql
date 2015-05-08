-- sqlplus parameters
set LINES 2000 PAGES 2000 head on feedback on
col SID format 9999
col INST_ID format 9
col SERIAL# format 999999
col USERNAME format a30
col HOST_NAME format a10
col OSUSER format A20
col MODULE format A40
col SQL_PROFILE format A64
col SQL_PLAN_BASELINE format A30
col LAST_CALL_ET format 9999999
col WAIT_CLASS format a15
col WAIT_TIME format 99999
col STATE format A19
col STATUS format A20
col WAITS format A30
col VALUE format A50
col EVENT format A50
col EVENT_NAME format A50
col SQL_ID format A15
col TABLESPACE_NAME format a30
col FILE_NAME format a70
col TOTGO format 99999.99
col MAXEXTGO format 99999.99
col AUTOEXTENSIBLE format a5
col USED_PERCENT format 99.99
col INDEX_NAME  format a30
col TABLE_NAME  format a30
col UNIUENES    format a12
col COLUMN_NAME format a30
col COLUMN_POSITION format 99999999
col PLAN_HASH_VALUE format 999999999999999
col executions format 999999999999
col ETIME format 999999999999.99
col AVG_ETIME format 999999999999.99



-- session parameters
alter session set nls_date_format="YY.MM.DD HH24:MI" ;
