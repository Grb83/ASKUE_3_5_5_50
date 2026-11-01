//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "unRTRNP.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "DBGridEh"
//#pragma link "GridsEh"
#pragma resource "*.dfm"
TfmRTRNP *fmRTRNP;
//---------------------------------------------------------------------------
__fastcall TfmRTRNP::TfmRTRNP(TComponent* Owner)
  : TForm(Owner)
{
  order_by = 0;
  order_by_det = 0;
  grActive=grRouters;
  accOFF=(dmMain->GetTaskRights(UsCon.Role_Id, 109) == TASK_RIGHTS_WRITE);
  SelectConf();
}
//---------------------------------------------------------------------------
bool __fastcall  TfmRTRNP::fmRTRNPShow(TComponent* Owner)
{
  TfmRTRNP *f=new TfmRTRNP(Owner);
  int res = f->ShowModal();
  delete f;
  return (res == mrOk);
}
//---------------------------------------------------------------------------


void __fastcall TfmRTRNP::btnRefreshClick(TObject *Sender)
{
  SelectConf();
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNP::m_btnSaveClick(TObject *Sender)
{
  TdmMain::SaveTable(this,grActive,Caption);
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNP::oqMainAfterScroll(TDataSet *DataSet)
{
  SelectDet();
  dbtCID->Text = "";
  if (DataSet->Active && !DataSet->FieldByName("CID")->IsNull)
    dbtCID->Text = DataSet->FieldByName("CID")->Value;
}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNP::grRoutersEnter(TObject *Sender)
{
  grActive=(TDBGridEh *)Sender;
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNP::SelectDet(void)
{
  int filter = 0;
  if (btnErrorFilter->Down) filter += 0x01;
  if (btnWarningFilter->Down) filter += 0x02;
  if (btnOkFilter->Down) filter += 0x04;
  oqSlave->Close();
  if (oqMain->RecordCount > 0)
  {
    oqSlave->ParamByName("cid")->AsInteger = oqMain->FieldByName("cid")->AsInteger;
    oqSlave->ParamByName("filter")->AsInteger = filter;
    oqSlave->ParamByName("sort")->AsInteger = order_by_det;
    oqSlave->Execute();
    SetAccMenuOFF();
  }
}

//---------------------------------------------------------------------------
void __fastcall TfmRTRNP::SelectConf(void)
{
  oqMain->Close();
  oqMain->ParamByName("sort")->AsInteger = order_by;
  oqMain->Execute();
}

//---------------------------------------------------------------------------
void __fastcall TfmRTRNP::grMetersDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
//    8 warning
//    9 good
//    10 bad
  int IconID = 10;
  if (DataCol == 0)
  {
    grMeters->Canvas->FillRect(Rect);
    if (Column->Field->IsNull) IconID = 8;
    else
      switch (Column->Field->AsInteger) {
        case 0: IconID = 9;
        break;
        case 1: IconID = 8;
        break;
        case 2: IconID = 10;
        break;
      }

    ilMenu->Draw(grMeters->Canvas, Rect.Left+2, Rect.Top, IconID);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNP::grMetersTitleClick(TColumnEh *Column)
{
  if (oqSlave->Active){
    if (!Column)
      return;

    for (int i = 0; i < grMeters->Columns->Count; ++i){
      if (i == Column->Index)
        continue;
      ((TColumnEh *)grMeters->Columns->Items[i])->Title->SortMarker  = smNoneEh;
    }

    Column->Title->SortMarker = (Column->Title->SortMarker == smUpEh)?smDownEh:smUpEh;
    order_by_det = ((Column->Title->SortMarker == smDownEh)?(-1):1)*(Column->Field->Index + 1);
    SelectDet();
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNP::grRoutersTitleClick(TColumnEh *Column)
{
  if (oqMain->Active){
    if (!Column)
      return;

    for (int i = 0; i < grRouters->Columns->Count; ++i){
      if (i == Column->Index)
        continue;
      ((TColumnEh *)grRouters->Columns->Items[i])->Title->SortMarker  = smNoneEh;
    }

    Column->Title->SortMarker = (Column->Title->SortMarker == smUpEh)?smDownEh:smUpEh;
    order_by = ((Column->Title->SortMarker == smDownEh)?(-1):1)*(Column->Field->Index + 1);
    SelectConf();
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNP::oqMainBeforeOpen(TDataSet *DataSet)
{
  oqSlave->Close();
  oqDetDetails->Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNP::btnOkFilterClick(TObject *Sender)
{
  SelectDet();
}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNP::oqSlaveAfterScroll(TDataSet *DataSet)
{
  oqDetDetails->Close();
  if (oqSlave->RecordCount > 0)
  {
    oqDetDetails->ParamByName("mid")->AsInteger = DataSet->FieldByName("mid")->AsInteger;
    oqDetDetails->Execute();
  }
  dbtMID->Text = "";
  if (DataSet->Active && !DataSet->FieldByName("MID")->IsNull)
    dbtMID->Text = DataSet->FieldByName("MID")->Value;
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNP::oqSlaveBeforeOpen(TDataSet *DataSet)
{
  oqDetDetails->Close();
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNP::FormClose(TObject *Sender, TCloseAction &Action)
{
  oqDetDetails->Close();
  oqMain->Close();
  oqSlave->Close();
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNP::btnResetPacketIdClick(TObject *Sender)
{
  if (oqMain->RecordCount > 0 && oqMain->FieldByName("cid")->AsInteger>0)
  {
    oqQuery->ParamByName("cid")->AsInteger = oqMain->FieldByName("cid")->AsInteger;
    if (Application->MessageBox("Сбросить нумерацию пакетов?", Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
    {
      oqQuery->Execute();
      SelectConf();
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNP::mnONCancelClick(TObject *Sender)
{
  if(oqSlave->Active && !oqSlave->FieldByName("MID")->IsNull)
    dmMain->SetCommandOff(oqSlave->FieldByName("MID")->Value,((TComponent *)Sender)->Tag);}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNP::SetAccMenuOFF(void)
{
  bool lacc=(accOFF&&oqSlave->Active && !oqSlave->FieldByName("MID")->IsNull);
  mnOFF->Visible=lacc;
  mnOFF->Enabled=lacc;
  mnONCancel->Visible=lacc;
  mnONCancel->Enabled=lacc;
  mnON->Visible=lacc;
  mnON->Enabled=lacc;
}
//---------------------------------------------------------------------------

