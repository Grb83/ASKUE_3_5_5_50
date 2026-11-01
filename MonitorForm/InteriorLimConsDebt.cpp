//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "InteriorLimConsDebt.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "Reconst.hpp"

// Фильтры
     AnsiString StrPlan = "";
     AnsiString StrReserv = "";
     AnsiString StrDebtRestr = "";
     AnsiString StrDebt = "";
//---------------------------------------------------------------------------
__fastcall TConsumLimitDebt::TConsumLimitDebt(TComponent* Owner,TSplitterForm *aSP,
	TFormDescr *aFD,Classes::TNotifyEvent OnProgr,bool B_and_W):
	TDUInterior(Owner,aSP,aFD,OnProgr,B_and_W )
{
        dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemAttr->Caption = Reconst_smes119_1;
        dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemAttr->Enabled=true;
        dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemAttr->OnClick=OnClickMenuItemAttr;
        dynamic_cast<TBaseMonitorForm*>(Owner)->PopupMenuDU->OnPopup=OnPopupMenuDU;
        AnsiString sf = " (";
        sf += StrPlan.IsEmpty()? AnsiString(""):AnsiString(Reconst_smes119_2+StrPlan+" /");
        sf += StrReserv.IsEmpty()? AnsiString(""):AnsiString(Reconst_smes119_3+StrReserv+" /");
        sf += StrDebtRestr.IsEmpty()? AnsiString(""):AnsiString(Reconst_smes119_4+StrDebtRestr+" /");
        sf += StrDebt.IsEmpty()? AnsiString(""):AnsiString(Reconst_smes119_5+StrDebt+" /");
        sf.SetLength(sf.Length()-1);
        sf += ")";
        if(sf.Length()>10)
           dynamic_cast<TBaseMonitorForm*>(Owner)->LabelComment->Caption =
           dynamic_cast<TBaseMonitorForm*>(Owner)->LabelComment->Caption+sf;
        //GRB ADD - подписываем на перерисовку
        ((TBaseMonitorForm*)Owner)->OnResize=TDUInterior::FormShow;
}
//---------------------------------------------------------------------------
__fastcall TConsumLimitDebt::~TConsumLimitDebt(void)
{
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimitDebt::Place(void)
{
	TDUInterior::Place();
	DrawTable->StaticStrings->Strings[0]=Reconst_smes119_6;
	DrawTable->OnSelectCell=OnSelectCell;
	//Invalidate(TABLE_CURR_POWER);
}
//---------------------------------------------------------------------------
AnsiString __fastcall TConsumLimitDebt::GetSubColumnsNames(int n)
{
	static AnsiString staticNameColumns[]={Reconst_smes119_7,Reconst_smes119_8,Reconst_smes119_9,
	Reconst_smes119_10,Reconst_smes119_11,"ERR"};
	return staticNameColumns[n];
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimitDebt::clonesInColumns(void)
{
   TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
static int SizeFields[]={LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,4};
	DrawTable->FixedCols=1;
	if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
	{
		DrawTable->RowsHeight=AnsiString("#")+psm->EditColorHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthName->Text+
			AnsiString("#")+psm->EditColorWidthDigit->Text+
			AnsiString("#")+psm->EditColorWidthDigit->Text+
			AnsiString("#")+psm->EditColorWidthDigit->Text+
			AnsiString("#")+psm->EditColorWidthDigit->Text+
			AnsiString("#")+psm->EditColorWidthDigit->Text+
			AnsiString("#")+psm->UpDownColorWidthDigit->Position/2;
	}
	else
	{
		DrawTable->RowsHeight=AnsiString("#")+psm->EditBWHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthName->Text+
			AnsiString("#")+psm->EditBWWidthDigit->Text+
			AnsiString("#")+psm->EditBWWidthDigit->Text+
			AnsiString("#")+psm->EditBWWidthDigit->Text+
			AnsiString("#")+psm->EditBWWidthDigit->Text+
			AnsiString("#")+psm->EditBWWidthDigit->Text+
			AnsiString("#")+psm->UpDownBWWidthDigit->Position/2;
	}
	if( !is_B_and_W )
	{
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b t 2 # $ m 0x0009 0x100F #$#$#$#$#$");
		//DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b-  t 7 # & m 0x0001 0x900C c 35 b #& c 5 b- #&#&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0009 0x100F c 15 b  t 7 a 0x26 # & m 0x0001 0x900C c36 a 0x25 #&#&#&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b- t 7 a 0x24 # & m 0x0001 0x900C c 5 a 0x25 #&#&#&#&#&");
	}
	else
	{
	/*
		DrawTable->TabStrings->Add("$ m 0x0005 0x1008 b # $ m 0x0009 0x1008 #$#$#$#$#$");
		//DrawTable->TabStrings->Add("$ m 0x0005 0x0 b- a 0x24 # & m 0x0001 0x00 b a 0x25 #& b- #&#&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0005 0x0 b a 0x24 # & m 0x0001 0x00 b- a 0x25 #&#&#&#&#&");
	*/
		DrawTable->TabStrings->Add("$ m 0x0005 0x800c b # $ m 0x0009 0x800c #$#$#$#$#$");
		//DrawTable->TabStrings->Add("$ m 0x0005 0x0 b- a 0x24 # & m 0x0001 0x00 b a 0x25 #& b- #&#&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0009 0x800c b a 0x26 # & m 0x0001 0x800c b a 0x25 #&#&#&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0005 0x800c b a 0x24 # & m 0x0001 0x800c b- a 0x25 #&#&#&#&#&");
	}
	DrawTable->StructStrings->Rebuild( Clones,SubColumns(),SizeFields );
	/*
	for( int i=0; i<NamesClones->Count && i<Clones ;++i)
		strcpy(DrawTable->StructStrings->GetArray()+i*(64+LenFloat*(SubColumns()-1)+4),NamesClones->Strings[i].c_str());
	*/
   delete psm;
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimitDebt::Invalidate( int Table )
{
	if(Table==TABLE_CURR_POWER)
	{
		dataInColumns();
		DrawTable->Invalidate();
		OnProgressBarStepBy(NULL);
	}
	--refreshDataCount;
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimitDebt::refreshData( int Table,TOraQuery *qwInter )
{
	if(Table==TABLE_CURR_POWER)
	 //	selectData(dmMain->qwInter);
   selectData(qwInter);
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimitDebt::selectData(TOraQuery *qwInter )
{
	int TempGid;
	int iClones,i, state;
	short ind[7];
	TCloneItem *ptr;
  double dat[7];

  try{
    ptr=datOracle;
    for( iClones=0 ; iClones<Clones ;++iClones ){
      for( i=0; i<SubColumns(); ++i ){
        ZeroMemory(ptr->isvalid,sizeof(ptr->isvalid));
        (ptr++)->val=-MAXFLOAT;
      }
    }
    dynamic_cast<TBaseMonitorForm*>(Owner)->Caption = fd->NameGroup+Reconst_smes119_12+GetCurrentDate(qwInter);

    qwInter->Params->Clear();
    qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.TConsumLimitDebt_selectData_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9);end;";
    qwInter->ParamByName("par9")->DataType=ftCursor;
    qwInter->ParamByName("par9")->ParamType=ptOutput;
    for( iClones=1 ; iClones<Clones ;++iClones ){
      TempGid=(int)NamesClones->Objects[iClones];
      qwInter->ParamByName("par1")->AsInteger= fd->IsPoints?1:0;
      qwInter->ParamByName("par2")->AsString=ObsoleteTimeLimit;
      qwInter->ParamByName("par3")->AsInteger=fd->StepProfile;
      qwInter->ParamByName("par4")->AsInteger=GroupIsList;
      qwInter->ParamByName("par5")->AsInteger=TempGid;
      qwInter->ParamByName("par6")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
      qwInter->ParamByName("par7")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
      qwInter->ParamByName("par8")->AsInteger=fd->GetPeriod(fd->DateTime);
      qwInter->Execute();
      if(!qwInter->FieldByName("limit")->IsNull){
        ind[0] = 0;
        dat[0]=qwInter->FieldByName("limit")->AsFloat;
      }else
        ind[0] = -1;
      if(!qwInter->FieldByName("fact")->IsNull){
        ind[1] = 0;
        dat[1]=qwInter->FieldByName("fact")->AsFloat;
      }else
        ind[1] = -1;
      if(!qwInter->FieldByName("factlim")->IsNull){
        ind[2] = 0;
        dat[2]=qwInter->FieldByName("factlim")->AsFloat;
      }else
        ind[2] = -1;
      if(!qwInter->FieldByName("armor")->IsNull){
        ind[3] = 0;
        dat[3]=qwInter->FieldByName("armor")->AsFloat;
      }else
        ind[3] = -1;
      if(!qwInter->FieldByName("debt")->IsNull){
        ind[4] = 0;
        dat[4]=qwInter->FieldByName("debt")->AsFloat;
      }else
        ind[4] = -1;
      if(!qwInter->FieldByName("obsol")->IsNull){
        ind[5] = 0;
        dat[5]=qwInter->FieldByName("obsol")->AsFloat;
      }else
        ind[5] = -1;
      if(!qwInter->FieldByName("debit")->IsNull){
        ind[6] = 0;
        dat[6]=qwInter->FieldByName("debit")->AsFloat;
      }else
        ind[6] = -1;

      if(( !StrPlan.IsEmpty()&&((*(dat+2)<=StrPlan.ToDouble())||(*(ind+2)<0)))||
               ( !StrReserv.IsEmpty()&&(((*(dat+1)-*(dat+3))<=StrReserv.ToDouble())||(*(ind+1)<0)||(*(ind+3)<0)))||
               (!StrDebt.IsEmpty()&&((*(dat+4)<=StrDebt.ToDouble())||(*(ind+4)<0)))||
               (!StrDebtRestr.IsEmpty()&&((*(dat+6)<=StrDebtRestr.ToDouble())||(*(ind+6)<0))) ){
        NamesClones->Delete(iClones);
        iClones--;
        Clones--;
        continue;
      }
      if( !qwInter->Eof ){
        for(i=0; i<SubColumns() ; ++i ){
          if(ind[i]==0)
            datOracle[iClones*SubColumns()+i].val=dat[i];
          else
            datOracle[iClones*SubColumns()+i].val=-MAXFLOAT;
        }
      }else{
        for(i=0; i<SubColumns() ; ++i ){
          datOracle[iClones*SubColumns()+i].val=-MAXFLOAT;
        }
      }
      qwInter->Close();
      OnProgressBarStepBy(this);
    }
    Clones = NamesClones->Count;
	}catch( Exception &e ){
  }
	OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimitDebt::clickDialog(long ACol, long ARow )
{
   TfmFilter *f = new TfmFilter(this);
   f->plMessages->Visible      = false;
   f->plJournal->Visible = false;
   f->Panel2->Visible=true;
   f->ePlan->Text = StrPlan;
   f->eReserv->Text = StrReserv;
   f->eDebtRestr->Text = StrDebtRestr;
   f->eDebt->Text = StrDebt;
   f->ShowModal();
   if(f->ModalResult==mrOk)
   {
        StrPlan = f->ePlan->Text.IsEmpty()?AnsiString(""):AnsiString(f->ePlan->Text.ToDouble());
        StrReserv = f->eReserv->Text.IsEmpty()?AnsiString(""):AnsiString(f->eReserv->Text.ToDouble());
        StrDebtRestr = f->eDebtRestr->Text.IsEmpty()?AnsiString(""):AnsiString(f->eDebtRestr->Text.ToDouble());
        StrDebt = f->eDebt->Text.IsEmpty()?AnsiString(""):AnsiString(f->eDebt->Text.ToDouble());
        refreshForm();
   }
   delete f;
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimitDebt::OnClickMenuItemAttr(TObject *Sender)
{
//            if(DrawTable->Row>1)
               clickDialog(0, DrawTable->Row );
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimitDebt::dataInColumns(void)
{
	int iClones,jColumns;
	char *ptr;
	char HeightCell[16];
	int hour;
	char ptr_hour[8];
	bool isSumm;
	AnsiString RowsHeight;
	//Подготавливаем переменные поля для приема
	ptr=DrawTable->StructStrings->GetArray();
	ptr+=LenFloat*(SubColumns()-1);
	ptr+=4;
    TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
	if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
	    strcpy(HeightCell,("#"+psm->EditColorHeight->Text).c_str());
	else
		strcpy(HeightCell,("#"+psm->EditBWHeight->Text).c_str());
    delete psm;

	RowsHeight=HeightCell;
	RowsHeight=RowsHeight+AnsiString(HeightCell);
	hour=0;
	*ptr_hour=0;
    VT_PrintData->First();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    VT_PrintData->Next();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    datOracle[SubColumns()-1].val = -1;
	for( iClones=1 ; iClones<Clones ; ++iClones )
	{
        VT_PrintData->Edit();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
		for(jColumns=0; jColumns<SubColumns()-1; ptr+=LenFloat,++jColumns)
        {
            if(datOracle[iClones*SubColumns()+jColumns].val!=-MAXFLOAT)
                strcpy(ptr, FormatFloat("#,###,##0.000;;0.0",datOracle[iClones*SubColumns()+jColumns].val).c_str());
            else
                *ptr=0;
            VT_PrintData->Fields->FieldByName("Data"+IntToStr(jColumns+1))->AsString = ptr;//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
        }
		if(datOracle[iClones*SubColumns()+SubColumns()-1].val>=0.0 ||
			datOracle[iClones*SubColumns()+SubColumns()-1].val==-MAXFLOAT)
			sprintf(ptr,"*\x0");
		else
		{
		    *ptr=0;
			if(datOracle[iClones*SubColumns()+SubColumns()-1].val<hour)
			{
			    hour=datOracle[iClones*SubColumns()+SubColumns()-1].val;
				sprintf(ptr_hour," %02d:%02d",-hour/100,-hour%100);
			}
		}
        VT_PrintData->Fields->FieldByName("Data"+IntToStr(SubColumns()))->AsString = ptr;//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
		ptr+=4;
		switch( fd->CodeTemplate )
		{
		case ConsumLim_F__Debt:
		case ConsumLim_F_BW__Debt:
		    if( datOracle[iClones*SubColumns()+4].val>0.0 )
			{
			    RowsHeight=RowsHeight+AnsiString(HeightCell);
				isSumm=true;
            }
			else
			{
			    RowsHeight=RowsHeight+AnsiString("#0");
				isSumm=false;
            }
			break;
        case ConsumLim_F__Limit:
		case ConsumLim_F_BW__Limit:
		    if( datOracle[iClones*SubColumns()+2].val>0.0 )
			{
			    RowsHeight=RowsHeight+AnsiString(HeightCell);
				isSumm=true;
            }
			else
			{
			    RowsHeight=RowsHeight+AnsiString("#0");
				isSumm=false;
            }
			break;
        default:
		    isSumm=true;
        }
		for(jColumns=0; isSumm && jColumns<SubColumns()-1; ++jColumns)
		if(datOracle[iClones*SubColumns()+jColumns].val!=-MAXFLOAT)
		{
		    if(datOracle[jColumns].val!=-MAXFLOAT)
			    datOracle[jColumns].val+=datOracle[iClones*SubColumns()+jColumns].val;
			else
				datOracle[jColumns]=datOracle[iClones*SubColumns()+jColumns];
        }
		if(isSumm && (datOracle[iClones*SubColumns()+SubColumns()-1].val>=0.0 ||
			datOracle[iClones*SubColumns()+SubColumns()-1].val==-MAXFLOAT))
			datOracle[SubColumns()-1].val=1.0;
        VT_PrintData->Next();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    }

	ptr=DrawTable->StructStrings->GetArray();
    VT_PrintData->First();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    VT_PrintData->Edit();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
	for(jColumns=0; jColumns<SubColumns()-1; ptr+=LenFloat,++jColumns)
    {
        if(datOracle[jColumns].val!=-MAXFLOAT)
		    strcpy(ptr, FormatFloat("#,###,##0.000;;0.0",datOracle[jColumns].val).c_str());
        else
		    *ptr=0;
        VT_PrintData->Fields->FieldByName("Data"+IntToStr(jColumns+1))->AsString = ptr;//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
    }
	if(datOracle[SubColumns()-1].val>=0.0 ||
	    datOracle[SubColumns()-1].val==-MAXFLOAT)
		strcpy(ptr,"*");
    VT_PrintData->Fields->FieldByName("Data"+IntToStr(SubColumns()))->AsString = ptr;//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
    VT_PrintData->Post();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DrawTable->RowsHeight=RowsHeight;
    /*	dynamic_cast<TBaseMonitorForm*>(Owner)->Caption=
	fd->NameGroup+" за "+fd->DateTime.FormatString("ddddd")+ptr_hour;
	dynamic_cast<TBaseMonitorForm*>(Owner)->PaintBoxCaption->Invalidate();*/
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//Получает данные о считываемой таблице
void __fastcall TConsumLimitDebt::formDescr( void )
{


        fd->IdGroup = GroupJump(fd->IdGroup);

	//Заполняем необходимые поля описания формы

  
  dmMain->oqInterCursor->Params->Clear();
  dmMain->oqInterCursor->SQL->Text = " begin "+SchemeName+"interior_pg.Interior_formDescr_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7);end;";
  dmMain->oqInterCursor->ParamByName("par7")->DataType=ftCursor;
  dmMain->oqInterCursor->ParamByName("par7")->ParamType=ptOutput;

  dmMain->oqInterCursor->ParamByName("par1")->AsInteger= fd->IsPoints?1:0;
  dmMain->oqInterCursor->ParamByName("par2")->AsInteger=fd->StepProfile;
  dmMain->oqInterCursor->ParamByName("par3")->AsInteger=fd->IdGroup;
  dmMain->oqInterCursor->ParamByName("par4")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
  dmMain->oqInterCursor->ParamByName("par5")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
  dmMain->oqInterCursor->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);
  dmMain->oqInterCursor->Execute();
  NamesClones->Clear();
	NamesClones->AddObject(Reconst_smes119_13,(TObject*)NULL);
  while(!dmMain->oqInterCursor->Eof){
    NamesClones->AddObject(dmMain->oqInterCursor->FieldByName("name")->AsString,(TObject*)dmMain->oqInterCursor->FieldByName("mid")->AsInteger);
	  ++Clones;
    dmMain->oqInterCursor->Next();
  }
  dmMain->oqInterCursor->Close();
  if(!Clones)
		throw(Exception(Reconst_smes119_14));
  else Clones++;
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimitDebt::OnSelectCell(TObject* Sender, int Col, int Row, bool &CanSelect)
{
	int del;
	if(((TDrawTable*)Sender)->RowHeights[Row]!=0)
	{
		CanSelect=true;
		return;
	}
	CanSelect=false;
	del=(((TDrawTable*)Sender)->Row-Row)>0?-1:1;
	for(Row+=del;Row<((TDrawTable*)Sender)->RowCount && Row>=0 ;Row+=del)
	if(((TDrawTable*)Sender)->RowHeights[Row]!=0)
	{
		((TDrawTable*)Sender)->Row=Row;
		return;
	}
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimitDebt::OnPopupMenuDU(TObject *Sender)
{
//
}
//---------------------------------------------------------------------------

