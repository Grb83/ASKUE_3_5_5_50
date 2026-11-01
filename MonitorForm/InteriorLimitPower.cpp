//---------------------------------------------------------------------------
#include <vcl.h>
#include <math.h>
#pragma hdrstop
#include "InteriorLimitPower.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min(a, b)  (((a) < (b)) ? (a) : (b))
//---------------------------------------------------------------------------
__fastcall TLimitPowerInterior::TLimitPowerInterior(TComponent* Owner,TSplitterForm *s,
	TFormDescr* f,Classes::TNotifyEvent n):T2xDrawTableChartInterior(Owner,s,f,n)
{
}
//---------------------------------------------------------------------------
__fastcall TLimitPowerInterior::~TLimitPowerInterior(void)
{
}
//---------------------------------------------------------------------------
void __fastcall TLimitPowerInterior::Place(void)
{
//	fd->PercentSplit=1;
	T2xDrawTableChartInterior::Place();
	DrawTable->PopupMenu->OnPopup=PopupMenuBaseFormPopup;
//	Chartfx1->Style=CS_SCROLLABLE|CS_TEMPLATE;
//	Chartfx1->Type=SCATTER|CT_LEGEND|CT_SHOWZERO|CT_SCATTERLINE|
//		CT_COLORLINE|CT_NOAREALINE|CT_NOBORDERS;
	//ChartFX->XLegType=CL_NOTCLIPPED|CL_NOTCHANGECOLOR|CL_GETLEGEND;
	//ChartFX->XLegType=CL_GETLEGEND;
	//ChartFX->OnGetLegend=ChartFXGetLegend;
}
//---------------------------------------------------------------------------
AnsiString s;
void __fastcall TLimitPowerInterior::ChartFXGetLegend(System::TObject* Sender,
	short nType, short &nRes)
{
	switch( nType )
	{
		case 0://X
//			s=Chartfx1->HText;
//			Chartfx1->HText=AnsiString("0");
			nRes=1;
			break;
		case 1://Y
//			s=Chartfx1->HText;
//			Chartfx1->HText=AnsiString("Да-да");
			nRes=1;
			break;
		default:
			nRes=0;
			break;
	}
}
//---------------------------------------------------------------------------
void __fastcall TLimitPowerInterior::refreshData( int Table,TOraQuery *qwInter)
{
	T2xDrawTableChartInterior::refreshData(Table,qwInter);
	TDrawTable::SAttrCell* p;
	if( fd->VerticalSplit )
	{
	for( int Row=2; Row<DrawTable->RowCount ; ++Row )
	for( int Col=1; Col<DrawTable->ColCount ; ++Col )
	{
		p=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(Col,Row);
		if( p->BackgroundColor==clYellow )
			p->BackgroundColor=clAqua;
		if( p->BackgroundColor==clOlive )
			p->BackgroundColor=clBlue;
	}
	for( int Col=3; Col<DrawTable->ColCount ; Col+=3 )
		for( int Row=2; Row<DrawTable->RowCount ; ++Row )
		{
		try{
			p=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(Col,Row);
			if(!DrawTable->VarStrings->Strings[p->IndexData].IsEmpty() &&
                DrawTable->VarStrings->Strings[p->IndexData]>0.0)
				p->FontColor=clRed;
			else
				if(p->BackgroundColor==clBlue)
					p->FontColor=clWhite;
				else
					p->FontColor=clBlack;
		}
		catch(Exception &e)
		{
		}
		}
	}
	else
	{
	for( int Row=1; Row<DrawTable->RowCount ; ++Row )
	for( int Col=2; Col<DrawTable->ColCount ; ++Col )
	{
		p=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(Col,Row);
		if( p->BackgroundColor==clYellow )
			p->BackgroundColor=clAqua;
		if( p->BackgroundColor==clOlive )
			p->BackgroundColor=clBlue;
	}
	for( int Row=3; Row<DrawTable->RowCount ; Row+=3 )
		for( int Col=2; Col<DrawTable->ColCount ; ++Col )
		{
		try{
			p=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(Col,Row);
			if( !DrawTable->VarStrings->Strings[p->IndexData].IsEmpty() &&
                DrawTable->VarStrings->Strings[p->IndexData]>0.0)
				p->FontColor=clRed;
			else
				if(p->BackgroundColor==clBlue)
					p->FontColor=clWhite;
				else
					p->FontColor=clBlack;
		}
		catch(Exception &e)
		{
		}
		}
	}
}
//---------------------------------------------------------------------------
void __fastcall TLimitPowerInterior::selectData( TOraQuery *qwInter )
{
  unsigned long selectRows,rowCount;
	unsigned short year, month, day;
	unsigned short hour, minute, sec, msec;
	int CountOnProgress=6;
	long iClones,clones,IdGroup, stepProfile,j;
	AnsiString FirstDate, LastDate, lDate;
	AnsiString grouping,table;
  AnsiString paramlist, decnsourcesec, decnsourcef,decperiod;
	struct TempStruct{
		long Count;
		double A;
    int nsource;
    char isvalid[32];
    TempStruct(){ZeroMemory(this,sizeof(*this));}
	}*TempDatOracle;
	TCloneItem *pDatOracle;
  double sumFloat;

	rowCount=RowCount+1;
	clones=Clones+1;
	pDatOracle=datOracle;
	for( iClones=0; (unsigned long)iClones<clones*SubColumns()*rowCount ;++iClones,++pDatOracle ){
                ZeroMemory(pDatOracle->isvalid,sizeof(pDatOracle->isvalid));
		pDatOracle->val=-MAXFLOAT;
                }

	fd->DateTime.DecodeDate(&year, &month, &day);

	switch( fd->StepProfile ){
  	case TFormDescr::stpHour:
	//GRB TEST 10.02.2020
	{
		if((IsShiftTimeZona)&&(IsDayShiftMonth(fd,10))) {
                        fd->DateTime.DecodeTime(&hour, &minute, &sec, &msec);
                        FirstDate=(TDateTime(year, month, day)+1.157407407407e-5).FormatString(DateTimeFormat);
	  	        LastDate=(TDateTime(year, month,day)+1+(hour/24.0+60/1440.0)).FormatString(DateTimeFormat);
                        stepProfile=60.0*PowerProfile;
                        break;
		}
	}
        //END GRB TEST
	    FirstDate=(TDateTime(year, month, day)+1.157407407407e-5).FormatString(DateTimeFormat);
	  	LastDate=(TDateTime(year, month,day)+1).FormatString(DateTimeFormat);
      stepProfile=60.0*PowerProfile;
  		break;
    case TFormDescr::stpMinute:
	    fd->DateTime.DecodeTime(&hour, &minute, &sec, &msec);
	  	FirstDate=(TDateTime(year, month, day)+hour/24.0+minute/1440.0+1.157407407407e-5).FormatString(DateTimeFormat);
		  LastDate=(TDateTime(year, month,day)+(RowCount*StepPROFILE/3600.0+hour+minute/60.0)/24.0).FormatString(DateTimeFormat);
  		stepProfile=StepPROFILE;
    	break;
	}

  TempDatOracle=new struct TempStruct[rowCount];

  qwInter->Params->Clear();
  qwInter->SQL->Text="begin "+SchemeName+"interior_pg.LimitPowerInt_selectData_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11);end;";

    for(iClones=0; iClones<clones; ++iClones){
    IdGroup=(long)NamesClones->Objects[iClones];

    qwInter->ParamByName("par11")->ParamType=ptOutput;
    qwInter->ParamByName("par11")->DataType=ftCursor;

    qwInter->ParamByName("par1")->AsInteger=fd->IsPoints?1:0; ;
    qwInter->ParamByName("par2")->AsInteger=fd->StepProfile;
    qwInter->ParamByName("par3")->AsInteger=fd->CodeTemplate;
    qwInter->ParamByName("par4")->AsString=IntToStr(RowCount);

    qwInter->ParamByName("par5")->AsInteger=PowerProfile;
    qwInter->ParamByName("par6")->AsInteger=stepProfile;

    qwInter->ParamByName("par7")->AsString=FirstDate;
    qwInter->ParamByName("par8")->AsString=LastDate;
    qwInter->ParamByName("par9")->AsInteger=IdGroup;
    qwInter->ParamByName("par10")->AsInteger=fd->GetPeriod(fd->DateTime);

    qwInter->Execute();
    int i=0;
    while(!qwInter->Eof&&i<(int)rowCount){
      TempDatOracle[i].Count= qwInter->FieldByName("BGroup")->AsInteger;
      TempDatOracle[i].A= qwInter->FieldByName("AParam")->AsFloat;
      if(qwInter->FieldByName("decnsour")->AsString.Length()>=22)
        strcpy(TempDatOracle[i].isvalid,qwInter->FieldByName("decnsour")->AsString.c_str());

      qwInter->Next();
      i++;
    }
    qwInter->Close();

    selectRows=i;
    if( CountOnProgress ){
      --CountOnProgress;
		  OnProgressBarStepBy(this);//20
		}
		for( sumFloat=0.0,j=0;(unsigned long)j<selectRows;++j){
      pDatOracle=datOracle+(iClones*SubColumns()+TempDatOracle[j].Count*clones*SubColumns());
  		sumFloat+=pDatOracle->val=TempDatOracle[j].A;
      strncpy(pDatOracle->isvalid,TempDatOracle[j].isvalid,sizeof(pDatOracle->isvalid));
		}
		if(selectRows)
      (datOracle+iClones*SubColumns())->val=-MAXFLOAT;//sumFloat/selectRows;
	}

	struct{
    long
    MORNING_START,
		MORNING_END,
		EVENING_START,
		EVENING_END;
	} TempLimitHour[2];

	struct{
		double
		EA,
		ER,
		PA_MORNING,
		PA_EVENING,
		PR_MORNING,
		PR_EVENING;
	} TempLimit[2];

  for(iClones=0; iClones<=Clones; ++iClones){
    IdGroup=(long)NamesClones->Objects[iClones];
    qwInter->Params->Clear();
    qwInter->SQL->Text="begin "+SchemeName+"interior_pg.LimitPowerInt_selectData2_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7);end;";
    qwInter->ParamByName("par7")->ParamType=ptOutput;
    qwInter->ParamByName("par7")->DataType=ftCursor;

    qwInter->ParamByName("par1")->AsInteger= 1;
    qwInter->ParamByName("par2")->AsInteger= stepProfile;
    qwInter->ParamByName("par3")->AsString= FirstDate;
    qwInter->ParamByName("par4")->AsString= LastDate;
    qwInter->ParamByName("par5")->AsInteger= IdGroup;
    qwInter->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);

    qwInter->Execute();
    TempLimitHour[0].MORNING_START=qwInter->FieldByName("MORNING_START")->AsInteger;
    TempLimitHour[0].MORNING_END=qwInter->FieldByName("MORNING_END")->AsInteger;
    TempLimitHour[0].EVENING_START=qwInter->FieldByName("EVENING_START")->AsInteger;
    TempLimitHour[0].EVENING_END= qwInter->FieldByName("EVENING_end")->AsInteger;
    if(qwInter->Eof){
      qwInter->Close();
      continue;
    }
    qwInter->Close();

    TempLimitHour[1]=TempLimitHour[0];
		lDate=LastDate;
		LastDate=FirstDate;

    qwInter->Params->Clear();
    qwInter->SQL->Text="begin "+SchemeName+"interior_pg.LimitPowerInt_selectData2_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7);end;";
    qwInter->ParamByName("par7")->ParamType=ptOutput;
    qwInter->ParamByName("par7")->DataType=ftCursor;

    qwInter->ParamByName("par3")->AsString= FirstDate;
    qwInter->ParamByName("par4")->AsString= LastDate;
    qwInter->ParamByName("par2")->AsInteger= stepProfile;
    qwInter->ParamByName("par1")->AsInteger= 0;
    qwInter->ParamByName("par5")->AsInteger= IdGroup;
    qwInter->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);
    qwInter->Execute();
    TempLimitHour[0].MORNING_START=qwInter->FieldByName("MORNING_START")->AsInteger;
    TempLimitHour[0].MORNING_END=qwInter->FieldByName("MORNING_END")->AsInteger;
    TempLimitHour[0].EVENING_START=qwInter->FieldByName("EVENING_START")->AsInteger;
    TempLimitHour[0].EVENING_END= qwInter->FieldByName("EVENING_end")->AsInteger;
    if(qwInter->Eof){
      qwInter->Close();
      continue;
    }
    qwInter->Close();

    LastDate=lDate;

    qwInter->Params->Clear();
    qwInter->SQL->Text="begin "+SchemeName+"interior_pg.LimitPowerInt_selectData3_p(:par1,:par2,:par3,:par4);end;";
    qwInter->ParamByName("par4")->ParamType=ptOutput;
    qwInter->ParamByName("par4")->DataType=ftCursor;
    qwInter->ParamByName("par1")->AsInteger=fd->CodeTemplate;
    qwInter->ParamByName("par2")->AsString=LastDate;
    qwInter->ParamByName("par3")->AsInteger=IdGroup;
    qwInter->Execute();
    switch( fd->CodeTemplate ){
			case APBO_F:
        TempLimit[0].ER=qwInter->FieldByName("EA")->AsFloat;
        TempLimit[0].PA_MORNING=qwInter->FieldByName("PA_MORNING")->AsFloat;
        TempLimit[0].PA_EVENING=qwInter->FieldByName("PA_EVENING")->AsFloat;
				break;
			case RPBO_F:
        TempLimit[0].ER=qwInter->FieldByName("EA")->AsFloat;
        TempLimit[0].PA_MORNING=qwInter->FieldByName("PA_MORNING")->AsFloat;
        TempLimit[0].PA_EVENING=qwInter->FieldByName("PA_EVENING")->AsFloat;
				break;
		}
    if(qwInter->Eof){
      qwInter->Close();
      continue;
    }
    qwInter->Close();

		TempLimit[1]=TempLimit[0];
    lDate=LastDate;
		LastDate=FirstDate;

    qwInter->Params->Clear();
    qwInter->SQL->Text="begin "+SchemeName+"interior_pg.LimitPowerInt_selectData3_p(:par1,:par2,:par3,:par4);end;";
    qwInter->ParamByName("par4")->ParamType=ptOutput;
    qwInter->ParamByName("par4")->DataType=ftCursor;
    qwInter->ParamByName("par1")->AsInteger=fd->CodeTemplate;
    qwInter->ParamByName("par2")->AsString=LastDate;
    qwInter->ParamByName("par3")->AsInteger=IdGroup;
    qwInter->Execute();
    switch( fd->CodeTemplate ){
			case APBO_F:
        TempLimit[0].ER=qwInter->FieldByName("EA")->AsFloat;
        TempLimit[0].PA_MORNING=qwInter->FieldByName("PA_MORNING")->AsFloat;
        TempLimit[0].PA_EVENING=qwInter->FieldByName("PA_EVENING")->AsFloat;
				break;
			case RPBO_F:
        TempLimit[0].ER=qwInter->FieldByName("EA")->AsFloat;
        TempLimit[0].PA_MORNING=qwInter->FieldByName("PA_MORNING")->AsFloat;
        TempLimit[0].PA_EVENING=qwInter->FieldByName("PA_EVENING")->AsFloat;
				break;
		}
    if(qwInter->Eof){
      qwInter->Close();
      continue;
    }
    qwInter->Close();

		if( CountOnProgress ){
			--CountOnProgress;
			OnProgressBarStepBy(this);//20
		}

		pDatOracle=	datOracle+iClones*SubColumns();
		switch( fd->CodeTemplate ){
			case APBO_F:
				(pDatOracle+1)->val=-MAXFLOAT;//TempLimit[0].EA;
				break;
			case RPBO_F:
				(pDatOracle+1)->val=-MAXFLOAT;//TempLimit[0].ER;
				break;
		}
		if((pDatOracle+1)->val>-MAXFLOAT)
			(pDatOracle+2)->val = pDatOracle->val - ((pDatOracle+1)->val/*/=24.0*/);

		pDatOracle = datOracle+(clones+iClones)*SubColumns();
		for( j=1;j<=RowCount;++j){
			if( j>=TempLimitHour[0].MORNING_START && j<TempLimitHour[0].MORNING_END){
				switch( fd->CodeTemplate ){
					case APBO_F:
						(pDatOracle+1)->val=TempLimit[0].PA_MORNING;
						break;
					case RPBO_F:
						(pDatOracle+1)->val=TempLimit[0].PR_MORNING;
						break;
				}
				if((pDatOracle+1)->val>-MAXFLOAT)
					(pDatOracle+2)->val = pDatOracle->val - (pDatOracle+1)->val;
				pDatOracle+=clones*SubColumns();
				continue;
			}
			if( j>=TempLimitHour[0].EVENING_START && j<TempLimitHour[0].EVENING_END){
				switch( fd->CodeTemplate ){
					case APBO_F:
						(pDatOracle+1)->val=TempLimit[0].PA_EVENING;
						break;
					case RPBO_F:
						(pDatOracle+1)->val=TempLimit[0].PR_EVENING;
						break;
				}
				if((pDatOracle+1)->val>-MAXFLOAT)
					(pDatOracle+2)->val = pDatOracle->val - (pDatOracle+1)->val;
				pDatOracle+=clones*SubColumns();
				continue;
			}
			if( j>=TempLimitHour[1].MORNING_START && j<TempLimitHour[1].MORNING_END){
				switch( fd->CodeTemplate ){
					case APBO_F:
						(pDatOracle+1)->val=TempLimit[1].PA_MORNING;
						break;
					case RPBO_F:
						(pDatOracle+1)->val=TempLimit[1].PR_MORNING;
						break;
				}
				if((pDatOracle+1)->val>-MAXFLOAT)
					(pDatOracle+2)->val = pDatOracle->val - (pDatOracle+1)->val;
				pDatOracle+=clones*SubColumns();
				continue;
			}
			if( j>=TempLimitHour[0].EVENING_START && j<TempLimitHour[0].EVENING_END){
				switch( fd->CodeTemplate ){
					case APBO_F:
						(pDatOracle+1)->val=TempLimit[1].PA_EVENING;
						break;
					case RPBO_F:
						(pDatOracle+1)->val=TempLimit[1].PR_EVENING;
						break;
				}
				if((pDatOracle+1)->val>-MAXFLOAT)
					(pDatOracle+2)->val = pDatOracle->val - (pDatOracle+1)->val;
				pDatOracle+=clones*SubColumns();
				continue;
			}
			pDatOracle+=clones*SubColumns();
		}
	}

	delete [] TempDatOracle;
	while( CountOnProgress ){
		--CountOnProgress;
		OnProgressBarStepBy(this);//20
	}
}
//---------------------------------------------------------------------------
void __fastcall TLimitPowerInterior::formDescr( void )
{
  fd->IdGroup = GroupJump(fd->IdGroup);

	//Заполняем необходимые поля описания формы
	Clones = 0;

  dmMain->oqInterCursor->Params->Clear();
  dmMain->oqInterCursor->SQL->Text="begin "+SchemeName+"interior_pg.LimitPowerInt_formDescr_p(:par1,:par2,:par3);end;";
  dmMain->oqInterCursor->ParamByName("par3")->ParamType=ptOutput;
  dmMain->oqInterCursor->ParamByName("par3")->DataType=ftCursor;
  dmMain->oqInterCursor->ParamByName("par1")->AsInteger= fd->IdGroup;
  dmMain->oqInterCursor->ParamByName("par2")->AsInteger=fd->GetPeriod(fd->DateTime);

  dmMain->oqInterCursor->Execute();
  NamesClones->Clear();
  while(!dmMain->oqInterCursor->Eof){
    NamesClones->AddObject(dmMain->oqInterCursor->FieldByName("name")->AsString,(TObject*)dmMain->oqInterCursor->FieldByName("gid")->AsInteger);
    dmMain->oqInterCursor->Next();
    Clones++;
  }
  dmMain->oqInterCursor->Close();
  
  if(!Clones)
		throw(Exception(Reconst_smes120_2));
  else
    Clones--;

	if(!Clones){
		fd->SummGroup=true;
		Clones=1;
  	NamesClones->AddObject("",(TObject*)0);
	}
}
//---------------------------------------------------------------------------
long __fastcall TLimitPowerInterior::SubColumns(void)
{
	return 3;
}
//---------------------------------------------------------------------------

