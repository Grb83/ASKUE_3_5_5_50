//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "JournalAlert.h"
#include "unDataMod.h"
#include "Filter.h"
#include "Reconst.hpp"
#include "InteriorAlert.cpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DBGridEh"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
TdlgJournalAlert *dlgJournalAlert;
struct
{ int   type;
  long  mid;
} filter2 = {0, 0};
int adv_filter = 0;
AnsiString code;
//---------------------------------------------------------------------------

void deniedBreakCommunicationButtonQucickFix (TDBGridEh *MessageGrid, TOraQuery *quMain){
/**!!! GRB: Hardcode (bugefix: denied button "break of communication" on SupperMain Form if no longer elements in list)!!!*/
      //TODO -> With enabled part of FIX in SupperMain.cpp - need to migrate into HackUtilsFix.cpp 
        if (MessageGrid->SelectedRows->Count==quMain->RecordCount){
             PostMessage( SupperMainForm -> Handle, WM_UPDATE_SPEED_BUTTON, 4, 9 );
        }
/**!!!END of FIX*/
}
__fastcall TdlgJournalAlert::TdlgJournalAlert(TComponent* Owner)
	: TForm(Owner),	m_ulNumberSelectedRows(0)
{
  filter2.type=0;
  filter2.mid=0;
  wasSwapColumn = false;
}
//---------------------------------------------------------------------------
void __fastcall TdlgJournalAlert::SelectData( void )
{

  static bool frun  = false;
  if (frun)
    return;
  frun  = true;
  try{

      quMain->Params->Clear();
      quMain->SQL->Text="begin "+SchemeName+"interior_pg.JournalAlert_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7);end;";
      quMain->ParamByName("par7")->DataType=ftCursor;
      quMain->ParamByName("par7")->ParamType=ptOutput;

      quMain->ParamByName("par1")->AsInteger =Tag;
      quMain->ParamByName("par2")->AsString = orderStr;
      quMain->ParamByName("par3")->AsInteger = filter2.mid;
      quMain->ParamByName("par4")->AsInteger = filter2.type;
      quMain->ParamByName("par5")->AsString = code;
      quMain->ParamByName("par6")->AsInteger = adv_filter;


    MessageGrid->Columns->Items[0]->FieldName="field1";
    MessageGrid->Columns->Items[1]->FieldName="field2";
    MessageGrid->Columns->Items[2]->FieldName="field3";
    MessageGrid->Columns->Items[3]->FieldName="field5";
    MessageGrid->Columns->Items[3]->Visible = (Tag==3||Tag==1);
     quMain->Execute();

    }__finally{

     frun  = false;
    }
 }
//---------------------------------------------------------------------------
void __fastcall TdlgJournalAlert::OnSubmit(TObject *Sender)
{
  long  i;
  int   cnt;
  LPARAM lParam = 0;
   quMain->DisableControls();
   int trec  = quMain->RecNo;
  try
  { try
    { switch (Tag)
      { case 1: // Обрыв связи
        case 2: // Предупреждение
          if (quMain->RecordCount&&MessageGrid->SelectedRows->Count>0){
          if(MessageBox(Handle, Reconst_smes94_1.c_str(),Application->Title.c_str(),MB_YESNO | MB_ICONQUESTION | MB_DEFBUTTON2) == IDYES){
             dmMain->quMain->Params->Clear();
             if(Tag==1)
                dmMain->quMain->SQL->Text= "begin "+SchemeName+"admin_pg.receipting_chan_p(:par1); end;";
             else
                dmMain->quMain->SQL->Text= "begin "+SchemeName+"admin_pg.receipting_warning_p(:par1); end;";
         for (int rcnt = 0; rcnt < MessageGrid->SelectedRows->Count; ++rcnt){
                 quMain->GotoBookmark((void *)MessageGrid->SelectedRows->Items[rcnt].c_str());
                dmMain->quMain->ParamByName("par1")->AsInteger=StrToInt(quMain->FieldByName("field1")->AsString);
                dmMain->quMain->Execute();
                }
              }
           deniedBreakCommunicationButtonQucickFix (MessageGrid, quMain);
           MessageGrid->SelectedRows->Clear();
          }else {
              Application->MessageBox(Reconst_smes94_2.c_str(), Reconst_smes94_3.c_str(),
                                      MB_OK | MB_ICONINFORMATION);
              }
          break;
        case 3: // Сообщение
          if(!quMain->RecordCount)
            break;
          if (MessageBox(Handle, Reconst_smes94_4.c_str(),
                          Application->Title.c_str(),
                          MB_YESNO | MB_ICONQUESTION | MB_DEFBUTTON2) == IDYES)
          {
           dmMain->quMain->Params->Clear();
           dmMain->quMain->SQL->Text= "begin "+SchemeName+"admin_pg.receipting_p; end;";
           dmMain->quMain->Execute();
          }
          break;

      }
    }
    catch (Exception &e)
    {
     dmMain ->orases->Rollback();
    }
    SelectData();
  }
     __finally
  { if (quMain->RecordCount)
    { if (trec < quMain->RecordCount)
        quMain->RecNo  = trec;
      else
        quMain->RecNo  = quMain->RecordCount;
    }
    quMain->EnableControls();
    }

}
//---------------------------------------------------------------------------
void __fastcall TdlgJournalAlert::OnShow(TObject *Sender)
{
  aSubmit->Visible  = (dmMain->GetTaskRights(UsCon.Role_Id, 98)==TASK_RIGHTS_WRITE);
  aSubmit->Enabled  = aSubmit->Visible;
  switch (Tag)
  { case 1: // Обрыв связи
      Caption = Reconst_smes94_5;
		  break;
    case 2: // Предупреждение
      Caption = Reconst_smes94_6;
		  break;
    case 3: // Сообщение
      Caption = Reconst_smes94_7;
		  break;
  }
  MessageGrid->Columns->Items[0]->Title->Caption  = "";
  MessageGrid->Columns->Items[0]->Width = 25;
  orderStr  = "field2 desc";
  if(Tag==1)  MessageGrid->Columns->Items[3]->Title->Caption  = "Порт";
  SelectData();
 ((TColumnEh *)MessageGrid->Columns->Items[1])->Title->SortMarker  = smDownEh;
}
//---------------------------------------------------------------------------

