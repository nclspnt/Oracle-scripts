@display_configuration.sql


col TIME_WAITED_MSEC format 99999999.99
col avg_ms format 999999.99

select * from (
select a.EVENT ,
sum(b.TOTAL_WAITS - a.TOTAL_WAITS) TOTAL_WAITS, 
round((sum(b.TIME_WAITED_MICRO - a.TIME_WAITED_MICRO) )/1000,2)  TIME_WAITED_MSEC,
(sum(b.TIME_WAITED_MICRO - a.TIME_WAITED_MICRO))/1000/(sum(b.TOTAL_WAITS - a.TOTAL_WAITS)) avg_ms
from gv$system_event a ,
gv$system_event b
where a.inst_id = b.inst_id
and a.EVENT_ID = b.EVENT_ID
and (b.TOTAL_WAITS - a.TOTAL_WAITS) > 0
and a.wait_class <> 'Idle'
group by a.EVENT
order by 3 desc
) where rownum <= 10 ;


