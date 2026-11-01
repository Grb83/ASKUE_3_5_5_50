//---------------------------------------------------------------------------

#include <vcl.h>
#include <Registry.hpp>
#include <IniFiles.hpp>
#include <stdio.h>
#include <process.h>
#include <errno.h>
#pragma hdrstop
#include "uOraDBConnection.h"
#include "unDataMod.h"
#include "unAbout.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma resource "*.dfm"
TfmConnect *fmConnect = NULL;
int KeyVer;
//---------------------------------------------------------------------------
TConnectParams::TConnectParams(){
    UpdateVersion = false;
    rKey="\\Software\\HARTEP\\ASKUE\\CONN";
}
//---------------------------------------------------------------------------
TConnectParams::TConnectParams(bool aUpdateVertion){
    UpdateVersion = aUpdateVertion;
    rKey="\\Software\\HARTEP\\ASKUE\\CONN";
}
//---------------------------------------------------------------------------
TConnectParams::TConnectParams(bool aUpdateVertion,AnsiString arKey){
    UpdateVersion = aUpdateVertion;
    rKey=arKey;
}
//---------------------------------------------------------------------------
bool DoConnect(TOraSession* OraSession)
{
 AnsiString error="";
 KeyVer=0;

  if(OraSession->Connected)
    return true;
  //проверяем параметры командной строки
  OraSession->ConnectString="";
  try{
    if(ParamCount()>=3){
      NameUser=ParamStr(1);
      Password=ParamStr(2);
      OraSession->Server = ParamStr(3);
      OraSession->Username=NameUser;
      OraSession->Password=Password;
      if(ParamStr(4)=="v")
        KeyVer=1;
      OraSession->Connect();
    }
  }catch (Exception &e){
    OraSession->Disconnect();
    error = e.Message;
  }
  if (OraSession->Connected)
    return true;
  //выводим форму ввода параметров соединения
  if (fmConnect->ShowModal() == mrOk){
    OraSession->Server    = fmConnect->dbName;
    NameUser=fmConnect->dbUser;
    Password=fmConnect->dbPasswd;
    OraSession->Username=NameUser;
    OraSession->Password=Password;
    try{
      OraSession->Connect();
    }catch (Exception &e){
      OraSession->Disconnect();
      Application->MessageBox(e.Message.c_str(),Application->Title.c_str(),MB_OK | MB_ICONERROR);
      error = e.Message;
    }
  }
  // start added by KAG
  if (error.AnsiPos("ORA-01017")!=0)
  {
    AnsiString mess = "\n Выполнена попытка несанкционированного входа в систему от имени '"+OraSession->Username+"'";
    char *names[256]  = {mess.c_str()};
    HANDLE hEventSource = RegisterEventSource(NULL,"АРМ АСКУЭ");
    ReportEvent(hEventSource, // handle returned by RegisterEventSource
        EVENTLOG_AUDIT_FAILURE,  // event type to log
        0, // event category
        0, // event identifier
        NULL, // user security identifier (optional)
        1, // number of strings to merge with message
        0, // size of binary data, in bytes
        (LPCTSTR*)names, // array of strings to merge with message
        NULL // address of binary data
    );
    DeregisterEventSource(hEventSource);// Отключаемся от журнала событий
  }
  // end added by KAG

  return OraSession->Connected;
}
//---------------------------------------------------------------------------
bool ConnectDB(TOraSession* OraSession, TConnectParams* ConnectParams)
{
  bool res;
  fmConnect  = new TfmConnect(NULL,ConnectParams);
  try{
    res = DoConnect(OraSession);
    if(!res)
      return false;
  }__finally{
   delete fmConnect;
   fmConnect = NULL;
  }
  return res;
}
//---------------------------------------------------------------------------
__fastcall TfmConnect::TfmConnect(TComponent* Owner,TConnectParams* ConnectParams)
        : TForm(Owner), FdbName(""), FdbUser(""), FdbPasswd("")
{
  FConnectParams=ConnectParams;
}
//---------------------------------------------------------------------------
void __fastcall TfmConnect::ConnectBtnClick(TObject *Sender)
{

  dbNameEdit->Text  = dbNameEdit->Text.Trim();
  if (!dbNameEdit->Text.Length())
  { dbNameEdit->SetFocus();
    return;
  }
  dbUserEdit->Text  = dbUserEdit->Text.Trim();
  if (!dbUserEdit->Text.Length())
  { dbUserEdit->SetFocus();
    return;
  }
  FdbName   = dbNameEdit->Text;
  FdbUser   = dbUserEdit->Text;
  FdbPasswd = dbPasswdEdit->Text;



  TStringList *valNames = new TStringList();
  TRegistry   *reg      = new TRegistry;
  try
  { reg->RootKey  = HKEY_CURRENT_USER;
    if (reg->OpenKey(FConnectParams->rKey, true))
    { reg->GetValueNames(valNames);
      for (int i = 0; i < valNames->Count; i++)
        reg->DeleteValue(valNames->Strings[i]);
      for (int i = 0; i < ProfileCBox->Items->Count; i++)
        reg->WriteString("TnsUser" + IntToStr(i), ProfileCBox->Items->Strings[i]);
      if (ProfileCBox->Items->IndexOf(dbName + " - " + dbUser) < 0)
        reg->WriteString("TnsUser" + IntToStr(ProfileCBox->Items->Count), dbName + " - " + dbUser);
      reg->WriteString("UserName", dbUser);
      reg->WriteString("Tns", dbName);
      reg->CloseKey();
      valNames->Clear();
    }
  }
  __finally{
    delete  reg;
    delete  valNames;
  }
  ModalResult = mrOk;
}
//---------------------------------------------------------------------------
void __fastcall TfmConnect::FormCreate(TObject *Sender)
{
  TStringList *valNames = new TStringList();
  TRegistry   *reg      = new TRegistry;
  try
  { ProfileCBox->Items->Clear();
    reg->RootKey  = HKEY_CURRENT_USER;
    if (reg->KeyExists(FConnectParams->rKey))
    { if (reg->OpenKey(FConnectParams->rKey, false))
      { valNames->Clear();
        reg->GetValueNames(valNames);
        for (int i = 0; i < valNames->Count; i++)
        { if (valNames->Strings[i].SubString(1,7) == "TnsUser")
            ProfileCBox->Items->Add(reg->ReadString(valNames->Strings[i]));
        }
        dbUser    = reg->ReadString("UserName");
        dbPasswd  = "";
        dbName    = reg->ReadString("Tns");
        reg->CloseKey();
      }
    }
    if (ProfileCBox->Items->Count)
    { int index = ProfileCBox->Items->IndexOf(dbName + " - " + dbUser);
      ProfileCBox->ItemIndex  = index < 0 ? 0 : index;
    }
  }
  __finally{
    delete  reg;
    delete  valNames;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmConnect::ProfileCBoxChange(TObject *Sender)
{
  if (ProfileCBox->ItemIndex < 0)
    return;
  AnsiString  s;

  s = ProfileCBox->Items->Strings[ProfileCBox->ItemIndex];
  dbName  = s.SubString(1, s.Pos(" - ") - 1);
  dbUser  = s.SubString(s.Pos(" - ") + 3, s.Length());
  ActiveControl = dbPasswdEdit;
}
//---------------------------------------------------------------------------
void __fastcall TfmConnect::FormShow(TObject *Sender)
{
  if (ProfileCBox->Items->Count)
    dbPasswdEdit->SetFocus();
  else
    dbNameEdit->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TfmConnect::ProfileDeleteBtnClick(TObject *Sender)
{
  int index = ProfileCBox->ItemIndex;
  if (ProfileCBox->ItemIndex > -1)
    ProfileCBox->Items->Delete(ProfileCBox->ItemIndex);
  if (index != 0)
    ProfileCBox->ItemIndex  = index - 1;
  else
  { if (ProfileCBox->Items->Count != 0)
      ProfileCBox->ItemIndex  = ProfileCBox->Items->Count - 1;
    else
      ProfileCBox->Refresh();
  }
}
//---------------------------------------------------------------------------

void ReplaceRyda(TComponent *f,AnsiString sts,AnsiString std)
{
  if (sts.UpperCase()==std.UpperCase())
    return;
  TCustomDADataSet *d;
  for(int i=0; i<f->ComponentCount; i++){
    if(d=dynamic_cast<TCustomDADataSet*>(f->Components[i])){
      d->SQL->Text=ReplaceRyda(d->SQL->Text,sts,std);
      d->SQLInsert->Text=ReplaceRyda(d->SQLInsert->Text,sts,std);
      d->SQLUpdate->Text=ReplaceRyda(d->SQLUpdate->Text,sts,std);
      d->SQLDelete->Text=ReplaceRyda(d->SQLDelete->Text,sts,std);
    }
  }
}
//---------------------------------------------------------------------------
AnsiString ReplaceRyda(AnsiString s,AnsiString sts,AnsiString std)
{
  sts=sts.UpperCase();
  std=std.UpperCase();
  if (sts==std)
    return s;
  s=s.UpperCase();
  int k,len=sts.Length();
  while((k=s.Pos(sts))>0)
    s=s.SubString(1,k-1)+std+s.SubString(k+len,s.Length()-k+1-len);
  return s;
}
//---------------------------------------------------------------------------


