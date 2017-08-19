set lines 200 pages 200
select name, round(sum(value)/1024/1024/1024/1024,2) as tb , round(sum(value)/1024/1024/1024,2) as gb , round(sum(value)/1024/1024,2) as mb 
from gv$statname sn 
natural join gv$sysstat ss 
natural join gv$instance i
where name in (
'cell physical IO interconnect bytes returned by smart scan',
'cell physical IO bytes saved by storage index',
'physical read total bytes'
)
group by name
order by 1, 2 ;
