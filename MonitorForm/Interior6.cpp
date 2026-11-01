//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "Interior6.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
__fastcall T6Interior::T6Interior(TComponent* Owner,TSplitterForm *s,
	TFormDescr* f,Classes::TNotifyEvent n):T2Interior(Owner,s,f,n)
{
}
//---------------------------------------------------------------------------
__fastcall T6Interior::~T6Interior(void)
{
}
//---------------------------------------------------------------------------
void __fastcall T6Interior::selectData( TOraQuery *qwInter )
{
 /* для обрезки допустимого баланса
  TOraQuery *qwInter2;
  qwInter2=new TOraQuery(Owner);
  qwInter2->Session=dmMain->orases;
  qwInter2->AutoCommit=false; */
	unsigned long j,selectRows,clones,rowCount;
	unsigned short year, month, day;
	int CountOnProgress=6;
	long iClones,IdGroup;
	AnsiString sql;// paramlist, decnsourcesec, decnsourcef,decperiod;
  AnsiString PowKoef = "";

	char FirstDate[20], LastDate[20];
 	struct TempStruct{
		long Count;
		double A;
		double B;
		double C;
		double D;
    char isvalid[32];
    TempStruct(){ZeroMemory(this,sizeof(*this));}
	}*TempDatOracle=NULL;
  short *ind=NULL;
	TCloneItem *pDatOracle=NULL;

  try{
    rowCount=RowCount+1;
	  clones=Clones+1;
    pDatOracle=datOracle;
	  for( iClones=0; (unsigned long)iClones<clones*SubColumns()*rowCount ;++iClones,++pDatOracle ){
		  pDatOracle->val=-MAXFLOAT;
      ZeroMemory(pDatOracle->isvalid,sizeof(pDatOracle->isvalid));
    }
    switch (fd->CodeTemplate){
      case BALANCE_POW_F:
      case RE_BALANCE_POW_F:
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

    ChoiceOfTimeDiap(FirstDate, LastDate);

    TempDatOracle=new struct TempStruct[rowCount];
    ind = new short[rowCount*IND_CNT];
    qwInter->Params->Clear();
    if(fd->CodeTemplate== NOT_BALANCE|| fd->CodeTemplate== NOT_BALANCE_AER)// 207 - Небаланс активной энергии)
      qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.Interior4_notbalanse_p(:par7,:par8,:par9,:par10,:par11,:par12,:par13,:par1,:par2,:par3,:par4,:par5,:par6,:par14); end;";
    else
      qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.Interior4_selectData_p(:par7,:par8,:par9,:par10,:par11,:par12,:par13,:par1,:par2,:par3,:par4,:par5,:par6,:par14); end;";

    for(iClones=0; iClones<=Clones; ++iClones){
      IdGroup=(long)NamesClones->Objects[iClones];
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
        }
        else
          ind[1*rowCount+i]=-1;
        if(!qwInter->FieldByName("BParam")->IsNull){
          ind[2*rowCount+i]=0;
          TempDatOracle[i].B= qwInter->FieldByName("BParam")->AsFloat;
        }else
          ind[2*rowCount+i]=-1;
        if(fd->CodeTemplate==NOT_BALANCE){
          if(!qwInter->FieldByName("CParam")->IsNull&&qwInter->FieldByName("CParam")->AsFloat>=0){
            ind[3*rowCount+i]=0;
            ind[4*rowCount+i]=0;
            TempDatOracle[i].C= qwInter->FieldByName("CParam")->AsFloat;
          }else{
            ind[3*rowCount+i]=-1;
            ind[4*rowCount+i]=-1;
          }
        }else {  //fd->CodeTemplate==NOT_BALANCE
          if(!qwInter->FieldByName("CParam")->IsNull){
            ind[3*rowCount+i]=0;
            TempDatOracle[i].C= qwInter->FieldByName("CParam")->AsFloat;
          }else
            ind[3*rowCount+i]=-1;
          if(!qwInter->FieldByName("DParam")->IsNull){
            ind[4*rowCount+i]=0;
            TempDatOracle[i].D= qwInter->FieldByName("DParam")->AsFloat;
          }else
            ind[4*rowCount+i]=-1;
        }
        if(qwInter->FieldByName("decnsour")->AsString.Length()>=22)
          strncpy(TempDatOracle[i].isvalid,qwInter->FieldByName("decnsour")->AsString.c_str(),sizeof(TempDatOracle[i].isvalid));
        qwInter->Next();
        i++;
      }
      qwInter->Close();

      selectRows=i;

      if( CountOnProgress ){
        --CountOnProgress;
        OnProgressBarStepBy(this);//20
      }
      switch( fd->CodeTemplate ){
         /* case RE_BALANCE_SUM_F:
         // case BALANCE_SUM_F:
                  for(int tem=0, j=2;j<(int)selectRows;++j){
                  TempDatOracle[j].A = TempDatOracle[j].A + TempDatOracle[j-1].A;
                  TempDatOracle[j].B = TempDatOracle[j].B + TempDatOracle[j-1].B;
                  TempDatOracle[j].C = TempDatOracle[j].C + TempDatOracle[j-1].C;
                  TempDatOracle[j].D = TempDatOracle[j].D+ TempDatOracle[j-1].D;
                  TempDatOracle[j].isvalid[0]='\0';
              };
               break; */
        case NOT_BALANCE:
          for(int j=0;j<(int)selectRows;++j){
            TempDatOracle[j].D=fabs(TempDatOracle[j].C)-fabs(TempDatOracle[j].B);
          }
          break;
      }
      if(PowerProfile == 60)
        PowKoef = "";

      for( j=0;j<selectRows;++j){
        pDatOracle=datOracle+(iClones*SubColumns()+TempDatOracle[j].Count*((Clones+1)*SubColumns()));
        if((PowKoef.IsEmpty() || j>0) && ind[1*rowCount+j]>-1) pDatOracle->val=TempDatOracle[j].A;
          strncpy(pDatOracle->isvalid,TempDatOracle[j].isvalid,sizeof(pDatOracle->isvalid));
        if((PowKoef.IsEmpty() || j>0) && ind[2*rowCount+j]>-1)
          (pDatOracle+1)->val=TempDatOracle[j].B;
        if(fd->CodeTemplate!=NOT_BALANCE)
          strncpy((pDatOracle+1)->isvalid,TempDatOracle[j].isvalid,sizeof((pDatOracle+1)->isvalid));
        if((PowKoef.IsEmpty() || j>0) && ind[3*rowCount+j]>-1)
          (pDatOracle+2)->val=TempDatOracle[j].C;
        if(fd->CodeTemplate!=NOT_BALANCE)
          strncpy((pDatOracle+2)->isvalid,TempDatOracle[j].isvalid,sizeof((pDatOracle+2)->isvalid));
        if((PowKoef.IsEmpty() || j>0) && ind[4*rowCount+j]>-1)
          (pDatOracle+3)->val=TempDatOracle[j].D;
        if(fd->CodeTemplate!=NOT_BALANCE)
          strncpy((pDatOracle+3)->isvalid,TempDatOracle[j].isvalid,sizeof((pDatOracle+3)->isvalid));
      }
    }
    delete [] TempDatOracle;
    delete []ind;
    while( CountOnProgress ){
      --CountOnProgress;
      OnProgressBarStepBy(this);//20
    }
  }catch(Exception&e){
    if(TempDatOracle)
      delete [] TempDatOracle;
    if(ind)
      delete []ind;
    while( CountOnProgress ){
	    --CountOnProgress;
		  OnProgressBarStepBy(this);//20
    }
    throw;
  }
}
//---------------------------------------------------------------------------
long __fastcall T6Interior::SubColumns(void)
{
        if(fd->CodeTemplate == 203) return 6;
	return 4;
}
//---------------------------------------------------------------------------

