//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#include "Interior2xDrawTableChart.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "ValidParam.h"
#include "unEnrgValid.h"

#include "Reconst.hpp"
//---------------------------------------------------------------------------
const int MAXGRAFICPICTURE_START = 1;
const double INCREASE_SCALE_VALUE = 6;


#pragma package(smart_init)

__fastcall T2xDrawTableChartInterior::T2xDrawTableChartInterior(TComponent* Owner,TSplitterForm *aSP,TFormDescr* aFD,Classes::TNotifyEvent OnProgr):
	inherited(Owner,aSP,aFD,OnProgr), fNumClones(NULL), datOracle(NULL), NamesClones(NULL),
    pChart(NULL), DrawTable(NULL),Series(NULL),SeriesDgrms(0),SeriesLines(0)
{
	if(dynamic_cast<TBaseMonitorForm*>(Owner))
    try
    {
	    ClonePressed=false;

		NamesClones=new TStringList();
    //------------------------------ VNB 12.12.2008
    //((TBaseMonitorForm*)Owner)->LabelComment->Caption=((TBaseMonitorForm*)Owner)->LabelComment->Caption+" [ "+GetUnitOfEnergy()+" ] ";
     ((TBaseMonitorForm*)Owner)->LabelComment->Caption=((TBaseMonitorForm*)Owner)->LabelComment->Caption+GetCaptionPowerCoeff();
    //---------------------------- VNB end;
		((TBaseMonitorForm*)Owner)->ChartFXLines->OnClick=ChartFXLinesClick;
		((TBaseMonitorForm*)Owner)->ChartFXColumns->OnClick=ChartFXLinesClick;
		((TBaseMonitorForm*)Owner)->ByGroup->OnClick=ChartFXLinesClick;
		((TBaseMonitorForm*)Owner)->ByProfile->OnClick=ChartFXLinesClick;

    ((TBaseMonitorForm*)Owner)->miFormula->OnClick=ChartFXLinesClick;
    if(fd->StepProfile==TFormDescr::stpHour)
    ((TBaseMonitorForm*)Owner)->miFormula->Visible=true;
    else
    ((TBaseMonitorForm*)Owner)->miFormula->Visible=false;

    ((TBaseMonitorForm*)Owner)->IsValid->OnClick=IsValidClick;
		((TBaseMonitorForm*)Owner)->PopupMenuBaseForm->OnPopup=PopupMenuBaseFormPopup;

		//Загружаем из базы полное описание таблицы
		OnProgressBarStepBy(NULL);//0
		formDescr();
		OnProgressBarStepBy(this);//10
        //GRB 23.05.2018 FIX - день перехода на летнее время для графика мощности - удары по выделенной памяти, т.к RowCount меньше чем обычно (46 вместо 48)
        int fixSize = RowCount+2;
        /*if (RowCount == 46){
           fixSize = fixSize+2;
        }*/
        //GRB 18.07.2019 FIX сверху очень наивный (30 минутки на NPID28 и только день при выборе пользователем)и не учитывает различных вариаций NPID22 и NPID28 и различных выборов пользователем периода отчёта (день и часы)
        switch(fd->StepProfile){
                case TFormDescr::stpHour:{
                        if (RowCount == (24*(60/PowerProfile)-1*(60/PowerProfile)))
                                fixSize = fixSize+(60/PowerProfile);
                        break;
                }
                case TFormDescr::stpMinute:{
                      if (RowCount == ((LenPROFILE/StepPROFILE)-1*(3600/StepPROFILE)))
                                fixSize = fixSize+(3600/StepPROFILE);
                        break;                                
                }
        }
        //END ADD


        datOracle = new TCloneItem[(Clones+1)*SubColumns()*fixSize];
        SeriesLines = (Clones+1)*SubColumns();
        SeriesDgrms = (fixSize)*SubColumns();
        //END OF FIX
        Series = new PSeries[SeriesLines+SeriesDgrms];
        ZeroMemory(Series, sizeof(PSeries)*(SeriesLines+SeriesDgrms));
        fPlace = true;
        fNumClones = new bool[Clones+1];
        //chig Формируем перечень клонов отображаемых на графиках на основании того, что запомнено
        bool prIsPerechEmpty = TRUE;
        if (fd->IsMemParActualForClones)
            for(int i=0; i < Clones+1; ++i)
            {
                fNumClones[i] = false;
                //Существует ли она в конфигурации
                for(int j=0; j<MAXGRAFICPICTURE; j++)
                if(i==fd->ColorAttr[j].PointId)
                {
                    fNumClones[i] = TRUE;
                    prIsPerechEmpty = FALSE;
                    break;
                }
                //e Существует ли она в конфигурации
            }
        //e chig Формируем перечень клонов отображаемых на графиках на основании того, что запомнено
        if (prIsPerechEmpty)
        {
            int prStertI = 0;
            int prNum = MAXGRAFICPICTURE_START;
        	if( !fd->SummGroup )
            {
                prStertI++;
                prNum++;
            }
            for( int i=0; i<Clones+1; i++ )
            {
                if((i >= prStertI)&&(i < prNum))
                    fNumClones[i]=true;
                else
                    fNumClones[i]=false;
            }
        }
        //add bu NNV
        if(AreTherTwoGraph())
           pSecondChart = new TChart(Owner); //Добавление второго компонента TChart на форму
        else
           pSecondChart = NULL;
        //end add by NNV
		//Загружаем из базы данные
	 //	selectData(dmMain->qwInter);
    selectData(dmMain->oqInterCursor);
		OnProgressBarStepBy(this);//30
    Dp= new TfmDetailPoint(Owner);
    }catch(Exception&e){
		if(NamesClones) delete NamesClones;
		if(datOracle) delete []datOracle;
        if(fNumClones) delete []fNumClones;
        if(Series) delete []Series;
        SeriesDgrms = SeriesLines = 0;
		throw;
    }else
		throw(Exception(Reconst_smes105_1));
    //GRB ADD - подписываем на перерисовку
    ((TBaseMonitorForm*)Owner)->OnResize=FormShow;
}
//---------------------------------------------------------------------------
__fastcall T2xDrawTableChartInterior::~T2xDrawTableChartInterior(void)
{
    if(NamesClones) delete NamesClones;
    if(datOracle) delete [] datOracle;
    if(fNumClones) delete []fNumClones;
    if(Series) delete []Series;
    SeriesDgrms = SeriesLines = 0;
    if (Dp) delete Dp;
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::Destroy(void)
{
	SplitterForm->RemoveChild(pChart);
	SplitterForm->RemoveChild(DrawTable);
        //add by NNV
        if(pSecondChart)
           SplitterForm->RemoveChild(pSecondChart);
        //end add by NNV
    inherited::Destroy();
}
//---------------------------------------------------------------------------

void __fastcall T2xDrawTableChartInterior::Place(void)
{
    TFormSetupMonitors*psm;
    try
    {
        psm = new TFormSetupMonitors(Application);
		//Создаем график
	pChart=new TChart(Owner);
        pChart->Enabled=true;
        //add by NNV
        int cw = 35;
        if(pSecondChart){
          pSecondChart->Enabled = true;
          pSecondChart->View3D=false;
          pSecondChart->Legend->Visible=true;
          pSecondChart->Legend->ColorWidth = 17;
          cw = 18;
          pSecondChart->AllowZoom=true;
          pSecondChart->AllowPanning=pmHorizontal;
          pSecondChart->Show();
          pSecondChart->LeftAxis->Title->Caption = GetUnitOfEnergy();
          pSecondChart->ClipPoints = true;
        }
        //end add by NNV
		//Создаем таблицу
		DrawTable=new TDrawTable(Owner);
		//Укладываем таблицу и график в SplitterForm
		SplitterForm->AddChild(NULL,DrawTable,alRight);
		if(fd->VerticalSplit)
			SplitterForm->AddChild(NULL,pChart,alRight);
		else
			SplitterForm->AddChild(NULL,pChart,alBottom);
                //add by NNV
                if(pSecondChart){
                    if(fd->VerticalSplit)
        	       SplitterForm->AddChild(pChart,pSecondChart,alRight);
                    else
	  	       SplitterForm->AddChild(pChart,pSecondChart,alBottom);
                }
                //end add by NNV
		//Проводим начальную настройку компонента TChart
	pChart->View3D=false;
        pChart->Legend->Visible=true;
        pChart->Legend->ColorWidth = cw;
        pChart->AllowZoom=true;
        pChart->AllowPanning=pmHorizontal;
        pChart->Show();
        pChart->LeftAxis->Title->Caption = GetUnitOfEnergy();
        pChart->ClipPoints = true;

		SplitterForm->Splitter->OnClick=OnClickPanel;
		SplitterForm->Splitter->Tag=fd->PercentSplit;
		SplitterForm->SplitFormResize(NULL);

        // ======== Форматирование таблицы
		TPopupMenu *pPopup=
		   (dynamic_cast<TBaseMonitorForm*>(Owner))->PopupMenu;
		DrawTable->PopupMenu=pPopup;
		DrawTable->PopupMenu->AutoPopup=false;
		DrawTable->OnEnter=OnClickPanel;
		DrawTable->OnMouseDown=DrawTableMouseDown;
		DrawTable->OnMouseMove=DrawTableMouseMove;
		DrawTable->OnMouseUp=DrawTableMouseUp;
		DrawTable->OnKeyUp=OnKeyUp;
		DrawTable->Options>>goRangeSelect>>goFixedVertLine>>goFixedHorzLine>>goVertLine>>goHorzLine;
		DrawTable->DefaultDrawing=false;
		if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
			DrawTable->RowsHeight=AnsiString("#")+psm->EditColorHeight->Text;
		else
			DrawTable->RowsHeight=AnsiString("#")+psm->EditBWHeight->Text;

		OnProgressBarStepBy(this);//40
		if( fd->VerticalSplit )
		{
			if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
				DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthDigit->Text;
			else
				DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthDigit->Text;
			clonesInColumns();
		}
		else
		{
			if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
				DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthName->Text+
					AnsiString("#")+psm->EditColorWidthDigit->Text;
			else
				DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthName->Text+
					AnsiString("#")+psm->EditBWWidthDigit->Text;
			clonesInRows();
		}


      //  setDataSourceToDrawTable(DrawTable,datOracle,Clones+1+!fd->SummGroup,SubColumns(),RowCount+1);

        //======== Строим график по умолчанию
        //if( Clones>0 )
		if(fd->SummGroup){
    setDataSourceToDrawTable(DrawTable,datOracle,Clones+1,SubColumns(),RowCount+1);
			ChartFXLines(0); }
		else {
    setDataSourceToDrawTable(DrawTable,datOracle,Clones+1,SubColumns(),RowCount+1);
			ChartFXLines(1); }
		OnProgressBarStepBy(this);//80
    setColorToDrawTable(DrawTable,SubColumns());

        //chig
        if (fd->IsMemParActualForClones)
        {
            //Восстановление состояния скроллинга
            DrawTable->TopRow = fd->TableTopRow;
            //e Восстановление состояния скроллинга
            fd->IsMemParActualForClones = FALSE;
        }
        if ( fd->IsMemParActualForProf )
        {
            //Восстановление состояния скроллинга
            DrawTable->LeftCol = fd->TableLeftCol;
            //e Восстановление состояния скроллинга
            fd->IsMemParActualForProf = FALSE;
        }
        //e
        //26.08.2021 GRB ADD
        if (GetContainedWidthStatusFromReg())
        AutoSizeNameOnly (DrawTable);
        //end ADD

        delete psm;
    }
    catch(Exception&e)
    {
		if(DrawTable){
                   SplitterForm->RemoveChild(DrawTable);
		   delete DrawTable;
    		   DrawTable=NULL;
                }
		if(pChart){
                   if(pSecondChart){
                     SplitterForm->RemoveChild(pSecondChart);
                     delete pSecondChart;
                     pSecondChart=NULL;
                   }
    		   SplitterForm->RemoveChild(pChart);
		   delete pChart;
    		   pChart=NULL;
                }
        delete psm;
		throw(Exception(Reconst_smes105_2));
   }
}
//---------------------------------------------------------------------------
bool __fastcall T2xDrawTableChartInterior::setSplit(void)
{
/*    switch( fd->CodeTemplate )
      {
        case BALANCE_F:
        case BALANCE_POW_F:
        case BALANCE_SUM_F:
        case RE_BALANCE_F:
        case RE_BALANCE_POW_F:
        case RE_BALANCE_SUM_F:
        case NOT_BALANCE:
           {Application->MessageBox("Форма не поддерживает данную операцию",
                            Application->Title.c_str(), MB_OK | MB_ICONINFORMATION);
               return  true;
           }
      }
*/

    TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
	long s=SplitterForm->Splitter->Tag;
	fd->VerticalSplit=!fd->VerticalSplit;
	if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
		DrawTable->RowsHeight=AnsiString("#")+psm->EditColorHeight->Text;
	else
		DrawTable->RowsHeight=AnsiString("#")+psm->EditBWHeight->Text;

	if(fd->VerticalSplit)
	{
		if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
			DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthDigit->Text;
		else
			DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthDigit->Text;
		clonesInColumns();
		DrawTable->SetFocus();
		SplitterForm->RemoveChild(pChart);     //edited by KAG
    if(pSecondChart)
      SplitterForm->RemoveChild(pSecondChart);
    SplitterForm->AddChild(NULL,pChart,alRight);
    if(pSecondChart)
      SplitterForm->AddChild(pChart,pSecondChart,alBottom);//alNone
          //end edited by KAG
	}
	else
	{
		if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
			DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthName->Text+
				AnsiString("#")+psm->EditColorWidthDigit->Text;
		else
			DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthName->Text+
				AnsiString("#")+psm->EditBWWidthDigit->Text;
		clonesInRows();
		DrawTable->SetFocus();
		SplitterForm->RemoveChild(pChart);    //edited by KAG
    if(pSecondChart)
      SplitterForm->RemoveChild(pSecondChart);
   	SplitterForm->AddChild(NULL,pChart,alBottom);
    if(pSecondChart)
      SplitterForm->AddChild(pChart,pSecondChart,alBottom);//alNone
        //end edited by KAG
	}
	SplitterForm->Splitter->Tag=s;
	SplitterForm->Splitter->OnClick=OnClickPanel;
	SplitterForm->SplitFormResize(NULL);
   delete psm;
  if(fd->SummGroup)
   setDataSourceToDrawTable(DrawTable,datOracle,Clones+1,SubColumns(),RowCount+1);
  else   setDataSourceToDrawTable(DrawTable,datOracle,Clones+1,SubColumns(),RowCount+1);
   return fd->VerticalSplit;
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::Invalidate( int Table )
{
	if(
	(Table==TABLE_PROFILE && fd->StepProfile==TFormDescr::stpMinute)||
	(Table==TABLE_HALFHOUR && fd->StepProfile==TFormDescr::stpHour)||
	(Table==TABLE_BILL && (fd->StepProfile==TFormDescr::stpDay||fd->StepProfile==TFormDescr::stpMonth))
	)
	{
/* Add KAS*/
   if((fd->CodeTemplate!=EXCEL_F)&&(fd->CodeTemplate!=EXCEL_REP_F)&&(fd->CodeTemplate!=EXCEL_OP_FORM))
   {
		if( fd->VerticalSplit )
			dataInColumns();
		else
			dataInRows();
		if( fd->SummGroup )
			ChartFXLines(0);
		else
			ChartFXLines(1);
		DrawTable->Invalidate();
		OnProgressBarStepBy(NULL);
            }
	}
	else
		--refreshDataCount;
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::refreshData( int Table,TOraQuery *qwInter )
{
	if(
	(Table==TABLE_PROFILE && fd->StepProfile==TFormDescr::stpMinute)||
	(Table==TABLE_HALFHOUR && fd->StepProfile==TFormDescr::stpHour)||
	(Table==TABLE_BILL && (fd->StepProfile==TFormDescr::stpDay||fd->StepProfile==TFormDescr::stpMonth))
	)

    //selectData(dmMain->oqInterCursor);
     selectData(qwInter);
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::OnClickPanel(System::TObject* Sender)
{
	(dynamic_cast<TBaseMonitorForm*>(Owner))->FormActivate(Sender);
        //GRB ADD 20.09.2021 Фиксим баг с возвращением к исходным размером при ресайзе диаграмм
        if (GetContainedWidthStatusFromReg())
                AutoSizeNameOnly (DrawTable);
        //END ADD
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::OnKeyUp(TObject *Sender, WORD &Key,
	TShiftState Shift)
{
#define Sender ((TDrawTable*)Sender)
	if( Key==93 && Shift==TShiftState() )
	{
		TRect Rect=Sender->CellRect(Sender->Col,Sender->Row);
		POINT p;
		p.x=Rect.Right;
		p.y=Rect.Bottom;
		p=Sender->ClientToScreen(p);
		Sender->PopupMenu->Popup(p.x,p.y);
	}
#undef Sender
}
//---------------------------------------------------------------------------
TFormDescr* __fastcall T2xDrawTableChartInterior::GetFormDescr(void)
{
	fd->PercentSplit=SplitterForm->Splitter->Tag;
	return fd;
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::dataInColumns(void)
{
    long clones=Clones;
	//long columns=SubColumns();
	int iClones, jColumns;
	char *ptr, tmpData[20];
	TCloneItem* ptrDatOracle;
    //Подготавливаем переменные поля для приема
    if(fd->SummGroup)
	    clones++;

    //столбцы для названий точек(времени) и и подколонок
    ColumnsCaption->Clear();
    VT_PrintData->Close();
    VT_PrintData->Clear();
    VT_PrintData->FieldDefs->BeginUpdate();
    VT_PrintData->FieldDefs->Clear();
    //VT_PrintData->FieldDefs->Add("RowName", ftString, 50, false);
    VT_PrintData->FieldDefs->Add("RowName", ftString, 100, false);
    VT_PrintData->FieldDefs->Add("SubRowName", ftString, 30, false);
    for(int CC = 1; CC<=clones; CC++) // RowCount+1 - Столбцы для данных
        VT_PrintData->FieldDefs->Add("Data"+IntToStr(CC), ftString, 20, false);
    VT_PrintData->FieldDefs->EndUpdate();
    VT_PrintData->Open();

	ptr = DrawTable->StructStrings->GetArray();
    if(fd->SummGroup)
    {
        jColumns = clones*SubColumns()*(RowCount+1);
        for( iClones=0 ; iClones<jColumns ; ptr+=LenFloat,++iClones )
            if(datOracle[iClones].val!=-MAXFLOAT)
                strcpy(ptr, FormatFloat(MyFloatFormat,datOracle[iClones].val).c_str());
            else
                *ptr=0;
    }
	else
    {
	    ptrDatOracle=datOracle;
		for( jColumns=0; jColumns <= RowCount; ++jColumns )
		    for( ptrDatOracle+=SubColumns(),iClones=0 ;
			    iClones < clones*SubColumns() ;
                ptr+=LenFloat,++iClones,++ptrDatOracle )
			    if(ptrDatOracle->val!=-MAXFLOAT)
				    strcpy(ptr, FormatFloat(MyFloatFormat,ptrDatOracle->val).c_str());
                else
			        *ptr=0;
    }
    for(int i=0; i<RowCount+1; i++)
        for(int j=0; j<SubColumns(); j++)
        {
            VT_PrintData->Append();
            for(int DC=1, k=!fd->SummGroup; k<clones+!fd->SummGroup; k++, DC++)
            {
                if(datOracle[k*SubColumns()+j+i*(clones+!fd->SummGroup)*SubColumns()].val!=-MAXFLOAT)
                    strcpy(tmpData, FormatFloat(MyFloatFormat,datOracle[k*SubColumns()+j+i*(clones+!fd->SummGroup)*SubColumns()].val).c_str());
                else
                    *tmpData=0;
                VT_PrintData->Fields->FieldByName("Data"+IntToStr(DC))->AsString = AnsiString(tmpData);
            }
            VT_PrintData->Post();
        }
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::clonesInColumns(void)
{
	long clones=Clones;
	long columns=SubColumns();
	int iClones,jColumns;
	double stepProfile;

 //int gtz=TimeZona;

    if(Clones==1 && (long)NamesClones->Objects[0]==(long)NamesClones->Objects[1])
    {
       AnsiString s;
       s=DrawTable->ColsWidth;
       for( jColumns=0 ; jColumns < columns; ++jColumns )
	  s+=DrawTable->ColsWidth;
        //for( jColumns=0 ; jColumns < columns; ++jColumns )
       s+="#0";
       DrawTable->ColsWidth=s;
    }
	DrawTable->RowCount=RowCount+2+(columns>1?1:0);
	if(fd->SummGroup)
	    clones++;
    DrawTable->ColCount=1+clones*columns;
 //	DrawTable->FixedCols=1;
 if(fd->SummGroup)
    DrawTable->FixedCols=1+(columns>1?columns:1);
 else
    DrawTable->FixedCols=1;
 //	DrawTable->FixedRows=1+(columns>1?1:0);
    DrawTable->FixedRows=2+(columns>1?1:0);

	//Подготавливаем переменные поля для приема
	int *TempStruct=new int[clones*columns];
	//char *ptr;
	//TCloneItem* ptrDatOracle;
	for(iClones=0;iClones<clones*columns;++iClones)
	   TempStruct[iClones]=LenFloat;
	DrawTable->StructStrings->Rebuild(RowCount+1,clones*columns,TempStruct);
	dataInColumns();
	delete []TempStruct;

	//Добавляем заголовки клонов

	DrawTable->StaticStrings->Clear();
	if(fd->SummGroup){
           DrawTable->StaticStrings->Add(NamesClones->Strings[0]);
           ColumnsCaption->Add(NamesClones->Strings[0]);
        }
	for( iClones=1; iClones<=Clones ; ++iClones ){
	   DrawTable->StaticStrings->Add(NamesClones->Strings[iClones]);
           ColumnsCaption->Add(NamesClones->Strings[iClones]);
        }
	//Добавляем заголовки колонок под клонами
    VT_PrintData->First();
    if(columns>1)
	    for( iClones=1; iClones<=clones ; ++iClones )
		    for( jColumns=0; jColumns<columns ; ++jColumns )
			    DrawTable->StaticStrings->Add(GetSubColumnsNames(jColumns));
    //Добавляем нумерацию профиля
	TDateTime tempDate;
	AnsiString formatDate;
	AnsiString formatDateSum;

	unsigned short year,month,day;
	unsigned short hour, minute, sec, msec;
  int ind=0;

	fd->DateTime.DecodeDate( &year, &month, &day);
	switch(fd->StepProfile)
	{
	case TFormDescr::stpDay:
		day=1;
		stepProfile=1.0;
		formatDate="dd/mm";
		formatDateSum="mmmm";
		tempDate=TDateTime(year,month,day);
		break;
	case TFormDescr::stpMonth:
		day=1;
		month=1;
		stepProfile=31.0;
		formatDate="mmmm";
		formatDateSum="yyyy";
		tempDate=TDateTime(year,month,day);
		break;
	case TFormDescr::stpHour:
		hour=1;
    if(RowCount>24*(60/PowerProfile))//25 час
    {
    stepProfile=1.0/(RowCount-60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(RowCount-60/PowerProfile);
    }
    else if(RowCount<24*(60/PowerProfile))//23 час
    {
    stepProfile=1.0/(RowCount+60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(RowCount+60/PowerProfile);
    }
    else
    {
    	stepProfile=1.0/RowCount;
     tempDate=TDateTime(year,month,day)+hour/(double)RowCount;
     }

		formatDate="t";
		formatDateSum="dd/mm/yy";

		break;
	case TFormDescr::stpMinute:
		fd->DateTime.DecodeTime(&hour, &minute, &sec, &msec);
		stepProfile=StepPROFILE*1.157407407407e-5;
		formatDate="t";
		formatDateSum=Reconst_smes105_4;
		tempDate=TDateTime(year,month,day)+hour/24.0+minute/1440.0+stepProfile;
                //GRB CHANGE 16.07.2019
                //tempDate=TDateTime(year,month,day)+stepProfile;
		break;
	}

    VT_PrintData->First();
	//if(fd->SummGroup)
	DrawTable->StaticStrings->Add(tempDate.FormatString(formatDateSum));
 // DrawTable->StaticStrings->Add(tempDate.FormatString(formatDate));
  ind=0;
    for(int iii = 0; iii<columns; iii++)
    {
        VT_PrintData->Edit();
        VT_PrintData->Fields->FieldByName("RowName")->AsString = tempDate.FormatString(formatDateSum);
        VT_PrintData->Fields->FieldByName("SubRowName")->AsString = GetSubColumnsNames(iii);
        VT_PrintData->Next();
    }



	for( jColumns=1; jColumns<=RowCount ; ++jColumns )
	{
        for(int iii = 0; iii<columns; iii++)
        {
            VT_PrintData->Edit();
            VT_PrintData->Fields->FieldByName("RowName")->AsString = tempDate.FormatString(formatDate);
            VT_PrintData->Fields->FieldByName("SubRowName")->AsString = GetSubColumnsNames(iii);
            VT_PrintData->Next();
        }
       DrawTable->StaticStrings->Add(tempDate.FormatString(formatDate));
       tempDate+=stepProfile;
     //---------------
      tempDate.DecodeTime(&hour, &minute, &sec, &msec);

      if((IsShiftTimeZona)&&RowCount>24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?5-TimeZona:4-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))


       {
           ind=60/PowerProfile;     //25 час
           tempDate=tempDate-ind*stepProfile;

       }

     if((IsShiftTimeZona)&&RowCount<24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?4-TimeZona:3-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;     //23 час
           tempDate=tempDate+ind*stepProfile;

       }
   
    }
	//Формируем описание структуры для шапки всей таблицы опираясь
	//на количество клонов. Шапка занимает две строки.
	DrawTable->TabStrings->Clear();
	AnsiString temp;
	if( columns>1)
		temp="c15 m0x09  0x1807";
	else
		temp="c15 m0x09  0x180f";
	iClones=1;
	if(fd->SummGroup)
	{
		++iClones;
		if( columns>1)
		{
			temp+="# t2 b $m0x05  0x100b";
			for( jColumns=1; jColumns<=columns-2 ; ++jColumns )
				temp+="#<m0x05  0x100a";
			temp+="#<m0x05  0x100e";
		}
		else
			temp+="# t2 b $m0x05  0x100f";
	}
	for( ; iClones<=clones ; ++iClones )
	{
		if(columns>1)
		{
	      temp+="# t8 b- $m0x05  0x100b";
			for( jColumns=1; jColumns<=columns-2 ; ++jColumns )
				temp+="#<m0x05  0x100a";
			temp+="#<m0x05  0x100e";
        }
		else
		   temp+="# t8 b- $m0x05  0x100f";
    }
	DrawTable-> TabStrings->Add(temp);

	if(columns>1)
	{
		temp="^m0x09  0x180d";
		for( iClones=1; iClones<=clones ; ++iClones )
			for( jColumns=1; jColumns<=columns ; ++jColumns )
				temp+="#$m0x09  0x100f";
		DrawTable-> TabStrings->Add(temp);
	}

	//Формируем описание структуры для переменных строк всей таблицы опираясь
	//на количество клонов.
	iClones=1;
	if(fd->SummGroup)
	{
		temp="c15 t2 b $m0x05  0x100f";
		++iClones;
		if(columns>1)
		{
			temp+="#c28 t42 b- &m0x01  0x800d";
			for( jColumns=1; jColumns<=columns-1 ; ++jColumns )
				temp+="# &m0x01  0x800c";
		}
		else
			temp+="#c28 t42 b- &m0x01  0x800c";

		for( ; iClones<=clones ; ++iClones )
		{
			if(columns>1)
			{
				temp+="#c36 t8 &m0x01  0x800d";
				for( jColumns=1; jColumns<=columns-1 ; ++jColumns )
					temp+="# &m0x01  0x800c";
			}
			else
				temp+="#c36 t8 &m0x01  0x800c";
		}
		DrawTable-> TabStrings->Add(temp);
	}
	else
	{
		temp="c15 t2 b $m0x05  0x100f";
		iClones=1;
		for( ; iClones<=clones ; ++iClones )
		{
			if(columns>1)
			{
	   		temp+="#c36 t8 b- &m0x01  0x800d";
				for( jColumns=1; jColumns<=columns-1 ; ++jColumns )
					temp+="# &m0x01  0x800c";
			}
			else
				temp+="#c36 t8 b-  &m0x01  0x800c";
		}
		DrawTable-> TabStrings->Add(temp);
    }
	temp="c15 t8 $m0x05  0x100f";
	iClones=1;
	if(fd->SummGroup)
	{
		++iClones;
		if(columns>1)
		{
			temp+="#c36 &m0x01  0x800d";
			for( jColumns=1; jColumns<=columns-1 ; ++jColumns )
				temp+="# &m0x01  0x800c";
		}
		else
			temp+="#c36 &m0x01  0x800c";
	}
	for( ; iClones<=clones ; ++iClones )
	{
		if(columns>1)
		{
			temp+="#c5 &m0x01  0x800d";
			for( jColumns=1; jColumns<=columns-1 ; ++jColumns )
				temp+="# &m0x01  0x800c";
		}
		else
			temp+="#c5 &m0x01  0x800c";
	}
	DrawTable-> TabStrings->Add(temp);
	DrawTable->UpdateTabStrings();
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::dataInRows(void)
{
	long clones=Clones;
	long columns=SubColumns();
	int iClones,jColumns;
	char *ptr, tmpData[20];
	TCloneItem *ptrDataOra;
    long ptrDatOracle;
//  TDrawTable::SAttrCell* pAtr;//VNB
    //столбцы для названий точек(времени) и и подколонок
    ColumnsCaption  ->Clear();
    VT_PrintData->Close();
    VT_PrintData->Clear();
    VT_PrintData->FieldDefs->BeginUpdate();
    VT_PrintData->FieldDefs->Clear();
    //VT_PrintData->FieldDefs->Add("RowName", ftString, 50, false);
    VT_PrintData->FieldDefs->Add("RowName", ftString, 100, false);
    VT_PrintData->FieldDefs->Add("SubRowName", ftString, 30, false);
    for(int CC = 1; CC<=RowCount+1; CC++) // RowCount+1 - Столбцы для данных
       VT_PrintData->FieldDefs->Add("Data"+IntToStr(CC), ftString, 20, false);

    VT_PrintData->FieldDefs->EndUpdate();
    VT_PrintData->Open();
	//Подготавливаем переменные поля для приема
	if(fd->SummGroup)
	    clones++;
    ptr = DrawTable->StructStrings->GetArray();
	if(fd->SummGroup)
	{
        for( jColumns=0; jColumns < clones*columns ; ++jColumns )
        {
            ptrDatOracle = jColumns;
            iClones=0;
            for(; iClones < RowCount+1; )
            {
                if(datOracle[ptrDatOracle].val != -MAXFLOAT)
                    strcpy(ptr, FormatFloat(MyFloatFormat,datOracle[ptrDatOracle].val).c_str());
                else
                    *ptr=0;

                ptr+=LenFloat;
                iClones++;
                ptrDatOracle += clones*columns;
            }
        }
    }
	else
	{
        for( jColumns=0; jColumns < clones*columns ; ++jColumns )
            for( ptrDatOracle = columns+jColumns,iClones=0 ;
                iClones <= RowCount ;
                ptr+=LenFloat,++iClones,ptrDatOracle+=(clones+1)*columns )
            {
                if(datOracle[ptrDatOracle].val != -MAXFLOAT)
                    strcpy(ptr, FormatFloat(MyFloatFormat,datOracle[ptrDatOracle].val).c_str());
                else
                    *ptr=0;
     /*       if((fd->CodeTemplate==206)&&((jColumns+1)%columns==0&&jColumns)){
             pAtr=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(6,6);
             if(datOracle[ptrDatOracle].val<0 ) pAtr->BackgroundColor=clRed;
              }  //VNB  */


            }
    }


    // Заполняем таблицу для QR
    int m = 0;
    // if(fd->SummGroup && clones==2) m = 1; //раскоментировать для правильного сохранения таблицы с одной строкой в файл
    for( jColumns=0; jColumns < (clones-m)*columns ; ++jColumns )
    {
        VT_PrintData->Append();
        for( ptrDatOracle=jColumns+(fd->SummGroup?0:columns),iClones=1; iClones<=RowCount+1; ++iClones,ptrDatOracle+=(clones+(!fd->SummGroup))*columns )
        {
            if(datOracle[ptrDatOracle].val!=-MAXFLOAT)
                strcpy(tmpData, FormatFloat(MyFloatFormat,datOracle[ptrDatOracle].val).c_str());
            else
                *tmpData=0;
            VT_PrintData->Fields->FieldByName("Data"+IntToStr(iClones))->AsString = AnsiString(tmpData);
        }
        VT_PrintData->Post();
    }
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::clonesInRows(void)
{
	long clones=Clones;
	long columns=SubColumns();
	int iClones,jColumns,i;
	double stepProfile;

 // int gtz=TimeZona;

    if(Clones==1 && (long)NamesClones->Objects[0]==(long)NamesClones->Objects[1])
	{
		AnsiString s;
		s=DrawTable->RowsHeight;
		for( jColumns=0 ; jColumns < columns; ++jColumns )
			s+=DrawTable->RowsHeight;
		//for( jColumns=0 ; jColumns < columns; ++jColumns )
		s+="#0";
		DrawTable->RowsHeight=s;
	}
	DrawTable->ColCount=RowCount+2+(columns>1?1:0);
	if(fd->SummGroup)
		++clones;
	DrawTable->RowCount=1+clones*columns;
	//DrawTable->FixedCols=1+(columns>1?1:0);
  DrawTable->FixedCols=2+(columns>1?1:0);           //бажина тут +- (число STEPROFILE)
 //	DrawTable->FixedRows=1;
 if(fd->SummGroup)
    DrawTable->FixedRows=1+(columns>1?columns:1);
 else
    DrawTable->FixedRows=1;
    //Подготавливаем переменные поля для приема
	int *TempStruct=new int[RowCount+1];
	//char *ptr;
	//TCloneItem* ptrDatOracle;
	for(iClones=0;iClones<=RowCount;++iClones)
		TempStruct[iClones]=LenFloat;
	DrawTable->StructStrings->Rebuild(clones*columns,RowCount+1,TempStruct);
	dataInRows();
	delete []TempStruct;

	//Добавляем нумерацию профиля
	TDateTime tempDate;
	AnsiString formatDate;
	AnsiString formatDateSum;
	unsigned short year,month,day;
	unsigned short hour, minute, sec, msec;
  int ind=0; //VNB 29.09.2008

	fd->DateTime.DecodeDate( &year, &month, &day);
	switch(fd->StepProfile)
	{
	case TFormDescr::stpDay:
		day=1;
		stepProfile=1.0;
		formatDate="dd/mm";
		formatDateSum="mmmm";
		tempDate=TDateTime(year,month,day);
		break;
	case TFormDescr::stpMonth:
		day=1;
		month=1;
		stepProfile=31.0;
		formatDate="mmmm";
		formatDateSum="yyyy";
		tempDate=TDateTime(year,month,day);
		break;
	case TFormDescr::stpHour:
  hour=1;
    if(RowCount>24*(60/PowerProfile)) //25 час
    {
    stepProfile=1.0/(RowCount-60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(RowCount-60/PowerProfile);
    }
    else if(RowCount<24*(60/PowerProfile)) //23 час
    {
    stepProfile=1.0/(RowCount+60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(RowCount+60/PowerProfile);
    }
    else
    {
    stepProfile=1.0/RowCount;
    tempDate=TDateTime(year,month,day)+hour/(double)RowCount;
    }

		formatDate="t";
		formatDateSum="ddddd";

  	break;
	case TFormDescr::stpMinute:
		fd->DateTime.DecodeTime(&hour, &minute, &sec, &msec);
		stepProfile=StepPROFILE*1.157407407407e-5;
		formatDate="t";
		formatDateSum="'Итого'";
                //GRB COMMENT 11.07.2019 - баг с построением от произвольной минуты (0:30) -> (0:14:24+3 мин = 17 мин) при нажатии на точку в графике профиля
		tempDate=TDateTime(year,month,day)+hour/24.0+minute/1440.0+stepProfile;
                //END GRB COMMENT
                //GRB ADD
                //tempDate=TDateTime(year,month,day)+stepProfile;
                //END GRB ADD
		break;
	}
 ind=0;
	DrawTable->StaticStrings->Clear();
	//if(fd->SummGroup)
	  DrawTable->StaticStrings->Add(tempDate.FormatString(formatDateSum));
    ColumnsCaption->Add(tempDate.FormatString(formatDateSum));




	for( jColumns=1; jColumns<=RowCount ; ++jColumns )
	{
     DrawTable->StaticStrings->Add(tempDate.FormatString(formatDate));
     ColumnsCaption->Add(tempDate.FormatString(formatDate));

     tempDate+=stepProfile;

     tempDate.DecodeTime(&hour, &minute, &sec, &msec);


     //GRB ADD 11.07.2019
     if (fd->StepProfile == TFormDescr::stpMinute){
     if((IsShiftTimeZona)&&(IsDayShiftMonth(fd,10))&&!ind&&(hour==(4-TimeZona))
      && (minute==(StepPROFILE/60)))
       {
           ind=60/(StepPROFILE/60);   //25 час
           tempDate=tempDate-ind*stepProfile;
       }
     if((IsShiftTimeZona)&&(IsDayShiftMonth(fd,3))&&!ind&&(hour==(3-TimeZona))
      && (minute==(StepPROFILE/60)))
       {
           ind=60/(StepPROFILE/60);   //23 час
           tempDate=tempDate+ind*stepProfile;

       }
    }else{
     //END GRB ADD
     if((IsShiftTimeZona)&&RowCount>24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?5-TimeZona:4-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;   //25 час
           tempDate=tempDate-ind*stepProfile;

       }
     if((IsShiftTimeZona)&&RowCount<24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?4-TimeZona:3-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;   //23 час
           tempDate=tempDate+ind*stepProfile;

       }
    }
    }
	//Добавляем заголовки клонов
    VT_PrintData->First();
	if(fd->SummGroup)
	{
	    DrawTable->StaticStrings->Add(NamesClones->Strings[0]);
		if(columns>1)
            for( jColumns=0; jColumns<columns ; ++jColumns )
            {
                VT_PrintData->Edit();
                DrawTable->StaticStrings->Add(GetSubColumnsNames(jColumns));
                VT_PrintData->Fields->FieldByName("RowName")->AsString = NamesClones->Strings[0];
                VT_PrintData->Fields->FieldByName("SubRowName")->AsString = GetSubColumnsNames(jColumns);
                VT_PrintData->Next();
            }
        else
        {
            VT_PrintData->Edit();
            VT_PrintData->Fields->FieldByName("RowName")->AsString = NamesClones->Strings[0];
            VT_PrintData->Next();
        }
    }
	for( iClones=1; iClones<=Clones ; ++iClones )
	{
	    DrawTable->StaticStrings->Add(NamesClones->Strings[iClones]);
        //Добавляем заголовки колонок под клонами
		if(columns>1)
            for( jColumns=0; jColumns<columns ; ++jColumns )
            {
                VT_PrintData->Edit();
                DrawTable->StaticStrings->Add(GetSubColumnsNames(jColumns));
                VT_PrintData->Fields->FieldByName("RowName")->AsString = NamesClones->Strings[iClones];
                VT_PrintData->Fields->FieldByName("SubRowName")->AsString = GetSubColumnsNames(jColumns);
                VT_PrintData->Next();
            }
        else
        {
            VT_PrintData->Edit();
            VT_PrintData->Fields->FieldByName("RowName")->AsString = NamesClones->Strings[iClones];
            VT_PrintData->Next();
        }
    }

    //Формируем описание структуры для шапки всей таблицы опираясь
	//на количество клонов. Шапка занимает две строки.
	DrawTable->TabStrings->Clear();
    AnsiString temp;
	if(columns>1)
	    temp="c15 m0x09  0x180b # m0x09  0x180e";
    else
	    temp="c15 m0x09  0x180f";
    //if(fd->SummGroup)
	temp+="# t2 b $m0x05  0x100f";
    for( jColumns=1; jColumns<=RowCount ; ++jColumns )
	    temp+="# t8 b- $m0x05  0x100f";

	DrawTable->TabStrings->Add(temp);

    iClones=1;
	if(fd->SummGroup)
	{
	    iClones++;
        if(columns>1)
    	    temp=" t2 b $m0x05  0x1007# t8 b- $m0x09  0x100f#c28 t42 &m0x01  0x800e";
	    else
		    temp=" t2 b $m0x05  0x100f# b- c28 t42 &m0x01  0x800c";
        for( i=1; i<=RowCount ; ++i )
            if(columns>1)
		        temp+="#c36 t8 &m0x01  0x800e";
            else
                temp+="#c36 t8 &m0x01  0x800c";
        DrawTable->TabStrings->Add(temp);

		if(columns>1)
        {
	        for( jColumns=3; jColumns<=columns ; ++jColumns )
            {
                temp="c15 ^m0x05  0x1005# $m0x09  0x100f#c28 t42 b- &m0x01  0x800c";
                for( i=1; i<=RowCount ; ++i )
				    temp+="#c36 t8 &";
                DrawTable->TabStrings->Add(temp);
            }

			temp="c15 ^m0x05  0x100d# $m0x09  0x100f#c28 t42 b- &m0x01  0x800c";
			for( i=1; i<=RowCount ; ++i )
			    temp+="#c36 t8 &";
            DrawTable->TabStrings->Add(temp);
        }
    }
	for( ; iClones<=clones ; ++iClones )
	{
	    if(columns>1)
		{
		    temp="c15 $m0x05  0x1007# $m0x09  0x100f";
			//if(fd->SummGroup)
			temp+="#c36 &m0x01  0x800e";
			for( i=1; i<=RowCount ; ++i )
			    temp+="#c5 &m0x01  0x800e";
        }
		else
		{
		    temp="c15 $m0x05  0x100f";
            //if(fd->SummGroup)
			temp+="#c36 &m0x01  0x800c";
            for( i=1; i<=RowCount ; ++i )
		        temp+="#c5 &m0x01  0x800c";
        }
		DrawTable->TabStrings->Add(temp);

		if( columns>1)
		{
		    for( jColumns=3; jColumns<=columns ; ++jColumns )
            {
	            temp="c15 ^m0x05  0x1005# $m0x09  0x100f";
		        //if(fd->SummGroup)
                temp+="#c36 &m0x01  0x800c";
	     		for( i=1; i<=RowCount ; ++i )
		      	    temp+="#c5 &m0x01  0x800c";
                DrawTable->TabStrings->Add(temp);
            }

            temp="c15 ^m0x05  0x100d# $m0x09  0x100f";
            //if(fd->SummGroup)
	     	temp+="#c36 &m0x01  0x800c";
            for( i=1; i<=RowCount ; ++i )
		  	    temp+="#c5 &m0x01  0x800c";
            DrawTable->TabStrings->Add(temp);
        }
    }
    DrawTable->UpdateTabStrings();
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::DrawTableMouseDown(TObject *Sender,
	TMouseButton Button, TShiftState Shift, int X, int Y)
{
#define Sender ((TDrawTable*)Sender)
	TDrawTable::SAttrCell * pAtrCell;
	int ACol, ARow;
	TShiftState leftShift;
	TShiftState rightShift;
	leftShift<<ssLeft;
	rightShift<<ssRight;
  TShiftState ShiftShift;     //Shift + кнопка мыши для расчетных точек
  ShiftShift<<ssShift;


	if( (Button==mbLeft && Shift==leftShift )||//нажата только левая кнопка мыши
		(Button==mbRight && Shift==rightShift) )    //нажата только правая кнопка мыши
 //   ( Button==mbRight && Shift==ShiftShift+rightShift))
		;
	else
	{
		if( ClonePressed )
		{
			((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->
				MarginEdge=EDGE_RAISED;
			Sender->InvalidCell( ColPressed, RowPressed );
			ClonePressed=false;
		}
		ShiftPressed= TShiftState();
		return;
	}

	ShiftPressed=Shift;

	Sender->MouseToCell( X, Y, ACol, ARow );
	if( ACol==-1 || ARow==-1 )
	{
		ShiftPressed= TShiftState();
		return;
	}
	pAtrCell=(TDrawTable::SAttrCell *)Sender->GetParentCellAttr( ACol, ARow );
	if( pAtrCell->styleCell==TDrawTable::SAttrCell::cellStatic && pAtrCell->MarginEdge==EDGE_RAISED )
	{
		ClonePressed=true;
		pAtrCell=(TDrawTable::SAttrCell *)Sender->GetCellAttr( ACol, ARow );
		ColPressed=ACol;
		RowPressed=ARow;
		if( pAtrCell->styleCell!=TDrawTable::SAttrCell::cellStatic )
		{
			ColPressed-=LOWORD(pAtrCell->IndexData);
			RowPressed-=HIWORD(pAtrCell->IndexData);
		}
		((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge=EDGE_SUNKEN;
		Sender->InvalidCell( ColPressed, RowPressed );
	}
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::DrawTableMouseMove(TObject *Sender,
	TShiftState Shift, int X, int Y)
{
#define Sender ((TDrawTable*)Sender)
	TDrawTable::SAttrCell * pAtrCell;
	int ACol, ARow;
	TDrawTable::SAttrCell tempAttr;
	if( ClonePressed==false )
		return;
	Sender->MouseToCell( X, Y, ACol, ARow );
	if( ACol==-1 || ARow==-1 )
		pAtrCell=&tempAttr;
	else
		pAtrCell=(TDrawTable::SAttrCell *)Sender->GetParentCellAttr( ACol, ARow );
	if( pAtrCell->styleCell==TDrawTable::SAttrCell::cellStatic )
	{
		pAtrCell=(TDrawTable::SAttrCell *)Sender->GetCellAttr( ACol, ARow );
		if( pAtrCell->styleCell!=TDrawTable::SAttrCell::cellStatic )
		{
			ACol-=LOWORD(pAtrCell->IndexData);
			ARow-=HIWORD(pAtrCell->IndexData);
		}
		if( ACol!=ColPressed || ARow!=RowPressed )
		{
		if(((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge!=EDGE_RAISED)
		{
			((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge=EDGE_RAISED;
			Sender->InvalidCell( ColPressed, RowPressed );
		}
		}
		else
		{
		if(((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge!=EDGE_SUNKEN)
		{
			((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge=EDGE_SUNKEN;
			Sender->InvalidCell( ColPressed, RowPressed );
		}
		}
	}
	else
		if(((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge!=EDGE_RAISED)
		{
			((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge=EDGE_RAISED;
			Sender->InvalidCell( ColPressed, RowPressed );
		}
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::DrawTableMouseUp(TObject *Sender,
	TMouseButton Button, TShiftState Shift, int X, int Y)
{
#define Sender ((TDrawTable*)Sender)
	TDrawTable::SAttrCell * pAtrCell;
	int ACol, ARow;

	if( ShiftPressed == TShiftState() )
		return;

	Sender->MouseToCell( X, Y, ACol, ARow );
	if( ACol==-1 || ARow==-1 )
	{
		ShiftPressed= TShiftState();
		ClonePressed=false;
		return;
	}
	if( ClonePressed )
	{
    	pAtrCell=(TDrawTable::SAttrCell *)Sender->GetParentCellAttr( ACol, ARow );
	    if( pAtrCell->styleCell==TDrawTable::SAttrCell::cellStatic )
    	{
	    	pAtrCell=(TDrawTable::SAttrCell *)Sender->GetCellAttr( ACol, ARow );
		    if( pAtrCell->styleCell!=TDrawTable::SAttrCell::cellStatic )
    		{
	    		ACol-=LOWORD(pAtrCell->IndexData);
		    	ARow-=HIWORD(pAtrCell->IndexData);
    		}
	    	((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge=EDGE_RAISED;
    		Sender->InvalidCell( ColPressed, RowPressed );
	    	if( ACol==ColPressed && ARow==RowPressed )
		    {
			    //Произошел щелчок по разложению профиля или клона
    			if( !fd->VerticalSplit )
	    		{
		    		ColPressed=ARow;
			    	RowPressed=ACol;
    			}
	    		if( ShiftPressed == ( TShiftState()<<ssLeft ))
		    		//Построение профиля или распределения
			    	clickGraphics(ColPressed, RowPressed );
    			else

	    			//Композиция или декомпозиция
		    		clickComposition(ColPressed, RowPressed );

    		}
	    }
    	ClonePressed=false;
	}
	else//Если клон не нажимался
		if( ShiftPressed == ( TShiftState()<<ssRight ) && Sender->PopupMenu )
	{
	    POINT p;
		p.x=X;
		p.y=Y;
		p=Sender->ClientToScreen(p);
		Sender->FocusCell( ACol, ARow );
		Sender->PopupMenu->Popup(p.x,p.y);
    }
	ShiftPressed =TShiftState();
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::clickComposition(long ColPressed, long RowPressed )
{
  if(ColPressed==0){//разложение по профилю
    if( DrawTable )
      fd->TableTopRow = DrawTable->TopRow;
    //Настройки нам еще понадобятся
    fd->IsMemParActualForClones = TRUE;
		TDateTime tempDate;
		unsigned short year,month,day;
		fd->DateTime.DecodeDate( &year, &month, &day);
		if(SubColumns()==1)
			RowPressed++;
		//if( fd->SummGroup )
    RowPressed--;
		if(RowPressed>=2){//Декомпозиция по профилю
		  switch(fd->StepProfile){
        case TFormDescr::stpMonth:
  		    if(fd->EnableControls.Contains(TFormDescr::ctrlDay)){
    				fd->DateTime=TDateTime(year,(unsigned short)(RowPressed-1),1);
		    		fd->StepProfile=TFormDescr::stpDay;
				    refreshForm();
  			  }
			    break;
        case TFormDescr::stpDay:
		      if(fd->EnableControls.Contains(TFormDescr::ctrlHour)){
    				fd->DateTime=TDateTime(year,month,1)+(unsigned short)(RowPressed-2);
		    		fd->StepProfile=TFormDescr::stpHour;
				    refreshForm();
    			}
		    	break;
        case TFormDescr::stpHour:
		      if(fd->EnableControls.Contains(TFormDescr::ctrlMinute)){
                                //GRB ADD TEST 25.07.2019 - Не даём проваливаться ниже 15 минуток в 3-5 минутки из
                                break;
    				/*fd->DateTime=TDateTime(year,month,day)+(RowPressed-2)/(double)RowCount;
		    		fd->StepProfile=TFormDescr::stpMinute;
				    refreshForm(); */
    			}
		  	  break;
        case TFormDescr::stpMinute:
    			break;
		  }
		}else{//Композиция по профилю
  		switch(fd->StepProfile){
    		case TFormDescr::stpMonth:
		    	break;
    		case TFormDescr::stpDay:
			    if(fd->EnableControls.Contains(TFormDescr::ctrlMonth)){
    				fd->DateTime=TDateTime(year,1,1);
		    		fd->StepProfile=TFormDescr::stpMonth;
				    refreshForm();
    			}
		    	break;
    		case TFormDescr::stpHour:
		    	if(fd->EnableControls.Contains(TFormDescr::ctrlDay)){
    				fd->DateTime=TDateTime(year,month,1);
		    		fd->StepProfile=TFormDescr::stpDay;
				    refreshForm();
    			}
		    	break;
    		case TFormDescr::stpMinute:
		    	if(fd->EnableControls.Contains(TFormDescr::ctrlHour)){
    				fd->DateTime=TDateTime(year,month,day);
		    		fd->StepProfile=TFormDescr::stpHour;
				    refreshForm();
    			}
		    	break;
  		}
    }
    if(fd->StepProfile==TFormDescr::stpHour)
      ((TBaseMonitorForm*)Owner)->miFormula->Visible=true;
    else
      ((TBaseMonitorForm*)Owner)->miFormula->Visible=false;
  }//end if(ColPressed==0)
	if( RowPressed==0 && fd->EnableControls.Contains(TFormDescr::ctrlGroup)){
  	//Разложение по клонам
    /* if(fd->CodeTemplate==203||fd->CodeTemplate==204||fd->CodeTemplate==205||fd->CodeTemplate==206
       ||fd->CodeTemplate==303||fd->CodeTemplate==304||fd->CodeTemplate==305)
       return;  */
	  long IdGroup,j;

    if( DrawTable )
      fd->TableLeftCol = DrawTable->LeftCol;
    //Настройки нам еще понадобятся
    fd->IsMemParActualForProf = TRUE;

    ColPressed=(ColPressed-1)/SubColumns();
    if( !fd->SummGroup )
      ColPressed++;
    IdGroup=0;
    if(ColPressed==0){
      if(fd->IdGroup==fd->IdGroupJump){ //*********Для списков
        fd->IdGroup = fd->IdGroupList; // Перешли на предприятие
        fd->IdGroupJump = 0;
        fd->IdGroupList = 0;
      }
      if(fd->IdGroup==fd->CeilingIdGroup)
        return;
      dmMain->qwInter->Params->Clear();
      dmMain->qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.Interior_clickComp1_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7); end;";
      dmMain->qwInter->ParamByName("par7")->ParamType=ptOutput;
      dmMain->qwInter->ParamByName("par7")->DataType=ftCursor;

      dmMain->qwInter->ParamByName("par1")->AsInteger=(fd->IsPoints)?1:0;
      dmMain->qwInter->ParamByName("par2")->AsInteger=fd->StepProfile;
      dmMain->qwInter->ParamByName("par3")->AsInteger=fd->IdGroup;
      dmMain->qwInter->ParamByName("par4")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
      dmMain->qwInter->ParamByName("par5")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
      dmMain->qwInter->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);
      dmMain->qwInter->Execute();
      IdGroup=dmMain->qwInter->FieldByName("IdGroup")->AsInteger;
      dmMain->qwInter->Close();
    }else
      try{
      IdGroup=(long)NamesClones->Objects[ColPressed];
      }catch (EStringListError &esle){
        return;
      }
    //***************** Для списков *********************************************************************************
    IdGroup = GroupJump(IdGroup);
    if(!IdGroup)
      return;
    //*************************************************************************************************************
    if( IdGroup==0 || IdGroup==fd->IdGroup )
      return;
    dmMain->qwInter->Params->Clear();
    dmMain->qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.Interior_clickComp2_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7); end;";
    dmMain->qwInter->ParamByName("par7")->ParamType=ptOutput;
    dmMain->qwInter->ParamByName("par7")->DataType=ftCursor;

    dmMain->qwInter->ParamByName("par1")->AsInteger=(fd->IsPoints)?1:0;
    dmMain->qwInter->ParamByName("par2")->AsInteger=fd->StepProfile;
    dmMain->qwInter->ParamByName("par3")->AsInteger=IdGroup;
    dmMain->qwInter->ParamByName("par4")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
    dmMain->qwInter->ParamByName("par5")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
    dmMain->qwInter->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);

    dmMain->qwInter->Execute();
    if( !dmMain->qwInter->Eof ){
        // Вставка
        fd->strGroup(dmMain->qwInter->FieldByName("Name")->AsString.c_str());
		    fd->NameGroup=dmMain->qwInter->FieldByName("Name")->AsString;
    		fd->ShortNameGroup=dmMain->qwInter->FieldByName("ShortName")->AsString;
	    	fd->IdGroup=IdGroup;
        fd->SummGroup=(dmMain->qwInter->FieldByName("GROUP_TOTAL")->AsString=="y");
        dmMain->qwInter->Close();
        refreshForm();
    }else
      dmMain->qwInter->Close();
	}//end if( RowPressed==0 && fd->EnableControls.Contains(TFormDescr::ctrlGroup)){
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::clickGraphics(long ColPressed, long RowPressed )
{
    if(ColPressed==0)//разложение по группам
	{
		if(SubColumns()>1)
	        RowPressed--;
		//if( fd->SummGroup )
        ChartFXColumns(RowPressed-1);
		//else
		//	ChartFXColumns(RowPressed);
	}
	if(RowPressed==0)//построение профиля
	{
        pChart->AxisVisible = true;
        if(pSecondChart)
          pSecondChart->AxisVisible = true;
        fPlace=false;
        if( fd->SummGroup )
            ChartFXLines((ColPressed-1)/SubColumns());
        else
            ChartFXLines((ColPressed-1)/SubColumns()+1);
    }
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::ChartFXLinesClick(TObject *Sender)
{
    long ACol,ARow;
    //GRB ADD 27.11.2020 - Для диаграммы с новым качеством электроэнергии
    if (!DrawTable) return;
    //END ADD
	if( fd->VerticalSplit )
	{
	    ACol=DrawTable->Col;
		ARow=DrawTable->Row;
    }
	else
	{
	    ARow=DrawTable->Col;
		ACol=DrawTable->Row;
    }
	ACol-=(ACol-1)%SubColumns();
	if( ((TMenuItem*)Sender)->Tag & 0x01 )
	    ACol=0;
    else
	    ARow=0;
  if( ((TMenuItem*)Sender)->Tag & 0x02)
     ShowDetailPoint(ACol, ARow);
  else{
    if( ((TMenuItem*)Sender)->Tag & 0xf0 )
	    clickComposition(ACol, ARow );
    else
	    clickGraphics(ACol, ARow );
     }

}
//---------------------------------------------------------------------------
 void __fastcall T2xDrawTableChartInterior::ShowDetailPoint(long ColPressed, long RowPressed )
{
  int  aIdGroup;
  if(ColPressed==0)
    return;
  if( RowPressed==0 && fd->EnableControls.Contains(TFormDescr::ctrlGroup)){
    ColPressed=(ColPressed-1)/SubColumns();
    if( !fd->SummGroup )
      ColPressed++;

    aIdGroup=(long)NamesClones->Objects[ColPressed];
    dmMain->qwInter->SQL->Text="begin :test:="+SchemeName+"DETAILPOINT_PG.test_points(:idgroup,:ispoints);end;";
    dmMain->qwInter->ParamByName("test")->ParamType=ptOutput;
    dmMain->qwInter->ParamByName("test")->DataType=ftInteger;
    dmMain->qwInter->ParamByName("idgroup")->AsInteger=aIdGroup;
    dmMain->qwInter->ParamByName("ispoints")->AsInteger=(fd->IsPoints)?1:0;
    dmMain->qwInter->Execute();
    int kk=dmMain->qwInter->ParamByName("test")->AsInteger;
    dmMain->qwInter->Close();
    if(!kk)
      return;
    //PROCEDURE test_points(an_idgroup NUMBER,an_ispoints NUMBER,an_test OUT NUMBER)
   // TfmDetailPoint*Dp= new TfmDetailPoint(Owner,fd,aIdGroup);
    Dp->SetFormDesc(fd,aIdGroup,kk);
    Dp->Show();
  }
}
//---------------------------------------------------------------------------------------
/*
	Отображение всплывающего контекстного меню
*/
void __fastcall T2xDrawTableChartInterior::PopupMenuBaseFormPopup(TObject *Sender)
{
	if( dynamic_cast<TBaseMonitorForm*>(Owner) )
	{
		TBaseMonitorForm* pOwner=dynamic_cast<TBaseMonitorForm*>(Owner);
		//предполагаем что все операции из меню доступны
		pOwner->SmallFont->Checked=!pOwner->isSmallFont;
		pOwner->SmallFont2->Checked=!pOwner->isSmallFont;
		pOwner->View->Enabled=true;
		pOwner->ChartFXColumns->Enabled=true;
		pOwner->ChartFXLines->Enabled=true;
		pOwner->ByGroup->Enabled=true;
		pOwner->ByProfile->Enabled=true;

    //доступ к пункту меню "Достоверность" в зависимости от настроек и метки качества
    SV = 0;
    TRegistry *pReg=new TRegistry;
	  pReg->RootKey=HKEY_CURRENT_USER;
	  if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", true) )
	  {
		  try
		  {
         SV = pReg->ValueExists("ShowManual")?pReg->ReadInteger("ShowManual"):0;
      }
      catch(Exception &e)
		  {
			  pReg->CloseKey();
			  delete pReg;
			  throw;
		  }
    }
    else
		 throw Exception(AnsiString(Reconst_smes129_3));

	  pReg->CloseKey();
	  delete pReg;

    if (SV == 2)
    {
      char s[32];
      int ACol=DrawTable->Col;
		  int ARow=DrawTable->Row;
      int ARowCount=DrawTable->RowCount;
      int AColCount=DrawTable->ColCount;
      int col=(SubColumns()>1)? 1:0;

      //datOracle[(DrawTable->Row-1-col)*(DrawTable->ColCount-1)+DrawTable->Col-1].isvalid)

      if( fd->VerticalSplit )
		  {
       if(fd->SummGroup)strcpy(s,datOracle[(ARow-1-col)*(AColCount-1)+ACol-1].isvalid);
       else strcpy(s,datOracle[(ARow-1-col)*(AColCount-1)+ACol-1+(AColCount-1)].isvalid);
		  }
		  else
		  {
	 	    if(fd->SummGroup)strcpy(s,datOracle[(ACol-1-col)*(ARowCount-1)+ARow-1].isvalid);
        else strcpy(s,datOracle[(ACol-1-col)*(ARowCount-1)+ARow-1+(ARowCount-1)].isvalid);
		  }

    //strcpy(s, "01011111111111111111111111");
    pOwner->IsValid->Caption = "Качество электроэнергии";
    if (s[0]!='\0')
      pOwner->IsValid->Enabled = StrToInt(s[1])+StrToInt(s[2]);
    else pOwner->IsValid->Enabled = false;
    }
    else if (SV == 1)
    {
      pOwner->IsValid->Caption = "Достоверность";
      pOwner->IsValid->Enabled = true;
    }
    else
    {
      pOwner->IsValid->Caption = "Достоверность";
      pOwner->IsValid->Enabled = false;
    }

		long ACol,ARow,tmp;
		TDrawTable::SAttrCell *pCellGroup,*pCellProfile;

		ACol=DrawTable->Col;
		ARow=DrawTable->Row;
		//находим атрибуты ячеек для заголовка клона и заголовка профиля
		//а затем вычисляем номер клона и номер профиля
		if( fd->VerticalSplit )
		{
			ACol-=(ACol-1)%SubColumns();
			pCellGroup=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(ACol,0);
			pCellProfile=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(0,ARow);
		}
		else
		{
			ARow-=(ARow-1)%SubColumns();
			pCellProfile=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(ACol,0);
			pCellGroup=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(0,ARow);
			tmp=ACol;
			ACol=ARow;
			ARow=tmp;
		}
		ACol=(ACol-1)/SubColumns();
		--ARow;
		if( SubColumns()>1 )
			--ARow;
		if( !fd->SummGroup )
			++ACol;

		pOwner->ChartFXColumns->Caption=AnsiString(Reconst_smes105_5)+pCellProfile->SourceData->Strings[pCellProfile->IndexData];
		pOwner->ChartFXLines->Caption=AnsiString(Reconst_smes105_6)+pCellGroup->SourceData->Strings[pCellGroup->IndexData];

		if(ARow)
		{
			pOwner->ByProfile->Caption=AnsiString(Reconst_smes105_7)+pCellProfile->SourceData->Strings[pCellProfile->IndexData];
			switch( fd->StepProfile )
			{
				case TFormDescr::stpMonth:
					if( !fd->EnableControls.Contains(TFormDescr::ctrlDay) )
						pOwner->ByProfile->Enabled=false;
					break;
				case TFormDescr::stpDay:
					if( !fd->EnableControls.Contains(TFormDescr::ctrlHour) )
						pOwner->ByProfile->Enabled=false;
					break;
				case TFormDescr::stpHour:
					if( !fd->EnableControls.Contains(TFormDescr::ctrlMinute) )
						pOwner->ByProfile->Enabled=false;
					break;
				case TFormDescr::stpMinute:
					pOwner->ByProfile->Enabled=false;
					break;
			}
		}
		else
		{
			pOwner->ByProfile->Caption=AnsiString(Reconst_smes105_8)+pCellProfile->SourceData->Strings[pCellProfile->IndexData];
			switch( fd->StepProfile )
			{
				case TFormDescr::stpMonth:
					pOwner->ByProfile->Enabled=false;
					break;
				case TFormDescr::stpDay:
					if( !fd->EnableControls.Contains(TFormDescr::ctrlMonth) )
						pOwner->ByProfile->Enabled=false;
					break;
				case TFormDescr::stpHour:
					if( !fd->EnableControls.Contains(TFormDescr::ctrlDay) )
						pOwner->ByProfile->Enabled=false;
					break;
				case TFormDescr::stpMinute:
					if( !fd->EnableControls.Contains(TFormDescr::ctrlHour) )
						pOwner->ByProfile->Enabled=false;
					break;
			}
		}

		if(ACol)
			pOwner->ByGroup->Caption=AnsiString(Reconst_smes105_9)+pCellGroup->SourceData->Strings[pCellGroup->IndexData];
		else
			pOwner->ByGroup->Caption=AnsiString(Reconst_smes105_10)+pCellGroup->SourceData->Strings[pCellGroup->IndexData];
		if( !fd->EnableControls.Contains(TFormDescr::ctrlGroup) )
			pOwner->ByGroup->Enabled=false;

	}
}
//---------------------------------------------------------------------------
long __fastcall T2xDrawTableChartInterior::SubColumns(void)
{
	return 2;
}
//---------------------------------------------------------------------------

AnsiString __fastcall T2xDrawTableChartInterior::GetSubColumnsNames(int n)
{
static AnsiString staticNameColumns[]={Reconst_smes105_11,Reconst_smes105_12,Reconst_smes105_13,Reconst_smes105_14};
	return staticNameColumns[n];
}
//---------------------------------------------------------------------------
//chig
bool T2xDrawTableChartInterior::IsColorAssigned( int PPInd )
{
  bool prRes = FALSE;
  for ( int i = 0; i < MAXGRAFICPICTURE; i++ )
    if ( PPInd == fd->ColorAttr[ i ].PointId )
    {
      prRes = TRUE;
      break;
    }
  return prRes;
}
//---------------------------------------------------------------------------
void T2xDrawTableChartInterior::AssignColor( int PPInd )
{
  for ( int i = 0; i < MAXGRAFICPICTURE; i++ )
    if ( -1 == fd->ColorAttr[ i ].PointId )
    {
      fd->ColorAttr[ i ].PointId = PPInd;
      break;
    }
}
//---------------------------------------------------------------------------
TColor T2xDrawTableChartInterior::ColorByClonId( int PPInd )
{
  TColor prCol = clBlue;
  for ( int i = 0; i < MAXGRAFICPICTURE; i++ )
    if ( PPInd == fd->ColorAttr[ i ].PointId )
    {
      prCol = fd->ColorAttr[ i ].Color;
      break;
    }
  return prCol;
}
//e chig
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::ChartFXLines(long AClone)
{
    const CntPROFILE = LenPROFILE/StepPROFILE+100;
    int i,j,k,MaxRowCount;
    AnsiString Str, LabelDateFormat;
    TDateTime *fDate = NULL;
    TLineSeries *pSeries[AMOUNTSERIES];
    bool fCode;
    int ColGraf;

  //  int gtz=TimeZona;


    try{
        fDate = new TDateTime[CntPROFILE];
        if(SubColumns()==1)
        {
            fCode=true;
            // Условия выбора
            if(!fPlace){
                ColGraf=0;
                for(i=0; i<Clones+1; i++){
                    if(i==AClone)
                        fNumClones[i] = !fNumClones[i];
                    if(fNumClones[i])
                        ColGraf+=1;
                }
                if(ColGraf > MAXGRAFICPICTURE)  // не показывать больше
                    fNumClones[AClone]=0;
                if(ColGraf==0)                  // не показывать ноль графиков
                    fNumClones[AClone]=1;
            }else if(Clones > 5)
                ColGraf=MAXGRAFICPICTURE;
        }else{
            fCode=false;
            ColGraf=SubColumns();
        }
        // наличие легенды
        if(ColGraf>1){
          if(pSecondChart){
            pChart->Legend->Visible=true;
            pChart->Legend->LegendStyle=lsSeries;
            pChart->Legend->TopPos=20;
            pSecondChart->Legend->Visible=true;
            pSecondChart->Legend->LegendStyle=lsSeries;
            pSecondChart->Legend->TopPos=20;
          }else{
            pChart->Legend->Visible=true;
            pChart->Legend->LegendStyle=lsSeries;
            pChart->Legend->TopPos=40;
          }
        }else{
            pChart->Legend->Visible=false;
            if(pSecondChart)
              pSecondChart->Legend->Visible = true;
        }

        pChart->AllowZoom = true;
        pChart->AllowPanning = pmBoth;
        pChart->ClipPoints = true;

        if(pSecondChart){
          pSecondChart->AllowZoom = true;
          pSecondChart->AllowPanning = pmBoth;
          pSecondChart->ClipPoints = true;
        }

        k=ColGraf;
        if(fCode) ColGraf=Clones+1;
        if(pSecondChart)  ColGraf-- ;
        //chig формирование таблицы цветов
        if(fCode)
        {
            //Освобождаем незанятые цвета
            for(int i=0; i<MAXGRAFICPICTURE; i++)
            {
                int prClonInd = fd->ColorAttr[i].PointId;
                bool prIsStillUsed = FALSE;
                if (-1 != prClonInd)
                {
                    //Если клон назначен
                    //e
                    int prSelectedCount = 0;
                    for( int j=0; j<Clones+1; ++j)
                        if( fNumClones[j] )
                        {
                            //Клон отобр-ся
                            //e
                            if ( j == prClonInd )
                                prIsStillUsed = TRUE;
                            prSelectedCount++;
                            if ( prSelectedCount >= MAXGRAFICPICTURE )
                                break;
                        }
                }//был назначен
                if ( !prIsStillUsed )
                    //Теперь уже не назначен
                    //e
                    fd->ColorAttr[ i ].PointId = -1;
            }
            //e Освобождаем незанятые цвета
            //Назначаем незанятые цвета
            int prSelectedCount = 0;
            for(i=0; i<Clones+1; ++i)
            {
                if( fNumClones[i] )
                {
                    if ( !IsColorAssigned( i ) )
                        AssignColor( i );
                    prSelectedCount++;
                    if ( prSelectedCount >= MAXGRAFICPICTURE )
                        break;
                }
            }
        }
        //e chig формирование цветов

        while(pChart->SeriesCount()>0)
            pChart->Series[0]->Free();

        while(pSecondChart&&pSecondChart->SeriesCount()>0)
              pSecondChart->Series[0]->Free();

        for(i=0,j=0; i<ColGraf; ++i){
          if(pSecondChart && FormSetupMonitors->kindOfADddBalanceDiag == 2 && i == 2) i++;
            if(fCode){
                if(fNumClones[i])
                    Str=NamesClones->Strings[i];
                else
                    continue;
            }else
                // added by KAG
                if ((fd->CodeTemplate==NOT_BALANCE && i<3)||(fd->CodeTemplate==NOT_BALANCE_AER &&i<3))
                  Str=GetSubColumnsNames(i+1);
                else
                //e KAG
                  Str=GetSubColumnsNames(i);
            if(pSecondChart&&(j>1)){
               pSeries[j]=new TLineSeries(pSecondChart);
               pSeries[j]->ParentChart=pSecondChart;
            }else{
               pSeries[j]=new TLineSeries(pChart);
               pSeries[j]->ParentChart=pChart;
            }
            pSeries[j]->Pointer->Visible = FormSetupMonitors->cbPoints->Checked;
            pSeries[j]->Pointer->Style = psCircle;
            pSeries[j]->Pointer->HorizSize = 3;
            pSeries[j]->Pointer->VertSize = 3;
            pSeries[j]->Marks->Visible = FormSetupMonitors->cbMarks->Checked;
            pSeries[j]->Marks->Clip = true;
            pSeries[j]->XValues->Order=loNone;
            pSeries[j]->YValues->Order=loDescending;
            pSeries[j]->Marks->Style=smsValue;
            pSeries[j]->LinePen->Width=2;
            pSeries[j]->XValues->DateTime=false;//true;
            pSeries[j]->Title=Str;
            //chig
            if(fCode)
            {
                if ( j < MAXGRAFICPICTURE )
                {
                    pSeries[j]->ColorEachPoint = FALSE;
                    pSeries[j]->SeriesColor = ColorByClonId( i );
                }
            }
            //e chig
            j++;
        }
        if(fCode){
            if(k > 1)
                Str=fd->NameGroup;
        }else
            Str=NamesClones->Strings[AClone];
        //pChart->Title->Text->Text=Str;    //     [CHART_TOPTIT]

        MaxRowCount=RowCount;
        unsigned short year,month,day;
        unsigned short hour, minute, sec, msec;
        unsigned short curr_year,curr_month,curr_day;
        unsigned short curr_hour, curr_min, curr_sec, curr_msec;
        double StepRow;
        int ind=0;
        TDateTime tmpDateTime;
        fd->DateTime.DecodeDate( &year, &month, &day);

        TDateTime::CurrentDate().DecodeDate( &curr_year, &curr_month, &curr_day);
        TDateTime::CurrentTime().DecodeTime( &curr_hour, &curr_min, &curr_sec, &curr_msec);

        switch(fd->StepProfile){
        case TFormDescr::stpMonth:
            Str = Str+" "+fd->DateTime.FormatString("yyyy")+" г.";
            LabelDateFormat = "mmm";
            for( j=1; j<=MaxRowCount ; ++j ){
                tmpDateTime=TDateTime(year,(unsigned short)j,1);
                fDate[j-1]=tmpDateTime;//.operator double();
            }
            break;
        case TFormDescr::stpDay:
            Str = Str+" "+fd->DateTime.FormatString("yyyy")+" г.";
            LabelDateFormat = "dd/mm";
            tmpDateTime=TDateTime(year,month,1);
            for( j=0; j<=MaxRowCount ; ++j ){
                fDate[j]=tmpDateTime;//.operator double();
                tmpDateTime+=(unsigned short)1;
            }
            break;
        case TFormDescr::stpHour:
            Str = Str+" "+fd->DateTime.FormatString("ddddd");
            LabelDateFormat = "t";
            tmpDateTime=TDateTime(year,month,day);
//            for( j=0; j<=RowCount && tmpDateTime<=TDateTime::CurrentDateTime() ; ++j ){
              if(RowCount>24*(60/PowerProfile))  StepRow=1.0/(RowCount-60/PowerProfile); //25 час
              else if(RowCount<24*(60/PowerProfile))  StepRow=1.0/(RowCount+60/PowerProfile); //23 час
              else   StepRow=1.0/RowCount;
              ind=0;


            for( j=0; j<=RowCount  ; ++j ){

                tmpDateTime+=StepRow;
              tmpDateTime.DecodeTime(&hour, &minute, &sec, &msec);

           if((IsShiftTimeZona)&&RowCount>24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?5-TimeZona:4-TimeZona)
            && minute==(PowerProfile==60?0:PowerProfile)))


               {
               ind=60/PowerProfile;
               tmpDateTime=tmpDateTime-ind*StepRow;

               }
             if((IsShiftTimeZona)&&RowCount<24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?4-TimeZona:3-TimeZona)
            && minute==(PowerProfile==60?0:PowerProfile)))

               {
               ind=60/PowerProfile;
               tmpDateTime=tmpDateTime+ind*StepRow;

               }


                fDate[j]=tmpDateTime;//temp;//-floor(temp);
            }
            MaxRowCount=j-1;
            break;
        case TFormDescr::stpMinute:
            Str = Str+" "+fd->DateTime.FormatString("ddddd");
            LabelDateFormat = "t";
            fd->DateTime.DecodeTime(&hour, &minute, &sec, &msec);
            tmpDateTime=TDateTime(year,month,day)+hour/24.0+minute/1440.0;
//            for( j=0; j<=RowCount && tmpDateTime<=TDateTime::CurrentDateTime(); ++j ){
            for( j=0; j<=RowCount  ; ++j ){
                tmpDateTime+=StepPROFILE* 1.157407407407e-5;
                fDate[j]=tmpDateTime;//temp-floor(temp);
            }
            MaxRowCount=j-1;
            break;
        }
        pChart->Title->Text->Text=Str;
        if(MaxRowCount<0)
            MaxRowCount=0;
        if(pSecondChart)
          ScaleOfTwoGraph(fCode, MaxRowCount, AClone, pSeries, fDate, LabelDateFormat);
        else
          ScaleOfGraph(fCode, ColGraf, MaxRowCount, AClone, pSeries, fDate, LabelDateFormat);
        if(fDate) delete []fDate;
    }catch(Exception&e){
        if(fDate) delete []fDate;
        throw e;
    }
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::IncreaseScaleValue( double & PPYMinVal, double & PPYMaxVal )
{
     //Только для profile
   if( TFormDescr::stpMinute == fd->StepProfile )
     //e
   {
     if
     (
       ( PPYMaxVal > 0 )
       &&
       ( PPYMaxVal < 1 )
     )
       PPYMaxVal = INCREASE_SCALE_VALUE;
     if
     (
       ( PPYMinVal < 0 )
       &&
       ( PPYMinVal > -1 )
     )
       PPYMinVal = -INCREASE_SCALE_VALUE;
   }
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::ChartFXColumns(long ARow)
{
    int i,j;
    TCloneItem *ptrDatOracle;
    AnsiString Str;
    TChartSeries *pSeries[AMOUNTSERIES];
    int razm = 40;
    int dgtype=FormSetupMonitors->rgDiagramType->ItemIndex;
    // наличие легенды
    if(SubColumns()>1){
        if(pSecondChart){
           razm = 20;
           pSecondChart->Legend->Visible=true;
           pSecondChart->Legend->LegendStyle=lsSeries;
           pSecondChart->Legend->TopPos=razm;
        }
        pChart->Legend->Visible=true;
        pChart->Legend->LegendStyle=lsSeries;
        pChart->Legend->TopPos=razm;
    }else{
        pChart->Legend->Visible=false;
        if(pSecondChart)
          pSecondChart->Legend->Visible=false;
    }
    while(pChart->SeriesCount()>0)
        pChart->Series[0]->Free();
    while(pSecondChart && pSecondChart->SeriesCount()>0)
        pSecondChart->Series[0]->Free();
    int ColGraph = (pSecondChart) ? SubColumns()-1 : SubColumns();
    for(i=0; i<ColGraph; ++i){
        if(dgtype==0 || SubColumns()>1) {
            if(pSecondChart&&(i>1)){
               if(dgtype==1){
                  pSeries[i] = new TPieSeries(pSecondChart);
                  ((TPieSeries*)pSeries[i])->Circled = true;
                  pSecondChart->Legend->Visible = true;
                  pSecondChart->Legend->LegendStyle = lsAuto;
                  pSecondChart->Legend->TextStyle = ltsPlain;
                  TRect r = pSecondChart->GetRectangle();
               }else{
                  pSeries[i] = new TBarSeries(pSecondChart);
                  pSecondChart->Legend->Visible = (SubColumns()>1);
               }
            }else{
              pSeries[i] = new TBarSeries(pChart);
              pChart->Legend->Visible = (SubColumns()>1);
            }
           pSeries[i]->Marks->Style=smsValue;
        }else{
            pSeries[i] = new TPieSeries(pChart);
            ((TPieSeries*)pSeries[i])->Circled = true;
            pChart->Legend->Visible = true;
            pChart->Legend->LegendStyle = lsAuto;
            pChart->Legend->TextStyle = ltsPlain;
            TRect r = pChart->GetRectangle();
            pSeries[i]->Marks->Style = smsValue;
        }

        if(pSecondChart && i > 1){
          pSecondChart->AxisVisible = true;
          pSeries[i]->ParentChart=pSecondChart;
        }else{
          pChart->AxisVisible = true;
          pSeries[i]->ParentChart=pChart;
        }

        pSeries[i]->XValues->Order=loNone;
        pSeries[i]->YValues->Order=loDescending;
        pSeries[i]->Marks->Visible = FormSetupMonitors->cbMarks->Checked;
        pSeries[i]->Marks->Clip=true;
        pSeries[i]->XValues->DateTime=true;
        // added by KAG
        if (pSecondChart && FormSetupMonitors->kindOfADddBalanceDiag==2&&i==2)
          Str = GetSubColumnsNames(i+1);
        else
          if ((fd->CodeTemplate==NOT_BALANCE && i<3)||(fd->CodeTemplate==NOT_BALANCE_AER && i<3))
            Str = GetSubColumnsNames(i+1);
          else
            Str = GetSubColumnsNames(i);
        //e KAG
        pSeries[i]->Title=Str;
    }

    TDateTime tempDate;
    unsigned short year,month,day;
    unsigned short hour, mini, sec, msec;
    fd->DateTime.DecodeDate( &year, &month, &day);
    if( ARow>0 )
        switch(fd->StepProfile){
        case TFormDescr::stpMonth:
            Str=TDateTime(year,(unsigned short)ARow,1).FormatString(AnsiString("mmmm"))
                + " "+fd->DateTime.FormatString("yyyy")+" г.";
            break;
        case TFormDescr::stpDay:
            Str=(TDateTime(year,month,1)+(unsigned short)(ARow-1)).FormatString(AnsiString("ddddd"));
            break;
        case TFormDescr::stpHour:
            Str=(TDateTime(year,month,day)+(double)(ARow/(double)RowCount)).FormatString(AnsiString("t"))+"  "+fd->DateTime.FormatString(AnsiString("ddddd"));
            break;
        case TFormDescr::stpMinute:
            fd->DateTime.DecodeTime(&hour, &mini, &sec, &msec);
            Str=(TDateTime(year,month,day)+(double)(hour/24.0+StepPROFILE*ARow* 1.157407407407e-5)).FormatString(AnsiString("t"))+"  "+fd->DateTime.FormatString(AnsiString("ddddd"));
            break;
        }
    else
	    switch(fd->StepProfile){
        case TFormDescr::stpMonth:
            Str=fd->DateTime.FormatString(AnsiString("yyyy"))+" г.";
            break;
        case TFormDescr::stpDay:
            Str=fd->DateTime.FormatString(AnsiString("mmmm"))+" "+fd->DateTime.FormatString(AnsiString("yyyy"))+" г.";
            break;
        case TFormDescr::stpHour:
            Str=fd->DateTime.FormatString(AnsiString("ddddd"));
            break;
        case TFormDescr::stpMinute:
            Str=fd->DateTime.FormatString(AnsiString("t"))+"  "+fd->DateTime.FormatString(AnsiString("ddddd"));
            break;
        }
    pChart->Title->Text->Text= fd->NameGroup+" "+Str;
    if(pSecondChart)
      ResizeScaleOfTwoGraph(ARow, pSeries, SubColumns());
    else
      ResizeScaleOfGraph(ARow, pSeries, SubColumns());
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::formDescr( void )
{
		int iClones;
		Clones=0;
		if( fd->SummGroup )
			++Clones;
		//Заполняем необходимые поля описания формы
		//fd->NameForm="T2xDrawTableChartInterior";
		//fd->CommentForm=fd->DateTime.FormatString("dddddd")+fd->DateTime.TimeString();

		if(fd->SummGroup)
			NamesClones->Add(Reconst_smes105_15);
		else
			NamesClones->Add(Reconst_smes105_16);
		for( iClones=0; iClones < Clones; ++iClones )
			NamesClones->Add(Reconst_smes105_17+AnsiString(iClones));
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::selectData( TOraQuery *qwInter )
{
    int iClones,i,j,clones,rowCount;
	clones=Clones+1;
	rowCount=RowCount+1;

    for(iClones=0; iClones<clones; ++iClones)
	    for( i=0; i<SubColumns(); ++i )
		    datOracle[iClones*SubColumns()+i].val=0.0;
    for( j=1;j<rowCount;++j)
	{
	    for(i=0; i<SubColumns() ; ++i )
		    datOracle[j*clones*SubColumns()+i].val=0.0;
        for(  iClones=1; iClones<clones ; ++iClones )
		    for(i=0; i<SubColumns() ; ++i )
			{
			    datOracle[j*clones*SubColumns()+iClones*SubColumns()+i].val=50.0+50.0*sin((double)i+(double)j/(double)rowCount*2.0*M_PI);
				datOracle[j*clones*SubColumns()+i].val+=datOracle[j*clones*SubColumns()+iClones*SubColumns()+i].val;
				datOracle[ iClones*SubColumns()+i].val+=datOracle[j*clones*SubColumns()+iClones*SubColumns()+i].val;
            }
        for(i=0; i<SubColumns() ; ++i )
		    datOracle[i].val+=datOracle[j*clones*SubColumns()+i].val;
    }
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::PrintGraph()
{
/*
    ChartPreview(this, pChart);

/**/
    int tmpH,tmpW,tmpWMargin,tmpHMargin, OldSplit = 0; // margins
    TPrinterOrientation OldOrientation;
    TPrintDialog* PrDialog=NULL;
//  TSplitterForm* SplitF = NULL;
//  ChartPreview(NULL, pChart);
    PrDialog= new TPrintDialog(this);
    PrDialog->Copies=1;
    if(SplitterForm->Splitter)
    {
        OldSplit = SplitterForm->Splitter->Tag;
        SplitterForm->Splitter->Tag = 0x00010000;
        SplitterForm->SplitFormResize(NULL);
    }
    if(PrDialog->Execute()){
        Screen->Cursor = crHourGlass;
        OldOrientation=Printer()->Orientation;  // <-- save paper orientation
        Printer()->Orientation=poLandscape; // <-- Force Horizontal paper
        try {
            for(int i=0;i<PrDialog->Copies;i++){
                Printer()->BeginDoc();       // <-- start printer job
                try {
                    Printer()->Title=Application->Title;
                    pChart->PrintResolution= 0;

                    // CALCULATE HORIZONTAL MARGIN
                    tmpW=Printer()->PageWidth;
                    tmpWMargin=floor(5.0*tmpW/100.0); // <-- 5% margins
                    tmpW=tmpW-2*tmpWMargin;  // <-- left and right margins
//                  tmpW=tmpW; // half height for left and right charts

                    // CALCULATE VERTICAL MARGIN
                    tmpH=Printer()->PageHeight;
                    tmpHMargin=floor(5.0*tmpH/100.0);  // <-- 5% margins
                    tmpH=tmpH-2*tmpHMargin;  // <-- bottom and top margins
//                  tmpH=tmpH; // half height for top and bottom charts

                    pChart->PrintProportional = true;
//                  Chart1.Height:=Round(1.0*Printer.PageHeight*Chart1.Width/Printer.PageWidth);
                    if(pSecondChart){
                       pSecondChart->PrintResolution= 0;
                       pSecondChart->PrintProportional = true;
                       pChart->Height = floor(1.0*Printer()->PageHeight*pChart->Width/Printer()->PageWidth)*1.04 / 2;
                       pSecondChart->Height = pChart->Height;
                       TRect r1 = TRect(tmpWMargin,tmpHMargin,tmpWMargin+tmpW,tmpHMargin+(tmpH/2));
                       TRect r2 = TRect(tmpWMargin,tmpHMargin+(tmpH/2),tmpWMargin+tmpW,tmpHMargin+tmpH);
                       pChart->PrintPartial(r1);
                       pSecondChart->PrintPartial(r2);
                    }else{
                       TRect r = TRect(tmpWMargin,tmpHMargin,tmpWMargin+tmpW,tmpHMargin+tmpH);
                       pChart->Height = floor(1.0*Printer()->PageHeight*pChart->Width/Printer()->PageWidth)*1.04;
                       pChart->PrintPartial(r);
                    }
                    Printer()->EndDoc(); // <-- end job and print !!
                }catch (Exception &e) {
                    Printer()->Abort();
                    Printer()->EndDoc();
                    delete  PrDialog;
                    throw;
                }
            }
        }
        __finally {
            Printer()->Orientation=OldOrientation;  // <-- restore paper orientation
            Screen->Cursor=crDefault; // <-- restore cursor
        }
    }
    if(SplitterForm->Splitter)
    {
        SplitterForm->Splitter->Tag = OldSplit;
        SplitterForm->SplitFormResize(NULL);
    }
    delete PrDialog;
/*  */
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::PrintTable()
{
    AnsiString RepTitle;
    TPrintDrawTable *PrintTable = new TPrintDrawTable(this);
//    PrintTable->DataSource1->DataSet = VT_PrintData;
//    PrintTable->ListBox1->Items = ColumnsCaption;
  /*  switch( fd->StepProfile )
    {
		case TFormDescr::stpMonth:
			RepTitle=fd->NameGroup+" за "+fd->DateTime.FormatString("yyyy 'г.'");
			break;
		case TFormDescr::stpDay:
			RepTitle=fd->NameGroup+" за "+fd->DateTime.FormatString("mmmm'.'");
			break;
		case TFormDescr::stpHour:
			RepTitle=fd->NameGroup+" за "+fd->DateTime.FormatString("ddddd");
			break;
		case TFormDescr::stpMinute:
			RepTitle=fd->NameGroup+" на "+fd->DateTime.FormatString("ddddd")+" c "+fd->DateTime.FormatString("t");
			break;
    }*/
   TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
   PrintTable->PrintTable(dynamic_cast<TBaseMonitorForm*>(Owner)->Caption, ((TBaseMonitorForm*)Owner)->LabelComment->Caption, ColumnsCaption, VT_PrintData,
      fd->VerticalSplit?psm->EditColorWidthDigit->Text.ToInt():psm->EditColorWidthName->Text.ToInt(),
      fd->VerticalSplit?psm->EditColorWidthName->Text.ToInt():psm->EditColorWidthDigit->Text.ToInt(),
      SubColumns()>1?2:1,GetFormDescr());
   delete psm;
   delete PrintTable;
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::SaveTableToFile(TSaveDialog *aSaveDialog)
{
    aSaveDialog->Title = Reconst_smes105_21;
    aSaveDialog->FileName = Reconst_smes105_22;
    aSaveDialog->DefaultExt = "xls";
    aSaveDialog->Filter = Reconst_smes105_23;
    if(aSaveDialog->Execute())
    {
        AnsiString RepTitle;
        TPrintDrawTable *PrintTable = new TPrintDrawTable(this);
        PrintTable->SaveTableToFile(dynamic_cast<TBaseMonitorForm*>(Owner)->Caption, dynamic_cast<TBaseMonitorForm*>(Owner)->LabelComment->Caption, ColumnsCaption, VT_PrintData,
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthName->Text.ToInt()+50:FormSetupMonitors->EditColorWidthDigit->Text.ToInt(),
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthDigit->Text.ToInt()-10:FormSetupMonitors->EditColorWidthName->Text.ToInt(),SubColumns()>1?2:1,aSaveDialog->FileName,0);
        delete PrintTable;
    }
}
//---------------------------------------------------------------------------

void __fastcall T2xDrawTableChartInterior::SaveGraphToFile(TSaveDialog *aSaveDialog)
{
      aSaveDialog->Title = Reconst_smes105_24;
      aSaveDialog->FileName = Reconst_smes105_22;
      aSaveDialog->DefaultExt = "bmp";
      aSaveDialog->Filter = Reconst_smes105_25;
      if(aSaveDialog->Execute())
      {
        Graphics::TBitmap* bm = new Graphics::TBitmap;
        try
        {
          bm->Width = pChart->Width;
          bm->Height= pChart->Height;
          pChart->BufferedDisplay=false;
//add by NNV добавляетса возможность выводить второй график в файл
          if(pSecondChart){
             bm->Height += pSecondChart->Height;
             pSecondChart->BufferedDisplay = false;
             pChart->Draw(bm->Canvas,Rect(0,0,pChart->Width,pChart->Height));
             pSecondChart->Draw(bm->Canvas,Rect(0,pChart->Height,bm->Width,bm->Height));
             pSecondChart->BufferedDisplay = true;
          }else
             pChart->Draw(bm->Canvas,Rect(0,0,pChart->Width,pChart->Height));
//end add by NNV
          pChart->BufferedDisplay = true;
          bm->SaveToFile(aSaveDialog->FileName);
        }
        __finally
        {
          delete bm;
        }
      }
}
//---------------------------------------------------------------------------
bool __fastcall T2xDrawTableChartInterior::AreTherTwoGraph()
{
  switch (fd->CodeTemplate)
  {
        case BALANCE_F:
        case BALANCE_POW_F:
        case BALANCE_SUM_F:
        case RE_BALANCE_F:
        case RE_BALANCE_POW_F:
        case RE_BALANCE_SUM_F:
        case NOT_BALANCE:
        case NOT_BALANCE_AER:
           return true;
        default :
           return false;
  }
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::ResizeScaleOfGraph(long ARow, TChartSeries **pSeries, int SubCol, int SkipCol)
{
    TCloneItem *ptrDatOracle;
    AnsiString Str;
    double temp;
    YMaxVal = 0;
    YMinVal = 0;
    for( int j=0; j<SubCol-SkipCol ; ++j ){
        if (fd->CodeTemplate==NOT_BALANCE||fd->CodeTemplate==NOT_BALANCE_AER)
          ptrDatOracle=datOracle+ARow*(Clones+1)*SubCol+SubCol+j+1;
        else
          ptrDatOracle=datOracle+ARow*(Clones+1)*SubCol+SubCol+j;
        for(int i=0; i<Clones; ++i,ptrDatOracle+=SubCol ){
            Str=NamesClones->Strings[i+1];
            if(ptrDatOracle->val<=-MAXFLOAT)
            {
                temp=0.0;
                if(!dynamic_cast<TPieSeries*>(pSeries[j]))
                    pSeries[j]->AddNull(Str);
            }else{
                temp=ptrDatOracle->val;
                pSeries[j]->AddY(temp,Str,(TColor)clTeeColor);
            }
            YMaxVal = max(temp,YMaxVal);
            YMinVal = min(temp,YMinVal);
        }
    }
    IncreaseScaleValue( YMinVal, YMaxVal );
    pChart->LeftAxis->Minimum = -MAXFLOAT;
    pChart->LeftAxis->Maximum = YMaxVal+((YMaxVal-YMinVal)/100)*5;
    pChart->LeftAxis->Minimum = YMinVal-((YMaxVal-YMinVal)/100)*5;
    pChart->LeftAxis->Automatic = false;
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::ResizeScaleOfSecondGraph(long ARow, TChartSeries **pSeries)
{
    TCloneItem *ptrDatOracle;
    AnsiString Str;
    double temp;
    YMaxVal = 0;
    YMinVal = 0;

    if(FormSetupMonitors->kindOfADddBalanceDiag==2)
       ptrDatOracle=datOracle+ARow*(Clones+1)*SubColumns()+SubColumns()+3;
    else
       ptrDatOracle=datOracle+ARow*(Clones+1)*SubColumns()+SubColumns()+2;

    for(int i=0; i<Clones; ++i,ptrDatOracle+=SubColumns() ){
      Str=NamesClones->Strings[i+1];
      if(ptrDatOracle->val<=-MAXFLOAT){
        temp=0.0;
        if(!dynamic_cast<TPieSeries*>(pSeries[2]))
          pSeries[2]->AddNull(Str);
      }else{
        temp=ptrDatOracle->val;
        pSeries[2]->AddY(temp,Str,(TColor)clTeeColor);
      }
      YMaxVal = max(temp,YMaxVal);
      YMinVal = min(temp,YMinVal);
    }
//    IncreaseScaleValue( YMinVal, YMaxVal );
    pSecondChart->LeftAxis->Minimum = -MAXFLOAT;
    pSecondChart->LeftAxis->Maximum = YMaxVal+((YMaxVal-YMinVal)/100)*5;
    pSecondChart->LeftAxis->Minimum = YMinVal-((YMaxVal-YMinVal)/100)*5;
    pSecondChart->LeftAxis->Automatic = false;
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::ResizeScaleOfTwoGraph(long ARow, TChartSeries **pSeries,int SubCol)
{
  ResizeScaleOfGraph(ARow,pSeries,SubCol,2);
  ResizeScaleOfSecondGraph(ARow,pSeries);
}
//---------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::ScaleOfGraph(bool fCode, int ColGraf, int MaxRowCount, long AClone, TLineSeries **pSeries, TDateTime *fDate, AnsiString LabelDateFormat)
{
   YMaxVal = -MAXFLOAT;
   YMinVal = -MAXFLOAT;
   int CurClone;
   double temp;
   double tempsave;
   TCloneItem *ptrDatOracle;
   for(int j=0,k=0; j< ColGraf; ++j ){                        // массив элементов
       if(fCode){
          if(fNumClones[j])
             CurClone=j;
          else
             continue;
          ptrDatOracle=datOracle+(Clones+1+CurClone)*SubColumns();
       }else
          if (fd->CodeTemplate==NOT_BALANCE||fd->CodeTemplate==NOT_BALANCE_AER)
            ptrDatOracle=datOracle+(Clones+1)*SubColumns()+AClone*SubColumns()+j+1;// added by KAG
          else
            ptrDatOracle=datOracle+(Clones+1)*SubColumns()+AClone*SubColumns()+j;
        for(int i=0; i<MaxRowCount; ++i,ptrDatOracle+=(Clones+1)*SubColumns() ){
            if(ptrDatOracle->val <= -MAXFLOAT){
           //------------------------------------------
           //    temp=tempsave;
           //    if(temp)pSeries[k]->AddXY(i/*fDate[i]*/,temp,fDate[i].FormatString(LabelDateFormat),clTeeColor);
           //    else pSeries[k]->AddNullXY(i/*fDate[i]*/,0,fDate[i].FormatString(LabelDateFormat));
           //    tempsave=0;
            //-------------------------------------------
               temp = 0;
               pSeries[k]->AddNullXY(i/*fDate[i]*/,0,fDate[i].FormatString(LabelDateFormat));
            }else{

               temp = ptrDatOracle->val;
                //-------------------------------
            //   tempsave=temp;
               //----------------------------------------
               if (fd->CodeTemplate==NOT_BALANCE) // added by KAG
                 temp = temp>0?temp:(-1)*temp;    // на первом графике небалансы будут выводится по модулю
               pSeries[k]->AddXY(i/*fDate[i]*/,temp,fDate[i].FormatString(LabelDateFormat),(TColor)clTeeColor);
            }
            if(YMaxVal == -MAXFLOAT){
               YMaxVal = temp;
               YMinVal = temp;
            }else{
               YMaxVal = max(temp,YMaxVal);
               YMinVal = min(temp,YMinVal);
            }
        }
        k++;
   }
//chig Изменение масштаба
   if(YMaxVal-YMinVal > 3)
      IncreaseScaleValue( YMinVal, YMaxVal );
//e Изменение масштаба
   pChart->LeftAxis->Minimum = -MAXFLOAT;
   pChart->LeftAxis->Maximum = YMaxVal+((YMaxVal-YMinVal)/100)*5;
   pChart->LeftAxis->Minimum = YMinVal-((YMaxVal-YMinVal)/100)*5;
   if(pChart->LeftAxis->Maximum<0)
      pChart->LeftAxis->Maximum = 0;
   if(pChart->LeftAxis->Minimum>0)
      pChart->LeftAxis->Minimum = 0;
   pChart->LeftAxis->Automatic = false;
}
//----------------------------------------------------------------------------
void __fastcall T2xDrawTableChartInterior::ScaleOfTwoGraph(bool fCode, int MaxRowCount, long AClone, TLineSeries **pSeries, TDateTime *fDate, AnsiString LabelDateFormat)
{
   TCloneItem *ptrDatOracle;
   ScaleOfGraph(fCode, 2, MaxRowCount, AClone, pSeries, fDate, LabelDateFormat);
   YMaxVal = -MAXFLOAT;
   YMinVal = -MAXFLOAT;
   int CurClone;
   double temp;
   if(FormSetupMonitors->kindOfADddBalanceDiag==2)
      ptrDatOracle=datOracle+(Clones+1)*SubColumns()+AClone*SubColumns()+3;
   else
      ptrDatOracle=datOracle+(Clones+1)*SubColumns()+AClone*SubColumns()+2;
     for(int i=0; i<MaxRowCount; ++i,ptrDatOracle+=(Clones+1)*SubColumns() ){
       if(ptrDatOracle->val <= -MAXFLOAT){
          temp = 0;
          pSeries[2]->AddNullXY(i/*fDate[i]*/,0,fDate[i].FormatString(LabelDateFormat));
       }else{
          temp = ptrDatOracle->val;
          pSeries[2]->AddXY(i/*fDate[i]*/,temp,fDate[i].FormatString(LabelDateFormat),(TColor)clTeeColor);
       }
       if(YMaxVal == -MAXFLOAT){
          YMaxVal = temp;
          YMinVal = temp;
       }else{
          YMaxVal = max(temp,YMaxVal);
          YMinVal = min(temp,YMinVal);
       }
   }
//chig Изменение масштаба
   if(YMaxVal-YMinVal > 3)
      IncreaseScaleValue( YMinVal, YMaxVal );
//e Изменение масштаба
   pSecondChart->LeftAxis->Minimum = -MAXFLOAT;
   pSecondChart->LeftAxis->Maximum = YMaxVal+((YMaxVal-YMinVal)/100)*5;
   pSecondChart->LeftAxis->Minimum = YMinVal-((YMaxVal-YMinVal)/100)*5;
   if(pSecondChart->LeftAxis->Maximum<0)
      pSecondChart->LeftAxis->Maximum = 0;
   if(pSecondChart->LeftAxis->Minimum>0)
      pSecondChart->LeftAxis->Minimum = 0;
   pSecondChart->LeftAxis->Automatic = false;

}
//----------------------------------------------------------------------------
 void __fastcall T2xDrawTableChartInterior::IsValidClick(TObject *Sender)
 {
   long ACol,ARow,ARowCount,AColCount,row,col=0;
		TDrawTable::SAttrCell *pCellGroup,*pCellProfile;
   char s[32];
		ACol=DrawTable->Col;
		ARow=DrawTable->Row;
    ARowCount=DrawTable->RowCount;
    AColCount=DrawTable->ColCount;
    col=(SubColumns()>1)? 1:0;
		//находим атрибуты ячеек для заголовка клона и заголовка профиля
		//а затем вычисляем номер клона и номер профиля
		if( fd->VerticalSplit )
		{
       pCellProfile=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(0,ARow);
       row= ((ACol-1)%SubColumns()==0)?
      ACol:
     ((ACol-2)%SubColumns()==0)?
      ACol-1:
      ((ACol-3)%SubColumns()==0)?
      ACol-2:
      ((ACol-4)%SubColumns()==0)?ACol-3:ACol;
		   pCellGroup=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(row,0);
       if(fd->SummGroup)strcpy(s,datOracle[(ARow-1-col)*(AColCount-1)+ACol-1].isvalid);
       else strcpy(s,datOracle[(ARow-1-col)*(AColCount-1)+ACol-1+(AColCount-1)].isvalid);
		}
		else
		{
      pCellProfile=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(ACol,0);
      row= ((ARow-1)%SubColumns()==0)?
      ARow:
     ((ARow-2)%SubColumns()==0)?
      ARow-1:
      ((ARow-3)%SubColumns()==0)?
      ARow-2:
      ((ARow-4)%SubColumns()==0)?ARow-3:ARow;

    	pCellGroup=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(0,row);

	 	  if(fd->SummGroup)strcpy(s,datOracle[(ACol-1-col)*(ARowCount-1)+ARow-1].isvalid);
      else strcpy(s,datOracle[(ACol-1-col)*(ARowCount-1)+ARow-1+(ARowCount-1)].isvalid);
		}
  // AnsiString n=((TBaseMonitorForm*)Owner)->LabelComment->Caption;
  if (s[0]!='\0'){
   int A;

    if (SV == 2)   //если выбрано отображение метки качества электроэнергии
    {
      TfmEnrgValid *FormEnrgValid = new TfmEnrgValid(this,s,pCellGroup->SourceData->Strings[pCellGroup->IndexData],pCellProfile->SourceData->Strings[pCellProfile->IndexData]);
      FormEnrgValid->ShowModal();
      delete FormEnrgValid;
    }

    else    //иначе - метка качества данных
    {
      TfmValidityForm *ValidityForm = new TfmValidityForm(this,s,pCellGroup->SourceData->Strings[pCellGroup->IndexData],pCellProfile->SourceData->Strings[pCellProfile->IndexData]);
      ValidityForm->ShowModal();
      delete ValidityForm;
    }
  }

 }
//-------------------------------------------------------------------------------
//GRB ADD 12.07.2019  - является ли дата в pfd->DateTime днём перевода времени за monthNumber
//-------------------------------------------------------------------------------
bool __fastcall T2xDrawTableChartInterior::IsDayShiftMonth (TFormDescr *pfd, int monthNumber){      //Октаябрь - 10, Март - 3
   unsigned short year,month,day;
   pfd->DateTime.DecodeDate( &year, &month, &day);

  unsigned short year_leap,month_leap,day_leap;
  pfd->DateTime.DecodeDate(&year_leap,&month_leap,&day_leap);

  if((IsShiftTimeZona)&&(month_leap==monthNumber)&&( pfd->DateTime.DayOfWeek()==1&&31-day<7))
        return true;
  return false;
}
//-------------------------------------------------------------------------------
//GRB ADD 26.08.2021 - два метода для автоформатирования по содержимому фиксированых колонок - исправление бага с обрезанием длинных имён в колонках
//---------------------------------------------------------------------------
void __fastcall  T2xDrawTableChartInterior::AutoSizeColGRB (TDrawTable* tsg, int columnIndex){
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
void __fastcall T2xDrawTableChartInterior::AutoSizeNameOnly (TDrawTable* tsg){
                AutoSizeColGRB (tsg, 0);
}
//---------------------------------------------------------------------------
TFont * __fastcall T2xDrawTableChartInterior::GetActiveFont4MonitorFromReg (){
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
void __fastcall T2xDrawTableChartInterior::FormShow(TObject *Sender){
         if (GetContainedWidthStatusFromReg())
                AutoSizeNameOnly (DrawTable);
}
//---------------------------------------------------------------------------
bool __fastcall T2xDrawTableChartInterior::GetContainedWidthStatusFromReg(){
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