void __fastcall TdlgJournalAlert::Timer1Timer(TObject *Sender)
{
   SelectData();
}
//---------------------------------------------------------------------------

void __fastcall TdlgJournalAlert::aFilterClick(TObject *Sender)
{
#define MAS_LEN 500
#define ACol 0
#define ARow DrawTable->Row
  TfmFilter *f  = new TfmFilter(this);
  try
  {
    f->Panel2->Visible = false;
    f->plJournal->Visible = false;
    f->plMessages->Visible = true;
    f->edCode2->Visible = Tag==3;
    f->lCode2->Visible = Tag==3;
    f->plAdv->Visible = Tag==3;
      switch (Tag){
       case 1:
          f->cbMessValue1->Clear();
          f->cbMessValue1->Items->AddObject(Reconst_smes94_8,(TObject*)0);
          f->cbMessValue1->ItemIndex=0;
          break;
       case 2:
          f->cbMessValue1->Clear();
          f->cbMessValue1->Items->AddObject(Reconst_smes94_9,(TObject*)0);
          f->cbMessValue1->ItemIndex=0;
          break;
       case 3:
          f->cbMessValue1->ItemIndex  = filter2.type;
          f->edCode2->Text = code;
          f->edAdvFilter->Text = sAdvFilter;
          f->chbNot->Checked = adv_filter<0;
          break;
          }
     if(filter2.mid){
          f->edMessValue->Clear();
          f->edMessValue->Text=Name;
      }else{
          f->edMessValue->Text=Reconst_smes94_10;
          FGid=0;
          }
    f->ShowModal();
    if (f->ModalResult == mrOk)
    { filter2.type = f->cbMessValue1->ItemIndex;
      filter2.mid = FGid;
      adv_filter = f->chbNot->Checked?(-1)*FGid_adv:FGid_adv;
      Name = f->edMessValue->Text;
      sAdvFilter = f->edAdvFilter->Text;
      code = f->edCode2->Text;
      SelectData();
    }
  }
  __finally
  { delete f;
  }
#undef MAS_LEN
#undef ACol
#undef ARow
}
//---------------------------------------------------------------------------

/*! Отображение полного содержимого ячейки в отдельном окне.
*/
void __fastcall TdlgJournalAlert::MessageGridDblClick(TObject *Sender)
{
  TPoint  tp  = MessageGrid->ScreenToClient(Mouse->CursorPos);
  TGridCoord  tgc = MessageGrid->MouseCoord(tp.x, tp.y);
  if (tgc.Y < 1)
    return;
  ShowMessage(quMain->FieldByName("field2")->AsString + "\n" +
                quMain->FieldByName("field3")->AsString);
}
//---------------------------------------------------------------------------

