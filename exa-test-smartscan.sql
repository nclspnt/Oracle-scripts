=======================> MYSTATS

set lines 200 pages 200 timing off autotrace off

select sn.name, ms.value/1024/1024 mb
from v$mystat ms natural join v$statname sn
where sn.name in ('physical read total bytes', 'physical write total bytes', 'cell io uncompressed bytes', 'cell flash cache read hits')
or sn.name like 'cell phy%' 
order by 1 desc ;


select distinct event, total_waits, time_waited/100 wait_secs,
average_wait/100 avg_wait_secs
from v$session_event e, v$mystat s
where event like 'cell%' and e.sid = s.sid;



=======================> LOAD example
-- test
drop table tst_nclspnt_01 purge ;

create table tst_nclspnt_01 ( id number, firstname varchar2(50), lastname varchar2(50), start_date date, salary number ) ;

insert into tst_nclspnt_01
select level, dbms_random.string('L', 20), dbms_random.string('L', 20),  sysdate - dbms_random.value(1,5000), dbms_random.value(60000,1000000)
from dual 
connect by level < 10000000 ;


=======================> Query efficiency with SmartCache

select  sql_id,
io_cell_offload_eligible_bytes qualifying,
io_cell_offload_returned_bytes actual,
round(((io_cell_offload_eligible_bytes - io_cell_offload_returned_bytes)/io_cell_offload_eligible_bytes)*100, 2) io_saved_pct,
sql_text
from v$sql
where io_cell_offload_returned_bytes > 0
and instr(lower(sql_fulltext), 'tst_nclspnt_01') > 0
;


=======================> Backup done on cells

select a.name, sum(b.value/1024/1024) MB
from v$sysstat a, v$sesstat b, v$session c
where a.statistic# = b.statistic# and
b.sid = c.sid and
upper(c.program) like 'RMAN%' and
(a.name in ('physical read total bytes',
'physical write total bytes',
'cell IO uncompressed bytes')
or a.name like 'cell phy%')
group by a.name;

=======================> HCC
set lines 200 pages 200

select segment_name, sum(bytes)/1024/1024 total_space_mb
from dba_segments
where owner = 'SYS'
and segment_name like 'TST_NCLSPNT_%'
group by segment_name;

select OWNER, TABLE_NAME, NUM_ROWS, FLASH_CACHE, CELL_FLASH_CACHE, COMPRESSION, COMPRESS_FOR, RESULT_CACHE 
from dba_tables 
where OWNER = 'SYS' 
and table_name like 'TST_NCLSPNT_%' ;

--> force le direct path car meilleur taux de compression
alter session force parallel query;
alter session force parallel ddl;
alter session force parallel dml;

alter table tst_nclspnt_01 move compress for query high;
alter table tst_nclspnt_01 move compress for query low;
alter table tst_nclspnt_01 move compress for archive high;
alter table tst_nclspnt_01 move compress for archive low;

create table tst_nclspnt_01_query_high parallel 4 nologging compress for query high as select * from tst_nclspnt_01;
create table tst_nclspnt_01_query_low parallel 4 nologging compress for query low as select * from tst_nclspnt_01;
create table tst_nclspnt_01_archive_high parallel 4 nologging compress for archive high as select * from tst_nclspnt_01;
create table tst_nclspnt_01_archive_low parallel 4 nologging compress for archive low as select * from tst_nclspnt_01;


=======================> Keep flash cache

alter table tst_nclspnt_01 storage (cell_flash_cache keep);

select OWNER, TABLE_NAME, NUM_ROWS, FLASH_CACHE, CELL_FLASH_CACHE, COMPRESSION, COMPRESS_FOR, RESULT_CACHE 
from dba_tables 
where OWNER = 'SYS' 
and table_name like 'tst_nclspnt_01%' ;


=======================> cell smart cache test

alter session set cell_offload_processing = false ;

@fbc
@stats



