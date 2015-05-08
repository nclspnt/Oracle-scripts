@display_configuration.sql

prompt =================================================================================================================
prompt == Memory Parameters
prompt =================================================================================================================

select inst_id, name, (value/1024/1024) MB 
from gv$parameter
where name in (
'pga_aggregate_target',
'sga_max_size',
'sga_target',
'shared_pool_size',
'large_pool_size',
'java_pool_size',
'db_cache_size',
'log_buffer',
'streams_pool_size',
'memory_max_target',
'memory_target',
'db_16k_cache_size',
'db_2k_cache_size',
'db_32k_cache_size',
'db_4k_cache_size',
'db_8k_cache_size'
) order by 1, 2 ;


prompt =================================================================================================================
prompt == Cache Hit Ratio
prompt =================================================================================================================

SELECT (P1.value + P2.value - P3.value) / (P1.value + P2.value)
FROM   v$sysstat P1, v$sysstat P2, v$sysstat P3
WHERE  P1.name = 'db block gets'
AND    P2.name = 'consistent gets'
AND    P3.name = 'physical reads'
;

prompt =================================================================================================================
prompt == GV$PGA_TARGET_ADVICE
prompt =================================================================================================================

select * 
from GV$PGA_TARGET_ADVICE
;


prompt =================================================================================================================
prompt == GV$SGA_TARGET_ADVICE
prompt =================================================================================================================

select * 
from GV$SGA_TARGET_ADVICE
;


prompt =================================================================================================================
prompt == GV$SGA_RESIZE_OPS
prompt =================================================================================================================

col COMPONENT format a30
col PARAMETER format a30
select * from (
select inst_id, COMPONENT, PARAMETER, OPER_TYPE, trunc(START_TIME,'MM') TIME_MM, count(1)
from GV$SGA_RESIZE_OPS
group by inst_id, COMPONENT, PARAMETER, OPER_TYPE, trunc(START_TIME,'MM')
order by 5, 1 , 2
) where rownum <= 30
;

prompt =================================================================================================================
prompt == GV$MEMORY_TARGET_ADVICE
prompt =================================================================================================================

select * 
from GV$MEMORY_TARGET_ADVICE
;

prompt =================================================================================================================
prompt == GV$MEMORY_RESIZE_OPS
prompt =================================================================================================================


col COMPONENT format a30
col PARAMETER format a30
select * from (
select inst_id, COMPONENT, PARAMETER, OPER_TYPE, trunc(START_TIME,'MM') TIME_MM, count(1)
from GV$MEMORY_RESIZE_OPS
group by inst_id, COMPONENT, PARAMETER, OPER_TYPE, trunc(START_TIME,'MM')
order by 5, 1 , 2
) where rownum <= 30
;
