@display_configuration.sql

def v_time_minute=&time_minute.

set verify off

select * from
( select 
session_type,
sql_id, 
round(count(1)/60,2) AVG_ACTIVE_SESSION,
round(sum(TM_DELTA_TIME+TM_DELTA_CPU_TIME+TM_DELTA_DB_TIME)/1000000/60,2) tm_delta_time_second,
round(100 / (select sum(TM_DELTA_TIME+TM_DELTA_CPU_TIME+TM_DELTA_DB_TIME) from gv$active_session_history where to_char(trunc(SAMPLE_TIME,'MI'),'HH24:MI') = '&v_time_minute.') * sum(TM_DELTA_TIME+TM_DELTA_CPU_TIME+TM_DELTA_DB_TIME),2) pct_activity
from gv$active_session_history  
where to_char(trunc(SAMPLE_TIME,'MI'),'HH24:MI') = '&v_time_minute.'
group by  SESSION_TYPE, sql_id 
order by 4 desc 
) where rownum <= 10
and tm_delta_time_second is not null 
and sql_id is not null 
;






