@display_configuration.sql

col OBJECT_NAME format a30
col OBJECT_TYPE format a30
col is_blocker format a25
col DESCRIPTION format a100
col NAME format a30
col IS_USER format a8

SELECT 
l.sid, 
s.blocking_session blocker, 
decode(l.BLOCK,0,'NO',1,'YES',2,'MAYBE on remote nodes', l.BLOCK) is_blocker, 
s.event, 
lt.NAME, 
lt.IS_USER, 
lt.DESCRIPTION, 
decode(l.lmode,0,'none',1,'null (NULL)',2,'row-S (SS)',3,'row-X (SX)',4,'share (S)',5,'S/Row-X (SSX)',6,'exclusive (X)',l.lmode ) lmode,
decode(l.request,0,'none',1,'null (NULL)',2,'row-S (SS)',3,'row-X (SX)',4,'share (S)',5,'S/Row-X (SSX)',6,'exclusive (X)',l.request ) request,
o.object_name, 
o.object_type 
FROM v$lock l, V$LOCK_TYPE lt, dba_objects o, v$session s 
WHERE l.type = lt.type
AND l.id1 = o.object_id (+) 
AND l.sid = s.sid 
and UPPER(s.username) = UPPER('&User') 
ORDER BY sid, lt.type
;