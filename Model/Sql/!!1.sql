select * from tmp_saa

SELECT   t.id, a.sname name,o.*,a.*
                  FROM identifiedobject o, attributes t, assocallowed a
                 WHERE o.id = 2001 AND o.classid = t.classid AND t.id = a.sattrib
              ORDER BY t.nsort, t.id
              
select * from IDENTIFIEDOBJECT where id=2001              
select * from classes where TABLENAME <>'NOT APPLICABLE' connect by prior id=parent start with parent is null

declare
ln_k number;
ln_start number;
begin
SELECT MAX(ID) INTO ln_start FROM ATTRIBUTES;
 for lc in (select c.*,c1.COMMENTS from classes c,USER_TAB_COMMENTS c1 where c.TABLENAME <>'NOT APPLICABLE' and c.TABLENAME=c1.TABLE_NAME(+)) loop
  ln_k:=1;
  for lc1 in (select c.*,c1.COMMENTS from user_tab_columns c,USER_COL_COMMENTS c1 where c.TABLE_NAME=lc.TABLENAME and c.TABLE_NAME=c1.TABLE_NAME(+) and  c.COLUMN_NAME=c1.COLUMN_NAME(+)) loop
   update ATTRIBUTES set NSORT=lc1.COLUMN_ID,DESCRIPTION=nvl(DESCRIPTION,lc1.COMMENTS) where CLASSID=lc.ID and COLUMNNAME=lc1.COLUMN_NAME;
   if sql%rowcount=0 then
    ln_start:=ln_start+1;
    insert into  ATTRIBUTES(ID,    CLASSID,    ATTRNAME,    ATTRTYPE,    COLUMNNAME,    DESCRIPTION,    NSORT)
    values(ln_start,lc.ID,lc1.COLUMN_NAME,4,lc1.COLUMN_NAME,lc1.COMMENTS,lc1.COLUMN_ID);
   end if;
  end loop;
  delete from ATTRIBUTES where CLASSID=lc.ID and COLUMNNAME not in (select COLUMN_NAME from user_tab_columns where TABLE_NAME=lc.TABLENAME);
  update classes set DESCRIPTION=nvl(DESCRIPTION,lc.COMMENTS) where id=lc.id;
 end loop;
end;


select * from user_tab_columns
select * from USER_TAB_COMMENTS

select * from user_tab_columns
where TABLE_NAME=lc.TABLENAME
select * from user_tab_columns where TABLE_NAME=lc.TABLENAME





select * from user_tab_columns --where TABLE_NAME=
select * from user_tab_columns
select *  from ATTRIBUTES a,classes c where a.classid=c.id order by TABLENAME,NSORT

select * from ATTRIBUTES

select * from user_tables where TABLE_NAME  NOT in (select TABLENAME from classes) ORDER BY 1

select count(*) from ATTRIBUTES 
delete from 
select * from classes ORDER BY 1
where CLASSID=4

delete from ATTRIBUTES WHERE COLUMNNAME='NOT APPLICABLE'
CREATE TABLE ATTRIBUTES1 AS SELECT * FROM ATTRIBUTES
CREATE TABLE ASSOCALLOWED1 AS SELECT * FROM ASSOCALLOWED

select * from classes where TABLENAME ='NOT APPLICABLE'

select * from ATTRIBUTES
 where id in
(select id from auxtype) order by 1

select c.*,c1.COMMENTS from classes c,USER_TAB_COMMENTS c1 where c.TABLENAME <>'NOT APPLICABLE' and c.TABLENAME=c1.TABLE_NAME(+)



insert into ASSOCALLOWED(    ID,    SATTRIB,    DATTRIB,    SNAME,    DNAME,    STYPE,    DTYPE,    ISAGGREGATION) 
--select c.TABLE_NAME,cl.COLUMN_NAME,c1.TABLE_NAME,cl1.COLUMN_NAME
select CLASSES_SEQ.nextval,a.id,a1.id,cs1.CLASSNAME,cs.CLASSNAME,1,0,0
from user_constraints c,USER_CONS_COLUMNS cl,user_constraints c1,USER_CONS_COLUMNS cl1,classes cs,classes cs1,ATTRIBUTES a,ATTRIBUTES a1
where c.CONSTRAINT_TYPE='R' and c.TABLE_NAME=cl.TABLE_NAME and c.CONSTRAINT_NAME=cl.CONSTRAINT_NAME
and c1.CONSTRAINT_TYPE='P' and c1.TABLE_NAME=cl1.TABLE_NAME and c1.CONSTRAINT_NAME=cl1.CONSTRAINT_NAME
and c.R_CONSTRAINT_NAME=c1.CONSTRAINT_NAME and c.TABLE_NAME=cs.TABLENAME and c1.TABLE_NAME=cs1.TABLENAME
and cs.ID=a.CLASSID and cs1.ID=a1.CLASSID and cl.COLUMN_NAME=a.COLUMNNAME and cl1.COLUMN_NAME=a1.COLUMNNAME 
and nvl(cs.parent,0)<>nvl(cs1.id,0)

select * from user_constraints where CONSTRAINT_TYPE='P'
select * from user_constraints c where c.CONSTRAINT_TYPE='R'
select * from USER_CONS_COLUMNS