select /*+ OPT_PARAM('cell_offload_processing' 'false') */ * from tst_nclspnt_01 where id = 43686 ;
select * from TST_NCLSPNT_01 where id = 4366 ;
select /*+ no_index (TST_NCLSPNT_01) */ *  from TST_NCLSPNT_01 where id = 4366 ;
select * from tst_nclspnt_01_archive_low where id = 43686 ;

set timi on serveroutput on



declare
  i number := 0 ;
  nb number ;
  v_id number ;
begin
  while i <= 50 loop
  v_id := round(dbms_random.value(1,1000000)) ;
  --select  /*+ OPT_PARAM('cell_offload_processing' 'true') */ count(1) into nb from tst_nclspnt_01 where id = v_id ;
  --select  /*+ OPT_PARAM('cell_offload_processing' 'false') */ count(1) into nb from tst_nclspnt_01 where id = v_id ;
  --select  /*+ no_index (tst_nclspnt_01) */ count(1) into nb from tst_nclspnt_01 where id = v_id ;
  --select  /*+ parallel (4) */ count(1) into nb from tst_nclspnt_01 where id = v_id ;
  select count(1) into nb from tst_nclspnt_01 where START_DATE > sysdate - 356 ;
 dbms_output.put_line(' ---> '||v_id);
  i := i+1 ;
  end loop ;
end;
/


select count(1) from tst_nclspnt_01 where  START_DATE > sysdate - 356 ;
select /*+ OPT_PARAM('cell_offload_processing' 'false') */ count(1) from tst_nclspnt_01 where  START_DATE > sysdate - 356 ;




====================================================================================================================================================================================
====================================================================================================================================================================================

==> select * from TST_NCLSPNT_01 where id = 4366 ;

SQL> @stats

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical write total bytes                                                0
physical read total bytes                                         1.3984375
cell physical IO interconnect bytes returned by smart scan                0
cell physical IO interconnect bytes                               1.3984375
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes saved by storage index                             0
cell physical IO bytes eligible for predicate offload                     0
cell flash cache read hits                                       .000077248
cell IO uncompressed bytes                                                0


Execution Plan
----------------------------------------------------------
Plan hash value: 3726029423

----------------------------------------------------------------------------------------------------
| Id  | Operation                   | Name                 | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |                      |     1 |    89 |     4   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| TST_NCLSPNT_01       |     1 |    89 |     4   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | TST_NCLSPNT_01_IDX01 |     1 |       |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("ID"=4366)

Note
-----
   - dynamic sampling used for this statement (level=2)


Statistics
----------------------------------------------------------
          0  recursive calls
          0  db block gets
          5  consistent gets
          4  physical reads
        208  redo size
        878  bytes sent via SQL*Net to client
        523  bytes received via SQL*Net from client
          2  SQL*Net roundtrips to/from client
          0  sorts (memory)
          0  sorts (disk)
          1  rows processed

		  

==> select /*+ no_index (TST_NCLSPNT_01) */ *  from TST_NCLSPNT_01 where id = 4366 ;

SQL> @stats

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical write total bytes                                                0
physical read total bytes                                        898.359375
cell physical IO interconnect bytes returned by smart scan       .000480652
cell physical IO interconnect bytes                              1.38329315
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes saved by storage index                    896.484375
cell physical IO bytes eligible for predicate offload            896.976563
cell flash cache read hits                                       .000076294
cell IO uncompressed bytes                                         .4921875


Execution Plan
----------------------------------------------------------
Plan hash value: 2296801760

--------------------------------------------------------------------------------------------
| Id  | Operation                 | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT          |                |  1263 |   109K| 31187   (1)| 00:00:02 |
|*  1 |  TABLE ACCESS STORAGE FULL| TST_NCLSPNT_01 |  1263 |   109K| 31187   (1)| 00:00:02 |
--------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   1 - storage("ID"=4366)
       filter("ID"=4366)

Note
-----
   - dynamic sampling used for this statement (level=2)


