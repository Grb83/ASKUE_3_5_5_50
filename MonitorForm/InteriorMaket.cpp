//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop       
#include "InteriorMaket.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)

const MAXTABLESIZE = 500;
//---------------------------------------------------------------------------
__fastcall TMaketInterior::TMaketInterior(TComponent* Owner,TSplitterForm *aSP,
	TFormDescr *aFD,Classes::TNotifyEvent OnProgr,bool B_and_W ):TDUInterior(Owner,aSP,aFD,OnProgr,B_and_W)
{
  ((TForm*)Owner)->Caption = fd->NameGroup+" за "+fd->DateTime.FormatString("dd.mm.yy");
  NameCol[0] = fd->DateTime.FormatString("dd.mm.yy");
  for(int i=1; i<26; i++)
    NameCol[i] = i<10? AnsiString("0"+IntToStr(i)):AnsiString(i);
    //GRB ADD - подписываем на перерисовку
    ((TBaseMonitorForm*)Owner)->OnResize=TDUInterior::FormShow;
}
//---------------------------------------------------------------------------
__fastcall TMaketInterior::~TMaketInterior(void)
{
}
//---------------------------------------------------------------------------
void __fastcall TMaketInterior::Place(void)
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
        if (TDUInterior::GetContainedWidthStatusFromReg())
        TDUInterior::AutoSizeNameOnly (DrawTable);
        //end ADD

   }
   catch(Exception &e)
   {
		if(DrawTable)
		{
			SplitterForm->RemoveChild( DrawTable );
			delete DrawTable;
			DrawTable=NULL;
		}
		throw(Exception(Reconst_smes121_1));
   }
}
//---------------------------------------------------------------------------
void __fastcall TMaketInterior::dataInColumns(void)
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

