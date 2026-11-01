//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <string.h>
#pragma hdrstop
#include "MonitorForm.h"
#include "InteriorDU.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
__fastcall TDUInterior::TDUInterior(TComponent* Owner,TSplitterForm *aSP,
	TFormDescr *aFD,Classes::TNotifyEvent OnProgr,bool B_and_W ):TInterior(Owner,aSP,aFD,OnProgr ),
	is_B_and_W(B_and_W)
{
	if( dynamic_cast<TWinControl*>(Owner) )
	{
try
{
                aFD->VerticalSplit = true;
		ClonePressed=false;
		NamesClones=new TStringList();
		dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemGroup->OnClick=OnClickMenuItemGroup;
		dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemMainGroup->OnClick=OnClickMenuItemMainGroup;
		dynamic_cast<TBaseMonitorForm*>(Owner)->PopupMenuDU->OnPopup=OnPopupMenuDU;
		dynamic_cast<TBaseMonitorForm*>(Owner)->MenuItemAttr->Enabled=false;
		if( is_B_and_W )
		{
			dynamic_cast<TBaseMonitorForm*>(Owner)->Tag=1;
			dynamic_cast<TForm*>(Owner)->Color=clWindow;
		}
		//Загружаем из базы полное описание таблицы
		OnProgressBarStepBy(NULL);//0
		formDescr();
		OnProgressBarStepBy(this);//10

		datOracle=new TCloneItem[ Clones*SubColumns() ];

		//Загружаем из базы данные
		/*
		OnProgressBarStepBy(NULL);//20
		OnProgressBarStepBy(NULL);//70
		OnProgressBarStepBy(NULL);//90
		OnProgressBarStepBy(NULL);//60
		OnProgressBarStepBy(NULL);//0
		OnProgressBarStepBy(NULL);//50
		*/
		//selectData( dmMain->qwInter );
    selectData( dmMain->oqInterCursor );
		OnProgressBarStepBy(this);//30
    //GRB ADD - подписываем на перерисовку
    ((TBaseMonitorForm*)Owner)->OnResize=FormShow;
}
catch(Exception &e)
{
		delete NamesClones;
		if(datOracle)
			delete [] datOracle;
		throw;
}
catch(...)
{
		delete NamesClones;
		if(datOracle)
			delete [] datOracle;
		throw(Exception(Reconst_smes110_1));
}
	}
	else
		throw(Exception(Reconst_smes110_2));
}
//---------------------------------------------------------------------------
__fastcall TDUInterior::~TDUInterior(void)
{
    if(DrawTable) delete DrawTable;
	if(NamesClones) delete NamesClones;
	if(datOracle) delete [] datOracle;
}
//---------------------------------------------------------------------------
//Снятие со SplitterFom таблицы и графика, вызываемтся при обновлении TBaseMonitorForm
void __fastcall TDUInterior::Destroy(void)
{
	SplitterForm->RemoveChild(DrawTable);
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::Place(void)
{
    int i;
    try
    {
        //Создаем таблицу
	    //Укладываем таблицу в SplitterForm
	    DrawTable=new TDrawTable(Owner);

        SplitterForm->AddChild(NULL,DrawTable,alRight);
        SplitterForm->SplitFormResize(NULL);

        //======== Форматирование таблицы

	    TPopupMenu *pPopup=
            (dynamic_cast<TBaseMonitorForm*>(Owner))->PopupMenuDU;
        DrawTable->PopupMenu=pPopup;
        DrawTable->PopupMenu->AutoPopup=false;
        pPopup=(dynamic_cast<TBaseMonitorForm*>(Owner))->PopupMenu;
        pPopup->AutoPopup=false;

        DrawTable->OnEnter=OnClickPanel;
    	DrawTable->OnMouseDown=DrawTableMouseDown;
	    DrawTable->OnMouseMove=DrawTableMouseMove;
    	DrawTable->OnMouseUp=DrawTableMouseUp;
	    DrawTable->OnKeyUp=OnKeyUp;

    	DrawTable->Options>>goRangeSelect>>goFixedVertLine>>goFixedHorzLine
			>>goVertLine>>goHorzLine;
	    DrawTable->DefaultDrawing=false;
    	DrawTable->ColCount=1+SubColumns();
	    DrawTable->RowCount=Clones+1;

        // -------------- Для печати -----------------------------------------------------------------------
        //столбцы для названий точек(времени) и и подколонок
        ColumnsCaption->Clear();
        VT_PrintData->Close();
        VT_PrintData->Clear();
        VT_PrintData->FieldDefs->Clear();
        VT_PrintData->FieldDefs->Add("RowName", ftString, 50, false);
        VT_PrintData->FieldDefs->Add("SubRowName", ftString, 30, false);
        for(int CC = 1; CC<=SubColumns(); CC++) // RowCount+1 - Столбцы для данных
        {
            VT_PrintData->FieldDefs->Add("Data"+IntToStr(CC), ftString, 20, false);
        }
        VT_PrintData->Open();
        // -------------------------------------------------------------------------------------------------

        OnProgressBarStepBy(this);//40
        DrawTable->StaticStrings->Add(Reconst_smes110_3);
        for(i=0;i<SubColumns();++i)
        {
            DrawTable->StaticStrings->Add(GetSubColumnsNames(i));
            ColumnsCaption->Add(GetSubColumnsNames(i));
        }
        for( i=0; i<NamesClones->Count ;++i)
        {
            VT_PrintData->Append();
            DrawTable->StaticStrings->Add(NamesClones->Strings[i]);
            VT_PrintData->Fields->FieldByName("RowName")->AsString = NamesClones->Strings[i];
            VT_PrintData->Post();
        }
        clonesInColumns();

        DrawTable->UpdateTabStrings();
//        setDataSourceToDrawTable(DrawTable,datOracle,Clones,SubColumns(),1);
        Invalidate(TABLE_CURR_POWER);
        //26.08.2021 GRB ADD
        if (GetContainedWidthStatusFromReg())
        AutoSizeNameOnly (DrawTable);
        //end ADD
    }catch(Exception&e){
        if(DrawTable)
		{
		    SplitterForm->RemoveChild( DrawTable );
			delete DrawTable;
			DrawTable=NULL;
		}
		throw(Exception(Reconst_smes110_4));
    }
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::dataInColumns(void)
{
	int iClones,jColumns;
	char *ptr;
        AnsiString Date;
	TDrawTable::SAttrCell* pAtr;
	//Подготавливаем переменные поля для приема
	ptr=DrawTable->StructStrings->GetArray();
        VT_PrintData->First();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	for( iClones=0 ; iClones<Clones ; ++iClones )
	{
                VT_PrintData->Edit();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
		pAtr=(TDrawTable::SAttrCell*)DrawTable->GetCellAttr(1,iClones+1);
                Date = AnsiString(datOracle[iClones*SubColumns()].val);

 	if(datOracle[iClones*SubColumns()].val>0.0 || datOracle[iClones*SubColumns()].val==-MAXFLOAT
                  ||datOracle[iClones*SubColumns()].val==0)

		{
                 if(datOracle[iClones*SubColumns()].val==0)
                  *ptr = 0;
                  else
                  {
                       // Date = (Date.Length()<8)?"0"+Date:Date;
                       while(Date.Length()<8){
                                Date ="0"+Date;
                                }
                         sprintf(ptr,"%s.%s %s:%s",Date.SubString(1,2),Date.SubString(3,2),
                         Date.SubString(5,2),Date.SubString(7,2));
                 }


			if( !is_B_and_W )
			{
				pAtr->BackgroundColor=clLime;
				pAtr->FontColor=clBlack;
			}
			pAtr->FontStyle<<fsBold;
		}
		else
		{

/*                        int ii=(int)datOracle[iClones*SubColumns()].val/10000;
                        sprintf(ptr,"%#2d %02d:%02d",-ii,
 KAS                              (-(int)(-10000*ii+datOracle[iClones*SubColumns()].val)/100),
                               (-(int)(-10000*ii+datOracle[iClones*SubColumns()].val)%100));
*/
                        Date = (Date.Length()<9)?"0"+Date.SubString(2,7):Date.SubString(2,8);
                        sprintf(ptr,"%s.%s %s:%s",Date.SubString(1,2),Date.SubString(3,2),
                               Date.SubString(5,2),Date.SubString(7,2));
   if( !is_B_and_W )
			{
				pAtr->BackgroundColor=clRed;
				pAtr->FontColor=clWhite;
			}
			pAtr->FontStyle>>fsBold;
		}
                VT_PrintData->Fields->FieldByName("Data1")->AsString = ptr;//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
// kas 		ptr+=9;
 		ptr+=15;
          //jColumns=1
		for(jColumns=1; jColumns<SubColumns(); ptr+=LenFloat,++jColumns)
                {
                   if(datOracle[iClones*SubColumns()+jColumns].val!=-MAXFLOAT)
                      strcpy(ptr, FormatFloat("###,###,##0.000;;0.",datOracle[iClones*SubColumns()+jColumns].val).c_str());
                   else
                      *ptr = 0;
                   VT_PrintData->Fields->FieldByName("Data"+IntToStr(jColumns+1))->AsString = ptr;
                }
                VT_PrintData->Next();//++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	}
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::clonesInColumns(void)
{
//kas  static int SizeFields[]={9,LenFloat,LenFloat};
  static int SizeFields[]={15,LenFloat,LenFloat};
 	DrawTable->FixedCols=2;

	if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
	{
		DrawTable->RowsHeight=AnsiString("#")+FormSetupMonitors->EditColorHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+FormSetupMonitors->EditColorWidthName->Text+
			AnsiString("#")+FormSetupMonitors->UpDownColorWidthDigit->Position+
			AnsiString("#")+FormSetupMonitors->EditColorWidthDigit->Text;
	}
	else
	{
		DrawTable->RowsHeight=AnsiString("#")+FormSetupMonitors->EditBWHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+FormSetupMonitors->EditBWWidthName->Text+
			AnsiString("#")+FormSetupMonitors->UpDownBWWidthDigit->Position+
			AnsiString("#")+FormSetupMonitors->EditBWWidthDigit->Text;
	}
	if( !is_B_and_W )
	{
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b t 2 # $ m 0x0009 0x100F #$#$");
//		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b-  t 7 # & m 0x0001 0x900C c 35 b #& c 5 b- #&");
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b-  t 7 A0x8000#A0x8025 & m 0x0001 0x900C c 35 b # & c 5 b- #&");
	}
	else
	{
		DrawTable->TabStrings->Add("$ m 0x0005 0x1008 b # $ m 0x0009 0x1008 #$#$");
//		DrawTable->TabStrings->Add("$ m 0x0005 0x0 b- a 0x24 # & m 0x0001 0x00 b a 0x25 #& b- #&");
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b-  t 7 A0x8000#A0x8025 & m 0x0001 0x900C c 35 b # & c 5 b- #&");
	}
	DrawTable->StructStrings->Rebuild( Clones,SubColumns(),SizeFields );
	//dataInColumns();
}
//---------------------------------------------------------------------------
//Обновление данных из базы
//NameAlert=-1 для обновления в любом случае
void __fastcall TDUInterior::refreshData( int Table,TOraQuery *qwInter )
{
	if(Table==TABLE_CURR_POWER)
		//selectData(dmMain->qwInter);
     selectData(qwInter);
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::Invalidate( int Table )
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

//Получает данные о считываемой таблице
void __fastcall TDUInterior::formDescr( void )
{
  fd->IdGroup = GroupJump(fd->IdGroup);
  Clones = 0;
  

  dmMain->oqInterCursor->Params->Clear();
  dmMain->oqInterCursor->SQL->Text="begin "+SchemeName+"interior_pg.TDUInterior_formDescr_p(:par1,:par2,:par3);end;";
  dmMain->oqInterCursor->ParamByName("par3")->ParamType=ptOutput;
  dmMain->oqInterCursor->ParamByName("par3")->DataType=ftCursor;
  dmMain->oqInterCursor->ParamByName("par1")->AsInteger= fd->IdGroup;
  dmMain->oqInterCursor->ParamByName("par2")->AsInteger=fd->GetPeriod(fd->DateTime);

  dmMain->oqInterCursor->Execute();
  NamesClones->Clear();
  while(!dmMain->oqInterCursor->Eof){
    ++Clones;
    NamesClones->AddObject(dmMain->oqInterCursor->FieldByName("short_name")->AsString,(TObject*)dmMain->oqInterCursor->FieldByName("gid")->AsInteger);
    dmMain->oqInterCursor->Next();
  }
  dmMain->oqInterCursor->Close();
 	if( Clones==0 )
	  throw(Exception(Reconst_smes110_5));

}

//---------------------------------------------------------------------------
void __fastcall TDUInterior::selectData(  TOraQuery *qwInter )
{
  int TempGid;
	int iClones,i;
	TCloneItem * ptr;
  double dat[4];
  long cur_date,abs;
  short ind[20];

	try{
    ptr=datOracle;
    for( iClones=0 ; iClones<Clones ;++iClones ){
      ZeroMemory(ptr->isvalid,sizeof(ptr->isvalid));
      (ptr++)->val=0.0;
      for( i=1; i<SubColumns(); ++i ){
        ZeroMemory(ptr->isvalid,sizeof(ptr->isvalid));
        (ptr++)->val=-MAXFLOAT;
      }
    }
    dynamic_cast<TBaseMonitorForm*>(Owner)->Caption = fd->NameGroup+Reconst_smes110_6+GetCurrentDate(qwInter);
    qwInter->Params->Clear();
    qwInter->SQL->Text="begin "+SchemeName+"interior_pg.TDUInterior_selectData_p(:par1,:par2,:par3,:par4,:par5);end;";
    qwInter->ParamByName("par5")->ParamType=ptOutput;
    qwInter->ParamByName("par5")->DataType=ftCursor;
    qwInter->ParamByName("par1")->AsInteger=(fd->IsPoints)?1:0;
    qwInter->ParamByName("par2")->AsString=ObsoleteTimeLimit;
    for( iClones=0 ; iClones<Clones ;++iClones ){
      TempGid=(int)NamesClones->Objects[iClones];
      qwInter->ParamByName("par3")->AsInteger= TempGid;
      qwInter->ParamByName("par4")->AsInteger=fd->GetPeriod(fd->DateTime);
      qwInter->Execute();
      if(!qwInter->FieldByName("obsolete")->IsNull){
        ind[2]=0;
        abs=qwInter->FieldByName("obsolete")->AsInteger;
      }else
        ind[2]=-1;
      if(!qwInter->FieldByName("DT")->IsNull){
        ind[0]=0;
        dat[0]=qwInter->FieldByName("DT")->AsFloat;
      }else
        ind[0]=-1;
      if(!qwInter->FieldByName("DAT")->IsNull){
        ind[1]=0;
        dat[1]=qwInter->FieldByName("DAT")->AsFloat;
      }else
        ind[1]=-1;
      if(!qwInter->FieldByName("cur_date")->IsNull){
        ind[3]=0;
        cur_date=qwInter->FieldByName("cur_date")->AsInteger;
      }else
        ind[3]=-1;
      if(!qwInter->Eof ){
        if(cur_date!=abs)
              //  KAS	            datOracle[iClones*SubColumns()+0].val=-10000*i+cur_date;
          datOracle[iClones*SubColumns()+0].val=ind[3]?0:cur_date;
        else
          datOracle[iClones*SubColumns()+0].val=ind[2]?0:-abs;
        datOracle[iClones*SubColumns()+1].val=ind[0]?-MAXFLOAT:dat[0];
        datOracle[iClones*SubColumns()+2].val=ind[1]?-MAXFLOAT:dat[1];
      }else{
        datOracle[iClones*SubColumns()+0].val=0;
        datOracle[iClones*SubColumns()+1].val=-MAXFLOAT;
        datOracle[iClones*SubColumns()+2].val=-MAXFLOAT;
      }
      qwInter->Close();
      OnProgressBarStepBy(this);
    }
  }catch(Exception&e){
    throw;
  }
	OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
bool __fastcall TDUInterior::setSplit(void)
{
	Application->MessageBox(Reconst_smes110_7.c_str(),
	Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
   setDataSourceToDrawTable(DrawTable,datOracle,Clones,SubColumns(),1);
	return fd->VerticalSplit=true;;
}
//---------------------------------------------------------------------------
AnsiString __fastcall TDUInterior::GetSubColumnsNames(int n)
{
	static AnsiString staticNameColumns[]={"",Reconst_smes110_8,/*"План/Лимит","Отклонение",*/Reconst_smes110_11};
	return staticNameColumns[n];
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::clickDialog(long ACol, long ARow )
{
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::clickComposition(long ACol, long ARow )
{
  long IdGroup=0,j;
  if(ARow==0){
    if(fd->IdGroup==fd->IdGroupJump){//***************** Для списков
      fd->IdGroup = fd->IdGroupList; // Перешли на предприятие
      fd->IdGroupJump = 0;
      fd->IdGroupList = 0;
    }
    if(fd->IdGroup==fd->CeilingIdGroup)
      return;

    dmMain->oqInterCursor->Params->Clear();
    dmMain->oqInterCursor->SQL->Text="begin "+SchemeName+"interior_pg.TDUInterior_clickComposition_p(:par1,:par2,:par3);end;";
    dmMain->oqInterCursor->ParamByName("par3")->ParamType=ptOutput;
    dmMain->oqInterCursor->ParamByName("par3")->DataType=ftCursor;
    dmMain->oqInterCursor->ParamByName("par1")->AsInteger=ARow;
    dmMain->oqInterCursor->ParamByName("par2")->AsInteger=fd->IdGroup;

    dmMain->oqInterCursor->Execute();
    IdGroup=dmMain->oqInterCursor->FieldByName("IdGroup")->AsInteger;
    dmMain->oqInterCursor->Close();
  }else{
    long TempIdGroup;
		IdGroup=(long)NamesClones->Objects[ARow-1];
    //***************** Для списков *********************************************************************************
    IdGroup = GroupJump(IdGroup);
    if(!IdGroup)
      return;
    //*************************************************************************************************************
    dmMain->oqInterCursor->Params->Clear();
    dmMain->oqInterCursor->SQL->Text="begin "+SchemeName+"interior_pg.TDUInterior_clickComposition_p(:par1,:par2,:par3);end;";
    dmMain->oqInterCursor->ParamByName("par3")->ParamType=ptOutput;
    dmMain->oqInterCursor->ParamByName("par3")->DataType=ftCursor;
    dmMain->oqInterCursor->ParamByName("par1")->AsInteger=ARow;
    dmMain->oqInterCursor->ParamByName("par2")->AsInteger=IdGroup;

    dmMain->oqInterCursor->Execute();
    TempIdGroup=dmMain->oqInterCursor->FieldByName("TempIdGroup")->AsInteger;
    dmMain->oqInterCursor->Close();
		if(TempIdGroup==0 )
		  return;
  }
	if( IdGroup==0 || IdGroup==fd->IdGroup )
	  return;
  dmMain->oqInterCursor->Params->Clear();
  dmMain->oqInterCursor->SQL->Text="begin "+SchemeName+"interior_pg.TDUInterior_clickComp2_p(:par1,:par2);end;";
  dmMain->oqInterCursor->ParamByName("par2")->ParamType=ptOutput;
  dmMain->oqInterCursor->ParamByName("par2")->DataType=ftCursor;
  dmMain->oqInterCursor->ParamByName("par1")->AsInteger=IdGroup;

  dmMain->oqInterCursor->Execute();
  if( !dmMain->oqInterCursor->Eof ){
    fd->strGroup(dmMain->oqInterCursor->FieldByName("Name")->AsString.c_str());
		fd->NameGroup=dmMain->oqInterCursor->FieldByName("Name")->AsString;
		fd->ShortNameGroup=dmMain->oqInterCursor->FieldByName("ShortName")->AsString;
		fd->IdGroup=IdGroup;
		fd->SummGroup=(dmMain->oqInterCursor->FieldByName("SumGroup")->AsString.c_str()=="y");
    dmMain->oqInterCursor->Close();
		refreshForm();
  }else
    dmMain->oqInterCursor->Close();
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::OnClickMenuItemGroup(TObject *Sender)
{
	clickComposition(0, DrawTable->Row );
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::OnClickMenuItemMainGroup(TObject *Sender)
{
	clickComposition(0, 0 );
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::OnPopupMenuDU(TObject *Sender) /*Отображение всплывающего контекстного меню*/
{
	if( dynamic_cast<TBaseMonitorForm*>(Owner) )
	{
		TBaseMonitorForm* pOwner=dynamic_cast<TBaseMonitorForm*>(Owner);
		pOwner->SmallFont->Checked=!pOwner->isSmallFont;
		pOwner->SmallFont2->Checked=!pOwner->isSmallFont;
		pOwner->MenuItemGroup->Caption=AnsiString(Reconst_smes110_12)+
			DrawTable->StaticStrings->Strings[
				DrawTable->GetCellAttr(0, DrawTable->Row)->IndexData
				];
		if( !fd->EnableControls.Contains(TFormDescr::ctrlGroup) )
			pOwner->ByGroup->Enabled=false;
		else
			pOwner->ByGroup->Enabled=true;
	}
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::OnClickPanel(System::TObject* Sender)
{
    TBaseMonitorForm*bmn = dynamic_cast<TBaseMonitorForm*>(Owner);
    //GRB CHANGE 20.09.2021 Фиксим баг с возвращением к исходным размером при ресайзе диаграмм
    //if(bmn) bmn->FormActivate(Sender);
    if (bmn){
        bmn->FormActivate(Sender);
        if (GetContainedWidthStatusFromReg())
                AutoSizeNameOnly (DrawTable);
    }
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::OnKeyUp(TObject *Sender, WORD &Key,
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
void __fastcall TDUInterior::DrawTableMouseDown(TObject *Sender,
	TMouseButton Button, TShiftState Shift, int X, int Y)
{
#define Sender ((TDrawTable*)Sender)
	TDrawTable::SAttrCell * pAtrCell;
	int ACol, ARow;
	TShiftState leftShift;
	TShiftState rightShift;
	leftShift<<ssLeft;
	rightShift<<ssRight;

	if( (Button==mbLeft && Shift==leftShift )||//нажата только левая кнопка мыши
		(Button==mbRight && Shift==rightShift) )//нажата только правая кнопка мыши
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
void __fastcall TDUInterior::DrawTableMouseMove(TObject *Sender,
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
void __fastcall TDUInterior::DrawTableMouseUp(TObject *Sender,
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
				//Вывод диалога
				clickDialog(ColPressed, RowPressed );
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
void __fastcall TDUInterior::PrintTable()
{
    AnsiString RepTitle;
    TPrintDrawTable *PrintTable = new TPrintDrawTable(this);
    PrintTable->PrintTable(dynamic_cast<TBaseMonitorForm*>(Owner)->Caption, dynamic_cast<TBaseMonitorForm*>(Owner)->LabelComment->Caption, ColumnsCaption, VT_PrintData,
    fd->VerticalSplit?FormSetupMonitors->EditColorWidthName->Text.ToInt()+50:FormSetupMonitors->EditColorWidthDigit->Text.ToInt(),
    fd->VerticalSplit?FormSetupMonitors->EditColorWidthDigit->Text.ToInt()-10:FormSetupMonitors->EditColorWidthName->Text.ToInt(),1,fd);
    delete PrintTable;
}
//---------------------------------------------------------------------------
void __fastcall TDUInterior::SaveTableToFile(TSaveDialog *aSaveDialog)
{
    aSaveDialog->Title = Reconst_smes110_13;
    aSaveDialog->FileName = Reconst_smes110_14;
    aSaveDialog->DefaultExt = "xls";
    aSaveDialog->Filter = Reconst_smes110_15;
    if(aSaveDialog->Execute())
    {
        AnsiString RepTitle;
        TPrintDrawTable *PrintTable = new TPrintDrawTable(this);
        PrintTable->SaveTableToFile(dynamic_cast<TBaseMonitorForm*>(Owner)->Caption, dynamic_cast<TBaseMonitorForm*>(Owner)->LabelComment->Caption, ColumnsCaption, VT_PrintData,
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthName->Text.ToInt()+50:FormSetupMonitors->EditColorWidthDigit->Text.ToInt(),
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthDigit->Text.ToInt()-10:FormSetupMonitors->EditColorWidthName->Text.ToInt(),1,aSaveDialog->FileName,0);
        delete PrintTable;
    }
}
//---------------------------------------------------------------------------
//-------------------------------------------------------------------------------
//GRB ADD 26.08.2021 - два метода для автоформатирования по содержимому фиксированых колонок - исправление бага с обрезанием длинных имён в колонках
//---------------------------------------------------------------------------
void __fastcall  TDUInterior::AutoSizeColGRB (TDrawTable* tsg, int columnIndex){
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
void __fastcall TDUInterior::AutoSizeNameOnly (TDrawTable* tsg){
                AutoSizeColGRB (tsg, 0);
}
//---------------------------------------------------------------------------
TFont * __fastcall TDUInterior::GetActiveFont4MonitorFromReg (){
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
void __fastcall TDUInterior::FormShow(TObject *Sender){
         if (GetContainedWidthStatusFromReg())
                AutoSizeNameOnly (DrawTable);
}
//---------------------------------------------------------------------------
bool __fastcall TDUInterior::GetContainedWidthStatusFromReg(){
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


