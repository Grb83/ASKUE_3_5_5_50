//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "BlockMessage.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "DBGridEh"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "PrnDbgeh"
#pragma link "DBCtrlsEh"
#pragma resource "*.dfm"
TfmBlockMess *fmBlockMess;
//---------------------------------------------------------------------------
__fastcall TfmBlockMess::TfmBlockMess(TComponent* Owner)
  : TForm(Owner)
{
  oqType->Open();
  oqType->First();
  while (!oqType->Eof){
    cbType->Items->AddObject(oqType->FieldByName("VNAME")->AsString,(TObject*)oqType->FieldByName("NTYPE")->AsInteger);
    oqType->Next();
  }
  cbType->ItemIndex = 0;
  sort_mess = 1;
  sort_bits = 1;

  grMessage->Columns->Items[4]->PickList->Clear();
  grMessage->Columns->Items[4]->KeyList->Clear();
  grStatusBits->Columns->Items[4]->PickList->Clear();
  grStatusBits->Columns->Items[4]->KeyList->Clear();
  grStatusBits->Columns->Items[6]->PickList->Clear();
  grStatusBits->Columns->Items[6]->KeyList->Clear();

  oqValid->Execute();
  while(!oqValid->Eof)
  {
    grMessage->Columns->Items[4]->KeyList->Add(IntToStr(oqValid->FieldByName("nvalid")->AsInteger));
    grMessage->Columns->Items[4]->PickList->Add(oqValid->FieldByName("VNAME")->AsString);
    grStatusBits->Columns->Items[4]->KeyList->Add(IntToStr(oqValid->FieldByName("nvalid")->AsInteger));
    grStatusBits->Columns->Items[4]->PickList->Add(oqValid->FieldByName("VNAME")->AsString);
    oqValid->Next();
  }

  oqNQM->Execute();
  while (!oqNQM->Eof)
  {
    grStatusBits->Columns->Items[6]->KeyList->Add(IntToStr(oqNQM->FieldByName("nNQM")->AsInteger));
    grStatusBits->Columns->Items[6]->PickList->Add(oqNQM->FieldByName("NNAME")->AsString);
    oqNQM->Next();
  }
  vRefresh(this);
}
//---------------------------------------------------------------------------
bool __fastcall TfmBlockMess::fmBlockMessShow(TComponent* Owner)
{
  TfmBlockMess *f=new TfmBlockMess(Owner);
  int res = f->ShowModal();
  delete f;
  return (res == mrOk);
}
//---------------------------------------------------------------------------
void TfmBlockMess::vRead(long MeterType,long Sort_mess, long Sort_bits)
{

  oqMessage->Close();      // чтение сообщений
  oqMessage->ParamByName("METERTYPE")->AsInteger=MeterType;
  oqMessage->ParamByName("NSORT")->AsInteger=Sort_mess;
  oqMessage->Execute();

  oqBits->Close();     // чтение битов состояний
  oqBits->ParamByName("METERTYPE")->AsInteger=MeterType;
  oqBits->ParamByName("NSORT")->AsInteger=Sort_bits;
  oqBits->Execute();
}
//-------------------------------------------------------------------------------
void __fastcall TfmBlockMess::vRefresh(TObject *Sender)
{

  vRead((int)cbType->Items->Objects[cbType->ItemIndex],sort_mess,sort_bits);
  if(btSave->Enabled){
    btSave->Enabled=false;
  }
}
//-------------------------------------------------------------------------------
void __fastcall TfmBlockMess::grMessageDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
  if(DataCol == 3){
    grMessage->Canvas->FillRect(Rect);
    if(oqMessage->RecordCount && Column->Field->AsInteger)
       ifMenu->Draw(grMessage->Canvas, Rect.Left+Rect.Width()/2-4, Rect.Top+1,40,true);
  }
 }
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::grMessageDblClick(TObject *Sender)
{
/* TRect Rect;
  if(oqMessage->RecordCount)

  {
   grMessage->Columns->BeginUpdate();*/
  if(grMessage->SelectedField->FieldNo==4)
    {
   oqMessage->Edit();
   oqMessage->FieldByName("NLOCK")->AsInteger=(int)!oqMessage->FieldByName("NLOCK")->AsInteger;
   oqMessage->Post();
    }
/* if(grMessage->SelectedField->FieldNo==5)
   {

   oqMessage->Edit();
#define Sender ((TDBGridEh*)Sender)
   Rect=Sender->CellRect(Sender->Col,Sender->Row);
    grMessage->Canvas->FillRect(Rect);
    if(!oqMessage->FieldByName("NVALID")->IsNull&&StrToInt(oqMessage->FieldByName("NVALID")->AsString)<2)
      oqMessage->FieldByName("NVALID")->AsString=IntToStr(StrToInt(oqMessage->FieldByName("NVALID")->AsString)+1);
    else  oqMessage->FieldByName("NVALID")->AsString=IntToStr(0);
    oqMessage->Post();
    TGridDrawState prFlags;
    prFlags.Clear();
    prFlags << gdSelected;
    grMessageDrawColumnCell(this,Rect, 4, grMessage->Columns->Items[4],prFlags );

#undef Sender
   }
    grMessage->Columns->EndUpdate();

  }*/
  btSave->Enabled = true;
}
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::btSaveClick(TObject *Sender)
{
 if(PageControl1->ActivePage==TabSheet1)
 {
  try{
    oqMessage->ApplyUpdates();
    oqMessage->Session->Commit();
    btSave->Enabled = false;
  }
  catch(...){
    throw;
  }
  oqMessage->CommitUpdates();
  }
  if(PageControl1->ActivePage==TabSheet2)
 {
  try{
    oqBits->ApplyUpdates();
    oqBits->Session->Commit();
    btSave->Enabled = false;
  }
  catch(...){
    throw;
  }
  oqBits->CommitUpdates();
  }

}
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::tbExportClick(TObject *Sender)
{
  TdmMain::SaveTable(this,grMessage,Reconst_smes3_1);
}
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::tbPrintClick(TObject *Sender)
{
  PrintMessageGrid->PageHeader->CenterText->Clear();
  PrintMessageGrid->PageHeader->RightText->Clear();
  PrintMessageGrid->PageHeader->CenterText->Add(Caption);
  PrintMessageGrid->PageHeader->CenterText->Add("  ");
  PrintMessageGrid->PageHeader->RightText->Text=Now().FormatString("dd.mm.yyyy hh:nn:ss");
  PrintMessageGrid->Preview();  
}
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::grMessageTitleBtnClick(TObject *Sender,
      int ACol, TColumnEh *Column)
{
  bool is_down = Column->Title->SortMarker != smUpEh;
  if(is_down)
    Column->Title->SortMarker = smUpEh;
  else
    Column->Title->SortMarker = smDownEh;

  for(int i=0; i < grMessage->Columns->Count; i++)
  {
    if(i != ACol)
      grMessage->Columns->Items[i]->Title->SortMarker = smNoneEh;
  }
  if(Column->Title->SortMarker == smUpEh)
    sort_mess = ACol + 1;
  else
    sort_mess = (ACol + 1)*(-1);
  vRead((int)cbType->Items->Objects[cbType->ItemIndex],sort_mess,sort_bits);
}
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::grMessageKeyPress(TObject *Sender, char &Key)
{
  if(Key==32)// нажатие Пробел
    grMessageDblClick(this);

}
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::cbTypeChange(TObject *Sender)
{
  btSaveClick(Sender);
  vRefresh(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::grStatusBitsDblClick(TObject *Sender)
{
  if(oqBits->RecordCount)
  {
    AnsiString currColName = grStatusBits->Columns->Items[grStatusBits->Col-1]->FieldName;
    TLocateOptions prFlags;
    prFlags.Clear();
    prFlags << loCaseInsensitive;
    if (currColName=="VEVENTTEXT1" && !oqBits->FieldByName("NEVENT0")->AsString.IsEmpty())
    {
        if (oqMessage->Locate("NEVENT",oqBits->FieldByName("NEVENT0")->AsString,prFlags))
          PageControl1->ActivePage = TabSheet1;
    }
    else if (currColName=="VEVENTTEXT2" && !oqBits->FieldByName("NEVENT1")->AsString.IsEmpty())
        if (oqMessage->Locate("NEVENT",oqBits->FieldByName("NEVENT1")->AsString,prFlags))
          PageControl1->ActivePage = TabSheet1;
    else return;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::grStatusBitsTitleBtnClick(TObject *Sender,
      int ACol, TColumnEh *Column)
{
  bool is_down = Column->Title->SortMarker != smUpEh;
  if(is_down)
    Column->Title->SortMarker = smUpEh;
  else
    Column->Title->SortMarker = smDownEh;

  for(int i=0; i < grStatusBits->Columns->Count; i++)
  {
    if(i != ACol)
      grStatusBits->Columns->Items[i]->Title->SortMarker = smNoneEh;
  }
  if(Column->Title->SortMarker == smUpEh)
    sort_bits = ACol + 1;
  else
    sort_bits = (ACol + 1)*(-1);
  vRead((int)cbType->Items->Objects[cbType->ItemIndex],sort_mess,sort_bits);
}
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::grMessageColumns4EditButtonClick(
      TObject *Sender, bool &Handled)
{
  btSave->Enabled = true;
}
//---------------------------------------------------------------------------
void __fastcall TfmBlockMess::oqMessageAfterEdit(TDataSet *DataSet)
{
  btSave->Enabled = true;
}
//---------------------------------------------------------------------------

