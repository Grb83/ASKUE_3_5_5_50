select c.COMMENTS,'a'||substr(t.DATA_TYPE,1,1)||'_'||substr(t.COLUMN_NAME,2)||' '||t.DATA_TYPE||','||'--'||c.COMMENTS  c1,
t.COLUMN_NAME||',' c2,
'a'||substr(t.DATA_TYPE,1,1)||'_'||substr(t.COLUMN_NAME,2)||',' c3,
t.COLUMN_NAME||'=a'||substr(t.DATA_TYPE,1,1)||'_'||substr(t.COLUMN_NAME,2)||',' c4,
decode(DATA_TYPE,'NUMBER',decode(nvl(DATA_PRECISION,0),0,'double','long'),'char')||' '||lower(t.COLUMN_NAME)||decode(DATA_TYPE,'NUMBER','','['||DATA_LENGTH||']') ||';' c5,
t.COLUMN_NAME||',' c6,
'b.'||t.COLUMN_NAME||',--'||c.COMMENTS c7,
t.*
from user_tab_columns t,USER_COL_COMMENTS c
where t.table_name=Upper('bill') and t.table_name=c.table_name and t.COLUMN_NAME=c.COLUMN_NAME order by t.COLUMN_ID
--select * from USER_COL_COMMENTS
