//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "DLK_ViewShem.h"
#include "unDataMod.h"
#include "PeriodFormUnit.h"
#include "InfoFormUnit.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#include <vector>
//---------------------------------------------------------------------------
#pragma link "Open_OCX"
#pragma package(smart_init)
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
typedef std::vector<long> TDataVector;
//---------------------------------------------------------------------------
#define DATATYPE_DEBIT      0
#define DATATYPE_LOSS       1
#define DATATYPE_DEBIT_LOSS 2
#define PERIOD_COUNT  36
//---------------------------------------------------------------------------
__fastcall TViewShemForm::TViewShemForm(TComponent* Owner, AnsiString Name, TAccess acc,
                                        TVSFormType vsftype)
  : TMainForm(Owner, Name, acc)
{
  d = new TMainFormPrivate;

  int tInt;
  switch (vsftype)
  { case vsCommutation:
      EditRec = false;
      MainCoolBar->Visible  = false;
      ShemEdit->Mode  = 1;
      ShemEdit->ConnectToDB(WideString(dmMain->orases->Server), WideString(dmMain->orases->Username), WideString(dmMain->orases->Password), &tInt);
      if (tInt != 1)
      { delete  d;
        d = NULL;
        throw Exception(Reconst_smes13_1);
      }
      break;
    case vsLoss:
      EditRec = false;
      MainCoolBar->Visible  = true;

      ShemEdit->Preview       = true;
      ShemEdit->ToolVisible   = false;
      ShemEdit->forAscueProp  = false;
      ShemEdit->AscueShEdit   = false;
      ShemEdit->Mode          = 2;

      ScaleCB->ItemIndex  = 5;
      DataTypeCB->ItemIndex = 2;

      //===== Проверка типа расчета потерь (Сутки/Месяц)
      //GRB ADD 16.04.2020 - test trouble ODAC
      dmMain->quMain->Params->Clear();
      //END ADD 
      dmMain->quMain->SQL->Text="select vvalue from ryda.parameter where npid = 30";
      tInt  = 0;
      dmMain->quMain->Execute();
      if(!dmMain->quMain->FieldByName("vvalue")->IsNull)
      tInt=dmMain->quMain->FieldByName("vvalue")->AsInteger;
      if ((dmMain->quMain->RecordCount > 0) && (tInt == 1))
      { PeriodDTP->Visible  = true;
        PeriodDTP->Width    = 80;
        PeriodCB->Visible   = false;
        PeriodCB->Width     = 1;
      }
      else
      { PeriodDTP->Visible  = false;
        PeriodDTP->Width    = 1;
        PeriodCB->Visible   = true;
        PeriodCB->Width     = 80;
      }

      LoadShemList();
      LoadShem();
      LoadPeriodList();
      break;
    case vsNone:
    default:
      dvstype = vsNone;
      delete  d;
      d = NULL;
      throw Exception(Reconst_smes13_2);
  }
  dvstype = vsftype;
  EditRec = false;

  mnEdit->Visible   = false;
}
//---------------------------------------------------------------------------
/*! Загрузка схемы в ActiveX.

    Исходные данные для схемы берутся из выпадающих списков.
*/
void __fastcall TViewShemForm::LoadShem()
{
  if (ShemCB->ItemIndex < 0)
    return;

  ShemEdit->Clear();
  ShemEdit->Scale = ScaleCB->Items->Strings[ScaleCB->ItemIndex].ToInt();
  TDataVector tmpObjects;
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="select sc.classu sc_classu, sc.color sc_color from ryda.se_colors sc ";
  dmMain->quMain->Execute();
  while(!dmMain->quMain->Eof){
    ShemEdit->AddColorU(dmMain->quMain->FieldByName("sc_classu")->AsFloat, dmMain->quMain->FieldByName("sc_color")->AsInteger);
    dmMain->quMain->Next();
  }
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="select ss.width ss_width, ss.height ss_height "
                          "from ryda.se_sheets ss "
                         "where ss.sid = " + AnsiString (d->shemStr);
  dmMain->quMain->Execute();
  if(!dmMain->quMain->Eof&&!dmMain->quMain->FieldByName("ss_width")->IsNull&&!dmMain->quMain->FieldByName("ss_height")->IsNull)
    ShemEdit->SetShemSize(dmMain->quMain->FieldByName("ss_width")->AsInteger, dmMain->quMain->FieldByName("ss_height")->AsInteger);
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="select so.ord so_ord, so.se_type so_se_type, nvl(so.oid, 0) so_oid, "
                "so.name so_name, so.x1 so_x1, so.x2 so_x2, so.y1 so_y1, so.y2 so_y2, "
                "so.layer so_layer, nvl(so.classu, 0) so_classu, nvl(so.feeder, 0) so_feeder "
              "from ryda.se_objects so "
              "where so.sid = " + d->shemStr;
  dmMain->quMain->Execute();
  while(!dmMain->quMain->Eof){
    ShemEdit->AddElement(dmMain->quMain->FieldByName("so_ord")->AsInteger, dmMain->quMain->FieldByName("so_se_type")->AsInteger, dmMain->quMain->FieldByName("so_oid")->AsInteger,
      WideString(dmMain->quMain->FieldByName("so_name")->AsString), dmMain->quMain->FieldByName("so_x1")->AsInteger, dmMain->quMain->FieldByName("so_y1")->AsInteger, dmMain->quMain->FieldByName("so_x2")->AsInteger,
      dmMain->quMain->FieldByName("so_y2")->AsInteger, dmMain->quMain->FieldByName("so_layer")->AsInteger, dmMain->quMain->FieldByName("so_classu")->AsFloat,dmMain->quMain->FieldByName("so_feeder")->AsInteger);
    tmpObjects.push_back(dmMain->quMain->FieldByName("so_ord")->AsInteger);
    dmMain->quMain->Next();
  }
  //load objects property
  TDataVector::iterator iter  = tmpObjects.begin();
  while (iter != tmpObjects.end()){
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="select sp.name sp_name, sv.value sv_value "
                "from ryda.se_values sv, ryda.se_properties sp "
                "where sv.sid = " + d->shemStr + " "
                  "and sv.ord = " + IntToStr(*iter) + " "
                  "and sv.pid = sp.pid";
    dmMain->quMain->Execute();
    while(!dmMain->quMain->Eof){
      ShemEdit->SetElPropertyVal(WideString(IntToStr(*iter)),WideString(dmMain->quMain->FieldByName("sp_name")->AsString),WideString(dmMain->quMain->FieldByName("sv_value")->AsString));
      dmMain->quMain->Next();
    }
    iter++;
  }
  tmpObjects.clear();
}
//---------------------------------------------------------------------------
/*! Очистка всех значений
*/
void __fastcall TViewShemForm::ClearLoss()
{
  try{
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="select sp.name sp_name from ryda.se_properties sp where sp.pid = " + IntToStr(d->pid_text);
    dmMain->quMain->Execute();
    if(dmMain->quMain->Eof||dmMain->quMain->FieldByName("sp_name")->AsString.IsEmpty())
      return;
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="select so.ord so_ord "
                "from ryda.se_objects so "
                "where so.sid = " + d->shemStr + " "
                  "and so.se_type in(200, 210)";
    dmMain->quMain->Execute();
    while(!dmMain->quMain->Eof){
      ShemEdit->SetMeterValue(WideString(dmMain->quMain->FieldByName("so_ord")->AsString),WideString("0000"), WideString(" "), clBlack, clWhite);
      dmMain->quMain->Next();
    }
  }catch (Exception &e){
  }
}
//---------------------------------------------------------------------------
/*! Загрузка данных по переключениям на схеме в зависимости от информации
    в выпадающих списках
*/
void __fastcall TViewShemForm::LoadCommutation()
{
  AnsiString  property_name;  //===== Наименование свойства
  AnsiString  date_from;      //===== Дата начала периода
  try{
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="select sp.name sp_name from ryda.se_properties sp where sp.pid = " + IntToStr(d->pid);
    dmMain->quMain->Execute();
    property_name=dmMain->quMain->FieldByName("sp_name")->AsString;
    if(dmMain->quMain->Eof)
      return;
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="select to_char(cp.sdate, 'dd.mm.yyyy hh24:mi') cp_sdate from ryda.calc_periods cp where cp.cpid = " + IntToStr(d->subperiodID);
    dmMain->quMain->Execute();
    if(dmMain->quMain->Eof||dmMain->quMain->FieldByName("cp_sdate")->IsNull)
      return;
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="select oo.ord oo_ord, os.state os_state from ryda.osm_switchings os, ryda.se_objects oo where oo.sid = " + d->shemStr + " "
                  "and os.oid = oo.oid and trunc(os.sdate, 'mi') <= to_date('" + dmMain->quMain->FieldByName("cp_sdate")->AsString +
                  "', 'dd.mm.yyyy hh24:mi') and trunc(os.ldate, 'mi') > to_date('" + dmMain->quMain->FieldByName("cp_sdate")->AsString + "', 'dd.mm.yyyy hh24:mi')";
    dmMain->quMain->Execute();
    while(!dmMain->quMain->Eof){
      ShemEdit->SetElPropertyVal(WideString(dmMain->quMain->FieldByName("oo_ord")->AsString),WideString(property_name),WideString(dmMain->quMain->FieldByName("os_state")->AsString));
      dmMain->quMain->Next();
    }
  }catch(Exception &e){
  }
}
//---------------------------------------------------------------------------
/*! Загрузка потерь по данным в выпадающих списках
*/
void __fastcall TViewShemForm::LoadLoss()
{
  ClearLoss();

  //===== Если нет данных для выборки - вылетаем
  if (PeriodCB->ItemIndex < 0
      || SubPeriodCB->ItemIndex < 0
      || DataTypeCB->ItemIndex < 0)
    return;
  try
  { WideString  valStr;
    WideString  srcStr;
    TColor      tColor,
                bColor;
    //===== Заполнение данными меток на схеме
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD   
  dmMain->quMain->SQL->Text="select b.ord b_ord, a.src a_src, "
    //                                                                  3
                  "round(decode(b.se_type, 200, a.wh, 210, a.varh), 1) valDebit, "
    //                                                                                4
                  "round(decode(b.se_type, 200, a.lossed_wh, 210, a.lossed_varh), 1) valLoss, "
    //                                                                                                5
                  "round(decode(b.se_type, 200, a.wh + a.lossed_wh, 210, a.varh + a.lossed_varh), 1) valSum, "
    //                  6               7               8
                  "a.qm a_qm, b.se_type b_se_type, a.wh a_debit "
                "from ryda.calc_results a, ryda.se_objects b "
                "where b.sid = " + d->shemStr + " "
                  "and a.cpid = " + IntToStr((long)SubPeriodCB->Items->Objects[SubPeriodCB->ItemIndex]) + " "
                  "and a.oid = b.feeder "
                  "and b.se_type in (200, 210)";
    dmMain->quMain->Execute();
    while(!dmMain->quMain->Eof){
      //===== Значение
      switch (DataTypeCB->ItemIndex){
        case DATATYPE_DEBIT:
          valStr  = dmMain->quMain->FieldByName("valDebit")->AsString;
          break;
        case DATATYPE_LOSS:
          valStr  = dmMain->quMain->FieldByName("valLoss")->AsString;
          break;
        case DATATYPE_DEBIT_LOSS:
          valStr  = dmMain->quMain->FieldByName("valSum")->AsString;
          break;
        default:
          continue;
      }
      //===== Источник
      switch (dmMain->quMain->FieldByName("a_src")->AsInteger){
        case 20:
          srcStr  = "Ш";
          break;
        case 30:
          srcStr  = "Л";
          break;
        case 40:
          srcStr  = "Т";
          break;
        case 10:
        default:
          srcStr  = " ";
          break;
      }
      switch (dmMain->quMain->FieldByName("a_qm")->AsInteger){ //===== Нет данных
        case 1:
            tColor  = clYellow;
            bColor  = clRed;
          break;
        //===== Отключен
        case -1:
            tColor  = (dmMain->quMain->FieldByName("a_debit")->AsFloat == 0) ? clBlack : clRed;
            bColor  = clWhite;
          break;
        //====== Свернут
        case -2:
            tColor  = clYellow;
            bColor  = clGray;
          break;
        //====== Навернут
        case -3:
            tColor  = clBlack;
            bColor  = clGray;
          break;
        //===== ОК
        case 0:
        default:
            tColor  = clBlack;
            bColor  = clWhite;
          break;
      }
      //SetMeterValue(ORD - ID метки, VALUE - значение, SRC - Источник,
      //                TEXT_COLOR - цвет текста, BACKGROUND_COLOR - цвет фона)
      ShemEdit->SetMeterValue(WideString(dmMain->quMain->FieldByName("b_ord")->AsString), valStr, srcStr, tColor, bColor);
      dmMain->quMain->Next();
    }
  }catch (Exception &e){
  }
}
//---------------------------------------------------------------------------
/*! Загрузка списка схем в ComboBox
*/
void __fastcall TViewShemForm::LoadShemList()
{
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="select s.name s_name, s.sid s_sid "
              "from ryda.se_sheets s "
              "where s.sid in (select o.sid o_sid "
                                "from ryda.se_objects o "
                                "where o.oid is not null "
                                  "and o.oid <> 0 "
                                  "and o.se_type in (select stm.se_type stm_se_type "
                                                      "from ryda.se_type_map stm "
                                                      "where stm.IS_RTOBJ is not null)) "
              "order by s.name";
  ShemCB->Items->Clear();
  dmMain->quMain->Execute();
  while(!dmMain->quMain->Eof){
    ShemCB->Items->AddObject(dmMain->quMain->FieldByName("s_name")->AsString, (TObject *)(dmMain->quMain->FieldByName("s_sid")->AsInteger));
    dmMain->quMain->Next();
  }
  //===== Выбор первой схемы в списке
  ShemCB->ItemIndex = ShemCB->Items->Count > 0 ? 0 : -1;
  if (ShemCB->ItemIndex < 0)
  { d->shemID   = BAD_ID;
    d->shemStr  = BAD_STR;
  }
  else
  { if (d->shemID != BAD_ID)
    { ShemCB->ItemIndex = ShemCB->Items->IndexOfObject((TObject *)d->shemID);
      if (ShemCB->ItemIndex < 0)
        ShemCB->ItemIndex = 0;
    }
    d->shemID   = (long)ShemCB->Items->Objects[ShemCB->ItemIndex];
    d->shemStr  = IntToStr(d->shemID);
  }
}
//---------------------------------------------------------------------------
/*! Зеагрузка списка Расчетных периодов в ComboBox
*/
void __fastcall TViewShemForm::LoadPeriodList()
{
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="select distinct cp.period cp_period "
              "from ryda.calc_periods cp "
              "order by cp.period desc";
   PeriodCB->Items->Clear();
   int i=0;
   dmMain->quMain->Execute();
   while(!dmMain->quMain->Eof){
     PeriodCB->Items->Add(dmMain->quMain->FieldByName("cp_period")->AsString);
     i++;
     if (PeriodCB->Visible && (i >= PERIOD_COUNT))
      break;
     dmMain->quMain->Next();
   }

  //===== Проверка на добавление нового периода
  if (d->newperiod == BAD_STR)
  { //===== Проверка на уже выбранный период
    if (d->period == BAD_STR)
    { //===== Если НЕТ - выбор первого периода в списке
      PeriodCB->ItemIndex = PeriodCB->Items->Count > 0 ? 0 : -1;
    }
    else
    { //===== Если ДА - проверка на наличие такого же
      int tmpI  = PeriodCB->Items->IndexOf(d->period);
      if (tmpI == -1)
      { //===== Если НЕТ - выбор первого периода в списке
        PeriodCB->ItemIndex = PeriodCB->Items->Count > 0 ? 0 : -1;
      }
      else
      { //===== Если есть - выбираем его и выходим
        PeriodCB->ItemIndex = tmpI;
      }
    }
  }
  else
  { //===== Есть новый период
    int tmpI  = PeriodCB->Items->IndexOf(d->newperiod);
    if (tmpI == -1)
    { //===== Если ненашли в списке - выбор первого периода в списке
      PeriodCB->ItemIndex = PeriodCB->Items->Count > 0 ? 0 : -1;
    }
    else
    { //===== Если нашли - выбираем его и выходим
      PeriodCB->ItemIndex = tmpI;
    }
  }
  if(PeriodCB->ItemIndex>-1)
    PeriodDTP->Date = TDateTime(PeriodCB->Items->Strings[PeriodCB->ItemIndex].SubString(1, 4).ToInt(),
                                PeriodCB->Items->Strings[PeriodCB->ItemIndex].SubString(5, 2).ToInt(),
                                PeriodCB->Items->Strings[PeriodCB->ItemIndex].SubString(7, 2).ToInt());

  PeriodCBChange(PeriodCB);
}
//---------------------------------------------------------------------------
void __fastcall TViewShemForm::LoadSubPeriodList()
{
   //GRB ADD 16.04.2020 - test trouble ODAC
   dmMain->quMain->Params->Clear();
   //END ADD 
  dmMain->quMain->SQL->Text="select cp.cpid cp_cpid, to_char(cp.sdate, 'DD.MM.YYYY HH24:MI') || ' - ' "
                "|| to_char(cp.edate,'DD.MM.YYYY HH24:MI') subperiod "
              "from ryda.calc_periods cp "
              "where cp.period = " + d->period + " "
              "order by cp.sdate, cp.edate";
  SubPeriodCB->Items->Clear();
  d->subperiodID  = BAD_ID;
  dmMain->quMain->Execute();
  while(!dmMain->quMain->Eof){
    SubPeriodCB->Items->AddObject(dmMain->quMain->FieldByName("subperiod")->AsString, (TObject *)(dmMain->quMain->FieldByName("cp_cpid")->AsInteger));
    dmMain->quMain->Next();
  }
  //===== Выбор предыдущего Подпериода, если таковой был перед эжтим
  if (d->subperiodStr == BAD_STR){ //===== Выбор первого ПодПериода в списке
    SubPeriodCB->ItemIndex  = SubPeriodCB->Items->Count > 0 ? 0 : -1;
  }else{
    SubPeriodCB->ItemIndex  = SubPeriodCB->Items->IndexOf(d->subperiodStr);
    if(SubPeriodCB->ItemIndex < 0)
      SubPeriodCB->ItemIndex  = 0;
  }
}
//---------------------------------------------------------------------------
/*! Обновление данных на форме
*/
void __fastcall TViewShemForm::vRefresh(TObject *Sender)
{
  switch (type)
  { case vsCommutation:
      ShemEdit->LoadShem(NULL);
      break;
    case vsLoss:
      RefreshActionExecute(RefreshSBtn);
      break;
  }
}
//---------------------------------------------------------------------------
/*! Сохранение данных
*/
void __fastcall TViewShemForm::vSave(TObject *Sender)
{
  try
  { switch (type)
    { case vsCommutation:
        ShemEdit->SaveCommut();
        break;
      case vsLoss:
      default:
        break;
    }
    EditRec = false;
  }
  catch (Exception &e)
  { Application->MessageBox(e.Message.c_str(),
                            Application->Title.c_str(), MB_OK | MB_ICONERROR);
  }
}
//---------------------------------------------------------------------------
void __fastcall TViewShemForm::FormDestroy(TObject *Sender)
{
  switch (type)
  { case vsCommutation:
      ShemEdit->Disconnect();
      break;
    case vsLoss:
      break;
    default:
      break;
  }
  if (d)
    delete  d;
  d = NULL;
  if (InfoForm)
  { delete  InfoForm;
  }
  InfoForm  = NULL;
}
//---------------------------------------------------------------------------
/*! Печать схемы
*/
void __fastcall TViewShemForm::PrintActionExecute(TObject *Sender)
{
  ShemEdit->PrintShem();
}
//---------------------------------------------------------------------------
/*! Обновление
*/
void __fastcall TViewShemForm::RefreshActionExecute(TObject *Sender)
{
  d->refresh  = true;
  try
  { LoadShemList();
    LoadShem();
    LoadPeriodList();
    LoadLoss();
  }
  __finally
  { d->refresh  = false;
  }
}
//---------------------------------------------------------------------------
/*! Растянуть по масштабу
*/
void __fastcall TViewShemForm::FitActionExecute(TObject *Sender)
{
  ShemEdit->FitToWindow();
  int iIndex  = ScaleCB->Items->IndexOf(ShemEdit->Scale);
  if (iIndex > -1)
    ScaleCB->ItemIndex  = iIndex;
}
//---------------------------------------------------------------------------
/*! Полная информация по выбранному периоду
*/
void __fastcall TViewShemForm::InfoActionExecute(TObject *Sender)
{
  if (d->shemID == BAD_ID || d->period == BAD_STR)
    return;

  if (!InfoForm)
    InfoForm  = new TInfoForm(this);

  //===== Заполнение таблицы
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="begin ryda.loss_replacement_pg.rep(" + d->shemStr + ", " + d->period + "); end;";
  dmMain->quMain->Execute();
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text="select cp.line cp_line "
              "from ryda.calc_protocol cp "
              "where cp.sid = " + d->shemStr + " "
                "and cp.period = " + d->period + " "
              "order by cp.ord";
  InfoForm->InfoREdit->Lines->Clear();
  dmMain->quMain->Execute();
  while(!dmMain->quMain->Eof){
    InfoForm->InfoREdit->Lines->Add(dmMain->quMain->FieldByName("cp_line")->AsString);
    dmMain->quMain->Next();
  }
  InfoForm->InfoREdit->SelStart   = 0;
  InfoForm->InfoREdit->SelLength  = 0;
  InfoForm->Show();
}
//---------------------------------------------------------------------------
/*! Добавление нового периода
*/
void __fastcall TViewShemForm::InsertActionExecute(TObject *Sender)
{
  PeriodForm  = new TPeriodForm(this);
  try
  { if (PeriodForm->ShowModal() != mrOk)
      return;

    AnsiString  tPeriod = PeriodForm->MonthCalendar->Date.FormatString("yyyymmdd");
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="begin ryda.loss_replacement_pg.run(" + tPeriod + "); end;";
    dmMain->quMain->Execute();

    d->newperiod  = tPeriod;
    try
    { RefreshActionExecute(RefreshSBtn);
    }
    __finally
    { d->newperiod  = BAD_STR;
    }
  }
  __finally
  { delete  PeriodForm;
    PeriodForm  = NULL;
  }
}
//---------------------------------------------------------------------------
/*! Производится расчет потерь за текущий период
*/
void __fastcall TViewShemForm::CalcActionExecute(TObject *Sender)
{
  try{
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="begin ryda.loss_replacement_pg.run(" + d->period + "); commit; end;";
    dmMain->quMain->Execute();
  }catch (Exception &e){
    dmMain->quMain->Session->Rollback();
  }
  RefreshActionExecute(RefreshSBtn);
}
//---------------------------------------------------------------------------
/*! Масштабирование схемы
*/
void __fastcall TViewShemForm::ScaleCBChange(TObject *Sender)
{
  ShemEdit->Scale = ScaleCB->Items->Strings[ScaleCB->ItemIndex].ToInt();
}
//---------------------------------------------------------------------------
/*! Обработка изменения выбранной схемы
*/
void __fastcall TViewShemForm::ShemCBChange(TObject *Sender)
{
  //===== Если не выбран элемент - ВЫЛЕТАЕМ
  if (ShemCB->ItemIndex < 0)
    return;
  //===== Проверка на выбор тогоже самого элемента
  if ((long)ShemCB->Items->Objects[ShemCB->ItemIndex] == d->shemID)
    return;

  d->shemID   = (long)ShemCB->Items->Objects[ShemCB->ItemIndex];
  d->shemStr  = IntToStr(d->shemID);

  LoadShem();
  LoadCommutation();
  LoadLoss();
}
//---------------------------------------------------------------------------
/*! Обработка изменения выбранного периода
    Вызывается при изменении
*/
void __fastcall TViewShemForm::PeriodCBChange(TObject *Sender)
{
  //===== Если изменения идут через TTdateTimePicker
  //===== (Включен суточный расчет)
  if (d&&!d->period.IsEmpty()&&(dynamic_cast<TDateTimePicker *>(Sender)))
  { int tInt  = PeriodCB->Items->IndexOf(PeriodDTP->Date.FormatString("yyyymmdd"));
    if (tInt < 0)
    { PeriodDTP->Date = TDateTime(d->period.SubString(1, 4).ToInt(),
                                  d->period.SubString(5, 2).ToInt(),
                                  d->period.SubString(7, 2).ToInt());
      return;
    }
    else
      PeriodCB->ItemIndex = tInt;
  }
  //===== Если не выбран элемент - ВЫЛЕТАЕМ
  if (PeriodCB->ItemIndex < 0)
    return;
  //===== Проверка на выбор тогоже самого элемента
  if (PeriodCB->Items->Strings[PeriodCB->ItemIndex] == d->period && !d->refresh)
    return;

  d->period = PeriodCB->Items->Strings[PeriodCB->ItemIndex];
  LoadSubPeriodList();

  SubPeriodCBChange(SubPeriodCB);
}
//---------------------------------------------------------------------------
/*! Обработка изменения выбранного ПодПериода
    Вызывается при изменении
*/
void __fastcall TViewShemForm::SubPeriodCBChange(TObject *Sender)
{
  //===== Если не выбран элемент - ВЫЛЕТАЕМ
  if (SubPeriodCB->ItemIndex < 0)
    return;
  //===== Проверка на выбор тогоже самого элемента
  if ((long)SubPeriodCB->Items->Objects[SubPeriodCB->ItemIndex] == d->subperiodID)
    return;

  d->subperiodID  = (long)SubPeriodCB->Items->Objects[SubPeriodCB->ItemIndex];
  d->subperiodStr = SubPeriodCB->Items->Strings[SubPeriodCB->ItemIndex];

  LoadCommutation();
  LoadLoss();
}
//---------------------------------------------------------------------------
/*! Выбор типа отображаемой информации
*/
void __fastcall TViewShemForm::DataTypeCBChange(TObject *Sender)
{
  //===== Если не выбран элемент - ВЫЛЕТАЕМ
  if (DataTypeCB->ItemIndex < 0)
    return;
  //===== Проверка на выбор тогоже самого элемента
  if (DataTypeCB->ItemIndex == d->datatype)
    return;

  d->datatype = DataTypeCB->ItemIndex;

  LoadLoss();
}
//---------------------------------------------------------------------------

void __fastcall TViewShemForm::ShemEditChangeCommut(TObject *Sender,
      int *change)
{
  EditRec = *change;
}
//---------------------------------------------------------------------------

