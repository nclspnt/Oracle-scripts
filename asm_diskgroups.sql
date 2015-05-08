@display_configuration.sql


col name format a15
col TOTAL_GB for 999G999G999
col FREE_GB for 999G999G999
col pct_used for 990D99
select NAME, 
       decode(NAME,'DGOCRVOTING',2048,TOTAL_MB)/1024 TOTAL_GB, 
       round(USABLE_FILE_MB/1024,2) FREE_GB, 
       round((100/decode(NAME,'DGOCRVOTING',2048,TOTAL_MB)*(decode(NAME,'DGOCRVOTING',2048,TOTAL_MB)-USABLE_FILE_MB)),2) pct_used
from v$asm_diskgroup_stat 
order by 4 desc ;

