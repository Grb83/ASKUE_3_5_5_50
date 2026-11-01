//---------------------------------------------------------------------------
#include <vcl.h>
#include <utilcls.h>
#include <string.h>
#include <fcntl.h>
#include <io.h>
#include <sys\stat.h>
#include <FileCtrl.hpp>
#pragma hdrstop
#include "InteriorPLTable.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "SupperMain.h" // Add KAS 17.07.2001
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
__fastcall TInteriorPLTable::TInteriorPLTable(TComponent* Owner,TSplitterForm *aSP,TFormDescr* aFD,Classes::TNotifyEvent OnProgr):
	TInterior(Owner,aSP,aFD,OnProgr )
{

  if( !dynamic_cast<TWinControl*>(Owner) )
  {
    OnProgressBarStepBy(NULL);
    throw(Exception(Reconst_smes127_1));
  }
  OnProgressBarStepBy(NULL);
  try
  {

     FInUn = new TfmInteriorUni(Owner,aFD);

     SplitterForm->Font=FormSetupMonitors->REdPLSQLRep->Font;

     //e Назначаем для него свойства
     OnProgressBarStepBy(this);//10
  }
  catch(Exception &exception)
  {
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
//GRB ADD 23.01.2019
__fastcall TInteriorPLTable::TInteriorPLTable(TComponent* Owner,TSplitterForm *aSP,TFormDescr* aFD,Classes::TNotifyEvent OnProgr, int tableNumber):
	TInterior(Owner,aSP,aFD,OnProgr )
{

  if( !dynamic_cast<TWinControl*>(Owner) )
  {
    OnProgressBarStepBy(NULL);
    throw(Exception(Reconst_smes127_1));
  }
  OnProgressBarStepBy(NULL);
  try
  {

     FInUn = new TfmInteriorUni(Owner,aFD, tableNumber);

     SplitterForm->Font=FormSetupMonitors->REdPLSQLRep->Font;

     //e Назначаем для него свойства
     OnProgressBarStepBy(this);//10
  }
  catch(Exception &exception)
  {
    Application->ShowException(&exception);
  }
}

//---------------------------------------------------------------------------
void __fastcall TInteriorPLTable::Place(void)
{
  try
  {
    //Имя
    AnsiString prStr = fd->NameForm + Reconst_smes127_2 + fd->NameGroup;
    //e Имя
    dynamic_cast<TBaseMonitorForm*>(Owner)->Caption = prStr;
    dynamic_cast<TBaseMonitorForm*>(Owner)->HelpContext = 31;

      SplitterForm->AddChild(NULL, FInUn, alClient);
    OnProgressBarStepBy(this);//20

    //Загружаем файл

      FInUn->vRefresh(this);
    //e Загружаем файл

    OnProgressBarStepBy(NULL);
  }catch(Exception &e){

    OnProgressBarStepBy(NULL);
    throw;
  }
}

//---------------------------------------------------------------------------
__fastcall TInteriorPLTable::~TInteriorPLTable(void)
{
   if(FInUn)
     delete FInUn;
}
//---------------------------------------------------------------------------
void __fastcall TInteriorPLTable::Invalidate(int Table)
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
void __fastcall TInteriorPLTable::PrintRep()
{
   FInUn->PrintData(this,"");

}
//---------------------------------------------------------------------------

void __fastcall TInteriorPLTable::SaveRepToFile(TSaveDialog *aSaveDialog)
{
   FInUn->vSaveToFile(this,"");

}
//GRB ADD
//-------------------------------------------------------------------------------
void __fastcall TInteriorPLTable::SaveMultyTableToFile(TSaveDialog *aSaveDialog)
{
   FInUn->SaveMultyTableToFileClick(aSaveDialog);

}
//-------------------------------------------------------------------------------



