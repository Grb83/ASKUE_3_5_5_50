insert into parameter(npid,vvalue,VDESCRIPTION) values (1,'25.'||to_char(sysdate,'MM.YYYY'),	'Дата расчета значений ручников с месячным профилем')
/
insert into parameter(npid,vvalue,VDESCRIPTION) values (2,'25.'||to_char(add_Months(sysdate,-1),'MM.YYYY'),	'Предыдущая дата расчета')
/
insert into parameter(npid,vvalue,VDESCRIPTION) values (3,'25.'||to_char(sysdate,'MM.YYYY'),	'Текущая дата расчета')
/
INSERT INTO procedures
(NPROCEDURE,VPROCDURE,VNAME,NORDER)
VALUES
(1,'CALC_PG.Calc_report_p','Отчет 1',1)
/
INSERT INTO procedures
(NPROCEDURE,VPROCDURE,VNAME,NORDER)
VALUES
(2,'CALC_PG.Report_Debt_p','Отчет 2',2)
/
INSERT INTO grouptypes
(NGROUPTYPE,VNAME)
VALUES
(1,'Подстанция')
/
INSERT INTO grouptypes
(NGROUPTYPE,VNAME)
VALUES
(2,'Потребитель')
/
commit
/
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES
(51,27,502,'6.9 Отчеты',NULL,'','')
/
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES
(52,42,604,'1.8 Ввод показаний (получасовки)',NULL,'','')
/
INSERT INTO tasks
(TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES
(53,42,603,'1.9 Ввод количества энергии (получасовки)',NULL,'','')
/
commit
/




--28.05.2002
INSERT INTO RYDA.PROTOCOLS
(PROTOCOL_ID,NAME)
VALUES
(11,'A1R Альфа')
/
INSERT INTO RYDA.PROTOCOLS
(PROTOCOL_ID,NAME)
VALUES
(12,'KM --> A1R Альфа')
/
INSERT INTO RYDA.PROTOCOLS
(PROTOCOL_ID,NAME)
VALUES
(14,'УСД КМ')
/
INSERT INTO RYDA.PROTOCOLS
(PROTOCOL_ID,NAME)
VALUES
(15,'KM --> УСД КМ')
/
INSERT INTO RYDA.PROTOCOLS
(PROTOCOL_ID,NAME)
VALUES
(16,'Облик-2002')
/
INSERT INTO RYDA.PROTOCOLS
(PROTOCOL_ID,NAME)
VALUES
(17,'KM --> Облик-2002')
/
INSERT INTO RYDA.PROTOCOLS
(PROTOCOL_ID,NAME)
VALUES
(18,'LG_ZxB')
/
INSERT INTO RYDA.PROTOCOLS
(PROTOCOL_ID,NAME)
VALUES
(19,'KM --> LG_ZxB')
/
commit
/

INSERT INTO FORM_TEMPLATES (TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES (50,11,921,'2.9. Переток активной э/э (общая и по тарифам)', 'Переток активной э/э (общая и по тарифам) [кВтч]','111001',1,'');
INSERT INTO FORM_TEMPLATES (TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES (51,11,941,'2.10. Переток реактивной э/э (общая и по тарифам)', 'Переток реактивной э/э (общая и по тарифам) [кВарч]','111001',1,'');
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (54,12,75,'3.2 Тарификация по режимным суткам',NULL,'','');
INSERT INTO ROLE_TASK (ROLE_ID,TASK_ID) VALUES (1,54);

--15/07/2002
insert into POINTS (mid,ind,name) values(0,1,'Каналы опроса')
/
    INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
      VALUES (50,19,505,'5.6.1 План опроса',NULL,'','')
/
commit
/


--22/07/2002
UPDATE TASKS set NAME='5.A Legacy' where TASK_ID=25
/
UPDATE TASKS set NAME='5.6 План опроса' where TASK_ID=50
/
update feeders set METKC=1
/
commit
/
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(4,'1','Признак архивации технического профиля (если 1 арнивируем 0 - нет)')
/
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(5,'c:\','Каталог для записи файлов архивации технического профиля')
/
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(6,'1','Признак архивации коммерческого профиля (если 1 арнивируем 0 - нет)')
/
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(7,'c:\','Каталог для записи файлов архивации коммерческого профиля')
/
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(8,'1','Признак архивации суточных данных (если 1 арнивируем 0 - нет)')
/
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(9,'c:\','Каталог для записи файлов архивации суточных данных')
/









----------------26.07.2002
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (55,27,506,'6.9 План рассылки',NULL,'','')
/
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
VALUES
(10,'c:\','Каталог для файлов отсылки отчетов')
/
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
values(11,'1','Автоматически обновлять версию.')
/
commit
/



--15.08.2002
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
  VALUES (56,NULL,0,'7. Коммуникации',NULL,'','');
    INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
      VALUES (57,56,507,'7.3 УСПД',NULL,'','');
update TASKS set PARENT=56,NAME='7.1 Параметры коммуникационного сервера' where TASK_ID=35;
update TASKS set PARENT=56,NAME='7.2 Настройка СОМ - портов' where TASK_ID=26;
update TASKS set PARENT=56,NAME='7.4 План опроса' where TASK_ID=50;
update TASKS set PARENT=56,NAME='7.9 Legacy' where TASK_ID=25;
INSERT INTO ROLE_TASK (ROLE_ID,TASK_ID) VALUES (1,56);
INSERT INTO ROLE_TASK (ROLE_ID,TASK_ID) VALUES (1,57);
commit;





---25.10.2002
INSERT INTO TASKS
(TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES
(58,27,76,'6.10 Макеты',NULL,'','')
/




INSERT INTO ROLE_TASK (ROLE_ID,TASK_ID) VALUES (1,58);
commit;



--12.11.2002
--INSERT INTO tasks(TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK) VALUES (59,42,605,'1.10 Ввод показаний для индукционных счетчиков',NULL,'','');
--INSERT INTO ROLE_TASK (ROLE_ID,TASK_ID) VALUES (1,59);
--commit;

--14/11/2002
insert into deportprocedures(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD) values(1,'Макет 1010','ryda.reports1_pg.m1010_p',2);
insert into deportprocedures(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD) values(2,'Макет 30817','ryda.reports1_pg.m30817_p',2);
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
values(12,'0','Заказчик')
/
--0 По умолчанию
--1 ХЭС
commit
/

--19.11.2002
insert into POINTS (mid,ind,name) values(1,1,'Каналы опроса1')
/
update points set parent=1 where parent=0
/
delete from points where mid=0
/
update points set name='Каналы опроса' where mid=1
/
commit
/



--24.11.2002
insert into monitors(monitor_id,MSCHEMA,NAME,DSIZE)
(select ROLES_SEQ.nextval, m.* from (select MSCHEMA,'Мониторы',0 from monitors group by MSCHEMA) m)
/
update monitors m set m.nparent=(select max(monitor_id) from monitors where MSCHEMA=m.MSCHEMA and DSIZE=0) where m.DSIZE>0
/
commit
/


--28.11.2002
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(1,NULL,NULL,'1. Учет энергии','','000000',0,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(6,1,500,'1.01. Приём Активной энергии','Приём Активной энергии [тыс.кВтч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(56,1,501,'1.01.1.  Приём Активной энергии (ГН, Тех.проф. - мощность)',
'Приём Активной энергии [тыс.кВтч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(72,1,502,'1.01.2.  Приём Активной энергии (Суммируется по наростающей)',
'Приём Активной энергии [тыс.кВтч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(7,1,600,'1.02. Отдача Активной энергии','Отдача Активной энергии [тыс.кВтч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(57,1,601,'1.02.1.  Отдача Активной энергии (ГН, Тех.проф. - мощность)',
'Отдача Активной энергии [тыс.кВтч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(73,1,602,'1.02.2.  Отдача Активной энергии (Суммируется по наростающей)',
'Отдача Активной энергии [тыс.кВтч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(5,1,400,'1.03. Переток Активной энергии','Переток Активной энергии [тыс.кВтч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(55,1,401,'1.03.1.  Переток Активной энергии (ГН, Тех.проф. - мощность)',
'Переток Активной энергии [тыс.кВтч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(71,1,402,'1.03.2.  Переток Активной энергии (Суммируется по наростающей)',
'Переток Активной энергии [тыс.кВтч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(9,1,800,'1.04. Приём Реактивной энергии','Приём Реактивной энергии [тыс.кВАрч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(59,1,801,'1.04.1.  Приём Реактивной энергии (ГН, Тех.проф. - мощность)',
'Приём Реактивной энергии [тыс.кВАрч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(75,1,802,'1.04.1.  Приём Реактивной энергии (Суммируется по наростающей)',
'Приём Реактивной энергии [тыс.кВАрч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(10,1,900,'1.05. Отдача Реактивной энергии','Отдача реактивной энергии [тыс.кВАрч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(60,1,901,'1.05.1.  Отдача Реактивной энергии (ГН, Тех.проф. - мощность)',
'Отдача реактивной энергии [тыс.кВАрч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(76,1,902,'1.05.1.  Отдача Реактивной энергии (Суммируется по наростающей)',
'Отдача реактивной энергии [тыс.кВАрч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(8,1,700,'1.06. Переток Реактивной энергии','Переток Реактивной энергии [тыс.кВАрч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(58,1,701,'1.06.1.  Переток Реактивной энергии (ГН, Тех.проф. - мощность)',
'Переток Реактивной энергии [тыс.кВАрч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(74,1,702,'1.06.1.  Переток Реактивной энергии (Суммируется по наростающей)',
'Переток Реактивной энергии [тыс.кВАрч]','111101',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(3,1,200,'1.07. Приём ; Отдача Активной энергии','Приём ; Отдача Активной энергии [тыс.кВтч]',
'111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(53,1,201,'1.07.1.  Приём ; Отдача Активной энергии (ГН, Тех.проф. - мощность)',
'Приём ; Отдача Активной энергии [тыс.кВтч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(69,1,202,'1.07.2.  Приём ; Отдача Активной энергии (Суммируется по наростающей)',
'Приём ; Отдача Активной энергии [тыс.кВтч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(4,1,300,'1.08. Приём ; Отдача Реактивной энергии','Приём ; Отдача Реактивной энергии [тыс.кВАрч]',
'111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(54,1,301,'1.08.1.  Приём ; Отдача Реактивной энергии (ГН, Тех.проф. - мощность)',
'Приём ; Отдача Реактивной энергии [тыс.кВАрч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(70,1,302,'1.08.1.  Приём ; Отдача Реактивной энергии (Суммируется по наростающей)',
'Приём ; Отдача Реактивной энергии [тыс.кВАрч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(2,1,100,'1.10. Переток Активной ; Реактивной энергии',
'Переток Активной ; Реактивной энергии [тыс.кВтч/тыс.кВАрч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(52,1,101,'1.10.1. Переток Активной ; Реактивной энергии (ГН, Тех.проф. - мощность)',
'Переток Активной ; Реактивной энергии [тыс.кВтч/тыс.кВАрч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(68,1,102,'1.10.2. Переток Активной ; Реактивной энергии (Суммируется по наростающей)',
'Переток Активной ; Реактивной энергии [тыс.кВтч/тыс.кВАрч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(61,1,310,'1.11. Приём ; Отдача Реактивной энергии при импорте активной энергии',
'Приём ; Отдача Реактивной энергии при импорте активной энергии [тыс.кВАрч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(62,1,311,
'1.11.1. Приём ; Отдача Реактивной энергии при импорте активной энергии (ГН, Тех.проф. - мощность)',
'Приём ; Отдача Реактивной энергии при импорте активной энергии[тыс.кВАрч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(63,1,320,'1.12. Приём ; Отдача Реактивной энергии при экспорте активной энергии',
'Приём ; Отдача Реактивной энергии при экспорте активной энергии [тыс.кВАрч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(64,1,321,
'1.12.1. Приём ; Отдача Реактивной энергии при экспорте активной энергии (ГН, Тех.проф. - мощность)',
'Приём ; Отдача Реактивной энергии при экспорте активной энергии [тыс.кВАрч]','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(77,1,1400,'1.13. Приём Активной энергии по декадам','Приём Активной энергии [тыс.кВтч]','111101',2,
'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(11,NULL,NULL,'2. Учет энергии по тарифам','','000000',0,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(12,11,910,'2.01. Активная принятая общая и по тарифам',
'Активная принятая общая и по тарифам [тыс.кВтч]','111101',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(13,11,920,'2.02. Активная отданная общая и по тарифам',
'Активная отданная общая и по тарифам [тыс.кВтч]','111101',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(50,11,921,'2.03. Переток активной э/э (общая и по тарифам)',
'Переток активной э/э (общая и по тарифам) [тыс.кВтч]','111001',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(14,11,930,'2.04. Реактивная принятая общая и по тарифам',
'Реактивная принятая общая и по тарифам [тыс.кВАрч]','111001',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(15,11,940,'2.05. Реактивная отданная общая и по тарифам',
'Реактивная отданная общая и по тарифам [тыс.кВАрч]','111001',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(51,11,941,'2.06. Переток реактивной э/э (общая и по тарифам)',
'Переток реактивной э/э (общая и по тарифам) [тыс.кВарч]','111001',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(16,11,950,'2.07. Активная принятая по тарифам','Активная принятая по тарифам [тыс.кВтч]','111001',
1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(17,11,960,'2.08. Активная отданная по тарифам','Активная отданная по тарифам [тыс.кВтч]','111001',
1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(18,11,970,'2.09. Реактивная принятая по тарифам','Реактивная принятая по тарифам [тыс.кВАрч]',
'111001',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(19,11,980,'2.10. Реактивная отданная по тарифам','Реактивная отданная по тарифам [тыс.кВАрч]',
'111001',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(20,NULL,NULL,'3. Контроль нагрузки','','000000',0,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(21,20,10,'3.01. Активная мощность','Активная мощность [МВт]','100101',0,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(22,20,20,'3.02. Реактивная мощность','Реактивная мощность [МВАр]','100101',0,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(25,20,50,'3.03. Текущая нагрузка','Текущая нагрузка [МВт/МВАр]','111111',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(26,20,52,'3.03.1. Текущая нагрузка (Ч\Б)','Текущая нагрузка [МВт/МВАр]','100100',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(23,20,30,'3.04. Контроль лимита активной мощности','Мощность, лимит, отклонение [МВт]','100111',3,
'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(24,20,40,'3.05. Контроль лимита реактивной мощности','Мощность, лимит, отклонение [МВАр]','100111',
3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(27,20,51,'3.06. Оперативный контроль лимитов','Контроль лимитов','100100',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(28,20,53,'3.06.1. Оперативный контроль лимитов (Ч\Б)','Контроль лимитов','100100',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(66,20,63,'3.07. Небалансы энергобъектов','Небалансы энергобъектов','100111',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(67,20,64,'3.08. Небалансы энергобъектов (Текущее)','Небалансы энергобъектов','100111',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(65,20,62,'3.09. Контроль потребителей (Долг)','Контроль потребителей','100111',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(29,20,54,'3.10. Контроль потребителей','Контроль потребителей','100111',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(30,20,55,'3.10.1. Контроль потребителей (Ч/Б)','Контроль потребителей','100111',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(31,20,58,'3.11. Контроль потребителей-перерасходчиков','Контроль потребителей-перерасходчиков',
'101000',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(32,20,59,'3.11.1. Контроль потребителей-перерасходчиков (Ч/Б)',
'Контроль потребителей-перерасходчиков','101000',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(33,20,56,'3.12. Контроль потребителей-должников','Контроль потребителей-должников','101000',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(34,20,57,'3.12.1. Контроль потребителей-должников (Ч/Б)','Контроль потребителей-должников',
'101000',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(35,20,60,'3.13.  Контроль не поступления данных','Контроль не поступления данных','100101',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(36,20,61,'3.13.1. Контроль не поступления данных (Ч\Б)','Контроль не поступления данных (Ч\Б)',
'100101',3,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(37,NULL,NULL,'4. Журналы','','000000',0,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(38,37,1000,'4.01. Журнал действий оператора','Журнал действий оператора','100001',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(39,37,1100,'4.02. Журнал сообщений системы','Журнал сообщений системы','100001',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(40,NULL,NULL,'5. Универсальные формы','','',NULL,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(43,40,1202,'5.01. Форма оперативного контроля',' ','110001',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(41,40,1200,'5.02. Форма оперативного контроля (Маштабируемая)',' ','111111',2,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(42,40,1201,'5.03. Форма отчета',' ','010001',1,'')
/
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(78,40,1203,'5.04. Форма отчета PL SQL','','111111',2,'')
/
commit
/



--30.11.2002
INSERT INTO tasks(TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (61,27,606,'6.11 План выполнения фоновых процессов',NULL,'','')
/
INSERT INTO ROLE_TASK (ROLE_ID,TASK_ID) VALUES (1,61)
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(4,'Расчет суточного расхода','ryda.DAS_PG.CalcOneDay4Bill',2,1,'')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(3,'Проверка канала','ryda.reports1_pg.LastSave_p',1,0,'')
/
INSERT INTO MAKETS
(NMAKET,NPROCEDURE,VNAME,VNOTE,NBLOCK,NCYCLE,NSHIFT)
VALUES
(1081,4,'Расчет суточного расхода','',0,0,400)
/

commit
/



--07.12.2002
INSERT INTO tasks(TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (63,42,608,'1.11 Ввод показаний с разбивкой на график',NULL,'','')
/
INSERT INTO ROLE_TASK (ROLE_ID,TASK_ID) VALUES (1,63)
/
commit
/

--02.01.2003
INSERT INTO tasks(TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (64,42,609,'1.11 Ввод расхода с разбивкой на график',NULL,'','')
/
INSERT INTO ROLE_TASK (ROLE_ID,TASK_ID) VALUES (1,64)
/
commit
/


--03.01.2003
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
values(13,'-11','Ид группы точек ручного ввода')
/
--------- ХЭС 42756
commit
/



--20.02.2003
INSERT INTO RYDA.PROTOCOLS
VALUES
(20,'LG_ZxD (IEC)')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(21,'KM --> LG_ZxD (IEC)')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(22,'Metcom')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(23,'KM --> Metcom')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(24,'FAG-12')
/
INSERT INTO RYDA.PROTOCOLS
VALUES
(25,'KM --> FAG-12')
/




---27.01.2003

INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(6,'Верификация по дублям','check_pg.by_duplicate',2,1,
'Сверка профиля нагрузки LG с Итеком')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(7,'Верификация параметров УСД Итек','check_pg.by_itekcoeff',2,1,
'Сверка коэффициентов Итека с базой данных')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(8,'Верификация связных номеров','check_pg.by_mtrsn',2,1,
'Сверка заводских и связных номеров LG')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(9,'Верификация суточных расходов','check_pg.by_day_expense',2,1,
'Сверка суточного расхода Итека с суммой по профилю нагрузки.'
)
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(10,'Верификация месячных расходов','check_pg.by_month_expense',5,1,
'Сверка месячного расхода LG, Итека с суммой по профилю нагрузки.'
)
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(11,'Верификация по балансам шин','check_pg.by_balance',2,1,'Выполняется только для пст Лозовая-330')
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(12,'Верификация переключений ОВ','check_pg.by_OV',2,1,
'Проверка совпадения расхода по ОВ и по переключениям')
/


INSERT INTO points
(mid, name, parent, ind)
VALUES
(2,'Процедуры верификации',null,1)
/

INSERT INTO points
(mid, name, parent, ind)
VALUES
(6,'Сверка по дублям',2,1)
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(7,'Сверка параметров УСД Итек',2,1)
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(8,'Сверка связных номеров',2,1)
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(9,'Сверка суточных расходов',2,1)

/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(10,'Сверка месячных расходов',2,1)
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(11,'Сверка по балансам шин',2,1)
/
INSERT INTO points
(mid, name, parent, ind)
VALUES
(12,'Сверка переключений ОВ',2,1)
/
commit
/


--27.01.2003
INSERT INTO RYDA.FORM_TEMPLATES
(TEMPLATE_ID,PARENT,CODETEMPLATE,NAMEFORM,COMMENTFORM,ENABLECONTROLS,STEPPROFILE,NAMEALERT)
VALUES
(79,1,1410,'1.14. Переток Активной энергии (по декадам)','Переток Активной энергии [тыс.кВтч]',
'111101',2,'')
/
commit
/



---10/03/2003
update db_term set TABLE_NAME='HALFHOUROLD',VEXTENTION='hor' where TABLE_NAME='HALFHOUR';
update db_term set VEXTENTION='bil' ,DATA_NAME='Суточные данные (расчетные)' where TABLE_NAME='BILL';
INSERT INTO db_term (DATA_NAME,TABLE_NAME,TERM,VINDIC_COLUMN,VEXTENTION) VALUES ('Суточные данные (первичная информация)','BILLORG',10000,'date_time','bilo');
update db_term set VEXTENTION='prf',DATA_NAME='Оперативные данные' where TABLE_NAME='PROFILE';
update db_term set VEXTENTION='fsk' where TABLE_NAME='FISCAL';
update db_term set VEXTENTION='jor' where TABLE_NAME='JOURNAL';
INSERT INTO db_term (DATA_NAME,TABLE_NAME,TERM,VINDIC_COLUMN,VEXTENTION) VALUES ('Протокол опроса','COMPORTEVENTS',10000,'dlastevent','cev');

INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(17,'Архивация и чистка БД','background01_pg.save4kill',2,1,'Архивация и чистка БД')
/
INSERT INTO MAKETS
(NMAKET,NPROCEDURE,VNAME,VNOTE,NBLOCK,NCYCLE,NSHIFT)
VALUES
(MAKETS_SEQ.nextval,17,'Архивация и чистка БД','',0,0,400)
/
INSERT INTO deportprocedures
(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,NTYPE,VMEMO)
VALUES
(18,'Удаление данных по истечению срока','background01_pg.killdata',2,1,'Удаление данных по истечению срока')
/
INSERT INTO MAKETS
(NMAKET,NPROCEDURE,VNAME,VNOTE,NBLOCK,NCYCLE,NSHIFT)
VALUES
(MAKETS_SEQ.nextval,18,'Удаление данных по истечению срока','',1,0,400)
/
update parameter set VDESCRIPTION='НЕ ИСПОЛЬЗУЕТСЯ '||VDESCRIPTION where npid in (6,7,8,9,4);
update parameter set VDESCRIPTION='Каталог для записи архивных файлов' where npid=5;
commit
/



--12.02.2003
insert into parameter(npid,vvalue,VDESCRIPTION) values (14,'16:00','Дата начала действия вечернего плана')
/
insert into parameter(npid,vvalue,VDESCRIPTION) values (15,'01:00','Дата начала действия утреннего плана')
/
commit
/






--13/02/2003
delete from comporttype where NCOMTYPE>1
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(2,'Соединение по каналам связи телемеханики')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(3,'Соединение по коммутируемой линии через стандартный модем')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(4,'Соединение через GSM терминал')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(5,'Соединение через GSM терминал с управлением питанием')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(6,'Соединение через радиостанцию типа LG')
/
INSERT INTO COMPORTTYPE
(NCOMTYPE,VNAME)
VALUES
(7,'Соединение по спутниковому каналу ')
/


-------14.02.2003
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (66,12,610,'3.5 Ввод тарифов UMC',NULL,'','');
commit;

-------17.02.2003
insert into parameter(npid,vvalue,VDESCRIPTION) values (16,'20','Вемя устаревания данных (мин)')
/
commit
/

-------24.03.2003
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (67,42,611,'1.12 Ввод показаний с пропорциональной разбивкой на график нагрузки на последние сутки',NULL,'','');
commit;

-------Для ХОЭ VVALUE=20419
INSERT INTO parameter
(NPID,VVALUE,VDESCRIPTION)
values(17,'-11','Ид группы для разложения по профилю суточного расхода')
/
commit
/
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (68,42,612,'1.13 Ввод расхода с пропорциональной разбивкой на график нагрузки на последние сутки',NULL,'','')
/
commit
/



--15.04.2003
insert into parameter(npid,vvalue,VDESCRIPTION) values (18,'1','Необходимость округлять остатки округления')
/
commit
/

--18.04.2003

INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (73,42,614,'1.18 Ввод показаний с равномерной разбивкой на график нагрузки',NULL,'','')
/
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (69,42,615,'1.14 Ввод показаний с равномерной разбивкой на график нагрузки на последние сутки',NULL,'','')
/
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (70,42,616,'1.15 Ввод расхода с пропорциональной разбивкой на график нагрузки',NULL,'','')
/
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (71,42,617,'1.16 Ввод расхода с равномерной разбивкой на график нагрузки',NULL,'','')
/
INSERT INTO TASKS (TASK_ID,PARENT,TASK_COD,NAME,NUM_ARG,CHAR_ARG,REMARK)
VALUES (72,42,618,'1.17 Ввод расхода с равномерной разбивкой на график нагрузки на последние сутки',NULL,'','')
/

update tasks set REMARK='' where TASK_ID=42;
update tasks set REMARK='' where TASK_ID=7;
update tasks set REMARK='' where TASK_ID=12;
update tasks set REMARK='' where TASK_ID=16;
update tasks set REMARK='' where TASK_ID=56;
update tasks set REMARK='' where TASK_ID=19;
update tasks set REMARK='' where TASK_ID=27;
update tasks set REMARK='Группы учета' where TASK_ID=17;
update tasks set REMARK='Спецификация экспортируемых данных' where TASK_ID=29;
update tasks set REMARK='00 Контролируемые потребители' where TASK_ID=39;
update tasks set REMARK='00 Контроль объема БД' where TASK_ID=34;
update tasks set REMARK='00 Параметры коммуникационного сервера' where TASK_ID=35;
update tasks set REMARK='00 Контролируемые объекты' where TASK_ID=11;
update tasks set REMARK='00 Определение планов' where TASK_ID=9;
update tasks set REMARK='00 Определение лимитов' where TASK_ID=8;
update tasks set REMARK='Задание часов максимумов' where TASK_ID=10;
update tasks set REMARK='Спецификация предприятия' where TASK_ID=28;
update tasks set REMARK='00 Группы присоединений' where TASK_ID=24;
update tasks set REMARK='Расчетные присоединения' where TASK_ID=22;
update tasks set REMARK='00 Обводные присоединения' where TASK_ID=23;
update tasks set REMARK='Точки учета' where TASK_ID=20;
update tasks set REMARK='Редактирование счетчиков' where TASK_ID=21;
update tasks set REMARK='Замена счетчиков' where TASK_ID=6;
update tasks set REMARK='Спецификация шаблонов форм' where TASK_ID=30;
update tasks set REMARK='Формы учета' where TASK_ID=18;
update tasks set REMARK='Расписание тарифных зон' where TASK_ID=13;
update tasks set REMARK='00 Циклические даты' where TASK_ID=14;
update tasks set REMARK='00 Cпециальные даты' where TASK_ID=15;
update tasks set REMARK='00 Legacy' where TASK_ID=25;
update tasks set REMARK='Настройка СОМ - портов' where TASK_ID=26;
update tasks set REMARK='Переключение ОВ' where TASK_ID=41;
update tasks set REMARK='Тарификация по режимным суткам' where TASK_ID=54;
update tasks set REMARK='Макеты' where TASK_ID=58;
update tasks set REMARK='00 Ввод показаний по тарифам' where TASK_ID=2;
update tasks set REMARK='00 Ввод количества энегии по тарифам' where TASK_ID=4;
update tasks set REMARK='00 Редактирование показаний' where TASK_ID=5;
update tasks set REMARK='00 Ввод количества энергии' where TASK_ID=3;
update tasks set REMARK='00 Ввод показаний' where TASK_ID=1;
update tasks set REMARK='Редактирование "ручников" ' where TASK_ID=40;
update tasks set REMARK='00 Ввод значений нагрузки  по ручным точкам учета' where TASK_ID=36;
update tasks set REMARK='План опроса' where TASK_ID=50;
update tasks set REMARK='План рассылки' where TASK_ID=55;
update tasks set REMARK='00 УСПД' where TASK_ID=57;
update tasks set REMARK='Ввод количества энергии (получасовки)' where TASK_ID=53;
update tasks set REMARK='Ввод показаний (получасовки)' where TASK_ID=52;
update tasks set REMARK='Ввод начальных показаний' where TASK_ID=59;
update tasks set REMARK='План выполнения фоновых процессов' where TASK_ID=61;
update tasks set REMARK='Ввод показаний с пропорциональной разбивкой на график нагрузки' where TASK_ID=63;
update tasks set REMARK='Ввод расхода с равномерной разбивкой на график нагрузки на последние сутки (спец группа)' where TASK_ID=64;
update tasks set REMARK='Ввод тарифов UMC' where TASK_ID=66;
update tasks set REMARK='Ввод показаний с пропорциональной разбивкой на график нагрузки на последние сутки' where TASK_ID=67;
update tasks set REMARK='Ввод расхода с пропорциональной разбивкой на график нагрузки на последние сутки' where TASK_ID=68;
update tasks set REMARK='Ввод показаний с равномерной разбивкой на график нагрузки' where TASK_ID=73;
update tasks set REMARK='Ввод показаний с равномерной разбивкой на график нагрузки на последние сутки' where TASK_ID=69;
update tasks set REMARK='Ввод расхода с пропорциональной разбивкой на график нагрузки' where TASK_ID=70;
update tasks set REMARK='Ввод расхода с равномерной разбивкой на график нагрузки' where TASK_ID=71;
update tasks set REMARK='Ввод расхода с равномерной разбивкой на график нагрузки на последние сутки' where TASK_ID=72;

commit
/

--29/04/2003
/* --Для ХОЭ
insert into deportprocedures(NPROCEDURE,VNAME,VPROCEDURE,NPERIOD,ntype,vmemo) values(21,'Подготовка данных для экспорта во внешнюю систему.','ryda.export_pg.setbackgroundexport',2,1,'Подготовка данных для экспорта во внешнюю систему.')
/
INSERT INTO makets
(NMAKET,NPROCEDURE,VNAME,VNOTE,NBLOCK,NCYCLE,NSHIFT,VPARAM,DOLDCREATED,VERROR)
select makets_seq.NEXTVAL,21,'Экспорт в RS-6000','',0,0,430,'','','' from dual
/
commit
/
*/