AnsiString __fastcall TLimitPowerInterior::GetSubColumnsNames(int n)
{
	static AnsiString staticNameColumns1[3]={Reconst_smes120_3,Reconst_smes120_4,Reconst_smes120_5};
	return staticNameColumns1[n];
}
//---------------------------------------------------------------------------
void __fastcall TLimitPowerInterior::clonesInColumns(void)
{
	T2xDrawTableChartInterior::clonesInColumns();
	TDrawTable::SAttrCell* p;
	for( int Row=2; Row<DrawTable->RowCount ; ++Row )
	for( int Col=1; Col<DrawTable->ColCount ; ++Col )
	{
		p=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(Col,Row);
		if( p->BackgroundColor==clYellow )
			p->BackgroundColor=clAqua;
		if( p->BackgroundColor==clOlive )
			p->BackgroundColor=clBlue;
	}
	for( int Col=3; Col<DrawTable->ColCount ; Col+=3 )
		for( int Row=2; Row<DrawTable->RowCount ; ++Row )
		{
		try{
			p=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(Col,Row);
			if(!DrawTable->VarStrings->Strings[p->IndexData].IsEmpty() &&
                DrawTable->VarStrings->Strings[p->IndexData]>0.0)
				p->FontColor=clRed;
		}
		catch(Exception &e)
		{
		}
		}
}
//---------------------------------------------------------------------------
void __fastcall TLimitPowerInterior::clonesInRows(void)
{
	T2xDrawTableChartInterior::clonesInRows();
	TDrawTable::SAttrCell* p;
	for( int Row=1; Row<DrawTable->RowCount ; ++Row )
	for( int Col=2; Col<DrawTable->ColCount ; ++Col )
	{
		p=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(Col,Row);
		if( p->BackgroundColor==clYellow )
			p->BackgroundColor=clAqua;
		if( p->BackgroundColor==clOlive )
			p->BackgroundColor=clBlue;
	}
	for( int Row=3; Row<DrawTable->RowCount ; Row+=3 )
    for( int Col=2; Col<DrawTable->ColCount ; ++Col )
	try{
	    p=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(Col,Row);
		if(!DrawTable->VarStrings->Strings[p->IndexData].IsEmpty() &&
            DrawTable->VarStrings->Strings[p->IndexData]>0.0)
			p->FontColor=clRed;
    }
	catch(Exception &e)
	{
	}
}
//---------------------------------------------------------------------------
void __fastcall TLimitPowerInterior::ChartFXColumns(long ARow)
{
}
//---------------------------------------------------------------------------
void __fastcall TLimitPowerInterior::ChartFXLines(long AClone)
{
    const CntPROFILE = LenPROFILE/StepPROFILE+100;
   int /*i,*/j,MaxRowCount;
   TCloneItem *ptrDatOracle;
   double temp;
   AnsiString Str, LabelDateFormat,ss;
   TLineSeries *pSeries[AMOUNTSERIES];
   TDateTime *fDate = NULL;
   unsigned short year,month,day;
   unsigned short curr_year,curr_month,curr_day;
   unsigned short hour, minute, sec, msec;
   TDateTime tmpDateTime;

    try{
        fDate = new TDateTime[CntPROFILE];
        for(int i=0;i<pChart->SeriesCount(); i++)
            pChart->Series[i]->Active = false;

   pSeries[0]=new TLineSeries(pChart);
   pSeries[0]->ParentChart=pChart;
   pSeries[0]->Pointer->Visible = FormSetupMonitors->cbPoints->Checked;
   pSeries[0]->Pointer->Style = psCircle;
   pSeries[0]->Pointer->HorizSize = 3;
   pSeries[0]->Pointer->VertSize = 3;
   pSeries[0]->Marks->Visible = FormSetupMonitors->cbMarks->Checked;
   pSeries[0]->Marks->Clip = true;
   pSeries[0]->XValues->Order=loNone;
   pSeries[0]->YValues->Order=loDescending;
   pSeries[0]->Marks->Style=smsValue;
   pSeries[0]->LinePen->Width=3;
   pSeries[0]->XValues->DateTime=false;//true;
   Str=GetSubColumnsNames(0);
   pSeries[0]->Title=Str;

   Str=NamesClones->Strings[AClone];
   fd->DateTime.DecodeDate( &year, &month, &day);
   TDateTime::CurrentDate().DecodeDate( &curr_year, &curr_month, &curr_day);
   MaxRowCount=RowCount;
   switch(fd->StepProfile)
   {
   case TFormDescr::stpHour:
      Str = Str+" "+fd->DateTime.FormatString("ddddd");
      tmpDateTime=TDateTime(year,month,day);
      LabelDateFormat = "t";
//      for( j=0; j<=RowCount && tmpDateTime<=TDateTime::CurrentDateTime(); ++j ){
      for( j=0; j<=RowCount; ++j ){
         tmpDateTime+=1.0/RowCount;
         fDate[j]=tmpDateTime;//temp-floor(temp);
      }
      MaxRowCount=j-1;
      break;
   case TFormDescr::stpMinute:
      Str = Str+" "+fd->DateTime.FormatString("ddddd");
      fd->DateTime.DecodeTime(&hour, &minute, &sec, &msec);
      tmpDateTime=TDateTime(year,month,day)+hour/24.0;
      LabelDateFormat = "t";
      tmpDateTime=TDateTime(year,month,day)+hour/24.0+minute/1440.0;
//      for( j=0; j<=RowCount && tmpDateTime<=TDateTime::CurrentDateTime(); ++j ){
      for( j=0; j<=RowCount ; ++j ){
         tmpDateTime+=StepPROFILE* 1.157407407407e-5;
//       tmpDateTime+=6.944444444444e-4;
         fDate[j]=tmpDateTime;//temp-floor(temp);
      }
      MaxRowCount=j-1;
      break;
   }
   pChart->Title->Text->Text=Str;    //     [CHART_TOPTIT]
   YMaxVal = 0;
   YMinVal = 0;
   for( j=0; j<1/*SubColumns()-1*/; ++j ){
      ptrDatOracle=datOracle+(Clones+1+AClone)*SubColumns()+j;
      for(int i=0; i<MaxRowCount; ++i )
      {
         if(ptrDatOracle->val<=-MAXFLOAT){
            temp=0;
            pSeries[j]->AddNullXY(i/*fDate[i-1]*/,temp,fDate[i].FormatString(LabelDateFormat));
         }else{
            temp=ptrDatOracle->val;
            pSeries[j]->AddXY(i/*fDate[i-1]*/,temp,fDate[i].FormatString(LabelDateFormat),(TColor)clTeeColor);
         }
         YMaxVal = max(temp,YMaxVal);
         YMinVal = min(temp,YMinVal);
         if(i<MaxRowCount-1) ptrDatOracle+=(Clones+1)*SubColumns();
      }
   }

   int zz=0;
   bool newser=true;
   ptrDatOracle=datOracle+(Clones+1+AClone)*SubColumns()+1;
   for(int i=0; i<MaxRowCount; ++i ){
      if(ptrDatOracle->val<=-MAXFLOAT){
         newser=true;
         if(i<MaxRowCount-1)
            ptrDatOracle+=(Clones+1)*SubColumns();
         continue;
      }
      if(newser){
         newser=false;
         zz++;
         pSeries[zz]=new TLineSeries(pChart);
         pSeries[zz]->ParentChart=pChart;
         pSeries[zz]->Pointer->Visible = FormSetupMonitors->cbPoints->Checked;
         pSeries[zz]->Pointer->Style = psCircle;
         pSeries[zz]->Pointer->HorizSize = 3;
         pSeries[zz]->Pointer->VertSize = 3;
         pSeries[zz]->Marks->Visible = FormSetupMonitors->cbMarks->Checked;
         pSeries[zz]->Marks->Clip = true;
         pSeries[zz]->XValues->Order=loNone;
         pSeries[zz]->YValues->Order=loDescending;
         pSeries[zz]->Marks->Style=smsValue;
         pSeries[zz]->LinePen->Width=3;
         pSeries[zz]->XValues->DateTime=false;//true;
         Str=GetSubColumnsNames(1);
         pSeries[zz]->Title=Str;
         if(zz>1){
            pSeries[zz]->ShowInLegend=false;
         }
      }
      temp=ptrDatOracle->val;
      if(zz==1)
         pSeries[zz]->AddXY(i/*fDate[i-1]*/,temp,fDate[i].FormatString(LabelDateFormat),(TColor)clTeeColor);
      else
         pSeries[zz]->AddXY(i/*fDate[i-1]*/,temp,fDate[i].FormatString(LabelDateFormat),pSeries[1]->SeriesColor);
      YMaxVal = max(temp,YMaxVal);
      YMinVal = min(temp,YMinVal);
      if(i<MaxRowCount-1)
         ptrDatOracle+=(Clones+1)*SubColumns();
   }
   if(zz==0){
      zz++;
      pSeries[zz]=new TLineSeries(pChart);
      pSeries[zz]->ParentChart=pChart;
      pSeries[zz]->Pointer->Visible = FormSetupMonitors->cbPoints->Checked;
      pSeries[zz]->Pointer->Style = psCircle;
      pSeries[zz]->Pointer->HorizSize = 3;
      pSeries[zz]->Pointer->VertSize = 3;
      pSeries[zz]->Marks->Visible = FormSetupMonitors->cbMarks->Checked;
      pSeries[zz]->Marks->Clip = true;
      pSeries[zz]->XValues->Order=loNone;
      pSeries[zz]->YValues->Order=loDescending;
      pSeries[zz]->Marks->Style=smsValue;
      pSeries[zz]->LinePen->Width=3;
      pSeries[zz]->XValues->DateTime=false;//true;
      Str=GetSubColumnsNames(1);
      pSeries[zz]->Title=Str;
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
void __fastcall TLimitPowerInterior::PopupMenuBaseFormPopup(TObject *Sender)
{
	T2xDrawTableChartInterior::PopupMenuBaseFormPopup(Sender);
	if( dynamic_cast<TBaseMonitorForm*>(Owner) )
	{
		TBaseMonitorForm* pOwner=dynamic_cast<TBaseMonitorForm*>(Owner);
		pOwner->SmallFont->Checked=!pOwner->isSmallFont;
		pOwner->SmallFont2->Checked=!pOwner->isSmallFont;
		pOwner->ChartFXColumns->Enabled=false;
	}
}
//---------------------------------------------------------------------------
AnsiString __fastcall TLimitPowerInterior::GetUnitOfEnergy()
{
    AnsiString d = "";
	switch( fd->CodeTemplate )
	{
	case APBO_F:
        d = "MВт";
        break;
    case RPBO_F:
        d = "MВАр";
        break;
	}
    return d;
}
//---------------------------------------------------------------------------
