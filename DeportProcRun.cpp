//---------------------------------------------------------------------------
#include <vcl.h>
#include <math.h>
#pragma hdrstop
#include "DeportProcsSched.h"
#include "SupperMain.h"
#include "DeportProcRun.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmDeportProcRun *fmDeportProcRun;
//---------------------------------------------------------------------------
__fastcall TfmDeportProcRun::TfmDeportProcRun(TComponent* Owner)
  : TForm(Owner)
{
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
}
//---------------------------------------------------------------------------
bool __fastcall CheckTimeInput( AnsiString PPVal, AnsiString PPNameStr )
{
  bool prB = TRUE;
  TDateTime prDT;
  AnsiString prStr;
  try
  {
    //Формируем значение как доу.
    prDT = StrToTime( PPVal + ":00" );
    //e Формируем значение как доу.
  }
  catch(Exception &exception)
  {
    prB = FALSE;
  }
  if ( !prB )
  {
    prStr = Reconst_smes10_1 + PPNameStr + "'.";
    Application->MessageBox
      (prStr.c_str(),Application->Title.c_str(),MB_OK	|MB_ICONERROR);
  }
  return prB;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcRun::BitBtn1Click(TObject *Sender)
{
  bool prCont = TRUE;
  if ( IsHour )
    prCont = CheckTimeInput( MEdTime->Text, Reconst_smes10_2 );
  if ( prCont )
  {
    //Вызов проц-ры
    TDateTime prTimeDT;

    if ( IsHour )
       prTimeDT = StrToTime( MEdTime->Text + ":00" );
    else
       prTimeDT = 0;

   TDateTime SprParDT;
   TDateTime FprParDT;

   if(!Panel4->Visible){
     SprParDT =(TDateTime) floor( DTPPar->Date ) + prTimeDT;
     FprParDT =(TDateTime)floor( DTPPar->Date ) + prTimeDT;
     }
   else
    {
      SprParDT = (TDateTime)floor( dtStart->Date ) + prTimeDT;
      FprParDT = (TDateTime)floor( dtFinish->Date ) + prTimeDT;
     }

   while (FprParDT>=SprParDT) {
    AnsiString prParDTStr = SprParDT.FormatString("dd.mm.yyyy hh:nn:ss");
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text = "begin "+SchemeName+"file_pg.startimmediate_p( :par1, to_date(:par2,'dd.mm.yyyy hh24:mi:ss'), :par3);\
       end;";
     dmMain->quMain->ParamByName("par1")->AsInteger=CurrDeportProc.NProcedure;
     dmMain->quMain->ParamByName("par2")->AsString = prParDTStr;
     dmMain->quMain->ParamByName("par3")->AsString = EdParam->Text;
     dmMain->quMain->Execute();
      SprParDT=SprParDT+1;
     }
    //Ид проц
    //e Вызов проц-ры
  }//пров-ка времени
  Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcRun::BitBtn2Click(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------
bool __fastcall TfmDeportProcRun::DataInit( int PPNProc,int isMaket )
{
  CurrDeportProc.NProcedure = PPNProc;
  unsigned long prCountStr;
  //Считываем текущ строку
  try{
     dmMain->oqCursor->Params->Clear();
     dmMain->oqCursor->SQL->Text="begin "+SchemeName+"file_pg.data_init(:par1,:par2); end;";
     dmMain->oqCursor->ParamByName("par1")->AsInteger = CurrDeportProc.NProcedure;
     dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
     dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
     dmMain->oqCursor->Execute();
     strcpy(CurrDeportProc.VName,dmMain->oqCursor->FieldByName("vname")->AsString.c_str());
     strcpy(CurrDeportProc.VMemo,dmMain->oqCursor->FieldByName("vmemo")->AsString.c_str());
     strcpy(CurrDeportProc.VProcedure,dmMain->oqCursor->FieldByName("vprocedure")->AsString.c_str());
     CurrDeportProc.NPeriod=dmMain->oqCursor->FieldByName("nperiod")->AsFloat;
     CurrDeportProc.NShift=dmMain->oqCursor->FieldByName("nshift")->AsInteger;
     CurrDeportProc.NType=dmMain->oqCursor->FieldByName("ntype")->AsInteger;
     strcpy(CurrDeportProc.VParam,dmMain->oqCursor->FieldByName("vparam")->AsString.c_str());
    //e Считываем текущ строку
    if(!dmMain->oqCursor->Eof){
       Caption = Caption +AnsiString(" ")+CurrDeportProc.VName;
       //Заполнение Даты времени
       float prPeriod = StrToFloat( CurrDeportProc.NPeriod );
       TDateTime prNow=dmMain->SystemDate;
       if ( prPeriod < 1)
       {
         DTPPar->Date = prNow - prPeriod;
         MEdTime->Visible = TRUE;
         MEdTime->Text = prNow.FormatString("hh:nn");
         DTPPar->Left = 96;
         IsHour = TRUE;

             //e Заполнение Даты времени
       EdParam->Text = CurrDeportProc.VParam;
       //для макетов блокируем вывод доп параметров
       Panel5->Visible = !(CurrDeportProc.NType==0);
       dynamic_cast<TForm*>(Panel5->Owner)->Height = 143 - 35 * ((int)!Panel5->Visible);
       }else{
         if ( prPeriod == 1 && isMaket==1)  {
          Panel2->Visible=false;
          Panel2->Enabled=false;
          Panel4->Visible=true;
          Panel4->Enabled=true;

          dtStart->Date=floor( prNow ) - prPeriod;
          dtFinish->Date=floor( prNow ) - prPeriod;
         }else{

         DTPPar->Date = floor( prNow ) - prPeriod;
         MEdTime->Visible = FALSE;
         DTPPar->Left = 152;
         MEdTime->Text = "00:00";
         IsHour = FALSE;
         
        //e Заполнение Даты времени
         EdParam->Text = CurrDeportProc.VParam;
         //для макетов блокируем вывод доп параметров
         Panel5->Visible = !(CurrDeportProc.NType==0);
         dynamic_cast<TForm*>(Panel5->Owner)->Height = 143 - 35 * ((int)!Panel5->Visible);
        }
      }
    }else
      throw Exception(Reconst_smes10_3);
  }catch (Exception &exception){
    Application->ShowException(&exception);
    return false;
  }
  return true;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcRun::FormCreate(TObject *Sender)
{
  //Инициируем
  strcpy( CurrDeportProc.VName, "" );
  strcpy( CurrDeportProc.VMemo, "" );
  strcpy( CurrDeportProc.VProcedure, "" );
  CurrDeportProc.NPeriod = 0;
  CurrDeportProc.NShift = 0;
  CurrDeportProc.NType = 0;
  strcpy( CurrDeportProc.VParam, "" );
  //e Инициируем
}
//---------------------------------------------------------------------------
void DeportProcedureRun( int PPNProc,TComponent* Owner,int isMaket )
{
   TfmDeportProcRun* f= new TfmDeportProcRun( Owner );
   f->Panel2->Visible=true;
   f->Panel2->Enabled=true;
   f->Panel4->Visible=false;
   f->Panel4->Enabled=false;
   if(f->DataInit( PPNProc,isMaket ))
     f->ShowModal();
   delete  f;
}
//---------------------------------------------------------------------------
bool ShowDateDialog(TDateTime &dt,TComponent* Owner )
{
  bool lret=false;
   TfmDeportProcRun* f= new TfmDeportProcRun( Owner );
   f->Panel2->Visible=true;
   f->Panel2->Enabled=true;
   f->Panel4->Visible=false;
   f->Panel4->Enabled=false;
   f->Panel5->Visible = false;
   f->Height=105;
   f->Caption=Reconst_smes10_4;
   f->BitBtn1->OnClick=f->NewBtOKClick;
   f->DTPPar->Date=floor(dt);
   f->MEdTime->Text=dt.FormatString("hh:nn");
   if(f->ShowModal()==mrOk){
    dt=floor(f->DTPPar->Date);
    dt=dt+StrToTime( f->MEdTime->Text + ":00" );
    lret=true;
   };
   delete  f;
   return lret;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcRun::NewBtOKClick(TObject *Sender)
{
  if(CheckTimeInput( MEdTime->Text, Reconst_smes10_2 ))
    ModalResult=mrOk;
}
//---------------------------------------------------------------------------

bool ShowDateStartFinishDialog(TDateTime &dt1,TDateTime &dt2, AnsiString vname,TComponent* Owner )
{
  bool lret=false;
   TfmDeportProcRun* f= new TfmDeportProcRun( Owner );
   f->Caption="Сформировать данные по "+vname;
   f->Panel2->Visible=false;
   f->Panel2->Enabled=false;
   f->Panel4->Visible=true;
   f->Panel4->Enabled=true;
   f->BitBtn1->OnClick=f->StFinBtOKClick;
   f->dtStart->Date=dt1;
   f->dtFinish->Date=dt2;
   if(f->ShowModal()==mrOk){
    dt1=f->dtStart->DateTime;
    dt2=f->dtFinish->DateTime;
    lret=true;
   };
   delete  f;
   return lret;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcRun::StFinBtOKClick(TObject *Sender)
{
  if((int)dtStart->Date > (int)dtFinish->Date)
        {
                Application->MessageBox(Reconst_smes15_1.c_str(),
                        Application->Title.c_str(),MB_ICONERROR);
                return;
        }
    ModalResult=mrOk;
}
//---------------------------------------------------------------------------


