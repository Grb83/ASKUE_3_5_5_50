
-- Start of DDL script for SSPOINTINLIST_PG
-- Generated 23-июл-02  6:14:44 pm
-- from ea-SS:1

-- Package body SSPOINTINLIST_PG

CREATE OR REPLACE
Package Body      SSPOINTINLIST_PG
IS
cursor gcur_l(an_point IN NUMBER,
                    an_pointlist IN NUMBER,
                    an_AccPeriod IN NUMBER)
is
select npoint,
        pil.nFromPeriod
from    SSPointList pl,
        SSPointInList pil
where pl.nPointList = an_pointlist
        and pl.vCode in ('1_frozen'/*,'1_cas'*/)
      and pl.nPointList = pil.nPointList(+)
        and pil.nPoint = an_point
      and nvl(an_AccPeriod,nvl(pil.nFromPeriod,101)) between nvl(pil.nFromPeriod,101) and nvl(pil.nTillPeriod,299912)
;
-----------------------------------------------------
PROCEDURE Ins_p(an_pointlist       IN NUMBER,
                an_point           IN NUMBER,
                av_text               IN VARCHAR ,
                an_amount             IN NUMBER,
                an_sum                IN NUMBER,
                an_fromperiod         IN NUMBER,
                an_tillperiod         IN NUMBER,
                an_superior           IN NUMBER,
                an_Ret             OUT NUMBER
               ) is
ln_Inc NUMBER;
ln_Ret NUMBER;
ln_RunLogging NUMBER;
ln_NotClearLog NUMBER;
lv_RecordType VARCHAR2(10);

CURSOR lcur_include IS
Select nPointList
from SSpointinlist
Where nPointList = an_pointlist
        and npoint = an_point and
      (an_fromperiod between nFromPeriod  and nvl(nTillPeriod,299912) or
       nFromPeriod between nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f) and nvl(an_TillPeriod,299912))
         ;
le_Debug EXCEPTION;
lv_Debug VARCHAR2(512);
lri_Curr ROWID;
BEGIN

Open lcur_include;
Fetch lcur_include into ln_Inc;
Close lcur_include;

SELECT  pl.nrunlogging,
            pl.nnotclearlog
INTO  ln_RunLogging, ln_NotClearLog
FROM  SSpointlist     pl
 WHERE nPointList = an_pointlist
 ;

-- Запись в журнал -----------
/*IF ln_RunLogging = 1 Then
  IF ln_NotClearLog = 1 THEN
    lv_RecordType := lv_RecordType||'Z';
  END IF;

  RS.rsRoot_PG.Log_p('Добавленa ТУ в список подстанций с Ид = '||an_pointlist,
                     'SSPOINT',
                            ssGroup_RO_PG.tGetParents_f(an_Consumer, ln_CalcStep),
                     nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f),
                            ln_CalcStep > 0,
                            true,
                     ln_CalcStep,
                            lv_RecordType,
                            ln_Ret,
                            lri_Curr);
  if ln_Ret = -1 then
    an_Ret := -1;
    return;
  end if;
END IF;

if ln_CalcStep = 0 or nvl(an_TillPeriod, 299912) < RS.rsCommon_PG.nConfAccPeriod_f then
  RS.RSROOT_PG.ClearCalc_p(nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f),
                                    lri_Curr,
                                    ln_Ret);
  if ln_Ret = -1 then
    an_Ret := -1;
    return;
  end if;
end if;*/
---------------Begin Sechin A.A. 20.07.2002
    RS.rsRoot_PG.LogStep_p('Добавленa ТУ в список подстанций с Ид = '||an_pointlist,
                'SSPOINT', ssPoint_RO_PG.tGetParents_f(an_Point, 0, nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f)),
                nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f), 0, '', ln_Ret, lri_Curr);
    if ln_Ret <0 then
      an_Ret := -1;
      return;
    end if;
