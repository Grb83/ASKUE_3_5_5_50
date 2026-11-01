
-- Start of DDL script for SSUTILSGAEK
-- Generated 25-ноя-02  10:18:43 am
-- from ea-SS:1

-- Package SSUTILSGAEK

CREATE OR REPLACE
PACKAGE SSUTILSGAEK
  IS
------------------------------------------------------------------------------------------------------------
--**    Function: nSaldo_begin_f
--**    Input arguments:
--**      an_Consumer  - Идентификатор абонента
--**      an_AccPeriod - Год и месяц отчетного периода (формат 'YYYYMM'), в 1-й функции используется текущий
--**                     отчетный период сессии
--**      an_Part      - Идентификатор счета (раздела)
--**    Returns:         Сумма сальдо
--**    Description:  Получение сальдо на начало месяца (отчетного периода).
------------------------------------------------------------------------------------------------------------
  FUNCTION nSaldo_begin_f
     (an_consumer IN NUMBER,
      an_AccPeriod IN NUMBER,
      an_part IN NUMBER)
      RETURN NUMBER;
  PRAGMA RESTRICT_REFERENCES (nSaldo_begin_f, WNDS, WNPS);

-------------------------------------------------------------------------------------------------------------
--**    Function: n_RetDeb_f
--**    Input arguments:
--**      an_Consumer        - Идентификатор абонента
--**      an_Part            - Идентификатор счета (раздела)
--**      an_AccPeriod       - Год и месяц отчетного периода (формат 'YYYYMM')
--**    Returns:         Сумма полного оборота дебета за месяц
--**    Description:     Получение полного оборота дебета(начислений) за месяц (отчетный период) по разделу.
------------------------------------------------------------------------------------------------------------
 FUNCTION n_RetDeb_f(an_consumer IN NUMBER,
      an_AccPeriod IN NUMBER,
      an_part IN NUMBER) RETURN NUMBER;
  PRAGMA RESTRICT_REFERENCES (n_RetDeb_f, WNDS, WNPS);

 ------------------------------------------------------------------------------------------------------------
--**    Function: n_RetAmount_f
--**    Input arguments:
--**      an_Consumer        - Идентификатор абонента
--**      an_Part            - Идентификатор счета (раздела)
--**      an_AccPeriod       - Год и месяц отчетного периода (формат 'YYYYMM')
--**    Returns:         Полное потребление за месяц
--**    Description:     Получение полного потребления абонета за месяц (отчетный период) по разделу в квт*ч
--**                     (по КРЭ при временном порядке расчета в квар*ч).
------------------------------------------------------------------------------------------------------------
  FUNCTION n_RetAmount_f(an_consumer IN NUMBER,
      an_AccPeriod IN NUMBER,
      an_part IN NUMBER) RETURN NUMBER;
  PRAGMA RESTRICT_REFERENCES (n_RetAmount_f, WNDS, WNPS);

-------------------------------------------------------------------------------------------------------------
--**    Function: n_RetPay_f
--**    Input arguments:
--**      an_Consumer        - Идентификатор абонента
--**      an_Part            - Идентификатор счета (раздела)
--**      an_AccPeriod       - Год и месяц отчетного периода (формат 'YYYYMM')
--**    Returns:         Сумма оборота кредита
--**    Description:     Получение оборота кредита(оплат) за месяц (отчетный период) по разделу.
-------------------------------------------------------------------------------------------------------------
  FUNCTION n_RetPay_f(an_consumer IN NUMBER,
      an_AccPeriod IN NUMBER,
      an_part IN NUMBER) RETURN NUMBER;
  PRAGMA RESTRICT_REFERENCES (n_RetPay_f, WNDS, WNPS);

  -- выполняется в тригере LINKFORGAEK.ON_LOGON_TO_WORK_SCHEMA
  procedure Begin_f;

-------------------------------------------------------------------------------------------------------------
--**    Function: n_CurrDedt_f
--**    Input arguments:
--**      an_Consumer        - Идентификатор абонента
--**      an_CurrentDate     - Дата
--**    Returns:         Сумма
--**    Description: Текущий долг
-------------------------------------------------------------------------------------------------------------
  FUNCTION n_CurrDedt_f
     (an_consumer IN NUMBER,
      ad_CurrentDate IN DATE) RETURN NUMBER;
