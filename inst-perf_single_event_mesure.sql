@display_configuration.sql

prompt db file async I/O submit
prompt db file parallel read
prompt db file parallel write
prompt db file scattered read
prompt db file sequential read
prompt db file single write
prompt direct path read
prompt direct path read temp
prompt direct path write
prompt direct path write temp
prompt log file sync

set pages 0
alter session set nls_timestamp_format="DD.MM HH24:MI" ;
col BEGIN_INTERVAL_TIME format a15
col SNAP_ID format 9999999999
col EVENT_NAME format a40
col TOTAL_WAITS format 9999999999
col TIME_WAITED_MICRO format 9999999999999999
col TOTAL_WAITS_DELTA format 9999999999999999
select instance_number, BEGIN_INTERVAL_TIME, EVENT_NAME, TOTAL_WAITS_DELTA, (TIME_WAITED_MICRO_DELTA/TOTAL_WAITS_DELTA)/1000
From (
select x.instance_number, y.BEGIN_INTERVAL_TIME, x.EVENT_NAME, 
x.TOTAL_WAITS - FIRST_VALUE(x.TOTAL_WAITS) OVER (ORDER BY BEGIN_INTERVAL_TIME ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS TOTAL_WAITS_DELTA,
x.TIME_WAITED_MICRO  - FIRST_VALUE(x.TIME_WAITED_MICRO) OVER (ORDER BY BEGIN_INTERVAL_TIME ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS TIME_WAITED_MICRO_DELTA
from DBA_HIST_SYSTEM_EVENT x,
DBA_HIST_SNAPSHOT y
where x.snap_id = y.snap_id
and x.instance_number = y.instance_number
and EVENT_NAME = '&event_name.'
and x.instance_number = &instance_number.
order by 2 ) 
where TIME_WAITED_MICRO_DELTA > 0 
order by 2  ;