Statistics
----------------------------------------------------------
          4  recursive calls
          0  db block gets
     114911  consistent gets  ( 114911 * 8 ) / 1024 ==> 897,7421875
     114982  physical reads
       6332  redo size
        874  bytes sent via SQL*Net to client
        523  bytes received via SQL*Net from client
          2  SQL*Net roundtrips to/from client
          0  sorts (memory)
          0  sorts (disk)
          1  rows processed


====================================================================================================================================================================================
====================================================================================================================================================================================
		  
@fbc
@stats

select /*+ no_index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

SQL> select /*+ no_index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711027

Elapsed: 00:00:00.10

SQL> @stats

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical write total bytes                                                0
physical read total bytes                                        898.351563
cell physical IO interconnect bytes returned by smart scan       8.50886536
cell physical IO interconnect bytes                              9.88386536
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes saved by storage index                             0
cell physical IO bytes eligible for predicate offload            896.976563
cell flash cache read hits                                       .001784325
cell IO uncompressed bytes                                       896.976563


Execution Plan
----------------------------------------------------------
Plan hash value: 2615736477

---------------------------------------------------------------------------------------------
| Id  | Operation                  | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT           |                |     1 |     9 | 31437   (2)| 00:00:02 |
|   1 |  SORT AGGREGATE            |                |     1 |     9 |            |          |
|*  2 |   TABLE ACCESS STORAGE FULL| TST_NCLSPNT_01 |   821K|  7223K| 31437   (2)| 00:00:02 |
---------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - storage("START_DATE">SYSDATE@!-356)
       filter("START_DATE">SYSDATE@!-356)

Note
-----
   - dynamic sampling used for this statement (level=2)


Statistics
----------------------------------------------------------
          0  recursive calls
          0  db block gets
     114819  consistent gets
     114814  physical reads
         96  redo size
        528  bytes sent via SQL*Net to client
        524  bytes received via SQL*Net from client
          2  SQL*Net roundtrips to/from client
          0  sorts (memory)
          0  sorts (disk)
          1  rows processed


		  
		  
SQL> select /*+ OPT_PARAM('cell_offload_processing' 'false') no_index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711026

Elapsed: 00:00:01.19


SQL> @stats

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical write total bytes                                                0
physical read total bytes                                        898.359375
cell physical IO interconnect bytes returned by smart scan                0
cell physical IO interconnect bytes                              898.359375
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes saved by storage index                             0
cell physical IO bytes eligible for predicate offload                     0
cell flash cache read hits                                       .001783371
cell IO uncompressed bytes                                                0


Execution Plan
----------------------------------------------------------
Plan hash value: 2615736477

---------------------------------------------------------------------------------------------
| Id  | Operation                  | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT           |                |     1 |     9 | 31355   (1)| 00:00:02 |
|   1 |  SORT AGGREGATE            |                |     1 |     9 |            |          |
|*  2 |   TABLE ACCESS STORAGE FULL| TST_NCLSPNT_01 |   821K|  7223K| 31355   (1)| 00:00:02 |
---------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter("START_DATE">SYSDATE@!-356)

Note
-----
   - dynamic sampling used for this statement (level=2)


Statistics
----------------------------------------------------------
          0  recursive calls
          0  db block gets
     229559  consistent gets
     114815  physical reads
        148  redo size
        528  bytes sent via SQL*Net to client
        524  bytes received via SQL*Net from client
          2  SQL*Net roundtrips to/from client
          0  sorts (memory)
          0  sorts (disk)
          1  rows processed

		  
		  
		  
===> select /*+ index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

SQL> @stats

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical write total bytes                                                0
physical read total bytes                                         16.140625
cell physical IO interconnect bytes returned by smart scan                0
cell physical IO interconnect bytes                               16.140625
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes saved by storage index                             0
cell physical IO bytes eligible for predicate offload                     0
cell flash cache read hits                                       .001874924
cell IO uncompressed bytes                                                0

SQL> select /*+ index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711015

Elapsed: 00:00:00.81

Execution Plan
----------------------------------------------------------
Plan hash value: 321745442

------------------------------------------------------------------------------------------
| Id  | Operation         | Name                 | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |                      |     1 |     9 |  2003   (1)| 00:00:01 |
|   1 |  SORT AGGREGATE   |                      |     1 |     9 |            |          |
|*  2 |   INDEX RANGE SCAN| TST_NCLSPNT_01_IDX02 |   821K|  7223K|  2003   (1)| 00:00:01 |
------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("START_DATE">SYSDATE@!-356)

Note
-----
   - dynamic sampling used for this statement (level=2)


Statistics
----------------------------------------------------------
          0  recursive calls
          0  db block gets
       1889  consistent gets
       1889  physical reads
      98272  redo size
        528  bytes sent via SQL*Net to client
        524  bytes received via SQL*Net from client
          2  SQL*Net roundtrips to/from client
          0  sorts (memory)
          0  sorts (disk)
          1  rows processed

--=========================> Conclusion, for first call from database, without the IndexStorage is 12 times slower to filter the data and all data from the table is loaded in buffer cache (898MB), but with the IndexStorage 8.50886536 MB only are sent to the database buffer cache
--=========================> index storage is more efficient (faster in time and lower in bytes) then an index BUT:
--=========================> index more efficient once cached than Index storage

SQL> select /*+ no_index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711008

Elapsed: 00:00:00.09
SQL> select /*+ no_index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711008

Elapsed: 00:00:00.11
SQL> select /*+ no_index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711008

Elapsed: 00:00:00.10
SQL> select /*+ no_index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711008

Elapsed: 00:00:00.11
SQL> select /*+ no_index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711008

Elapsed: 00:00:00.10
SQL> select /*+ index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711008

Elapsed: 00:00:00.76
SQL> select /*+ index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711008

Elapsed: 00:00:00.03
SQL> select /*+ index (TST_NCLSPNT_01) */ count(1) from tst_nclspnt_01 where START_DATE > sysdate - 356 ;

  COUNT(1)
