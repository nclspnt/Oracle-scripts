@display_configuration.sql

alter session set nls_date_format="DD.MM.YYYY" ;

select
trunc(BEGIN_INTERVAL_TIME,'DD') WHEN, 
sum(TM_DELTA_CPU_TIME),
sum(TM_DELTA_DB_TIME),
sum(DELTA_READ_IO_BYTES)/1024/1024,
sum(DELTA_WRITE_IO_BYTES)/1024/1024,
sum(DELTA_INTERCONNECT_IO_BYTES)/1024/1024
from dba_hist_active_sess_history x,
dba_hist_snapshot y
where x.SNAP_ID = y.SNAP_ID
and BEGIN_INTERVAL_TIME >= sysdate - &days_before.
group by trunc(BEGIN_INTERVAL_TIME,'DD')
order by 1;