void __fastcall TMaketInterior::clonesInColumns(void)
{
   TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
static int SizeFields[]={LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,
           LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,
           LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat,LenFloat};
	DrawTable->FixedCols=1;
	if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
	{
		DrawTable->RowsHeight=AnsiString("#")+psm->EditColorHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthName->Text+
			AnsiString("#")+psm->UpDownColorWidthDigit->Position+
			AnsiString("#")+AnsiString(psm->EditColorWidthDigit->Text.ToInt()-30);
  	}
	else
	{
		DrawTable->RowsHeight=AnsiString("#")+psm->EditBWHeight->Text;
		DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthName->Text+
			AnsiString("#")+psm->UpDownBWWidthDigit->Position+
			AnsiString("#")+AnsiString(psm->EditBWWidthDigit->Text.ToInt()-30);
	}
	if( !is_B_and_W )
	{
		DrawTable->TabStrings->Add(" m 0x0009 0x100F c 15 b t 2 #$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$");
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b-  t 7 A0x8000#A0x8025 & m 0x0001 0x900C c 36 b #b- c 5 &#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&");
	}
	else
	{
		DrawTable->TabStrings->Add(" m 0x0009 0x100F c 15 b t 2 #$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$");
		DrawTable->TabStrings->Add("$ m 0x0005 0x100F c 15 b-  t 7 A0x8000#A0x8025 & m 0x0001 0x900C c 5 b #b- &#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&#&");
	}
	DrawTable->StructStrings->Rebuild( Clones,SubColumns(),SizeFields );
   delete psm;
}
//---------------------------------------------------------------------------
//Обновление данных из базы
//NameAlert=-1 для обновления в любом случае
void __fastcall TMaketInterior::refreshData( int Table,TOraQuery *qwInter )
{
	if(Table==TABLE_BILL)
		selectData(qwInter);
}
//---------------------------------------------------------------------------
void __fastcall TMaketInterior::Invalidate( int Table )
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
void __fastcall TMaketInterior::formDescr( void )
{
  AnsiString DT;
  DateTimeToString(DT, "dd.mm.yyyy", fd->DateTime);

	//Заполняем необходимые поля описания формы
	Clones = 0;

  dmMain->qwIntMaket2->Params->Clear();
  dmMain->qwIntMaket2->SQL->Text="begin "+SchemeName+"monitor_pg.get_30817_name_p(:par1,to_date(:par2,'dd.mm.yyyy'),:par3); end;";

  dmMain->qwIntMaket2->ParamByName("par1")->AsInteger= fd->IdGroup;
  dmMain->qwIntMaket2->ParamByName("par2")->AsString= DT;
  dmMain->qwIntMaket2->ParamByName("par3")->ParamType=ptOutput;
  dmMain->qwIntMaket2->ParamByName("par3")->DataType=ftString;
  dmMain->qwIntMaket2->ParamByName("par3")->Table=true;
  dmMain->qwIntMaket2->Execute();

  NamesClones->Clear();
  int j=1;
  while(!dmMain->qwIntMaket2->Eof&&j<=dmMain->qwIntMaket2->ParamByName("par3")->Length){
    NamesClones->Add(dmMain->qwIntMaket2->ParamByName("par3")->ItemAsString[j]);
    dmMain->qwIntMaket2->Next();
    Clones++;
    j++;
  }
  dmMain->qwIntMaket2->Close();
}
//---------------------------------------------------------------------------
void __fastcall TMaketInterior::selectData( TOraQuery *qwIntMaket )
{
	int iClones;
  double col1[MAXTABLESIZE], col2[MAXTABLESIZE], col3[MAXTABLESIZE], col4[MAXTABLESIZE], col5[MAXTABLESIZE], col6[MAXTABLESIZE],
         col7[MAXTABLESIZE], col8[MAXTABLESIZE], col9[MAXTABLESIZE], col10[MAXTABLESIZE], col11[MAXTABLESIZE], col12[MAXTABLESIZE],
         col13[MAXTABLESIZE], col14[MAXTABLESIZE], col15[MAXTABLESIZE], col16[MAXTABLESIZE], col17[MAXTABLESIZE], col18[MAXTABLESIZE],
         col19[MAXTABLESIZE], col20[MAXTABLESIZE], col21[MAXTABLESIZE], col22[MAXTABLESIZE], col23[MAXTABLESIZE], col24[MAXTABLESIZE],
         col25[MAXTABLESIZE], col26[MAXTABLESIZE];
  short indicator[26][MAXTABLESIZE];
  ZeroMemory(indicator,26*MAXTABLESIZE);
	try{
    qwIntMaket->Params->Clear();
    qwIntMaket->SQL->Text=" begin  "+SchemeName+"monitor_pg.get_30817_data_p(:par1,to_date(:par2,'dd.mm.yyyy hh24:mi:ss'),:par3,:par4,:par5,:par6,:par7,:par8,:par9,:par10,:par11, \
      :par12,:par13,:par14,:par15,:par16,:par17,:par18,:par19,:par20,:par21,:par22,:par23,:par24,:par25,:par26,:par27,:par28);  end; ";
    for(int i=3;i<29;i++){
      qwIntMaket->ParamByName("par"+IntToStr(i))->Table=true;
      qwIntMaket->ParamByName("par"+IntToStr(i))->DataType=ftFloat;
      qwIntMaket->ParamByName("par"+IntToStr(i))->ParamType=ptOutput;
      qwIntMaket->ParamByName("par"+IntToStr(i))->Length=1;
           //  qwIntMaket->ParamByName("par"+IntToStr(i)))->ItemAsInteger[1]=0;
    }

    qwIntMaket->ParamByName("par1")->AsInteger=fd->IdGroup;
    qwIntMaket->ParamByName("par2")->AsString=fd->DateTime.FormatString(DateTimeFormat);

    qwIntMaket->Execute();
    int i=0;
    int j=1;
    while(!qwIntMaket->Eof&&i<MAXTABLESIZE){
      if(j<=qwIntMaket->ParamByName("par3")->Length&&!qwIntMaket->ParamByName("par3")->IsNull){
        indicator[0][i]=0;
        col1[i]= qwIntMaket->ParamByName("par3")->ItemAsFloat[j];}
      else indicator[0][i]=-1;
      if(j<=qwIntMaket->ParamByName("par4")->Length&&!qwIntMaket->ParamByName("par4")->IsNull){
        indicator[1][i]=0;
        col2[i]= qwIntMaket->ParamByName("par4")->ItemAsFloat[j];}
      else indicator[1][i]=-1;
      if(j<=qwIntMaket->ParamByName("par5")->Length&&!qwIntMaket->ParamByName("par5")->IsNull){
        indicator[2][i]=0;
        col3[i]= qwIntMaket->ParamByName("par5")->ItemAsFloat[j];}
      else indicator[2][i]=-1;
      if(j<=qwIntMaket->ParamByName("par6")->Length&&!qwIntMaket->ParamByName("par6")->IsNull){
        indicator[3][i]=0;
        col4[i]= qwIntMaket->ParamByName("par6")->ItemAsFloat[j];}
      else indicator[3][i]=-1;
      if(j<=qwIntMaket->ParamByName("par7")->Length&&!qwIntMaket->ParamByName("par7")->IsNull){
        indicator[4][i]=0;
        col5[i]= qwIntMaket->ParamByName("par7")->ItemAsFloat[j];}
      else indicator[4][i]=-1;
      if(j<=qwIntMaket->ParamByName("par8")->Length&&!qwIntMaket->ParamByName("par8")->IsNull){
        indicator[5][i]=0;
        col6[i]= qwIntMaket->ParamByName("par8")->ItemAsFloat[j];}
      else indicator[5][i]=-1;
      if(j<=qwIntMaket->ParamByName("par9")->Length&&!qwIntMaket->ParamByName("par9")->IsNull){
        indicator[6][i]=0;
        col7[i]= qwIntMaket->ParamByName("par9")->ItemAsFloat[j];}
      else indicator[6][i]=-1;
      if(j<=qwIntMaket->ParamByName("par10")->Length&&!qwIntMaket->ParamByName("par10")->IsNull){
        indicator[7][i]=0;
        col8[i]= qwIntMaket->ParamByName("par10")->ItemAsFloat[j];}
      else indicator[7][i]=-1;
      if(j<=qwIntMaket->ParamByName("par11")->Length&&!qwIntMaket->ParamByName("par11")->IsNull){
        indicator[8][i]=0;
        col9[i]= qwIntMaket->ParamByName("par11")->ItemAsFloat[j];}
      else indicator[8][i]=-1;
      if(j<=qwIntMaket->ParamByName("par12")->Length&&!qwIntMaket->ParamByName("par12")->IsNull){
        indicator[9][i]=0;
        col10[i]= qwIntMaket->ParamByName("par12")->ItemAsFloat[j];}
      else indicator[9][i]=-1;
      if(j<=qwIntMaket->ParamByName("par13")->Length&&!qwIntMaket->ParamByName("par13")->IsNull){
        indicator[10][i]=0;
        col11[i]= qwIntMaket->ParamByName("par13")->ItemAsFloat[j];}
      else indicator[10][i]=-1;
      if(j<=qwIntMaket->ParamByName("par14")->Length&&!qwIntMaket->ParamByName("par14")->IsNull){
        indicator[11][i]=0;
        col12[i]= qwIntMaket->ParamByName("par14")->ItemAsFloat[j];}
      else indicator[11][i]=-1;
      if(j<=qwIntMaket->ParamByName("par15")->Length&&!qwIntMaket->ParamByName("par15")->IsNull){
        indicator[12][i]=0;
        col13[i]= qwIntMaket->ParamByName("par15")->ItemAsFloat[j];}
      else indicator[12][i]=-1;
      if(j<=qwIntMaket->ParamByName("par16")->Length&&!qwIntMaket->ParamByName("par16")->IsNull){
        indicator[13][i]=0;
        col14[i]= qwIntMaket->ParamByName("par16")->ItemAsFloat[j];}
      else indicator[13][i]=-1;
      if(j<=qwIntMaket->ParamByName("par17")->Length&&!qwIntMaket->ParamByName("par17")->IsNull){
        indicator[14][i]=0;
        col15[i]= qwIntMaket->ParamByName("par17")->ItemAsFloat[j];}
      else indicator[14][i]=-1;
      if(j<=qwIntMaket->ParamByName("par18")->Length&&!qwIntMaket->ParamByName("par18")->IsNull){
        indicator[15][i]=0;
        col16[i]= qwIntMaket->ParamByName("par18")->ItemAsFloat[j];}
      else indicator[15][i]=-1;
      if(j<=qwIntMaket->ParamByName("par19")->Length&&!qwIntMaket->ParamByName("par19")->IsNull){
        indicator[16][i]=0;
        col17[i]= qwIntMaket->ParamByName("par19")->ItemAsFloat[j];}
      else indicator[16][i]=-1;
      if(j<=qwIntMaket->ParamByName("par20")->Length&&!qwIntMaket->ParamByName("par20")->IsNull){
        indicator[17][i]=0;
        col18[i]= qwIntMaket->ParamByName("par20")->ItemAsFloat[j];}
      else indicator[17][i]=-1;
      if(j<=qwIntMaket->ParamByName("par21")->Length&&!qwIntMaket->ParamByName("par21")->IsNull){
        indicator[18][i]=0;
        col19[i]= qwIntMaket->ParamByName("par21")->ItemAsFloat[j];}
      else indicator[18][i]=-1;
      if(j<=qwIntMaket->ParamByName("par22")->Length&&!qwIntMaket->ParamByName("par22")->IsNull){
        indicator[19][i]=0;
        col20[i]= qwIntMaket->ParamByName("par22")->ItemAsFloat[j];}
      else indicator[19][i]=-1;
      if(j<=qwIntMaket->ParamByName("par23")->Length&&!qwIntMaket->ParamByName("par23")->IsNull){
        indicator[20][i]=0;
        col21[i]= qwIntMaket->ParamByName("par23")->ItemAsFloat[j];}
      else indicator[20][i]=-1;
      if(j<=qwIntMaket->ParamByName("par24")->Length&&!qwIntMaket->ParamByName("par24")->IsNull){
        indicator[21][i]=0;
        col22[i]= qwIntMaket->ParamByName("par24")->ItemAsFloat[j];}
      else indicator[21][i]=-1;
      if(j<=qwIntMaket->ParamByName("par25")->Length&&!qwIntMaket->ParamByName("par25")->IsNull){
        indicator[22][i]=0;
        col23[i]= qwIntMaket->ParamByName("par25")->ItemAsFloat[j];}
      else indicator[22][i]=-1;
      if(j<=qwIntMaket->ParamByName("par26")->Length&&!qwIntMaket->ParamByName("par26")->IsNull){
        indicator[23][i]=0;
        col24[i]= qwIntMaket->ParamByName("par26")->ItemAsFloat[j];}
      else indicator[23][i]=-1;
      if(j<=qwIntMaket->ParamByName("par27")->Length&&!qwIntMaket->ParamByName("par27")->IsNull){
        indicator[24][i]=0;
        col25[i]= qwIntMaket->ParamByName("par27")->ItemAsFloat[j];}
      else indicator[24][i]=-1;
      if(j<=qwIntMaket->ParamByName("par28")->Length&&!qwIntMaket->ParamByName("par28")->IsNull){
        indicator[25][i]=0;
        col26[i]= qwIntMaket->ParamByName("par28")->ItemAsFloat[j];}
      else indicator[25][i]=-1;

      qwIntMaket->Next();
      j++;
      i++;
    }
    qwIntMaket->Close();
    Clones =i;
    for( iClones=0 ; iClones<Clones ;++iClones ){
      datOracle[iClones*SubColumns()+0].val = indicator[0][iClones]<0? -MAXFLOAT:col1[iClones];
      datOracle[iClones*SubColumns()+0].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+1].val = indicator[1][iClones]<0? -MAXFLOAT:col2[iClones];
      datOracle[iClones*SubColumns()+1].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+2].val = indicator[2][iClones]<0? -MAXFLOAT:col3[iClones];
      datOracle[iClones*SubColumns()+2].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+3].val = indicator[3][iClones]<0? -MAXFLOAT:col4[iClones];
      datOracle[iClones*SubColumns()+3].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+4].val = indicator[4][iClones]<0? -MAXFLOAT:col5[iClones];
      datOracle[iClones*SubColumns()+4].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+5].val = indicator[5][iClones]<0? -MAXFLOAT:col6[iClones];
      datOracle[iClones*SubColumns()+5].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+6].val = indicator[6][iClones]<0? -MAXFLOAT:col7[iClones];
      datOracle[iClones*SubColumns()+6].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+7].val = indicator[7][iClones]<0? -MAXFLOAT:col8[iClones];
      datOracle[iClones*SubColumns()+8].val = indicator[8][iClones]<0? -MAXFLOAT:col9[iClones];
      datOracle[iClones*SubColumns()+8].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+9].val = indicator[9][iClones]<0? -MAXFLOAT:col10[iClones];
      datOracle[iClones*SubColumns()+9].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+10].val = indicator[10][iClones]<0? -MAXFLOAT:col11[iClones];
      datOracle[iClones*SubColumns()+10].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+11].val = indicator[11][iClones]<0? -MAXFLOAT:col12[iClones];
      datOracle[iClones*SubColumns()+11].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+12].val = indicator[12][iClones]<0? -MAXFLOAT:col13[iClones];
      datOracle[iClones*SubColumns()+12].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+13].val = indicator[13][iClones]<0? -MAXFLOAT:col14[iClones];
      datOracle[iClones*SubColumns()+13].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+14].val = indicator[14][iClones]<0? -MAXFLOAT:col15[iClones];
      datOracle[iClones*SubColumns()+14].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+15].val = indicator[15][iClones]<0? -MAXFLOAT:col16[iClones];
      datOracle[iClones*SubColumns()+15].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+16].val = indicator[16][iClones]<0? -MAXFLOAT:col17[iClones];
      datOracle[iClones*SubColumns()+16].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+17].val = indicator[17][iClones]<0? -MAXFLOAT:col18[iClones];
      datOracle[iClones*SubColumns()+17].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+18].val = indicator[18][iClones]<0? -MAXFLOAT:col19[iClones];
      datOracle[iClones*SubColumns()+18].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+19].val = indicator[19][iClones]<0? -MAXFLOAT:col20[iClones];
      datOracle[iClones*SubColumns()+19].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+20].val = indicator[20][iClones]<0? -MAXFLOAT:col21[iClones];
      datOracle[iClones*SubColumns()+20].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+21].val = indicator[21][iClones]<0? -MAXFLOAT:col22[iClones];
      datOracle[iClones*SubColumns()+21].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+22].val = indicator[22][iClones]<0? -MAXFLOAT:col23[iClones];
      datOracle[iClones*SubColumns()+22].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+23].val = indicator[23][iClones]<0? -MAXFLOAT:col24[iClones];
      datOracle[iClones*SubColumns()+23].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+24].val = indicator[24][iClones]<0? -MAXFLOAT:col25[iClones];
      datOracle[iClones*SubColumns()+24].isvalid[0] = '\0';
      datOracle[iClones*SubColumns()+25].val = indicator[25][iClones]<0? -MAXFLOAT:col26[iClones];
      datOracle[iClones*SubColumns()+25].isvalid[0] = '\0';
      OnProgressBarStepBy(this);
    }
  }catch( Exception &e ){
  }
	OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
AnsiString __fastcall TMaketInterior::GetSubColumnsNames(int n)
{
  return NameCol[n];
}
//---------------------------------------------------------------------------

void __fastcall TMaketInterior::clickComposition(long ACol, long ARow )
{
}
//---------------------------------------------------------------------------
void __fastcall TMaketInterior::OnClickMenuItemMainGroup(TObject *Sender)
{
	clickComposition(0, 1 );
}
//---------------------------------------------------------------------------
void __fastcall TMaketInterior::PrintTable()
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

