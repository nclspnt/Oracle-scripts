@display_configuration.sql

col TOTAL_WAITS format 99999999
col TIME_WAITED_SEC format 99999999999999.99
col avg_ms format 99999999.99

select * from (
select a.EVENT_NAME ,
sum(b.TOTAL_WAITS - a.TOTAL_WAITS) TOTAL_WAITS, 
round((sum(b.TIME_WAITED_MICRO - a.TIME_WAITED_MICRO) )/1000000,2)  TIME_WAITED_SEC,
(sum(b.TIME_WAITED_MICRO - a.TIME_WAITED_MICRO))/1000/(sum(b.TOTAL_WAITS - a.TOTAL_WAITS)) avg_ms
from DBA_HIST_SYSTEM_EVENT a ,
DBA_HIST_SYSTEM_EVENT b
where a.DBID = b.DBID
and a.INSTANCE_NUMBER = b.INSTANCE_NUMBER
and a.EVENT_ID = b.EVENT_ID
and a.snap_id = &snap_being.
and b.snap_id = &snap_end.
and (b.TOTAL_WAITS - a.TOTAL_WAITS) > 0
and a.wait_class <> 'Idle'
group by a.EVENT_NAME
order by 2 desc
) where rownum <= &nb_of_top_to_display.;