//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <values.h>
#include <Math.hpp>
#pragma hdrstop
#include "unDataMod.h"
#include "InputParam.h"
#include "ManualInputMeter.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma link "DBGridEh"
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "VirtualTable"
#pragma link "PrnDbgeh"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmManualInputMeter::TfmManualInputMeter(TComponent* Owner,AnsiString Name, long ttable,long rezerv, TAccess a)
	: TMainForm(Owner, Name, a)
{
 //rezerv-0 TaskMenu;1-EditFeeders;2-EditGroup
 ReplaceRyda(this,BASE_SCHEME,SchemeName);
// this->ttable=ttable;
  this->ttable=5;
  isEditFeeders=rezerv;
  nmid=ttable;
  Access=a;
 }
//---------------------------------------------------------------------------

void __fastcall TfmManualInputMeter::FormCreate(TObject *Sender)
{
  TCount=0;
 // p.Step=1;
  p.usetime=true;
  p.myTime=TDateTime::CurrentDate()-1;
  if (isEditFeeders==0)
  vParams(NULL);
  else {
  p.ifpoint=isEditFeeders==2?0:1;
  vParamsEditFeeders();
  }


}
//------------------------------------------------------------------------------
void __fastcall TfmManualInputMeter::vParamsEditFeeders()
{


 int FRowCount;

  try{
       p.mid=nmid;
       vtData->DisableControls();

       vtDataem->OnValidate=NULL;
     //  NameGroup=f->tvMain->Selected->Text;


     ReadData();


   vtDataem->OnValidate=vtDataemValidate;
   vtData->EnableControls();

  }catch (Exception &exception){

  	Application->ShowException(&exception);

  }
}
//---------------------------------------------------------------------------
void __fastcall TfmManualInputMeter::vParams(TObject* Sender)
{

 TFormManualInTree *f=NULL;
 int FRowCount;
    try{

    f= new TFormManualInTree(this,&p);

    if((f->ShowModal() == mrOk)&&f->tvMain->Selected){
       vtData->DisableControls();

       vtDataem->OnValidate=NULL;
       NameGroup=f->tvMain->Selected->Text;
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

   vtDataem->OnValidate=vtDataemValidate;
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
void __fastcall TfmManualInputMeter::ReadData()
{                                          
   AnsiString NamePoint1;

    //-----------------------------------------------------------------
    oqReadRow->ParamByName("par1")->AsInteger= p.mid ;
    oqReadRow->ParamByName("par2")->AsInteger= p.entype[0];
    oqReadRow->ParamByName("par3")->AsInteger= p.entype[1];
    oqReadRow->ParamByName("par4")->AsInteger= p.entype[2];
    oqReadRow->ParamByName("par5")->AsInteger= p.entype[3];
    oqReadRow->ParamByName("par6")->AsInteger= p.entype[4];
    oqReadRow->ParamByName("par7")->AsInteger= p.entype[5];
    oqReadRow->ParamByName("par8")->AsInteger= p.ifpoint;
    oqReadRow->ParamByName("par10")->AsInteger= ttable;
    oqReadRow->ParamByName("par11")->AsDateTime= p.myTime;
   //-------------------------------------------------------------------
    oqReadRow->Execute();
    RowCount=0;
    vtData->Open();
  while (!oqReadRow->Eof){
           RowCount++;
       if(vtData->State==dsInsert||vtData->State==dsEdit)
            vtData->Post();
          vtData->Append();
          if(RowCount==1)
          NamePoint1=oqReadRow->FieldByName("name")->AsString;
          else
            if(NamePoint1==oqReadRow->FieldByName("name")->AsString)
               NamePoint1=" ";
            else
               NamePoint1=oqReadRow->FieldByName("name")->AsString;

          vtData->FieldByName("mid")->AsFloat=oqReadRow->FieldByName("mid")->AsFloat;
          vtData->FieldByName("name")->AsString=NamePoint1;
          vtData->FieldByName("type")->AsString=oqReadRow->FieldByName("type")->AsString;
          vtData->FieldByName("mtrsn")->AsString=oqReadRow->FieldByName("mtrsn")->AsString;
          vtData->FieldByName("KC")->AsInteger=oqReadRow->FieldByName("KC")->AsInteger;
          vtData->FieldByName("nmeasure")->AsInteger=oqReadRow->FieldByName("nmeasure")->AsInteger;
          if(!oqReadRow->FieldByName("lastd")->IsNull)
          vtData->FieldByName("lastd")->AsDateTime=oqReadRow->FieldByName("lastd")->AsDateTime;
          if(!oqReadRow->FieldByName("lastind")->IsNull)
          vtData->FieldByName("lastind")->AsFloat=oqReadRow->FieldByName("lastind")->AsFloat;
          if(!oqReadRow->FieldByName("em")->IsNull)
          vtData->FieldByName("em")->AsFloat=oqReadRow->FieldByName("em")->AsFloat;
          if(!oqReadRow->FieldByName("e")->IsNull)
          vtData->FieldByName("e")->AsFloat=oqReadRow->FieldByName("e")->AsFloat;
          if(!oqReadRow->FieldByName("nextd")->IsNull)
          vtData->FieldByName("nextd")->AsDateTime=oqReadRow->FieldByName("nextd")->AsDateTime;
          if(!oqReadRow->FieldByName("nextind")->IsNull)
          vtData->FieldByName("nextind")->AsFloat=oqReadRow->FieldByName("nextind")->AsFloat;
          if(!oqReadRow->FieldByName("digits")->IsNull)
          vtData->FieldByName("digits")->AsFloat=oqReadRow->FieldByName("digits")->AsFloat;
            NamePoint1=oqReadRow->FieldByName("name")->AsString;

           vtData->FieldByName("predmin")->AsFloat=0;
           vtData->FieldByName("predmax")->AsFloat=MAXFLOAT;
           vtData->FieldByName("avarmin")->AsFloat=0;
           vtData->FieldByName("avarmax")->AsFloat=MAXFLOAT;
           vtData->FieldByName("fizmin")->AsFloat=0;
           vtData->FieldByName("fizmax")->AsFloat=MAXFLOAT;

         
            oqMaxValue->ParamByName("par1")->AsFloat=oqReadRow->FieldByName("mid")->AsFloat;
            oqMaxValue->ParamByName("par2")->AsInteger=oqReadRow->FieldByName("nmeasure")->AsInteger;
            oqMaxValue->Execute();

            while(!oqMaxValue->Eof){

             if (!oqMaxValue->FieldByName("predmin")->IsNull)
               vtData->FieldByName("predmin")->AsFloat=oqMaxValue->FieldByName("predmin")->AsFloat;
             if (!oqMaxValue->FieldByName("predmax")->IsNull)
               vtData->FieldByName("predmax")->AsFloat=oqMaxValue->FieldByName("predmax")->AsFloat;
             if (!oqMaxValue->FieldByName("avarmin")->IsNull)
               vtData->FieldByName("avarmin")->AsFloat=oqMaxValue->FieldByName("avarmin")->AsFloat;
             if (!oqMaxValue->FieldByName("avarmax")->IsNull)
               vtData->FieldByName("avarmax")->AsFloat=oqMaxValue->FieldByName("avarmax")->AsFloat;
             if (!oqMaxValue->FieldByName("fizmin")->IsNull)
               vtData->FieldByName("fizmin")->AsFloat=oqMaxValue->FieldByName("fizmin")->AsFloat;
             if (!oqMaxValue->FieldByName("fizmax")->IsNull)
               vtData->FieldByName("fizmax")->AsFloat=oqMaxValue->FieldByName("fizmax")->AsFloat;

            oqMaxValue->Next();
            }

          oqReadRow->Next();

          }
  vtData->First();
}


//--------------------------------------------------------------------------------------------------
void __fastcall TfmManualInputMeter::vRefresh(TObject* Sender)
{
   TBookmark SavePlace;
  try{
    SavePlace = vtData->GetBookmark();
     vtData->DisableControls();
     dbManInput->Columns->BeginUpdate();
      vtData->Close();
      vtData->Clear();


     vtDataem->OnValidate=NULL;
     ReadData();
    
     vtDataem->OnValidate=vtDataemValidate;
     vtData->First();
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
void __fastcall TfmManualInputMeter::vSave(TObject* Sender)
{
  TBookmark SavePlace;
try{
      if(vtData->State==dsInsert||vtData->State==dsEdit)
         vtData->Post();

  SavePlace = vtData->GetBookmark();
  vtData->DisableControls();

  oqSave->Params->Clear();
      oqSave->SQL->Text="begin \
                          "+SchemeName+"indic_pg.setindic(:par12,:par11,:par17,:par101,1,'Р.В',:par14,:par15,:par16,:par1,:par2,:par18,:par19); \
                         end;";

   vtData->First();
   oqReadRow->First();
  while(!vtData->Eof){
     if(vtData->FieldByName("em")->AsFloat==oqReadRow->FieldByName("em")->AsFloat){
        vtData->Next();
        oqReadRow->Next();
           continue;
       }
       if(!vtData->FieldByName("em")->IsNull)
       oqSave->ParamByName("par1")->AsFloat= vtData->FieldByName("em")->AsFloat;
       else
       oqSave->ParamByName("par1")->Clear();

       oqSave->ParamByName("par2")->AsFloat= vtData->FieldByName("e")->AsFloat;
       oqSave->ParamByName("par11")->AsDateTime= p.myTime;
       oqSave->ParamByName("par12")->AsFloat= vtData->FieldByName("mid")->AsFloat;
       oqSave->ParamByName("par14")->AsString= UsCon.uName;
       oqSave->ParamByName("par15")->AsString= vtData->FieldByName("mtrsn")->AsString;
       oqSave->ParamByName("par16")->AsInteger= vtData->FieldByName("KC")->AsInteger;
       oqSave->ParamByName("par17")->AsInteger= vtData->FieldByName("nmeasure")->AsInteger;
       oqSave->ParamByName("par18")->AsInteger=ComboBox1->ItemIndex==0?0:1;
       oqSave->ParamByName("par19")->AsInteger=ComboBox1->ItemIndex==0?1:0;
       oqSave->ParamByName("par101")->AsInteger= ttable;
       oqSave->Execute();
       dmMain->orases->Commit();
       vtData->Next();
       oqReadRow->Next();
      }
   

    vtData->EnableControls();
    vtData->GotoBookmark(SavePlace);
    vtData->FreeBookmark(SavePlace);
    vRefresh(this);
    btSave->Enabled=false;
    dbManInput->SetFocus();
  }catch(Exception&e){
     dmMain->orases->Rollback();
     Application->ShowException(&e);
   }

}
//---------------------------------------------------------------------------

void __fastcall TfmManualInputMeter::iaRefreshExecute(TObject *Sender)
{
   vRefresh(this);

}
//---------------------------------------------------------------------------

void __fastcall TfmManualInputMeter::tbPrintClick(TObject *Sender)
{
  PrintGrid->PageHeader->CenterText->Clear();
  PrintGrid->PageHeader->RightText->Clear();
  PrintGrid->PageHeader->CenterText->Add(Caption);
  PrintGrid->PageHeader->CenterText->Add("  ");
  PrintGrid->PageHeader->RightText->Text=p.myTime.FormatString("dd.mm.yyyy hh:nn");
  PrintGrid->Preview();
}
//---------------------------------------------------------------------------


void __fastcall TfmManualInputMeter::iaCloseExecute(TObject *Sender)
{

  if(btSave->Enabled==true)
      {
      switch (MessageBox(Handle, Reconst_smes43_5.c_str(),
                        Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1))
     { case IDCANCEL:
        return;
      case IDYES:
       if (Access == accDenied && Access == accRead)
          throw Exception(Reconst_smes43_3);
        vSave(Sender);
        break;
    }

      }
    
    vtDataem->OnValidate=NULL;
   
    Close();

}

//--------------------------------------------------------------------------------



void __fastcall TfmManualInputMeter::vtDataemValidate(TField *Sender)
{

   AnsiString sras,scurr;
  bool conv;
  double proc,aRas;
  static double dopproc=30;
  TColor CurrentColor=clWhite;
  AnsiString s;
  TRect Rect;
  AnsiString     aPred="";
  AnsiString     aCur="";
  AnsiString     aDig="";
  AnsiString     aKC="";
  long redcell=0;
  long test=0;
  double HourCount=1;
  double MinTest;
  double MaxTest;
  bool ValueTest=true;
  AnsiString MesText;

    //------------------------------------------------------------------Проверка
       if (!vtData->FieldByName("lastind")->IsNull)
        aPred=FloatToStr(vtData->FieldByName("lastind")->AsFloat);

       if(!Sender->IsNull)
        aCur=FloatToStr(Sender->AsFloat);

       if(!vtData->FieldByName("digits")->IsNull)
        aDig= FloatToStr(vtData->FieldByName("digits")->AsFloat);

       if(!vtData->FieldByName("KC")->IsNull)
        aKC= IntToStr(vtData->FieldByName("KC")->AsInteger);

      if(GetRas(aPred,aCur,aDig,aKC,conv,proc)!="")
       aRas=StrToFloat(GetRas(aPred,aCur,aDig,aKC,conv,proc));
      else
        aRas=NULL;
        
      if(proc>=dopproc){
        CurrentColor=clRed;
        Application->MessageBox(AnsiString(Reconst_smes82_11+
                        IntToStr((long)dopproc)+Reconst_smes82_12).c_str(),
                        Application->Title.c_str(),MB_OK |MB_ICONWARNING);
       }else{
        if(conv)
          CurrentColor=clYellow;
        if(Sender->IsNull)
          CurrentColor=clLime;
      }
      //------------------------------------------------------------------------   end;

    //-------------------------------------------------------------Проверка границ
         HourCount=p.myTime-vtData->FieldByName("lastd")->AsDateTime;
         HourCount=Ceil(HourCount*24)*StrToInt(aKC);



   if(aRas&&(aRas<vtData->FieldByName("fizmin")->AsFloat*HourCount||
     aRas>vtData->FieldByName("fizmax")->AsFloat*HourCount)){
               ValueTest=false;
               throw Exception ("Введенные показания выходят за физические границы!");
    }

   if(ValueTest&&aRas&&(aRas<vtData->FieldByName("avarmin")->AsFloat*HourCount||
     aRas>vtData->FieldByName("avarmax")->AsFloat*HourCount)){
               ValueTest=false;
               MinTest=vtData->FieldByName("avarmin")->AsFloat*HourCount;
               MaxTest=vtData->FieldByName("avarmax")->AsFloat*HourCount;
               CurrentColor=clRed;
               dbManInput->Canvas->FillRect(Rect);
        Application->MessageBox(AnsiString("Введенные показания " + FormatFloat("0.000",aRas/(double)StrToInt(aKC))
               + " выходят за допустимые аварийные границы: "
               ">="+FormatFloat("0.000",MinTest) + " или "+
               "<=" +FormatFloat("0.000",MaxTest) ).c_str()
               ,Application->Title.c_str(),MB_OK | MB_ICONWARNING);
     }

    if(ValueTest&&aRas&&(aRas<vtData->FieldByName("predmin")->AsFloat*HourCount||
     aRas>vtData->FieldByName("predmax")->AsFloat*HourCount)){
               ValueTest=false;
               MinTest=vtData->FieldByName("predmin")->AsFloat*HourCount;
               MaxTest=vtData->FieldByName("predmax")->AsFloat*HourCount;
              CurrentColor=clRed;
         Application->MessageBox(AnsiString("Введенные показания " + FormatFloat("0.000",aRas/(double)StrToInt(aKC))
                + " выходят за допустимые предупредительные границы: "
               ">="+FormatFloat("0.000",MinTest) + " или "+
               "<=" +FormatFloat("0.000",MaxTest) ).c_str()
                ,Application->Title.c_str(),MB_OK | MB_ICONWARNING);
           }

    //----------------------------------------------------------end;

     if(CurrentColor!=clWhite){
           s=FormatFloat("0.000",Sender->AsFloat);
           Rect=dbManInput->CellRect(dbManInput->Col,dbManInput->Row);
           dbManInput->Canvas->Brush->Color=CurrentColor;
           dbManInput->Canvas->FillRect(Rect);
           dbManInput->Canvas->Font->Color=clBlack;
           dbManInput->Canvas->TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
      }

     vtData->Edit();
     vtData->FieldByName("e")->AsFloat=aRas;


          btSave->Enabled=true;


}
//---------------------------------------------------------------------------



void __fastcall TfmManualInputMeter::dbManInputColEnter(TObject *Sender)
{
  if(dbManInput->SelectedIndex!=6)dbManInput->SelectedIndex=6;

}
//---------------------------------------------------------------------------



