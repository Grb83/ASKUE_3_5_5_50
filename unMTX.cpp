//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unDataMod.h"
#include "unMTX.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "DBGridEh"
//#pragma link "GridsEh"
#pragma resource "*.dfm"
TfmMTX *fmMTX;
//---------------------------------------------------------------------------
__fastcall TfmMTX::TfmMTX(TComponent* Owner)
  : TForm(Owner)
{
  order_by = 0;
  order_by_det = 0;
  grActive=grRouters;
  SelectConf();
}
//---------------------------------------------------------------------------
bool __fastcall  TfmMTX::fmMTXShow(TComponent* Owner)
{
  TfmMTX *f=new TfmMTX(Owner);
  int res = f->ShowModal();
  delete f;
  return (res == mrOk);
}
//---------------------------------------------------------------------------


void __fastcall TfmMTX::btnRefreshClick(TObject *Sender)
{
  SelectConf();
}
//---------------------------------------------------------------------------

void __fastcall TfmMTX::m_btnSaveClick(TObject *Sender)
{
  TdmMain::SaveTable(this,grActive,Caption);
}
//---------------------------------------------------------------------------

void __fastcall TfmMTX::oqMainAfterScroll(TDataSet *DataSet)
{
  SelectDet();
}
//---------------------------------------------------------------------------
void __fastcall TfmMTX::grRoutersEnter(TObject *Sender)
{
  grActive=(TDBGridEh *)Sender;
}
//---------------------------------------------------------------------------

void __fastcall TfmMTX::btnDeleteMeterClick(TObject *Sender)
{
  if (oqSlave->RecordCount > 0 && oqMain->RecordCount > 0)
  {
    OraQuery->ParamByName("mid")->AsInteger = oqMain->FieldByName("mid")->AsInteger;
    OraQuery->ParamByName("order")->AsInteger = oqSlave->FieldByName("norder")->AsInteger;
    if (Application->MessageBox("Удалить выбранное устройство?", Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
    {
      OraQuery->Execute();
      SelectDet();
    }
  }
}

//---------------------------------------------------------------------------
void __fastcall TfmMTX::SelectDet(void)
{
  int filter = 0;
  if (btnErrorFilter->Down) filter += 0x01;
  if (btnWarningFilter->Down) filter += 0x02;
  if (btnOkFilter->Down) filter += 0x04;
  oqSlave->Close();
  if (oqMain->RecordCount > 0)
  {
    oqSlave->ParamByName("mid")->AsInteger = oqMain->FieldByName("mid")->AsInteger;
    oqSlave->ParamByName("cid")->AsInteger = oqMain->FieldByName("cid")->AsInteger;
    oqSlave->ParamByName("filter")->AsInteger = filter;
    oqSlave->ParamByName("sort")->AsInteger = order_by_det;
    oqSlave->Execute();
  }
}

//---------------------------------------------------------------------------
void __fastcall TfmMTX::SelectConf(void)
{
  oqMain->Close();
  oqMain->ParamByName("sort")->AsInteger = order_by;
  oqMain->Execute();
}

//---------------------------------------------------------------------------
void __fastcall TfmMTX::grMetersDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
//    108 warning
//    109 good
//    110 bad
  int IconID = 110;
  if (DataCol == 0)
  {
    grMeters->Canvas->FillRect(Rect);
    if (Column->Field->IsNull) IconID = 108;
    else if (Column->Field->AsInteger == 0) IconID = 109;
    else IconID = 110;

    ilMenu->Draw(grMeters->Canvas, Rect.Left+2, Rect.Top, IconID);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmMTX::grMetersTitleClick(TColumnEh *Column)
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

void __fastcall TfmMTX::grRoutersTitleClick(TColumnEh *Column)
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


void __fastcall TfmMTX::oqMainBeforeOpen(TDataSet *DataSet)
{
  oqSlave->Close();
  oqDetDetails->Close();
}
//---------------------------------------------------------------------------



void __fastcall TfmMTX::btnOkFilterClick(TObject *Sender)
{
  SelectDet();  
}
//---------------------------------------------------------------------------

void __fastcall TfmMTX::btnDeleteRouterClick(TObject *Sender)
{
  if (oqMain->RecordCount > 0 && oqMain->FieldByName("mid")->AsInteger>0)
  {
    OraQuery->ParamByName("mid")->AsInteger = oqMain->FieldByName("mid")->AsInteger;
    OraQuery->ParamByName("order")->Clear();
    if (Application->MessageBox("Удалить все устройства роутера?", Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
    {
      OraQuery->Execute();
      SelectConf();
    }
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmMTX::oqSlaveAfterScroll(TDataSet *DataSet)
{
  oqDetDetails->Close();
  if (oqSlave->RecordCount > 0)
  {
    oqDetDetails->ParamByName("mid")->AsInteger = oqSlave->FieldByName("mid")->AsInteger;
    oqDetDetails->Execute();
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmMTX::oqSlaveBeforeOpen(TDataSet *DataSet)
{
  oqDetDetails->Close();
}
//---------------------------------------------------------------------------

void __fastcall TfmMTX::FormClose(TObject *Sender, TCloseAction &Action)
{
  oqDetDetails->Close();
  oqMain->Close();
  oqSlave->Close();
  OraQuery->Close();  
}
//---------------------------------------------------------------------------

