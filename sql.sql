@display_configuration.sql

def v_sql_id=&sql_id.

prompt ## ============================================================================================================
prompt ## distinct plans used
prompt ## ============================================================================================================
select sql_id, 
child_number, 
old_hash_value,
plan_hash_value,
rpad(nvl(sql_profile,' '),64) sql_profile,
rpad(nvl(sql_plan_baseline,' '),30) sql_plan_baseline,
executions executions, 
elapsed_time/1000000 etime,
(elapsed_time/1000000)/decode(nvl(executions,0),0,1,executions) avg_etime, 
u.username
from v$sql s, dba_users u
where sql_id like nvl('&v_sql_id',sql_id)
and u.user_id = s.parsing_user_id
/


set head off feedback off longc 50000 long 50000
prompt ## ============================================================================================================
prompt ## full sql text
prompt ## ============================================================================================================
select 
  replace(
    replace(
	  replace(
	    replace(
	      replace(
	        replace(
	          sql_fulltext
	        ,'select',chr(10)||'select')
	      ,'from',chr(10)||'from')
	    ,'and',chr(10)||'  and')
      ,'where',chr(10)||'where')
    ,'case',chr(10)||'case')
   ,'when',chr(10)||'  when')
from v$sql
where sql_id = '&v_sql_id.'
;












