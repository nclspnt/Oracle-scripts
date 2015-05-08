@display_configuration.sql
set serveroutput on

begin

dbms_output.put_line( '|'||rpad('-',41, '-')||rpad('-',15,'-')||rpad('-',14,'-')||rpad('-',63,'-')||rpad('-',16,'-')||'|' ) ;
dbms_output.put_line( '|'||rpad('username (inst_id,sid,serial#,spid)',42)||'|'||rpad('last_call_et',16)||'|'||rpad('sql_id',15)||'|'||rpad('event',64)||'|'||rpad('seconds_in_wait',16)||'|' ) ;
dbms_output.put_line( '|'||rpad('-',41, '-')||rpad('-',15,'-')||rpad('-',14,'-')||rpad('-',63,'-')||rpad('-',16,'-')||'|' ) ;


for c_ts in (
select
rpad(USERNAME||' ('||inst_id||','||sid||','||serial#||','||(select spid from gv$process where s.paddr = addr  and s.inst_id = inst_id)||')',42) USERNAME,
rpad(LAST_CALL_ET,16) last_call_et_s,
rpad(nvl(sql_id,' '),15) sql_id,
rpad(EVENT,64) EVENT,
rpad(to_char(SECONDS_IN_WAIT),16) seconds_in_wait_s
from
gv$session s
where
USERNAME is not null
and STATE = 'WAITING'
and status = 'ACTIVE'
and sid <> SYS_CONTEXT('USERENV', 'SID')
order by SECONDS_IN_WAIT desc
) loop

dbms_output.put_line( '|'||c_ts.USERNAME||'|'||c_ts.last_call_et_s||'|'||c_ts.sql_id||'|'||c_ts.event||'|'||c_ts.seconds_in_wait_s||'|' ) ;

end loop ;

end;
/
