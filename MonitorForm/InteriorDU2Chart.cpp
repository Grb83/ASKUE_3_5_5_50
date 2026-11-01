//---------------------------------------------------------------------------

#include <vcl.h>
#include <stdio.h>
#include <ArrowCha.hpp>
#pragma hdrstop
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#include "InteriorDU2Chart.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "Reconst.hpp"

int y;
//---------------------------------------------------------------------------
//Текущие значения и параметры качества электроэнергии (КСС)
__fastcall TDU2ChartInterior::TDU2ChartInterior(TComponent* Owner,TSplitterForm *aSP,TFormDescr *aFD,Classes::TNotifyEvent OnProgr)
    :T1Interior(Owner,aSP,aFD,OnProgr)
{
  fd->SummGroup = false;
  TBaseMonitorForm  *tBMForm  = dynamic_cast<TBaseMonitorForm *>(Owner);
  if (!tBMForm)
    return;
  tBMForm->PopupMenuBaseForm->OnPopup = OnPopupClick;
  tBMForm->ChartFXLines->OnClick      = NULL;
  tBMForm->ChartFXColumns->OnClick    = NULL;
  tBMForm->ByGroup->OnClick           = NULL;
  tBMForm->ByProfile->OnClick         = NULL;
  //GRB ADD - подписываем на перерисовку
  ((TBaseMonitorForm*)Owner)->OnResize=FormShow;
}
//---------------------------------------------------------------------------

