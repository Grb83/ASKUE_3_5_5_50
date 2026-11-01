//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "Interior1.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
__fastcall T1Interior::T1Interior(TComponent* Owner,TSplitterForm *s,
	TFormDescr* f,Classes::TNotifyEvent n):T2Interior(Owner,s,f,n)
{
}
//---------------------------------------------------------------------------
__fastcall T1Interior::~T1Interior(void)
{
}
//---------------------------------------------------------------------------
void __fastcall T1Interior::selectData( TOraQuery *qwInter )
{
  unsigned long j,selectRows,clones,rowCount;
	unsigned short year, month, day;
	unsigned short hour, minute, sec, msec;
  AnsiString PowKoef = ""; // Коэффициент для перевода в мощность Для ГН и Тех. профиля

	int CountOnProgress=6;
	long iClones,IdGroup;
	AnsiString sql;//, paramlist, decnsourcesec, decnsourcef,decperiod;
	char FirstDate[20], LastDate[20];
 //	AnsiString grouping;
	struct TempStruct{
    long Count;
	  double A;
    char isvalid[32];
    TempStruct(){ZeroMemory(this,sizeof(*this));}
  };
  TempStruct * TempDatOracle = NULL;
  short *ind=NULL;
	TCloneItem *pDatOracle=NULL;
  try{
    rowCount=RowCount+1;
    clones=Clones+1;
	  pDatOracle=datOracle;
    for(iClones=0;(unsigned long)iClones < clones*SubColumns()*rowCount;++iClones,++pDatOracle){
  	  pDatOracle->val=-MAXFLOAT;
      ZeroMemory(pDatOracle->isvalid,sizeof(pDatOracle->isvalid));
    }
    switch (fd->CodeTemplate){
      case AEBO_POW_F:
    	case AERO_POW_F:
	    case AEDO_POW_F:
    	case REBO_POW_F:
	    case RERO_POW_F:
    	case REDO_POW_F:
        switch (fd->StepProfile){
          case TFormDescr::stpHour:
            PowKoef = "*"+IntToStr((int)(60.0/PowerProfile));
            break;
          case TFormDescr::stpMinute:
            PowKoef = "*"+IntToStr((int)(3600.0/StepPROFILE));
            break;
          }
        break;
    }
    //e //chig - переворот в разности!!!!
    fd->DateTime.DecodeDate(&year, &month, &day);
    // ChoiceOfTimeDiap(grouping, FirstDate, LastDate);
    ChoiceOfTimeDiap(FirstDate, LastDate);

    TempDatOracle = new struct TempStruct[rowCount];
    ind = new short[rowCount*IND_CNT];

    qwInter->Params->Clear();
    qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.Interior1_selectData_p(:par7, \
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

      qwInter->ParamByName("par12")->AsInteger=PowerProfile;
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
          TempDatOracle[i].Count= qwInter->FieldByName("BGroup")->AsInteger;
        if(!qwInter->FieldByName("AParam")->IsNull){
          ind[1*rowCount+i]=0;
          TempDatOracle[i].A= qwInter->FieldByName("AParam")->AsFloat;
          if(qwInter->FieldByName("decnsour")->AsString.Length()>=22)
            strcpy(TempDatOracle[i].isvalid,qwInter->FieldByName("decnsour")->AsString.c_str());
        }else
          ind[1*rowCount+i]=-1;
        qwInter->Next();
        i++;
      }
      qwInter->Close();

      selectRows=i;
      if( CountOnProgress ) {
        --CountOnProgress;
    	  OnProgressBarStepBy(this);//20
      }
      for(j=0;j<selectRows;++j){
        pDatOracle = datOracle+(iClones*SubColumns()+TempDatOracle[j].Count*((Clones+1)*SubColumns()));
        if((PowKoef.IsEmpty() || j>0) && ind[1*rowCount+j]>-1){
          pDatOracle->val = TempDatOracle[j].A;
          strncpy(pDatOracle->isvalid,TempDatOracle[j].isvalid,sizeof(pDatOracle->isvalid));
        }
      }

      CheckPrecipice(rowCount, iClones, SubColumns(), Clones, datOracle);//add by NNV
    } //end for(iClones=0; iClones<=Clones; ++iClones)
    delete []TempDatOracle;
    delete []ind;
    while(CountOnProgress){
  	  --CountOnProgress;
      OnProgressBarStepBy(this);//20
    }
  }catch(Exception &e){
    if(TempDatOracle)
      delete []TempDatOracle;
    if(ind)
      delete []ind;
    while(CountOnProgress){
      --CountOnProgress;
      OnProgressBarStepBy(this);//20
    }
    throw;
  }
}
//---------------------------------------------------------------------------
long __fastcall T1Interior::SubColumns(void)
{
	return 1;
}
//---------------------------------------------------------------------------