AnsiString __fastcall T6Interior::GetSubColumnsNames(int n)
{
   AnsiString staticNameColumns1[4]={Reconst_smes106_1,Reconst_smes106_2,Reconst_smes106_3,Reconst_smes106_4};
   AnsiString staticNameColumns2[4]={Reconst_smes106_5,Reconst_smes106_6,Reconst_smes106_7,Reconst_smes106_8};
   AnsiString staticNameColumns3[4]={Reconst_smes106_9,Reconst_smes106_10,Reconst_smes106_11,Reconst_smes106_12};
   AnsiString staticNameColumns4[4]={Reconst_smes106_13,Reconst_smes106_14,Reconst_smes106_15,Reconst_smes106_16};
   AnsiString staticNameColumns5[4]={Reconst_smes106_17,Reconst_smes106_18,Reconst_smes106_19,Reconst_smes106_20};
   AnsiString staticNameColumns6[4]={Reconst_smes106_17,Reconst_smes106_18,Reconst_smes106_19,Reconst_smes106_32};
   //-----------------VNB 12.12.2008
   if(PowerCoeff==1)
   {
   staticNameColumns3[0]= Reconst_smes106_21;
   staticNameColumns3[1]= Reconst_smes106_22;
   staticNameColumns3[2]= Reconst_smes106_23;

   staticNameColumns4[0]= Reconst_smes106_24;
   staticNameColumns4[1]= Reconst_smes106_25;
   staticNameColumns4[2]= Reconst_smes106_26;

   staticNameColumns5[0]= Reconst_smes106_27;
   staticNameColumns6[0]= Reconst_smes106_27;

   }
   //-----------------VNB end;

	switch( fd->CodeTemplate )
	{
    case AERO_AERA_AERB_AERC_F:
	case AEDO_AEDA_AEDB_AEDC_F:
	case RERO_RERA_RERB_RERC_F:
	case REDO_REDA_REDB_REDC_F:
    // add KAS 20.04.2002
	case AEBO_AEBA_AEBB_AEBC_F: // 921 Переток активной э/э (общая и по тарифам) [кВтч]
	case REBO_REBA_REBB_REBC_F: //941 Переток реактивной э/э (общая и по тарифам) [кВарч]
    // end add
        return staticNameColumns1[n];

        case AERA_AERB_AERC_AERD_F:
	case AEDA_AEDB_AEDC_AEDD_F:
	case RERA_RERB_RERC_RERD_F:
	case REDA_REDB_REDC_REDD_F:
	    return staticNameColumns2[n];
    //add by NNV
        case BALANCE_F:
        case BALANCE_POW_F:
        case BALANCE_SUM_F:
            return staticNameColumns3[n];
        case RE_BALANCE_F:
        case RE_BALANCE_POW_F:
        case RE_BALANCE_SUM_F:
            return staticNameColumns4[n];
    //end add by NNV
    //add by KAG
      case NOT_BALANCE:
          return staticNameColumns5[n];
     case NOT_BALANCE_AER:
          return staticNameColumns6[n];
    //end add by KAG
    default:
	    return staticNameColumns1[n];
	}
}
//---------------------------------------------------------------------------
AnsiString __fastcall T6Interior::GetUnitOfEnergy()
{
        AnsiString d = "";
	switch( fd->CodeTemplate )
	{
            case AERO_AERA_AERB_AERC_F:
            case AEDO_AEDA_AEDB_AEDC_F:
            case AEBO_AEBA_AEBB_AEBC_F:
            case AERA_AERB_AERC_AERD_F:
            case AEDA_AEDB_AEDC_AEDD_F:
                                       d =(PowerCoeff==1)?Reconst_smes106_28: Reconst_smes106_29;
                                       break;
            case RERO_RERA_RERB_RERC_F:
            case REDO_REDA_REDB_REDC_F:
            case REBO_REBA_REBB_REBC_F:
            case RERA_RERB_RERC_RERD_F:
            case REDA_REDB_REDC_REDD_F:
                                       d =(PowerCoeff==1)?Reconst_smes106_30: Reconst_smes106_31;
                                       break;
            case BALANCE_F:
            case BALANCE_POW_F:
            case BALANCE_SUM_F:
            case RE_BALANCE_F:
            case RE_BALANCE_POW_F:
            case RE_BALANCE_SUM_F:
                                      d = "";
                                      break;
            case NOT_BALANCE:     // add by KAG
            case NOT_BALANCE_AER:
                                      d = " % ";
                                      break;
	}
        return d;
}

//---------------------------------------------------------------------------
