@display_configuration.sql


alter session set nls_date_format="DD.MM.YYYY" ;


select
trunc(BEGIN_INTERVAL_TIME,'DD') WHEN, 
PARSING_SCHEMA_NAME,
sum(EXECUTIONS_DELTA) EXECUTIONS_DELTA,
round(sum(ELAPSED_TIME_DELTA)/1000000/60) ELAPSED_TIME_DELTA
from DBA_HIST_SQLSTAT x,
dba_hist_snapshot y
where x.SNAP_ID = y.SNAP_ID
and BEGIN_INTERVAL_TIME >= sysdate - &days_before.
and PARSING_SCHEMA_NAME = '&username.' 
group by trunc(BEGIN_INTERVAL_TIME,'DD') , PARSING_SCHEMA_NAME
order by 1;