/*! Отрисовка иконки типа сообщения в первой колонке сетки
*/
void __fastcall TdlgJournalAlert::m_btnRefreshDataClick(TObject *Sender)
{
  SelectData();
}
//---------------------------------------------------------------------------
void __fastcall TdlgJournalAlert::aExportExecute(TObject *Sender)
{
  TDBGridEh *gr = MessageGrid;
  AnsiString  s;
  TStringList *StringList;
  TBookmark SavePlace;
  AnsiString  tab = char(9);
  TDataSet  *ds = gr->DataSource->DataSet;
  if (!ds || !ds->Active)
  { Application->MessageBox(Reconst_smes94_11.c_str(),
                              Application->Title.c_str(),
                            MB_OK | MB_ICONSTOP);
    return;
  }
  if (!SaveDialog1->Execute())
    return;

  try
  { StringList  = new TStringList;
    //Завголовок
    StringList->Add(Caption);
    StringList->Add("");
    if (Tag == 4)
      s = gr->Columns->Items[0]->Title->Caption;
    else
      s = Reconst_smes94_12;
    for (int i = 1; i < gr->Columns->Count; i++)
    { if (!gr->Columns->Items[i]->Visible)
        continue;
      s += tab;
      if (gr->Columns->Items[i]->Field)
        s += gr->Columns->Items[i]->Title->Caption;
    }
    StringList->Add(s);
    //Данные
    SavePlace = ds->GetBookmark();
    ds->DisableControls();
    ds->First();
    int cn  = 0;
    while (!ds->Eof)
    { switch (Tag)
      { case 1:
          s = "3";
          break;
        case 2:
          s = "4";
          break;
        default:
          s = gr->Columns->Items[0]->Field->AsString;
      }
      for (int i = 1; i < gr->Columns->Count; i++)
      { if (!gr->Columns->Items[i]->Visible)
          continue;
        s += tab;
        if (gr->Columns->Items[i]->Field)
        { if (gr->Columns->Items[i]->Field->DataType == ftDateTime)
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
    StringList->SaveToFile(SaveDialog1->FileName);
    delete  StringList;
    Application->MessageBox(AnsiString(AnsiString(Reconst_smes94_13) +
                              SaveDialog1->FileName +
                              AnsiString(Reconst_smes94_14) +
                              IntToStr(cn) +
                              AnsiString(Reconst_smes94_15)).c_str(),
                            Application->Title.c_str(),
                            MB_OK | MB_ICONINFORMATION);
  }
  catch (Exception &e)
  { delete  StringList;
    throw;
  }
}
//---------------------------------------------------------------------------

void __fastcall TdlgJournalAlert::MessageGridDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
   if (DataCol != 0)
    return;
  MessageGrid->Canvas->FillRect(Rect);
    if ((Tag == 3) &&quMain->RecordCount)

    ImageList1->Draw(MessageGrid->Canvas, Rect.Left + 2, Rect.Top + 1,
                      Column->Field->AsInteger + 2,
                      true);
  else
    if (Tag == 2)
      ImageList1->Draw(MessageGrid->Canvas, Rect.Left + 2, Rect.Top + 1, 4, true);
    else
      if (Tag == 1)
        ImageList1->Draw(MessageGrid->Canvas, Rect.Left + 2, Rect.Top + 1, 3, true);
}
//---------------------------------------------------------------------------
void __fastcall TdlgJournalAlert::MessageGridTitleClick(TColumnEh *Column)
{
  TColumnEh *tCol = dynamic_cast<TColumnEh *>(Column);
  if (wasSwapColumn){
        wasSwapColumn = false;
        return;
  }
  if (!tCol)
    return;
  switch (tCol->Index)
  { case 0:
        orderStr  = "field1 ";
      break;
    case 1:
        orderStr  = "field2 ";
      break;
    case 2:
        orderStr  = "field3 ";
      break;
     case 3:
        orderStr = (Tag==3||Tag==1)?"field5 ":"field4 ";
      break;
  }

  for (int i = 0; i < MessageGrid->Columns->Count; ++i)
  { if (i == tCol->Index)
      continue;
    ((TColumnEh *)MessageGrid->Columns->Items[i])->Title->SortMarker  = smNoneEh;
  }

  if (tCol->Title->SortMarker == smUpEh)
  { tCol->Title->SortMarker = smDownEh;
    orderStr  += "desc ";
  }
  else
    tCol->Title->SortMarker = smUpEh;

  SelectData();
}
//---------------------------------------------------------------------------


void __fastcall TdlgJournalAlert::MessageGridColumnMoved(TObject *Sender,
      int FromIndex, int ToIndex)
{
        if ((FromIndex==0)){
        MessageGrid->Columns->Items[ToIndex]->Index = FromIndex;
        return;
        }
        if ((ToIndex==0)){
        MessageGrid->Columns->Items[ToIndex]->Index = FromIndex;
        return;
        }
        wasSwapColumn = true;
}
//---------------------------------------------------------------------------