__fastcall TDU2ChartInterior::~TDU2ChartInterior(void)
{
	if (pChart1)
    delete  pChart1;
  pChart1 = NULL;
	if (vtDU2Data)
    delete  vtDU2Data;
  vtDU2Data = NULL;
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInterior::formDescr( void )
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
  }
  vtDU2Data->Assign(dmMain->oqInterCursor);
  vtDU2Data->Active = true;
  dmMain->oqInterCursor->Close();
	if (!Clones)
    Application->ShowException(&Exception(Reconst_smes111_2));
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInterior::selectData( TOraQuery *qwInter )
{
  int iClones,
      state,
      i;
	TCloneItem  *ptr,
              *pDatOracle;
  double  dat[26];
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
      if(!vtDU2Data->FieldByName("na")->IsNull)
        dat[0]=vtDU2Data->FieldByName("na")->AsFloat;
      if(!vtDU2Data->FieldByName("nr")->IsNull)
        dat[1]=vtDU2Data->FieldByName("nr")->AsFloat;
      if(!vtDU2Data->FieldByName("an")->IsNull)
        dat[2]=vtDU2Data->FieldByName("an")->AsFloat;
      if(!vtDU2Data->FieldByName("cosf")->IsNull)
        dat[3]=vtDU2Data->FieldByName("cosf")->AsFloat;
      if(!vtDU2Data->FieldByName("ua")->IsNull)
        dat[4]=vtDU2Data->FieldByName("ua")->AsFloat;
      if(!vtDU2Data->FieldByName("ub")->IsNull)
        dat[5]=vtDU2Data->FieldByName("ub")->AsFloat;
      if(!vtDU2Data->FieldByName("uc")->IsNull)
        dat[6]=vtDU2Data->FieldByName("uc")->AsFloat;
      if(!vtDU2Data->FieldByName("an_ua")->IsNull)
        dat[7]=vtDU2Data->FieldByName("an_ua")->AsFloat;
      if(!vtDU2Data->FieldByName("an_ub")->IsNull)
        dat[8]=vtDU2Data->FieldByName("an_ub")->AsFloat;
      if(!vtDU2Data->FieldByName("an_uc")->IsNull)
        dat[9]=vtDU2Data->FieldByName("an_uc")->AsFloat;
      if(!vtDU2Data->FieldByName("ia")->IsNull)
        dat[10]=vtDU2Data->FieldByName("ia")->AsFloat;
      if(!vtDU2Data->FieldByName("ib")->IsNull)
        dat[11]=vtDU2Data->FieldByName("ib")->AsFloat;
      if(!vtDU2Data->FieldByName("ic")->IsNull)
        dat[12]=vtDU2Data->FieldByName("ic")->AsFloat;
      if(!vtDU2Data->FieldByName("an_ia")->IsNull)
        dat[13]=vtDU2Data->FieldByName("an_ia")->AsFloat;
      if(!vtDU2Data->FieldByName("an_ib")->IsNull)
        dat[14]=vtDU2Data->FieldByName("an_ib")->AsFloat;
      if(!vtDU2Data->FieldByName("an_ic")->IsNull)
        dat[15]=vtDU2Data->FieldByName("an_ic")->AsFloat;
      if(!vtDU2Data->FieldByName("U1U2")->IsNull)
        dat[16]=vtDU2Data->FieldByName("U1U2")->AsFloat;
      if(!vtDU2Data->FieldByName("U1U3")->IsNull)
        dat[17]=vtDU2Data->FieldByName("U1U3")->AsFloat;
      if(!vtDU2Data->FieldByName("U2U3")->IsNull)
        dat[18]=vtDU2Data->FieldByName("U2U3")->AsFloat;
      if(!vtDU2Data->FieldByName("U1I1")->IsNull)
        dat[19]=vtDU2Data->FieldByName("U1I1")->AsFloat;
      if(!vtDU2Data->FieldByName("U2I2")->IsNull)
        dat[20]=vtDU2Data->FieldByName("U2I2")->AsFloat;
      if(!vtDU2Data->FieldByName("U3I3")->IsNull)
        dat[21]=vtDU2Data->FieldByName("U3I3")->AsFloat;
      if(!vtDU2Data->FieldByName("freq")->IsNull)
        dat[22]=vtDU2Data->FieldByName("freq")->AsFloat;  

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

void __fastcall TDU2ChartInterior::clonesInRows(void)
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
//  DrawTable->TabStrings->Add("$ m0x0 0x100F c15 b #$ m0x9 0x100B #< m0x9 0x100A #<#< m0x9 0x100E #$ m0x0009 0x100B # < m0x9 0x100A #<#<#<#<#<#<#<#<#<#<#<#<#<#<#<#< m0x9 0x100E#$ m0x9 0x100F");
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
  //DrawTable->StaticStrings->Add(GetSubColumnsNames()[jColumns]);
  //  ColumnsCaption->Add(GetSubColumnsNames()[jColumns]);
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
inline AnsiString __fastcall TDU2ChartInterior::GetSubColumnsNames(int n)
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

void __fastcall TDU2ChartInterior::dataInRows(void)
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

void __fastcall TDU2ChartInterior::Place(void)
{
  TFormSetupMonitors*psm;
  try
  { psm = new TFormSetupMonitors(Application);
		//Создаем график 1
		pChart  = NULL;
		pChart  = new TChart(Owner);
    pChart->OnMouseDown               = ChartMouseDown;
    pChart->OnMouseMove               = ChartMouseMove;
    pChart->Enabled                   = true;
		pChart->Parent                    = dynamic_cast<TWinControl*>(Owner);
		//Проводим начальную настройку компонента TChart 1
		pChart->View3D                    = false;
    pChart->Legend->Visible           = true;
    pChart->Legend->ColorWidth        = 35;
    pChart->AllowZoom                 = false;
    pChart->AllowPanning              = pmNone;
    pChart->LeftAxis->Title->Caption  = GetUnitOfEnergy();
    pChart->Show();
		//Создаем график 2
		pChart1 = NULL;
		pChart1 = new TChart(Owner);
    pChart1->OnMouseDown              = ChartMouseDown;
    pChart1->OnMouseMove              = ChartMouseMove;
    pChart1->Enabled                  = true;
		pChart1->Parent                   = dynamic_cast<TWinControl *>(Owner);
		//Проводим начальную настройку компонента TChart 2
		pChart1->View3D                   = false;
    pChart1->Legend->Visible          = true;
    pChart1->Legend->ColorWidth       = 35;
    pChart1->AllowZoom                = false;
    pChart1->AllowPanning             = pmNone;
    pChart1->LeftAxis->Title->Caption = GetUnitOfEnergy();
    pChart1->Show();
		//Создаем таблицу
		//Укладываем таблицу и графики в SplitterForm
		DrawTable = new TDrawTable(Owner);

		SplitterForm->AddChild(NULL, DrawTable, alRight);
    SplitterForm->AddChild(NULL, pChart, alBottom);
    SplitterForm->AddChild(pChart, pChart1, alRight);

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
    //VNB 8.01.2009 Судя по всему в этом мониторе метки качества нет
   // setDataSourceToDrawTable(DrawTable,datOracle,Clones+1,SubColumns(),RowCount+1);

    // Строим график по умолчанию
    ChartFXColumns(1);
		OnProgressBarStepBy(this);//80

    //chig
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
    //e
    //GRB ADD - подписываем на перерисовку
    ((TBaseMonitorForm*)Owner)->OnResize=FormShow;
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
    delete  psm;
    OnProgressBarStepBy(NULL);
		throw(Exception(Reconst_smes111_26));
  }
  delete  psm;
  OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInterior::clickGraphics(long ColPressed, long RowPressed)
{
	if (ColPressed == 1)//разложение по группам
	{ ChartFXLines(RowPressed);
	}
	if (RowPressed == 0)//построение профиля
	{ ChartFXColumns(ColPressed - 1);
	}
}
//---------------------------------------------------------------------------

bool __fastcall TDU2ChartInterior::setSplit(void)
{
  Application->MessageBox(Reconst_smes111_27.c_str(),
                            Application->Title.c_str(), MB_OK | MB_ICONINFORMATION);
  return  true;
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInterior::ChartFXLines(long AClone)
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
 // pLine->Title              = GetSubColumnsNames()[0];
  pLine->Title              = GetSubColumnsNames(0);
  pChart->Title->Text->Text = AnsiString(Reconst_smes111_28)+
                                 GetSubColumnsNames(AClone) + Reconst_smes111_29 + fd->NameGroup;
                               // GetSubColumnsNames()[AClone] + Reconst_smes111_29 + fd->NameGroup;

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

void __fastcall TDU2ChartInterior::ChartFXColumns(long ARow)
{
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
#define FR      16          // смещение частоты
  TCloneItem  *ptrDatOracle;
  double  kfcI2U = 1;
  double  XMaxVal;
  double  dNA, dNR, dFR, dCOSF, dUA, dUB, dUC, dAnUA,
          dAnUB, dAnUC, dIA, dIB, dIC, dAnIA, dAnIB, dAnIC;
  TArrowSeries  *pArrow,
                *pArrow1;
  // Настройка графика
  while (pChart->SeriesCount()>0)
  { TChartSeries  *cs = pChart->Series[0];
    cs->ParentChart = NULL;
    delete  cs;
  }
  //for(int i=0; i<pChart->SeriesList->Count; i++)
  //    pChart->Series[i]->Active = false;
  //pChart->SeriesList->Clear();
  pArrow  = new TArrowSeries(pChart);
  pChart->Legend->Visible             = true;
  pChart->Legend->LegendStyle         = lsAuto;
  pChart->Legend->TextStyle           = ltsPlain;
  pChart->AxisVisible                 = true;
  pChart->AllowPanning                = pmNone;
  pChart->AllowZoom                   = false;
  pChart->OnMouseDown                 = ChartMouseDown;
  pChart->OnMouseMove                 = ChartMouseMove;
  pChart->BottomAxis->PositionPercent = 50;
  pChart->BottomAxis->LabelStyle      = talValue;
  pChart->LeftAxis->PositionPercent   = 50;
  pArrow->ParentChart         = pChart;
  pArrow->XValues->Order      = loNone;
  pArrow->YValues->Order      = loDescending;
  pArrow->Marks->Visible      = false;
  pArrow->XValues->DateTime   = false;
  pArrow->ColorEachPoint      = true;
  pArrow->Pointer->Pen->Width = 2;

  // Получить параметры из таблицы
  ptrDatOracle = datOracle+Clones+1+ARow;
  dNA   = (ptrDatOracle + NA *(Clones + 1))->val;
  dNR   = (ptrDatOracle + NR *(Clones + 1))->val;
//  dFR   = (ptrDatOracle + FR * (Clones + 1))->val;
//  dCOSF = (ptrDatOracle + COSF * (Clones + 1))->val;
  dUA   = (ptrDatOracle + UA * (Clones + 1))->val;
  dUB   = (ptrDatOracle + UB * (Clones + 1))->val;
  dUC   = (ptrDatOracle + UC * (Clones + 1))->val;
  dAnUA = (ptrDatOracle+anUA * (Clones + 1))->val;
  dAnUB = (ptrDatOracle+anUB * (Clones + 1))->val;
  dAnUC = (ptrDatOracle+anUC * (Clones + 1))->val;
  dIA   = (ptrDatOracle + IA * (Clones + 1))->val;
  dIB   = (ptrDatOracle + IB * (Clones + 1))->val;
  dIC   = (ptrDatOracle + IC * (Clones + 1))->val;
  dAnIA = (ptrDatOracle + anIA * (Clones + 1))->val;
  dAnIB = (ptrDatOracle + anIB * (Clones + 1))->val;
  dAnIC = (ptrDatOracle + anIC * (Clones + 1))->val;

  // расчёт коэффициента для приведения токов к напряжению
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
  dIA *= kfcI2U * 0.7;//sechin
  dIB *= kfcI2U * 0.7;
  dIC *= kfcI2U * 0.7;

  if (NamesClones->Count > ARow)
  { pArrow->Title = NamesClones->Strings[ARow];
    pChart->Title->Text->Text = Reconst_smes111_30 +
                                  fd->NameGroup + Reconst_smes110_6 + NamesClones->Strings[ARow];
  }
  else
  { pArrow->Title = "";
    pChart->Title->Text->Text = "";
  }
  // Вырисовка векторного графика
  if (dNA != -MAXFLOAT)
   // pArrow->AddArrow(0, 0, dNA, 0, GetSubColumnsNames()[NA + 1], clTeeColor);
   pArrow->AddArrow(0, 0, dNA, 0, GetSubColumnsNames(NA + 1), (TColor)clTeeColor);
  if (dNR != -MAXFLOAT)
   // pArrow->AddArrow(0, 0, 0, dNR, GetSubColumnsNames()[NR + 1], clTeeColor);
     pArrow->AddArrow(0, 0, 0, dNR, GetSubColumnsNames(NR + 1), (TColor)clTeeColor);
  if (dNA != -MAXFLOAT && dNR != -MAXFLOAT)
    pArrow->AddArrow(0, 0, dNA, dNR, Reconst_smes111_31, (TColor)clTeeColor);
  if (dNA != -MAXFLOAT && dNR != -MAXFLOAT)
    YMaxVal = max(fabs(dNA), fabs(dNR));
  else
    if (dNA != -MAXFLOAT)
      YMaxVal = fabs(dNA);
    else
      if (dNR != -MAXFLOAT)
        YMaxVal = fabs(dNR);
      else
        YMaxVal = 10;
  YMinVal = -YMaxVal;
  // Настройка масштаба по умолчанию
  IncreaseScaleValue(YMinVal, YMaxVal);
  pChart->LeftAxis->Minimum     = -MAXFLOAT;
  pChart->BottomAxis->Minimum   = -MAXFLOAT;
  pChart->LeftAxis->Maximum     = YMaxVal + ((YMaxVal - YMinVal) / 100) * 5;
  pChart->LeftAxis->Minimum     = YMinVal - ((YMaxVal - YMinVal) / 100) * 5;
  pChart->BottomAxis->Maximum   = YMaxVal + ((YMaxVal - YMinVal) / 100) * 5;
  pChart->BottomAxis->Minimum   = YMinVal - ((YMaxVal - YMinVal) / 100) * 5;
  pChart->LeftAxis->Automatic   = false;
  pChart->BottomAxis->Automatic = false;

  if (pChart1->Parent == NULL)
    SplitterForm->AddChild(pChart, pChart1, alRight);
  // Настройка графика
  pChart1->SeriesList->Clear();
  pArrow1 = new TArrowSeries(pChart1);
  pChart1->Legend->Visible              = true;
  pChart1->Legend->LegendStyle          = lsAuto;
  pChart1->Legend->TextStyle            = ltsPlain;
  pChart1->AxisVisible                  = false;
  pChart1->AllowPanning                 = pmNone;
//  pChart1->AllowZoom = false;
  pChart1->BottomAxis->PositionPercent  = 50;
  pChart1->BottomAxis->LabelStyle       = talValue;
  pChart1->LeftAxis->PositionPercent    = 50;
  pArrow1->ParentChart                  = pChart1;
  pArrow1->XValues->Order               = loNone;
  pArrow1->YValues->Order               = loDescending;
  pArrow1->Marks->Visible               = false;
  pArrow1->XValues->DateTime            = false;
  pArrow1->ColorEachPoint               = false;
  pArrow1->Pointer->Pen->Width          = 2;

  if (NamesClones->Count > ARow)
  { pArrow1->Title  = NamesClones->Strings[ARow];
    pChart1->Title->Text->Text  = Reconst_smes111_32 +
                                    fd->NameGroup + Reconst_smes110_6 + NamesClones->Strings[ARow];
  }

  double  x, y;
  //===== 22.4.2005 Frizyuk A.M. Start
  //===== Добавлено ко всем углам 90 градусов
  if (dUA != -MAXFLOAT && dAnUA != -MAXFLOAT)
  { x = dUA * cos((dAnUA + 90) * M_PI / 180);
    y = dUA * sin((dAnUA + 90) * M_PI / 180);
   // pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames()[UA + 1], (TColor)0xFFFF); //clTeeColor
    pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames(UA + 1), (TColor)0xFFFF); //clTeeColor
    YMaxVal = max(fabs(y), fabs(x));
  }
  if (dUB != -MAXFLOAT && dAnUB != -MAXFLOAT)
  { x = dUB * cos((-dAnUB + 90) * M_PI / 180);
    y = dUB * sin((-dAnUB + 90) * M_PI / 180);
   // pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames()[UB + 1], clGreen);
    pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames(UB + 1), clGreen);
    YMaxVal = max(YMaxVal, fabs(x));
    YMaxVal = max(YMaxVal, fabs(y));
  }
  if (dUC != -MAXFLOAT && dAnUC != -MAXFLOAT)
  { x = dUC * cos((-dAnUC + 90) * M_PI / 180);
    y = dUC * sin((-dAnUC + 90) * M_PI / 180);
   // pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames()[UC + 1], clRed);
    pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames(UC + 1), clRed);
    YMaxVal = max(YMaxVal, fabs(x));
    YMaxVal = max(YMaxVal, fabs(y));
  }
  if (dIA != -MAXFLOAT && dAnIA != -MAXFLOAT)
  { x = dIA * cos((-dAnIA + 90) * M_PI / 180);
    y = dIA * sin((-dAnIA + 90) * M_PI / 180);
  //  pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames()[IA + 1], (TColor)0xC4FFFF);
    pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames(IA + 1), (TColor)0xC4FFFF);
    YMaxVal = max(YMaxVal, fabs(x));
    YMaxVal = max(YMaxVal, fabs(y));
  }
  if (dIB != -MAXFLOAT && dAnIB != -MAXFLOAT)
  { x = dIB * cos((-dAnIB + 90) * M_PI / 180);
    y = dIB * sin((-dAnIB + 90) * M_PI / 180);
   // pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames()[IB + 1], (TColor)0xFF00);
    pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames(IB + 1), (TColor)0xFF00);
    YMaxVal = max(YMaxVal, fabs(x));
    YMaxVal = max(YMaxVal, fabs(y));
  }
  if (dIC != -MAXFLOAT && dAnIC != -MAXFLOAT)
  { x = dIC * cos((-dAnIC + 90) * M_PI / 180);
    y = dIC * sin((-dAnIC + 90) * M_PI / 180);
   // pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames()[IC + 1], (TColor)0x8080FF);
   pArrow1->AddArrow(0, 0, x, y, GetSubColumnsNames(IC + 1), (TColor)0x8080FF);
    YMaxVal = max(YMaxVal, fabs(x));
    YMaxVal = max(YMaxVal, fabs(y));
  }
  //===== 22.4.2005 Frizyuk A.M. Finish
  YMinVal = -YMaxVal;
  // Настройка масштаба по умолчанию
  IncreaseScaleValue(YMinVal, YMaxVal);
  pChart1->LeftAxis->Minimum      = -MAXFLOAT;
  pChart1->BottomAxis->Minimum    = -MAXFLOAT;
  pChart1->LeftAxis->Maximum      = YMaxVal + ((YMaxVal - YMinVal) / 100) * 5;
  pChart1->BottomAxis->Maximum    = YMaxVal + ((YMaxVal - YMinVal) / 100) * 5;
  pChart1->LeftAxis->Minimum      = YMinVal - ((YMaxVal - YMinVal) / 100) * 5;
  pChart1->BottomAxis->Minimum    = YMinVal - ((YMaxVal - YMinVal) / 100) * 5;
  pChart1->LeftAxis->Automatic    = false;
  pChart1->BottomAxis->Automatic  = false;
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInterior::Destroy(void)
{
	SplitterForm->RemoveChild(pChart1);
	SplitterForm->RemoveChild(pChart);
	SplitterForm->RemoveChild(DrawTable);
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInterior::ChartMouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
  y = Y;
  TChart  *ch = dynamic_cast<TChart *>(Sender);
  if (Shift.Contains(ssRight) && ch)
    ch->UndoZoom();
}
//---------------------------------------------------------------------------

