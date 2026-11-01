//---------------------------------------------------------------------------

#include <vcl.h>
#include <FileCtrl.hpp>
#include <io.h>
#include <fcntl.h>
#include <sys\stat.h>
#pragma hdrstop
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#include <process.h>
#include <errno.h>
#include <stdio.h>
#include <Math.hpp>
//---------------------------------------------------------------------------
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min(a, b)  (((a) < (b)) ? (a) : (b))
//---------------------------------------------------------------------------
#include "unDataMod.h"
#include "unAbout.h"
#include "unitperm.h"
//---------------------------------------------------------------------------
#define SAA_MAXCOUNFILES 128
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Ora"
#pragma link "MemDS"
#pragma link "OraScript"
#pragma link "DBAccess"
#pragma link "OdacVcl"
#pragma resource "*.dfm"
TdmMain *dmMain;
//---------------------------------------------------------------------------
AnsiString NameUser;
AnsiString Password;

//---------------------------------------------------------------------------
SCONNECT UsCon;
//Надо удалить
SROLS UserRol;
//
AnsiString ExFileFullName; // Переменная используется для передачи пути файла-шаблона Excel + его имя
AnsiString ExFilePuth; // Переменная используется для передачи пути файла-шаблона Excel
AnsiString SchemeName;
long customer_id;
long period; //текущий период
AnsiString ObsoleteTimeLimit;// Интервал времени после которого данные считаются устаревшими
                             // т.е. если дата данных в curr_power отличается от максимальной даты на
                             // ObsoleteTimeLimit то данные устарели и не выводятся
