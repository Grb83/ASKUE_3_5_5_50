//---------------------------------------------------------------------------
#ifndef ASKUETYPES_H
#define ASKUETYPES_H
//---------------------------------------------------------------------------
#include  <systdate.h>
//---------------------------------------------------------------------------
#define SELECTCOUNT 100   //!< Количество выбираемых записей из базы

#define NAME_LEN      256   //!< Длинна строки имени
#define DATE_LEN      50    //!< Длинна строки даты
#define PARAM_COUNT   14    //!< Максимальное количество параметров трансформаторов и линий
#define PARAM_NULL    -1    //!< Признак NULL'овского значения при вычитке/записи в БД
#define PARAM_NOTNULL 0     //!< Признак не NULL'овского значения при вычитке/записи в БД
//---------------------------------------------------------------------------
#define  WM_DATA_TASK_LIST  (WM_USER + 4) //Сообщение -отобразить список задач
#define  WM_CREATEMONITOR (WM_USER + 40)
#define  WM_UPDATE_SPEED_BUTTON (WM_USER+50)//

#include "Reconst.hpp"
//---------------------------------------------------------------------------
/*! Информация для расчета потерь по формуле
*/
typedef struct __ttimeinfo
{ long    nperiod;
  double  f1;
  double  f2;
  double  f3;
  short   indic[3];
  __ttimeinfo()
  { nperiod   = 0;    //!< Период
    f1        = 0;    //!< Время работы
    f2        = 0;    //!< Полное время работы
    f3        = 0;    //!< Полное время работы
    indic[0]  = 0;    //!<
    indic[1]  = 0;    //!<
    indic[2]  = 0;    //!<
  }
} TTimeInfo;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
/*
  Table [POINTS]
  Имена трансформаторов и линийй
  Field [IND] - справочник из Table [DICT_OBJ_TYPES]
*/

/*! Базовый класс трансформаторов и линий
*/
class TCustomTransformerLine
{
public:
  /*! Перечень типов трансформаторов и линий
  */
  typedef enum
  { ttNone    = 0x00,   //!< Не тр-р
    ttCurrent = 0x01,   //!< Изм. тр-р тока
    ttVoltage = 0x02,   //!< Изм. тр-р напряжения
    ttPower2  = 0x03,   //!< Силовой тр-р двухобмоточный
    ttPower3  = 0x04,   //!< Силовой тр-р трехобмоточный
    ttLine    = 0x05,    //!< Линия
    ttReactor = 0x06    //!< Реактор
  } TTransLineTypes;

  __fastcall TCustomTransformerLine(TTransLineTypes ttype = ttNone)
    :id(0), type(ttype), edit(false)
  { name  = Reconst_smes135_1.c_str();
    date  = TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn:ss").c_str();
  }
  __fastcall TCustomTransformerLine(TCustomTransformerLine *Other)
  { *this = *Other;
    name  = Reconst_smes135_1.c_str();
  }
  __fastcall ~TCustomTransformerLine()
  {
  }

  TCustomTransformerLine & operator=(TCustomTransformerLine &Other)
  { if (this == &Other)
      return  *this;
    id    = Other.id;
    type  = Other.type;
    edit  = Other.edit;
    name  = Other.name;
    date  = Other.date;

    return  *this;
  }

  long  id;         //!< Ид трансформатора или mid подстанции
  long  type;       //!< Тип трансформатора \sa TTransLineTypes
  bool  edit;       //!< Признак редактирования

  __property char *name   = {read = Getname, write = Setname};
  __property char *date   = {read = Getdate, write = Setdate};

  char  dname[NAME_LEN];  //!< Название
  char  ddate[DATE_LEN];  //!< дата установки

private:

  char * __fastcall Getname()
  { return  dname;
  }
  void __fastcall Setname(const char *Value)
  { memset(dname, 0, NAME_LEN);
    strcpy(dname, Value);
  }
  char * __fastcall Getdate()
  { return  ddate;
  }
  void __fastcall Setdate(const char *Value)
  { memset(ddate, 0, DATE_LEN);
    strcpy(ddate, Value);
  }
};
//---------------------------------------------------------------------------
//Реактор

