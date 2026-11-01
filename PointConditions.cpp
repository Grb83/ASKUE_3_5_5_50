//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "PointConditions.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"

//const MaxCountRow = 100;
//---------------------------------------------------------------------------
TItemData::TItemData(int Param, AnsiString Name, AnsiString Condition)
{
  NParam = Param;
  VName = Name;
  VCondition = Condition;
}
//---------------------------------------------------------------------------
__fastcall TfmPointConditions::TfmPointConditions(TComponent* Owner, int aPointId, TAccess a)
        : TMainForm(Owner,NULL,a)
{
   sgPointsList->Cells[0][0] = Reconst_smes52_1;
   sgPointsList->Cells[1][0] = Reconst_smes52_2;
   sgPointsList->Cells[2][0] = Reconst_smes52_3;
   sgPointsList->Cells[3][0] = Reconst_smes52_4;
   PointId = aPointId;
   vRefresh(this);
}
//---------------------------------------------------------------------------
void __fastcall TfmPointConditions::vDelete(TObject *Sender)
{
   if(sgPointsList->Cells[0][1].IsEmpty()) return;

   AnsiString title = sgPointsList->Selection.Bottom==sgPointsList->Selection.Top ?
      AnsiString(Reconst_smes52_5)+sgPointsList->Cells[0][sgPointsList->Row]+"?" :
      AnsiString(Reconst_smes52_6);
   if(Application->MessageBox(title.c_str(), Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==ID_YES)
   {
      int b = sgPointsList->Selection.Bottom;
      int t = sgPointsList->Selection.Top;
      int c = sgPointsList->RowCount;
      for(int i=0;i < c-b-1; i++)
      {
         sgPointsList->Rows[t+i]->Text = sgPointsList->Rows[b+i+1]->Text;
         sgPointsList->Objects[0][t+i] = sgPointsList->Objects[0][b+i+1];
      }
      for(int i=c-b+t; i<=c; i++)
         sgPointsList->Rows[i-1]->Text = "";
      sgPointsList->RowCount -= b-t;
      if(sgPointsList->RowCount>2)
         sgPointsList->RowCount--;
      EditRec = true;
//      sgPointsListSelectCell(sgPointsList, 1, sgPointsList->Selection.Bottom, true);
   }
   iaDelete->Enabled = !sgPointsList->Cells[0][1].IsEmpty();
   SetLabel();
}
//---------------------------------------------------------------------------
void __fastcall TfmPointConditions::vRefresh(TObject *Sender)
{
   LoadParams();
   LoadPointConditions();
   EditRec = false;
}
//---------------------------------------------------------------------------
void __fastcall TfmPointConditions::vSave(TObject *Sender)
{
  SavePointConditions();
}
//---------------------------------------------------------------------------
void __fastcall TfmPointConditions::SetAccess(TAccess value)
{
   if(FAccess != value){
      TMainForm::SetAccess(value);
      iaDelete->Enabled = value==accWrite;
//      gbEdit->Enabled = iaDelete->Enabled;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmPointConditions::vUpdate(TObject*Sender)
{
}
//---------------------------------------------------------------------------
void TfmPointConditions::LoadPointConditions()
{
  sgPointsList->Rows[1]->Clear();
  sgPointsList->RowCount = 2;
  try
  {
    oqSavePointConditions->Params->Clear();
    oqSavePointConditions->SQL->Text="begin "+SchemeName+"tc_pg.LoadPointConditions(:par1,:par2); end;";
    oqSavePointConditions->ParamByName("par2")->ParamType = ptOutput;
    oqSavePointConditions->ParamByName("par2")->DataType = ftCursor;
    oqSavePointConditions->ParamByName("par1")->AsInteger=PointId;
    oqSavePointConditions->Execute();
    while(!oqSavePointConditions->Eof){
     if(!sgPointsList->Cells[0][1].IsEmpty()) sgPointsList->RowCount++;

          sgPointsList->Cells[0][sgPointsList->RowCount-1] = oqSavePointConditions->FieldByName("vname")->AsString;
          sgPointsList->Objects[0][sgPointsList->RowCount-1] = (TObject*)oqSavePointConditions->FieldByName("NPARAM")->AsInteger;
          sgPointsList->Cells[1][sgPointsList->RowCount-1] = IntToStr(oqSavePointConditions->FieldByName("CLAMP")->AsInteger);
          sgPointsList->Cells[2][sgPointsList->RowCount-1] = oqSavePointConditions->FieldByName("VVALUE")->AsString;
          sgPointsList->Cells[3][sgPointsList->RowCount-1] = oqSavePointConditions->FieldByName("Condition")->AsString;

       oqSavePointConditions->Next();
       }

  }
   __finally
  {
    
  }
  iaDelete->Enabled = !sgPointsList->Cells[0][1].IsEmpty();
  SetLabel();
}
//---------------------------------------------------------------------------
void TfmPointConditions::SavePointConditions()
{
  AnsiString delStr;

  typedef char TVValueStr[512];

  unsigned long ArraySize = sgPointsList->RowCount - 1;

  long* Clamps = new long[ArraySize];
  long* NParams = new long[ArraySize];
  TVValueStr* VValues = new TVValueStr[ArraySize];

  unsigned long mas_size=ArraySize;

  if (!sgPointsList->Cells[0][1].IsEmpty())
  {
   for(int i = 1; i < sgPointsList->RowCount; i++)
   {
    try
    {
     Clamps[i-1] = StrToInt(sgPointsList->Cells[1][i]);
    }
    catch(EConvertError &e)
    {
      AnsiString msg = Reconst_smes52_7 + IntToStr(i);
      Application->MessageBox(msg.c_str(), Application->Title.c_str(), MB_OK|MB_ICONERROR);
      return;
    }
    NParams[i-1] = (long)sgPointsList->Objects[0][i];
    sprintf(VValues[i-1],sgPointsList->Cells[2][i].c_str());
  }
 }
 else mas_size = 0;
 
 try
 {
   oqSavePointConditions->Params->Clear();
   oqSavePointConditions->SQL->Text="begin "+SchemeName+"tc_pg.set_tcsignals(:par1,:par2,:par3, :par4); end;";
   oqSavePointConditions->ParamByName("par1")->AsInteger=PointId;
   oqSavePointConditions->ParamByName("par2")->Table=true;
   oqSavePointConditions->ParamByName("par3")->Table=true;
   oqSavePointConditions->ParamByName("par4")->Table=true;
   int cnt=0;
       for(int i=0;i<(int)mas_size;i++){
           oqSavePointConditions->ParamByName("par2")->Length=++cnt;
           oqSavePointConditions->ParamByName("par2")->ItemAsInteger[cnt]=Clamps[i];
           oqSavePointConditions->ParamByName("par3")->Length=cnt;
           oqSavePointConditions->ParamByName("par3")->ItemAsInteger[cnt]=NParams[i];
           oqSavePointConditions->ParamByName("par4")->Length=cnt;
           oqSavePointConditions->ParamByName("par4")->ItemAsString[cnt]=VValues[i];
           }
       if(!cnt){
          oqSavePointConditions->ParamByName("par2")->Length=1;
         // oqSavePointConditions->ParamByName("par2")->Clear();
          oqSavePointConditions->ParamByName("par2")->ItemAsInteger[1]=0;
          oqSavePointConditions->ParamByName("par3")->Length=1;
         // oqSavePointConditions->ParamByName("par3")->Clear();
           oqSavePointConditions->ParamByName("par3")->ItemAsInteger[1]=0;
          oqSavePointConditions->ParamByName("par4")->Length=1;
         // oqSavePointConditions->ParamByName("par4")->Clear();
           oqSavePointConditions->ParamByName("par4")->ItemAsString[1]=0;
          }
         oqSavePointConditions->Execute();
         dmMain->orases->Commit();


    EditRec = false;
   }
   __finally
   {
      
      delete[] Clamps;
      delete[] VValues;
      delete[] NParams;
   }
}
//---------------------------------------------------------------------------
void TfmPointConditions::LoadParams()
{
  ParamsList->Items->Clear();
  oqSavePointConditions->Params->Clear();
  oqSavePointConditions->SQL->Text="begin "+SchemeName+"tc_pg.LoadParams(:par1); end;";
  oqSavePointConditions->ParamByName("par1")->ParamType = ptOutput;
  oqSavePointConditions->ParamByName("par1")->DataType = ftCursor;
  oqSavePointConditions->Execute();
  while(!oqSavePointConditions->Eof){
   AddParam(oqSavePointConditions->FieldByName("NParam")->AsInteger,
             oqSavePointConditions->FieldByName("VName")->AsString,
             oqSavePointConditions->FieldByName("VCondition")->AsString);
       oqSavePointConditions->Next();
       }

  if (ParamsList->Items->Count > 0)
    ParamsList->Selected = ParamsList->Items->Item[0];
}
//---------------------------------------------------------------------------
TListItem* TfmPointConditions::AddParam(long id, AnsiString Name, AnsiString Condition)
{
   TListItem* newItem;
   newItem = ParamsList->Items->Add();
   newItem->Caption = Name;
   newItem->Data = new TItemData(id, Name, Condition);
   return newItem;
}
//---------------------------------------------------------------------------
void __fastcall TfmPointConditions::FormResize(TObject *Sender)
{
   int w = sgPointsList->ClientWidth - 25;
   w -= sgPointsList->ColWidths[0];
   w -= sgPointsList->ColWidths[1];
   sgPointsList->ColWidths[2] = w/2;
   sgPointsList->ColWidths[3] = w/2;
}
//---------------------------------------------------------------------------
void __fastcall TfmPointConditions::ParamsListStartDrag(TObject *Sender,
      TDragObject *&DragObject)
{
   DragData = (TItemData*)ParamsList->Selected->Data;
}
//---------------------------------------------------------------------------

void __fastcall TfmPointConditions::sgPointsListDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
  Accept = (DragData != NULL);
  if (Accept){
    for(int i = 0; i < sgPointsList->RowCount; i++){
      if ((long)sgPointsList->Objects[0][i] == DragData->NParam){
        Accept=false;
        return;
      }
    }
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmPointConditions::sgPointsListDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
  if(!DragData) return;
  for(int i = 0; i < sgPointsList->RowCount; i++)
  {
    if ((long)sgPointsList->Objects[0][i] == DragData->NParam)
    {
      sgPointsList->Row = i;
      DragData = NULL;
      return;
    }
  }

  if(!sgPointsList->Cells[0][1].IsEmpty()) sgPointsList->RowCount++;

  sgPointsList->Cells[0][sgPointsList->RowCount-1] = DragData->VName;
  sgPointsList->Objects[0][sgPointsList->RowCount-1] = (TObject*)DragData->NParam;
  sgPointsList->Cells[3][sgPointsList->RowCount-1] = DragData->VCondition;

  DragData = NULL;
  EditRec = true;
  iaDelete->Enabled = !sgPointsList->Cells[0][1].IsEmpty();
  SetLabel();
  if(sgPointsList->Selection.Top == sgPointsList->RowCount-1){
    bool CanSelect=true;
    sgPointsListSelectCell(sgPointsList, 1, sgPointsList->RowCount-1, CanSelect);
  }
 }
//---------------------------------------------------------------------------

void __fastcall TfmPointConditions::sgPointsListSelectCell(TObject *Sender,
      int ACol, int ARow, bool &CanSelect)
{
  if ((ACol == 0) || (ACol == 3))
  {
    sgPointsList->Options >> goEditing;
  }
  else
    sgPointsList->Options << goEditing;
  SetLabel(ARow);  
}
//---------------------------------------------------------------------------

void __fastcall TfmPointConditions::sgPointsListSetEditText(
      TObject *Sender, int ACol, int ARow, const AnsiString Value)
{
  EditRec = true;
}
//---------------------------------------------------------------------------
void __fastcall TfmPointConditions::SetLabel(int ARow)
{
  int i=0,j=0;
  if(sgPointsList->RowCount>2){
    i=(ARow)?ARow:((sgPointsList->Row>0)?sgPointsList->Row:1);
    j=sgPointsList->RowCount-1;
  }else{
    if(!sgPointsList->Cells[0][1].IsEmpty()){
      i=1;
      j=1;
    }
  }
  paInfo->Caption=IntToStr(i)+AnsiString("/")+IntToStr(j);
}
//---------------------------------------------------------------------------