----------
    711008

Elapsed: 00:00:00.03



====================================================================================================================================================================================
====================================================================================================================================================================================


create table tst_nclspnt_02 as select * from  ( select * from tst_nclspnt_01 order by DBMS_RANDOM.VALUE ) where rownum <= 1000 ;
 
@fbc
@stats

select count(1) 
from tst_nclspnt_01 x, tst_nclspnt_02 y
where x.id = y.id ;

Elapsed: 00:00:00.40


SQL> @stats

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical write total bytes                                                0
physical read total bytes                                        898.453125
cell physical IO interconnect bytes returned by smart scan       116.104073
cell physical IO interconnect bytes                              117.580635
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes saved by storage index                             0
cell physical IO bytes eligible for predicate offload            896.976563
cell flash cache read hits                                        .00179863
cell IO uncompressed bytes                                       896.976563


---------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
---------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                  |                |     1 |    26 | 17325   (1)| 00:00:01 |        |      |            |
|   1 |  SORT AGGREGATE                   |                |     1 |    26 |            |          |        |      |            |
|   2 |   PX COORDINATOR                  |                |       |       |            |          |        |      |            |
|   3 |    PX SEND QC (RANDOM)            | :TQ10001       |     1 |    26 |            |          |  Q1,01 | P->S | QC (RAND)  |
|   4 |     SORT AGGREGATE                |                |     1 |    26 |            |          |  Q1,01 | PCWP |            |
|*  5 |      HASH JOIN                    |                |  1000 | 26000 | 17325   (1)| 00:00:01 |  Q1,01 | PCWP |            |
|   6 |       BUFFER SORT                 |                |       |       |            |          |  Q1,01 | PCWC |            |
|   7 |        PX RECEIVE                 |                |  1000 | 13000 |     5   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   8 |         PX SEND BROADCAST         | :TQ10000       |  1000 | 13000 |     5   (0)| 00:00:01 |        | S->P | BROADCAST  |
|   9 |          TABLE ACCESS STORAGE FULL| TST_NCLSPNT_02 |  1000 | 13000 |     5   (0)| 00:00:01 |        |      |            |
|  10 |       PX BLOCK ITERATOR           |                |    10M|   135M| 17304   (1)| 00:00:01 |  Q1,01 | PCWC |            |
|  11 |        TABLE ACCESS STORAGE FULL  | TST_NCLSPNT_01 |    10M|   135M| 17304   (1)| 00:00:01 |  Q1,01 | PCWP |            |
---------------------------------------------------------------------------------------------------------------------------------

