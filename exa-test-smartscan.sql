=======================> MYSTATS
set timing on
set lines 200 pages 200
alter system flush buffer_cache ;

select sn.name, ms.value/1024/1024 MB
from v$mystat ms natural join v$statname sn
where sn.name in ('physical read total bytes', 'physical write total bytes', 'cell IO uncompressed bytes')
or sn.name like 'cell phy%' 
order by 1 desc ;


=======================> LOAD
-- test
drop table TEST_EASYTEAM purge ;

create table TEST_EASYTEAM ( id number, firstname varchar2(50), lastname varchar2(50), start_date date, salary number ) ;

insert into TEST_EASYTEAM
select level, dbms_random.string('L', 20), dbms_random.string('L', 20),  sysdate - dbms_random.value(1,5000), dbms_random.value(60000,1000000)
from dual 
connect by level < 1000000 ;



=======================> HCC
set lines 200 pages 200

select segment_name, sum(bytes)/1024/1024 total_space_mb
from dba_segments
where owner = 'SYS'
and segment_name = 'TEST_EASYTEAM'
group by segment_name;

select OWNER, TABLE_NAME, NUM_ROWS, FLASH_CACHE, CELL_FLASH_CACHE, COMPRESSION, COMPRESS_FOR, RESULT_CACHE 
from dba_tables 
where OWNER = 'SYS' 
and table_name = 'TEST_EASYTEAM' ;


alter table TEST_EASYTEAM move compress for query high;
alter table TEST_EASYTEAM move compress for query low;
alter table TEST_EASYTEAM move compress for archive high;
alter table TEST_EASYTEAM move compress for archive low;


=======================> Keep flash cache

alter table TEST_EASYTEAM storage (cell_flash_cache keep);

select OWNER, TABLE_NAME, NUM_ROWS, FLASH_CACHE, CELL_FLASH_CACHE, COMPRESSION, COMPRESS_FOR, RESULT_CACHE 
from dba_tables 
where OWNER = 'SYS' 
and table_name = 'TEST_EASYTEAM' ;


=======================> cell smart cache test

alter session set cell_offload_processing = false ;

select /*+ OPT_PARAM('cell_offload_processing' 'false') */ * from TEST_EASYTEAM where id = 43686 ;
select * from TEST_EASYTEAM where id = 43686 ;

set timi on serveroutput on
alter system flush buffer_cache ;
declare
  i number := 0 ;
  nb number ;
  v_id number ;
begin
  while i <= 50 loop
  v_id := round(dbms_random.value(1,1000000)) ;
  --select  /*+ OPT_PARAM('cell_offload_processing' 'true') */ count(1) into nb from TEST_EASYTEAM where id = v_id ;
  --select  /*+ OPT_PARAM('cell_offload_processing' 'false') */ count(1) into nb from TEST_EASYTEAM where id = v_id ;
  --select  /*+ no_index (TEST_EASYTEAM) */ count(1) into nb from TEST_EASYTEAM where id = v_id ;
  --select  /*+ parallel (8) */ count(1) into nb from TEST_EASYTEAM where id = v_id ;
  select count(1) into nb from TEST_EASYTEAM where START_DATE > sysdate - 356 ;
 dbms_output.put_line(' ---> '||v_id);
  i := i+1 ;
  end loop ;
end;
/


select count(1) from TEST_EASYTEAM where  START_DATE > sysdate - 356 ;
select /*+ OPT_PARAM('cell_offload_processing' 'false') */ count(1) from TEST_EASYTEAM where  START_DATE > sysdate - 356 ;







