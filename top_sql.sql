@display_configuration.sql

select
*
from
(
select 
sql_id,
sum(tot_time_waited) "CPU+WAITS time"
from (
SELECT 
a.inst_id,
s.username,
s.osuser,
a.session_id,
a.session_serial#,
a.sql_id,
max(a.time_waited)+max(a.wait_time) tot_time_waited
FROM gv$active_session_history a, gv$session s
where a.inst_id = s.inst_id
and a.session_id = s.sid
and a.session_serial# = s.serial#
and a.sample_time >= sysdate - 5/24/60
and s.username is not null
and a.sql_id is not null
group by 
a.inst_id,
s.username,
s.osuser,
a.SESSION_ID,
a.SESSION_SERIAL#,
a.sql_id
) 
group by sql_id
order by sum(tot_time_waited) desc
) where rownum <= 10
;



/*
select 
*
from 
(
select 
SQL_ID,
(
sum(CPU_TIME) +
sum(APPLICATION_WAIT_TIME) +
sum(CONCURRENCY_WAIT_TIME) +
sum(CLUSTER_WAIT_TIME) +
sum(USER_IO_WAIT_TIME) +
sum(PLSQL_EXEC_TIME) +
sum(JAVA_EXEC_TIME) 
) TOT_TIME
from
gv$sql
where LAST_ACTIVE_TIME >= sysdate - 5/24/60
group by SQL_ID
order by TOT_TIME desc
) 
where rownum <= 10
;


select 
*
from 
(
select 
SQL_ID,
(
sum(OPTIMIZER_COST) 
) TOT_TIME
from
gv$sql
where LAST_ACTIVE_TIME >= sysdate - 5/24/60
group by SQL_ID
order by TOT_TIME desc
) 
where rownum <= 10
;







/* OEM 12c query
SELECT event, sql_id, sql_plan_hash_value, sql_opcode, 
session_id, session_serial#, module, action, client_id, 
DECODE(wait_time, 0, 'W', 'C'), 1, time_waited, service_hash, user_id, program, sample_time, p1, p2, p3, 
current_file#, current_obj#, current_block#, qc_session_id, 
qc_instance_id, INST_ID,
REMOTE_INSTANCE# 
FROM gv$active_session_history
where sample_time >= sysdate - 5/24/60
order by time_waited
;
*/