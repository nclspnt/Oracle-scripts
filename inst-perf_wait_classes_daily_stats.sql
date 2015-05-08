@display_configuration.sql


select trunc(sample_time,'HH24'), WAIT_CLASS, round( sum(TIME_WAITED)/1000/60 , 2), count(1)
from dba_hist_active_sess_history 
where session_state='WAITING'
group by trunc(sample_time,'HH24'),  WAIT_CLASS
order by 1;
