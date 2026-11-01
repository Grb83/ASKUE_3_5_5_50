//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "InputParameters4.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFormInputParameters4 *FormInputParameters4;
//---------------------------------------------------------------------------
__fastcall TFormInputParameters4::TFormInputParameters4(TComponent* Owner)
    : TForm(Owner)
{
    meProfileDate->Text = TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn");
    meHalfDate->Text =    TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn");
    meBillDate->Text =    TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn");
    meMonthDate->Text =   TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn");
    meJournalDate->Text = TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn");
    meCurrentDate->Text = TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn");
    allProfileDate->Text =  TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn");

    meProfileDateEnd->Text = TDateTime("01.01.3000").FormatString("dd.mm.yyyy hh:nn");
    meHalfDateEnd->Text =    TDateTime("01.01.3000").FormatString("dd.mm.yyyy hh:nn");
    meBillDateEnd->Text =    TDateTime("01.01.3000").FormatString("dd.mm.yyyy hh:nn");
    meMonthDateEnd->Text =   TDateTime("01.01.3000").FormatString("dd.mm.yyyy hh:nn");
    meJournalDateEnd->Text = TDateTime("01.01.3000").FormatString("dd.mm.yyyy hh:nn");
    meCurrentDateEnd->Text = TDateTime("01.01.3000").FormatString("dd.mm.yyyy hh:nn");
    allProfileDateEnd->Text = TDateTime("01.01.3000").FormatString("dd.mm.yyyy hh:nn");
}
//---------------------------------------------------------------------------
void __fastcall TFormInputParameters4::cbClick(TObject *Sender)
{
    TCheckBox*cb = dynamic_cast<TCheckBox*>(Sender);
    if(!cb) return;
    TMaskEdit *sg = NULL;
    TMaskEdit *sg1 = NULL;
    switch((int)cb->Tag)
    {
      case  0: sg = meProfileDate; sg1 = meProfileDateEnd; break;
      case  1: sg = meHalfDate;    sg1 = meHalfDateEnd; break;
      case  2: sg = meBillDate;    sg1 = meBillDateEnd; break;
      case  3: sg = meMonthDate;   sg1 = meMonthDateEnd; break;
      case  4: sg = meJournalDate; sg1 = meJournalDateEnd; break;
      case  5: sg = meCurrentDate; sg1 = meCurrentDateEnd; break;
    }
    if(!sg) return;
    sg->Enabled = cb->Checked;
    sg->Color = sg->Enabled?clWindow:clMenu;
    if(!sg1) return;
    sg1->Enabled = cb->Checked;
    sg1->Color = sg1->Enabled?clWindow:clMenu;
}
//---------------------------------------------------------------------------
void __fastcall TFormInputParameters4::cbClickAll(TObject *Sender){
if (cbAllDate->Checked){
 meProfileDate->Text = allProfileDate->Text;
 meHalfDate->Text = allProfileDate->Text;
 meBillDate->Text = allProfileDate->Text;
 meMonthDate->Text = allProfileDate->Text;
 meJournalDate->Text = allProfileDate->Text;
 meCurrentDate->Text = allProfileDate->Text;

 meProfileDateEnd->Text = allProfileDateEnd->Text;
 meHalfDateEnd->Text = allProfileDateEnd->Text;
 meBillDateEnd->Text = allProfileDateEnd->Text;
 meMonthDateEnd->Text = allProfileDateEnd->Text;
 meJournalDateEnd->Text = allProfileDateEnd->Text;
 meCurrentDateEnd->Text = allProfileDateEnd->Text;

 cbProfileDate->Checked = true;
 cbClick(cbProfileDate);

 cbHalfDate->Checked = true;
 cbClick(cbHalfDate);

 cbBillDate->Checked = true;
 cbClick(cbBillDate);

 cbMonthDate->Checked = true;
 cbClick(cbMonthDate);

 cbJournalDate->Checked = true;
 cbClick(cbJournalDate);

 cbCurrentDate->Checked = true;
 cbClick(cbCurrentDate);

    if(!allProfileDate) return;
    allProfileDate->Enabled = true;
    allProfileDate->Color = clWindow;
    if(!allProfileDateEnd) return;
    allProfileDateEnd->Enabled = true;
    allProfileDateEnd->Color = clWindow;

}else{
    if(!allProfileDate) return;
    allProfileDate->Enabled = false;
    allProfileDate->Color = clMenu;
    if(!allProfileDateEnd) return;
    allProfileDateEnd->Enabled = false;
    allProfileDateEnd->Color = clMenu;

}

}
//---------------------------------------------------------------------------

