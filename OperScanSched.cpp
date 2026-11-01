//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "OperScanSched.h"
#include "unDataMod.h"
#include "OperScanSchedEd.h"
#include "OperScanPointPar.h"
#include "SupperMain.h"
#include "selectpoint.h"
#include "Reconst.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBGridEh"
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TfmOperScanSched *fmOperScanSched;

static char CurrScanSchId[20];
int ColumnToSort = 0;

//---------------------------------------------------------------------------
__fastcall TfmOperScanSched::TfmOperScanSched(TComponent* Owner,int Mid,AnsiString Name,int CMid,AnsiString CName,int IfPoint)
  : TForm(Owner)
{
  wasSwapColumn = false;
  grChannels->OnDrawColumnCell = grChannelsDrawColumnCell;
  if(Mid>0)
  {
   if(IfPoint==0)
   {
      ePoint->Tag = Mid;
      ePoint->Text = Name;
   }
   if(IfPoint==1)
   {
     ePoint->Tag = Mid;
     ePoint->Text = Name;
     eFilter->Tag = CMid;
     eFilter->Text = CName;
   }
   }else{
    if(IfPoint==2)
    {
     eFilter->Tag = CMid;
     eFilter->Text = CName;
    }
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::btStartClick(TObject *Sender)
{
  TDataSet *pDS = grChannels->DataSource->DataSet;
  if (pDS->RecordCount){
    TfmOperScanSchedEd* f = new TfmOperScanSchedEd(this);
    for (int i=0; i < grChannels->SelectedRows->Count; i++){
      pDS->GotoBookmark((void *)grChannels->SelectedRows->Items[i].c_str());
      f->edPeriod->Text = pDS->FieldByName("cycle_tout")->AsString;
      f->MEdEnd->Text = TDateTime(Now()+ 1.0/24.0).FormatString("hh:nn");
      if(f->ShowModal()==mrOk)
        ScanActivate(f->MEdEnd->Text,f->edPeriod->Text);
      break;
    }
    delete  f;
  }  
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::FormCreate(TObject *Sender)
{
   orderStr  = "vname ";
   SchChRefresh();
}
//----------------------------------------------------------------------------
void __fastcall TfmOperScanSched::SchChRefresh()
{
  //Формируем массив каналов для текущей роли

  oqChannels->Params->Clear();
  oqChannels->SQL->Text="begin "+SchemeName+"operscan_pg.get_channels_for_role(:par1,:par2,:par3,:par4,:par5); end;";
  oqChannels->ParamByName("par1")->AsString = CurrScanSchId;
  oqChannels->ParamByName("par2")->ParamType = ptOutput;
  oqChannels->ParamByName("par2")->DataType = ftCursor;
  oqChannels->ParamByName("par3")->AsInteger = eFilter->Tag;
  oqChannels->ParamByName("par4")->AsString = orderStr;
  oqChannels->ParamByName("par5")->AsInteger = ePoint->Tag;

  grChannels->Columns->Items[0]->FieldName="is_dead";
  grChannels->Columns->Items[0]->Title->Caption = "";
  grChannels->Columns->Items[1]->FieldName="blocking";
  grChannels->Columns->Items[1]->Title->Caption = "";
  grChannels->Columns->Items[2]->FieldName="vname";
  grChannels->Columns->Items[3]->FieldName="dstart";
  grChannels->Columns->Items[4]->FieldName="dend";
  grChannels->Columns->Items[5]->FieldName="cycle_tout";
  grChannels->Columns->Items[6]->FieldName="vuser";
  grChannels->Columns->Items[7]->FieldName="com_id";
  grChannels->Columns->Items[8]->FieldName="prname";
  //GRB ADD 27.02.2020 - локализация имён колонок на лету
  AnsiString Language;
  TRegistry *Reg = new TRegistry(KEY_READ);
  try{
        Reg->RootKey =HKEY_LOCAL_MACHINE;
        Reg->Access=KEY_READ;
        Reg->OpenKey("SOFTWARE\\INTEP\\ASKUE", False);
        Language = Reg->ReadString("Language");
        if(!Language.Length()){
                char c[256];
                GetLocaleInfo(GetSystemDefaultLCID(), LOCALE_SABBREVLANGNAME, c, sizeof(c));
                Language=c;
        }
        }__finally{
                delete Reg;
  }


  for (int i=2; i < 9; i++) {
        switch (i){
        case 2:{
        grChannels->Columns->Items[i]->Title->Caption = "Канал";
        break;
        }
        case 3:{
        if (Language == "UKR") grChannels->Columns->Items[i]->Title->Caption = "Початок";
        else
        grChannels->Columns->Items[i]->Title->Caption = "Начало";
        break;
        }
        case 4:{
        if (Language == "UKR") grChannels->Columns->Items[i]->Title->Caption = "Кінець";
        else
        grChannels->Columns->Items[i]->Title->Caption = "Конец";
        break;
        }
        case 5:{
        if (Language == "UKR") grChannels->Columns->Items[i]->Title->Caption = "Період";
        else
        grChannels->Columns->Items[i]->Title->Caption = "Период";
        break;
        }
        case 6:{
        if (Language == "UKR") grChannels->Columns->Items[i]->Title->Caption = "Ініціатор";
        else
        grChannels->Columns->Items[i]->Title->Caption = "Инициатор";
        break;
        }
        case 7:{
        grChannels->Columns->Items[i]->Title->Caption = "Порт";
        break;
        }
        case 8:{
        grChannels->Columns->Items[i]->Title->Caption = "Протокол";
        break;
        }
        }
  }
  oqChannels->DisableControls();
  oqChannels->Execute();

  // заполняем таблицу
  while(!oqChannels->Eof){

      strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].Name,oqChannels->FieldByName("vname")->AsString.c_str());
      strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].Start,oqChannels->FieldByName("dstart")->AsString.c_str());
      strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].End,oqChannels->FieldByName("dend")->AsString.c_str());
      strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].CycleTout,oqChannels->FieldByName("cycle_tout")->AsString.c_str());
      strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].User,oqChannels->FieldByName("vuser")->AsString.c_str());
      strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].comid,oqChannels->FieldByName("com_id")->AsString.c_str());
      strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].is_dead,oqChannels->FieldByName("is_dead")->AsString.c_str());

     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].Id,oqChannels->FieldByName("cid")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].Ready,oqChannels->FieldByName("nready")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].Kind,oqChannels->FieldByName("nkind")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].Bloking,oqChannels->FieldByName("blocking")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].Parent,oqChannels->FieldByName("nparent")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].NotReadCurr,oqChannels->FieldByName("nnotreadcurr")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].Retries,oqChannels->FieldByName("retries")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].RetriesTout,oqChannels->FieldByName("retries_tout")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].isbilldata,oqChannels->FieldByName("nbilldata")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].isbilldatadepth,oqChannels->FieldByName("nbilldatadepth")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].iscurrdata,oqChannels->FieldByName("ncurrdata")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].iscurrdatadepth,oqChannels->FieldByName("ncurrdatadepth")->AsString.c_str());
     strcpy(TableChannList[oqChannels->FieldByName("rn")->AsInteger].prname,oqChannels->FieldByName("prname")->AsString.c_str());

     oqChannels->Next();
  }
  oqChannels->First();
  oqChannels->EnableControls();
  grChannels->SelectedRows->CurrentRowSelected = true;
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::ScanActivate(AnsiString PPDT,AnsiString PPInt )
{
  try{
   TDataSet *pDS = grChannels->DataSource->DataSet;
   if (pDS->RecordCount){
     for (int i=0; i < grChannels->SelectedRows->Count; i++){
        pDS->GotoBookmark((void *)grChannels->SelectedRows->Items[i].c_str());
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text=AnsiString("begin "+SchemeName+"operscan_pg.active_p(:par1,to_date('")+PPDT+
                        AnsiString("','hh24:mi'),")+PPInt+AnsiString("); end;");
        dmMain->oqCursor->ParamByName("par1")->AsString = pDS->FieldByName("cid")->AsString;
        dmMain->oqCursor->Execute();
     }
     dmMain->orases->Commit();
     SchChRefresh();
   }
  }catch(Exception &e){
    dmMain->orases->Rollback();
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::btStopClick(TObject *Sender)
{
   ScanDeactivate();
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::ScanDeactivate()
{
   try{
    TDataSet *pDS = grChannels->DataSource->DataSet;
    if (pDS->RecordCount){
      for (int i=0; i < grChannels->SelectedRows->Count; i++){
         pDS->GotoBookmark((void *)grChannels->SelectedRows->Items[i].c_str());
         if (pDS->FieldByName("nkind")->AsInteger==100){
           dmMain->oqCursor->Params->Clear();
           dmMain->oqCursor->SQL->Text = "begin "+SchemeName+"operscan_pg.deactive_p(:par1); end;";
           dmMain->oqCursor->ParamByName("par1")->AsString= pDS->FieldByName("cid")->AsString;
         }
         dmMain->oqCursor->Execute();
      }
      dmMain->orases->Commit();
      SchChRefresh();
    }
  }catch(Exception &e){
    dmMain ->orases->Rollback();
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
//                 Формирование таблицы каналов для данной схемы
//void __fastcall TfmOperScanSched::OperScanSchedShow(void)
void __fastcall TfmOperScanSched::OperScanSchedShow(int Mid,AnsiString Name,int CMid,AnsiString CName,int IfPoint)
{
   dmMain->oqCursor->Params->Clear();
   dmMain->oqCursor->SQL->Text= "begin "+SchemeName+"operscan_pg.get_channels_for_shema(:par1,:par2); end;";
   dmMain->oqCursor->ParamByName("par1")->AsInteger =UsCon.Role_Id;
   dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
   dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
   dmMain->oqCursor->Execute();
   strcpy(CurrScanSchId,dmMain->oqCursor->FieldByName("CurrScanSchId")->AsString.c_str());

  if(!dmMain->oqCursor->Eof){
    AnsiString prStr = CurrScanSchId;
    //Схема назначена
    if( prStr=="")
      Application->MessageBox(Reconst_smes47_1.c_str(),Application->Title.c_str(),MB_OK | MB_ICONWARNING);
    else{

      fmOperScanSched  = new TfmOperScanSched(SupperMainForm,Mid,Name,CMid,CName,IfPoint);
      fmOperScanSched->ShowModal();
      delete  fmOperScanSched;
    }
  }else
		Application->MessageBox(Reconst_smes47_2.c_str(),Application->Title.c_str(),MB_OK | MB_ICONERROR);
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::btCloseClick(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::btPointClick(TObject *Sender)
{
  //Производим действия по заданию оперативного опроса
  TDataSet *pDS = grChannels->DataSource->DataSet;
  if (grChannels->SelectedRows->Count>0 && pDS->RecordCount){
    pDS->GotoBookmark((void *)grChannels->SelectedRows->Items[0].c_str());
    TfmOperScanPointPar* f= new TfmOperScanPointPar(this,pDS->FieldByName("rn")->AsInteger);
    f->ShowModal();
    delete f;
  }else
    Application->MessageBox(Reconst_smes47_3.c_str(),Application->Title.c_str(),MB_OK | MB_ICONWARNING);
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::btRefreshClick(TObject *Sender)
{
  SchChRefresh();
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::spbFilterClick(TObject *Sender)
{
  GROUPDATAFORM gdf;
  gdf.gid = eFilter->Tag;
  gdf.type = 10; // было раньше 2 для каналов с типом протокола "Файл"

  TfmSelectPoint*sp = new TfmSelectPoint(this, &gdf);
  if(sp->ShowModal()==mrOk){
     eFilter->Tag = gdf.gid;
     eFilter->Text = gdf.Name;
     SchChRefresh();
  }
  delete sp;
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::spbDelFilterClick(TObject *Sender)
{
  eFilter->Tag = 1;
  eFilter->Text = "Все";
  SchChRefresh();
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::grChannelsDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
  if (!Column->Field)
    return;
  switch (DataCol)
  {
    case 0:
      grChannels->Canvas->FillRect(Rect);
      ImageList1->Draw(grChannels->Canvas, Rect.Left + 2, Rect.Top + 1,
                       Column->Field->AsInteger,
                       true);
      break;
    case 1:
      grChannels->Canvas->FillRect(Rect);
      ImageList1->Draw(grChannels->Canvas, Rect.Left + 2, Rect.Top + 1,
                       Column->Field->AsInteger+2,
                       true);
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::grChannelsTitleClick(TColumnEh *Column)
{
  if (wasSwapColumn){
        wasSwapColumn = false;
        return;
  }
  TColumnEh *tCol = dynamic_cast<TColumnEh *>(Column);
  if (!tCol)
    return;
  switch (tCol->Index)
  { case 0:
        orderStr  = "is_dead ";
      break;
    case 1:
        orderStr  = "blocking ";
      break;
    case 2:
        orderStr  = "vname ";
      break;
    case 3:
        orderStr  = "dstart ";
      break;
    case 4:
        orderStr  = "dend ";
      break;
    case 5:
        orderStr  = "cycle_tout ";
      break;
    case 6:
        orderStr  = "vuser ";
      break;
    case 7:
        orderStr  = "com_id ";
      break;
    case 8:
        orderStr  = "prname ";
      break;
    default:
        return;
  }

  for (int i = 0; i < grChannels->Columns->Count; ++i)
  { if (i == tCol->Index)
      continue;
    ((TColumnEh *)grChannels->Columns->Items[i])->Title->SortMarker  = smNoneEh;
  }

  if (tCol->Title->SortMarker == smUpEh)
  {
    tCol->Title->SortMarker = smDownEh;
    orderStr  += "desc ";
  }
  else
    tCol->Title->SortMarker = smUpEh;

  SchChRefresh();
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanSched::eFilterKeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
  if (Key == VK_SPACE	|| Key == VK_RETURN){
    spbFilterClick(this);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmOperScanSched::sbPointClick(TObject *Sender)
{
   GROUPDATAFORM gdf;
  gdf.gid = ePoint->Tag;
  gdf.type = 1; 

  TfmSelectPoint*sp = new TfmSelectPoint(this, &gdf);
  if(sp->ShowModal()==mrOk){
     ePoint->Tag = gdf.gid;
     ePoint->Text = gdf.Name;
     SchChRefresh();
  }
  delete sp;
}
//---------------------------------------------------------------------------

void __fastcall TfmOperScanSched::sbDelPointClick(TObject *Sender)
{
  ePoint->Tag = 1000;
  ePoint->Text = "Все";
  SchChRefresh();
}
//---------------------------------------------------------------------------

void __fastcall TfmOperScanSched::grChannelsColumnMoved(TObject *Sender,
      int FromIndex, int ToIndex)
{
        if ((FromIndex==0) ||(FromIndex==1)){
        grChannels->Columns->Items[ToIndex]->Index = FromIndex;
        return;
        }
        if ((ToIndex==0) ||(ToIndex==1)){
        grChannels->Columns->Items[ToIndex]->Index = FromIndex;
        return;
        }
        wasSwapColumn = true;
        /*if (ToIndex>FromIndex){
        AnsiString swapFromCaption = grChannels->Columns->Items[ToIndex]->Title->Caption;
        grChannels->Columns->Items[ToIndex]->Title->Caption = grChannels->Columns->Items[FromIndex]->Title->Caption;
        grChannels->Columns->Items[FromIndex]->Title->Caption = swapFromCaption;
        }else{
        AnsiString swapFromCaption = grChannels->Columns->Items[FromIndex]->Title->Caption;
        grChannels->Columns->Items[FromIndex]->Title->Caption = grChannels->Columns->Items[ToIndex]->Title->Caption;
        grChannels->Columns->Items[ToIndex]->Title->Caption = swapFromCaption;
        } */
}
//---------------------------------------------------------------------------

void __fastcall TfmOperScanSched::SaveTableToFile(TObject *Sender)
{
    Screen->Cursor = crHourGlass;
    grChannels->DataSource->DataSet->DisableControls();
    TBookmark bm = grChannels->DataSource->DataSet->GetBookmark();
    grChannels->DataSource->DataSet->First();
    TStringList* mem = NULL;
    try{
    mem = new TStringList;
    mem->Clear();
    // добавляем информацию для имён колонок
    AnsiString sline = "";
    for(int col = 0; col < grChannels->FieldCount; ++col)
    {
        sline += grChannels->Fields[col]->DisplayLabel + (char)9;
    }
    mem->Add(sline);
    // получаем данные из mem
    for(int row = 0; row < grChannels->DataSource->DataSet->RecordCount; ++row)
    {
        sline = "";
        for(int col = 0; col < grChannels->FieldCount; ++col) {
            sline += grChannels->Fields[col]->AsString + (char)9;
        }
        mem->Add(sline);
        grChannels->DataSource->DataSet->Next();
    }

    // копируем данные в clipboard
    if (SaveDialog1->Execute())
        mem->SaveToFile(SaveDialog1->FileName);
    delete mem;
    mem = NULL;
    // ... тут закрываешь Excel
    grChannels->DataSource->DataSet->GotoBookmark(bm);
    grChannels->DataSource->DataSet->FreeBookmark(bm);
    grChannels->DataSource->DataSet->EnableControls();
    Screen->Cursor = crDefault;
    }catch (Exception &ex){
    grChannels->DataSource->DataSet->GotoBookmark(bm);
    grChannels->DataSource->DataSet->FreeBookmark(bm);
    grChannels->DataSource->DataSet->EnableControls();
    Screen->Cursor = crDefault;
    if (mem!=NULL){
        delete mem;
        mem = NULL;
    }
    }
}
//---------------------------------------------------------------------------

