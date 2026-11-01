//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "InteriorDecad.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
__fastcall TDecadInterior::TDecadInterior(TComponent* Owner,TSplitterForm *aSP,
	TFormDescr *aFD,Classes::TNotifyEvent OnProgr,bool B_and_W ):TDUInterior(Owner,aSP,aFD,OnProgr,B_and_W)
{
                //GRB ADD - подписываем на перерисовку
                ((TBaseMonitorForm*)Owner)->OnResize=TDUInterior::FormShow;
}
//---------------------------------------------------------------------------
__fastcall TDecadInterior::~TDecadInterior(void)
{
}
//---------------------------------------------------------------------------
void __fastcall TDecadInterior::Place(void)
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
      //setDataSourceToDrawTable(DrawTable,datOracle,Clones,SubColumns(),1);
		Invalidate(TABLE_BILL);
      //26.08.2021 GRB ADD
        if (GetContainedWidthStatusFromReg())
        TDUInterior::AutoSizeNameOnly (DrawTable);
        //END ADD
   }
   catch(Exception &e)
   {
		if(DrawTable)
		{
			SplitterForm->RemoveChild( DrawTable );
			delete DrawTable;
			DrawTable=NULL;
		}
		throw(Exception(Reconst_smes109_1));
   }
}
//---------------------------------------------------------------------------
void __fastcall TDecadInterior::dataInColumns(void)
{
	int iClones,jColumns;
	char *ptr;
	TDrawTable::SAttrCell* pAtr;
	//Подготавливаем переменные поля для приема
	ptr=DrawTable->StructStrings->GetArray();
        VT_PrintData->First();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	for( iClones=0 ; iClones<Clones ; ++iClones )
	{
        VT_PrintData->Edit();//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
		for(jColumns=0; jColumns<SubColumns(); ptr+=LenFloat,++jColumns)
        {
            if(datOracle[iClones*SubColumns()+jColumns].val!=-MAXFLOAT)
                strcpy(ptr, FormatFloat(MyFloatFormat,datOracle[iClones*SubColumns()+jColumns].val).c_str());
            else
                *ptr=0;
            VT_PrintData->Fields->FieldByName("Data"+IntToStr(jColumns+1))->AsString = ptr;
        }
        VT_PrintData->Next();//++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	}
}
//---------------------------------------------------------------------------

void __fastcall TDecadInterior::clonesInColumns(void)
{
   TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
static int SizeFields[]={LenFloat,LenFloat,LenFloat};
	DrawTable->FixedCols=1;
	if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
	{
		DrawTable->RowsHeight=AnsiString("#")+psm->EditColorHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthName->Text+
			AnsiString("#")+psm->UpDownColorWidthDigit->Position+
			AnsiString("#")+psm->EditColorWidthDigit->Text;
  	}
	else
	{
		DrawTable->RowsHeight=AnsiString("#")+psm->EditBWHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthName->Text+
			AnsiString("#")+psm->UpDownBWWidthDigit->Position+
			AnsiString("#")+psm->EditBWWidthDigit->Text;
	}
	if( !is_B_and_W )
	{
		DrawTable->TabStrings->Add(" m 0x0009 0x100F c 15 b t 2 # $  #$#$");
                if(fd->SummGroup)
                    DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b  t 2 A0x8000# A0x8025 & m 0x0001 0x900C c 36 b- # &  # &");
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b-  t 7 A0x8000#A0x8025 & m 0x0001 0x900C c 5 # & #&");
	}
	else
	{
		DrawTable->TabStrings->Add(" m 0x0009 0x1008 # $ #$#$");
                if(fd->SummGroup)
                    DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b  t 7 A0x8000#A0x8025 & m 0x0001 0x900C c 5 b- # &  #&");
  		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b-  t 7 A0x8000#A0x8025 & m 0x0001 0x900C c 5 # &  #&");
	}
	DrawTable->StructStrings->Rebuild( Clones,SubColumns(),SizeFields );
   delete psm;
}
//---------------------------------------------------------------------------
//Обновление данных из базы
//NameAlert=-1 для обновления в любом случае
void __fastcall TDecadInterior::refreshData( int Table,TOraQuery *qwInter )
{
	if(Table==TABLE_BILL)
		selectData(qwInter);
}
//---------------------------------------------------------------------------
void __fastcall TDecadInterior::Invalidate( int Table )
{
	if(Table==TABLE_BILL)
	{
		dataInColumns();
		DrawTable->Invalidate();
		OnProgressBarStepBy(NULL);
	}
	--refreshDataCount;
}
//---------------------------------------------------------------------------

//Получает данные о считываемой таблице
void __fastcall TDecadInterior::formDescr( void )
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
  NamesClones->AddObject(fd->ShortNameGroup,(TObject*)fd->IdGroup);
  while(!dmMain->oqInterCursor->Eof){
    NamesClones->AddObject(dmMain->oqInterCursor->FieldByName("name")->AsString,(TObject*)dmMain->oqInterCursor->FieldByName("mid")->AsInteger);
    dmMain->oqInterCursor->Next();
    Clones++;
  }
  dmMain->oqInterCursor->Close();
	if(!Clones){
    fd->SummGroup=true;
    Clones = 1;
  }else
    Clones++;
}
//---------------------------------------------------------------------------
void __fastcall TDecadInterior::selectData(TOraQuery *qwInter)
{
  int TempGid;
	int iClones;
	TCloneItem *ptr;
  struct {
    double val;
    int nsource;
    char isvalid[32];
  } dat[3];
	short ind[3];

	try{
    ptr=datOracle;
    for( iClones=0 ; iClones<Clones ;++iClones ){
      ZeroMemory(ptr->isvalid,sizeof(ptr->isvalid));
      (ptr++)->val=0.0;
      for(int i=1; i<SubColumns(); ++i ){
        ZeroMemory(ptr->isvalid,sizeof(ptr->isvalid));
        (ptr++)->val=-MAXFLOAT;
      }
    }

    for( iClones=0 ; iClones<Clones ;++iClones ){
      TempGid=(int)NamesClones->Objects[iClones];

      qwInter->Params->Clear();
      qwInter->SQL->Text="begin "+SchemeName+"interior_pg.TDecadInterior_selectData_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par9);end;";
      qwInter->ParamByName("par9")->DataType=ftCursor;
      qwInter->ParamByName("par9")->ParamType=ptOutput;

      qwInter->ParamByName("par1")->AsInteger= fd->IsPoints?1:0;
      qwInter->ParamByName("par2")->AsString=fd->DateTime.FormatString(DateTimeFormat);
      qwInter->ParamByName("par3")->AsInteger=fd->CodeTemplate;
      qwInter->ParamByName("par4")->AsInteger=fd->StepProfile;
      qwInter->ParamByName("par5")->AsInteger=TempGid;
      qwInter->ParamByName("par6")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
      qwInter->ParamByName("par7")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
      qwInter->ParamByName("par8")->AsInteger=fd->GetPeriod(fd->DateTime);

      qwInter->Execute();
      int i=0;

      while(!qwInter->Eof){
        if(!qwInter->FieldByName("val")->IsNull){
          ind[i]=0;
          dat[i].val= qwInter->FieldByName("val")->AsFloat;
          strcpy(dat[i].isvalid,qwInter->FieldByName("nsource")->AsString.c_str());
        }else
          ind[i]=-1;
        qwInter->Next();
        i++;
      }
      qwInter->Close();

      if(i){
        datOracle[iClones*SubColumns()+0].val=ind[0]?-MAXFLOAT:dat[0].val;
        if(ind[0])
          datOracle[iClones*SubColumns()+0].isvalid[0] = '\0';
        else
          strcpy(datOracle[iClones*SubColumns()+0].isvalid,dat[0].isvalid);
        datOracle[iClones*SubColumns()+1].val=ind[1]?-MAXFLOAT:dat[1].val;
        if(ind[1])
          datOracle[iClones*SubColumns()+1].isvalid[0] = '\0';
        else
          strcpy(datOracle[iClones*SubColumns()+1].isvalid,dat[1].isvalid);
        datOracle[iClones*SubColumns()+2].val=ind[2]?-MAXFLOAT:dat[2].val;
        if(ind[2])
          datOracle[iClones*SubColumns()+2].isvalid[0] = '\0';
        else
          strcpy(datOracle[iClones*SubColumns()+2].isvalid,dat[2].isvalid);
      }else{
        datOracle[iClones*SubColumns()+0].val=-MAXFLOAT;
        datOracle[iClones*SubColumns()+0].isvalid[0] = '\0';
        datOracle[iClones*SubColumns()+1].val=-MAXFLOAT;
        datOracle[iClones*SubColumns()+1].isvalid[0] = '\0';
        datOracle[iClones*SubColumns()+2].val=-MAXFLOAT;
        datOracle[iClones*SubColumns()+2].isvalid[0] = '\0';
      }
      OnProgressBarStepBy(this);
    }
  }catch( Exception &e ){
  }
	OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
AnsiString __fastcall TDecadInterior::GetSubColumnsNames(int n)
{
  AnsiString Name_Columns[3];
  unsigned short d,m,y;
  TDateTime DT = IncMonth(fd->DateTime,1);
  DT.DecodeDate(&y,&m,&d);
  DT = EncodeDate(y,m,1);
  DT = DT-1;
  NameCol1 = "10."+fd->DateTime.FormatString("mm");
  NameCol2 = "20."+fd->DateTime.FormatString("mm");
  NameCol3 = DT.FormatString("dd.mm");
  Name_Columns[0] = NameCol1;
  Name_Columns[1] = NameCol2;
  Name_Columns[2] = NameCol3;
	return Name_Columns[n];
}
//---------------------------------------------------------------------------
void __fastcall TDecadInterior::clickComposition(long ACol, long ARow )
{
  unsigned long i;
  long IdGroup,j;
	IdGroup=0;
	if(ARow==1){
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
    dmMain->oqInterCursor->ParamByName("par1")->AsInteger=0;
    dmMain->oqInterCursor->ParamByName("par2")->AsInteger=fd->IdGroup;

    dmMain->oqInterCursor->Execute();
    IdGroup=dmMain->oqInterCursor->FieldByName("IdGroup")->AsInteger;
    dmMain->oqInterCursor->Close();
  }else{
    IdGroup=(long)NamesClones->Objects[ARow-1];
    //***************** Для списков *********************************************************************************
    IdGroup = GroupJump(IdGroup);
    if(!IdGroup)
      return;
    //*************************************************************************************************************
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
		fd->SummGroup=(dmMain->oqInterCursor->FieldByName("SumGroup")->AsString=="y");
    dmMain->oqInterCursor->Close();
    refreshForm();
  }else
    dmMain->oqInterCursor->Close();
}
//---------------------------------------------------------------------------
void __fastcall TDecadInterior::OnClickMenuItemMainGroup(TObject *Sender)
{
	clickComposition(0, 1 );
}
//---------------------------------------------------------------------------
void __fastcall TDecadInterior::PrintTable()
{
   AnsiString RepTitle;
   TPrintDrawTable *PrintTable = new TPrintDrawTable(this);
   switch( fd->StepProfile )
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
   }
   TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
   PrintTable->PrintTable(RepTitle, fd->CommentForm, ColumnsCaption, VT_PrintData,
      fd->VerticalSplit?psm->EditColorWidthName->Text.ToInt():psm->EditColorWidthDigit->Text.ToInt(),
      fd->VerticalSplit?psm->EditColorWidthDigit->Text.ToInt():psm->EditColorWidthName->Text.ToInt(),1,fd);
   delete PrintTable;
   delete psm;
}
//---------------------------------------------------------------------------