class TReactor : public TCustomTransformerLine
{
  typedef TCustomTransformerLine  inherited;
public:
  __fastcall TReactor()
    :TCustomTransformerLine(ttReactor)
    , Un(0.0), Sn(0.0), DP(0.0), FHours(0.0), CHours(0.0)
    , indUn(PARAM_NULL), indSn(PARAM_NULL), indDP(PARAM_NULL), indFHours(PARAM_NULL), indCHours(PARAM_NULL)
  { name  = Reconst_smes135_2.c_str();
  }
  __fastcall TReactor(TReactor *Other)
    :TCustomTransformerLine(Other)
    , Un(0.0), Sn(0.0), DP(0.0), FHours(0.0), CHours(0.0)
    , indUn(PARAM_NULL), indSn(PARAM_NULL), indDP(PARAM_NULL), indFHours(PARAM_NULL), indCHours(PARAM_NULL)
  { *this = *Other;
    name  = Reconst_smes135_2.c_str();
  }
  __fastcall ~TReactor()
  {
  }

  TReactor & operator=(TReactor &Other)
  { if (this == &Other)
      return  *this;

    inherited::operator =(Other);
    //===== параметры записываются в таблицу CONNECTIONPARAM
    Un        = Other.Un;     //===== Un
    indUn     = Other.indUn;
    Sn        = Other.Sn;     //===== Sn
    indSn     = Other.indSn;
    DP        = Other.DP;      //===== DP
    indDP     = Other.indDP;
    FHours    = Other.FHours;     //===== FHours
    indFHours = Other.indFHours;
    CHours    = Other.CHours;     //===== CHours
    indCHours = Other.indCHours;

    return  *this;
  }

  double  Un;       //!< Номинальное напряжение
  short   indUn;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Sn;       //!< Номинальная мощность
  short   indSn;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  DP;        //!< Потери мощности
  short   indDP;     //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  FHours;    //!< Фактическое число часов работы реактора
  short   indFHours;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  CHours;    //!< Календарное число часов работы реактора
  short   indCHours;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
};

//---------------------------------------------------------------------------
/*! Линия
*/
class TTransmissionLine : public TCustomTransformerLine
{
  typedef TCustomTransformerLine  inherited;
public:
  __fastcall TTransmissionLine()
    :TCustomTransformerLine(ttLine)
    , Ro(0.0), Xo(0.0), L(0.0), Un(0.0)
    , indRo(PARAM_NULL), indXo(PARAM_NULL), indL(PARAM_NULL), indUn(PARAM_NULL)
  { name  = Reconst_smes135_3.c_str();
  }
  __fastcall TTransmissionLine(TTransmissionLine *Other)
    :TCustomTransformerLine(Other)
    , Ro(0.0), Xo(0.0), L(0.0), Un(0.0)
    , indRo(PARAM_NULL), indXo(PARAM_NULL), indL(PARAM_NULL), indUn(PARAM_NULL)
  { *this = *Other;
    name  = Reconst_smes135_3.c_str();
  }
  __fastcall ~TTransmissionLine()
  {
  }

  TTransmissionLine & operator=(TTransmissionLine &Other)
  { if (this == &Other)
      return  *this;

    inherited::operator =(Other);
    //===== параметры записываются в таблицу CONNECTIONPARAM
    Ro    = Other.Ro;     //===== NRO
    indRo = Other.indRo;
    Xo    = Other.Xo;     //===== NXO
    indXo = Other.indXo;
    L     = Other.L;      //===== NL
    indL  = Other.indL;
    Un    = Other.Un;     //===== NUN
    indUn = Other.indUn;

    return  *this;
  }

  double  Ro;       //!< Активное сопротивление
  short   indRo;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Xo;       //!< Реактивное сопротивление
  short   indXo;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  L;        //!< Длинна линии
  short   indL;     //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Un;       //!< Номинальное напряжение
  short   indUn;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
};
//---------------------------------------------------------------------------
/*! Измерительный трансформатор
*/
class TMeteringTransformer  : public TCustomTransformerLine
{
  typedef TCustomTransformerLine  inherited;
public:
  __fastcall TMeteringTransformer(TTransLineTypes ttype = ttNone)
    :TCustomTransformerLine(ttype)
    , Val1(0.0), Val2(0.0)
    , indVal1(PARAM_NULL), indVal2(PARAM_NULL)
  { name  = Reconst_smes135_4.c_str();
  }
  __fastcall TMeteringTransformer(TMeteringTransformer *Other)
    :TCustomTransformerLine(Other)
    , Val1(0.0), Val2(0.0)
    , indVal1(PARAM_NULL), indVal2(PARAM_NULL)
  { *this = *Other;
    name  = Reconst_smes135_4.c_str();
  }
  __fastcall ~TMeteringTransformer()
  {
  }

  TMeteringTransformer & operator=(TMeteringTransformer &Other)
  { if (this == &Other)
      return  *this;

    inherited::operator =(Other);
    Val1    = Other.Val1;
    indVal1 = Other.indVal1;
    Val2    = Other.Val2;
    indVal2 = Other.indVal2;

    return  *this;
  }

