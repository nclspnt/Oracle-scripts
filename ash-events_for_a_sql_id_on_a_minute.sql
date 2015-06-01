@display_configuration.sql


col WAIT_CLASS format a30
col EVENT format a50
col AVG_ACTIVE_SESSIONS format 9999999999.99
col TM_DELTA_TIME_SECOND_PER_EXEC format 9999999999.99


select
decode(SESSION_STATE,'ON CPU','CPU + CPU Wait',WAIT_CLASS) WAIT_CLASS, 
decode(SESSION_STATE,'ON CPU','n/a',EVENT) EVENT, 
round(count(1)/60,2) AVG_ACTIVE_SESSIONS, 
round(sum(TM_DELTA_TIME+TM_DELTA_CPU_TIME+TM_DELTA_DB_TIME)/1000000/60,2) AVG_WAIT_TIME
from GV$ACTIVE_SESSION_HISTORY
where to_char(trunc(SAMPLE_TIME,'MI'),'HH24:MI') = '&time_minute.'
and SAMPLE_TIME > sysdate - 2/24
and sql_id = '&sql_id.'
group by SESSION_STATE, WAIT_CLASS, EVENT
order by 4 desc
;