--  PRAGMA RESTRICT_REFERENCES (n_CurrDedt_f, WNDS, WNPS);

-------------------------------------------------------------------------------------------------------------
--**    Function: n_RestrCurrDedt_f
--**    Input arguments:
--**      an_Consumer        - Идентификатор абонента
--**      an_CurrentDate     - Дата
--**    Returns:         Сумма
--**    Description: Текущий долг с учетом реструктуризации
-------------------------------------------------------------------------------------------------------------
  FUNCTION n_RestrCurrDedt_f
     (an_consumer IN NUMBER,
      ad_CurrentDate IN DATE) RETURN NUMBER;
--  PRAGMA RESTRICT_REFERENCES (n_RestrCurrDedt_f, WNDS, WNPS);

END;
/

-- End of DDL script for SSUTILSGAEK

-- Start of DDL script for SSUTILSGAEK
-- Generated 25-ноя-02  10:19:01 am
-- from ea-SS:1

-- Package body SSUTILSGAEK

CREATE OR REPLACE
PACKAGE BODY SSUTILSGAEK
IS
  FUNCTION nSaldo_begin_f
     (an_consumer IN NUMBER,
      an_AccPeriod IN NUMBER,
      an_part IN NUMBER)
      RETURN NUMBER is
begin
    return ss.ssutils.nSaldo_begin_f(an_consumer,an_AccPeriod,an_part);
end;

 FUNCTION n_RetDeb_f(an_consumer IN NUMBER,
      an_AccPeriod IN NUMBER,
      an_part IN NUMBER) RETURN NUMBER is
begin
    return ss.ssutils.n_RetDeb_f(an_Consumer, an_Part, an_AccPeriod);
end;

FUNCTION n_RetAmount_f(an_consumer IN NUMBER,
      an_AccPeriod IN NUMBER,
      an_part IN NUMBER) RETURN NUMBER is
begin
    return ss.ssutils.n_RetAmount_f(an_Consumer, an_Part, an_AccPeriod);
end;

FUNCTION n_RetPay_f(an_consumer IN NUMBER,
      an_AccPeriod IN NUMBER,
      an_part IN NUMBER) RETURN NUMBER is
begin
    return ss.ssutils.n_RetPay_f(an_Consumer, an_Part, an_AccPeriod);
end;

  procedure Begin_f is
  l_ret number;
  begin l_ret:=rs.rscommon_pg.begin_f;end;

-------------------------------------------------------------------------------------------------------------
  FUNCTION n_CurrDedt_f
     (an_consumer IN NUMBER,
      ad_CurrentDate IN DATE) RETURN NUMBER
  is
  begin
  return
     ss.SSANDRREPORT2_PG.Debts_f(an_consumer,to_char(ad_CurrentDate,'YYYYMMDD'),1,1,1)+ --nPODebt, --
     ss.SSANDRREPORT2_PG.Debts_f(an_consumer,to_char(ad_CurrentDate,'YYYYMMDD'),121,1,1)+ --nNDSDebt, --
     ss.SSANDRREPORT2_PG.Debts_f(an_consumer,to_char(ad_CurrentDate,'YYYYMMDD'),905,1,1); --nNDSeksDebt -- ;
  end;
-------------------------------------------------------------------------------------------------------------
  FUNCTION n_RestrCurrDedt_f
     (an_consumer IN NUMBER,
      ad_CurrentDate IN DATE) RETURN NUMBER
  is
  ln_Res NUMBER;
  begin
  select sum(nsum) summ into ln_Res
    from SS.VSSDEBTSSHEDULE_DETAILED d
    where nconsumer=an_consumer
    		and DCLEARING > trunc(sysdate)
    		and nvl(DCLOSING,sysdate) > trunc(sysdate)
    		--and npart is null
    		and npart in (11,402,101,121,905)
    		and NUSEINFINECALC=1
    ;
  return n_CurrDedt_f(an_consumer, ad_CurrentDate) - ln_Res;
  end;


END;
/

-- End of DDL script for SSUTILSGAEK