  double  Val1;       //!< Первичный ток или напряжение
  short   indVal1;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Val2;       //!< Вторичный ток или напряжение
  short   indVal2;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
};
//---------------------------------------------------------------------------
/*! Силовой трансформатор 2-х обмоточный
*/
class TPowerTwoTransformer  : public TCustomTransformerLine
{
  typedef TCustomTransformerLine  inherited;
public:
  __fastcall TPowerTwoTransformer()
    :TCustomTransformerLine(ttPower2)
    , Sn(0.0), dPxx(0.0), dPkz(0.0), Ixx(0.0), Ukz(0.0)
    , WHours(0.0), FHours(0.0)
    , indSn(PARAM_NULL), inddPxx(PARAM_NULL), inddPkz(PARAM_NULL)
    , indIxx(PARAM_NULL), indUkz(PARAM_NULL)
    , indWHours(PARAM_NULL), indFHours(PARAM_NULL)
  { name  = Reconst_smes135_5.c_str();
  }
  __fastcall TPowerTwoTransformer(TPowerTwoTransformer *Other)
    :TCustomTransformerLine(Other)
    , Sn(0.0), dPxx(0.0), dPkz(0.0), Ixx(0.0), Ukz(0.0)
    , WHours(0.0), FHours(0.0)
    , indSn(PARAM_NULL), inddPxx(PARAM_NULL), inddPkz(PARAM_NULL)
    , indIxx(PARAM_NULL), indUkz(PARAM_NULL)
    , indWHours(PARAM_NULL), indFHours(PARAM_NULL)
  { *this = *Other;
    name  = Reconst_smes135_5.c_str();
  }
  __fastcall ~TPowerTwoTransformer()
  {
  }

  TPowerTwoTransformer & operator=(TPowerTwoTransformer &Other)
  { if (this == &Other)
      return  *this;

    inherited::operator =(Other);
    //===== параметры записываются в таблицу CONNECTIONPARAM
    Sn        = Other.Sn;       //NSN
    indSn     = Other.indSn;
    dPxx      = Other.dPxx;     //NDELTAPIDLING
    inddPxx   = Other.inddPxx;
    dPkz      = Other.dPkz;     //NDELTAPSC
    inddPkz   = Other.inddPkz;
    Ixx       = Other.Ixx;      //NIIDLING
    indIxx    = Other.indIxx;
    Ukz       = Other.Ukz;      //NUSC
    indUkz    = Other.indUkz;
    WHours    = Other.WHours;   //NWORKINGHOURS
    indWHours = Other.indWHours;
    FHours    = Other.FHours;   //NFULLHOURS
    indFHours = Other.indFHours;

    return  *this;
  }

  double  Sn;           //!< Номинальная мощность кВА
  short   indSn;        //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  dPxx;         //!< Потери холостого хода кВт
  short   inddPxx;      //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  dPkz;         //!< Потери короткого замыкания кВт
  short   inddPkz;      //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Ixx;          //!< Ток холостого хода %
  short   indIxx;       //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Ukz;          //!< Напряжение короткого замыкания %
  short   indUkz;       //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  WHours;       //!< Номинальное время работы
  short   indWHours;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  FHours;       //!< Номинальное полное время
  short   indFHours;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
};
//---------------------------------------------------------------------------
/*! Силовой трансформатор 3-х обмоточный
*/
class TPowerThreeTransformer  : public TCustomTransformerLine
{
  typedef TCustomTransformerLine  inherited;
public:
  __fastcall TPowerThreeTransformer()
    :TCustomTransformerLine(ttPower3)
    , Sn(0.0), Su(0.0), Sm(0.0), Sd(0.0)
    , dPxx(0.0), dPkzu(0.0), dPkzm(0.0), dPkzd(0.0)
    , Ixx(0.0), Ukzu(0.0), Ukzm(0.0), Ukzd(0.0)
    , WHours(0.0), FHours(0.0)
    , indSn(PARAM_NULL), indSu(PARAM_NULL), indSm(PARAM_NULL), indSd(PARAM_NULL)
    , inddPxx(PARAM_NULL), inddPkzu(PARAM_NULL), inddPkzm(PARAM_NULL), inddPkzd(PARAM_NULL)
    , indIxx(PARAM_NULL), indUkzu(PARAM_NULL), indUkzm(PARAM_NULL), indUkzd(PARAM_NULL)
    , indWHours(PARAM_NULL), indFHours(PARAM_NULL)
  { name  = Reconst_smes135_6.c_str();
  }
  __fastcall TPowerThreeTransformer(TPowerThreeTransformer *Other)
    :TCustomTransformerLine(Other)
    , Sn(0.0), Su(0.0), Sm(0.0), Sd(0.0)
    , dPxx(0.0), dPkzu(0.0), dPkzm(0.0), dPkzd(0.0)
    , Ixx(0.0), Ukzu(0.0), Ukzm(0.0), Ukzd(0.0)
    , WHours(0.0), FHours(0.0)
    , indSn(PARAM_NULL), indSu(PARAM_NULL), indSm(PARAM_NULL), indSd(PARAM_NULL)
    , inddPxx(PARAM_NULL), inddPkzu(PARAM_NULL), inddPkzm(PARAM_NULL), inddPkzd(PARAM_NULL)
    , indIxx(PARAM_NULL), indUkzu(PARAM_NULL), indUkzm(PARAM_NULL), indUkzd(PARAM_NULL)
    , indWHours(PARAM_NULL), indFHours(PARAM_NULL)
  { *this = *Other;
    name  = Reconst_smes135_6.c_str();
  }
  __fastcall ~TPowerThreeTransformer()
  {
  }