--==================================================================================================

select /*+ OPT_PARAM('cell_offload_processing' 'false') no_index (TST_NCLSPNT_01) */  count(1) 
from tst_nclspnt_01 x, tst_nclspnt_02 y
where x.id = y.id ;

  COUNT(1)
----------
      1000

Elapsed: 00:00:00.78

SQL> @stats

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical write total bytes                                                0
physical read total bytes                                         898.53125
cell physical IO interconnect bytes returned by smart scan                0
cell physical IO interconnect bytes                               898.53125
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes saved by storage index                             0
cell physical IO bytes eligible for predicate offload                     0
cell flash cache read hits                                       .001818657
cell IO uncompressed bytes                                                0



Execution Plan
----------------------------------------------------------
Plan hash value: 4029056089

---------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
---------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                  |                |     1 |    26 | 17325   (1)| 00:00:01 |        |      |            |
|   1 |  SORT AGGREGATE                   |                |     1 |    26 |            |          |        |      |            |
|   2 |   PX COORDINATOR                  |                |       |       |            |          |        |      |            |
|   3 |    PX SEND QC (RANDOM)            | :TQ10001       |     1 |    26 |            |          |  Q1,01 | P->S | QC (RAND)  |
|   4 |     SORT AGGREGATE                |                |     1 |    26 |            |          |  Q1,01 | PCWP |            |
|*  5 |      HASH JOIN                    |                |  1000 | 26000 | 17325   (1)| 00:00:01 |  Q1,01 | PCWP |            |
|   6 |       BUFFER SORT                 |                |       |       |            |          |  Q1,01 | PCWC |            |
|   7 |        PX RECEIVE                 |                |  1000 | 13000 |     5   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   8 |         PX SEND BROADCAST         | :TQ10000       |  1000 | 13000 |     5   (0)| 00:00:01 |        | S->P | BROADCAST  |
|   9 |          TABLE ACCESS STORAGE FULL| TST_NCLSPNT_02 |  1000 | 13000 |     5   (0)| 00:00:01 |        |      |            |
|  10 |       PX BLOCK ITERATOR           |                |    10M|   135M| 17304   (1)| 00:00:01 |  Q1,01 | PCWC |            |
|  11 |        TABLE ACCESS STORAGE FULL  | TST_NCLSPNT_01 |    10M|   135M| 17304   (1)| 00:00:01 |  Q1,01 | PCWP |            |
---------------------------------------------------------------------------------------------------------------------------------


--==> CONCLUSION beaucoup moins d'espacec utiliser dans le cache en passant par le SmartScan

====================================================================================================================================================================================
====================================================================================================================================================================================
create table tst_nclspnt_03 as select * from  ( select * from tst_nclspnt_01 order by DBMS_RANDOM.VALUE ) where rownum <= 1000 ;
create table tst_nclspnt_04 as select * from  ( select * from tst_nclspnt_01 order by DBMS_RANDOM.VALUE ) where rownum <= 1000 ;

@fbc
@stats

select count(1) 
from tst_nclspnt_01 x, tst_nclspnt_02 y, tst_nclspnt_03 z, tst_nclspnt_02 u
where x.id = y.id
and x.id = z.id
and x.id = u.id ;


  COUNT(1)
----------
         9

Elapsed: 00:00:02.45

