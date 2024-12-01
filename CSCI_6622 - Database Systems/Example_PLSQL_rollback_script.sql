set pagesize 50000 linesize 32767 trimspool on time on timing on echo off feedback off define off sqlblanklines on
spool c:\INC601087_Major_Codes_ROLLBACK.log
spool
select user, to_char(sysdate, 'dd-Mon-yyyy (Dy) hh:mi:ss a.m.') as "Process Date/Time Stamp", instance_name, host_name, version from v$instance;
set echo on feedback 1 colsep '	'
set termout off

-----------------------------SCRIPT BEGINS HERE----------------------------------------------------------------------

DECLARE
/****************************************************************
* Remedy: INC529116
* Author: Zhou Howard
* Date: June 1, 2015
* Description: For the list of ID numbers found in the source document under this Remedy
ID in the EBAS Remedy requests subfolder:

If ENTITY.pref_class_yr = blank/null AND ENTITY_RECORD_TYPE.class.year =
blank=null, make pref_class_yr and class_year = DEGREE.degree_year where
DEGREE.school = LW and DEGREE.degree.type = "U".

If pref class yr or class.yr is not blank/null, list in exception report,
and perform no update
If there is no DEGREE record where school = LW, , list in exception report,
and perform no update
If degree.type is blank/null, list in exception report, and perform no
update

* Revised: July 22, 2015 - Added date_modified and operator_name

*****************************************************************/
   --Exception handling variables
   stoo_error           INTEGER;
   stoo_rowcnt          INTEGER;
   stoo_errmsg          VARCHAR2 (1000 BYTE);
   i_raise_msg          VARCHAR2 (1000 BYTE);
   i_raise_code         INTEGER;
   
   --Internal variable
   i_id_number          VARCHAR2(10 BYTE);
   i_degree_year        VARCHAR2(4 BYTE);
   
   --Flags
   f_skip               NUMBER;
   f_found_degree       NUMBER;
   f_update_made        NUMBER;
   
   CURSOR osgoode_cleanup
   IS (SELECT decode(trim(y.ID_NUMBER), null, ' ', lpad(trim(y.ID_NUMBER), 10, '0')) as "ID_NUMBER"
        FROM advance.y_temp_inc529116 y);
        
BEGIN

    i_raise_code := -20905;
    
    FOR rec IN osgoode_cleanup 
    LOOP

        i_id_number := '';
        f_skip := 0;
        f_found_degree := 0;
        f_update_made := 0;
        
        --Check for record with empty class_year and pref_clear_year
        BEGIN
            SELECT en.id_number
            INTO i_id_number
            FROM advance.entity en, advance.entity_record_type ert
            WHERE en.id_number = ert.id_number
            AND en.id_number = rec.id_number
            AND trim(en.pref_class_year) IS NULL
            AND trim(ert.class_year) IS NULL
            AND ert.record_type_code = 'AL';
            
            IF (SQL%ROWCOUNT <> 0) THEN
                f_skip := 0;
            END IF;
        EXCEPTION
            WHEN too_many_rows THEN
                f_skip := 1;
            WHEN no_data_found THEN
                f_skip := 1;
            WHEN others THEN
                f_skip := 1;    
        END;
        
        --If found, check for degree record
        IF f_skip = 0 THEN
            BEGIN
                SELECT d.degree_year
                INTO i_degree_year
                FROM advance.degrees d
                WHERE d.id_number = rec.id_number
                AND d.school_code = 'LW'
                AND d.degree_level_code = 'U';
                
                IF (SQL%ROWCOUNT <> 0) THEN
                    f_found_degree := 1;
                END IF; 
            EXCEPTION
                WHEN too_many_rows THEN
                    f_found_degree := 0;
                WHEN no_data_found THEN
                    f_found_degree := 0;
                WHEN others THEN
                    f_found_degree := 0;
            END;
            
            --When matching degree is found, update degree year in ENTITY and ENTITY_RECORD_TYPE
            IF f_found_degree = 1 THEN
                BEGIN
                    UPDATE advance.entity
                        SET pref_class_year = i_degree_year,
							date_modified = sysdate,
							operator_name = 'YUBATCH'
                    WHERE id_number = rec.id_number;
                    
                    IF (SQL%ROWCOUNT <> 0) THEN
                        f_update_made := 1;
                    END IF;
                EXCEPTION
                    WHEN others THEN
                        f_update_made := 0;
                        stoo_errmsg := SUBSTR (SQLERRM, 1, 1000);
                        i_raise_msg := 'Entity update error :' || stoo_errmsg;
                        GOTO l_error;
                END;
                
                BEGIN
                    UPDATE advance.entity_record_type
                        SET class_year = i_degree_year,
							date_modified = sysdate,
							operator_name = 'YUBATCH'
                    WHERE id_number = rec.id_number
                    AND record_type_code = 'AL';
                    
                    IF (SQL%ROWCOUNT <> 0) THEN
                        f_update_made := 1;
                    END IF;
                EXCEPTION
                    WHEN others THEN
                        f_update_made := 0;
                        stoo_errmsg := SUBSTR (SQLERRM, 1, 1000);
                        i_raise_msg := 'Entity Record Type update error :' || stoo_errmsg;
                        GOTO l_error;
                END;
                
                --When a successfull update has been made
                IF f_update_made = 1 THEN
                    BEGIN
                        UPDATE advance.y_temp_inc529116
                            SET status = 'UPDATED',
                                timestamp = sysdate,
                                message = 'Successfully updated'
                        WHERE decode(trim(ID_NUMBER), null, ' ', lpad(trim(ID_NUMBER), 10, '0')) = rec.id_number;
                    EXCEPTION
                    WHEN others THEN
                        stoo_errmsg := SUBSTR (SQLERRM, 1, 1000);
                        i_raise_msg := 'Update error :' || stoo_errmsg;
                        GOTO l_error;
                    END;   
                END IF;     
            ELSE
                BEGIN
                        UPDATE advance.y_temp_inc529116
                            SET status = 'EXCEPTION',
                                timestamp = sysdate,
                                message = 'Matching DEGREE record not found'
                        WHERE decode(trim(ID_NUMBER), null, ' ', lpad(trim(ID_NUMBER), 10, '0')) = rec.id_number;
                EXCEPTION
                WHEN others THEN
                    stoo_errmsg := SUBSTR (SQLERRM, 1, 1000);
                    i_raise_msg := 'Update error :' || stoo_errmsg;
                    GOTO l_error;
                END;   
            END IF;
            
        ELSE
            BEGIN
                        UPDATE advance.y_temp_inc529116
                            SET status = 'EXCEPTION',
                                timestamp = sysdate,
                                message = 'CLASS_YEAR or PREF_CLASS_YEAR not blank'
                        WHERE decode(trim(ID_NUMBER), null, ' ', lpad(trim(ID_NUMBER), 10, '0')) = rec.id_number;
            EXCEPTION
            WHEN others THEN
                stoo_errmsg := SUBSTR (SQLERRM, 1, 1000);
                i_raise_msg := 'Update error :' || stoo_errmsg;
                GOTO l_error;
            END;
                
        END IF;
    END LOOP;
    GOTO l_exit;

     <<l_error>>
     ROLLBACK;
     RAISE_APPLICATION_ERROR(i_raise_code, i_raise_msg);
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
