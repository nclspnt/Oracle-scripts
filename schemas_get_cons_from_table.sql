@display_configuration.sql



select CONSTRAINT_NAME,
CONSTRAINT_TYPE,
SEARCH_CONDITION,
R_OWNER,
R_CONSTRAINT_NAME,
DELETE_RULE,
STATUS,
DEFERRABLE,
DEFERRED,
VALIDATED,
GENERATED
from dba_constraints
where table_name = UPPER('&table_name.')
AND  owner = UPPER('&owner.')
;