-----------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name           | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
-----------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                |     1 |    52 | 17336   (1)| 00:00:01 |        |      |            |
|   1 |  SORT AGGREGATE                     |                |     1 |    52 |            |          |        |      |            |
|   2 |   PX COORDINATOR                    |                |       |       |            |          |        |      |            |
|   3 |    PX SEND QC (RANDOM)              | :TQ10003       |     1 |    52 |            |          |  Q1,03 | P->S | QC (RAND)  |
|   4 |     SORT AGGREGATE                  |                |     1 |    52 |            |          |  Q1,03 | PCWP |            |
|*  5 |      HASH JOIN                      |                |     1 |    52 | 17336   (1)| 00:00:01 |  Q1,03 | PCWP |            |
|*  6 |       HASH JOIN                     |                |     1 |    39 | 17330   (1)| 00:00:01 |  Q1,03 | PCWP |            |
|*  7 |        HASH JOIN                    |                |  1000 | 26000 | 17325   (1)| 00:00:01 |  Q1,03 | PCWP |            |
|   8 |         BUFFER SORT                 |                |       |       |            |          |  Q1,03 | PCWC |            |
|   9 |          PX RECEIVE                 |                |  1000 | 13000 |     5   (0)| 00:00:01 |  Q1,03 | PCWP |            |
|  10 |           PX SEND BROADCAST         | :TQ10000       |  1000 | 13000 |     5   (0)| 00:00:01 |        | S->P | BROADCAST  |
|  11 |            TABLE ACCESS STORAGE FULL| TST_NCLSPNT_02 |  1000 | 13000 |     5   (0)| 00:00:01 |        |      |            |
|  12 |         PX BLOCK ITERATOR           |                |    10M|   135M| 17304   (1)| 00:00:01 |  Q1,03 | PCWC |            |
|  13 |          TABLE ACCESS STORAGE FULL  | TST_NCLSPNT_01 |    10M|   135M| 17304   (1)| 00:00:01 |  Q1,03 | PCWP |            |
|  14 |        BUFFER SORT                  |                |       |       |            |          |  Q1,03 | PCWC |            |
|  15 |         PX RECEIVE                  |                |  1000 | 13000 |     5   (0)| 00:00:01 |  Q1,03 | PCWP |            |
|  16 |          PX SEND BROADCAST          | :TQ10001       |  1000 | 13000 |     5   (0)| 00:00:01 |        | S->P | BROADCAST  |
|  17 |           TABLE ACCESS STORAGE FULL | TST_NCLSPNT_02 |  1000 | 13000 |     5   (0)| 00:00:01 |        |      |            |
|  18 |       BUFFER SORT                   |                |       |       |            |          |  Q1,03 | PCWC |            |
|  19 |        PX RECEIVE                   |                |  1009 | 13117 |     6   (0)| 00:00:01 |  Q1,03 | PCWP |            |
|  20 |         PX SEND BROADCAST           | :TQ10002       |  1009 | 13117 |     6   (0)| 00:00:01 |        | S->P | BROADCAST  |
|  21 |          TABLE ACCESS STORAGE FULL  | TST_NCLSPNT_03 |  1009 | 13117 |     6   (0)| 00:00:01 |        |      |            |
-----------------------------------------------------------------------------------------------------------------------------------


SQL> @stats

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical write total bytes                                                0
physical read total bytes                                        898.578125
cell physical IO interconnect bytes returned by smart scan       116.104073
cell physical IO interconnect bytes                              117.705635
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes saved by storage index                             0
cell physical IO bytes eligible for predicate offload            896.976563
cell flash cache read hits                                        .00179863
cell IO uncompressed bytes                                       896.976563




select  /*+ OPT_PARAM('cell_offload_processing' 'false') */ count(1) 
from tst_nclspnt_01 x, tst_nclspnt_02 y, tst_nclspnt_03 z, tst_nclspnt_02 u
where x.id = y.id
and x.start_date = z.start_date
and x.SALARY = u.SALARY ;

  COUNT(1)
----------
         9

Elapsed: 00:00:00.97

Execution Plan
----------------------------------------------------------
Plan hash value: 35105254

