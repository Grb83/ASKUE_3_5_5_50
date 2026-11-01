#include <vcl.h>
#include <stdio.h>
#include <ArrowCha.hpp>
#include <math.hpp>
#pragma hdrstop
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#include "InteriorDU2ChartGRB.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "Reconst.hpp"

#define NA      0           // смещение Мощности А
#define NR      1           // смещение Мощности D
#define anF     2           // смещение фи
#define COSF    3           // смещение косинуса фи
#define UA      4           // смещение напряжения А
#define UB      5           // смещение напряжения D
#define UC      6           // смещение напряжения C
#define anUA    7           // смещение угла напряжения А
#define anUB    8           // смещение угла напряжения B
#define anUC    9           // смещение угла напряжения C
#define IA      10          // смещение тока А
#define IB      11          // смещение тока B
#define IC      12          // смещение тока C
#define anIA    13          // смещение угла тока А
#define anIB    14          // смещение угла тока B
#define anIC    15          // смещение угла тока C
#define zU1U2    16
#define zU1U3    17
#define zU2U3    18
#define zU1I1    19
#define zU2I2    20
#define zU3I3    21
#define FR       22          // смещение частоты
#define OBSOLETE 23          // смещение достоверности
int y;
const double INCREASE_SCALE_VALUE = 6;
double  dNA, dNR, dFR, dCOSF, dUA, dUB, dUC, dAnUA,
          dAnUB, dAnUC, dIA, dIB, dIC, dAnIA, dAnIB, dAnIC;

//---------------------------------------------------------------------------
//Текущие значения и параметры качества электроэнергии (КСС)
__fastcall TDU2ChartInteriorGRB::TDU2ChartInteriorGRB(TComponent* Owner,TSplitterForm *aSP,TFormDescr *aFD,Classes::TNotifyEvent OnProgr)
    :T1Interior(Owner,aSP,aFD,OnProgr)
{
  fd->SummGroup = false;
  TBaseMonitorForm  *tBMForm  = dynamic_cast<TBaseMonitorForm *>(Owner);
  if (!tBMForm)
    return;
  tBMForm->ChartFXLines->OnClick      = NULL;
  tBMForm->ChartFXColumns->OnClick    = NULL;
  tBMForm->ByGroup->OnClick           = NULL;
  tBMForm->ByProfile->OnClick         = NULL;
  tBMForm->IsValid->OnClick           = NULL;
  tBMForm->PopupMenuBaseForm->OnPopup =OnPopupClick;
  ((TBaseMonitorForm*)Owner)->ChartFXLines->OnClick=NULL;
  ((TBaseMonitorForm*)Owner)->ChartFXColumns->OnClick=NULL;
  ((TBaseMonitorForm*)Owner)->ByGroup->OnClick=NULL;
  ((TBaseMonitorForm*)Owner)->ByProfile->OnClick=NULL;

  ((TBaseMonitorForm*)Owner)->IsValid->OnClick=NULL;
  ((TBaseMonitorForm*)Owner)->IsValid->Enabled = false;
  ((TBaseMonitorForm*)Owner)->IsValid->Visible = false;
  tBMForm->IsValid->Enabled = false;
  tBMForm->IsValid->Visible = false;
  TMenuItem* mi;
  TPopupMenu* tpm;
  for (int i = 0; i <tBMForm->ComponentCount; i++ ){
        mi=dynamic_cast<TMenuItem *>(tBMForm->Components[i]);
        if(mi){
            mi->Enabled = false;
            mi->Visible = false;
        }
  }
  TRegistry *Reg = new TRegistry(KEY_READ);
  try{
        Reg->RootKey =HKEY_LOCAL_MACHINE;
        Reg->Access=KEY_READ;
        Reg->OpenKey("SOFTWARE\\INTEP\\ASKUE", False);
        Language = Reg->ReadString("Language");
        if(!Language.Length()){
                char c[256];
                GetLocaleInfo(GetSystemDefaultLCID(), LOCALE_SABBREVLANGNAME, c, sizeof(c));
                Language=c;
        }
  }__finally{
                delete Reg;
  }
  currentRow = 1;
  tBMForm->OnResize = FormShow;

}
//---------------------------------------------------------------------------

