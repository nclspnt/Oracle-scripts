@display_configuration.sql

-----------------------------------------------------------------------------------------------

set feedback off
set termout off

column v_past_hour new_value v_past_hour
column v_hour new_value v_hour

select to_char(trunc(sysdate-1/24,'HH24'),'HH24') v_past_hour from dual ;
select to_char(trunc(sysdate,'HH24'),'HH24') v_hour from dual ;

set termout on
set verify off

break on report
set colsep "|"

-----------------------------------------------------------------------------------------------

col "&v_past_hour.:00" format 9999.99
col "&v_past_hour.:01" format 9999.99
col "&v_past_hour.:02" format 9999.99
col "&v_past_hour.:03" format 9999.99
col "&v_past_hour.:04" format 9999.99
col "&v_past_hour.:05" format 9999.99
col "&v_past_hour.:06" format 9999.99
col "&v_past_hour.:07" format 9999.99
col "&v_past_hour.:08" format 9999.99
col "&v_past_hour.:09" format 9999.99
col "&v_past_hour.:10" format 9999.99
col "&v_past_hour.:11" format 9999.99
col "&v_past_hour.:12" format 9999.99
col "&v_past_hour.:13" format 9999.99
col "&v_past_hour.:14" format 9999.99
col "&v_past_hour.:15" format 9999.99
col "&v_past_hour.:16" format 9999.99
col "&v_past_hour.:17" format 9999.99
col "&v_past_hour.:18" format 9999.99
col "&v_past_hour.:19" format 9999.99
col "&v_past_hour.:20" format 9999.99
col "&v_past_hour.:21" format 9999.99
col "&v_past_hour.:22" format 9999.99
col "&v_past_hour.:23" format 9999.99
col "&v_past_hour.:24" format 9999.99
col "&v_past_hour.:25" format 9999.99
col "&v_past_hour.:26" format 9999.99
col "&v_past_hour.:27" format 9999.99
col "&v_past_hour.:28" format 9999.99
col "&v_past_hour.:29" format 9999.99
col "&v_past_hour.:30" format 9999.99
col "&v_past_hour.:31" format 9999.99
col "&v_past_hour.:32" format 9999.99
col "&v_past_hour.:33" format 9999.99
col "&v_past_hour.:34" format 9999.99
col "&v_past_hour.:35" format 9999.99
col "&v_past_hour.:36" format 9999.99
col "&v_past_hour.:37" format 9999.99
col "&v_past_hour.:38" format 9999.99
col "&v_past_hour.:39" format 9999.99
col "&v_past_hour.:40" format 9999.99
col "&v_past_hour.:41" format 9999.99
col "&v_past_hour.:42" format 9999.99
col "&v_past_hour.:43" format 9999.99
col "&v_past_hour.:44" format 9999.99
col "&v_past_hour.:45" format 9999.99
col "&v_past_hour.:46" format 9999.99
col "&v_past_hour.:47" format 9999.99
col "&v_past_hour.:48" format 9999.99
col "&v_past_hour.:49" format 9999.99
col "&v_past_hour.:50" format 9999.99
col "&v_past_hour.:51" format 9999.99
col "&v_past_hour.:52" format 9999.99
col "&v_past_hour.:53" format 9999.99
col "&v_past_hour.:54" format 9999.99
col "&v_past_hour.:55" format 9999.99
col "&v_past_hour.:56" format 9999.99
col "&v_past_hour.:57" format 9999.99
col "&v_past_hour.:58" format 9999.99
col "&v_past_hour.:59" format 9999.99

COMPUTE sum LABEL total OF "&v_past_hour.:00" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:01" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:02" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:03" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:04" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:05" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:06" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:07" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:08" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:09" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:10" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:11" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:12" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:13" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:14" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:15" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:16" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:17" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:18" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:19" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:20" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:21" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:22" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:23" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:24" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:25" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:26" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:27" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:28" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:29" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:30" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:31" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:32" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:33" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:34" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:35" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:36" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:37" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:38" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:39" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:40" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:41" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:42" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:43" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:44" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:45" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:46" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:47" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:48" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:49" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:50" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:51" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:52" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:53" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:54" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:55" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:56" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:57" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:58" ON REPORT
COMPUTE sum LABEL total OF "&v_past_hour.:59" ON REPORT

