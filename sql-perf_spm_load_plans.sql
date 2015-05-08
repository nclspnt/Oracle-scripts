@display_configuration.sql


declare
  v_ret number ;
begin

  v_ret := DBMS_SPM.LOAD_PLANS_FROM_CURSOR_CACHE ( -
  sql_id 			=> '&sql_id.', -
  plan_hash_value 	=> '&plan_hash_value.', -
  fixed			 	=> '&fixed_NO_YES.', -
  enabled 			=> '&enabled_NO_YES.' ) ;

end;
/

