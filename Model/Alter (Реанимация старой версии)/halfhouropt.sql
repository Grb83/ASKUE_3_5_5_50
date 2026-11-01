CREATE GLOBAL TEMPORARY TABLE HALFHOUROPT  (
   MID                  NUMBER                          not null,
   DATE_TIME            DATE                            not null,
   NSOURCE              NUMBER(10)                     default 50 not null,
   ER                   NUMBER,
   Q1                   NUMBER,
   ED                   NUMBER,
   Q3                   NUMBER,
   Q2                   NUMBER,
   Q4                   NUMBER,
   ERM                  NUMBER,
   Q1M                  NUMBER,
   EDM                  NUMBER,
   Q3M                  NUMBER,
   Q2M                  NUMBER,
   Q4M                  NUMBER,
   STATUS               NUMBER,
   NSWITCH              NUMBER,
   NEXCEPTCALC          NUMBER(1),
   DCLOSED              DATE,
   NKC                  NUMBER,
   ER_MTRSN             VARCHAR2(20),
   DENTER               DATE                           default sysdate not null,
   VQM                  VARCHAR2(32),
   NMETERTYPE           NUMBER(10),
   constraint HALFHOUROPT_PK primary key (MID, DATE_TIME, NSOURCE)
)
 ON COMMIT PRESERVE ROWS
 ORGANIZATION HEAP
 CACHE
;

comment on table HALFHOUROPT is
'Получасовки';

comment on column HALFHOUROPT.MID is
'Ид точки';

comment on column HALFHOUROPT.DATE_TIME is
'Дата показаний';

comment on column HALFHOUROPT.NSOURCE is
'Код источника';

comment on column HALFHOUROPT.ER is
'Расход А пр';

comment on column HALFHOUROPT.Q1 is
'Расход Q1';

comment on column HALFHOUROPT.ED is
'Расход А от';

comment on column HALFHOUROPT.Q3 is
'Расход Q3';

comment on column HALFHOUROPT.Q2 is
'Расход Q2';

comment on column HALFHOUROPT.Q4 is
'Расход Q4';

comment on column HALFHOUROPT.ERM is
'Показания А пр';

comment on column HALFHOUROPT.Q1M is
'Показания Q1';

comment on column HALFHOUROPT.EDM is
'Показания А от';

comment on column HALFHOUROPT.Q3M is
'Показания Q3';

comment on column HALFHOUROPT.Q2M is
'Показания Q2';

comment on column HALFHOUROPT.Q4M is
'Показания Q4';

comment on column HALFHOUROPT.STATUS is
'Статус';

comment on column HALFHOUROPT.NSWITCH is
'Ид обводника';

comment on column HALFHOUROPT.NEXCEPTCALC is
'Исключен из расчета';

comment on column HALFHOUROPT.DCLOSED is
'Дата закрытия суток';

comment on column HALFHOUROPT.NKC is
'Коеф счетчика';

comment on column HALFHOUROPT.ER_MTRSN is
'Номер счетчика';

comment on column HALFHOUROPT.DENTER is
'Дата попадания';

comment on column HALFHOUROPT.VQM is
'Метка качества';

comment on column HALFHOUROPT.NMETERTYPE is
'Тип счетчика';


