//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "unRTRNIK.h"
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
TfmRTRNIK *fmRTRNIK;
//---------------------------------------------------------------------------
__fastcall TfmRTRNIK::TfmRTRNIK(TComponent* Owner,long lcid)
  : TForm(Owner)
{
  order_by = 0;
  fcid=lcid;
  SelectDet();
}
//---------------------------------------------------------------------------
bool __fastcall  TfmRTRNIK::fmRTRNIKShow(TComponent* Owner,long lcid)
{
  TfmRTRNIK *f=new TfmRTRNIK(Owner,lcid);
  int res = f->ShowModal();
  delete f;
  return (res == mrOk);
}
//---------------------------------------------------------------------------  
void __fastcall TfmRTRNIK::btnRefreshClick(TObject *Sender)
{
  SelectDet();
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNIK::m_btnSaveClick(TObject *Sender)
{
  TdmMain::SaveTable(this,grMeters,Caption);
}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNIK::SelectDet(void)
{
  TCheckBox * cb;
  int filter = 0;

  for(int i=0;i<ComponentCount;i++) {
    cb=dynamic_cast<TCheckBox *>(Components[i]);
    if(cb&&cb->Tag>0&&(cb->OnClick==cbClick)&&cb->Checked)
      filter|=(1<<(cb->Tag-1));
  }
  oqSlave->Close();
  oqSlave->ParamByName("cid")->AsInteger = fcid;
  oqSlave->ParamByName("filter")->AsInteger = filter;
  oqSlave->ParamByName("sort")->AsInteger = order_by;
  oqSlave->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNIK::grMetersDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
//    8 warning
//    9 good
//    10 bad
return;
/*  int IconID = 10;
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
  }*/
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNIK::grMetersTitleClick(TColumnEh *Column)
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
    order_by = ((Column->Title->SortMarker == smDownEh)?(-1):1)*(Column->Field->Index + 1);
    SelectDet();
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNIK::oqMainBeforeOpen(TDataSet *DataSet)
{
  oqSlave->Close();
  oqDetDetails->Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNIK::oqSlaveAfterScroll(TDataSet *DataSet)
{
  oqDetDetails->Close();
  if (oqSlave->RecordCount > 0)
  {
    oqDetDetails->ParamByName("mid")->AsInteger = oqSlave->FieldByName("mid")->AsInteger;
    oqDetDetails->Execute();
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNIK::oqSlaveBeforeOpen(TDataSet *DataSet)
{
  oqDetDetails->Close();
}
//---------------------------------------------------------------------------

void __fastcall TfmRTRNIK::FormClose(TObject *Sender, TCloseAction &Action)
{
  oqDetDetails->Close();
  oqSlave->Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmRTRNIK::cbClick(TObject *Sender)
{
  SelectDet();
}
//---------------------------------------------------------------------------