---------------End Sechin A.A.
IF ln_Inc is null THEN
    INSERT INTO SSpointinlist
     (
      npointlist ,
      npoint ,
      nfromperiod ,
      ntillperiod ,
      vtext,
      namount,
      nsum,
      nsuperior
     )
     VALUES
     (
      an_pointlist ,
      an_point ,
      nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f) ,
      an_tillperiod ,
      av_text,
      an_amount,
      an_sum,
      an_superior
     );
END IF;

/*FOR lr IN gcur_l(an_point, an_pointlist, nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f)) LOOP
    ssRest_PG.InvalidateRests_p(an_point,
                                            1,
                                            nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f),
                                            null,
                                            ln_Ret);
    if ln_Ret < 0 then
         an_Ret := -1;
         return;
     end if;
    exit;
END LOOP;*/

an_Ret := nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f);

EXCEPTION
    WHEN le_Debug THEN
        RS.rsCommon_PG.AddError_p('PointInList', 0, lv_Debug);
        an_Ret := -1;
    WHEN OTHERS THEN
        RS.rsCommon_PG.AddError_p('PointInList', SQLCode, SQLErrM);
        an_Ret := -1;
END;
------------------------------------

PROCEDURE Del_p(an_pointlist     IN NUMBER,
                an_point         IN NUMBER,
                an_Ret             OUT NUMBER
               ) is
ln_Ret NUMBER;
ln_FromPeriod NUMBER;
ln_TillPeriod NUMBER;
ln_RunLogging NUMBER;
ln_NotClearLog NUMBER;

lv_RecordType VARCHAR2(10);

le_Debug EXCEPTION;
lv_Debug VARCHAR2(512);
lri_Curr   ROWID;
BEGIN

SELECT nFromPeriod, nTillPeriod
INTO ln_FromPeriod, ln_TillPeriod
 FROM  SSPointInList pl
 WHERE nPointList = an_PointList
         and nPoint = an_Point
       and rs.rsCommon_pg.nAccPeriod_f between nFromPeriod and nvl(nTillPeriod,299912)
        ;

SELECT pl.nrunlogging,
        pl.nnotclearlog
 INTO  ln_RunLogging, ln_NotClearLog
 FROM  SSpointlist pl
 WHERE nPOintList = an_pointlist
 ;

-- Запись в журнал -----------
/*IF ln_RunLogging = 1 Then
  IF ln_NotClearLog = 1 THEN lv_RecordType := lv_RecordType||'Z'; END IF;

  RS.rsRoot_PG.Log_p('Удален абонент из списока с Ид = '||an_consumerlist,
                     'SSGROUP', ssGroup_RO_PG.tGetParents_f(an_Consumer, ln_CalcStep),
                     nvl(ln_fromperiod,RS.rsCommon_PG.nAccPeriod_f), ln_CalcStep > 0, true,
                     ln_CalcStep, lv_RecordType, ln_Ret, lri_Curr);
  if ln_Ret = -1 then an_Ret := -1; return; end if;

END IF;

if ln_CalcStep = 0 or nvl(ln_TillPeriod, 299912) < RS.rsCommon_PG.nConfAccPeriod_f then
  RS.RSROOT_PG.ClearCalc_p(nvl(ln_fromperiod,RS.rsCommon_PG.nAccPeriod_f), lri_Curr, ln_Ret);
  if ln_Ret = -1 then an_Ret := -1; return; end if;
end if;

-------------------------------
FOR lr IN gcur_l(an_consumer, an_consumerlist, null) LOOP
    ssRest_PG.InvalidateRests_p(an_consumer, 1, lr.nFromPeriod, null, ln_Ret);
    if ln_Ret < 0 then an_Ret := -1; return; end if;
    exit;
END LOOP;*/
---------------Begin Sechin A.A. 20.07.2002
    RS.rsRoot_PG.LogStep_p('Удалена ТУ из списока подстанций с Ид = '||an_pointlist,
                'SSPOINT', ssPoint_RO_PG.tGetParents_f(an_Point, 0, RS.rsCommon_PG.nAccPeriod_f),
                RS.rsCommon_PG.nAccPeriod_f, 0, '', ln_Ret, lri_Curr);
    if ln_Ret <0 then
      an_Ret := -1;
      return;
    end if;
