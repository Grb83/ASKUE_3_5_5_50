//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Find.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFindForm *FindForm=NULL;
//---------------------------------------------------------------------------
__fastcall TFindForm::TFindForm(TComponent* Owner)
   : TForm(Owner)
{
   FindForm=this;
}
//---------------------------------------------------------------------------

__fastcall TFindForm::~TFindForm()
{
   FindForm=NULL;
}
//---------------------------------------------------------------------------

void __fastcall TFindForm::cbClick(TObject *Sender)
{
   if(Sender==cbAP) {
      eAP->Enabled = cbAP->Checked;
      eAP->Color = eAP->Enabled?clWindow:clMenu;
   } else if(Sender==cbAM) {
      eAM->Enabled = cbAM->Checked;
      eAM->Color = eAM->Enabled?clWindow:clMenu;
   } else if(Sender==cbRP) {
      eRP->Enabled = cbRP->Checked;
      eRP->Color = eRP->Enabled?clWindow:clMenu;
   } else if(Sender==cbRM) {
      eRM->Enabled = cbRM->Checked;
      eRM->Color = eRM->Enabled?clWindow:clMenu;
   }

}
//---------------------------------------------------------------------------

bool __fastcall TFindForm::Compare(TMeasure*arg)
{
   int pos;
   switch(arg->entype){
   case EN:   // Актив приём
      if(!cbAP->Checked)
         goto chck;
      pos = eAP->Text.IsEmpty()?0:eAP->Text.ToInt();
      if(pos!=0 && pos!=arg->pos)
         return false;
      break;
   case ED:    // Актив отдача
      if(!cbAM->Checked)
         goto chck;
      pos = eAM->Text.IsEmpty()?0:eAM->Text.ToInt();
      if(pos!=0 && pos!=arg->pos)
         return false;
      break;
   case Q1:    // Реактив приём
      if(!cbRP->Checked)
         goto chck;
      pos = eRP->Text.IsEmpty()?0:eRP->Text.ToInt();
      if(pos!=0 && pos!=arg->pos)
         return false;
      break;
   case Q3:    // Реактив отдача
      if(!cbRM->Checked)
         goto chck;
      pos = eRM->Text.IsEmpty()?0:eRM->Text.ToInt();
      if(pos!=0 && pos!=arg->pos)
         return false;
      break;
   }
   goto cntn;
chck:
   if(cbAP->Checked||cbAM->Checked||cbRP->Checked||cbRM->Checked)
      return false;
   if(cbMeasure->Text.Length()==0)
      throw Exception(Reconst_smes31_1);
cntn:
   if(conformance(arg->text.c_str(), cbMeasure->Text.c_str()))
      return true;
   return false;
}
//---------------------------------------------------------------------------
// проверка соответствия строки маске
bool __fastcall TFindForm::conformance(char*text, char*mask)
{
   if(StrLen(mask)==0) return true;
   if(cbCase->Checked){
      if(StrPos(text, mask)==NULL)
         return false;
      else
         return true;
   }else{
      if(StrPos(AnsiStrLower(text), AnsiStrLower(mask))==NULL)
         return false;
      else
         return true;
   }
}
//---------------------------------------------------------------------------

void __fastcall TFindForm::bbOkClick(TObject *Sender)
{
   for(int i=0; i<cbMeasure->Items->Count; i++)
      if(cbMeasure->Items->Strings[i]==cbMeasure->Text)
         return;
   cbMeasure->Items->Add(cbMeasure->Text);
}
//---------------------------------------------------------------------------

