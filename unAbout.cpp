//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "unAbout.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmAbout *fmAbout;
//---------------------------------------------------------------------------
__fastcall TfmAbout::TfmAbout(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmAbout::Label1Click(TObject *Sender)
{
    //ShellExecute(Handle,"open","mailto: office@intep.in.ua",0,0,SW_SHOW);
}
//---------------------------------------------------------------------------
void __fastcall TfmAbout::Image1Click(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmAbout::FormCreate(TObject *Sender)
{
  AnsiString Language;
  TRegistry *Reg = new TRegistry(KEY_READ);
  try{
        Reg->RootKey =HKEY_LOCAL_MACHINE;
        Reg->Access=KEY_READ;
        Reg->OpenKey("SOFTWARE\\INTEP\\ASKUE", False);
        Language = Reg->ReadString("Language");
        if(!Language.Length()){
                char c[256];
                GetLocaleInfo(GetSystemDefaultLCID(), LOCALE_SABBREVLANGNAME, c, sizeof(c));
                Language=c;
        }
        }__finally{
                delete Reg;
  }
  lbVersion->Caption="Версия "+GetFileVerInfo(Application->ExeName).vver;
  if (Language=="UKR")
  lbVersion->Caption="Версiя "+GetFileVerInfo(Application->ExeName).vver;
  try{
    if (Language!="UKR"){
    if(FileExists(ExtractFilePath(Application->ExeName)+AnsiString("askue.jpg")))
      Image1->Picture->LoadFromFile(ExtractFilePath(Application->ExeName)+AnsiString("askue.jpg"));
      }else{
    if(FileExists(ExtractFilePath(Application->ExeName)+AnsiString("askue_ukr.jpg")))
      Image1->Picture->LoadFromFile(ExtractFilePath(Application->ExeName)+AnsiString("askue_ukr.jpg"));
      else{//если нету то грузим русский (например на машинах со старыми версиями)
        if(FileExists(ExtractFilePath(Application->ExeName)+AnsiString("askue.jpg")))
                Image1->Picture->LoadFromFile(ExtractFilePath(Application->ExeName)+AnsiString("askue.jpg"));
      }
      }
  }catch(Exception&e){
      Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmAbout::FormKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
  if(Key==27)
    Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmAbout::Label2Click(TObject *Sender)
{
  //ShellExecute(Handle,"open","http://www.intep.in.ua",0,0,SW_SHOW);

}
//---------------------------------------------------------------------------

