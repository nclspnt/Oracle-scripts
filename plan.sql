@display_configuration.sql

SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR('&sql_id.',&child.));
