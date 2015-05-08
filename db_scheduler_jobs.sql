@display_configuration.sql

col OWNER format a30
col JOB_NAME format a35
col ENABLED format a30
col AUTO_DROP format a30
col RESTARTABLE format a30
col STATE format a30
col RUN_COUNT format 999999
col MAX_RUNS format 999999
col FAILURE_COUNT format 999999
col MAX_FAILURES  format 999999


select OWNER, JOB_NAME, ENABLED, AUTO_DROP, RESTARTABLE, STATE, RUN_COUNT, MAX_RUNS, FAILURE_COUNT, MAX_FAILURES
from dba_scheduler_jobs
order by FAILURE_COUNT desc ;
