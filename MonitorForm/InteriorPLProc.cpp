//---------------------------------------------------------------------------
#include <vcl.h>
#include <utilcls.h>
#include <string.h>
#include <fcntl.h>
#include <io.h>
#include <sys\stat.h>
#include <FileCtrl.hpp>
#pragma hdrstop
#include "InteriorPLProc.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
static char DOS_PRINT_TEMP_FILE_NAME[ 200 ] = "TempRep";

template <class T> T* _getAddress(T& object)
{
     return reinterpret_cast<T*>(&reinterpret_cast<int&>(object));
}
//---------------------------------------------------------------------------
__fastcall TInteriorPLProc::TInteriorPLProc(TComponent* Owner,TSplitterForm *aSP,TFormDescr* aFD,Classes::TNotifyEvent OnProgr):
	TInterior(Owner,aSP,aFD,OnProgr )
{
  if( !dynamic_cast<TWinControl*>(Owner) )
  {
    OnProgressBarStepBy(NULL);
    throw(Exception(Reconst_smes123_1));
  }
  OnProgressBarStepBy(NULL);
  try
  {
     REdit = new TRichEdit(Owner);
     //Назначаем для него свойства
     SplitterForm->Font=FormSetupMonitors->REdPLSQLRep->Font;
     REdit->ReadOnly = true;
     REdit->WordWrap = false;
     REdit->ScrollBars=ssBoth;
     //e Назначаем для него свойства
     OnProgressBarStepBy(this);//10
  }
  catch(Exception &exception)
  {
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TInteriorPLProc::Place(void)
{
  try
  {
    //Имя
    AnsiString prStr = fd->NameForm + Reconst_smes123_2 + fd->NameGroup;
    //e Имя
    dynamic_cast<TBaseMonitorForm*>(Owner)->Caption = prStr;
    dynamic_cast<TBaseMonitorForm*>(Owner)->HelpContext = 31;
    SplitterForm->AddChild(NULL, REdit, alClient);
    OnProgressBarStepBy(this);//20

    //Загружаем файл
    LoadReportData(REdit);
    //e Загружаем файл

    OnProgressBarStepBy(NULL);
  }catch(Exception &e){
   
    OnProgressBarStepBy(NULL);
    throw;
  }
}
//---------------------------------------------------------------------------
__fastcall TInteriorPLProc::~TInteriorPLProc(void)
{
  if(REdit)
     delete REdit;
}
//---------------------------------------------------------------------------
void __fastcall TInteriorPLProc::Invalidate(int Table)
{
  if(Table==1 /*PROFILE*/)
  {
    dynamic_cast<TBaseMonitorForm*>(Owner)->Cursor = crHourGlass;
    //Возможно, обновление
    //e Возможно, обновление
    dynamic_cast<TBaseMonitorForm*>(Owner)->Cursor = crDefault;
    OnProgressBarStepBy(NULL);
  }
}
//---------------------------------------------------------------------------
void __fastcall TInteriorPLProc::UnivPrintRep(TComponent* Owner,int lMode,TRichEdit* reTmp)
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
     AnsiString prTmp = ExtractFilePath(Application->ExeName) + DOS_PRINT_TEMP_FILE_NAME;
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
                throw Exception(Reconst_smes123_3+S);
         }
         delete PrDialog;
     }catch(Exception &e){
        delete PrDialog;
        Application->ShowException(&e);
     }
  }
}
//---------------------------------------------------------------------------
void __fastcall TInteriorPLProc::UnivSaveRepToFile(TSaveDialog *aSaveDialog,TRichEdit* reTmp)
{
   aSaveDialog->Title = Reconst_smes123_4;
   aSaveDialog->DefaultExt = "txt";
   aSaveDialog->Filter = Reconst_smes123_5;
   if(aSaveDialog->Execute())
   {
      if(aSaveDialog->FilterIndex == 1)
         reTmp->Lines->SaveToFile(aSaveDialog->FileName); //rtf вариант
      else  //Пишем в файл
         WriteRepToFile(aSaveDialog->FileName, 3 - aSaveDialog->FilterIndex,reTmp);
   }
}
//---------------------------------------------------------------------------
void __fastcall TInteriorPLProc::PrintRep()
{
  UnivPrintRep(this,FormSetupMonitors->RGrPrintMode->ItemIndex,REdit);
}
//---------------------------------------------------------------------------
void __fastcall TInteriorPLProc::WriteRepToFile(AnsiString PPName, int PPPrintMode,TRichEdit* reTmp)
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
   //GRB CHANGE SAVE TO FILE CSV MORE PRECISELY 12.11.2018  where prMStr=StringReplace(prMStr,":",";",Flags);
   //FIRST ADDED THIS
   bool isStick = isStickCharInReport(reTmp,PPPrintMode);
   //END OF
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

      // static
       TReplaceFlags Flags;
       Flags<<rfReplaceAll;
       //GRB ADD 12.11.2018
       if (PPPrintMode==-1){   //CSV
        if (isStick){
        if (prMStr.AnsiPos("|")==0) { //нету палки - считаем что это шапка и выводим как есть
                write(prLogFileH, prMStr.c_str(), strlen(prMStr.c_str()));
                continue;
        }
        else{   //нашли хотя бы одну палку - меняем её на разделитель ;
          prMStr=StringReplace(prMStr,"|",";",Flags);
        }
        }else{ //нету вообще во всём в тексте палок
          prMStr=StringReplace(prMStr,":",";",Flags);//оставляем по-старому
        }
        }
        //END OF ADD

        //OLD BLOCK TO REPLACE ADD WAS
        /*
        if (PPPrintMode==-1){
       //  prMStr=StringReplace(prMStr,":",char(9),Flags);
        prMStr=StringReplace(prMStr,":",";",Flags);
        } */

        //END OF BLOCK
           write(prLogFileH, prMStr.c_str(), strlen(prMStr.c_str()));
   }
   close( prLogFileH );
}
//---------------------------------------------------------------------------
void __fastcall TInteriorPLProc::SaveRepToFile(TSaveDialog *aSaveDialog)
{
  UnivSaveRepToFile(aSaveDialog,REdit);
}
//---------------------------------------------------------------------------
void __fastcall TInteriorPLProc::LoadReportData(TRichEdit* reData)
{
  reData->Lines->BeginUpdate();
  reData->Clear();
  dmMain->oqInterCursor->Params->Clear();
  dmMain->oqInterCursor->SQL->Text="begin "+SchemeName+"interior_pg.PLProc_LoadReportData_p(:par1); end;";
  dmMain->oqInterCursor->ParamByName("par1")->ParamType=ptOutput;
  dmMain->oqInterCursor->ParamByName("par1")->DataType=ftCursor;

  dmMain->oqInterCursor->Execute();
  while(!dmMain->oqInterCursor->Eof){
    reData->Lines->Add(dmMain->oqInterCursor->FieldByName("vtext")->AsString);
    dmMain->oqInterCursor->Next();
  }
  dmMain->oqInterCursor->Close();
  reData->Lines->EndUpdate();
  reData->SelStart=0;

  dmMain->qwInter->SQL->Text="begin "+SchemeName+"filereport_pg.clear_table; end;";
  dmMain->qwInter->Execute();
}
//---------------------------------------------------------------------------
bool __fastcall TInteriorPLProc::isStickCharInReport (TRichEdit* reTmp, int PPPrintMode){
   for(int i=0; i < reTmp->Lines->Count; i++)
   {
      AnsiString prMStr = reTmp->Lines->Strings[i]+"\n";
      if(!PPPrintMode){
         char prChs[5000];
         CharToOem(
            (LPCSTR)(prMStr.c_str()),	// pointer to string to translate
            (LPSTR)prChs 	// pointer to translated string
         );
         prMStr = prChs;      }

      // static
       TReplaceFlags Flags;
       Flags<<rfReplaceAll;
       if (PPPrintMode==-1){
          prMStr=StringReplace(prMStr,":",";",Flags);
       }
    if (prMStr.AnsiPos("|")!=0) return true;
   }
   return false;
}
//---------------------------------------------------------------------------




