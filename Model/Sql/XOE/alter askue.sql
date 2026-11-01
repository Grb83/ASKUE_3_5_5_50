
CREATE TABLE ASKUE.ASKUELOG
(
   NROOT                      NUMBER(10,0) NOT NULL,
   NCLASS                     NUMBER(3,0) NOT NULL)
/

 COMMENT ON TABLE ASKUE.ASKUELOG IS
'Журнал экспортируемых данных, по которым были изменения'
/

 COMMENT ON COLUMN ASKUE.ASKUELOG.NROOT IS
'Ид объекта'
/

 COMMENT ON COLUMN ASKUE.ASKUELOG.NCLASS IS
'Класс таблицы объекта'
/

grant insert on askuelog to rs
/

CREATE DATABASE LINK askue
CONNECT TO ryda IDENTIFIED BY tyda
USING 'askue'
/

CREATE TABLE pointimportinaskue
 (
  npoint                     NUMBER(10),
  norder                     NUMBER(32) NOT NULL,
  nerror                     NUMBER(10),
  verror                     VARCHAR2(2000)
 )
/
COMMENT ON TABLE pointimportinaskue IS 'Импорт данных в АСКУЭ'
/
COMMENT ON COLUMN pointimportinaskue.nerror IS 'Код ошибки'
/
COMMENT ON COLUMN pointimportinaskue.npoint IS 'Ид точки'
/
COMMENT ON COLUMN pointimportinaskue.verror IS 'Текст ошибки'
/
COMMENT ON COLUMN pointimportinaskue.norder IS 'Служебный'
/
-- Indexes for pointimportinaskue
ALTER TABLE pointimportinaskue
 ADD CONSTRAINT pointimportinaskue_pk PRIMARY KEY (npoint)
 USING INDEX
  TABLESPACE amsind
/
ALTER TABLE pointimportinaskue
 ADD CONSTRAINT pointimportinaskue_f1 FOREIGN KEY (npoint)
      REFERENCES ss.ssPOINT(npoint) ON DELETE CASCADE
/

CREATE INDEX POINTIMPORTINASKUE_IDX1
ON POINTIMPORTINASKUE
 (  NORDER
 )
TABLESPACE AMSIND
/

-- Table groupimportinaskue
CREATE TABLE groupimportinaskue
 (
  ngroup                     NUMBER(10),
  nerror                     NUMBER(10),
  verror                     VARCHAR2(2000)
 )
/
COMMENT ON TABLE groupimportinaskue IS 'Импорт данных в АСКУЭ'
/
COMMENT ON COLUMN groupimportinaskue.nerror IS 'Код ошибки'
/
COMMENT ON COLUMN groupimportinaskue.ngroup IS 'Ид группы'
/
COMMENT ON COLUMN groupimportinaskue.verror IS 'Текст ошибки'
/
-- Indexes for groupimportinaskue
ALTER TABLE groupimportinaskue
 ADD CONSTRAINT groupimportinaskue_pk PRIMARY KEY (ngroup)
 USING INDEX
  TABLESPACE amsind
/
ALTER TABLE groupimportinaskue
 ADD CONSTRAINT groupimportinaskue_f1 FOREIGN KEY (ngroup)
      REFERENCES ss.ssGROUP(ngroup) ON DELETE CASCADE
/

-- End of DDL script for groupimportinaskue
CREATE SEQUENCE importinaskue_s
 INCREMENT BY 1
 START WITH 1000
 MINVALUE 1
 MAXVALUE 999999999999999999999999999
 NOCYCLE
 NOORDER
 CACHE 20
/



-- Generated 17-ноя-02  3:01:55 pm
CREATE TABLE jobs
 (
  njob                       NUMBER(10) NOT NULL,
  ddate                      DATE NOT NULL,
  nerror                     NUMBER(10),
  verrortext                 VARCHAR2(2000)
 )
/
-- Constraints for JOBS
ALTER TABLE jobs
 ADD CONSTRAINT pk_jobs PRIMARY KEY (njob,ddate)
 USING INDEX
  TABLESPACE amsind
/

COMMENT ON TABLE jobs IS 'Фоновые процессы'
/
COMMENT ON COLUMN jobs.njob IS 'Ид процесса'
/
COMMENT ON COLUMN jobs.ddate IS 'Дата выполнения'
/
COMMENT ON COLUMN jobs.nerror IS 'Код завершения'
/
COMMENT ON COLUMN jobs.verrortext IS 'Текст ожибки'
/

-- End of DDL script for JOBS


-- Start of DDL script for JOBS
-- Generated 28-ноя-02  11:22:40 am
-- from ea-ASKUE:5
CREATE TABLE lastjobs
 (
  njob                       NUMBER(10) NOT NULL,
  ddate                      DATE NOT NULL,
  nerror                     NUMBER(10),
  verrortext                 VARCHAR2(2000)
 )
/
COMMENT ON TABLE lastjobs IS 'Фоновые процессы последние данные'
/
COMMENT ON COLUMN lastjobs.ddate IS 'Дата выполнения'
/
COMMENT ON COLUMN lastjobs.nerror IS 'Код завершения'
/
COMMENT ON COLUMN lastjobs.njob IS 'Ид процесса'
/
COMMENT ON COLUMN lastjobs.verrortext IS 'Текст ожибки'
/
ALTER TABLE lastjobs
 ADD CONSTRAINT pk_lastjobs PRIMARY KEY (njob)
 USING INDEX
  TABLESPACE amsind
/