-----------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name           | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
-----------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                |     1 |    70 | 17351   (1)| 00:00:01 |        |      |            |
|   1 |  SORT AGGREGATE                     |                |     1 |    70 |            |          |        |      |            |
|   2 |   PX COORDINATOR                    |                |       |       |            |          |        |      |            |
|   3 |    PX SEND QC (RANDOM)              | :TQ10003       |     1 |    70 |            |          |  Q1,03 | P->S | QC (RAND)  |
|   4 |     SORT AGGREGATE                  |                |     1 |    70 |            |          |  Q1,03 | PCWP |            |
|*  5 |      HASH JOIN                      |                |     1 |    70 | 17351   (1)| 00:00:01 |  Q1,03 | PCWP |            |
|*  6 |       HASH JOIN                     |                |     1 |    61 | 17345   (1)| 00:00:01 |  Q1,03 | PCWP |            |
|*  7 |        HASH JOIN                    |                |  1000 | 48000 | 17340   (1)| 00:00:01 |  Q1,03 | PCWP |            |
|   8 |         BUFFER SORT                 |                |       |       |            |          |  Q1,03 | PCWC |            |
|   9 |          PX RECEIVE                 |                |  1000 | 13000 |     5   (0)| 00:00:01 |  Q1,03 | PCWP |            |
|  10 |           PX SEND BROADCAST         | :TQ10000       |  1000 | 13000 |     5   (0)| 00:00:01 |        | S->P | BROADCAST  |
|  11 |            TABLE ACCESS STORAGE FULL| TST_NCLSPNT_02 |  1000 | 13000 |     5   (0)| 00:00:01 |        |      |            |
|  12 |         PX BLOCK ITERATOR           |                |    10M|   365M| 17318   (1)| 00:00:01 |  Q1,03 | PCWC |            |
|  13 |          TABLE ACCESS STORAGE FULL  | TST_NCLSPNT_01 |    10M|   365M| 17318   (1)| 00:00:01 |  Q1,03 | PCWP |            |
|  14 |        BUFFER SORT                  |                |       |       |            |          |  Q1,03 | PCWC |            |
|  15 |         PX RECEIVE                  |                |  1000 | 13000 |     5   (0)| 00:00:01 |  Q1,03 | PCWP |            |
|  16 |          PX SEND BROADCAST          | :TQ10001       |  1000 | 13000 |     5   (0)| 00:00:01 |        | S->P | BROADCAST  |
|  17 |           TABLE ACCESS STORAGE FULL | TST_NCLSPNT_02 |  1000 | 13000 |     5   (0)| 00:00:01 |        |      |            |
|  18 |       BUFFER SORT                   |                |       |       |            |          |  Q1,03 | PCWC |            |
|  19 |        PX RECEIVE                   |                |  1009 |  9081 |     6   (0)| 00:00:01 |  Q1,03 | PCWP |            |
|  20 |         PX SEND BROADCAST           | :TQ10002       |  1009 |  9081 |     6   (0)| 00:00:01 |        | S->P | BROADCAST  |
|  21 |          TABLE ACCESS STORAGE FULL  | TST_NCLSPNT_03 |  1009 |  9081 |     6   (0)| 00:00:01 |        |      |            |
-----------------------------------------------------------------------------------------------------------------------------------



SQL> @stats

NAME                                                                     MB
---------------------------------------------------------------- ----------
physical write total bytes                                                0
physical read total bytes                                        898.757813
cell physical IO interconnect bytes returned by smart scan                0
cell physical IO interconnect bytes                              898.757813
cell physical IO bytes sent directly to DB node to balance CPU            0
cell physical IO bytes saved during optimized file creation               0
cell physical IO bytes saved during optimized RMAN file restore           0
cell physical IO bytes saved by storage index                             0
cell physical IO bytes eligible for predicate offload                     0
cell flash cache read hits                                       .001818657
cell IO uncompressed bytes                                                0




--==> CONCLUSION => quand le storage index n'est pas utiliser les offload sur les cells sont moins performant qu'en DB, il vaut mieux ramer 1GB et les trier en Buffer Cache que laisser faire les Cells qui ramene juste les 5MB de resultat



