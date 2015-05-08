@display_configuration.sql

set long 50000 longc 50000

select
sql_text
from
v$sql
where sql_id = '&sql_id.'
;