void __fastcall TDU2ChartInterior::ChartMouseMove(TObject *Sender,
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

inline int __fastcall TDU2ChartInterior::GetCountRow(void)
{
  return  23;//17;
}
//---------------------------------------------------------------------------
#pragma package(smart_init)

void __fastcall TDU2ChartInterior::OnPopupClick(TObject* Sender)
{
  TBaseMonitorForm  *bmf  = dynamic_cast<TBaseMonitorForm *>(Owner);
  if (!bmf)
    return;
  bmf->View->Enabled            = true;
  bmf->ChartFXColumns->Enabled  = false;
  bmf->ChartFXLines->Enabled    = false;
  bmf->ByGroup->Enabled         = false;
  bmf->ByProfile->Enabled       = false;
  bmf->SmallFont->Checked       = !bmf->isSmallFont;
  bmf->SmallFont2->Checked      = !bmf->isSmallFont;
}
//---------------------------------------------------------------------------
void __fastcall TDU2ChartInterior::SaveTableToFile(TSaveDialog *aSaveDialog)
{
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
}
//---------------------------------------------------------------------------
//-------------------------------------------------------------------------------
//GRB ADD 26.08.2021 - два метода для автоформатирования по содержимому фиксированых колонок - исправление бага с обрезанием длинных имён в колонках
//---------------------------------------------------------------------------
void __fastcall  TDU2ChartInterior::AutoSizeColGRB (TDrawTable* tsg, int columnIndex){
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
void __fastcall TDU2ChartInterior::AutoSizeNameOnly (TDrawTable* tsg){
                AutoSizeColGRB (tsg, 0);
}
//---------------------------------------------------------------------------
TFont * __fastcall TDU2ChartInterior::GetActiveFont4MonitorFromReg (){
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
//END ADD
void __fastcall TDU2ChartInterior::FormShow(TObject *Sender){
         if (GetContainedWidthStatusFromReg())
                AutoSizeNameOnly (DrawTable);
}
//---------------------------------------------------------------------------
bool __fastcall TDU2ChartInterior::GetContainedWidthStatusFromReg(){
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

