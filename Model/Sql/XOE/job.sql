declare
jobno number;
--------------------------
BEGIN
    dbms_job.submit(jobno, 'SS.ssimportinaskue_pg.import_p;',sysdate+1/1440,'sysdate+1/288');
--    dbms_job.remove(61);
    commit;
END; -- Procedure

