//---------------------------------------------------------------------------
#include <vcl.h>
#include <math.h>
#pragma hdrstop
#include "InteriorChart.h"
#include "unDataMod.h"
#include "Interior.h"
#include "MonitorForm.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min(a, b)  (((a) < (b)) ? (a) : (b))
//---------------------------------------------------------------------------
__fastcall TChartInterior::TChartInterior(TComponent* Owner,TSplitterForm *aSP,
	TFormDescr *aFD,Classes::TNotifyEvent OnProgr):TInterior(Owner,aSP,aFD,OnProgr )
{
  int RowCount=86400/StepPROFILE;
	if( dynamic_cast<TWinControl*>(Owner) ){
    try{
  		OwnerMenu = dynamic_cast<TBaseMonitorForm*>(Owner)->PopupMenu;
      dynamic_cast<TBaseMonitorForm*>(Owner)->PopupMenu = NULL;
  		NamesClones=new TStringList();
	  	datOracle=NULL;
		  OnProgressBarStepBy(NULL);//0
  		switch(fd->StepProfile){
  			case TFormDescr::stpHour:
	  			break;
		  	default:
			  	throw(Exception(Reconst_smes107_1));
  		}
		//Загружаем из базы полное описание таблицы
	    formDescr();
  		OnProgressBarStepBy(this);//10

	  	datOracle=new TCloneItem[ Clones*SubColumns()*RowCount];

		//selectData( dmMain->qwInter);
     selectData( dmMain->oqInterCursor);

    }catch (Exception &exception){
		  Application->ShowException(&exception);
      dynamic_cast<TBaseMonitorForm*>(Owner)->PopupMenu = OwnerMenu;
	  	delete NamesClones;
		  if(datOracle)
			  delete [] datOracle;
  		throw(Exception(Reconst_smes107_2));
    }catch(...){
		  delete NamesClones;
  		if(datOracle)
	  		delete [] datOracle;
		  throw(Exception(Reconst_smes107_3));
    }
	}else
		throw(Exception(Reconst_smes107_4));
}
//---------------------------------------------------------------------------
__fastcall TChartInterior::~TChartInterior(void)
{
  dynamic_cast<TBaseMonitorForm*>(Owner)->PopupMenu = OwnerMenu;
	delete NamesClones;
	delete [] datOracle;
	if(pChart)
    delete pChart;
}
//---------------------------------------------------------------------------
		//Снятие со SplitterFom таблицы и графика, вызываемтся при обновлении TBaseMonitorForm
void __fastcall TChartInterior::Destroy(void)
{
	SplitterForm->RemoveChild(pChart);
}
//---------------------------------------------------------------------------
void __fastcall TChartInterior::Place(void)
{
try
{
   //Создаем график
	pChart=NULL;
	pChart=new TChart(Owner);
   pChart->Enabled=true;
	pChart->Parent=dynamic_cast<TWinControl*>(Owner);
	//Проводим начальную настройку компонента TChart
	pChart->View3D=false;
   pChart->Legend->Visible=true;
   pChart->Legend->ColorWidth = 35;
   pChart->AllowZoom=true;
   pChart->AllowPanning=pmHorizontal;
   pChart->Show();
   switch(fd->CodeTemplate)
   {
   case APRO_C: // 10 - Активная мощность
      pChart->LeftAxis->Title->Caption = Reconst_smes107_5;
      break;
   case RPRO_C: // 20 - Реактивная мощность
      pChart->LeftAxis->Title->Caption = Reconst_smes107_6;
      break;
   }
	SplitterForm->AddChild(NULL,pChart,alRight);
	SplitterForm->SplitFormResize(NULL);
	ChartFXLines(1);
	OnProgressBarStepBy(this);//100
}
catch(Exception &e)
{
		if(pChart)
		{
			SplitterForm->RemoveChild(pChart);
			delete pChart;
			pChart=NULL;
		}
		throw(Exception(Reconst_smes107_7));
}
}
//---------------------------------------------------------------------------
		//Возвращает количесиво подколонок для формы
long __fastcall TChartInterior::SubColumns(void)
{
	return 1;
}
//---------------------------------------------------------------------------
		//Обновление данных из базы
		//NameAlert=-1 для обновления в любом случае