-----------------------------------------------------------------------------------------------


select time_class.WAIT_CLASS,
SUM(DECODE(to_char(time_class.time,'MI'), '00', ash.TOT, 0)) AS "&v_past_hour.:00",
SUM(DECODE(to_char(time_class.time,'MI'), '01', ash.TOT, 0)) AS "&v_past_hour.:01",
SUM(DECODE(to_char(time_class.time,'MI'), '02', ash.TOT, 0)) AS "&v_past_hour.:02",
SUM(DECODE(to_char(time_class.time,'MI'), '03', ash.TOT, 0)) AS "&v_past_hour.:03",
SUM(DECODE(to_char(time_class.time,'MI'), '04', ash.TOT, 0)) AS "&v_past_hour.:04",
SUM(DECODE(to_char(time_class.time,'MI'), '05', ash.TOT, 0)) AS "&v_past_hour.:05",
SUM(DECODE(to_char(time_class.time,'MI'), '06', ash.TOT, 0)) AS "&v_past_hour.:06",
SUM(DECODE(to_char(time_class.time,'MI'), '07', ash.TOT, 0)) AS "&v_past_hour.:07",
SUM(DECODE(to_char(time_class.time,'MI'), '08', ash.TOT, 0)) AS "&v_past_hour.:08",
SUM(DECODE(to_char(time_class.time,'MI'), '09', ash.TOT, 0)) AS "&v_past_hour.:09",
SUM(DECODE(to_char(time_class.time,'MI'), '10', ash.TOT, 0)) AS "&v_past_hour.:10",
SUM(DECODE(to_char(time_class.time,'MI'), '11', ash.TOT, 0)) AS "&v_past_hour.:11",
SUM(DECODE(to_char(time_class.time,'MI'), '12', ash.TOT, 0)) AS "&v_past_hour.:12",
SUM(DECODE(to_char(time_class.time,'MI'), '13', ash.TOT, 0)) AS "&v_past_hour.:13",
SUM(DECODE(to_char(time_class.time,'MI'), '14', ash.TOT, 0)) AS "&v_past_hour.:14",
SUM(DECODE(to_char(time_class.time,'MI'), '15', ash.TOT, 0)) AS "&v_past_hour.:15",
SUM(DECODE(to_char(time_class.time,'MI'), '16', ash.TOT, 0)) AS "&v_past_hour.:16",
SUM(DECODE(to_char(time_class.time,'MI'), '17', ash.TOT, 0)) AS "&v_past_hour.:17",
SUM(DECODE(to_char(time_class.time,'MI'), '18', ash.TOT, 0)) AS "&v_past_hour.:18",
SUM(DECODE(to_char(time_class.time,'MI'), '19', ash.TOT, 0)) AS "&v_past_hour.:19",
SUM(DECODE(to_char(time_class.time,'MI'), '20', ash.TOT, 0)) AS "&v_past_hour.:20",
SUM(DECODE(to_char(time_class.time,'MI'), '21', ash.TOT, 0)) AS "&v_past_hour.:21",
SUM(DECODE(to_char(time_class.time,'MI'), '22', ash.TOT, 0)) AS "&v_past_hour.:22",
SUM(DECODE(to_char(time_class.time,'MI'), '23', ash.TOT, 0)) AS "&v_past_hour.:23",
SUM(DECODE(to_char(time_class.time,'MI'), '24', ash.TOT, 0)) AS "&v_past_hour.:24",
SUM(DECODE(to_char(time_class.time,'MI'), '25', ash.TOT, 0)) AS "&v_past_hour.:25",
SUM(DECODE(to_char(time_class.time,'MI'), '26', ash.TOT, 0)) AS "&v_past_hour.:26",
SUM(DECODE(to_char(time_class.time,'MI'), '27', ash.TOT, 0)) AS "&v_past_hour.:27",
SUM(DECODE(to_char(time_class.time,'MI'), '28', ash.TOT, 0)) AS "&v_past_hour.:28",
SUM(DECODE(to_char(time_class.time,'MI'), '29', ash.TOT, 0)) AS "&v_past_hour.:29",
SUM(DECODE(to_char(time_class.time,'MI'), '30', ash.TOT, 0)) AS "&v_past_hour.:30",
SUM(DECODE(to_char(time_class.time,'MI'), '31', ash.TOT, 0)) AS "&v_past_hour.:31",
SUM(DECODE(to_char(time_class.time,'MI'), '32', ash.TOT, 0)) AS "&v_past_hour.:32",
SUM(DECODE(to_char(time_class.time,'MI'), '33', ash.TOT, 0)) AS "&v_past_hour.:33",
SUM(DECODE(to_char(time_class.time,'MI'), '34', ash.TOT, 0)) AS "&v_past_hour.:34",
SUM(DECODE(to_char(time_class.time,'MI'), '35', ash.TOT, 0)) AS "&v_past_hour.:35",
SUM(DECODE(to_char(time_class.time,'MI'), '36', ash.TOT, 0)) AS "&v_past_hour.:36",
SUM(DECODE(to_char(time_class.time,'MI'), '37', ash.TOT, 0)) AS "&v_past_hour.:37",
SUM(DECODE(to_char(time_class.time,'MI'), '38', ash.TOT, 0)) AS "&v_past_hour.:38",
SUM(DECODE(to_char(time_class.time,'MI'), '39', ash.TOT, 0)) AS "&v_past_hour.:39",
SUM(DECODE(to_char(time_class.time,'MI'), '40', ash.TOT, 0)) AS "&v_past_hour.:40",
SUM(DECODE(to_char(time_class.time,'MI'), '41', ash.TOT, 0)) AS "&v_past_hour.:41",
SUM(DECODE(to_char(time_class.time,'MI'), '42', ash.TOT, 0)) AS "&v_past_hour.:42",
SUM(DECODE(to_char(time_class.time,'MI'), '43', ash.TOT, 0)) AS "&v_past_hour.:43",
SUM(DECODE(to_char(time_class.time,'MI'), '44', ash.TOT, 0)) AS "&v_past_hour.:44",
SUM(DECODE(to_char(time_class.time,'MI'), '45', ash.TOT, 0)) AS "&v_past_hour.:45",
SUM(DECODE(to_char(time_class.time,'MI'), '46', ash.TOT, 0)) AS "&v_past_hour.:46",
SUM(DECODE(to_char(time_class.time,'MI'), '47', ash.TOT, 0)) AS "&v_past_hour.:47",
SUM(DECODE(to_char(time_class.time,'MI'), '48', ash.TOT, 0)) AS "&v_past_hour.:48",
SUM(DECODE(to_char(time_class.time,'MI'), '49', ash.TOT, 0)) AS "&v_past_hour.:49",
SUM(DECODE(to_char(time_class.time,'MI'), '50', ash.TOT, 0)) AS "&v_past_hour.:50",
SUM(DECODE(to_char(time_class.time,'MI'), '51', ash.TOT, 0)) AS "&v_past_hour.:51",
SUM(DECODE(to_char(time_class.time,'MI'), '52', ash.TOT, 0)) AS "&v_past_hour.:52",
SUM(DECODE(to_char(time_class.time,'MI'), '53', ash.TOT, 0)) AS "&v_past_hour.:53",
SUM(DECODE(to_char(time_class.time,'MI'), '54', ash.TOT, 0)) AS "&v_past_hour.:54",
SUM(DECODE(to_char(time_class.time,'MI'), '55', ash.TOT, 0)) AS "&v_past_hour.:55",
SUM(DECODE(to_char(time_class.time,'MI'), '56', ash.TOT, 0)) AS "&v_past_hour.:56",
SUM(DECODE(to_char(time_class.time,'MI'), '57', ash.TOT, 0)) AS "&v_past_hour.:57",
SUM(DECODE(to_char(time_class.time,'MI'), '58', ash.TOT, 0)) AS "&v_past_hour.:58",
SUM(DECODE(to_char(time_class.time,'MI'), '59', ash.TOT, 0)) AS "&v_past_hour.:59"
from
( select * from 
    (select trunc(sysdate,'HH24')-level/60/24  TIME from dual connect by level <= 60) minutes,
    (select distinct WAIT_CLASS from v$EVENT_NAME union select 'CPU + CPU Wait' from dual ) class_name
) time_class,
(select trunc(SAMPLE_TIME,'MI') TIME, 
decode(SESSION_STATE,'ON CPU','CPU + CPU Wait',WAIT_CLASS) WAITS , 
round(count(1)/60,2) TOT
from GV$ACTIVE_SESSION_HISTORY
group by trunc(SAMPLE_TIME,'MI'), decode(SESSION_STATE,'ON CPU','CPU + CPU Wait',WAIT_CLASS) ) ash
where time_class.time = ash.time (+)
and time_class.WAIT_CLASS = ash.WAITS (+)
group by time_class.WAIT_CLASS
order by 1, 2, 3
;


