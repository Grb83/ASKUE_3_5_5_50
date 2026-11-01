//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "InteriorConsImbalance.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "Reconst.hpp"
#define MAX_SELECT 500
//---------------------------------------------------------------------------
__fastcall TConsumImbalance::TConsumImbalance(TComponent* Owner,TSplitterForm *aSP,
	TFormDescr *aFD,Classes::TNotifyEvent OnProgr,bool B_and_W):
	TDUInterior(Owner,aSP,aFD,OnProgr,B_and_W )
{
		dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemAttr->Enabled=true;
		dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemAttr->OnClick=OnClickMenuItemAttr;
		dynamic_cast<TBaseMonitorForm*>(Owner)->PopupMenuDU->OnPopup=OnPopupMenuDU;
                //GRB ADD - подписываем на перерисовку
                ((TBaseMonitorForm*)Owner)->OnResize=TDUInterior::FormShow;
}
//---------------------------------------------------------------------------
__fastcall TConsumImbalance::~TConsumImbalance(void)
{
}
//---------------------------------------------------------------------------
void __fastcall TConsumImbalance::Place(void)
{
	TDUInterior::Place();
	DrawTable->StaticStrings->Strings[0]=Reconst_smes108_1;
	DrawTable->OnSelectCell=OnSelectCell;
	//Invalidate(TABLE_CURR_POWER);
}
//---------------------------------------------------------------------------
AnsiString __fastcall TConsumImbalance::GetSubColumnsNames(int n)
{
	static AnsiString staticNameColumns[]={Reconst_smes108_2,Reconst_smes108_3,Reconst_smes108_4,"ERR"};
	static AnsiString staticNameColumns1[]={Reconst_smes108_5,Reconst_smes108_6,Reconst_smes108_4,"ERR"};
    if(fd->CodeTemplate==ConsumImbalance_POW_F)
        return staticNameColumns1[n];
    else return staticNameColumns[n];
}
//---------------------------------------------------------------------------
void __fastcall TConsumImbalance::clonesInColumns(void)
{
   TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
static int SizeFields[]={LenFloat,LenFloat,LenFloat,4};
	DrawTable->FixedCols=1;
	if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
	{
		DrawTable->RowsHeight=AnsiString("#")+psm->EditColorHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthName->Text+
			AnsiString("#")+psm->EditColorWidthDigit->Text+
			AnsiString("#")+psm->EditColorWidthDigit->Text+
			AnsiString("#")+psm->UpDownColorWidthDigit->Position/1.3+
			AnsiString("#")+psm->UpDownColorWidthDigit->Position/2;
	}
	else
	{
		DrawTable->RowsHeight=AnsiString("#")+psm->EditBWHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthName->Text+
			AnsiString("#")+psm->EditBWWidthDigit->Text+
			AnsiString("#")+psm->EditBWWidthDigit->Text+
			AnsiString("#")+psm->UpDownBWWidthDigit->Position/1.3+
			AnsiString("#")+psm->UpDownBWWidthDigit->Position/2;
	}
	if( !is_B_and_W )
	{
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b t 2 # $ m 0x0009 0x100F #$#$#$");
		//DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b-  t 7 # & m 0x0001 0x900C c 35 b #& c 5 b- #&#&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0009 0x100F c 15 b  t 7 a 0x26 # & m 0x0001 0x900C c36 a 0x25 #&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b- t 7 a 0x24 # & m 0x0001 0x900C c 5 a 0x25 #&#&#&");
	}
	else
	{
		DrawTable->TabStrings->Add("$ m 0x0005 0x800c b # $ m 0x0009 0x800c #$#$#$");
		//DrawTable->TabStrings->Add("$ m 0x0005 0x0 b- a 0x24 # & m 0x0001 0x00 b a 0x25 #& b- #&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0009 0x800c b a 0x26 # & m 0x0001 0x800c b a 0x25 #&#&#&");
		DrawTable->TabStrings->Add("$ m 0x0005 0x800c b a 0x24 # & m 0x0001 0x800c b- a 0x25 #&#&#&");
	}
	DrawTable->StructStrings->Rebuild( Clones,SubColumns(),SizeFields );
   delete psm;
}
//---------------------------------------------------------------------------
void __fastcall TConsumImbalance::Invalidate( int Table )
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
void __fastcall TConsumImbalance::refreshData( int Table,TOraQuery *qwInter )
{
	if(Table==TABLE_CURR_POWER)
		selectData(qwInter);
}
//---------------------------------------------------------------------------
void __fastcall TConsumImbalance::selectData(TOraQuery *qwInter )
{
  unsigned short year, month, day;
	unsigned short hour, minute, sec, msec;
	int TempGid;
	int iClones,i;
	short ind[4];
  char currTime[20];
	TCloneItem *ptr;
  double dat[4];
  char FirstDate[20], LastDate[20];

	try{
    fd->DateTime.DecodeDate(&year, &month, &day);
    ptr=datOracle;
    for( iClones=0 ; iClones<Clones ;++iClones ){
      for( i=0; i<SubColumns(); ++i ){
        ZeroMemory(ptr->isvalid,sizeof(ptr->isvalid));
        (ptr++)->val=-MAXFLOAT;
      }
    }
    if(fd->CodeTemplate==ConsumImbalance_POW_F){
      // KAS Текущую дату на название формы
      dynamic_cast<TBaseMonitorForm*>(Owner)->Caption = fd->NameGroup+Reconst_smes108_7+GetCurrentDate(qwInter);
    }else{
      switch (fd->StepProfile){
        case TFormDescr::stpMonth:
          strcpy( FirstDate,(TDateTime(year, 1, 1)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
          strcpy( LastDate,TDateTime(year+1, 1, 1).FormatString(DateTimeFormat).c_str());
          break;
        case TFormDescr::stpDay:
          strcpy( FirstDate,(TDateTime(year, month, 1)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
          strcpy( LastDate,(TDateTime(year, month, 1)+RowCount).FormatString(DateTimeFormat).c_str());
          break;
        case TFormDescr::stpHour:
          strcpy( FirstDate,(TDateTime(year, month, day)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
          strcpy( LastDate,(TDateTime(year, month,day)+1).FormatString(DateTimeFormat).c_str());
          break;
        case TFormDescr::stpMinute:
          throw Exception(Reconst_smes108_8);
      }
    }
    qwInter->Params->Clear();
    qwInter->SQL->Text="begin "+SchemeName+"interior_pg.TConsumImbalance_selectData_p(:par1,:par2,:par3,:par4,:par5, \
                             :par6,:par7,:par8,:par9,:par10,:par11);end;";
    qwInter->ParamByName("par11")->DataType=ftCursor;
    qwInter->ParamByName("par11")->ParamType=ptOutput;

    for( iClones=0 ; iClones<Clones ;++iClones ){
      TempGid=(int)NamesClones->Objects[iClones];

      qwInter->ParamByName("par1")->AsInteger= fd->IsPoints?1:0;
      qwInter->ParamByName("par2")->AsString=ObsoleteTimeLimit;
      qwInter->ParamByName("par3")->AsInteger=fd->CodeTemplate;
      qwInter->ParamByName("par4")->AsInteger=fd->StepProfile;
      qwInter->ParamByName("par5")->AsInteger=TempGid;
      qwInter->ParamByName("par6")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
      qwInter->ParamByName("par7")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
      qwInter->ParamByName("par8")->AsInteger=fd->GetPeriod(fd->DateTime);
      qwInter->ParamByName("par9")->AsString=FirstDate;
      qwInter->ParamByName("par10")->AsString=LastDate;

      qwInter->Execute();
      strcpy(currTime,qwInter->FieldByName("currTime")->AsString.c_str());
      if(!qwInter->FieldByName("ain")->IsNull){
        ind[0]=0;
        dat[0]=qwInter->FieldByName("ain")->AsFloat; }
      else
        ind[0]=-1;
      if(!qwInter->FieldByName("aall")->IsNull){
        ind[1]=0;
        dat[1]=qwInter->FieldByName("aall")->AsFloat; }
      else
        ind[1]=-1;
      if(!qwInter->FieldByName("dat")->IsNull){
        ind[2]=0;
        dat[2]=qwInter->FieldByName("dat")->AsFloat;
      }else
        ind[2]=-1;
      if(!qwInter->FieldByName("obsolete")->IsNull){
        ind[3]=0;
        dat[3]=qwInter->FieldByName("obsolete")->AsFloat;
      }else
        ind[3]=-1;

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
    if(fd->CodeTemplate==ConsumImbalance_POW_F){
      dynamic_cast<TBaseMonitorForm*>(Owner)->Caption=fd->NameGroup+" на "+currTime;
      dynamic_cast<TBaseMonitorForm*>(Owner)->PaintBoxCaption->Invalidate();
    }
  }catch(Exception &e){
    throw;
  }
  OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TConsumImbalance::clickDialog(long ACol, long ARow )
{
}
//---------------------------------------------------------------------------
void __fastcall TConsumImbalance::OnClickMenuItemAttr(TObject *Sender)
{
	if(DrawTable->Row>1)
		clickDialog(0, DrawTable->Row );
}
//---------------------------------------------------------------------------
void __fastcall TConsumImbalance::dataInColumns(void)
{
    int iClones,jColumns;
	char *ptr;
	char HeightCell[16];
	char ptr_hour[8];
	bool isSumm;
	AnsiString RowsHeight;
	//Подготавливаем переменные поля для приема
	ptr = DrawTable->StructStrings->GetArray();
    TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
	if(dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont)
	    sprintf(HeightCell,"#%s",psm->EditColorHeight->Text.c_str());
	else
        sprintf(HeightCell,"#%s",psm->EditBWHeight->Text.c_str());
    delete psm;

	RowsHeight=HeightCell;
	RowsHeight=RowsHeight+AnsiString(HeightCell);
	*ptr_hour = 0;
    VT_PrintData->First();
    VT_PrintData->Next();
    datOracle[SubColumns()-1].val = -1;
	for(iClones=0; iClones<Clones; ++iClones)
	{
        VT_PrintData->Edit();
        for(jColumns=0; jColumns<SubColumns()-1; ptr+=LenFloat,++jColumns)
        {
            if(datOracle[iClones*SubColumns()+jColumns].val!=-MAXFLOAT)
                strcpy(ptr, FormatFloat("#,###,##0.000;;0.0",datOracle[iClones*SubColumns()+jColumns].val).c_str());
            else
                *ptr=0;
            VT_PrintData->Fields->FieldByName("Data"+IntToStr(jColumns+1))->AsString = ptr;
        }
        if(datOracle[iClones*SubColumns()+SubColumns()-1].val>0.0 ||
		    datOracle[iClones*SubColumns()+SubColumns()-1].val==-MAXFLOAT)
			strcpy(ptr,"*");
		else
			*ptr=0;
        VT_PrintData->Fields->FieldByName("Data"+IntToStr(SubColumns()))->AsString = ptr;
		ptr+=4;

        if(datOracle[iClones*SubColumns()+SubColumns()-1].val>0.0 ||
            datOracle[iClones*SubColumns()+SubColumns()-1].val==-MAXFLOAT)
            datOracle[SubColumns()-1].val=1.0;
        VT_PrintData->Next();
    }
    ptr=DrawTable->StructStrings->GetArray();
    VT_PrintData->First();
    VT_PrintData->Edit();
	for(jColumns=0; jColumns<SubColumns()-1; ptr+=LenFloat,++jColumns)
    {
        if(datOracle[jColumns].val!=-MAXFLOAT)
		    strcpy(ptr, FormatFloat("#,###,##0.000;;0.0",datOracle[jColumns].val).c_str());
        else
		    *ptr=0;
        VT_PrintData->Fields->FieldByName("Data"+IntToStr(jColumns+1))->AsString = ptr;
    }
	if(datOracle[SubColumns()-1].val>0.0 ||
	    datOracle[SubColumns()-1].val==-MAXFLOAT)
		strcpy(ptr,"*");
    VT_PrintData->Fields->FieldByName("Data"+IntToStr(SubColumns()))->AsString = ptr;
    VT_PrintData->Post();
	DrawTable->RowsHeight=RowsHeight;
}
//---------------------------------------------------------------------------
//Получает данные о считываемой таблице
void __fastcall TConsumImbalance::formDescr( void )
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

	NamesClones->AddObject(Reconst_smes108_10,(TObject*)fd->IdGroup);
  while (!dmMain->oqInterCursor->Eof){
     ++Clones;
     NamesClones->AddObject(dmMain->oqInterCursor->FieldByName("name")->AsString,(TObject*)dmMain->oqInterCursor->FieldByName("mid")->AsInteger);
     dmMain->oqInterCursor->Next();
   }
  dmMain->oqInterCursor->Close();
  if(!Clones)
		throw(Exception(Reconst_smes108_9));
  else Clones++;
}
//---------------------------------------------------------------------------
void __fastcall TConsumImbalance::OnSelectCell(TObject* Sender, int Col, int Row, bool &CanSelect)
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
void __fastcall TConsumImbalance::OnPopupMenuDU(TObject *Sender)
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



