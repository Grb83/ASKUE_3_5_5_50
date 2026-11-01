SQLPLUS ryda/oracle81634@askue @drop.sql
imp.exe userid=system/sys2@askue file=exp.dmp log=imp.log fromuser=ryda touser=ryda buffer=10000000
SQLPLUS ryda/oracle81634@askue @compile.sql