void __fastcall TChartInterior::refreshData( int Table,TOraQuery *qwInter  )
{
	if(Table==TABLE_PROFILE)
		selectData(qwInter);
//     selectData(dmMain->oqInterCursor);
}
//---------------------------------------------------------------------------
void __fastcall TChartInterior::Invalidate( int Table )
{
	if(Table==TABLE_PROFILE)
	{
		ChartFXLines(1);
		OnProgressBarStepBy(NULL);
	}
	--refreshDataCount;
}
//---------------------------------------------------------------------------
void __fastcall TChartInterior::selectData( TOraQuery *qwInter  )
{

	unsigned long j,selectRows,clones,rowCount;
	unsigned short year, month, day;
	int CountOnProgress=8;
	long iClones,IdGroup,stepProfile;
	AnsiString sql;
	char FirstDate[20], LastDate[20];

	struct TempStruct{
		long Count;
		double A;
    TempStruct(){ZeroMemory(this,sizeof(*this));}
	}*TempDatOracle;
	TCloneItem *pDatOracle;

	rowCount=RowCount;
	clones=Clones;
	pDatOracle=datOracle;
	for( iClones=0; (unsigned long)iClones<clones*SubColumns()*rowCount ;++iClones,++pDatOracle ){
		pDatOracle->val=-MAXFLOAT;
    ZeroMemory(pDatOracle->isvalid,sizeof(pDatOracle->isvalid));
  }

	fd->DateTime.DecodeDate(&year, &month, &day);
	strcpy( FirstDate,(TDateTime(year, month, day)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
	strcpy( LastDate,(TDateTime(year, month,day)+1).FormatString(DateTimeFormat).c_str());

	TempDatOracle=new struct TempStruct[rowCount];
	stepProfile=StepPROFILE;

  qwInter->Params->Clear();
  qwInter->SQL->Text="begin "+SchemeName+"interior_pg.ChartInterior_selectData_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11); end;";
  qwInter->ParamByName("par11")->ParamType=ptOutput;
  qwInter->ParamByName("par11")->DataType=ftCursor;

	for(iClones=0; iClones<Clones; ++iClones){
		IdGroup=(long)NamesClones->Objects[iClones];

    qwInter->ParamByName("par1")->AsInteger= (fd->IsPoints)?1:0;
    qwInter->ParamByName("par2")->AsInteger=fd->StepProfile;
    qwInter->ParamByName("par3")->AsInteger=fd->CodeTemplate;
    qwInter->ParamByName("par4")->AsInteger=stepProfile;
    qwInter->ParamByName("par5")->AsString=FirstDate;
    qwInter->ParamByName("par6")->AsString=LastDate;
    qwInter->ParamByName("par7")->AsInteger=IdGroup;
    qwInter->ParamByName("par8")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
    qwInter->ParamByName("par9")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
    qwInter->ParamByName("par10")->AsInteger=fd->GetPeriod(fd->DateTime);

    qwInter->Execute();
    int i=0;
    while(!qwInter->Eof&&i<(int)rowCount){
     TempDatOracle[i].Count=qwInter->FieldByName("BCount")->AsInteger;
     TempDatOracle[i].A = qwInter->FieldByName("AParam")->AsFloat;
     qwInter->Next();
     i++;
    }
    qwInter->Close();
    selectRows=i;
		if( CountOnProgress ){
			CountOnProgress-=(8/Clones>0?8/Clones:1);
			for( j=0;j<(8u/Clones>0?8u/Clones:1u);++j)
				OnProgressBarStepBy(this);//20
		}

		for( j=0;j<selectRows;++j){
			pDatOracle=datOracle+(iClones*SubColumns()+TempDatOracle[j].Count*Clones*SubColumns());
			pDatOracle->val=TempDatOracle[j].A;
		}
	}
	delete [] TempDatOracle;
	while( CountOnProgress ){
		--CountOnProgress;
		OnProgressBarStepBy(this);//20
	}
}
//---------------------------------------------------------------------------
		//Получает данные о считываемой таблице
void __fastcall TChartInterior::formDescr( void )
{
  fd->IdGroup = GroupJump(fd->IdGroup);
 	//Заполняем необходимые поля описания формы
	Clones = 0;
  dmMain->oqInterCursor->Params->Clear();
  dmMain->oqInterCursor->SQL->Text="begin "+SchemeName+"interior_pg.Interior_formDescr_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7); end;";
  dmMain->oqInterCursor->ParamByName("par7")->ParamType=ptOutput;
  dmMain->oqInterCursor->ParamByName("par7")->DataType=ftCursor;

  dmMain->oqInterCursor->ParamByName("par1")->AsInteger=(fd->IsPoints)?1:0;
  dmMain->oqInterCursor->ParamByName("par2")->AsInteger=fd->StepProfile;
  dmMain->oqInterCursor->ParamByName("par3")->AsInteger=fd->IdGroup;
  dmMain->oqInterCursor->ParamByName("par4")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
  dmMain->oqInterCursor->ParamByName("par5")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
  dmMain->oqInterCursor->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);

  dmMain->oqInterCursor->Execute();
 	NamesClones->Clear();
  while(!dmMain->oqInterCursor->Eof){
    Clones++;
    NamesClones->AddObject(dmMain->oqInterCursor->FieldByName("name")->AsString,(TObject*)dmMain->oqInterCursor->FieldByName("mid")->AsInteger);
    dmMain->oqInterCursor->Next();
  }
  dmMain->oqInterCursor->Close();
	if( Clones==0 )
		throw(Exception(Reconst_smes107_8));

}
//---------------------------------------------------------------------------
		//Строит линейный график для указанного клона
void __fastcall TChartInterior::ChartFXLines(long AClone)
{
    const CntPROFILE = LenPROFILE/StepPROFILE+100;
   int RowCount=86400/StepPROFILE;
   int i,j,MaxRowCount;
   TCloneItem *ptrDatOracle;
   double temp;
   AnsiString Str;
   TDateTime *fDate = NULL;
   TLineSeries *pSeries[AMOUNTSERIES];

    try{
        fDate = new TDateTime[CntPROFILE];
   pChart->Legend->Visible=true;//С легендой

   for(int i=0; i<pChart->SeriesCount(); i++)
       pChart->Series[i]->Active = false;
   for(i=0; i<Clones; ++i){
      pSeries[i]=new TLineSeries(pChart);
      pSeries[i]->ParentChart=pChart;
      pSeries[i]->Pointer->Visible = FormSetupMonitors->cbPoints->Checked;
      pSeries[i]->Pointer->Style = psCircle;
      pSeries[i]->Pointer->HorizSize = 3;
      pSeries[i]->Pointer->VertSize = 3;
      pSeries[i]->Marks->Visible = FormSetupMonitors->cbMarks->Checked;
      pSeries[i]->Marks->Clip = true;
      pSeries[i]->XValues->Order=loNone;
      pSeries[i]->YValues->Order=loDescending;
      pSeries[i]->Marks->Style=smsValue;
      pSeries[i]->LinePen->Width=3;
      pSeries[i]->XValues->DateTime=true;
      Str=NamesClones->Strings[i];
      pSeries[i]->Title=Str;
   }
   Str=fd->NameGroup;
   pChart->Title->Text->Text=Str+"  "+fd->DateTime.FormatString("ddddd");    //     [CHART_TOPTIT]

	unsigned short year,month,day;
   TDateTime tmpDateTime;

	fd->DateTime.DecodeDate( &year, &month, &day);
	switch(fd->StepProfile)
	{
	case TFormDescr::stpHour:
		tmpDateTime=TDateTime(year,month,day);//+hour/24.0;
//    for( j=0; j<=RowCount && tmpDateTime<=TDateTime::CurrentDateTime(); ++j ){
    for( j=0; j<=RowCount ; ++j ){
       tmpDateTime+= StepPROFILE* 1.157407407407e-5;
       fDate[j]=tmpDateTime;//temp-floor(temp);
    }
		MaxRowCount=j-1;
		break;
   default:
	   throw(Exception(Reconst_smes107_9));
   }
   YMaxVal = 0;
   YMinVal = 0;
	for( j=0; j<Clones ; ++j ){
		ptrDatOracle=datOracle+j;
		for(i=0; i<MaxRowCount; ++i,ptrDatOracle+=Clones*SubColumns() )
		{
         if(ptrDatOracle->val<=-MAXFLOAT){
            temp=0;
            pSeries[j]->AddNullXY(fDate[i],temp,"");
         }else{
            temp=ptrDatOracle->val;
   			pSeries[j]->AddXY(fDate[i],temp,"",(TColor)clTeeColor);
         }
         YMaxVal = max(temp,YMaxVal);
         YMinVal = min(temp,YMinVal);
      }
   }
   pChart->LeftAxis->Maximum = YMaxVal+((YMaxVal-YMinVal)/100)*5;
   pChart->LeftAxis->Minimum = YMinVal-((YMaxVal-YMinVal)/100)*5;
   pChart->LeftAxis->Automatic = false;

        if(fDate) delete []fDate;
    }catch(Exception&e){
        if(fDate) delete []fDate;
        throw e;
    }
}
//---------------------------------------------------------------------------
void __fastcall TChartInterior::PopupMenuBaseFormPopup(TObject *Sender)
{
//	T2xDrawTableChartInterior::PopupMenuBaseFormPopup(Sender);
	if( dynamic_cast<TBaseMonitorForm*>(Owner) )
	{
		TBaseMonitorForm* pOwner=dynamic_cast<TBaseMonitorForm*>(Owner);
		pOwner->SmallFont->Checked=!pOwner->isSmallFont;
		pOwner->SmallFont2->Checked=!pOwner->isSmallFont;
		pOwner->ChartFXColumns->Enabled=false;
	}
}

//---------------------------------------------------------------------------
// Add KAS 11.02.02
void __fastcall TChartInterior::PrintGraph()
{
  int tmpH,tmpW,tmpWMargin,tmpHMargin, OldSplit = 0; // margins
  TPrinterOrientation OldOrientation;
  TPrintDialog* PrDialog=NULL;
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
          tmpW=Printer()->PageWidth;
          tmpWMargin=floor(5.0*tmpW/100.0); // <-- 5% margins
          tmpW=tmpW-2*tmpWMargin;  // <-- left and right margins
          tmpW=tmpW; // half height for left and right charts

          // CALCULATE VERTICAL MARGIN
          tmpH=Printer()->PageHeight;
          tmpHMargin=floor(5.0*tmpH/100.0);  // <-- 5% margins
          tmpH=tmpH-2*tmpHMargin;  // <-- bottom and top margins
          tmpH=tmpH; // half height for top and bottom charts

          // left / top chart
          pChart->PrintPartial( Rect( tmpWMargin,tmpHMargin,
                                     tmpWMargin+tmpW,tmpHMargin+tmpH ) );

          Printer()->EndDoc(); // <-- end job and print !!
        }catch (Exception &e) {
           Printer()->Abort();
           Printer()->EndDoc();
           delete PrDialog;
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
}
//---------------------------------------------------------------------------
void __fastcall TChartInterior::SaveGraphToFile(TSaveDialog *aSaveDialog)
{
      aSaveDialog->Title = Reconst_smes107_10;
      aSaveDialog->FileName = Reconst_smes107_11;
      aSaveDialog->DefaultExt = "bmp";
      aSaveDialog->Filter = Reconst_smes107_12;
      if(aSaveDialog->Execute())
      {
        Graphics::TBitmap* bm = new Graphics::TBitmap;
        try
        {
          bm->Width = pChart->Width;
          bm->Height= pChart->Height;
          pChart->BufferedDisplay=false;
          pChart->Draw(bm->Canvas,Rect(0,0,pChart->Width,pChart->Height));
          pChart->BufferedDisplay=true;
          bm->SaveToFile(aSaveDialog->FileName);
        }
        __finally
        {
          delete bm;
        }
      }
}
//---------------------------------------------------------------------------
AnsiString __fastcall TChartInterior::GetUnitOfEnergy()
{
  AnsiString d = "";
	switch( fd->CodeTemplate ){
		case APRO_C:
      d = Reconst_smes107_13.c_str();
      break;
		case RPRO_C:
      d = Reconst_smes107_14.c_str();
      break;
	}
  return d;
}
//---------------------------------------------------------------------------
// end Add