AnsiString __fastcall T1Interior::GetSubColumnsNames(int n)
{

   static AnsiString staticNameColumns[]={
        Reconst_smes103_1.c_str(),Reconst_smes103_2.c_str(),Reconst_smes103_3.c_str(),Reconst_smes103_4.c_str(),
        Reconst_smes103_5.c_str(),Reconst_smes103_6.c_str(),Reconst_smes103_7.c_str(),Reconst_smes103_8.c_str(),Reconst_smes103_9.c_str()};

   static AnsiString staticNameColumns1[]={
        Reconst_smes103_10.c_str(),Reconst_smes103_11.c_str(),Reconst_smes103_12.c_str(),Reconst_smes103_13.c_str(),
        Reconst_smes103_14.c_str(),Reconst_smes103_15.c_str(),Reconst_smes103_16.c_str(),Reconst_smes103_17.c_str(),Reconst_smes103_18.c_str()};

    int k;
	switch( fd->CodeTemplate )
	{
    case AEBO_F: k = 0; break;
    case AERO_F: k = 1; break;
	case AEDO_F: k = 2; break;
	case REBO_F: k = 3; break;
	case RERO_F: k = 4; break;
	case REDO_F: k = 5; break;
	case WATER_F:k = 6; break;
	case GAS_F:  k = 7; break;
	case HEAT_F: k = 8; break;
	default: k=0;
	}
  if(PowerCoeff==1000)
    return staticNameColumns[k];
  else
    return staticNameColumns1[k];
}
//---------------------------------------------------------------------------
AnsiString __fastcall T1Interior::GetUnitOfEnergy()
{
    AnsiString d = "";
	switch( fd->CodeTemplate )
	{
		case AEBO_F:
		case AERO_F:
		case AEDO_F:
                            d = (PowerCoeff==1)?Reconst_smes103_19.c_str():Reconst_smes103_20.c_str();
                            break;
		case AEBO_POW_F:
		case AEBO_SUM_F:
		case AERO_POW_F:
		case AERO_SUM_F:
		case AEDO_POW_F:
		case AEDO_SUM_F:
                            if(fd->StepProfile==TFormDescr::stpHour||fd->StepProfile==TFormDescr::stpMinute)
                               d = Reconst_smes103_21.c_str();
                            else
                               d = (PowerCoeff==1)?Reconst_smes103_22.c_str(): Reconst_smes103_23.c_str();
                            break;
		case REBO_F:
		case RERO_F:
		case REDO_F:
                            d = (PowerCoeff==1)?Reconst_smes103_24.c_str(): Reconst_smes103_25.c_str();
                            break;
		case REBO_POW_F:
		case REBO_SUM_F:
		case RERO_POW_F:
		case RERO_SUM_F:
		case REDO_POW_F:
		case REDO_SUM_F:
                            if(fd->StepProfile==TFormDescr::stpHour||fd->StepProfile==TFormDescr::stpMinute)
                               d = Reconst_smes103_26.c_str();
                            else
                               d = (PowerCoeff==1)?Reconst_smes103_27.c_str(): Reconst_smes103_28.c_str();
                            break;
		case WATER_F:
                            d = Reconst_smes103_29.c_str();
                            break;
		case GAS_F:
                            d = Reconst_smes103_30.c_str();
                            break;
		case HEAT_F:
                            d = Reconst_smes103_31.c_str();
                            break;
	}
        return d;
}
//---------------------------------------------------------------------------