-----------------------------------------------------------------------------------------------
prompt 
prompt 
-----------------------------------------------------------------------------------------------

col "&v_hour.:00" format 9999.99
col "&v_hour.:01" format 9999.99
col "&v_hour.:02" format 9999.99
col "&v_hour.:03" format 9999.99
col "&v_hour.:04" format 9999.99
col "&v_hour.:05" format 9999.99
col "&v_hour.:06" format 9999.99
col "&v_hour.:07" format 9999.99
col "&v_hour.:08" format 9999.99
col "&v_hour.:09" format 9999.99
col "&v_hour.:10" format 9999.99
col "&v_hour.:11" format 9999.99
col "&v_hour.:12" format 9999.99
col "&v_hour.:13" format 9999.99
col "&v_hour.:14" format 9999.99
col "&v_hour.:15" format 9999.99
col "&v_hour.:16" format 9999.99
col "&v_hour.:17" format 9999.99
col "&v_hour.:18" format 9999.99
col "&v_hour.:19" format 9999.99
col "&v_hour.:20" format 9999.99
col "&v_hour.:21" format 9999.99
col "&v_hour.:22" format 9999.99
col "&v_hour.:23" format 9999.99
col "&v_hour.:24" format 9999.99
col "&v_hour.:25" format 9999.99
col "&v_hour.:26" format 9999.99
col "&v_hour.:27" format 9999.99
col "&v_hour.:28" format 9999.99
col "&v_hour.:29" format 9999.99
col "&v_hour.:30" format 9999.99
col "&v_hour.:31" format 9999.99
col "&v_hour.:32" format 9999.99
col "&v_hour.:33" format 9999.99
col "&v_hour.:34" format 9999.99
col "&v_hour.:35" format 9999.99
col "&v_hour.:36" format 9999.99
col "&v_hour.:37" format 9999.99
col "&v_hour.:38" format 9999.99
col "&v_hour.:39" format 9999.99
col "&v_hour.:40" format 9999.99
col "&v_hour.:41" format 9999.99
col "&v_hour.:42" format 9999.99
col "&v_hour.:43" format 9999.99
col "&v_hour.:44" format 9999.99
col "&v_hour.:45" format 9999.99
col "&v_hour.:46" format 9999.99
col "&v_hour.:47" format 9999.99
col "&v_hour.:48" format 9999.99
col "&v_hour.:49" format 9999.99
col "&v_hour.:50" format 9999.99
col "&v_hour.:51" format 9999.99
col "&v_hour.:52" format 9999.99
col "&v_hour.:53" format 9999.99
col "&v_hour.:54" format 9999.99
col "&v_hour.:55" format 9999.99
col "&v_hour.:56" format 9999.99
col "&v_hour.:57" format 9999.99
col "&v_hour.:58" format 9999.99
col "&v_hour.:59" format 9999.99

