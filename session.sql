
set lines 200 pages 200

select 
'--| local db |'||rpad('-',44,'-')||chr(10)||chr(10)||
'inst_id:'||lpad(s.inst_id,50)||chr(10)||
'sid:'||lpad(s.sid,54)||chr(10)||
'serial#:'||lpad(s.serial#,50)||chr(10)||
'spid:'||lpad(p.spid,53)||chr(10)||
'username:'||lpad(s.username,49)||chr(10)||
'module:'||lpad(s.module,51)||chr(10)||
'action:'||lpad(s.action,51)||chr(10)||
'client_info:'||lpad(s.CLIENT_INFO,45)||chr(10)||
'client_identifier:'||lpad(s.CLIENT_IDENTIFIER,40)||chr(10)||
'logon_time:'||lpad(s.logon_time,47)||chr(10)||
chr(10)||'--| session status |'||rpad('-',38,'-')||chr(10)||chr(10)||
'status:'||lpad(s.status,51)||chr(10)||
'last_call_et:'||lpad(s.last_call_et,45)||chr(10)||
'sql_id:'||lpad(s.sql_id,51)||chr(10)||
'prev_sql_id:'||lpad(s.PREV_SQL_ID,46)||chr(10)||
chr(10)||'--| session config |'||rpad('-',38,'-')||chr(10)||chr(10)||
'resource_consumer_group:'||lpad(s.RESOURCE_CONSUMER_GROUP,34)||chr(10)||
'pq_status:'||lpad(s.PQ_STATUS,48)||chr(10)||
chr(10)||'--| sqlnet |'||rpad('-',46,'-')||chr(10)||chr(10)||
'service_name:'||lpad(s.service_name,45)||chr(10)||
'server:'||lpad(s.server,51)||chr(10)||
chr(10)||'--| local os |'||rpad('-',44,'-')||chr(10)||chr(10)||
'sql_trace:'||lpad(s.SQL_TRACE,48)||chr(10)||
'tracefile:'||lpad('{trace_dest}/'||SUBSTR(TRACEFILE,(INSTR(TRACEFILE,'/',-1,1)+1),length(TRACEFILE)),48)||chr(10)||
'background:'||lpad(p.BACKGROUND,48)||chr(10)||
'pga_used_mem:'||lpad(p.PGA_USED_MEM,45)||chr(10)||
'pga_alloc_mem:'||lpad(p.PGA_ALLOC_MEM,44)||chr(10)||
'pga_freeable_mem:'||lpad(p.PGA_FREEABLE_MEM,41)||chr(10)||
'pag_max_mem:'||lpad(p.PGA_MAX_MEM,46)||chr(10)||
chr(10)||'--| remote os |'||rpad('-',43,'-')||chr(10)||chr(10)||
'osuser:'||lpad(s.osuser,51)||chr(10)||
'machine:'||lpad(s.machine,50)||chr(10)||
'process:'||lpad(s.process,50)||chr(10)||
'program:'||lpad(s.program,50)
from 
gv$session s,
gv$process p
where
s.paddr = p.addr
and s.sid = &sid.
;
