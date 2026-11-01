//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "unDataMod.h"
#include "setpasword.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TFormSetPasword *FormSetPasword;
//---------------------------------------------------------------------------
__fastcall TFormSetPasword::TFormSetPasword(TComponent* Owner)
	: TForm(Owner)
{
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
}
//---------------------------------------------------------------------------
void __fastcall TFormSetPasword::btOkClick(TObject *Sender)
{
   if(UsCon.Pasword.LowerCase()!=me1->Text.LowerCase())
    throw Exception(Reconst_smes59_1);
   if(me2->Text.Length()==0)
    throw Exception(Reconst_smes59_2);
   if(me2->Text!=me3->Text)
    throw Exception(Reconst_smes59_3);
   if(setPassword(me2->Text.c_str())){
    MessageBox(Handle,Reconst_smes59_4.c_str(),Application->Title.c_str(),MB_OK|MB_ICONINFORMATION);
    UsCon.Pasword=me2->Text.LowerCase();
    ModalResult=mrOk;
   }
}
//---------------------------------------------------------------------------
bool __fastcall TFormSetPasword::setPassword(char* NewPassw){
  try{
  //GRB ADD 16.04.2020 - test trouble ODAC
  dmMain->quMain->Params->Clear();
  //END ADD 
  dmMain->quMain->SQL->Text = "begin "+SchemeName+"common_pg.set_password_p(:par1); commit; end;";
  dmMain->quMain->ParamByName("par1")->AsString = NewPassw;
  dmMain->quMain->Execute();
  dmMain ->orases->Commit();
     return true;
  }catch(Exception &e){
   dmMain ->orases->Rollback();
   Application->ShowException(&e);
    return false;
  }
}
//----------------------------------------------------------------------------

