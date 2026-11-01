//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "unDataMod.h"
#include "InputStartMeters.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Main"
#pragma link "DBAccess"
#pragma link "DBGridEh"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "VirtualTable"
#pragma resource "*.dfm"
TfmInputStartMeters *fmInputStartMeters;
//---------------------------------------------------------------------------
__fastcall TfmInputStartMeters::TfmInputStartMeters(TComponent* Owner,AnsiString Name, TAccess acc)
  : TMainForm(Owner,Name,acc)
{
 ReplaceRyda(this,BASE_SCHEME,SchemeName);
 pointPOL.myTime=TDateTime::CurrentDate();
 //iaSave->OnExecute     = vSave;
// EditRec=false;
}

//-------------------------------------------------------------------------------
void __fastcall TfmInputStartMeters::vParams(TObject* Sender)
{
   TFormVVMeter *f=NULL;
   try{
      if(EditRec)
      switch(MessageBox(Handle, Reconst_smes91_1.c_str(), Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION))
      {
      case IDYES:
         vSave(Sender);
         if(EditRec) return;
         break;
      case IDCANCEL:
         return;
      }
       f= new TFormVVMeter(this,&pointPOL);
      // f->Panel11->Visible=false;
        f->paEdit->Visible=false;
      if((f->ShowModal() == mrOk)&&f->tvMain->Selected){
         vtData->DisableControls();
         vtData->AfterPost=NULL;
      //   NameGroup=f->tvMain->Selected->Text;
      if(Sender)
     {
        dbManInput->Columns->BeginUpdate();
        vtData->Close();
         vtData->Clear();
      }
      ReadData();
      }else{
      if(!Sender)
            Close();
    }
     vtData->AfterPost=vtDataAfterPost;
    vtData->EnableControls();
      delete f;
      if(Sender)
        dbManInput->SetFocus();
   }catch (Exception &exception){
      if(f)
         delete f;
      Application->ShowException(&exception);
      if(!Sender)
         Close();
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmInputStartMeters::vSave
(TObject* Sender)
 {
 TBookmark SavePlace;
try{
      if(vtData->State==dsInsert||vtData->State==dsEdit)
         vtData->Post();

  SavePlace = vtData->GetBookmark();
  vtData->DisableControls();

  oqSave->Params->Clear();
      oqSave->SQL->Text="begin \
                          "+SchemeName+"MANUAL_IN_START_METERS_PG.SAVE_DATA_P(:par1,:par2,:par3,:par5); \
                         end;";
           /*SAVE_DATA_P(an_mid NUMBER,an_er NUMBER,an_erm NUMBER,an_meas NUMBER,
                                        ad_date DATE )*/
   vtData->First();

  while(!vtData->Eof){
     if(vtData->FieldByName("IsEdit")->AsInteger==1){


          oqSave->ParamByName("par1")->AsInteger= vtData->FieldByName("mid")->AsInteger;
          if(!vtData->FieldByName("e")->IsNull)
          oqSave->ParamByName("par2")->AsFloat= vtData->FieldByName("e")->AsFloat;
          else
          oqSave->ParamByName("par2")->Clear();
           if(!vtData->FieldByName("em")->IsNull)
          oqSave->ParamByName("par3")->AsFloat= vtData->FieldByName("em")->AsFloat;
          else
          oqSave->ParamByName("par3")->Clear();
       //   oqSave->ParamByName("par4")->AsInteger= vtData->FieldByName("nmeasure")->AsInteger;
          oqSave->ParamByName("par5")->AsDateTime=vtData->FieldByName("ddate")->AsDateTime+
          vtData->FieldByName("dtime")->AsDateTime;


     if ( vtData->FieldByName("ddate")->IsNull&&(!vtData->FieldByName("em")->IsNull||!vtData->FieldByName("e")->IsNull)){
        MessageBox(Handle, "¬ведите дату.", Application->Title.c_str(),MB_OK|MB_ICONWARNING);
         vtData->Edit();
         vtData->FieldByName("IsEdit")->AsInteger=0;
         vtData->EnableControls();
         vtData->GotoBookmark(SavePlace);
         vtData->FreeBookmark(SavePlace);
        return;
        }

       oqSave->Execute();

       dmMain->orases->Commit();
       vtData->Edit();
       vtData->FieldByName("IsEdit")->AsInteger=0;
       }
       vtData->Next();

      }


    vtData->EnableControls();
    vtData->GotoBookmark(SavePlace);
    vtData->FreeBookmark(SavePlace);
      vRefresh(this);
       EditRec=false;
   // btnSave->Enabled=false;
    dbManInput->SetFocus();
  }catch(Exception&e){
     dmMain->orases->Rollback();
     Application->ShowException(&e);
   }
 }

 //---------------------------------------------------------------------------
void __fastcall TfmInputStartMeters::vRefresh
(TObject* Sender)
 {
 TBookmark SavePlace;
  try{
    SavePlace = vtData->GetBookmark();
     vtData->DisableControls();
     vtData->AfterPost=NULL;
     dbManInput->Columns->BeginUpdate();
      vtData->Close();
      vtData->Clear();



     ReadData();
    
 

     vtData->First();
     vtData->AfterPost=vtDataAfterPost;
     vtData->EnableControls();
     dbManInput->Columns->EndUpdate();
     vtData->GotoBookmark(SavePlace);
     vtData->FreeBookmark(SavePlace);
  }catch(Exception &e){
    vtData->EnableControls();
    Application->ShowException(&e);
  }
 }

 //---------------------------------------------------------------------------
void __fastcall TfmInputStartMeters::vCheck
(TObject* Sender)
 {
//
 }

 //--------------------------------------------------------------------------------
void __fastcall TfmInputStartMeters::FormCreate(TObject *Sender)
{
	vParams(NULL);
}
//---------------------------------------------------------------------------
  void __fastcall TfmInputStartMeters::ReadData()
{
   AnsiString NamePoint1;

    //-----------------------------------------------------------------
    oqData->ParamByName("par1")->AsInteger= pointPOL.mid ;
    oqData->ParamByName("par2")->AsInteger= pointPOL.ifpoint;

     vtData->FieldByName("ddate")->ReadOnly=false;
     vtData->FieldByName("dtime")->ReadOnly=false;
     vtData->FieldByName("e")->ReadOnly=false;
     vtData->FieldByName("em")->ReadOnly=false;

   //-------------------------------------------------------------------
    oqData->Execute();
    RowCount=0;
     EditRec=false;
    vtData->Open();
  while (!oqData->Eof){
           RowCount++;
       if(vtData->State==dsInsert||vtData->State==dsEdit)
            vtData->Post();
          vtData->Append();
          if(RowCount==1)
          NamePoint1=oqData->FieldByName("vname")->AsString;
          else
            if(NamePoint1==oqData->FieldByName("vname")->AsString)
               NamePoint1=" ";
            else
               NamePoint1=oqData->FieldByName("vname")->AsString;

          vtData->FieldByName("mid")->AsFloat=oqData->FieldByName("mid")->AsFloat;
          vtData->FieldByName("name")->AsString=NamePoint1;
         // vtData->FieldByName("type")->AsString=oqData->FieldByName("type")->AsString;
          vtData->FieldByName("mtrsn")->AsString=oqData->FieldByName("mtrsn")->AsString;
          vtData->FieldByName("KC")->AsInteger=oqData->FieldByName("KC")->AsInteger;
       //   vtData->FieldByName("nmeasure")->AsInteger=oqData->FieldByName("nmeasure")->AsInteger;
          vtData->FieldByName("mconst")->AsFloat=oqData->FieldByName("mconst")->AsFloat;
          if(!oqData->FieldByName("e")->IsNull)
          vtData->FieldByName("e")->AsFloat=oqData->FieldByName("e")->AsFloat;
          if(!oqData->FieldByName("em")->IsNull)
          vtData->FieldByName("em")->AsFloat=oqData->FieldByName("em")->AsFloat;
          if(!oqData->FieldByName("ddate")->IsNull)
          {
          vtData->FieldByName("ddate")->AsDateTime=oqData->FieldByName("ddate")->AsDateTime;
          vtData->FieldByName("dtime")->AsDateTime=oqData->FieldByName("ddate")->AsDateTime;
          }
          vtData->FieldByName("IsEdit")->AsInteger=0;






          oqData->Next();

          }
  vtData->First();

 if(RowCount==0){
 vtData->FieldByName("ddate")->ReadOnly=true;
 vtData->FieldByName("dtime")->ReadOnly=true;
 vtData->FieldByName("e")->ReadOnly=true;
 vtData->FieldByName("em")->ReadOnly=true;

 }else{
 vtData->FieldByName("ddate")->ReadOnly=false;
 vtData->FieldByName("dtime")->ReadOnly=false;
 vtData->FieldByName("e")->ReadOnly=false;
 vtData->FieldByName("em")->ReadOnly=false;
 }
}
//-------------------------------------------------------------------------------------------------------------------
void __fastcall TfmInputStartMeters::vtDataAfterPost(TDataSet *DataSet)
{
vtData->AfterPost=NULL;
 vtData->Edit();
 vtData->FieldByName("IsEdit")->AsInteger=1;
if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

       EditRec=true;
    //   btnSave->Enabled=true;

     vtData->AfterPost=vtDataAfterPost;
}
//---------------------------------------------------------------------------
void __fastcall TfmInputStartMeters::bbTestClick(TObject *Sender)
{
  TBookmark SavePlace;
try{
      if(vtData->State==dsInsert||vtData->State==dsEdit)
         vtData->Post();

  SavePlace = vtData->GetBookmark();
  vtData->DisableControls();
   vtData->First();

  while(!vtData->Eof){
     if(!vtData->FieldByName("e")->IsNull&&!vtData->FieldByName("ddate")->IsNull){
           oqTest->ParamByName("par2")->AsInteger= vtData->FieldByName("mid")->AsInteger;
           oqTest->ParamByName("par3")->AsFloat= vtData->FieldByName("e")->AsFloat;
           oqTest->ParamByName("par4")->AsDateTime=vtData->FieldByName("ddate")->AsDateTime+
           vtData->FieldByName("dtime")->AsDateTime;
           oqTest->ParamByName("par5")->AsFloat= vtData->FieldByName("mconst")->AsFloat;
           oqTest->Execute();

           if(!oqTest->ParamByName("par1")->IsNull) {
            vtData->Edit();
            vtData->FieldByName("em")->AsFloat=oqTest->ParamByName("par1")->AsFloat;
            }
        }
       vtData->Next();

      }
  }catch(Exception&e){
       Application->ShowException(&e);
  }
  vtData->EnableControls();
  vtData->GotoBookmark(SavePlace);
  vtData->FreeBookmark(SavePlace);
  dbManInput->SetFocus();
}
//---------------------------------------------------------------------------