AnsiString EnterpriseName;
int StepPROFILE; //Минимальный шаг профиля в секундах (int)(300)	//10 минут
int LenPROFILE; //Длинна минутного профиля в секундах 28800
int PowerProfile; // Количество строк при выводе графика нагрузки
int PowerCoeff; // Коэффициент представления данных в мониторах
int ShowValidity;
int RateZona;//Тарифные зоны
//int IsShiftRateZona; //Есть ли переход зима-лето, если есть,то 1
int TimeZona;//Часовой пояс
int TimeZonaMid;//Id Часовой пояс
int IsShiftTimeZona;//Есть ли переход зима-лето, если есть,то 1
//---------------------------------------------------------------------------
AnsiString GetRas(AnsiString spred,AnsiString scurr,AnsiString sdig,AnsiString skc,bool &conv,double &proc)
{
    double dpred,dcurr,dkc,ddig;
    double dadd=0;
    conv=false;
    proc=0;

    if(scurr.IsEmpty()) return "";
    dcurr=scurr.ToDouble();
    if(dcurr<0)
        throw Exception(Reconst_smes68_1);

    if(spred.IsEmpty()){
        return "0";
    }
    dpred=spred.ToDouble();
    dkc=skc.ToDouble();

    if(sdig.IsEmpty())
        ddig=Power(10,IntToStr(max(abs((long)dpred),abs((long)dcurr))).Length());
    else
        ddig=Power(10,IntToStr((long)sdig.ToDouble()).Length());

    if(dcurr<dpred){
        dadd=ddig;
        conv=true;
    }
    proc=100.0*(dadd+dcurr-dpred)/ddig;
    return FormatFloat("#######0.00",(dadd+dcurr-dpred)*dkc);
}
//---------------------------------------------------------------------
AnsiString SAATrim(AnsiString Str)
{
    for(int i=1; i<=Str.Length(); i++){
        if(Str[i]==' ')
            Str.Delete(i--,1);
    }
    if ((Str.Length()==1)&&(Str[1]=='.'))
        Str="";
    return(Str);
}
//---------------------------------------------------------------------
void SetStringInfo(TStrings *st,AnsiString s,AnsiString field1,AnsiString field2,TOraQuery *quTmp)
{
    quTmp->Params->Clear();
    quTmp->SQL->Text=s;
    quTmp->Execute();
    st->Clear();
    while(!quTmp->Eof){
      st->AddObject(quTmp->FieldByName( field2)->AsString, (TObject *)quTmp->FieldByName( field1)->AsInteger);
      quTmp->Next();
    }
    quTmp->Close();
}
//---------------------------------------------------------------------------
TVerInfo GetFileVerInfo(AnsiString filename)
{
    TVerInfo VerInf;
    VS_FIXEDFILEINFO **lpBuffer = NULL;
    DWORD k,d;
    unsigned int zz;
    LPVOID lpData = NULL;

    try{
        d=GetFileVersionInfoSize(filename.c_str(),&k);
        lpData = new char[d];
        lpBuffer = new VS_FIXEDFILEINFO*[1];
        if((GetFileVersionInfo(filename.c_str(),NULL,d,lpData) &&
            VerQueryValue(lpData,"\\",(void**)lpBuffer,&zz)))
        {
            VerInf.HVer=lpBuffer[0]->dwFileVersionMS;
            VerInf.LVer=lpBuffer[0]->dwFileVersionLS;
            VerInf.vver=IntToStr(HIWORD(VerInf.HVer))+"."+IntToStr(LOWORD(VerInf.HVer))+"."+
                IntToStr(HIWORD(VerInf.LVer))+"."+IntToStr(LOWORD(VerInf.LVer));
        }else{
            VerInf.HVer=0;
            VerInf.LVer=0;
            VerInf.vver="";
        }
        delete []lpBuffer;
        delete []lpData;
    }catch(Exception&e){
        if(lpBuffer) delete []lpBuffer;
        if(lpData) delete []lpData;
    }
    return VerInf;
}
//---------------------------------------------------------------------------
void InitGlobalVariable(void)
{
    DecimalSeparator='.';
    ShortDateFormat="dd.mm.yyyy";
    //ShortTimeFormat="hh:mm:ss";
    //LongTimeFormat="hh:mm:ss";
    DateSeparator='.';
    TimeSeparator=':';
    // Загрузка курсоров для опрераций Drag&Drop
    Screen->Cursors[crDragCopy] = LoadCursor(HInstance, "DRAGDROPCOPY");
    Screen->Cursors[crDragUsd] = LoadCursor(HInstance, "DRAGDROPUSD");
    Screen->Cursors[crDragMain] = LoadCursor(HInstance, "DRAGDROPMAIN");
}
//---------------------------------------------------------------------------
__fastcall TdmMain::TdmMain(TComponent* Owner)
  : TDataModule(Owner)
{
  TIniFile *unpackvr;
  try{
    unpackvr = new TIniFile(ExtractFilePath(Application->ExeName)+"UnPackVr.ini");
    SchemeName = unpackvr->ReadString("VERSIONINFO","CHEMANAME","RYDA")+".";
  }__finally{
    delete unpackvr;
  }
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
  FSrvList =new TStringList();

  PointCnt=0;

/*#if CHK_ALL_LIMITS==1 //Проверка ограничений
  FLicType=GrdGetPermission(CHK_LIC_TYPE,0);
  if(FLicType<0){
    tmStatus->Enabled=true;
    throw Exception("В доступе отказано: "+IntToStr(FLicType)+","+IntToStr(CHK_LIC_TYPE)+",0");
  }
#else*/
  /*FLicType=1;*/
/*#endif*/
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::DataModuleCreate(TObject *Sender)
{
  TRegistry *Reg = new TRegistry;
  Reg->Access=KEY_READ;
  Reg->RootKey = HKEY_LOCAL_MACHINE;
  if (!Reg->OpenKey("SOFTWARE\\Grant\\Ascue",false)||Reg->ReadString("ExTemplateDir").IsEmpty()){
       MessageDlg(Reconst_smes68_2,
            mtInformation, TMsgDlgButtons() << mbOK, 0);
       ExFilePuth = "C:\\";
  }else
    ExFilePuth=Reg->ReadString("ExTemplateDir");
  delete Reg;
  if(!DirectoryExists(ExFilePuth))
    CreateDirectory(ExFilePuth.c_str(),NULL);

  VerInf=GetFileVerInfo(Application->ExeName);
  TConnectParams ConnectParams;
  if(!ConnectDB(orases, &ConnectParams)){
    Application->Terminate();
    return;
  }
  try{
    CheckLicPoint();
  }catch(Exception &e){
    if(orases->Connected)
      orases->Disconnect();
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::DataModuleDestroy(TObject *Sender)
{
  if(orases->Connected){
    try{
      quMain->SQL->Text= " begin  \
         if "+SchemeName+"common_pg.username_f is not null then  \
           "+SchemeName+"admin_pg.fiscal_p(NULL, 3, 'Произведен выход из системы с компьютера: '||USERENV('TERMINAL')); \
           commit; \
         end if; \
        end;  " ;
      quMain->Execute();
    }catch(Exception &e){
    }
    orases->Disconnect();
  }
  if(FSrvList)
    delete FSrvList;
}
//---------------------------------------------------------------------------
TDateTime __fastcall TdmMain::FSystemDate(void)
{
  static double d;
  static TDateTime t=TDateTime(2000,1,1);
  try{
      if(abs(t-Now())>0.01){
        qwUtil->SQL->Text="SELECT SYSDATE D FROM DUAL";
        qwUtil->Open();
        t=qwUtil->FieldByName("D")->AsDateTime;
        qwUtil->Close();
        d=t-Now();
      }
    }catch(Exception &e){
      Application->ShowException(&e);
      Application->Terminate();
  }
  return Now()+d;
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::orasesAfterConnect(TObject *Sender)
{
  try{
     oqCursor->Params->Clear();
     oqCursor->SQL->Text="begin "+SchemeName+"admin_pg.get_user(:par1,:par2); end;";
     oqCursor->ParamByName("par1")->AsString = NameUser.UpperCase();
     oqCursor->ParamByName("par2")->ParamType = ptOutput;
     oqCursor->ParamByName("par2")->DataType = ftCursor;
     oqCursor->Execute();
     if(oqCursor->Eof)
      throw Exception(Reconst_smes68_3+NameUser+Reconst_smes68_4);
     UsCon.User_Id=oqCursor->FieldByName("user_id")->AsInteger;
     UsCon.UserName=NameUser.UpperCase();
     UsCon.Pasword=orases->Password;
     UsCon.uName=oqCursor->FieldByName("name")->AsString;
     UsCon.Admin=(oqCursor->FieldByName("admin")->AsString=="*")?1:0;
     UsCon.Role_Id=oqCursor->FieldByName("role_id")->AsInteger;
     oqCursor->Params->Clear();
     oqCursor->SQL->Text="begin "+SchemeName+"admin_pg.get_lver(:par1); end;";
     oqCursor->ParamByName("par1")->ParamType = ptOutput;
     oqCursor->ParamByName("par1")->DataType = ftCursor;
     oqCursor->Execute();
     int lver=oqCursor->FieldByName("par")->AsInteger;
     if(lver==1&&!GetVerApp()){
      orases->Disconnect();
      return;
     }
     oqInit->ParamByName("par3")->AsInteger=UsCon.User_Id;
     oqInit->Execute();
     customer_id=oqInit->ParamByName("par1")->AsInteger;
     ObsoleteTimeLimit=oqInit->ParamByName("par2")->AsString+"/1440";
     EnterpriseName=oqInit->ParamByName("par4")->AsString;
     StepPROFILE=oqInit->ParamByName("par5")->AsInteger;
     LenPROFILE=oqInit->ParamByName("par6")->AsInteger;
     PowerProfile=oqInit->ParamByName("par7")->AsInteger;
     period=oqInit->ParamByName("par8")->AsInteger;
     AnsiString sWar=oqInit->ParamByName("par9")->AsString;
     PointCnt=oqInit->ParamByName("par10")->AsInteger;
     FCanManualOperPoint=oqInit->ParamByName("par11")->AsInteger;
     oqInit->Close();
     Application->Title=Reconst_smes68_5+EnterpriseName;
     oqCursor->Params->Clear();
     oqCursor->SQL->Text = "begin "+SchemeName+"COMSRVDISP_PG.get_srv_info(:par1); end;";
     oqCursor->ParamByName("par1")->ParamType = ptOutput;
     oqCursor->ParamByName("par1")->DataType = ftCursor;
     oqCursor->Execute();
     while(!oqCursor->Eof){
      FSrvList->AddObject(oqCursor->FieldByName("vname")->AsString,(TObject*)oqCursor->FieldByName("nsrv")->AsInteger);
      oqCursor->Next();
     }
     oqCursor->Close();
     if(!sWar.IsEmpty())
      Application->MessageBox(sWar.c_str(),Application->Title.c_str(),MB_OK | MB_ICONWARNING);
  }catch(Exception &e){
    orases->Disconnect();
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::orasesBeforeConnect(TObject *Sender)
{
  fmAbout->Show();
  fmAbout->Repaint();
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::UnivSaveRepToFile(TSaveDialog *aSaveDialog,TRichEdit* reTmp)
{
   aSaveDialog->Title = Reconst_smes68_6;
   aSaveDialog->DefaultExt = "txt";
   aSaveDialog->Filter = Reconst_smes68_7;
   if(aSaveDialog->Execute())
   {
      if(aSaveDialog->FilterIndex == 1)
         reTmp->Lines->SaveToFile(aSaveDialog->FileName); //rtf вариант
      else  //Пишем в файл
         WriteRepToFile(aSaveDialog->FileName, 3 - aSaveDialog->FilterIndex,reTmp);
   }
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::UnivPrintRep(TComponent* Owner,int lMode,TRichEdit* reTmp)
{
  if(lMode==1){
    TPrintDialog* PrDialog=NULL;
    PrDialog= new TPrintDialog(Owner);
    try{
      if(PrDialog->Execute())
          for(int i=0;i<PrDialog->Copies;i++)
              reTmp->Print("");
    }catch (Exception &e){
       delete PrDialog;
       throw;
    }
    delete PrDialog;
  }else{
     //Печать в DOS
       //Формируем файл в кодировке DOS
     AnsiString prTmp = GetTmpPath() + "askue.txt";
     WriteRepToFile(prTmp, 0,reTmp);
       //e Формируем файл в кодировке DOS
     AnsiString S,tmpstr;
     char ADevice[256],ADriver[256],APort[256];
     UINT ADeviceMode;
     TPrintDialog* PrDialog=NULL;
     PrDialog= new TPrintDialog(Owner);
     try
     {
         if(PrDialog->Execute())
         {
            if(GetVersion() < 0x80000000)
                S="CMD.EXE /c copy \""+prTmp+"\" \"";
            else
                S="COMMAND.COM /c copy \""+prTmp+"\" \"";

            Printer()->GetPrinter(ADevice,ADriver,APort,ADeviceMode);
            tmpstr=ADevice;
            if(tmpstr.SubString(0,2)!="\\\\"){
               tmpstr=APort;
            }
            S=S+tmpstr+"\"";
            if(WinExec(S.c_str(),SW_HIDE)<32)
                throw Exception(Reconst_smes68_8+S);
         }
         delete PrDialog;
     }catch(Exception &e){
        delete PrDialog;
        Application->ShowException(&e);
     }
  }
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::WriteRepToFile(AnsiString PPName, int PPPrintMode,TRichEdit* reTmp)
{
   int prLogFileH;
   char fullName[256];
   strcpy( fullName, PPName.c_str() );
   if((prLogFileH = open(
      fullName,
      O_RDWR|O_CREAT|O_TEXT|O_APPEND|O_TRUNC,
      S_IREAD|S_IWRITE
   ))==-1){
      perror("Error:");
      throw;
   }
   for(int i=0; i < reTmp->Lines->Count; i++)
   {
      AnsiString prMStr = reTmp->Lines->Strings[i]+"\n";
      if(!PPPrintMode){
         //Для случая DOS производим перекодировку
         char prChs[5000];
         CharToOem(
            (LPCSTR)(prMStr.c_str()),	// pointer to string to translate
            (LPSTR)prChs 	// pointer to translated string
         );
         prMStr = prChs;
         //e Для случая DOS производим перекодировку
      }
      write(prLogFileH, prMStr.c_str(), strlen(prMStr.c_str()));
   }
   close( prLogFileH );
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption)
{
  AnsiString s,fname;
  TStringList *StringList;
  TBookmark SavePlace;
  AnsiString  tab = char(9);
  AnsiString ExportSeparator;
  TSaveDialog *sd=new TSaveDialog(Owner);
  TDataSet  *ds = gr->DataSource->DataSet;
  if (!ds || !ds->Active){
    Application->MessageBox(Reconst_smes68_9.c_str(),Application->Title.c_str(),MB_OK | MB_ICONSTOP);
    return;
  }

  TRegistry *Reg = new TRegistry(KEY_READ);
      try
      {
        Reg->RootKey = HKEY_CURRENT_USER;
        Reg->Access = KEY_READ;
        Reg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", False);
        if(Reg->ValueExists("ExportSeparator"))
              ExportSeparator = ((Reg->ReadString("ExportSeparator") == ",") ? (",") : ("."));
        else
             ExportSeparator = (".");
      }
      __finally
      {
        delete Reg;
      }


  sd->Title = Reconst_smes68_10;
  sd->DefaultExt = "txt";
  sd->FileName=Reconst_smes68_11;
  sd->Filter = Reconst_smes68_12;
  sd->Options << ofOverwritePrompt;
  if(sd->Execute())
    fname=sd->FileName;
  else
    fname="";
  delete sd;
  if(fname.IsEmpty())
    return;

  try{
    StringList  = new TStringList;
    //Завголовок
    if(!RepCaption.IsEmpty())
      StringList->Add(RepCaption);
    s="";
    for (int i = 0; i < gr->Columns->Count; i++){
      if(gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
        if(!s.IsEmpty())
          s += tab;
        s+= gr->Columns->Items[i]->Title->Caption;
      }
    }
    StringList->Add(s);
    //Данные
    SavePlace = ds->GetBookmark();
    ds->DisableControls();
    ds->First();
    int cn  = 0;
    while (!ds->Eof){
      s="";
      for (int i = 0; i < gr->Columns->Count; i++){
        if (gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
          if(!s.IsEmpty())
            s += tab;
          if (gr->Columns->Items[i]->Field->DataType == ftDateTime)
            s += gr->Columns->Items[i]->Field->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
          else{
            if(gr->Columns->Items[i]->Field->DataType == ftFloat){
              if (ExportSeparator == ",")
                s += StringReplace(gr->Columns->Items[i]->Field->AsString,".",",",TReplaceFlags()<<rfReplaceAll);
              else
                s += StringReplace(gr->Columns->Items[i]->Field->AsString,",",".",TReplaceFlags()<<rfReplaceAll);
            }else
              s += gr->Columns->Items[i]->Field->AsString;
          }
        }
      }
      StringList->Add(s);
      cn++;
      ds->Next();
    }
    ds->GotoBookmark(SavePlace);
    ds->FreeBookmark(SavePlace);
    ds->EnableControls();
    StringList->SaveToFile(fname);
    delete  StringList;
    Application->MessageBox(AnsiString(AnsiString(Reconst_smes68_13) +
                              fname +
                              AnsiString(Reconst_smes68_14) +
                              IntToStr(cn) +
                              AnsiString(Reconst_smes68_15)).c_str(),
                            Application->Title.c_str(),
                            MB_OK | MB_ICONINFORMATION);
  }
  catch (Exception &e){
    delete  StringList;
    throw;
  }
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::SendToNotepad(TRichEdit* reTmp)
{
  TStrings *ls=new TStringList();
  try{
    AnsiString pname=GetTmpPath();
    AnsiString fname=pname + Reconst_smes68_16;
    ls->AddStrings(reTmp->Lines);
    ls->SaveToFile(fname);
    ShellExecute(NULL,"open","notepad.exe",fname.c_str(),NULL,SW_SHOWDEFAULT);
    delete ls;
  }catch(Exception &e){
    delete ls;
    throw;
  }
}
//---------------------------------------------------------------------------
AnsiString __fastcall TdmMain::GetTmpPath(void)
{
  LPTSTR lpMsgBuf;
  char tmpdir[256];
  if(!GetTempPath(sizeof(tmpdir),tmpdir)){
    FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,NULL,
      GetLastError(),MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),(LPTSTR) &lpMsgBuf, 0, NULL);
    throw Exception(AnsiString(lpMsgBuf));
  }
  AnsiString s=tmpdir;
  if(!DirectoryExists(s)&&!ForceDirectories(s))
    throw Exception(Reconst_smes68_17);
  s = (s.LastDelimiter("\\")==s.Length()?s:s+"\\");
  return s;
}
//---------------------------------------------------------------------------
bool __fastcall TdmMain::GetVerApp()
{
  bool needupdate=false;
  AnsiString fname;
  LPTSTR lpMsgBuf;
  FILETIME lpLastWriteTime,lpLastDBTime; 	// address of last write time in file Excel
  DWORD dwDateTime;
  HANDLE hFile=NULL;
  unsigned long readen;
  AnsiString sfname,sver;

 try{
    oqCursor->Params->Clear();
    oqCursor->SQL->Text="begin "+SchemeName+"admin_pg.get_version(:par1); end;";
    oqCursor->ParamByName("par1")->ParamType = ptOutput;
    oqCursor->ParamByName("par1")->DataType = ftCursor;
    oqCursor->Execute();
    int i=0;
    while(!oqCursor->Eof){
      sfname=oqCursor->FieldByName("vfilename")->AsString;
      sver=oqCursor->FieldByName("vversion")->AsString;
      oqCursor->Next();//Тут правильней
      fname=ExtractFilePath(Application->ExeName)+ExtractFileName(sfname);
      if(FileExists(fname)){
        hFile=CreateFile(fname.c_str(),GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL);
        if(hFile==INVALID_HANDLE_VALUE){
          FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
                                NULL,GetLastError(),MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                              (LPTSTR) &lpMsgBuf, 0, NULL);
          throw Exception(lpMsgBuf);
       }
        if(!GetFileTime(hFile, NULL, NULL, &lpLastWriteTime)){
          FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
                                NULL,GetLastError(),MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                               (LPTSTR) &lpMsgBuf, 0, NULL);
          throw Exception(lpMsgBuf);
       }
        CloseHandle(hFile);
        hFile=NULL;
        if(!sscanf(sver.SubString(1,sver.Pos("-")-1).c_str()," %u",&dwDateTime))
          throw Exception(Reconst_smes68_18+sfname);
        lpLastDBTime.dwLowDateTime=dwDateTime;
        if(!sscanf(sver.SubString(sver.Pos("-")+1,sver.Length()-sver.Pos("-")).c_str()," %u",&dwDateTime))
          throw Exception(Reconst_smes68_18+sfname);
        lpLastDBTime.dwHighDateTime=dwDateTime;

        if(lpLastWriteTime.dwHighDateTime==lpLastDBTime.dwHighDateTime){
          if(lpLastWriteTime.dwLowDateTime>=lpLastDBTime.dwLowDateTime&&lpLastWriteTime.dwLowDateTime-lpLastDBTime.dwLowDateTime<30000000)
           continue;
          if(lpLastWriteTime.dwLowDateTime<lpLastDBTime.dwLowDateTime&&lpLastDBTime.dwLowDateTime-lpLastWriteTime.dwLowDateTime<30000000)
            continue;
        }
      }
      i++;
      needupdate=true;
      break;
    }
    oqCursor->Close();

    int flag;
   if(needupdate){
   //-----------------------------------------------VNB 03.03.2008   Start
  if(KeyVer)
          flag=MB_YESNOCANCEL;
    else flag=MB_YESNO;
       switch( Application->MessageBox(Reconst_smes68_20.c_str(),
                        Application->Title.c_str(), flag|MB_ICONWARNING))
    {
         case ID_YES:
              {   orases->Disconnect();
               AnsiString S="*"+orases->Server+"*ASKUEV"+AnsiString("ER*AS")+"KVER*"+Application->ExeName+" "+NameUser+AnsiString(" ")+Password+AnsiString(" ")+orases->Server;
             if(execlp(AnsiString(ExtractFilePath(Application->ExeName)+"UnPackVr.exe").c_str(),AnsiString(ExtractFilePath(Application->ExeName)+"UnPackVr.exe").c_str(),S.c_str(),NULL)==-1){
             switch(errno){
               case EACCES: throw Exception(Reconst_smes68_21);
               case EMFILE: throw Exception(Reconst_smes68_22);
               case ENOENT: throw Exception(Reconst_smes68_23+ExtractFilePath(Application->ExeName)+"UnPackVr.exe'");
               case ENOEXEC: throw Exception(Reconst_smes68_24+ExtractFilePath(Application->ExeName)+"UnPackVr.EXE'"+Reconst_smes68_25);
               case ENOMEM: throw Exception(Reconst_smes68_26);
                default : throw Exception(Reconst_smes68_27);
               }
             }
                 return true;
             }
      case ID_CANCEL: return true;
      case ID_NO:  return true;/*GRB TEST CHANGE 23.04.2020*///return false;
    }
  }
  KeyVer=0;
  //-----------------------------------------------VNB 03.03.2008  Finish

 }catch(Exception &e){
    if(hFile||hFile==INVALID_HANDLE_VALUE)
      CloseHandle(hFile);
    throw;
  }
  return true;
}
//---------------------------------------------------------------------------
AnsiString TdmMain::GetStr(AnsiString LongStr,int Poz,AnsiString Razdel)
{
// AnsiString Razdel = "*";
 int i = 0;

 if (LongStr.Pos(Razdel)==0){
     if(Poz>0)
        return "";
     return LongStr;
 }
 while (LongStr.Pos(Razdel)!=0)
  {
   if (i==Poz)
	 {
	  return LongStr.SubString(1,LongStr.Pos(Razdel)-1);
	 }else LongStr = LongStr.SubString(LongStr.Pos(Razdel)+Razdel.Length(),LongStr.Length()-LongStr.Pos(Razdel));
   i++;
  }
  if(Poz>i) return "";
 return LongStr;
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::CheckLicPoint()
{
/*#if CHK_ALL_LIMITS==1 //Проверка ограничений
  if(!LicType){
    int licPointType=GrdGetPermission(CHK_LIC_POINT,0);
    if(licPointType<0||licPointType>=SAA_MAXLICPOINT||PointCnt>LicPoint[licPointType]){
      tmStatus->Enabled=true;
      Application->MessageBox("Нарушено лицензионное ограничение по количеству точек учета. Приложение будет закрыто через 1 минуту.",Application->Title.c_str(),MB_OK | MB_ICONWARNING);
    }
    if(licPointType<0)
      throw Exception("В доступе отказано: "+IntToStr(LicType)+","+IntToStr(CHK_LIC_POINT)+",0");
  }
#endif*/
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::tmStatusTimer(TObject *Sender)
{
  orases->Disconnect();
  orases->ConnectString="e";
  Application->Terminate();
}
//---------------------------------------------------------------------------
void __fastcall TdmMain::SetShiftTimeZona(TDateTime dd)
{
   oqCursor->Params->Clear();
   oqCursor->SQL->Text=" begin "+SchemeName+"interior_pg.get_timezoneshift(:par1,:par2,:par3); end;";
   oqCursor->ParamByName("par3")->DataType=ftInteger;
   oqCursor->ParamByName("par3")->ParamType=ptOutput;
   oqCursor->ParamByName("par1")->AsInteger=TimeZonaMid;
   oqCursor->ParamByName("par2")->AsDateTime=dd;
   oqCursor->Execute();
   IsShiftTimeZona=oqCursor->ParamByName("par3")->AsInteger;
}
//-------------------------------------------------------------------------------
void __fastcall TdmMain::SetCommandOff(long lmid,long lcmd)
{
  if(!lmid)
    return;

  AnsiString s;
  switch (lcmd){
    case 1:
      s="Отключить питание потребителя '";
      break;
     case 2: ;
      s="Вкллючить питание потребителя '";
      break;
     default:
      s="Отменить команду Отключения/Включения для '";
  }
  s=s+GetPointName(lmid)+"'?";

  if(Application->MessageBox(s.c_str(), Application->Title.c_str(), MB_YESNOCANCEL|MB_ICONQUESTION|MB_DEFBUTTON2)!=IDYES)
    return;
  oqCursor->Params->Clear();
  oqCursor->SQL->Text=" begin "+SchemeName+"editfeeders_pg.set_command_off(:lmid, :lcmd ); end;";
  oqCursor->ParamByName("lmid")->AsInteger=lmid;
  oqCursor->ParamByName("lcmd")->AsInteger=lcmd;
  oqCursor->Execute();
  Application->MessageBox("Команда выполнена.", Application->Title.c_str(), MB_OK|MB_ICONINFORMATION);
}
//-------------------------------------------------------------------------------
int __fastcall TdmMain::GetTaskRights(long roleid, long taskid)
{
  int rCode = TASK_RIGHTS_DISABLE;
  long  nAccess;
  try
  {
    try{
    //long  nAccess;
    //05.01.2022 GRB ADD
    InitializeCriticalSection(&CS);
    EnterCriticalSection(&CS);
    int   sCode;
    oqCursorUnic->Params->Clear();
    oqCursorUnic->SQL->Text="begin "+SchemeName+"admin_pg.get_task_rights(:par1,:par2,:par3); end;";
    oqCursorUnic->ParamByName("par1")->AsInteger= roleid;
    oqCursorUnic->ParamByName("par2")->AsInteger= taskid;
    oqCursorUnic->ParamByName("par3")->ParamType = ptOutput;
    oqCursorUnic->ParamByName("par3")->DataType = ftCursor;
    }catch (Exception &ex){
        AnsiString mess = "Беда перед вызовом admin_pg.get_task_rights(:par1,:par2,:par3) с параметрами roleid="+IntToStr (roleid)+" taskid="+ IntToStr(taskid);
        Application->MessageBox (mess.c_str(),Application->Title.c_str(),MB_OK);
    }
    try{
    oqCursorUnic->Execute();
    }catch (Exception &ex){
        AnsiString mess = "Беда при вызове admin_pg.get_task_rights(:par1,:par2,:par3) с параметрами roleid="+IntToStr (roleid)+" taskid="+ IntToStr(taskid);
        Application->MessageBox (mess.c_str(),Application->Title.c_str(),MB_OK);
    }
    try{
    nAccess = oqCursorUnic->FieldByName("nacc")->AsInteger;
    if (oqCursorUnic->Eof)
    { rCode = TASK_RIGHTS_DISABLE;
    }
    else
    { if (nAccess == TASK_RIGHTS_WRITE)
        rCode = TASK_RIGHTS_WRITE;
      else
        rCode = TASK_RIGHTS_READ;
    }
    oqCursorUnic->Close();
    LeaveCriticalSection(&CS);
    DeleteCriticalSection(&CS);
    }catch (Exception &ex){
        AnsiString mess = "Беда после вызовв admin_pg.get_task_rights(:par1,:par2,:par3) с параметрами nAccess="+IntToStr (nAccess);
        Application->MessageBox (mess.c_str(),Application->Title.c_str(),MB_OK);
        LeaveCriticalSection(&CS);
        DeleteCriticalSection(&CS);
    }
  }
  catch (Exception &e)
  { rCode = TASK_RIGHTS_ERROR;
  //07.10.2021 - GRB TEMP - ловим исключения
  Application->ShowException(&e);
  //END TEMP
  }

  return  rCode;
}
//-----------------------------------------------------------------------------
AnsiString __fastcall  TdmMain::GetPointName(long lmid,long ldetal,long lshow)
{
  AnsiString s;

  oqCursor->Params->Clear();
  oqCursor->SQL->Text=" select "+SchemeName+"util_pg.get_pointname(:lmid,:ldetal,:lshow) name from dual";
  oqCursor->ParamByName("lmid")->AsInteger=lmid;
  oqCursor->ParamByName("ldetal")->AsInteger=ldetal;
  oqCursor->ParamByName("lshow")->AsInteger=lshow;
  oqCursor->Execute();
  s=oqCursor->FieldByName("name")->AsString;
  oqCursor->Close();
  return s;
}
//-----------------------------------------------------------------------------

