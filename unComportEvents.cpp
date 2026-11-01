//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unComportEvents.h"
#include "math.h"
#include "unDataMod.h"
#include "Reconst.hpp"
#include <DateUtils.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "DBGridEh"
#pragma resource "*.dfm"
TfmComportEvents *fmComportEvents;
//---------------------------------------------------------------------------
__fastcall TfmComportEvents::TfmComportEvents(TComponent* Owner)
  : TForm(Owner)
{
  new(this) TfmComportEvents(Owner, 0, "");
}
//---------------------------------------------------------------------------
__fastcall TfmComportEvents::TfmComportEvents(TComponent* Owner, long assdID,
  AnsiString adefaultCOM)
  : TForm(Owner)
{
  desc1=0;
  desc2=0;
  desc3=0;
  sort = -1;
  ssdID = assdID;
  defaultCOM = adefaultCOM;
}
//---------------------------------------------------------------------------
void __fastcall TfmComportEvents::FormClose(TObject *Sender,
      TCloseAction &Action)
{
  Action=caFree;
}
//---------------------------------------------------------------------------
void __fastcall TfmComportEvents::m_btnCloseClick(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------


void __fastcall TfmComportEvents::FormShow(TObject *Sender)
{
  TDateTime dtCurrent = Now();
  int comID;
  int index;
  AnsiString comName = "";

  dtFrom->DateTime = dtCurrent - 1;
  edFrom->Text = dtCurrent - 1;
  dtTill->DateTime = dtCurrent+1;
  edTill->Text = dtCurrent+1;

  cbCOMPort->Clear();
  cbCOMPort->AddItem("Все порты", 0);
  zapros_go = 0;
  oqMain->SQL->Text = "begin " + SchemeName + "COMPORTS_PG.list_ports(:par1, :par2); end;";
  oqMain->ParamByName("par1")->AsInteger = ssdID;
  oqMain->ParamByName("par2")->ParamType = ptOutput;
  oqMain->ParamByName("par2")->DataType = ftCursor;

  oqMain->Execute();
  while (!oqMain->Eof) {
    comID = oqMain->FieldValues["com_id"];
    comName = oqMain->FieldValues["name"];
    cbCOMPort->AddItem(comName, (TObject *)comID);

    oqMain->Next();
  }
  oqMain->Close();

  index = cbCOMPort->Items->IndexOf(defaultCOM);
  if (index < 0) index = 0;
  cbCOMPort->ItemIndex = index;
  SortData();
}
//---------------------------------------------------------------------------

void __fastcall TfmComportEvents::SortData( void )
{
  TListItem *newitem;
  TDateTime from, till;
  TDateTime sysDate;
  int index = 0;
  int pos = 0;
  try {
        Go->Enabled = false;
    try{
    sysDate = dmMain->SystemDate;
    sysDate = sysDate.CurrentDate() + StrToTime("00:00:00");

    }catch (Exception &ex1){
    Application->MessageBox ("Вылет на sysDate = dmMain->SystemDate;",Application->Title.c_str(),MB_OK);
    Go->Enabled = true;
    return;
    }
    if (zapros_go == 0){
        //GRB ADD 11.11.2021
        try{
        oqMain->Params->Clear();
        oqMain->SQL->Text = "begin " + SchemeName +
        "COMPORTS_PG.select_events(:par1, :par2, to_date(:par3, 'dd.mm.yyyy hh24:mi:ss'), to_date(:par4, 'dd.mm.yyyy hh24:mi:ss'), :par5, :par6); end;";
        zapros_go = 1;
        }catch (Exception &ex3){
        Application->MessageBox ("Вылет на oqMain->SQL->Text =...;",Application->Title.c_str(),MB_OK);
        ShowMessage(ex3.Message);
        Application->ShowException(&ex3);
        }
        //END ADD

  }
    /*try{
    oqMain->Params->Clear();
    }catch (Exception &ex2){
    Application->MessageBox ("Вылет на oqMain->Params->Clear();",Application->Title.c_str(),MB_OK);
    Go->Enabled = true;
    return;
    } */
    /*try{
    oqMain->SQL->Text = "begin " + SchemeName +
      "COMPORTS_PG.select_events(:par1, :par2, to_date(:par3, 'dd.mm.yyyy hh24:mi:ss'), to_date(:par4, 'dd.mm.yyyy hh24:mi:ss'), :par5, :par6); end;";
    }catch (Exception &ex3){
    Application->MessageBox ("Вылет на oqMain->SQL->Text =...;",Application->Title.c_str(),MB_OK);
    ShowMessage(ex3.Message);
    Application->ShowException(&ex3);
    Go->Enabled = true;
    return;
    } */
    try{
    index = cbCOMPort->ItemIndex;
    }catch (Exception &ex4){
    Application->MessageBox ("Вылет на int index = cbCOMPort->ItemIndex;",Application->Title.c_str(),MB_OK);
    Go->Enabled = true;
    return;
    }
    try{
    pos = (int)cbCOMPort->Items->Objects[index];
    }catch (Exception &ex5){
    Application->MessageBox ("Вылет на int pos = (int)cbCOMPort->Items->Objects[index];",Application->Title.c_str(),MB_OK);
    Go->Enabled = true;
    return;
    }
    try{
    oqMain->ParamByName("par1")->AsInteger = pos;
    }catch (Exception &ini_ex){
    Application->MessageBox ("Вылет на oqMain->ParamByName('par1')->AsInteger = pos; ",Application->Title.c_str(),MB_OK);
    Go->Enabled = true;
    return;
    }
    oqMain->ParamByName("par2")->AsInteger = ssdID;

    from = TDateTime(floor(dtFrom->Date)) + StrToTime(edFrom->Text);
    //from = IncDay(sysDate,-1) + StrToTime(edFrom->Text);
    till = TDateTime(floor(dtTill->Date)) + StrToTime(edTill->Text);
    //till = IncDay(sysDate,1) + StrToTime(edTill->Text);

    oqMain->ParamByName("par3")->AsString = from.FormatString("dd.mm.yyyy hh:MM:ss");
    oqMain->ParamByName("par4")->AsString = till.FormatString("dd.mm.yyyy hh:MM:ss");;
    oqMain->ParamByName("par5")->AsInteger = sort;
    oqMain->ParamByName("par6")->ParamType = ptOutput;
    oqMain->ParamByName("par6")->DataType = ftCursor;
    try{
    oqMain->Execute();
    }catch (Exception &eoe){
    Application->MessageBox ("Вылет на вызове COMPORTS_PG.select_events",Application->Title.c_str(),MB_OK);
    Application->ShowException(&eoe);
    Go->Enabled = true;
    return;
    }
  } catch(Exception &exception)
    {
        Application->MessageBox ("Необработанные исключения в TfmComportEvents::SortData",Application->Title.c_str(),MB_OK);
        Application->ShowException(&exception);
        Go->Enabled = true;
    }
    Go->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TfmComportEvents::GoClick(TObject *Sender)
{
  SortData();
}
//---------------------------------------------------------------------------
void __fastcall TfmComportEvents::m_btnSaveClick(TObject *Sender)
{
  TdmMain::SaveTable(this,MessageGrid1,Caption+" "+cbCOMPort->Text + ", с " + dtFrom->Date.FormatString("dd.mm.yyyy") +
      " " + edFrom->Text + " по " + dtTill->Date.FormatString("dd.mm.yyyy") +
      " " + edTill->Text);
}
//---------------------------------------------------------------------------

void __fastcall TfmComportEvents::MessageGrid1TitleClick(TColumnEh *Column)
{
  TColumnEh *tCol = dynamic_cast<TColumnEh *>(Column);
  if (!tCol)
    return;

  for (int i = 0; i < MessageGrid1->Columns->Count; ++i)
  { if (i == tCol->Index)
      continue;
    ((TColumnEh *)MessageGrid1->Columns->Items[i])->Title->SortMarker  = smNoneEh;
  }

  if (tCol->Title->SortMarker == smUpEh)
  { tCol->Title->SortMarker = smDownEh;
    desc1 = true;
    desc2 = true;
    desc3 = true;
  }
  else
  {
    tCol->Title->SortMarker = smUpEh;
    desc1 = false;
    desc2 = false;
    desc3 = false;
  }

  int ci = tCol->Index + 1;
  switch (ci)
  { case 1:
        sort = desc1?(-1)*ci:ci;
      break;
    case 2:
        sort = desc2?(-1)*ci:ci;
      break;
    case 3:
        sort = desc3?(-1)*ci:ci;
      break;
  }

  SortData();
}
//---------------------------------------------------------------------------
TDateTime __fastcall TfmComportEvents::FSystemDate(void)
{
  static double d;
  static TDateTime t=TDateTime(2000,1,1);
  try{
      if(abs(t-Now())>0.01){
        oqMain->Open();
        oqMain->SQL->Text="SELECT SYSDATE D FROM DUAL";
        oqMain->Open();
        t=oqMain->FieldByName("D")->AsDateTime;
        oqMain->Close();

        d=t-Now();
      }
    }catch(Exception &e){
      Application->ShowException(&e);
      Application->Terminate();
  }
  return Now()+d;
}
//---------------------------------------------------------------------------

