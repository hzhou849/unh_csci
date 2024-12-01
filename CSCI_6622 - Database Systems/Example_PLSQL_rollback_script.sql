set pagesize 50000 linesize 32767 trimspool on time on timing on echo off feedback off define off sqlblanklines on
spool c:\INC601087_Major_Codes_ROLLBACK.log
spool
select user, to_char(sysdate, 'dd-Mon-yyyy (Dy) hh:mi:ss a.m.') as "Process Date/Time Stamp", instance_name, host_name, version from v$instance;
set echo on feedback 1 colsep '	'
set termout off

-----------------------------SCRIPT BEGINS HERE----------------------------------------------------------------------

DECLARE
-- validating data
  i_count                    INTEGER;
  i_new_xsequence        INTEGER;
  

--Exception handling Variables
   i_raise_msg    VARCHAR2 (1000 BYTE);
   i_raise_code   INTEGER;
   
   --Cursor (pulls data from QA staging table)
  CURSOR major_cleanup_cur IS
    SELECT id_number, xsequence, major_code1, major_code2  FROM advance.y_degree_upd_stg; 

BEGIN

    i_count := 0;
    i_new_xsequence := 0;
    
    --Restore the DEGREES table from backup
    BEGIN
		UPDATE advance.degrees
		SET degrees.major_code1 = (select a.major_code1 from degrees_bak a
						   where a.id_number =degrees.id_number
						   and a.xsequence = degrees.xsequence),

		 degrees.major_code2 = (select a.major_code2 from degrees_bak a
						   where a.id_number =degrees.id_number
						   and a.xsequence = degrees.xsequence),
							   
		 degrees.school_code = (select a.school_code from degrees_bak a
						   where a.id_number =degrees.id_number
						   and a.xsequence = degrees.xsequence)                                


		WHERE (degrees.id_number, degrees.xsequence) IN (SELECT id_number, xsequence FROM y_degree_upd_stg);

        
    EXCEPTION WHEN OTHERS THEN
        i_raise_msg := 'advance.degrees ROLLBACK ERROR';
        GOTO l_error;
    END;
    
    
    BEGIN
    
		FOR cur IN major_cleanup_cur LOOP
		 
		     --Check to see if entry is >1 
		     SELECT COUNT (*)
		     INTO i_count
		     FROM advance.xcomment_bak a
		     WHERE a.id_number = cur.id_number
		     AND a.xsequence = (SELECT  MAX(xsequence) FROM xcomment_bak WHERE id_number = a.id_number  );
		   
		     --Get the xsequence from backup +1 ( the new entry we are going to delete)
		     
		     --0 = account was not found in XCOMMENT backup --> delete XSEQUENCE 1
		     IF (i_count = 0) THEN
			     BEGIN
				  DELETE  FROM advance.xcomment
				  WHERE xcomment.id_number = cur.id_number
				  AND xcomment.xsequence = 1;
			     END;
		     
		     ELSIF (i_count >0) THEN
		         BEGIN
				  SELECT MAX (xsequence) +1
				  INTO i_new_xsequence
				  FROM advance.xcomment_bak
				  WHERE id_number = cur.id_number;
			     
				  DELETE FROM advance.xcomment
				  WHERE xcomment.id_number = cur.id_number
				  AND xcomment.xsequence = i_new_xsequence;
			     
			     
			     EXCEPTION WHEN OTHERS THEN
				  i_raise_msg :='advance.xcomment ROLLBACK ERROR'; 
			  
		     END;
		     
		 END IF;
        

    
         END LOOP;   
         GOTO l_exit;
    END;
    

    

GOTO l_exit;

    <<l_error>>
    ROLLBACK;
    RAISE_APPLICATION_ERROR (i_raise_code, i_raise_msg);
    RETURN;
    
    <<l_exit>>
    COMMIT;
    RETURN;

END;
/


-----------------------------SCRIPT ENDS HERE------------------------------------------------------------------------
set termout on

set echo off feedback off
select user, to_char(sysdate, 'dd-Mon-yyyy (Dy) hh:mi:ss a.m.') as "Process Date/Time Stamp", instance_name, host_name, version from v$instance;

spool off
set pagesize 14 linesize 80 trimspool OFF time OFF timing OFF echo OFF feedback 6 define '&' sqlblanklines OFF
-- exit
