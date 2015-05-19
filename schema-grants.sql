@display_configuration.sql
set serveroutput on

def v_schema_name=&schema_name.

set verify off 


prompt ## ==================== dba_role_privs
select granted_role, ADMIN_OPTION from dba_role_privs where grantee='&v_schema_name.' order by granted_role;


prompt ## ==================== dba_sys_privs
select privilege, ADMIN_OPTION from dba_sys_privs where grantee='&v_schema_name.' order by privilege;


prompt ## ==================== dba_tab_privs
select privilege, owner, table_name, grantor from dba_tab_privs where grantee='&v_schema_name.' order by owner, table_name, privilege;


--dba_users info
--dba_ts_quotas info
