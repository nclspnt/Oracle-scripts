@display_configuration.sql

compute sum of TOT on time
BREAK ON TIME SKIP 1

select trunc(SAMPLE_TIME,'MI') TIME, 
decode(SESSION_STATE,'ON CPU','CPU + CPU Wait',WAIT_CLASS) WAITS , 
round(count(1)/60,2) TOT
from V$ACTIVE_SESSION_HISTORY
where SAMPLE_TIME > sysdate-&nb_of_hours_before./24
group by trunc(SAMPLE_TIME,'MI'), decode(SESSION_STATE,'ON CPU','CPU + CPU Wait',WAIT_CLASS), SESSION_STATE
order by 1, 2 ;



