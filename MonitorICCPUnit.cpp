//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MonitorICCPUnit.h"
#include "unDataMod.h"
#include "selectpoint.h"
#include <SysUtils.hpp>

#include "unEditServName.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Main"
#pragma link "DBGridEh"
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "OraSmart"
#pragma link "PrnDbgeh"
#pragma resource "*.dfm"
TMonitorICCPForm *MonitorICCPForm;
//---------------------------------------------------------------------------
__fastcall TMonitorICCPForm::TMonitorICCPForm(TComponent* Owner, AnsiString Name, TAccess a)
  : TMainForm(Owner, Name, a)
{
 ReplaceRyda(this,BASE_SCHEME,SchemeName);
}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::vSave(TObject *Sender)
{

}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::vRefresh(TObject *Sender)
{

}
//----------------------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::FormCreate(TObject *Sender)
{
  RowToRem = 1;
  MonColToRem = 0;
  AssColToRem = 0;

  Refresh(MonColToRem);

  ((TColumnEh *)grMonitor->Columns->Items[1])->Title->SortMarker  = smUpEh;
  ((TColumnEh *)grAssociation->Columns->Items[1])->Title->SortMarker  = smUpEh;


}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::grMonitorCellClick(TColumnEh *Column)
{
  if (grMonitor->Row != RowToRem)
  {
    AssociationsRefresh();
    RowToRem = grMonitor->Row;
  }
}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::grMonitorKeyUp(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
  //if (((Key == 38) || (Key == 40) || (Key == 9)) && (grMonitor->Row != RowToRem))
    if ((Key == 38) || (Key == 40))
  {
      AssociationsRefresh();

      RowToRem = grMonitor->Row;
  }
}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::Panel3Resize(TObject *Sender)
{
 // grAssociation->Columns->Items[4]->Width = grAssociation->Width - grAssociation->Columns->Items[1]->Width - grAssociation->Columns->Items[2]->Width - grAssociation->Columns->Items[3]->Width - 10;
}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::FormShow(TObject *Sender)
{
  grMonitor->SetFocus();  
}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::Refresh(int srt)
{
  oqGetMonitor->Close();

  if (!srt)
    oqGetMonitor->ParamByName("srt")->Clear();
  else
    oqGetMonitor->ParamByName("srt")->AsInteger = srt;

  oqGetMonitor->Execute();

  oqGetMonitor->First();

    for (int i = 0; i < (RowToRem - 1); i++)
    {
     oqGetMonitor->Next();
    }

  AssociationsRefresh();
}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::TimerTimer(TObject *Sender)
{
    this->Cursor = crDefault;
    oqGetMonitor->DisableControls();
    Refresh(MonColToRem);
    oqGetMonitor->EnableControls();
    this->Cursor = crDefault;
}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::iaPrintExecute(TObject *Sender)
{
  PrintgrMonitor->Preview();
}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::grMonitorTitleClick(TColumnEh *Column)
{
  TColumnEh *tCol = dynamic_cast<TColumnEh *>(Column);
  if (!tCol)
    return;

    for (int i = 0; i < grMonitor->Columns->Count; ++i)
    {
      if (i == tCol->Tag)
        continue;
      ((TColumnEh *)grMonitor->Columns->Items[i])->Title->SortMarker  = smNoneEh;
    }

  if (tCol->Title->SortMarker == smUpEh)
  {
    tCol->Title->SortMarker = smDownEh;
    MonColToRem = 0 - (tCol->Tag+1);
  }
  else
  {
    tCol->Title->SortMarker = smUpEh;
    MonColToRem = tCol->Tag+1;
  }
  Refresh(MonColToRem);
}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::iaRefreshExecute(TObject *Sender)
{
  Refresh(MonColToRem);
}
//---------------------------------------------------------------------------

void __fastcall TMonitorICCPForm::grAssociationTitleClick(
      TColumnEh *Column)
{
    TColumnEh *tCol = dynamic_cast<TColumnEh *>(Column);
  if (!tCol)
    return;

    for (int i = 0; i < grAssociation->Columns->Count; ++i)
    {
      if (i == tCol->Tag)
        continue;
      ((TColumnEh *)grAssociation->Columns->Items[i])->Title->SortMarker  = smNoneEh;
    }

  if (tCol->Title->SortMarker == smUpEh)
  {
    tCol->Title->SortMarker = smDownEh;
    AssColToRem = 0 - (tCol->Tag+1);
  }
  else
  {
    tCol->Title->SortMarker = smUpEh;
    AssColToRem = tCol->Tag+1;
  }

  AssociationsRefresh();

}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::AssociationsRefresh()
{
    oqAssociations->Close();

    if (!AssColToRem)
      oqAssociations->ParamByName("srt")->Clear();
    else
      oqAssociations->ParamByName("srt")->AsInteger = AssColToRem;

    oqAssociations->ParamByName("mmid")->AsInteger=oqGetMonitor->FieldByName("mid")->AsInteger;
    oqAssociations->Execute();

    for (int i = 0; i < (AssRowToRem - 1); i++)
    {
      oqAssociations->Next();
    }
}
//---------------------------------------------------------------------------

void __fastcall TMonitorICCPForm::grAssociationKeyUp(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
    AssRowToRem = grAssociation->Row;
}
//---------------------------------------------------------------------------

void __fastcall TMonitorICCPForm::grAssociationCellClick(TColumnEh *Column)
{
    AssRowToRem = grAssociation->Row;
}
//---------------------------------------------------------------------------

void __fastcall TMonitorICCPForm::acEdServNameExecute(TObject *Sender)
{
  TfmEditServName *f = new TfmEditServName (Application, oqGetMonitor->FieldByName("NNAME")->AsString, oqGetMonitor->FieldByName("mid")->AsInteger);

  f->ShowModal();

  if (f->ModalResult == mrOk)
    Refresh(MonColToRem);

  delete f;
}
//---------------------------------------------------------------------------
void __fastcall TMonitorICCPForm::FormClose(TObject *Sender,
      TCloseAction &Action)
{
  oqGetMonitor->Close();
  oqAssociations->Close();

  TMainForm::FormClose(Sender, Action);
}
//---------------------------------------------------------------------------


