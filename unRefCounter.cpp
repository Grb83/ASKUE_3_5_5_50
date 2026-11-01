//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "unRefCounter.h"
#include "EditCounter.h"
#include "Main.h"
#include "ReConst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "DBGridEh"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "PrnDbgeh"
#pragma resource "*.dfm"
TfmRefCounter *fmRefCounter;
//---------------------------------------------------------------------------
__fastcall TfmRefCounter::TfmRefCounter(TComponent* Owner)
  : TForm(Owner)
{
  ReplaceRyda(this,"RYDA.",SchemeName);
  vRefresh(this);
  grMain->Col = 1;
}
//---------------------------------------------------------------------------

void __fastcall TfmRefCounter::vSave(TObject *Sender)
{
   if(oqMain->State==dsEdit)
      oqMain->Post();
   try{
    oqMain->ApplyUpdates();
    oqMain->Session->Commit();
    oqMain->CommitUpdates();
    btSave->Enabled=false;
   }catch (Exception &exception){
    oqMain->Session->Rollback();
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------

void TfmRefCounter::vRead()
{
  oqMain->Close();
  oqMain->Execute();
}
//-------------------------------------------------------------------------------

void __fastcall TfmRefCounter::vRefresh(TObject *Sender)
{
  vRead();
  if(btSave->Enabled){
    btSave->Enabled=false;
  }
}
//-------------------------------------------------------------------------------

void __fastcall TfmRefCounter::btSaveClick(TObject *Sender)
{
  vSave(this);
  vRefresh(this); //обновляем таблицу
}
//---------------------------------------------------------------------------

void __fastcall TfmRefCounter::tbExportClick(TObject *Sender)
{
  SaveTable(this,grMain, this->Caption);
}
//---------------------------------------------------------------------------

void __fastcall TfmRefCounter::tbPrintClick(TObject *Sender)
{
  PrintMessageGrid->PageHeader->CenterText->Clear();
  PrintMessageGrid->PageHeader->RightText->Clear();
  PrintMessageGrid->PageHeader->CenterText->Add(Caption);
  PrintMessageGrid->PageHeader->CenterText->Add("  ");
  PrintMessageGrid->PageHeader->RightText->Text=Now().FormatString("dd.mm.yyyy hh:nn:ss");
  PrintMessageGrid->Preview();
}
//---------------------------------------------------------------------------

void __fastcall TfmRefCounter::grMainTitleBtnClick(TObject *Sender, int ACol,
      TColumnEh *Column)
{
  bool is_down = Column->Title->SortMarker != smUpEh;
  if(is_down)
    Column->Title->SortMarker = smUpEh;
  else
    Column->Title->SortMarker = smDownEh;

  for(int i=0; i < grMain->Columns->Count; i++)
  {
    if(i != ACol)
      grMain->Columns->Items[i]->Title->SortMarker = smNoneEh;
  }
  vRead();
}
//---------------------------------------------------------------------------

void __fastcall TfmRefCounter::btOkClick(TObject *Sender)
{
 if (btSave->Enabled)
   vSave(this);
 if(!btSave->Enabled)
   ModalResult=mrOk;
}
//---------------------------------------------------------------------------

void __fastcall TfmRefCounter::oqMainAfterEdit(TDataSet *DataSet)
{
  btSave->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TfmRefCounter::SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption)
{
  AnsiString s,fname;
  TStringList *StringList;
  TBookmark SavePlace;
  AnsiString  tab = char(9);
  TSaveDialog *sd=new TSaveDialog(Owner);
  TDataSet  *ds = gr->DataSource->DataSet;
  if (!ds || !ds->Active){
    Application->MessageBox(Reconst_smes6_2.c_str(),Application->Title.c_str(),MB_OK | MB_ICONSTOP);
    return;
  }
  sd->Title       = "Открыть";
  sd->DefaultExt  = "txt";
  sd->FileName    = RepCaption;
  //sd->Filter      = "*.txt";
  //21.07.2022 GRB CHANGE
  sd->Filter = "Текстовые документы (*.txt)|*.txt|Книга Microsoft Excel (*.xls)|*.xls|Все файлы (*.*)|*.*";
  sd->Options << ofOverwritePrompt;
  if(sd->Execute())
    fname=sd->FileName;
  else
    fname="";
  delete sd;
  if(fname.IsEmpty())
    return;

  try{
    StringList  = new TStringList;
    //Завголовок
    if(!RepCaption.IsEmpty())
      StringList->Add(RepCaption);
    s="";
    for (int i = 0; i < gr->Columns->Count; i++){
      if(gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
        if(!s.IsEmpty())
          s += tab;
        s+= gr->Columns->Items[i]->Title->Caption;
      }
    }
    StringList->Add(s);
    //Данные
    SavePlace = ds->GetBookmark();
    ds->DisableControls();
    ds->First();
    int cn  = 0;
    while (!ds->Eof){
      s="";
      for (int i = 0; i < gr->Columns->Count; i++){
        if (gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
          if(!s.IsEmpty())
            s += tab;
          if (gr->Columns->Items[i]->Field->DataType == ftDateTime)
            s += gr->Columns->Items[i]->Field->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
          else
            s += gr->Columns->Items[i]->Field->AsString;
        }
      }
      StringList->Add(s);
      cn++;
      ds->Next();
    }
    ds->GotoBookmark(SavePlace);
    ds->FreeBookmark(SavePlace);
    ds->EnableControls();
    StringList->SaveToFile(fname);
    delete  StringList;
  }
  catch (Exception &e){
    delete  StringList;
    throw;
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmRefCounter::tbAddClick(TObject *Sender)
{
  oqMain->Insert();
}
//---------------------------------------------------------------------------

void __fastcall TfmRefCounter::tbDelClick(TObject *Sender)
{
  oqMain->Delete();
  btSave->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TfmRefCounter::dsMainDataChange(TObject *Sender, TField *Field)
{
  if(Field == oqMain->FieldByName("DIGITS"))
    TFormCounter::ProvMask(Field->AsString);
  btSave->Enabled = true;
}
//---------------------------------------------------------------------------

