@display_configuration.sql



select snap_id, BEGIN_INTERVAL_TIME 
from dba_hist_snapshot 
where BEGIN_INTERVAL_TIME  > sysdate - &nb_of_days_before. order by 1 ;