  TPowerThreeTransformer & operator=(TPowerThreeTransformer &Other)
  { if (this == &Other)
      return  *this;

    inherited::operator =(Other);
    //===== параметры записываются в таблицу CONNECTIONPARAM
    Sn        = Other.Sn;       //NSN где NWINDING=1
    indSn     = Other.indSn;
    Su        = Other.Su;       //NSH где NWINDING=1
    indSu     = Other.indSu;
    Sm        = Other.Sm;       //NSH где NWINDING=2
    indSm     = Other.indSm;
    Sd        = Other.Sd;       //NSH где NWINDING=3
    indSd     = Other.indSd;
    dPxx      = Other.dPxx;     //NDELTAPIDLING где NWINDING=1
    inddPxx   = Other.inddPxx;
    dPkzu     = Other.dPkzu;    //NDELTAPSC где NWINDING=1
    inddPkzu  = Other.inddPkzu;
    dPkzm     = Other.dPkzm;    //NDELTAPSC где NWINDING=2
    inddPkzm  = Other.inddPkzm;
    dPkzd     = Other.dPkzd;    //NDELTAPSC где NWINDING=3
    inddPkzd  = Other.inddPkzd;
    Ixx       = Other.Ixx;      //NIIDLING где NWINDING=1
    indIxx    = Other.indIxx;
    Ukzu      = Other.Ukzu;     //NUSC где NWINDING=1
    indUkzu   = Other.indUkzu;
    Ukzm      = Other.Ukzm;     //NUSC где NWINDING=2
    indUkzm   = Other.indUkzm;
    Ukzd      = Other.Ukzd;     //NUSC где NWINDING=3
    indUkzd   = Other.indUkzd;
    WHours    = Other.WHours;   //NWORKINGHOURS где NWINDING=1
    indWHours = Other.indWHours;
    FHours    = Other.FHours;   //NFULLHOURS где NWINDING=1
    indFHours = Other.indFHours;

    return  *this;
  }

  double  Sn;           //!< Номинальная мощность кВА
  short   indSn;        //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Su;           //!< Номинальная мощность верхней обмотки кВА
  short   indSu;        //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Sm;           //!< Номинальная мощность средней обмотки кВА
  short   indSm;        //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Sd;           //!< Номинальная мощность нижней обмотки кВА
  short   indSd;        //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  dPxx;         //!< Потери холостого хода кВт
  short   inddPxx;      //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  dPkzu;        //!< Потери короткого замыкания верхней обмотки кВт
  short   inddPkzu;     //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  dPkzm;        //!< Потери короткого замыкания средней обмотки кВт
  short   inddPkzm;     //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  dPkzd;        //!< Потери короткого замыкания нижней обмотки кВт
  short   inddPkzd;     //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Ixx;          //!< Ток холостого хода %
  short   indIxx;       //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Ukzu;         //!< Напряжение короткого замыкания верхней обмотки %
  short   indUkzu;      //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Ukzm;         //!< Напряжение короткого замыкания средней обмотки %
  short   indUkzm;      //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  Ukzd;         //!< Напряжение короткого замыкания нижней обмотки %
  short   indUkzd;      //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  WHours;       //!< Номинальное время работы
  short   indWHours;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
  double  FHours;       //!< Номинальное полное время
  short   indFHours;    //!< Признак значения NULL \sa PARAM_NULL \sa PARAM_NOTNULL
};
//---------------------------------------------------------------------------
#endif  //ASKUETYPES_H
//---------------------------------------------------------------------------

