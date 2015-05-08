--
-- Copyright (c) 1988, 2005, Oracle.  All Rights Reserved.
--
-- NAME
--   glogin.sql
--
-- DESCRIPTION
--   SQL*Plus global login "site profile" file
--
--   Add any SQL*Plus commands here that are to be executed when a
--   user starts SQL*Plus, or uses the SQL*Plus CONNECT command.
--
-- USAGE
--   This script is automatically run
--



set lines 2000 
set pages 2000
set timi on
set time on

set sqlprompt "_USER'@'_CONNECT_IDENTIFIER> "

SET TERMOUT OFF 
DEFINE sqlprompt=none
COLUMN sqlprompt NEW_VALUE sqlprompt
SELECT 
LOWER(SYS_CONTEXT('USERENV','CURRENT_USER')) || '@' || SYS_CONTEXT('USERENV','DB_UNIQUE_NAME')||'['||host_name||']' as sqlprompt 
FROM v$instance ;
SET SQLPROMPT '&sqlprompt> '
UNDEFINE sqlprompt
SET TERMOUT ON