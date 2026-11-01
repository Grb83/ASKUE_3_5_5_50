//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "InteriorLimCons.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
__fastcall TConsumLimit::TConsumLimit(TComponent* Owner,TSplitterForm *aSP,
	TFormDescr *aFD,Classes::TNotifyEvent OnProgr,bool B_and_W):
	TDUInterior(Owner,aSP,aFD,OnProgr,B_and_W )
{
		dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemAttr->Visible = false;
/*		dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemAttr->Enabled=true;
		dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemAttr->OnClick=OnClickMenuItemAttr;
*/
		dynamic_cast<TBaseMonitorForm*>(Owner)->PopupMenuDU->OnPopup=OnPopupMenuDU;
                //GRB ADD - подписываем на перерисовку
                ((TBaseMonitorForm*)Owner)->OnResize=TDUInterior::FormShow;
}
//---------------------------------------------------------------------------
__fastcall TConsumLimit::~TConsumLimit(void)
{
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimit::Place(void)
{
	TDUInterior::Place();
	DrawTable->StaticStrings->Strings[0]=Reconst_smes118_1;
	DrawTable->OnSelectCell=OnSelectCell;
	//Invalidate(TABLE_CURR_POWER);
}
//---------------------------------------------------------------------------
AnsiString __fastcall TConsumLimit::GetSubColumnsNames(int n)
{
	static AnsiString staticNameColumns[]={Reconst_smes118_2,Reconst_smes118_3,Reconst_smes118_4,
	Reconst_smes118_5,"ERR"};
	return staticNameColumns[n];
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimit::clonesInColumns(void)
{
   TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
   static int SizeFields[]={LenFloat,LenFloat,LenFloat,LenFloat,4};
	DrawTable->FixedCols=1;

	if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
	{
		DrawTable->RowsHeight=AnsiString("#")+psm->EditColorHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthName->Text+
			AnsiString("#")+psm->EditColorWidthDigit->Text+
			AnsiString("#")+psm->EditColorWidthDigit->Text+
			AnsiString("#")+psm->EditColorWidthDigit->Text;
      switch(fd->CodeTemplate)
      {
      case 1:
      case 2:
         DrawTable->ColsWidth = DrawTable->ColsWidth + AnsiString("#")+psm->EditColorWidthDigit->Text;
         break;
      case ConsumLim_F:
      case ConsumLim_F_BW:
         DrawTable->ColsWidth = DrawTable->ColsWidth + AnsiString("#0");
         break;
      }
		DrawTable->ColsWidth = DrawTable->ColsWidth + AnsiString("#")+psm->UpDownColorWidthDigit->Position/2;
	}
	else
	{
		DrawTable->RowsHeight=AnsiString("#")+psm->EditBWHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthName->Text+
			AnsiString("#")+psm->EditBWWidthDigit->Text+
			AnsiString("#")+psm->EditBWWidthDigit->Text+
			AnsiString("#")+psm->EditBWWidthDigit->Text;
      switch(fd->CodeTemplate)
      {
      case 1:
      case 2:
         DrawTable->ColsWidth = DrawTable->ColsWidth + AnsiString("#")+psm->EditBWWidthDigit->Text;
         break;
      case ConsumLim_F:
      case ConsumLim_F_BW:
         DrawTable->ColsWidth = DrawTable->ColsWidth + AnsiString("#0");
         break;
      }
	   DrawTable->ColsWidth = DrawTable->ColsWidth + AnsiString("#")+psm->UpDownBWWidthDigit->Position/2;
	}
	if( !is_B_and_W )
	{
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b t 2 # $ m 0x0009 0x100F #$#$#$#$");
		//DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b-  t 7 # & m 0x0001 0x900C c 35 b #& c 5 b- #&#&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0009 0x100F c 15 b  t 7 a 0x26 # & m 0x0001 0x900C c36 a 0x25 #&#&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b- t 7 a 0x24 # & m 0x0001 0x900C c 5 a 0x25 #&#&#&#&");
	}
	else
	{
		DrawTable->TabStrings->Add("$ m 0x0005 0x800c b # $ m 0x0009 0x800c #$#$#$#$");
		//DrawTable->TabStrings->Add("$ m 0x0005 0x0 b- a 0x24 # & m 0x0001 0x00 b a 0x25 #& b- #&#&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0009 0x800c b a 0x26 # & m 0x0001 0x800c b a 0x25 #&#&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0005 0x800c b a 0x24 # & m 0x0001 0x800c b- a 0x25 #&#&#&#&");
	}
	DrawTable->StructStrings->Rebuild( Clones,SubColumns(),SizeFields );
   delete psm;
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimit::Invalidate( int Table )
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
void __fastcall TConsumLimit::refreshData( int Table,TOraQuery *qwInter )
{
	if(Table==TABLE_CURR_POWER)
		//selectData(dmMain->qwInter);
   selectData(qwInter);
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimit::selectData( TOraQuery *qwInter )
{
  int TempGid;
  int iClones,i;
  short ind[5];
  TCloneItem *ptr;
  double dat[5];
  unsigned long rowSelect;

	try{
   	ptr=datOracle;
    for( iClones=0 ; iClones<Clones ;++iClones ){
		  for( i=0; i<SubColumns(); ++i ){
        ZeroMemory(ptr->isvalid,sizeof(ptr->isvalid));
			  (ptr++)->val=-MAXFLOAT;
      }
    }
// KAS Текущую дату на название формы
    dynamic_cast<TBaseMonitorForm*>(Owner)->Caption = fd->NameGroup+" на "+GetCurrentDate(qwInter);
    qwInter->Params->Clear();
    qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.TConsumLimit_selectData_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9);end;";
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
        ind[0]=0;
        dat[0]=qwInter->FieldByName("limit")->AsFloat;
      }else
        ind[0]=-1;
      if(!qwInter->FieldByName("afact")->IsNull){
        ind[1]=0;
        dat[1]=qwInter->FieldByName("afact")->AsFloat;}
      else
        ind[1]=-1;
      if(!qwInter->FieldByName("limfact")->IsNull){
        ind[2]=0;
        dat[2]=qwInter->FieldByName("limfact")->AsFloat;}
      else
        ind[2]=-1;
      if(!qwInter->FieldByName("armor")->IsNull){
        ind[3]=0;
        dat[3]=qwInter->ParamByName("armor")->AsFloat;
      }else
        ind[3]=-1;
      if(!qwInter->FieldByName("obs")->IsNull){
        ind[4]=0;
        dat[4]=qwInter->FieldByName("obs")->AsFloat;}
      else
        ind[4]=-1;
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
	}catch( Exception &e ){
  }
  OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimit::clickDialog(long ACol, long ARow )
{
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimit::OnClickMenuItemAttr(TObject *Sender)
{
	if(DrawTable->Row>1)
		clickDialog(0, DrawTable->Row );
}
//---------------------------------------------------------------------------
void __fastcall TConsumLimit::dataInColumns(void)
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
		    *ptr='\x00';
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
			    datOracle[jColumns].val=datOracle[iClones*SubColumns()+jColumns].val;
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
		sprintf(ptr,"*\x0");
    VT_PrintData->Fields->FieldByName("Data"+IntToStr(SubColumns()))->AsString = ptr;//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
    VT_PrintData->Post();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DrawTable->RowsHeight=RowsHeight;
    /*	dynamic_cast<TBaseMonitorForm*>(Owner)->Caption=
	fd->NameGroup+" за "+fd->DateTime.FormatString("ddddd")+ptr_hour;
	dynamic_cast<TBaseMonitorForm*>(Owner)->PaintBoxCaption->Invalidate();
    */

    /*
	int iClones;
	TDrawTable::SAttrCell* pAtr;
	TDUInterior::dataInColumns();
	for( iClones=0 ; iClones<Clones ; ++iClones )
	{
		pAtr=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(4,iClones+1);
		if(datOracle[iClones*SubColumns()+3].val>0.0)
		{
			if( !is_B_and_W )
				pAtr->FontColor=clRed;
			else
				pAtr->FontStyle<<fsBold;
		}
		else
		{
			if( !is_B_and_W )
				pAtr->FontColor=clBlack;
			else
				pAtr->FontStyle>>fsBold;
		}
	}
    */
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

//Получает данные о считываемой таблице
void __fastcall TConsumLimit::formDescr( void )
{
   fd->IdGroup = GroupJump(fd->IdGroup);

	//Заполняем необходимые поля описания формы
	Clones = 0;

  dmMain->oqInterCursor->Params->Clear();
  dmMain->oqInterCursor->SQL->Text = " begin "+SchemeName+"interior_pg.TConsumLimit_formDescr_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7);end;";
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
	NamesClones->AddObject(Reconst_smes118_7,(TObject*)NULL);
  while(!dmMain->oqInterCursor->Eof){
   Clones++;
   NamesClones->AddObject(dmMain->oqInterCursor->FieldByName("name")->AsString,(TObject*)dmMain->oqInterCursor->FieldByName("mid")->AsInteger);
   dmMain->oqInterCursor->Next();
  }
  dmMain->oqInterCursor->Close();

  if( Clones==0 )
		throw(Exception(Reconst_smes118_8));
  Clones++;
}

//---------------------------------------------------------------------------
void __fastcall TConsumLimit::OnSelectCell(TObject* Sender, int Col, int Row, bool &CanSelect)
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
void __fastcall TConsumLimit::OnPopupMenuDU(TObject *Sender)
{
	if( dynamic_cast<TBaseMonitorForm*>(Owner) )
	{
		TBaseMonitorForm* pOwner=dynamic_cast<TBaseMonitorForm*>(Owner);
		TDUInterior::OnPopupMenuDU(Sender);
		if( DrawTable->Row<=1 )
		{
			pOwner->MenuItemGroup->Enabled=false;
			pOwner->MenuItemAttr->Enabled=false;
		}
		else
		{
			pOwner->MenuItemAttr->Enabled=true;
			pOwner->MenuItemGroup->Enabled=true;
		}
	}
}
//---------------------------------------------------------------------------

