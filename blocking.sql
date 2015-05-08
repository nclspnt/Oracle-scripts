@display_configuration.sql

set lines 200 pages 200
col STATUS format a20
col WAIT_CLASS format a30
col EVENT format a50
col SQL_ID format a15
select level , sid, serial#, status, WAIT_CLASS, EVENT, sql_id, last_call_et 
from (
select sid, 
BLOCKING_SESSION p_sid,
inst_id, serial#, status, WAIT_CLASS, EVENT, sql_id, last_call_et 
from gv$session 
where BLOCKING_SESSION is not null 
union all
select sid, 
BLOCKING_SESSION p_sid,
inst_id, serial#, status, WAIT_CLASS, EVENT, sql_id, last_call_et 
from gv$session 
where sid in ( 
select BLOCKING_SESSION 
from gv$session 
where BLOCKING_SESSION 
is not null ) )
START WITH p_sid is null
CONNECT BY PRIOR sid = p_sid
ORDER SIBLINGS BY sid ;