---------------End Sechin A.A.

DELETE FROM SSpointinlist
  WHERE npointlist = an_pointlist
        and  nPoint = an_point
        and nFromPeriod = ln_FromPeriod
    ;

an_Ret := 1;
EXCEPTION
    WHEN le_Debug THEN
        RS.rsCommon_PG.AddError_p('POintInList', 0, lv_Debug);
        an_Ret := -1;
    WHEN OTHERS THEN
        RS.rsCommon_PG.AddError_p('PointInList', SQLCode, SQLErrM);
        an_Ret := -1;
END;
------------------------------------
PROCEDURE Upd_p(an_pointlist       IN NUMBER,
                an_point           IN NUMBER,
                an_tillPeriod         IN NUMBER,
                av_text               IN VARCHAR ,
                an_amount             IN NUMBER,
                an_sum                IN NUMBER,
                an_fromperiod         IN NUMBER,
                an_fromperiod_old     IN NUMBER,
                an_superior           IN NUMBER,
                an_Ret             OUT NUMBER
               ) is
lv_Debug VARCHAR2(512);
le_Debug EXCEPTION;

ln_Ret NUMBER;
ln_RunLogging NUMBER;
ln_NotClearLog NUMBER;
lv_RecordType VARCHAR2(10);
lri_Curr ROWID;

CURSOR lcur_include IS
Select *
from SSpointinlist
Where nPointList = an_pointlist
        and npoint = an_point and
      nFromPeriod = an_fromperiod_old
        ;

BEGIN

for lr in lcur_include loop

    SELECT pl.nrunlogging, pl.nnotclearlog
     INTO  ln_RunLogging, ln_NotClearLog
     FROM  SSpointlist     pl
     WHERE nPointList = an_pointlist;

/*    -- Запись в журнал -----------
    IF ln_RunLogging = 1 Then
      IF ln_NotClearLog = 1 THEN lv_RecordType := lv_RecordType||'Z'; END IF;

      RS.rsRoot_PG.Log_p('Изменены данные по абоненту в списке с Ид = '||an_consumerlist,
                         'SSGROUP', ssGroup_RO_PG.tGetParents_f(an_Consumer, ln_CalcStep),
                         nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f), ln_CalcStep > 0, true,
                         ln_CalcStep, lv_RecordType, ln_Ret, lri_Curr);
      if ln_Ret = -1 then an_Ret := -1; return; end if;

    END IF;

    if ln_CalcStep = 0 or
            greatest(nvl(an_TillPeriod, 299912),nvl(lr.nTillPeriod, 299912)) < RS.rsCommon_PG.nConfAccPeriod_f then
        RS.RSROOT_PG.ClearCalc_p(nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f), lri_Curr, ln_Ret);
        if ln_Ret = -1 then an_Ret := -1; return; end if;
    end if;*/
    UPDATE SSpointinlist
     SET   ntillperiod = an_tillPeriod,
           vtext= av_text,
           namount = an_amount,
           nsum = an_sum,
           nFromPeriod = an_fromperiod,
           nsuperior = an_superior
     WHERE npointlist = an_pointlist
                and  nPoint = an_point and
           nFromPeriod = an_fromperiod_old;
---------------Begin Sechin A.A. 20.07.2002
IF SQL%ROWCOUNT >0 THEN
    RS.rsRoot_PG.LogStep_p('Изменены данные по ТУ в списке Ид = '||an_pointlist,
                'SSPOINT', ssPoint_RO_PG.tGetParents_f(an_Point, 0, nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f)),
                nvl(an_fromperiod,RS.rsCommon_PG.nAccPeriod_f), 0, '', ln_Ret, lri_Curr);
    if ln_Ret <0 then
      an_Ret := -1;
      return;
    end if;
END IF;
---------------End Sechin A.A.

