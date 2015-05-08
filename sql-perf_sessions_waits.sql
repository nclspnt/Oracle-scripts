@display_configuration.sql


select
x.inst_id,
x.sid,
x.serial#, 
x.username, 
x.osuser, 
substr(x.module,0,25) module, 
x.status, 
x.sql_id, 
x.last_call_et, 
x.wait_class, 
x.wait_time,
y.STATE,
y.EVENT
from  
gv$session x, 
gV$SESSION_WAIT y
where x.sid=y.sid
and x.username is not null  
order by x.STATUS, x.LAST_CALL_ET desc ;
