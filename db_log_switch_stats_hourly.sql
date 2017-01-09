@display_configuration.sql
ACCEPT num_days PROMPT 'Enter number days: ' default 30
col thread# form 9999
col day form a10

break on report
compute sum of total on report FORMAT 9,999,999

COLUMN H00   FORMAT 999  HEADING '00'
COLUMN H01   FORMAT 999  HEADING '01'
COLUMN H02   FORMAT 999  HEADING '02'
COLUMN H03   FORMAT 999  HEADING '03'
COLUMN H04   FORMAT 999  HEADING '04'
COLUMN H05   FORMAT 999  HEADING '05'
COLUMN H06   FORMAT 999  HEADING '06'
COLUMN H07   FORMAT 999  HEADING '07'
COLUMN H08   FORMAT 999  HEADING '08'
COLUMN H09   FORMAT 999  HEADING '09'
COLUMN H10   FORMAT 999  HEADING '10'
COLUMN H11   FORMAT 999  HEADING '11'
COLUMN H12   FORMAT 999  HEADING '12'
COLUMN H13   FORMAT 999  HEADING '13'
COLUMN H14   FORMAT 999  HEADING '14'
COLUMN H15   FORMAT 999  HEADING '15'
COLUMN H16   FORMAT 999  HEADING '16'
COLUMN H17   FORMAT 999  HEADING '17'
COLUMN H18   FORMAT 999  HEADING '18'
COLUMN H19   FORMAT 999  HEADING '19'
COLUMN H20   FORMAT 999  HEADING '20'
COLUMN H21   FORMAT 999  HEADING '21'
COLUMN H22   FORMAT 999  HEADING '22'
COLUMN H23   FORMAT 999  HEADING '23'

column total format 999,999 heading "Total"

alter session set nls_date_format='DD/MM/YYYY';

SELECT
   THREAD#,
   to_date(first_time) DAY,
   sum(decode(to_char(first_time,'HH24'),'00',1,0)) "H00",
   sum(decode(to_char(first_time,'HH24'),'01',1,0)) "H01",
   sum(decode(to_char(first_time,'HH24'),'02',1,0)) "H02",
   sum(decode(to_char(first_time,'HH24'),'03',1,0)) "H03",
   sum(decode(to_char(first_time,'HH24'),'04',1,0)) "H04",
   sum(decode(to_char(first_time,'HH24'),'05',1,0)) "H05",
   sum(decode(to_char(first_time,'HH24'),'06',1,0)) "H06",
   sum(decode(to_char(first_time,'HH24'),'07',1,0)) "H07",
   sum(decode(to_char(first_time,'HH24'),'08',1,0)) "H08",
   sum(decode(to_char(first_time,'HH24'),'09',1,0)) "H09",
   sum(decode(to_char(first_time,'HH24'),'10',1,0)) "H10",
   sum(decode(to_char(first_time,'HH24'),'11',1,0)) "H11",
   sum(decode(to_char(first_time,'HH24'),'12',1,0)) "H12",
   sum(decode(to_char(first_time,'HH24'),'13',1,0)) "H13",
   sum(decode(to_char(first_time,'HH24'),'14',1,0)) "H14",
   sum(decode(to_char(first_time,'HH24'),'15',1,0)) "H15",
   sum(decode(to_char(first_time,'HH24'),'16',1,0)) "H16",
   sum(decode(to_char(first_time,'HH24'),'17',1,0)) "H17",
   sum(decode(to_char(first_time,'HH24'),'18',1,0)) "H18",
   sum(decode(to_char(first_time,'HH24'),'19',1,0)) "H19",
   sum(decode(to_char(first_time,'HH24'),'20',1,0)) "H20",
   sum(decode(to_char(first_time,'HH24'),'21',1,0)) "H21",
   sum(decode(to_char(first_time,'HH24'),'22',1,0)) "H22",
   sum(decode(to_char(first_time,'HH24'),'23',1,0)) "H23",
   count(*) total
from gv$log_history
where to_date(first_time) > sysdate - &num_days
GROUP by  THREAD#,to_date(first_time)
order by to_date(first_time), THREAD#
/

alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS'
/

undef num_days