/*    FOR lr IN gcur_l(an_consumer, an_consumerlist, null) LOOP
        ssRest_PG.InvalidateRests_p(an_consumer, 1, least(an_fromperiod,an_fromperiod_old), null, ln_Ret);
        if ln_Ret < 0 then an_Ret := -1; return; end if;
        exit;
    END LOOP;*/
    exit;
end loop;

an_Ret := 1;

EXCEPTION
    WHEN le_Debug THEN
        RS.rsCommon_PG.AddError_p('PointInList', 0, lv_Debug);
        an_Ret := -1;
    WHEN OTHERS THEN
        RS.rsCommon_PG.AddError_p('PointInList', SQLCode, SQLErrM);
        an_Ret := -1;
END;
------------------------------------
PROCEDURE InsUpd_p( an_pointlist       IN NUMBER,
                    an_point           IN NUMBER,
                    av_text               IN VARCHAR ,
                    an_amount             IN NUMBER,
                    an_sum                IN NUMBER,
                    an_fromperiod         IN NUMBER,
                    an_tillperiod         IN NUMBER,
                    an_include            IN NUMBER,
                    an_fromperiod_old     IN NUMBER,
                    an_superior           IN NUMBER,
                    an_Ret             OUT NUMBER
               ) is
ln_ret NUMBER;
lv_Debug VARCHAR2(512);
le_Debug EXCEPTION;
Cursor lcur_exist is
    Select nPoint
    FROM SSpointinlist
    WHERE npointlist = an_pointlist
            and  nPOint = an_Point
            and rs.rsCommon_PG.nAccPeriod_f between nFromPeriod and nvl(nTillPeriod,299912)
    ;
Begin
open lcur_exist;
fetch lcur_exist into ln_ret;
close lcur_exist;
if an_include = 1 Then
    IF ln_ret is null Then
         Ins_p(an_pointlist, an_point, av_text, an_amount, an_sum, an_fromperiod,  an_tillperiod, 0, ln_ret);
    Else
         Upd_p(an_pointlist, an_point, an_tillperiod, av_text, an_amount, an_sum,
               an_fromperiod, an_fromperiod_old, an_superior, ln_ret);
    End if;
elsif ln_ret is not null then
    Upd_p(an_pointlist, an_point, rs.rsCommon_PG.f_PriorPeriod(rs.rsCommon_PG.nAccPeriod_f), av_text, an_amount,
          an_sum, an_fromperiod, an_fromperiod_old, an_superior, ln_ret);
else
    Del_p(an_pointlist, an_point, ln_Ret);
end if;

if ln_Ret = -1 then
    an_Ret := -1;
    return;
end if;

an_ret := ln_ret;

EXCEPTION
    WHEN le_Debug THEN
        RS.rsCommon_PG.AddError_p('PointInList', 0, lv_Debug);
        an_Ret := -1;
    WHEN OTHERS THEN
        RS.rsCommon_PG.AddError_p('PointInList', SQLCode, SQLErrM);
        an_Ret := -1;
End;
------------------------------------
PROCEDURE Verify_superior_p(an_pointlist       IN NUMBER,
                            an_Ret             OUT NUMBER
                            ) is
ln_count  NUMBER;
le_notvalid exception;
lv_name varchar2(256);
Begin
Select  count(npoint) into ln_count
from SSPointInList
where nPointList = an_Pointlist
        and nsuperior = 1
;
IF ln_count > 1 Then
    Select  vName into lv_name
     from SSPointList
    where nPointList = an_POintlist;
    raise le_notvalid;
ELSE
    an_Ret := 1;
END IF;
EXCEPTION
    WHEN le_notvalid THEN
        RS.rsCommon_PG.AddError_p('PointInList', SQLCode, 'Главных в списке <<'||lv_name||'>> не может быть больше одного');
        an_Ret := -1;
    WHEN OTHERS THEN
        RS.rsCommon_PG.AddError_p('PointInList', SQLCode, SQLErrM);
        an_Ret := -1;
END;

END;
/

-- End of DDL script for SSPOINTINLIST_PG
