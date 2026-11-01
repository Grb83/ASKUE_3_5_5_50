//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "Interior2.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
__fastcall T2Interior::T2Interior(TComponent* Owner,TSplitterForm *s,
	TFormDescr* f,Classes::TNotifyEvent n):T2xDrawTableChartInterior(Owner,s,f,n)
{
}
//---------------------------------------------------------------------------
__fastcall T2Interior::~T2Interior(void)
{
}
//---------------------------------------------------------------------------

void __fastcall T2Interior::selectData( TOraQuery *qwInter )
{
	unsigned long j,selectRows,clones,rowCount;
  AnsiString PowKoef = ""; // Коэффициент для перевода в мощность Для ГН и Тех. профиля
  int CountOnProgress=6;
	long iClones,IdGroup;
	AnsiString sql;// paramlist, decnsourcesec, decnsourcef,decperiod;
	char FirstDate[20], LastDate[20];
	struct TempStruct{
		long Count;
		double A;
    double B;
    char isvalid[32];
    TempStruct(){ZeroMemory(this,sizeof(*this));}
	};
  struct TempStruct *TempDatOracle=NULL;
  short *ind=NULL;
	TCloneItem *pDatOracle;
  try{
    rowCount=RowCount+1;
	  clones=Clones+1;
    pDatOracle=datOracle;
	  for( iClones=0; (unsigned long)iClones<clones*SubColumns()*rowCount ;++iClones,++pDatOracle ){
		  pDatOracle->val=-MAXFLOAT;
      ZeroMemory(pDatOracle->isvalid,sizeof(pDatOracle->isvalid));
    }
    switch (fd->CodeTemplate){
      case AEBO_REBO_POW_F:
      case AERO_AEDO_POW_F:
      case RERO_REDO_POW_F:
      case RQ1_RQ4_POW_F:
      case RQ2_RQ3_POW_F:
        switch (fd->StepProfile){
          case TFormDescr::stpHour:
            PowKoef =  "*"+IntToStr((int)(60.0/PowerProfile));
            break;
          case TFormDescr::stpMinute:
            PowKoef =  "*"+IntToStr((int)(3600.0/StepPROFILE));
            break;
        }
        break;
    }
       // ChoiceOfTimeDiap(grouping, FirstDate, LastDate);
    ChoiceOfTimeDiap(FirstDate, LastDate);
    ind = new short[rowCount*IND_CNT];
    TempDatOracle=new struct TempStruct[rowCount*IND_CNT];
    qwInter->Params->Clear();
    qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.Interior2_selectData_p(:par7, \
                              :par8,:par9,:par10,:par11,:par12,:par13,:par1,:par2,:par3,:par4,:par5,:par6,:par14); end;";
    for(iClones=0; iClones<=Clones; ++iClones){
      IdGroup=(long)NamesClones->Objects[iClones];
      //   -----------------------------------------------------------------------------
      qwInter->ParamByName("par14")->ParamType=ptOutput;
      qwInter->ParamByName("par14")->DataType=ftCursor;

      qwInter->ParamByName("par7")->AsInteger=fd->IsPoints?1:0; ;
      qwInter->ParamByName("par8")->AsInteger=fd->StepProfile;
      qwInter->ParamByName("par9")->AsInteger=fd->CodeTemplate;
      qwInter->ParamByName("par10")->AsString=IntToStr(RowCount);
      qwInter->ParamByName("par11")->AsInteger=fd->bird;
      qwInter->ParamByName("par12")->AsInteger=(int)PowerProfile;
      if(fd->StepProfile==TFormDescr::stpHour)
        qwInter->ParamByName("par13")->AsInteger=24*(60/PowerProfile);
      else
        qwInter->ParamByName("par13")->AsInteger=StepPROFILE;
      //  ---------------------------------------------------------------------------------
      qwInter->ParamByName("par1")->AsString=FirstDate;
      qwInter->ParamByName("par2")->AsString=LastDate;
      qwInter->ParamByName("par3")->AsInteger=IdGroup;
      qwInter->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);
      qwInter->ParamByName("par4")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
      qwInter->ParamByName("par5")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);

      qwInter->Execute();
      int i=0;
      while(!qwInter->Eof&&i<(int)rowCount){
        if(!qwInter->FieldByName("BGroup")->IsNull)
        TempDatOracle[i].Count = qwInter->FieldByName("BGroup")->AsInteger;
        if(!qwInter->FieldByName("AParam")->IsNull){
          ind [1*rowCount+i]=0;
          TempDatOracle[i].A= qwInter->FieldByName("AParam")->AsFloat;
        }else
          ind [1*rowCount+i]=-1;
        if(!qwInter->FieldByName("BParam")->IsNull){
          ind [2*rowCount+i]=0;
          TempDatOracle[i].B= qwInter->FieldByName("BParam")->AsFloat;
        }else
          ind [2*rowCount+i]=-1;
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
      for( j=0;j<selectRows;++j){
        pDatOracle=datOracle+(iClones*SubColumns()+TempDatOracle[j].Count*((Clones+1)*SubColumns()));
        if(PowKoef.IsEmpty()||j>0){
          if(ind[1*rowCount+j]>-1) pDatOracle->val=TempDatOracle[j].A;
            strncpy(pDatOracle->isvalid,TempDatOracle[j].isvalid,sizeof(pDatOracle->isvalid));
          if(ind[2*rowCount+j]>-1) (pDatOracle+1)->val = TempDatOracle[j].B;
            strncpy((pDatOracle+1)->isvalid,TempDatOracle[j].isvalid,sizeof(pDatOracle->isvalid));
        }
      }
      CheckPrecipice(rowCount, iClones, SubColumns(), Clones, datOracle); //add by NNV
    }//end for(iClones=0; iClones<=Clones; ++iClones)

    delete [] TempDatOracle;
    delete []ind;
    while(CountOnProgress){
      --CountOnProgress;
      OnProgressBarStepBy(this);//20
    }
  }catch(Exception &e){
    if(TempDatOracle)
      delete []TempDatOracle;
    if(ind)
      delete ind;
    while(CountOnProgress){
      --CountOnProgress;
		  OnProgressBarStepBy(this);//20
    }
    throw;
  }
}
//---------------------------------------------------------------------------
 void __fastcall T2Interior::formDescr( void )
{
  AnsiString SubSelect;
  fd->IdGroup = GroupJump(fd->IdGroup);
	//Заполняем необходимые поля описания формы
	Clones = 0;
  dmMain->oqInterCursor->Params->Clear();
  dmMain->oqInterCursor->SQL->Text=" begin "+SchemeName+"interior_pg.Interior_formDescr_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7); end;";
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
  //24.08.2022 GRB Change - баг с обрезанием длинных имен колонок при сохранении в файл - меняем короткое имя группы на полное
  //NamesClones->AddObject(fd->ShortNameGroup,(TObject*)fd->IdGroup);
    NamesClones->AddObject(fd->NameGroup,(TObject*)fd->IdGroup);
  while(!dmMain->oqInterCursor->Eof){
    Clones++;
  	fd->strGroup(dmMain->oqInterCursor->FieldByName("name")->AsString.c_str());
		NamesClones->AddObject(dmMain->oqInterCursor->FieldByName("name")->AsString,(TObject*)dmMain->oqInterCursor->FieldByName("mid")->AsInteger);
    dmMain->oqInterCursor->Next();
  }

  dmMain->oqInterCursor->Close();
	if(!Clones){
		fd->SummGroup=true;
      //24.08.2022 GRB Change - баг с обрезанием длинных имен колонок при сохранении в файл - меняем короткое имя группы на полное
    //NamesClones->AddObject(fd->ShortNameGroup,(TObject*)fd->IdGroup);
        NamesClones->AddObject(fd->NameGroup,(TObject*)fd->IdGroup);
		Clones=1;
	}
}
//---------------------------------------------------------------------------
long __fastcall T2Interior::SubColumns(void)
{
	return 2;
}
//---------------------------------------------------------------------------
AnsiString __fastcall T2Interior::GetSubColumnsNames(int n)
{
  AnsiString staticNameColumns1[2]={Reconst_smes104_1.c_str(),Reconst_smes104_2.c_str()};
  AnsiString staticNameColumns2[2]={Reconst_smes104_3.c_str(),Reconst_smes104_4.c_str()};
	AnsiString staticNameColumns3[2]={Reconst_smes104_5.c_str(),Reconst_smes104_6.c_str()};

	AnsiString staticNameColumns4[2]={Reconst_smes104_7.c_str(),Reconst_smes104_8.c_str()};
	AnsiString staticNameColumns5[2]={Reconst_smes104_9.c_str(),Reconst_smes104_10.c_str()};
	AnsiString staticNameColumns6[2]={Reconst_smes104_11.c_str(),Reconst_smes104_12.c_str()};

	AnsiString staticNameColumns7[2]={Reconst_smes104_13.c_str(),Reconst_smes104_14.c_str()};
	AnsiString staticNameColumns8[2]={Reconst_smes104_15.c_str(),Reconst_smes104_16.c_str()};
	AnsiString staticNameColumns9[2]={Reconst_smes104_17.c_str(),Reconst_smes104_18.c_str()};
	AnsiString staticNameColumns10[2]={Reconst_smes104_19.c_str(),Reconst_smes104_20.c_str()};
  //------------VNB 12.12.2008
  if(PowerCoeff==1){
    staticNameColumns1[0]=Reconst_smes104_21.c_str();
    staticNameColumns1[1]=Reconst_smes104_22.c_str();

    staticNameColumns2[0]=Reconst_smes104_23.c_str();
    staticNameColumns2[1]=Reconst_smes104_24.c_str();

	  staticNameColumns3[0]=Reconst_smes104_25.c_str();
    staticNameColumns3[1]= Reconst_smes104_26.c_str();

    staticNameColumns4[0]=Reconst_smes104_27.c_str();
    staticNameColumns4[1]= Reconst_smes104_28.c_str();

    staticNameColumns5[0]=Reconst_smes104_29.c_str();
    staticNameColumns5[1]=Reconst_smes104_30.c_str();

    staticNameColumns6[0]=Reconst_smes104_31.c_str();
    staticNameColumns6[1]=Reconst_smes104_32.c_str();

	  staticNameColumns7[0]=Reconst_smes104_33.c_str();
    staticNameColumns7[1]=Reconst_smes104_34.c_str();

	  staticNameColumns8[0]=Reconst_smes104_35.c_str();
    staticNameColumns8[1]=Reconst_smes104_36.c_str();

	  staticNameColumns9[0]=Reconst_smes104_37.c_str();
    staticNameColumns9[1]=Reconst_smes104_38.c_str();

	  staticNameColumns10[0]=Reconst_smes104_39.c_str();
    staticNameColumns10[1]=Reconst_smes104_40.c_str();
  }
  //-------------------VNB end;
  if(fd->StepProfile==TFormDescr::stpHour||fd->StepProfile==TFormDescr::stpMinute){
    switch( fd->CodeTemplate ){
      case AEBO_REBO_POW_F:
        return staticNameColumns4[n];
      case AERO_AEDO_POW_F:
        return staticNameColumns5[n];
      case RERO_REDO_POW_F:
        return staticNameColumns6[n];
      case RQ1_RQ4_POW_F:
        return staticNameColumns8[n];
      case RQ2_RQ3_POW_F:
        return staticNameColumns10[n];
    }
  }
  switch( fd->CodeTemplate ){
    case AEBO_REBO_F:
	  case AEBO_REBO_POW_F:
    case AEBO_REBO_SUM_F:
      return staticNameColumns1[n];
    case AERO_AEDO_F:
    case AERO_AEDO_POW_F:
    case AERO_AEDO_SUM_F:
      return staticNameColumns2[n];
    case RERO_REDO_F:
    case RERO_REDO_POW_F:
    case RERO_REDO_SUM_F:
      return staticNameColumns3[n];
    case RQ1_RQ4_F:
    case RQ1_RQ4_POW_F:
      return staticNameColumns7[n];
    case RQ2_RQ3_F:
    case RQ2_RQ3_POW_F:
      return staticNameColumns9[n];
    default:
      return staticNameColumns1[n];
  }
}
//---------------------------------------------------------------------------
void __fastcall T2Interior::ChoiceOfTimeDiap( char *FirstDate, char *LastDate)
{
   unsigned short year, month, day;
   unsigned short hour, minute, sec, msec;
   fd->DateTime.DecodeDate(&year, &month, &day);
   switch(fd->StepProfile)
   {
      case TFormDescr::stpMonth:
       //  grouping = " 0+to_char(date_time-1.157407407407e-5,'mm') ";
         strcpy( FirstDate,(TDateTime(year, 1, 1)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
         strcpy( LastDate,TDateTime(year+1, 1, 1).FormatString(DateTimeFormat).c_str());
        break;
      case TFormDescr::stpDay:
      //   grouping = " 0+to_char(date_time-1.157407407407e-5,'dd') ";
         strcpy( FirstDate,(TDateTime(year, month, 1)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
         strcpy( LastDate,(TDateTime(year, month, 1)+RowCount).FormatString(DateTimeFormat).c_str());
        break;
      case TFormDescr::stpHour:
      //   grouping = " 1+FLOOR((date_time-to_date(:par1,'dd.mm.yyyy hh24:mi:ss'))*86400/:par4) ";
         strcpy( FirstDate,(TDateTime(year, month, day)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
         strcpy( LastDate,(TDateTime(year, month,day)+1).FormatString(DateTimeFormat).c_str());
        break;
      case TFormDescr::stpMinute:
      //   grouping = " 1+FLOOR((date_time-to_date(:par1,'dd.mm.yyyy hh24:mi:ss'))*86400/:par4) ";
         fd->DateTime.DecodeTime(&hour, &minute, &sec, &msec);
         strcpy( FirstDate,(TDateTime(year, month, day)+hour/24.0+minute/1440.0+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
         strcpy( LastDate,(TDateTime(year, month,day)+(hour+minute/60.0+LenPROFILE/3600.0)/24.0).FormatString(DateTimeFormat).c_str());
        break;
   }
}
//---------------------------------------------------------------------------
void __fastcall T2Interior::CheckPrecipice(int rowCount, int iClones, int SubColumns, int Clones, TCloneItem *datOracle)
{
   switch( fd->CodeTemplate )
   {
      case AEBO_SUM_F:
      case AERO_SUM_F:
      case AEDO_SUM_F:
      case REBO_SUM_F:
      case RERO_SUM_F:
      case REDO_SUM_F:
      case AEBO_REBO_SUM_F:
      case AERO_AEDO_SUM_F:
      case RERO_REDO_SUM_F:
      case RE_BALANCE_SUM_F:
      case BALANCE_SUM_F:
//         TCloneItem *pDatOracle=NULL;
         Clones++;
//         int hole = 8;
  //           for(int j=0; j <= rowCount; ++j){
    //            pDatOracle = datOracle+(iClones*SubColumns+j*Clones*SubColumns);
/*                if(pDatOracle->val==-MAXFLOAT) tem = hole; else pDatOracle->nsource = pDatOracle->nsource | tem;
                if(SubColumns >1){
                  if((pDatOracle+1)->val==-MAXFLOAT) tem = hole; else (pDatOracle+1)->nsource = (pDatOracle+1)->nsource | tem;
                  if(SubColumns == 4){
                     if((pDatOracle+2)->val==-MAXFLOAT) tem = hole; else (pDatOracle+2)->nsource = (pDatOracle+2)->nsource | tem;
                     if((pDatOracle+3)->val==-MAXFLOAT) tem = hole; else (pDatOracle+3)->nsource = (pDatOracle+3)->nsource | tem;
                  }
                }*/
    //         }
   }
}
//---------------------------------------------------------------------------
//end add by NNV

