@display_configuration.sql

set lines 2000 pages 2000
col machine format a25
col OSUSER format a20
col SQL_ID format a15
col CHILD_NUMBER format 999
col PLAN_HASH_VALUE format 99999999999
col sid format 999999
col SQL_TEXT format a1000
SELECT  sess.machine, sess.OSUSER, sess.sid, sql.executions, sql.PLAN_HASH_VALUE, SUBSTR(sql.BIND_DATA,-5) BIND_DATA, sql.SQL_ID ,sql.child_number, sql.SQL_TEXT
FROM v$open_cursor cur, V$SESSION sess, V$SQL sql
where cur.SADDR = sess.SADDR
and cur.SID = sess.SID
and sess.username is not null
and cur.sql_id = sql.sql_id
order by SQL_ID, sql.child_number
;