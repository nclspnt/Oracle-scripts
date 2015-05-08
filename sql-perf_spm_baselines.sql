@display_configuration.sql


col ORIGIN format a20
col VERSION format a30
col CREATED format a30
col LAST_MODIFIED format a30
col LAST_EXECUTED format a30
col LAST_VERIFIED format a30

select
( SELECT sql_id FROM v$sql WHERE exact_matching_signature = signature ) sql_id,
SQL_HANDLE,
PLAN_NAME,
CREATOR,
ORIGIN,
VERSION,
CREATED,
LAST_MODIFIED,
LAST_EXECUTED,
LAST_VERIFIED,
ENABLED,
ACCEPTED,
FIXED,
REPRODUCED,
OPTIMIZER_COST,
EXECUTIONS,
ELAPSED_TIME,
CPU_TIME,
BUFFER_GETS,
ROWS_PROCESSED
from DBA_SQL_PLAN_BASELINES
where SQL_HANDLE like '&optional_sql_handle.%'
and signature IN ( SELECT exact_matching_signature FROM v$sql WHERE sql_id like '&optional_sql_id%')
;
