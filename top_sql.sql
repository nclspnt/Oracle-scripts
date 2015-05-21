@display_configuration.sql

set feedback off timi off serveroutput on

prompt
prompt ## == top 5 queries by ranges of 5 minutes (elapsed time)


Declare

	v_StartTime number ;
	v_EndTime number ;
	v_step number := 5 ;
		
begin

	for C_NbOfRange in 0..11 loop

		v_EndTime := C_NbOfRange * v_step;
		v_StartTime := (C_NbOfRange+1) * v_step; 
	
	    dbms_output.put_line ( chr(10) || ' ## == From => ' ||  to_char(sysdate - v_StartTime/60/24) || ' to  => ' || to_char(sysdate - v_EndTime/60/24) || chr(10) ) ;

		dbms_output.put_line ( 'session_type'||chr(9)||'sql_id      '||chr(9)||rpad('nb_avg_sess', 15, ' ')||chr(9)||rpad('tm_delta_time_second', 15, ' ') ) ;
		dbms_output.put_line ( lpad('-', 15, '-')||chr(9)||lpad('-', 15, '-')||chr(9)||lpad('-', 15, '-')||chr(9)||lpad('-', 15, '-') ) ;

		for C_Sql in (
		select *  from
		( select 
		session_type,
		sql_id, 
		round(count(distinct SESSION_ID||','||SESSION_SERIAL#)/60/5,2) nb_avg_sess,
		round(sum(TM_DELTA_TIME+TM_DELTA_CPU_TIME+TM_DELTA_DB_TIME)/1000000,2) tm_delta_time_second
		from gv$active_session_history  
		where sample_time > sysdate - v_StartTime/60/24
		and   sample_time <= sysdate - v_EndTime/60/24
		group by  SESSION_TYPE, sql_id 
		order by 4 desc 
		) where rownum <= 5 
		and tm_delta_time_second is not null 
		and sql_id is not null 
		) loop
		
			dbms_output.put_line ( C_Sql.session_type||chr(9)||C_Sql.sql_id ||chr(9)||lpad(C_Sql.nb_avg_sess, 15, ' ')||chr(9)||lpad(C_Sql.tm_delta_time_second, 15, ' ') ) ;
		
		end loop ;

	end loop;

end;
/