__fastcall TDU2ChartInteriorGRB::~TDU2ChartInteriorGRB(void)
{
	if (pChart1)
    delete  pChart1;
  pChart1 = NULL;
	if (vtDU2Data)
    delete  vtDU2Data;
  vtDU2Data = NULL;
  if (pChartGRB1)
    delete  pChartGRB1;
  pChartGRB1 = NULL;
  if (StringGrid1)
    delete StringGrid1;
  StringGrid1=NULL;
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::formDescr( void )
{
  vtDU2Data = new TVirtualTable(this);
  char  datest[20],
        dateen[20];
  //Заполняем необходимые поля описания формы
	Clones  = 0;

  unsigned short  year,
                  month,
                  day;
  fd->DateTime.DecodeDate(&year,&month,&day);
  switch (fd->StepProfile){
    case TFormDescr::stpDay:
      strcpy(datest, TDateTime(year, month, 1).FormatString("dd.mm.yyyy hh:nn").c_str());
      strcpy(dateen, (TDateTime(year, month, 1) + 31).FormatString("dd.mm.yyyy hh:nn").c_str());
      break;
    case TFormDescr::stpHour:
      strcpy(datest, TDateTime(year, month, day).FormatString("dd.mm.yyyy hh:nn").c_str());
      strcpy(dateen, (TDateTime(year, month, day) + 1).FormatString("dd.mm.yyyy hh:nn").c_str());
      break;
    case TFormDescr::stpMonth:
      strcpy(datest, TDateTime(year, 1, 1).FormatString("dd.mm.yyyy hh:nn").c_str());
      strcpy(dateen, TDateTime(year + 1, 1, 1).FormatString("dd.mm.yyyy hh:nn").c_str());
      break;
    case TFormDescr::stpMinute:
    default:
      throw Exception(Reconst_smes111_1);
  }

	NamesClones->Clear();
  NamesClones->Add("01.01.0001 00:00");
  // названия строк таблицы получаем теперь здесь
  dmMain->oqInterCursor->Params->Clear();
  dmMain->oqInterCursor->SQL->Text="begin "+SchemeName+"interior_pg.InteriorDU2Chart_selectData_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8); end;";
  dmMain->oqInterCursor->ParamByName("par8")->ParamType=ptOutput;
  dmMain->oqInterCursor->ParamByName("par8")->DataType=ftCursor;

  dmMain->oqInterCursor->ParamByName("par1")->AsInteger=(fd->IsPoints)?1:0;
  dmMain->oqInterCursor->ParamByName("par2")->AsInteger=fd->StepProfile;
  dmMain->oqInterCursor->ParamByName("par3")->AsInteger=fd->IdGroup;
  dmMain->oqInterCursor->ParamByName("par4")->AsString=fd->DateTime.FormatString("dd.mm.yyyy hh:nn");
  dmMain->oqInterCursor->ParamByName("par5")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
  dmMain->oqInterCursor->ParamByName("par6")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
  dmMain->oqInterCursor->ParamByName("par7")->AsInteger=fd->GetPeriod(fd->DateTime);
  dmMain->oqInterCursor->Execute();
  while(!dmMain->oqInterCursor->Eof){
    fd->strGroup(dmMain->oqInterCursor->FieldByName("dattime")->AsString.c_str());
    NamesClones->Add(dmMain->oqInterCursor->FieldByName("dattime")->AsString);
    dmMain->oqInterCursor->Next();
    Clones++;
    if (Clones == 1){
        activ_data.obsolete = dmMain->oqInterCursor->FieldByName("obsolete")->AsInteger;
    }
  }
  vtDU2Data->Assign(dmMain->oqInterCursor);
  vtDU2Data->Active = true;
  dmMain->oqInterCursor->Close();
	if (!Clones)
    Application->ShowException(&Exception(Reconst_smes111_2));
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::selectData( TOraQuery *qwInter )
{
  int iClones,
      state,
      i;
	TCloneItem  *ptr,
              *pDatOracle;
  double  dat[27];
  long  cur_date, abs;
	short ind[26];
	unsigned long rowSelect;
  char  date[20];

	try
  { //Инициализация массива
    unsigned long clones  = Clones + 1;
    for (int i = 0; i < SubColumns() * (Clones + 1) * (RowCount + 1); i++){
      datOracle[i].val  = -MAXFLOAT;
      datOracle[i].isvalid[0] = '\0';
    }
    // KAS Текущую дату на название формы
    dynamic_cast<TBaseMonitorForm *>(Owner)->Caption  = fd->NameGroup + " на " + GetCurrentDate(qwInter);
   for (iClones = 1; iClones <= Clones; ++iClones)
	  { strcpy(date, NamesClones->Strings[iClones].c_str());

      for (int i = 0; i < sizeof(dat) / sizeof(dat[0]); i++)
        dat[i] = -MAXFLOAT;
      if(!vtDU2Data->FieldByName("na")->IsNull) {
        dat[0]=vtDU2Data->FieldByName("na")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("nr")->IsNull){
        dat[1]=vtDU2Data->FieldByName("nr")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("an")->IsNull){
        dat[2]=vtDU2Data->FieldByName("an")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("cosf")->IsNull){
        dat[3]=vtDU2Data->FieldByName("cosf")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("ua")->IsNull){
        dat[4]=vtDU2Data->FieldByName("ua")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("ub")->IsNull){
        dat[5]=vtDU2Data->FieldByName("ub")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("uc")->IsNull){
        dat[6]=vtDU2Data->FieldByName("uc")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("an_ua")->IsNull){
        dat[7]=vtDU2Data->FieldByName("an_ua")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("an_ub")->IsNull){
        dat[8]=vtDU2Data->FieldByName("an_ub")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("an_uc")->IsNull){
        dat[9]=vtDU2Data->FieldByName("an_uc")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("ia")->IsNull){
        dat[10]=vtDU2Data->FieldByName("ia")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("ib")->IsNull){
        dat[11]=vtDU2Data->FieldByName("ib")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("ic")->IsNull){
        dat[12]=vtDU2Data->FieldByName("ic")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("an_ia")->IsNull){
        dat[13]=vtDU2Data->FieldByName("an_ia")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("an_ib")->IsNull){
        dat[14]=vtDU2Data->FieldByName("an_ib")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("an_ic")->IsNull){
        dat[15]=vtDU2Data->FieldByName("an_ic")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("U1U2")->IsNull){
        dat[16]=vtDU2Data->FieldByName("U1U2")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("U1U3")->IsNull){
        dat[17]=vtDU2Data->FieldByName("U1U3")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("U2U3")->IsNull){
        dat[18]=vtDU2Data->FieldByName("U2U3")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("U1I1")->IsNull){
        dat[19]=vtDU2Data->FieldByName("U1I1")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("U2I2")->IsNull){
        dat[20]=vtDU2Data->FieldByName("U2I2")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("U3I3")->IsNull){
        dat[21]=vtDU2Data->FieldByName("U3I3")->AsFloat;
      }
      if(!vtDU2Data->FieldByName("freq")->IsNull){
        dat[22]=vtDU2Data->FieldByName("freq")->AsFloat;
      }
      /*dat[23] = 1;
      if(!vtDU2Data->FieldByName("obsolete")->IsNull){
       dat[23] = vtDU2Data->FieldByName("obsolete")->AsInteger;
       int i = 0;
       if (dat[23]==1){
       i++;
       }
       dat[23] = vtDU2Data->FieldByName("obsolete")->AsInteger;
      } */
      
      if (Clones / 8 == 0 || iClones % (Clones / 8) == 0)
        OnProgressBarStepBy(this);
      for (i = 1; i <= RowCount; i++)
      { ptr = datOracle + iClones + i * clones;
        ptr->val      = dat[i - 1];
      }
      vtDU2Data->Next();
    }
  }
	catch(Exception &e)
	{
  }
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::clonesInRows(void)
{
  long  clones  = Clones;
  long  columns = SubColumns();
  int iClones,
      jColumns,
      i;
  double  stepProfile;

	DrawTable->ColCount   = RowCount + 1 + (columns > 1 ? 1 : 0);
	DrawTable->RowCount   = 2 + clones * columns;
	DrawTable->FixedCols  = 1 + (columns > 1 ? 1 : 0);
  if (DrawTable->RowCount == 2)
    DrawTable->RowCount++;
  DrawTable->FixedRows  = 2;

  //Подготавливаем переменные поля для приема
	int *TempStruct = new int[RowCount];
	for (iClones = 0; iClones < RowCount; iClones++)
    TempStruct[iClones] = LenFloat;
DrawTable->TabStrings->Add("$ m0x0 0x100F c15 b #$ m0x9 0x100B #< m0x9 0x100A #<#< m0x9 0x100E #$ m0x0009 0x100B # < m0x9 0x100A #< m0x9 0x100E #$ m0x0009 0x100B # < m0x9 0x100A #< m0x9 0x100E #$ m0x0009 0x100B # < m0x9 0x100A #< m0x9 0x100E #$ m0x0009 0x100B # < m0x9 0x100A #< m0x9 0x100E #$ m0x0009 0x100B # < m0x9 0x100A #< m0x9 0x100E #$ m0x0009 0x100B # < m0x9 0x100A #< m0x9 0x100E#$ m0x9 0x100F");
DrawTable->TabStrings->Add("$ m0x9 0x100F c15 b #$ m0x5 0x100F #$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$");
	DrawTable->TabStrings->Add("$ m0x5 0x100F c15 b- A0x8000 #& m 0x1 0x900C c5 A0x8025 #&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&");
  DrawTable->StructStrings->Rebuild(clones * columns, RowCount, TempStruct);
	dataInRows();
	delete  TempStruct;

	//Добавляем нумерацию профиля
	TDateTime tempDate;
	AnsiString  formatDate;
	AnsiString  formatDateSum;
	unsigned short  year,
                  month,
                  day,
                  hour,
                  min,
                  sec,
                  msec;

  DrawTable->StaticStrings->Clear();
  DrawTable->StaticStrings->Add(fd->NameGroup);
  DrawTable->StaticStrings->Add(Reconst_smes111_4);
  DrawTable->StaticStrings->Add(Reconst_smes111_5);
  DrawTable->StaticStrings->Add(Reconst_smes111_6);
  DrawTable->StaticStrings->Add(Reconst_smes111_7);
  DrawTable->StaticStrings->Add(Reconst_smes111_8);
  DrawTable->StaticStrings->Add(Reconst_smes111_9);
  DrawTable->StaticStrings->Add(Reconst_smes111_10);
  DrawTable->StaticStrings->Add(Reconst_smes111_11);
  DrawTable->StaticStrings->Add(Reconst_smes111_12);
	for (jColumns = 1; jColumns <= RowCount; jColumns++)
	{
   DrawTable->StaticStrings->Add(GetSubColumnsNames(jColumns));
   ColumnsCaption->Add(GetSubColumnsNames(jColumns));
  }
	//Добавляем заголовки клонов
  VT_PrintData->First();
	for (iClones = 0; iClones < Clones ; ++iClones)
	{ DrawTable->StaticStrings->Add(NamesClones->Strings[iClones + 1]);
    //Добавляем заголовки колонок под клонами
    VT_PrintData->Edit();
    VT_PrintData->Fields->FieldByName("RowName")->AsString  = NamesClones->Strings[iClones + 1];
    VT_PrintData->Next();
  }
  DrawTable->UpdateTabStrings();
}
//---------------------------------------------------------------------------

//inline char** __fastcall TDU2ChartInterior::GetSubColumnsNames(void)
inline AnsiString __fastcall TDU2ChartInteriorGRB::GetSubColumnsNames(int n)
{
  AnsiString  names[]  = {"", "P A [МВт]", "P Q [МВАр]", Reconst_smes111_13, "сos(Ф)",
                      "Uа [В]", "Ub [В]", "Uc [В]",
                      Reconst_smes111_14, Reconst_smes111_15, Reconst_smes111_16,
                      "Ia [А]", "Ib [А]", "Ic [А]",
                      Reconst_smes111_17, Reconst_smes111_18, Reconst_smes111_19,
                      Reconst_smes111_20, Reconst_smes111_21, Reconst_smes111_22,
                      Reconst_smes111_23, Reconst_smes111_24, Reconst_smes111_25,
                      "F [Гц]"};
  return  names[n];
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::dataInRows(void)
{
	long  clones  = Clones + 1;
	int iClones,
      jColumns;
	char  *ptr,
        tmpData[20];
	TCloneItem  *ptrDatOracle,
              *ptrDataOra;

  //столбцы для названий точек(времени) и и подколонок
  ColumnsCaption->Clear();
  VT_PrintData->Close();
  VT_PrintData->Clear();
  VT_PrintData->FieldDefs->Clear();
  VT_PrintData->FieldDefs->Add("RowName", ftString, 50, false);
  for (int CC = 0; CC < RowCount; CC++)
    VT_PrintData->FieldDefs->Add("Data" + IntToStr(CC), ftString, 20, false);
  VT_PrintData->Open();
  //Подготавливаем переменные поля для приема
  ptr = DrawTable->StructStrings->GetArray();
  for (jColumns = 1; jColumns <= Clones; jColumns++){
    VT_PrintData->Append();
    for (iClones = 1; iClones <= RowCount; iClones++){
      ptrDatOracle  = datOracle + jColumns + iClones * clones;
      if (ptrDatOracle->val != -MAXFLOAT)
        sprintf(ptr, "%-.19s\x0", FormatFloat(MyFloatFormat, ptrDatOracle->val).c_str());
      else
        *ptr  = 0;
      VT_PrintData->Fields->FieldByName("Data"+IntToStr(iClones-1))->AsString = AnsiString(ptr); //saa
      ptr += LenFloat;
    }
  }
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::Place()
{
  //GRB - 26.11.2020 Место под отрисовку нового pChartGRB1, StringGrid1
    try
    {
    pChartGRB1  = NULL;
    pChartGRB1  = new TChart(Owner);
    pChartGRB1->OnMouseDown               = NULL;
    pChartGRB1->OnMouseMove               = NULL;
    pChartGRB1->Enabled                   = true;
    //Проводим начальную настройку компонента TChart 1
    pChartGRB1->View3D                   = false;
    pChartGRB1->Legend->Visible          = false;
    pChartGRB1->Legend->ColorWidth       = 35;
    pChartGRB1->MarginBottom = 4;
    pChartGRB1->MarginTop = 4;
    pChartGRB1->MarginRight = 3;
    pChartGRB1->MarginBottom = 3;

    pChartGRB1->OnBeforeDrawSeries = pChart1BeforeDraw;
    AnsiString date_data = fd->DateTime.FormatString("dd.mm.yyyy hh:nn");
    if (objName == NULL)
        objName = getObjectName(1);
    AnsiString caption1 = "";
    if (Language == "UKR"){
    caption1 = "Векторна діаграма якості електроенергії, дані по об'єкту: '"+ fd->NameGroup +"' за дату "+objName +" з профілем ";
    switch (fd->StepProfile){
    case TFormDescr::stpDay:
      caption1+=" за місяц.";
      break;
    case TFormDescr::stpHour:
      caption1+=" за добу.";
      break;
    case TFormDescr::stpMonth:
      caption1+=" за рік.";
      break;
    }
    }else {
    caption1 = "Векторная диаграмма качества электроэнергии, данные по объекту: '"+ fd->NameGroup +"' за дату "+objName +" с профилем ";

      switch (fd->StepProfile){
    case TFormDescr::stpDay:
      caption1+=" за месяц.";
      break;
    case TFormDescr::stpHour:
      caption1+=" за сутки.";
      break;
    case TFormDescr::stpMonth:
      caption1+=" за год.";
      break;
      }
  }

    pChartGRB1->Title->Text->Add(caption1);
    
    pChartGRB1->Width = 512;
    pChartGRB1->Height = 506;
    pChartGRB1->Parent                   = dynamic_cast<TWinControl *>(Owner);
    pChartGRB1->Show();
    StringGrid1 = NULL;
    StringGrid1 = new TStringGrid (Owner);
    StringGrid1->ColCount = 3;
    StringGrid1->RowCount = 29;
    StringGrid1->ColWidths[0] = 15;

    StringGrid1->Width = 120;
    StringGrid1->OnDrawCell = StringGrid1DrawCell;
    StringGrid1->Options << goRowSizing;
    StringGrid1->Options << goColSizing;
    StringGrid1->Options >> goDrawFocusSelected;
    }
    catch(Exception &e)
  { SplitterForm->RemoveChild(DrawTable);
		SplitterForm->RemoveChild(pChart1);
		SplitterForm->RemoveChild(pChart);
		if (DrawTable)
			delete  DrawTable;
		if (pChart1)
			delete  pChart1;
		if (pChart)
			delete  pChart;
		pChart    = NULL;
    pChart1   = NULL;
		DrawTable = NULL;
                pChartGRB1  = NULL;
    OnProgressBarStepBy(NULL);
		throw(Exception(Reconst_smes111_26));
  }
  OnProgressBarStepBy(NULL);
  //END GRB - Конец

  TFormSetupMonitors*psm;
  try
  { psm = new TFormSetupMonitors(Application);
    //Создаем график 1
    //Создаем таблицу
    //Укладываем таблицу и графики в SplitterForm
    DrawTable = new TDrawTable(Owner);
    DrawTable->OnDrawCell = DrawTableDrawCell;
    DrawTable->Options << goRowSizing;
    DrawTable->Options << goColSizing;
    SplitterForm->AddChild(NULL, pChartGRB1, alRight);
    SplitterForm->AddChild(NULL, StringGrid1, alLeft);
    SplitterForm->AddChild(StringGrid1
    ,DrawTable,  alLeft);

    SplitterForm->Splitter->OnClick = OnClickPanel;
    SplitterForm->Splitter->Tag     = fd->PercentSplit;
    SplitterForm->SplitFormResize(NULL);
    // Форматирование таблицы
    DrawTable->OnEnter        = OnClickPanel;
    DrawTable->OnMouseDown    = DrawTableMouseDown;
    DrawTable->OnMouseMove    = DrawTableMouseMove;
    DrawTable->OnMouseUp      = DrawTableMouseUp;
    DrawTable->Options >> goRangeSelect >> goFixedVertLine >> goFixedHorzLine >> goVertLine >> goHorzLine;
    DrawTable->DefaultDrawing = false;

    if (dynamic_cast<TBaseMonitorForm *>(Owner)->isSmallFont)
      DrawTable->RowsHeight = AnsiString("#") + psm->EditColorHeight->Text;
    else
      DrawTable->RowsHeight = AnsiString("#") + psm->EditBWHeight->Text;
      OnProgressBarStepBy(this);//40
      if (fd->VerticalSplit)
		{ if (dynamic_cast<TBaseMonitorForm *>(Owner)->isSmallFont)
        DrawTable->ColsWidth  = AnsiString("#") + psm->EditColorWidthDigit->Text;
			else
				DrawTable->ColsWidth  = AnsiString("#") + psm->EditBWWidthDigit->Text;
			clonesInColumns();
      }
      else
		{ if (dynamic_cast<TBaseMonitorForm *>(Owner)->isSmallFont)
        DrawTable->ColsWidth  = AnsiString("#") + psm->EditColorWidthName->Text +
					                        AnsiString("#") + psm->EditColorWidthDigit->Text;
			else
        DrawTable->ColsWidth  = AnsiString("#") + psm->EditBWWidthName->Text +
					                        AnsiString("#") + psm->EditBWWidthDigit->Text;
			clonesInRows();
                }
    // Строим график по умолчанию
    ChartFXColumns(1);
    OnProgressBarStepBy(this);//80
    if (fd->IsMemParActualForClones)
    { //Восстановление состояния скроллинга
      if (DrawTable)
        DrawTable->TopRow = fd->TableTopRow;
      //e Восстановление состояния скроллинга
      fd->IsMemParActualForClones = FALSE;
    }
    if (fd->IsMemParActualForProf)
    { //Восстановление состояния скроллинга
      if (DrawTable)
        DrawTable->LeftCol  = fd->TableLeftCol;
      //e Восстановление состояния скроллинга
      fd->IsMemParActualForProf = FALSE;
    }
    //26.08.2021 GRB ADD
    if (GetContainedWidthStatusFromReg())
        AutoSizeNameOnly (DrawTable);
    //end ADD
  }
  catch(Exception &e)
  { SplitterForm->RemoveChild(DrawTable);
		SplitterForm->RemoveChild(pChart1);
		SplitterForm->RemoveChild(pChart);
                //22.12.2020 0 GRB ADD - ремувим и тут
                SplitterForm->RemoveChild (pChartGRB1);
                SplitterForm->RemoveChild (StringGrid1);
                //22.12.2020 end ADD

		if (DrawTable)
			delete  DrawTable;
		if (pChart1)
			delete  pChart1;
		if (pChart)
			delete  pChart;
                //22.12.2020 - GRB ADD - надо корректно удалять своё
                if (pChartGRB1)
			delete  pChartGRB1;
                if (StringGrid1)
                        delete StringGrid1;
                pChartGRB1 = NULL;
                StringGrid1 = NULL;
                //end ADD
		pChart    = NULL;
                pChart1   = NULL;
		DrawTable = NULL;
    delete  psm;
    OnProgressBarStepBy(NULL);
		throw(Exception(Reconst_smes111_26));
  }
  delete  psm;
  OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::clickGraphics(long ColPressed, long RowPressed)
{
	if (ColPressed == 1)//разложение по группам
	{
        return;
	}
	if (RowPressed == 0)//построение профиля
	{
        ChartFXColumns(ColPressed - 1);
	}
}
//---------------------------------------------------------------------------

bool __fastcall TDU2ChartInteriorGRB::setSplit(void)
{
  Application->MessageBox(Reconst_smes111_27.c_str(),
                            Application->Title.c_str(), MB_OK | MB_ICONINFORMATION);
  return  true;
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::ChartFXLines(long AClone)
{
  TCloneItem  *ptrDatOracle;
  double  temp;
  TLineSeries *pLine;
  int CurClone;

  fPlace  = false;
  pChart->AxisVisible                 = true;
  pChart->Legend->Visible             = false;
  pChart->AllowZoom                   = true;
  pChart->AllowPanning                = pmBoth;
  pChart->ClipPoints                  = true;
  pChart->AllowPanning                = pmBoth;
  pChart->OnMouseDown                 = NULL;
  pChart->OnMouseMove                 = NULL;
  pChart->AllowZoom                   = true;
  pChart->BottomAxis->PositionPercent = 0;
  pChart->LeftAxis->PositionPercent   = 0;
  if (pChart1->Parent != NULL)
    SplitterForm->RemoveChild(pChart1);

  while (pChart->SeriesCount() > 0)
  { TChartSeries  *cs = pChart->Series[0];
    cs->ParentChart = NULL;
    delete  cs;
  }
  pLine = new TLineSeries(pChart);
  pLine->ParentChart  = pChart;
  pLine->Pointer->Visible         = FormSetupMonitors->cbPoints->Checked;
  pLine->Pointer->Style           = psCircle;
  pLine->Pointer->HorizSize       = 3;
  pLine->Pointer->VertSize        = 3;
  pLine->Marks->Visible           = FormSetupMonitors->cbMarks->Checked;
  pLine->Marks->Clip              = true;
  pLine->XValues->Order           = loNone;
  pLine->YValues->Order           = loDescending;
  pLine->Marks->Style             = smsValue;
  pLine->LinePen->Width           = 2;
  pLine->XValues->DateTime        = true;
  pChart->BottomAxis->LabelStyle  = talAuto;
  pLine->Title              = GetSubColumnsNames(0);
  pChart->Title->Text->Text = AnsiString(Reconst_smes111_28)+
                                 GetSubColumnsNames(AClone) + Reconst_smes111_29 + fd->NameGroup;

  ptrDatOracle  = datOracle + (Clones + 1) * AClone + 1;
  YMaxVal = -MAXFLOAT;
  YMinVal = -MAXFLOAT;
  for (int i = 1; i <= Clones; i++, ptrDatOracle++)
//    for(int i=Clones; i>=1; i--, ptrDatOracle--)
  { if (ptrDatOracle->val <= -MAXFLOAT)
    { pLine->AddNullXY(Clones - i + 1, temp, NamesClones->Strings[i]);
    }
    else
    { temp  = ptrDatOracle->val;
      pLine->AddXY(Clones - i + 1, temp, NamesClones->Strings[i], (TColor)clTeeColor);
      if (YMaxVal == -MAXFLOAT)
      { YMaxVal = temp;
        YMinVal = temp;
      }
      else
      { YMaxVal = max(temp,YMaxVal);
        YMinVal = min(temp,YMinVal);
      }
    }
  }
  IncreaseScaleValue(YMinVal, YMaxVal);
  pChart->LeftAxis->Minimum = -MAXFLOAT;
  pChart->LeftAxis->Maximum = YMaxVal + ((YMaxVal - YMinVal) / 100) * 5;
  pChart->LeftAxis->Minimum = YMinVal - ((YMaxVal - YMinVal) / 100) * 5;
  pChart->LeftAxis->Automatic   = false;
  pChart->BottomAxis->Automatic = true;
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::ChartFXColumns(long ARow)
{
// Удаление серий с графика
  while (pChartGRB1->SeriesCount()>0)
  { TChartSeries  *cs = pChartGRB1->Series[0];
    cs->ParentChart = NULL;
    delete  cs;
  }
  for(int i=0; i<pChartGRB1->SeriesList->Count; i++)
      pChartGRB1->Series[i]->Active = false;
  pChartGRB1->SeriesList->Clear();
  //Вычитка активных данных и отрисовка всего добра
  try{
  objName = getObjectName(ARow);
  }catch (Exception &ex){
   return;
  }
  moveRowToActiveData(ARow);
  currentRow = ARow;
  writeParamsToTable();
  InitValue();
  placeChart();

}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::Destroy(void)
{
	SplitterForm->RemoveChild(pChart1);
	SplitterForm->RemoveChild(pChart);
	SplitterForm->RemoveChild(DrawTable);
        SplitterForm->RemoveChild(pChartGRB1);
        SplitterForm->RemoveChild(StringGrid1);

}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::ChartMouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
  y = Y;
  TChart  *ch = dynamic_cast<TChart *>(Sender);
  if (Shift.Contains(ssRight) && ch)
    ch->UndoZoom();
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::ChartMouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
  TChart  *ch = dynamic_cast<TChart *>(Sender);
  if (!ch || !Shift.Contains(ssLeft))
    return;
  double  d = Y - y;
  if (d != 0)
    ch->ZoomPercent(d / fabs(d) * 10 + 100);
  y = Y;
}
//---------------------------------------------------------------------------

inline int __fastcall TDU2ChartInteriorGRB::GetCountRow(void)
{
  return  23;
}
//---------------------------------------------------------------------------
#pragma package(smart_init)

void __fastcall TDU2ChartInteriorGRB::OnPopupClick(TObject* Sender)
{
  return;
  /*TBaseMonitorForm  *bmf  = dynamic_cast<TBaseMonitorForm *>(Owner);
  if (!bmf)
    return;
  bmf->View->Enabled            = true;
  bmf->ChartFXColumns->Enabled  = false;
  bmf->ChartFXLines->Enabled    = false;
  bmf->ByGroup->Enabled         = false;
  bmf->ByProfile->Enabled       = false;
  bmf->SmallFont->Checked       = !bmf->isSmallFont;
  bmf->SmallFont2->Checked      = !bmf->isSmallFont;*/
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::StringGrid1DrawCell(TObject *Sender, int ACol,
      int ARow, const TRect &Rect, TGridDrawState State)
{
  if (ACol == 0 && ARow!=0 &&ARow < 8 ) //коодинаты ячейки которой нужно изменить цвет
  {
    StringGrid1->Canvas->Brush->Color = clYellow;
    StringGrid1->Canvas->FillRect(Rect);
  }
  if (ACol == 0 && ARow==1 &&ARow < 8 ) //коодинаты ячейки которой нужно изменить цвет
  {
    StringGrid1->Canvas->Brush->Color =  (TColor)RGB(255,215,28);/*clOlive*/;
    StringGrid1->Canvas->FillRect(Rect);
  }
  if (ACol == 0 && ARow==8 ) //коодинаты ячейки которой нужно изменить цвет
  {
    StringGrid1->Canvas->Brush->Color = clLime;
    StringGrid1->Canvas->FillRect(Rect);
  }

  if (ACol == 0 && ARow >8 &&ARow<=14 ) //коодинаты ячейки которой нужно изменить цвет
  {
    StringGrid1->Canvas->Brush->Color = clGreen;
    StringGrid1->Canvas->FillRect(Rect);
  }
    if (ACol == 0 && ARow==15) //коодинаты ячейки которой нужно изменить цвет
  {
    StringGrid1->Canvas->Brush->Color = (TColor)0x8010FF;
    StringGrid1->Canvas->FillRect(Rect);
  }

  if (ACol == 0 && ARow >15 &&ARow<22 ) //коодинаты ячейки которой нужно изменить цвет
  {
    StringGrid1->Canvas->Brush->Color = clRed;
    StringGrid1->Canvas->FillRect(Rect);
  }
  if (ACol == 0 && ARow == 28 ) //коодинаты ячейки которой нужно изменить цвет
  {
    StringGrid1->Canvas->Brush->Color = clBlue;
    StringGrid1->Canvas->FillRect(Rect);
  }
  if (activ_data.obsolete&&(ACol==2)&&(ARow>0)){
  StringGrid1->Canvas->Brush->Color = clMaroon;
  AnsiString   uStr = StringGrid1->Cells[ACol][ARow];
  StringGrid1->Canvas->TextRect( Rect, Rect.left+2, Rect.top+2, uStr);
  StringGrid1->Canvas->FrameRect(Rect);
  }
  //Отключаем (пытаемся) эффект выделения активной ячейки при попытке перерисовки при нажати на строку DrawCell
   if (State.Contains(Grids::gdSelected)){
      if (activ_data.obsolete==0)
      StringGrid1->Canvas->Brush->Color=clWhite;
      else if (ACol==2) {
      StringGrid1->Canvas->Brush->Color=clMaroon;
      }else
      StringGrid1->Canvas->Brush->Color=clWhite;
      StringGrid1->Canvas->Font->Color = clBlack;
      StringGrid1->Canvas->FillRect(Rect);
      StringGrid1->Canvas->TextRect (Rect, Rect.Left + 2, Rect.Top + 2,StringGrid1->Cells[ACol] [ARow]);
   }
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::fAutoSizeColSG(TStringGrid* StringGrid) {

    int iTempColSize = 0; //
    int iMaxColSize = 0; //

    for (int j = 1; j <= StringGrid->ColCount - 1; j++) {
        for (int i = 0; i <= StringGrid->RowCount - 1; i++) {
            iTempColSize = StringGrid->Canvas->TextWidth
                (StringGrid->Cells[j][i]);
            if (iTempColSize > iMaxColSize) {
                iMaxColSize = iTempColSize;
            }
        }

        if (iMaxColSize == 0) {
            StringGrid->ColWidths[j] = 125;
        }
        else {
            StringGrid->ColWidths[j] = iMaxColSize +
                StringGrid->GridLineWidth + 10;
        }

        iTempColSize = 0; //
        iMaxColSize = 0;
    }

}
//---------------------------------------------------------------------------
 void __fastcall TDU2ChartInteriorGRB::writeParamsToTable(){
if (Language == "UKR"){
StringGrid1->Cells [1][0] = "Параметри якості";
StringGrid1->Cells [2][0] = "Значення";

StringGrid1->Cells [1][1] = "Напруга, Ua (В):";
StringGrid1->Cells [1][2] = "Струм, Ia (A):";
StringGrid1->Cells [1][3] =" Кут Ф (гр.):";
StringGrid1->Cells [1][4] =" cos(Ф):";

StringGrid1->Cells [1][5] = "Активна потужність (кВт):";
StringGrid1->Cells [1][6] = "Реактивна потужність (кВар):";
StringGrid1->Cells [1][7] = "Повна потужність (кВА):";

StringGrid1->Cells [1][8] = "Напруга, Ub (В):";
StringGrid1->Cells [1][9] = "Струм, Ib (A):";
StringGrid1->Cells [1][10] =" Кут Ф (гр.):";
StringGrid1->Cells [1][11] =" cos(Ф):";

StringGrid1->Cells [1][12] = "Активна потужність (кВт):";
StringGrid1->Cells [1][13] = "Реактивна потужність (кВар):";
StringGrid1->Cells [1][14] = "Повна потужність (кВА):";

StringGrid1->Cells [1][15] = "Напруга, Uc (C):";
StringGrid1->Cells [1][16] = "Струм, Ic (A):";
StringGrid1->Cells [1][17] =" Кут Ф(гр.):";
StringGrid1->Cells [1][18] =" cos(Ф):";
StringGrid1->Cells [1][19] = "Активна потужність (кВт):";
StringGrid1->Cells [1][20] = "Реактивна потужність (кВар):";
StringGrid1->Cells [1][21] = "Повна потужність (кВА):";

StringGrid1->Cells [1][22] = "Частота F (Гц):";
//StringGrid1->Cells [1][23] = "Сумма по фазам";
StringGrid1->Cells [1][23] = "Активна потужність (кВт):";
StringGrid1->Cells [1][24] = "Реактивна потужність (кВар):";
StringGrid1->Cells [1][25] = "Повна потужність (кВА):";
StringGrid1->Cells [1][26] = "Кут Ф(гр.):";
StringGrid1->Cells [1][27] = "cos(Ф):";
StringGrid1->Cells [1][28] = "Достовірність:";

}
else{
StringGrid1->Cells [1][0] = "Параметры качества";
StringGrid1->Cells [2][0] = "Значения";

StringGrid1->Cells [1][1] = "Напряжение, Ua (В):";
StringGrid1->Cells [1][2] = "Ток, Ia (A):";
StringGrid1->Cells [1][3] =" Угол Ф (гр.):";
StringGrid1->Cells [1][4] =" cos(Ф):";

StringGrid1->Cells [1][5] = "Активная мощность (кВт):";
StringGrid1->Cells [1][6] = "Реактивная мощность (кВар):";
StringGrid1->Cells [1][7] = "Полная мощность (кВА):";

StringGrid1->Cells [1][8] = "Напряжение, Ub (В):";
StringGrid1->Cells [1][9] = "Ток, Ib (A):";
StringGrid1->Cells [1][10] =" Угол Ф (гр.):";
StringGrid1->Cells [1][11] =" cos(Ф):";

StringGrid1->Cells [1][12] = "Активная мощность (кВт):";
StringGrid1->Cells [1][13] = "Реактивная мощность (кВар):";
StringGrid1->Cells [1][14] = "Полная мощность (кВА):";

StringGrid1->Cells [1][15] = "Напряжение, Uc (C):";
StringGrid1->Cells [1][16] = "Ток, Ic (A):";
StringGrid1->Cells [1][17] =" Угол Ф(гр.):";
StringGrid1->Cells [1][18] =" cos(Ф):";
StringGrid1->Cells [1][19] = "Активная мощность (кВт):";
StringGrid1->Cells [1][20] = "Реактивная мощность (кВар):";
StringGrid1->Cells [1][21] = "Полная мощность (кВА):";

StringGrid1->Cells [1][22] = "Частота F (Гц):";
//StringGrid1->Cells [1][23] = "Сумма по фазам";
StringGrid1->Cells [1][23] = "Активная мощность (кВт):";
StringGrid1->Cells [1][24] = "Реактивная мощность (кВар):";
StringGrid1->Cells [1][25] = "Полная мощность (кВА):";
StringGrid1->Cells [1][26] = "Угол Ф(гр.):";
StringGrid1->Cells [1][27] = "cos(Ф):";
StringGrid1->Cells [1][28] = "Достоверность:";
}
double cos1, cos2, cos3; cos1 = cos2 = cos3 = 0;
//Тут и ниже так проверяем на отсутствие данных в измеренных значениях >=0 (-3.4e38), а X!=X проверка на NAN в рассчитаных которые получаются из него
if (activ_data.ua>=0)
        StringGrid1->Cells [2][1] = AnsiString().sprintf("%0.3f",activ_data.ua);//activ_data.ua;
else
        StringGrid1->Cells [2][1] = "";
if (activ_data.ia >= 0)
        StringGrid1->Cells [2][2] = AnsiString().sprintf("%0.3f",activ_data.ia);//activ_data.ia;
else
        StringGrid1->Cells [2][2] = "";

double phi1_rad = (activ_data.U1I1*M_PI)/180;  //угол в радианах, косинус работает с ним
double phi1_grad = activ_data.U1I1;
if (fabs(phi1_grad)<361)
StringGrid1->Cells [2][3] = FormatFloat("0.000",phi1_grad);
else
StringGrid1->Cells [2][3] = "";

if (!IsNan(phi1_rad))
cos1 = cos (phi1_rad);
if (!IsNan (cos1))
StringGrid1->Cells [2][4] = FormatFloat("0.0000", cos1);
else
StringGrid1->Cells [2][4] = "";
double AM1 = activ_data.ia*activ_data.ua*cos(phi1_rad);
if (!IsNan(AM1))
StringGrid1->Cells [2][5] = FormatFloat("0.000",AM1);
else
StringGrid1->Cells [2][5] = "";
double RM1 = activ_data.ia*activ_data.ua*sin(phi1_rad);
if (!IsNan(RM1))
StringGrid1->Cells [2][6] = FormatFloat("0.000",RM1);
else
StringGrid1->Cells [2][6] = "";

double FM1 = AM1+RM1;
if (!IsNan(FM1))
StringGrid1->Cells [2][7] = FormatFloat("0.000",FM1);
else
StringGrid1->Cells [2][7] = "";

if (activ_data.ub>=0)
StringGrid1->Cells [2][8] = AnsiString().sprintf("%0.3f",activ_data.ub);//activ_data.ub;
else
StringGrid1->Cells [2][8] = "";
if (activ_data.ib >= 0)
StringGrid1->Cells [2][9] = AnsiString().sprintf("%0.3f",activ_data.ib);//activ_data.ib;
else
StringGrid1->Cells [2][9] = "";
double phi2_rad = (activ_data.U2I2*M_PI)/180;  //угол в радианах, косинус работает с ним
double phi2_grad = activ_data.U2I2;
if (fabs (phi2_grad)<361)
StringGrid1->Cells [2][10] = FormatFloat("0.000",phi2_grad);
else
StringGrid1->Cells [2][10] = "";
cos2 = cos (phi2_rad);
if (!IsNan(cos2))
StringGrid1->Cells [2][11] = FormatFloat("0.0000", cos2);
else
StringGrid1->Cells [2][11] = "";
double AM2 = activ_data.ib*activ_data.ub*cos(phi2_rad);
if (!IsNan(AM2))
StringGrid1->Cells [2][12] = FormatFloat("0.000",AM2);
else
StringGrid1->Cells [2][12] = "";
double RM2 = activ_data.ib*activ_data.ub*sin(phi2_rad);
if (!IsNan(RM2))
StringGrid1->Cells [2][13] = FormatFloat("0.000",RM2);
else
StringGrid1->Cells [2][13] = "";
double FM2 = AM2+RM2;
if (!IsNan(FM2))
StringGrid1->Cells [2][14] = FormatFloat("0.000",FM2);
else
StringGrid1->Cells [2][14] = "";
if (activ_data.uc >= 0)
StringGrid1->Cells [2][15] = AnsiString().sprintf("%0.3f",activ_data.uc);//activ_data.uc;
else
StringGrid1->Cells [2][15] = "";
if (activ_data.ic >= 0)
StringGrid1->Cells [2][16] = AnsiString().sprintf("%0.3f",activ_data.ic);//activ_data.ic
else
StringGrid1->Cells [2][16] = "";

double phi3_rad = (activ_data.U3I3*M_PI)/180;  //угол в радианах, косинус работает с ним
double phi3_grad = activ_data.U3I3;
if (fabs(phi3_grad)<361)
StringGrid1->Cells [2][17] = FormatFloat("0.000",phi3_grad);
else
StringGrid1->Cells [2][17] = "";
cos3 = cos (phi3_rad);
if (!IsNan (cos3))
StringGrid1->Cells [2][18] = FormatFloat("0.0000", cos3);
else
StringGrid1->Cells [2][18] = "";
double AM3 = activ_data.ic*activ_data.uc*cos(phi3_rad);
if (!IsNan (AM3))
StringGrid1->Cells [2][19] = FormatFloat("0.000",AM3);
else
StringGrid1->Cells [2][19] = "";
double RM3 = activ_data.ic*activ_data.uc*sin(phi3_rad);
if (!IsNan(RM3))
StringGrid1->Cells [2][20] = FormatFloat("0.000",RM3);
else
StringGrid1->Cells [2][20] = "";
double FM3 = AM3+RM3;
if (!IsNan (FM3))
StringGrid1->Cells [2][21] = FormatFloat("0.000",FM3);
else
StringGrid1->Cells [2][21] = "";
if (activ_data.freq >= 0)
StringGrid1->Cells [2][22] = AnsiString().sprintf("%0.3f",activ_data.freq);//activ_data.freq;
else
StringGrid1->Cells [2][22] = "";
double FAM, FRM;
FAM = AM1+AM2+AM3;
FRM = RM1+RM2+RM3;
if (!IsNan (FAM))
StringGrid1->Cells [2][23] = FormatFloat("0.000",FAM);
else
StringGrid1->Cells [2][23] = "";
if (!IsNan(FRM))
StringGrid1->Cells [2][24] = FormatFloat("0.000",FRM);
else
StringGrid1->Cells [2][24] = "";
if (!IsNan (FAM+FRM))
StringGrid1->Cells [2][25] = FormatFloat("0.000",FAM+FRM);
else
StringGrid1->Cells [2][25] = "";
if (activ_data.an >=0 )
StringGrid1->Cells [2][26] = AnsiString().sprintf("%0.3f",activ_data.an);
else
StringGrid1->Cells [2][26] = "";
if (activ_data.cosf >=-1)
StringGrid1->Cells [2][27] = AnsiString().sprintf("%0.4f",activ_data.cosf);//activ_data.cosf;
else
StringGrid1->Cells [2][27] = "";

if (Language == "UKR"){
if (activ_data.obsolete==1){
StringGrid1->Cells [2][28] = "Недостовірно";//activ_data.cosf;
}
else
StringGrid1->Cells [2][28] = "Достовірно";//activ_data.cosf;

}
else{
if (activ_data.obsolete==1){
StringGrid1->Cells [2][28] = "Не достоверно";//activ_data.cosf;
}
else
StringGrid1->Cells [2][28] = "Достоверно";//activ_data.cosf;
}
fAutoSizeColSG(StringGrid1);
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::pChart1BeforeDraw(TObject *Sender)
{
//TODO 05.08.2020 Тут мы будем выводить подписи к стрелкам на диаграмму после её построения с пересчётом координат от середины диаграммы к фактическим декартовым x;y с учётом сдвига в рабочей области
// и фон
drawTitleDiagramm();
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::drawTitleDiagramm(){
//TODO 05.08.2020 Тут будем перерисовывать "прицел" вместо фонового bmp файлика с учётом фактических текущих координат диаграммы
        const int x1 = getX1();
        const int y1 = getY1();
        int x2 = getX2();
        /* (pChartGRB1->Legend->Visible){
                x2 = x2-15;
        } */
        const int y3 = getY3();//493;
        const int x4 = x2;
        const int y4 = y3;
        int center_x = (x1+x2)/2+2-1;
        int center_y = (y1+y3)/2+25+1;
        //21.12.2020 - GRB делаем центр круга по меньшей координате
        int min_dim = (center_x < center_y)? center_x: center_y;
        center_x = min_dim;
        //end add
        pChartGRB1->Canvas->Font->Size = 12;

        pChartGRB1->Canvas->Line (center_x, y1+3, center_x, y1+13); //рисуем рисочки на всей области диаграммы
        pChartGRB1->Canvas->Line (center_x, y4-3, center_x, y4-13);
        pChartGRB1->Canvas->Line (x1+3, center_y, x1+13, center_y);
        pChartGRB1->Canvas->Line (x4-3,center_y, x4-13,center_y);

        //рисуем продолжения линий
        pChartGRB1->Canvas->Line(center_x,y1+23,center_x, y3-23);
        pChartGRB1->Canvas->Line(x1+23,center_y,x4-23, center_y);
        //рисуем большой круг
        double radius_big = 5*center_y/6;
        if (center_x < center_y){
                radius_big = 5*center_x/6;
        }
        pChartGRB1->Canvas->Ellipse(center_x - radius_big, center_y - radius_big, center_x + radius_big, center_y + radius_big);
        //выводим отсечки углов на большом круге
        //TColor oldColor = pChartGRB1->Canvas->Brush->Color;
        pChartGRB1->Canvas->Brush->Color = (TColor) 0xF0F0F0 ;
        pChartGRB1->Canvas->Font->Size = 12;
        /*Test - отсечки выводим на старом круге подшаманенном немного*/
        int pseudo_center_x = center_x;
        int pseudo_center_y = center_y;

        //21.12.2020 - GRB делаем центр круга по меньшей координате
        //int min_dim2 = (pseudo_center_x < pseudo_center_y)? pseudo_center_x: pseudo_center_y;
        pseudo_center_x = min_dim;
        //end add
        for (int i = 0; i<12; i++){
                int j = 30*(i+1); //угол
                coordArcAngle [i] = getCoord4CaptionOnRound (center_x, center_y, radius_big ,j);
                switch (i){
                case 0:{
                                //30
                                pChartGRB1->Canvas->Line(pseudo_center_x, pseudo_center_y,coordArcAngle[i].x,coordArcAngle[i].y);
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x+14, coordArcAngle[i].y-11 , IntToStr(j) );
                                break;
                        }
                        case 1:{//60
                                pChartGRB1->Canvas->Line(pseudo_center_x, pseudo_center_y,coordArcAngle[i].x,coordArcAngle[i].y);
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x+8, coordArcAngle[i].y-5, IntToStr(j) );
                                break;
                        }
                        case 2:{//90
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x-8, coordArcAngle[i].y-10, IntToStr(j) );
                                break;
                        }
                        case 3:{//120
                                pChartGRB1->Canvas->Line(pseudo_center_x, pseudo_center_y,coordArcAngle[i].x,coordArcAngle[i].y);
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x+2, coordArcAngle[i].y, IntToStr(j) );
                                break;
                        }
                        case 4:{//150
                                pChartGRB1->Canvas->Line(pseudo_center_x, pseudo_center_y,coordArcAngle[i].x,coordArcAngle[i].y);
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x, coordArcAngle[i].y, IntToStr(j) );
                                break;
                        }
                        case 5:{//180
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x-12, coordArcAngle[i].y-7, IntToStr(j) );
                                break;
                        }
                        case 6:{//210
                                pChartGRB1->Canvas->Line(pseudo_center_x, pseudo_center_y,coordArcAngle[i].x,coordArcAngle[i].y);
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x-28, coordArcAngle[i].y, IntToStr(j) );
                                break;
                        }
                        case 7:{//240
                                pChartGRB1->Canvas->Line(pseudo_center_x, pseudo_center_y,coordArcAngle[i].x,coordArcAngle[i].y);
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x-35, coordArcAngle[i].y-6, IntToStr(j) );
                                break;
                        }
                        case 8:{//270
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x-15, coordArcAngle[i].y-10, IntToStr(j) );
                                break;
                        }
                        case 9:{//300
                                pChartGRB1->Canvas->Line(pseudo_center_x, pseudo_center_y,coordArcAngle[i].x,coordArcAngle[i].y);
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x-32, coordArcAngle[i].y-10, IntToStr(j) );
                                break;
                        }
                        case 10:{//330
                                pChartGRB1->Canvas->Line(pseudo_center_x, pseudo_center_y,coordArcAngle[i].x,coordArcAngle[i].y);
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x-35, coordArcAngle[i].y-15, IntToStr(j) );
                                break;
                        }
                        case 11:{//360
                                pChartGRB1->Canvas->TextOutA(coordArcAngle[i].x-10, coordArcAngle[i].y-12, IntToStr(j) );
                                break;
                        }
                }
         }
          //Test
         //рисуем малый круг
         double radius_small = (center_y)/2;
         if (center_x<center_y)
                radius_small = (center_x)/2;
         pChartGRB1->Canvas->Ellipse(center_x-radius_small,center_y-radius_small,center_x+radius_small,center_y+radius_small);
         //рисуем подписи к графикам
         drawCaptionLines(captionVector);
}
//---------------------------------------------------------------------------
int __fastcall TDU2ChartInteriorGRB::getX1(){
 int tst = (pChartGRB1->ChartWidth*pChartGRB1->MarginLeft)/100+(pChartGRB1->ChartWidth*pChartGRB1->MarginRight)/100;
 return tst;
}
//---------------------------------------------------------------------------
int __fastcall TDU2ChartInteriorGRB::getY1(){
 int tst = (pChartGRB1->ChartHeight*pChartGRB1->MarginBottom)/100+(pChartGRB1->ChartHeight*pChartGRB1->MarginTop)/100;
 return tst;
}
//---------------------------------------------------------------------------
int __fastcall TDU2ChartInteriorGRB::getX2(){
  int res = pChartGRB1->ChartWidth;
  return res;
}
//---------------------------------------------------------------------------
int __fastcall TDU2ChartInteriorGRB::getY3(){
  int res = pChartGRB1->ChartHeight;
  return res;
}
//---------------------------------------------------------------------------
coord2x __fastcall TDU2ChartInteriorGRB::getCoord4CaptionOnRound (int x0, int y0, int Radius, int degree){
        coord2x ret = {0,0};
        ret.x= x0+Radius*cos(((90-degree) * M_PI / 180)); // отсечка на degree град
        ret.y= y0-Radius*sin(((90-degree) * M_PI / 180));
        return ret;
}
//---------------------------------------------------------------------------
//TODO отрисовка подписей к стрелкам на канве - не получилось
void __fastcall TDU2ChartInteriorGRB::drawCaptionLines (endVectorCoord* array_line){
       const int x1 = getX1();
        const int y1 = getY1();
        int x2 = getX2();
        if (pChartGRB1->Legend->Visible){
                x2 = x2-15;
        }
        const int y3 = getY3();
        int center_x = (x1+x2)/2-1;
        int center_y = (y1+y3)/2+25+1;
        //21.12.2020 - GRB делаем центр круга по меньшей координате
        int min_dim = (center_x < center_y)? center_x: center_y;
        center_x = min_dim;
        //end add
     if (!array_line) return;
     TColor wasColor = pChartGRB1->Canvas->Font->Color;
     TColor wasBack = pChartGRB1->Canvas->BackColor;
     int wasFontSize = pChartGRB1->Canvas->Font->Size;
     pChartGRB1->Canvas->BackColor = clLtGray;
     pChartGRB1->Canvas->Font->Size = 10;
     if (activ_data.obsolete==0){
     //if (global_obsolete==0){
     for (int i = 0; i < VECTOR_NUMS; i++){
        endVectorCoord curr = array_line[i];
        pChartGRB1->Canvas->Font->Color = curr.color;
        if (fabs(curr.coord.x)<0.001 && fabs(curr.coord.y)<0.001)//пропускаем нули
                continue;
        pChartGRB1->Canvas->TextOutA(center_x+curr.coord.x, center_y-curr.coord.y,curr.name);
        int widthOld = pChartGRB1->Canvas->Pen->Width;
        pChartGRB1->Canvas->Pen->Width = 2;
        pChartGRB1->Canvas->Pen->Color = curr.color;
        //Вместо линии рисуем стрелу
        //pChartGRB1->Canvas->Line (center_x, center_y, center_x+curr.coord.x,center_y-curr.coord.y);
        DrawLine ((pChartGRB1->Canvas),center_x, center_y, center_x+curr.coord.x,center_y-curr.coord.y,20,10);
        pChartGRB1->Canvas->Pen->Width = widthOld;
     }
     }
     pChartGRB1->Canvas->Font->Color = wasColor;
     pChartGRB1->Canvas->Font->Size = wasFontSize;
     pChartGRB1->Canvas->BackColor = wasBack;
     placeChart();
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::InitValue(){
 // Получить параметры из таблицы
  dNA   = activ_data.na;
  dNR   = activ_data.nr;
  dFR   = activ_data.freq;
  dCOSF = activ_data.cosf;
  dUA   = activ_data.ua;
  dUB   = activ_data.ub;
  dUC   = activ_data.uc;

  dAnUA = activ_data.an_ua;
  dAnUB = activ_data.an_ub;
  dAnUC = activ_data.an_uc;

  dIA   = activ_data.ia;
  dIB   = activ_data.ib;
  dIC   = activ_data.ic;

  dAnIA = activ_data.an_ia;
  dAnIB = activ_data.an_ib;
  dAnIC = activ_data.an_ic;

}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::placeChart(){

  double  kfcI2U = 1;
  double  XMaxVal;
  TArrowSeries *pArrow1;

  if (pChartGRB1->Parent == NULL)
  /* Настройка графика*/
  pChartGRB1->SeriesList->Clear();
  pArrow1 = new TArrowSeries(pChartGRB1);
  pChartGRB1->Legend->Visible              = false;
  pChartGRB1->Legend->LegendStyle          = lsAuto;
  pChartGRB1->Legend->TextStyle            = ltsPlain;
  pChartGRB1->AxisVisible                  = false;
  pChartGRB1->AllowPanning                 = pmNone;
  pChartGRB1->AllowZoom = false;
  pChartGRB1->BottomAxis->PositionPercent  = 100;
  pChartGRB1->BottomAxis->LabelStyle       = talValue;
  pChartGRB1->LeftAxis->PositionPercent    = 100;
  pArrow1->ParentChart                  = pChartGRB1;
  pArrow1->XValues->Order               = loNone;
  pArrow1->YValues->Order               = loDescending;
  pArrow1->Marks->Visible               = false;
  pArrow1->XValues->DateTime            = false;
  pArrow1->ColorEachPoint               = false;
  pArrow1->Pointer->Pen->Width          = 2;
  pArrow1->ArrowHeight = 12;
  pArrow1->ArrowWidth = 6;
  /*GRB ADD */
  captionVector = new endVectorCoord[VECTOR_NUMS];
    for (int i = 0; i < VECTOR_NUMS; i++){
        switch (i){
        case 0:{
        captionVector[i].name = "UA";
        captionVector[i].color = (TColor)0x000000;
        captionVector[i].coord.x = 0;
        captionVector[i].coord.y = 0;

        break;
        }
        case 1:{
        captionVector[i].name = "UB";
        captionVector[i].color = (TColor)0x000000;
        captionVector[i].coord.x = 0;
        captionVector[i].coord.y = 0;

        break;
        }
        case 2:{
        captionVector[i].name = "UC";
        captionVector[i].color = (TColor)0x000000;
        captionVector[i].coord.x = 0;
        captionVector[i].coord.y = 0;

        break;
        }
        case 3:{
        captionVector[i].name = "IA";
        captionVector[i].color = (TColor)0x000000;
        captionVector[i].coord.x = 0;
        captionVector[i].coord.y = 0;

        break;
        }
        case 4:{
        captionVector[i].name = "IB";
        captionVector[i].color = (TColor)0x000000;
        captionVector[i].coord.x = 0;
        captionVector[i].coord.y = 0;

        break;
        }
        case 5:{
        captionVector[i].name = "IC";
        captionVector[i].color = (TColor)0x000000;
        captionVector[i].coord.x = 0;
        captionVector[i].coord.y = 0;

        break;
        }
      }
    }
   //21.12.2020 GRB Своя нормировка для кругов
  const int x1 = getX1();
  const int y1 = getY1();
  int x2 = getX2();
  if (pChartGRB1->Legend->Visible){
        x2 = x2-15;
  }
  const int y3 = getY3();
  int center_x = (x1+x2)/2-1;
  int center_y = (y1+y3)/2+25+1;
  //end add
  int min_dim = (center_x < center_y)? center_x: center_y;
  center_x = min_dim;
  double norma_big = 1;
  double norma_small = 1;

   //приводим вектора напряжения
   double xBig11 = coordArcAngle[11].x;
   double yBig11 = coordArcAngle[11].y;
   /*double xBig6 = coordArcAngle[6].x;
   double yBig6 = coordArcAngle[6].y;*/
   double vectorMaxLen = sqrt (((xBig11-center_x)*(xBig11-center_x)) + ((yBig11-center_y) * (yBig11-center_y)));
   //double vectorMaxLen2 = sqrt (((xBig6-center_x)*(xBig6 - center_x)) + ((yBig6-center_y) * (yBig6-center_y)));
   double maxUVector = getMaxVector (dUA, dUB, dUC);
   if (fabs(maxUVector) > 0.00000001)
        norma_big = vectorMaxLen/maxUVector;
   else
        norma_big = 1;

  //end ADD
  /* расчёт коэффициента для приведения токов к напряжению */
  if (dIA >= dIB && dIA >= dIC && dIA>0){
    kfcI2U  = dUA / dIA;
  }else{
    if(dIB >= dIA && dIB >= dIC && dIB>0){
      kfcI2U = dUB/dIB;
    }else{
      if(dIC >= dIB && dIC>=dIA && dIC>0){
        kfcI2U = dUC/dIC;
      }else{
        kfcI2U = 1;
      }
    }
  }
  dIA *= kfcI2U;//*5/6;
  dIB *= kfcI2U;//*5/6;
  dIC *= kfcI2U;//*5/6;

     //приводим вектора тока
   double vectorMinLen = (center_y)/2;
   if (center_x<center_y)
        vectorMinLen = (center_x)/2;
   double maxIVector = getMaxVector (dIA, dIB, dIC);
   if (fabs(maxIVector) > 0.00000001)
        norma_small = vectorMinLen/maxIVector;
   else
        norma_small = 1;
  /*END ADD*/

  double  x, y;
  //===== Добавлено ко всем углам 90 градусов
  if (dUA != -MAXFLOAT && dAnUA != -MAXFLOAT)
  { x = norma_big*dUA * cos((dAnUA + 90) * M_PI / 180);
    y = norma_big*dUA * sin((dAnUA + 90) * M_PI / 180);

    captionVector[0].color = (TColor)RGB(255,215,28);//clOlive;//(TColor)0xFFFF00;
    /*pArrow1->AddArrow(0, 0, x, y, "UA", (TColor)RGB(255,215,28));*/ //clTeeColor

    YMaxVal = max(fabs(y), fabs(x));
    coordArcAngle[0].x = x;
    coordArcAngle[0].y = y;
    captionVector[0].coord.x = x;
    captionVector[0].coord.y = y;
  }
  if (dUB != -MAXFLOAT && dAnUB != -MAXFLOAT)
  { x = norma_big*dUB * cos((-dAnUB + 90) * M_PI / 180);
    y = norma_big*dUB * sin((-dAnUB + 90) * M_PI / 180);
    captionVector[1].color = clLime;//(TColor)0x8010FF;
    /*pArrow1->AddArrow(0, 0, x, y, "UB", clLime);*/
    YMaxVal = max(YMaxVal, fabs(x));
    YMaxVal = max(YMaxVal, fabs(y));
    captionVector[1].coord.x = x;
    captionVector[1].coord.y = y;

  }
  if (dUC != -MAXFLOAT && dAnUC != -MAXFLOAT)
  { x = norma_big*dUC * cos((-dAnUC + 90) * M_PI / 180);
    y = norma_big*dUC * sin((-dAnUC + 90) * M_PI / 180);
    captionVector[2].color = (TColor)0x8010FF;//clLime;
    /*pArrow1->AddArrow(0, 0, x, y,  "UC", (TColor)0x8010FF);*/
    YMaxVal = max(YMaxVal, fabs(x));
    YMaxVal = max(YMaxVal, fabs(y));
    captionVector[2].coord.x = x;
    captionVector[2].coord.y = y;
  }
  if (dIA != -MAXFLOAT && dAnIA != -MAXFLOAT)
  { x = norma_small*dIA * cos((-dAnIA + 90) * M_PI / 180);
    y = norma_small*dIA * sin((-dAnIA + 90) * M_PI / 180);
    captionVector[3].color = clYellow;//clBlue;
    /*pArrow1->AddArrow(0, 0, x, y, "IA", clYellow);*/
    YMaxVal = max(YMaxVal, fabs(x));
    YMaxVal = max(YMaxVal, fabs(y));
    captionVector[3].coord.x = x;
    captionVector[3].coord.y = y;
  }
  if (dIB != -MAXFLOAT && dAnIB != -MAXFLOAT)
  { x = norma_small*dIB * cos((-dAnIB + 90) * M_PI / 180);
    y = norma_small*dIB * sin((-dAnIB + 90) * M_PI / 180);
    captionVector[4].color = clGreen;//clRed;
    /*pArrow1->AddArrow(0, 0, x, y, "IB", clGreen);*/
    YMaxVal = max(YMaxVal, fabs(x));
    YMaxVal = max(YMaxVal, fabs(y));
    captionVector[4].coord.x = x;
    captionVector[4].coord.y = y;
  }
  if (dIC != -MAXFLOAT && dAnIC != -MAXFLOAT)
  { x = norma_small*dIC * cos((-dAnIC + 90) * M_PI / 180);
    y = norma_small*dIC * sin((-dAnIC + 90) * M_PI / 180);
    captionVector[5].color = clRed;/*clGreen*/;
    /*pArrow1->AddArrow(0, 0, x, y,  "IC", clRed);*/
    YMaxVal = max(YMaxVal, fabs(x));
    YMaxVal = max(YMaxVal, fabs(y));
    captionVector[5].coord.x = x;
    captionVector[5].coord.y = y;
  }
  //===== 22.4.2005 Fr+izyuk A.M. Finish
  YMinVal = -YMaxVal;
  // Настройка масштаба по умолчанию
  IncreaseScaleValue(YMinVal, YMaxVal);
  pChartGRB1->LeftAxis->Minimum      = -MAXFLOAT;
  pChartGRB1->BottomAxis->Minimum    = -MAXFLOAT;
  pChartGRB1->LeftAxis->Maximum      = YMaxVal + ((YMaxVal - YMinVal) / 100) * 5;
  pChartGRB1->BottomAxis->Maximum    = YMaxVal + ((YMaxVal - YMinVal) / 100) * 5;
  pChartGRB1->LeftAxis->Minimum      = YMinVal - ((YMaxVal - YMinVal) / 100) * 5;
  pChartGRB1->BottomAxis->Minimum    = YMinVal - ((YMaxVal - YMinVal) / 100) * 5;
  pChartGRB1->LeftAxis->Automatic    = false;
  pChartGRB1->BottomAxis->Automatic  = false;
  pChartGRB1->Title->Text->Clear();
  AnsiString caption1 = "";
  AnsiString caption2 = "";

  if (Language == "UKR"){
  caption1 = "Дані по об'єкту '"+ fd->NameGroup +"' за дату "+objName +" з профілем ";
  caption2 = "Векторна діаграма";
  switch (fd->StepProfile){
    case TFormDescr::stpDay:
      caption1+=" за місяць";
      break;
    case TFormDescr::stpHour:
      caption1+=" за добу";
      break;
    case TFormDescr::stpMonth:
      caption1+=" за рік";
      break;
  }
  }else{
  caption1 = "Данные по объекту '"+ fd->NameGroup +"' за дату "+objName +" с профилем ";
  caption2 = "Векторная диаграмма";
   switch (fd->StepProfile){
    case TFormDescr::stpDay:
      caption1+=" за месяц";
      break;
    case TFormDescr::stpHour:
      caption1+=" за сутки";
      break;
    case TFormDescr::stpMonth:
      caption1+=" за год";
      break;
  }
  }

    pChartGRB1->Title->Text->Add(caption2);
    ((TBaseMonitorForm*)Owner)->Caption = caption1;
    ((TBaseMonitorForm*)Owner)->Repaint();
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::IncreaseScaleValue( double & PPYMinVal, double & PPYMaxVal )
{
     //Только для profile
     if
     (
       ( PPYMinVal < 0 )
       &&
       ( PPYMinVal > -1 )
     )
       PPYMinVal = -INCREASE_SCALE_VALUE;
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::OnKeyUp(TObject *Sender, WORD &Key,TShiftState Shift){
        return;
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::ChartFXLinesClick(TObject *Sender){
        return;
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::SaveGraphToFile(TSaveDialog *aSaveDialog)
{
      aSaveDialog->Title = Reconst_smes105_24;
      aSaveDialog->FileName = Reconst_smes105_22;
      aSaveDialog->DefaultExt = "bmp";
      aSaveDialog->Filter = Reconst_smes105_25;
      if(aSaveDialog->Execute())
      {
        Graphics::TBitmap* bm = new Graphics::TBitmap;
        //07.12.2020 - GRB comment
        /*try
        {
          bm->Width = pChartGRB1->Width;
          bm->Height= pChartGRB1->Height;
          pChartGRB1->BufferedDisplay=false;
          pChartGRB1->Draw(bm->Canvas,Rect(0,0,pChartGRB1->Width,pChartGRB1->Height));
          pChartGRB1->BufferedDisplay = true;
          bm->SaveToFile(aSaveDialog->FileName);
        }*/
        //07.12.2020 GRB rewrite - выводим картикой не только диаграмму но и стринггрид с поясняловкой
        try{
         int maxHeight = pChartGRB1->Height;
         if (StringGrid1->Height > pChartGRB1->Height)
                maxHeight = StringGrid1->Height;
          bm->Width = pChartGRB1->Width+StringGrid1->Width;
          bm->Height= maxHeight;

         pChartGRB1->BufferedDisplay=false;
         pChartGRB1->Draw(bm->Canvas,Rect(0, 0, pChartGRB1->Width, maxHeight));
         pChartGRB1->BufferedDisplay = true;

         bm->Canvas->Brush->Color = clWhite;
         TRect rect = TRect (pChartGRB1->Width,0,bm->Width,bm->Height);
         bm->Canvas->FillRect(rect);
         StringGrid1->PaintTo(bm->Canvas, pChartGRB1->Width, 0);

         bm->SaveToFile(aSaveDialog->FileName);
         //end rewrite
        }
        __finally
        {
          delete bm;
        }
      }
}
//---------------------------------------------------------------------------
AnsiString __fastcall TDU2ChartInteriorGRB::getSeparator(){
 TRegistry *Reg = new TRegistry(KEY_READ);
 AnsiString ExportSeparator = ",";
      try
      {
        Reg->RootKey = HKEY_CURRENT_USER;
        Reg->Access = KEY_READ;
        Reg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", False);
        if(Reg->ValueExists("ExportSeparator"))
              ExportSeparator = ((Reg->ReadString("ExportSeparator") == ",") ? (",") : ("."));
        else
             ExportSeparator = (".");
      }
      __finally
      {
        delete Reg;
      }
      return ExportSeparator;
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::SaveTableToFile(TSaveDialog *aSaveDialog)
{
    //07.12.2020 GRB - COMMENT Т.к у нас в картинку идёт стринггрид с диаграммой в файл будем писать таблицу
    /*aSaveDialog->Title = Reconst_smes111_33;
    aSaveDialog->FileName = Reconst_smes105_22;
    aSaveDialog->DefaultExt = "txt";
    aSaveDialog->Filter = Reconst_smes111_35;
    AnsiString delim = ";";
    if(aSaveDialog->Execute())
    {
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString fileName = aSaveDialog->FileName;
                AnsiString separator = getSeparator();
                for (int i = 1; i < StringGrid1->RowCount; i++){
                        for (int j = 0; j < StringGrid1->ColCount; j++){
                               rowData =  StringGrid1->Cells[j][i];
                               rowData = StringReplace(rowData,".",separator,TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);
                               if (rowData!="")
                                        str = str + rowData;
                        }
                    sList->Add (str);
                    str="";
                }
                try{
                        if (!FileExists(fileName))
                                sList->SaveToFile(fileName);
                        else{
                                DeleteFile (fileName);
                                sList->SaveToFile(fileName);
                        }
                }catch (EFCreateError &efce){
                   throw;
                }
    } */
    //07.12.2020 - GRB Rewrire
    aSaveDialog->Title = Reconst_smes111_33;
    aSaveDialog->FileName = Reconst_smes111_34;
    aSaveDialog->DefaultExt = "xls";
    aSaveDialog->Filter = Reconst_smes111_35;
    if(aSaveDialog->Execute())
    {
        AnsiString RepTitle;
        TPrintDrawTable *PrintTable = new TPrintDrawTable(this);
        PrintTable->SaveTableToFile(dynamic_cast<TBaseMonitorForm*>(Owner)->Caption, dynamic_cast<TBaseMonitorForm*>(Owner)->LabelComment->Caption, ColumnsCaption, VT_PrintData,
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthName->Text.ToInt()+50:FormSetupMonitors->EditColorWidthDigit->Text.ToInt(),
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthDigit->Text.ToInt()-10:FormSetupMonitors->EditColorWidthName->Text.ToInt(),0,aSaveDialog->FileName,0);
        delete PrintTable;
    }
    //END Rewrite
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::OnClickPanel(System::TObject* Sender)
{
	(dynamic_cast<TBaseMonitorForm*>(Owner))->FormActivate(Sender);
        //GRB ADD 20.09.2021 Фиксим баг с возвращением к исходным размером при ресайзе диаграмм
        if (GetContainedWidthStatusFromReg())
                AutoSizeNameOnly (DrawTable);
        //END ADD
}

void __fastcall TDU2ChartInteriorGRB::moveRowToActiveData(int ARow){
   // Получить параметры из таблицы
  	TCloneItem  *ptr,*pDatOracle,*ptrDatOracle;
  ptrDatOracle = datOracle+Clones+1+ARow;
  activ_data.na = (ptrDatOracle + NA *(Clones + 1))->val;
  activ_data.nr = (ptrDatOracle + NR *(Clones + 1))->val;
  activ_data.an = (ptrDatOracle + anF *(Clones + 1))->val;
  activ_data.cosf = (ptrDatOracle + COSF *(Clones + 1))->val;

  activ_data.ua = (ptrDatOracle + UA * (Clones + 1))->val;
  activ_data.ub = (ptrDatOracle + UB * (Clones + 1))->val;
  activ_data.uc = (ptrDatOracle + UC * (Clones + 1))->val;

  activ_data.an_ua = (ptrDatOracle+anUA * (Clones + 1))->val;
  activ_data.an_ub = (ptrDatOracle+anUB * (Clones + 1))->val;
  activ_data.an_uc = (ptrDatOracle+anUC * (Clones + 1))->val;

  activ_data.ia = (ptrDatOracle + IA * (Clones + 1))->val;
  activ_data.ib = (ptrDatOracle + IB * (Clones + 1))->val;
  activ_data.ic = (ptrDatOracle + IC * (Clones + 1))->val;

  activ_data.an_ia = (ptrDatOracle + anIA * (Clones + 1))->val;
  activ_data.an_ib = (ptrDatOracle + anIB * (Clones + 1))->val;
  activ_data.an_ic = (ptrDatOracle + anIC * (Clones + 1))->val;


  activ_data.U1U2 = (ptrDatOracle + zU1U2 * (Clones + 1))->val;
  activ_data.U1U3 = (ptrDatOracle + zU1U3 * (Clones + 1))->val;
  activ_data.U2U3 = (ptrDatOracle + zU2U3 * (Clones + 1))->val;

  activ_data.U1I1 = (ptrDatOracle + zU1I1 * (Clones + 1))->val;
  activ_data.U2I2 = (ptrDatOracle + zU2I2 * (Clones + 1))->val;
  activ_data.U3I3 = (ptrDatOracle + zU3I3 * (Clones + 1))->val;

  activ_data.freq = (ptrDatOracle + FR * (Clones + 1))->val;
  //activ_data.obsolete = (ptrDatOracle + OBSOLETE * (Clones + 1))->val;
  //activ_data.obsolete = global_obsolete;
  }
//---------------------------------------------------------------------------
AnsiString __fastcall TDU2ChartInteriorGRB::getObjectName (int aRow){
     AnsiString ret = (NamesClones->Strings[aRow]);
     return ret;
}

//---------------------------------------------------------------------------

void __fastcall TDU2ChartInteriorGRB::DrawTableDrawCell(TObject *Sender, int ACol,
      int ARow, const TRect &Rect, TGridDrawState State)
{
   //Тут была попытка (неудачная) выводить желтым цветом фон последней нажатой строчки DrawTable, с тем чтобы пользователь мог понимать на чём он стоит и к чему диаграмма
   //может вернусь к ней
   /*if (State.Contains(gdFocused))
      DrawTable->Canvas->Brush->Color = clYellow;

   DrawTable->Canvas->FillRect(Rect);*/
}
//---------------------------------------------------------------------------
double __fastcall TDU2ChartInteriorGRB::getMaxVector (double vec1, double vec2, double vec3 ){
double ret = vec1;
if ( (fabs (vec1) >= fabs (vec2)) && ( (fabs (vec1)>=fabs (vec2) )))  return vec1;
if ( (fabs (vec2) >= fabs (vec1))&& ((fabs (vec2)>=fabs (vec3))))  return vec2;
if ( (fabs (vec3) >= fabs (vec1))&&((fabs (vec3)>=fabs (vec2))))  return vec3;
return ret;
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::DrawLine(TCanvas3D* Canvas, double x0, double y0, double x1, double y1, double ArrowAngle, int ArrowLen){

ArrowAngle = ArrowAngle*M_PI/180;
//Длина основной линии
int Len = sqrt((x0-x1)*(x0-x1) + (y0-y1)*(y0-y1));
//Угол наклона основной линии
double Angle;
if(x0==x1 && y0<y1){
Angle = M_PI/2;
}
else if(x0==x1 && y0>y1){
Angle = 3*M_PI/2;
}
else if(x0>x1 && y0==y1){
Angle = 0;
}
else if(x0<x1 && y0==y1){
Angle = M_PI;
}
else if(x0>x1 && y0<y1){
Angle = asin((y1-y0)/Len);
}
else if(x0<x1 && y0<y1){
Angle = M_PI - asin( (y1-y0)/Len);
}
else if(x0<x1 && y0>y1){
Angle = M_PI-asin((y1-y0)/Len);
}
else if(x0>x1 && y0>y1){
Angle = 2*M_PI+asin( (y1-y0)/Len);
}

int x2 = x1 + ArrowLen * cos(Angle+ArrowAngle); // конец первого лепестка по X
int y2 = y1 - ArrowLen * sin(Angle+ArrowAngle); // конец первого лепестка по Y

int x3 = x1 + ArrowLen * cos(Angle-ArrowAngle); // конец второго лепестка по X
int y3 = y1 - ArrowLen * sin(Angle-ArrowAngle); // конец конец второго лепестка по Y
// рисуем саму линию
Canvas->MoveTo(x0,y0);
Canvas->LineTo(x1,y1);
//Рисуем лепестки
TPoint points[3];
points[0] = Point(x1,y1);
points[1] = Point(x2,y2);
points[2] = Point(x3,y3);
Canvas->Polygon(points, 2);
}
//
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::FormShow(TObject *Sender){
        ChartFXColumns(currentRow);
         if (GetContainedWidthStatusFromReg())
                AutoSizeNameOnly (DrawTable);
}
//---------------------------------------------------------------------------
//-------------------------------------------------------------------------------
//GRB ADD 26.08.2021 - два метода для автоформатирования по содержимому фиксированых колонок - исправление бага с обрезанием длинных имён в колонках
//---------------------------------------------------------------------------
void __fastcall  TDU2ChartInteriorGRB::AutoSizeColGRB (TDrawTable* tsg, int columnIndex){
        int i,w,WMax;
        TFont *wasFont;
        TFont* regFont;
        try{
        WMax = atoi(tsg->ColsWidth.c_str());
        wasFont = tsg->Canvas->Font;
        regFont = GetActiveFont4MonitorFromReg();
        if (regFont!=NULL){
                tsg->Canvas->Font = regFont;
        }
        delete regFont;
        regFont = NULL;
        tsg->Canvas->Font->Style = tsg->Canvas->Font->Style << fsBold;
        for (int i = 0; i < tsg->RowCount-1; i++){
                AnsiString a_val = NamesClones->Strings[i];//tsg->GetEditText[columnIndex][i];
                w = tsg->Canvas->TextWidth(a_val);
                if (w > WMax) WMax = w;
        }
        }catch (Exception &ex){
        tsg->ColWidths[columnIndex] = WMax + 8;
        tsg->Canvas->Font = wasFont;
        try{
        delete regFont;
        regFont = NULL;
        }catch (Exception &ex){}
        }
        tsg->ColWidths[columnIndex] = WMax + 8;
        tsg->Canvas->Font = wasFont;
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInteriorGRB::AutoSizeNameOnly (TDrawTable* tsg){
                AutoSizeColGRB (tsg, 0);
}
//---------------------------------------------------------------------------
TFont * __fastcall TDU2ChartInteriorGRB::GetActiveFont4MonitorFromReg (){
    TFormSetupMonitors *psm;
    TFont *retFont;
    try
    {
        retFont = new TFont();
        psm = new TFormSetupMonitors(Application);
        retFont->Name = psm->PanelColorTable->Font->Name;
        retFont->Size = psm->PanelColorTable->Font->Size;
        delete psm;
        return retFont;

    }catch (Exception &ex){
        delete psm;
        //Смелое предположение - так типа по дефолту
        retFont->Name = "MS Sans Serif";
        retFont->Size = 8;
        return retFont;
    }


}
//---------------------------------------------------------------------------
bool __fastcall TDU2ChartInteriorGRB::GetContainedWidthStatusFromReg(){
         TFormSetupMonitors *psm;
         bool ret = false;
         try{
         psm = new TFormSetupMonitors(Application);
         if (psm->RadioGroupColWidthName->ItemIndex == 1) ret = true;
         else ret = false;
         delete psm;
         }catch (Exception &ex){
                delete psm;
                return false;
         }
         return ret;
}
//---------------------------------------------------------------------------