COMPUTE sum LABEL total OF "&v_hour.:00" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:01" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:02" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:03" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:04" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:05" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:06" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:07" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:08" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:09" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:10" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:11" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:12" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:13" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:14" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:15" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:16" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:17" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:18" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:19" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:20" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:21" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:22" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:23" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:24" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:25" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:26" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:27" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:28" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:29" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:30" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:31" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:32" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:33" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:34" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:35" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:36" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:37" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:38" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:39" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:40" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:41" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:42" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:43" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:44" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:45" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:46" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:47" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:48" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:49" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:50" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:51" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:52" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:53" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:54" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:55" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:56" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:57" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:58" ON REPORT
COMPUTE sum LABEL total OF "&v_hour.:59" ON REPORT

-----------------------------------------------------------------------------------------------


select time_class.WAIT_CLASS,
SUM(DECODE(to_char(time_class.time,'MI'), '00', ash.TOT, 0)) AS "&v_hour.:00",
SUM(DECODE(to_char(time_class.time,'MI'), '01', ash.TOT, 0)) AS "&v_hour.:01",
SUM(DECODE(to_char(time_class.time,'MI'), '02', ash.TOT, 0)) AS "&v_hour.:02",
SUM(DECODE(to_char(time_class.time,'MI'), '03', ash.TOT, 0)) AS "&v_hour.:03",
SUM(DECODE(to_char(time_class.time,'MI'), '04', ash.TOT, 0)) AS "&v_hour.:04",
SUM(DECODE(to_char(time_class.time,'MI'), '05', ash.TOT, 0)) AS "&v_hour.:05",
SUM(DECODE(to_char(time_class.time,'MI'), '06', ash.TOT, 0)) AS "&v_hour.:06",
SUM(DECODE(to_char(time_class.time,'MI'), '07', ash.TOT, 0)) AS "&v_hour.:07",
SUM(DECODE(to_char(time_class.time,'MI'), '08', ash.TOT, 0)) AS "&v_hour.:08",
SUM(DECODE(to_char(time_class.time,'MI'), '09', ash.TOT, 0)) AS "&v_hour.:09",
SUM(DECODE(to_char(time_class.time,'MI'), '10', ash.TOT, 0)) AS "&v_hour.:10",
SUM(DECODE(to_char(time_class.time,'MI'), '11', ash.TOT, 0)) AS "&v_hour.:11",
SUM(DECODE(to_char(time_class.time,'MI'), '12', ash.TOT, 0)) AS "&v_hour.:12",
SUM(DECODE(to_char(time_class.time,'MI'), '13', ash.TOT, 0)) AS "&v_hour.:13",
SUM(DECODE(to_char(time_class.time,'MI'), '14', ash.TOT, 0)) AS "&v_hour.:14",
SUM(DECODE(to_char(time_class.time,'MI'), '15', ash.TOT, 0)) AS "&v_hour.:15",
SUM(DECODE(to_char(time_class.time,'MI'), '16', ash.TOT, 0)) AS "&v_hour.:16",
SUM(DECODE(to_char(time_class.time,'MI'), '17', ash.TOT, 0)) AS "&v_hour.:17",
SUM(DECODE(to_char(time_class.time,'MI'), '18', ash.TOT, 0)) AS "&v_hour.:18",
SUM(DECODE(to_char(time_class.time,'MI'), '19', ash.TOT, 0)) AS "&v_hour.:19",
SUM(DECODE(to_char(time_class.time,'MI'), '20', ash.TOT, 0)) AS "&v_hour.:20",
SUM(DECODE(to_char(time_class.time,'MI'), '21', ash.TOT, 0)) AS "&v_hour.:21",
SUM(DECODE(to_char(time_class.time,'MI'), '22', ash.TOT, 0)) AS "&v_hour.:22",
SUM(DECODE(to_char(time_class.time,'MI'), '23', ash.TOT, 0)) AS "&v_hour.:23",
SUM(DECODE(to_char(time_class.time,'MI'), '24', ash.TOT, 0)) AS "&v_hour.:24",
SUM(DECODE(to_char(time_class.time,'MI'), '25', ash.TOT, 0)) AS "&v_hour.:25",
SUM(DECODE(to_char(time_class.time,'MI'), '26', ash.TOT, 0)) AS "&v_hour.:26",
SUM(DECODE(to_char(time_class.time,'MI'), '27', ash.TOT, 0)) AS "&v_hour.:27",
SUM(DECODE(to_char(time_class.time,'MI'), '28', ash.TOT, 0)) AS "&v_hour.:28",
SUM(DECODE(to_char(time_class.time,'MI'), '29', ash.TOT, 0)) AS "&v_hour.:29",
SUM(DECODE(to_char(time_class.time,'MI'), '30', ash.TOT, 0)) AS "&v_hour.:30",
SUM(DECODE(to_char(time_class.time,'MI'), '31', ash.TOT, 0)) AS "&v_hour.:31",
SUM(DECODE(to_char(time_class.time,'MI'), '32', ash.TOT, 0)) AS "&v_hour.:32",
SUM(DECODE(to_char(time_class.time,'MI'), '33', ash.TOT, 0)) AS "&v_hour.:33",
SUM(DECODE(to_char(time_class.time,'MI'), '34', ash.TOT, 0)) AS "&v_hour.:34",
SUM(DECODE(to_char(time_class.time,'MI'), '35', ash.TOT, 0)) AS "&v_hour.:35",
SUM(DECODE(to_char(time_class.time,'MI'), '36', ash.TOT, 0)) AS "&v_hour.:36",
SUM(DECODE(to_char(time_class.time,'MI'), '37', ash.TOT, 0)) AS "&v_hour.:37",
SUM(DECODE(to_char(time_class.time,'MI'), '38', ash.TOT, 0)) AS "&v_hour.:38",
SUM(DECODE(to_char(time_class.time,'MI'), '39', ash.TOT, 0)) AS "&v_hour.:39",
SUM(DECODE(to_char(time_class.time,'MI'), '40', ash.TOT, 0)) AS "&v_hour.:40",
SUM(DECODE(to_char(time_class.time,'MI'), '41', ash.TOT, 0)) AS "&v_hour.:41",
SUM(DECODE(to_char(time_class.time,'MI'), '42', ash.TOT, 0)) AS "&v_hour.:42",
SUM(DECODE(to_char(time_class.time,'MI'), '43', ash.TOT, 0)) AS "&v_hour.:43",
SUM(DECODE(to_char(time_class.time,'MI'), '44', ash.TOT, 0)) AS "&v_hour.:44",
SUM(DECODE(to_char(time_class.time,'MI'), '45', ash.TOT, 0)) AS "&v_hour.:45",
SUM(DECODE(to_char(time_class.time,'MI'), '46', ash.TOT, 0)) AS "&v_hour.:46",
SUM(DECODE(to_char(time_class.time,'MI'), '47', ash.TOT, 0)) AS "&v_hour.:47",
SUM(DECODE(to_char(time_class.time,'MI'), '48', ash.TOT, 0)) AS "&v_hour.:48",
SUM(DECODE(to_char(time_class.time,'MI'), '49', ash.TOT, 0)) AS "&v_hour.:49",
SUM(DECODE(to_char(time_class.time,'MI'), '50', ash.TOT, 0)) AS "&v_hour.:50",
SUM(DECODE(to_char(time_class.time,'MI'), '51', ash.TOT, 0)) AS "&v_hour.:51",
SUM(DECODE(to_char(time_class.time,'MI'), '52', ash.TOT, 0)) AS "&v_hour.:52",
SUM(DECODE(to_char(time_class.time,'MI'), '53', ash.TOT, 0)) AS "&v_hour.:53",
SUM(DECODE(to_char(time_class.time,'MI'), '54', ash.TOT, 0)) AS "&v_hour.:54",
SUM(DECODE(to_char(time_class.time,'MI'), '55', ash.TOT, 0)) AS "&v_hour.:55",
SUM(DECODE(to_char(time_class.time,'MI'), '56', ash.TOT, 0)) AS "&v_hour.:56",
SUM(DECODE(to_char(time_class.time,'MI'), '57', ash.TOT, 0)) AS "&v_hour.:57",
SUM(DECODE(to_char(time_class.time,'MI'), '58', ash.TOT, 0)) AS "&v_hour.:58",
SUM(DECODE(to_char(time_class.time,'MI'), '59', ash.TOT, 0)) AS "&v_hour.:59"
from
( select * from 
    (select trunc(sysdate - (level-1)/60/24,'MI') TIME from dual connect by level <= (select trunc(( sysdate - trunc(sysdate,'HH24') ) *24*60) from dual)+1 ) minutes,
    (select distinct WAIT_CLASS from v$EVENT_NAME union select 'CPU + CPU Wait' from dual ) class_name
) time_class,
(select trunc(SAMPLE_TIME,'MI') TIME, 
decode(SESSION_STATE,'ON CPU','CPU + CPU Wait',WAIT_CLASS) WAITS , 
round(count(1)/60,2) TOT
from GV$ACTIVE_SESSION_HISTORY
group by trunc(SAMPLE_TIME,'MI'), decode(SESSION_STATE,'ON CPU','CPU + CPU Wait',WAIT_CLASS) ) ash
where time_class.time = ash.time (+)
and time_class.WAIT_CLASS = ash.WAITS (+)
group by time_class.WAIT_CLASS
order by 1, 2, 3
;


-----------------------------------------------------------------------------------------------
prompt 
prompt 
-----------------------------------------------------------------------------------------------








