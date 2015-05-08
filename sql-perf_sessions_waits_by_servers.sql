@display_configuration.sql


select
x.MACHINE,
x.OSUSER,
x.username,
x.service_name,
x.server,
count(1)
from gv$session x
where x.username is not null
group by 
x.MACHINE,
x.OSUSER,
x.username,
x.service_name,
x.server
order by 1, 2 ;
