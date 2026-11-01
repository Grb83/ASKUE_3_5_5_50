//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "unEditFormula.h"
#include "unDataMod.h"
#include "selectpoint.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "DBGridEh"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "VirtualTable"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmEditFormula::TfmEditFormula(TComponent* Owner,long id)
	: TForm(Owner)
{
 ReplaceRyda(this,BASE_SCHEME,SchemeName);
 this->id=id;
 Tr=new TfmTree(this);
 ls=new TList;
 measst= new TStringList();
}
//---------------------------------------------------------------------------
bool __fastcall TfmEditFormula::fmEditFormulaShow(TComponent* Owner,long id)
{
  TfmEditFormula *f=new TfmEditFormula(Owner,id);
  int res = f->ShowModal();
  delete f;
  return (res == mrOk);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::vSave(TObject *Sender)
{
  if (!Compiling(Sender)) return;
  else {
  SavePlace = vtArg->GetBookmark();
  argFree=false;
  vtArg->First();

  while (!vtArg->Eof){
   if ((vtArg->FieldByName("vtArgVNAME")->AsString=="")||(vtArg->FieldByName("vtArgVPARAM")->AsString=="")) argFree=true;
   vtArg->Next();
  }
  if((editFrmla->Text.Trim()=="")||(argFree)){
    MessageBox(Handle, Reconst_smes69_1.c_str(),Application->Title.c_str(),MB_OK | MB_ICONERROR);
    cbObjType->ItemIndex=Temp;
    return;
  }
    oqSave->ParamByName("point_id")->AsInteger=id;
    oqSave->ParamByName("an_meas")->AsInteger=(long)cbObjType->Items->Objects[cbObjType->ItemIndex];
    oqSave->ParamByName("av_formula")->AsString=editFrmla->Text;
    oqSave->ParamByName("av_memo")->AsString=edMemo->Text;

    //Часовой период интеграции
    oqSave->ParamByName("an_NHOURERIOD")->AsInteger = (int)cbHourPeriod->Checked;
    //разбивать на 30 мин
    oqSave->ParamByName("an_NDIVTYPE")->AsInteger = (int)cbThirty_min->Checked;

    int i=0;
    vtArg->First();
    while (!vtArg->Eof)
    {
      i++;
      oqSave->ParamByName("at_name")->ItemAsString[i]=vtArg->FieldByName("vtArgVNAME")->AsString;
      oqSave->ParamByName("at_param")->ItemAsString[i]=vtArg->FieldByName("vtArgVPARAM")->AsString;
      oqSave->ParamByName("at_memo")->ItemAsString[i]=vtArg->FieldByName("vtArgVMEMO")->AsString;
      oqSave->ParamByName("at_shift")->ItemAsString[i]=vtArg->FieldByName("vtArgVShift")->AsString;
      vtArg->Next();
    }

    if(!i)
    {
      i++;
      oqSave->ParamByName("at_name")->ItemAsString[i]="";
      oqSave->ParamByName("at_param")->ItemAsString[i]="";
      oqSave->ParamByName("at_memo")->ItemAsString[i]="";
      oqSave->ParamByName("at_shift")->ItemAsString[i]="";
    }

    oqSave->ParamByName("at_name")->Length=i;
    oqSave->ParamByName("at_param")->Length=i;
    oqSave->ParamByName("at_memo")->Length=i;
    oqSave->ParamByName("at_shift")->Length=i;

  oqSave->Execute();
  cbObjType->ItemIndex=Temp2;
  btSave->Enabled=false;

  vtArg->GotoBookmark(SavePlace);
  vtArg->FreeBookmark(SavePlace);
  }
}
//-------------------------------------------------------------------------------
bool __fastcall TfmEditFormula::vRead(void)
{
  //добавление ид точки и выполнение запроса
  oqGetFrmla->ParamByName("an_mid")->AsInteger=id;
  oqGetFrmla->Execute();

 //ввод формулы в окно и комментариев
  editFrmla->Text=oqGetFrmla->ParamByName("av_formula")->AsString;
  edMemo->Text=oqGetFrmla->ParamByName("av_memo")->AsString;

  //Часовой период интеграции
  cbHourPeriod->Checked = (bool)oqGetFrmla->ParamByName("an_NHOURERIOD")->AsInteger;
  //разбивать на 30 мин
  cbThirty_min->Checked = (bool)oqGetFrmla->ParamByName("an_NDIVTYPE")->AsInteger;

 vtArg->DisableControls();
 vtArg->Clear();
 vtArg->Open();
  while (!oqGetFrmla->Eof){
  vtArg->Append();
  vtArg->FieldByName("vtArgVNAME")->AsString=oqGetFrmla->FieldByName("VNAME")->AsString;
  vtArg->FieldByName("vtArgVPARAM")->AsString=oqGetFrmla->FieldByName("VPARAM")->AsString;
  vtArg->FieldByName("vtArgVMEMO")->AsString=oqGetFrmla->FieldByName("VMEMO")->AsString;
  vtArg->FieldByName("vtArgVPntName")->AsString=oqGetFrmla->FieldByName("OBJNAME")->AsString;
  vtArg->FieldByName("vtArgVShift")->AsFloat=oqGetFrmla->FieldByName("NSHIFT")->AsFloat;

  vtArg->Post();
  oqGetFrmla->Next();
 }

 vtArg->First();
 vtArg->EnableControls();
 btSave->Enabled=false;
 sbResult->SimpleText="";
 return true;
}
//-----------------------------------------------------------------------------------
void __fastcall TfmEditFormula::vRefresh(TObject *Sender)
{
  //cancel
  if(pcEditFormula->ActivePage == tsEditFormula)
  {
    if (btSave->Enabled)
    {
      int choice=MessageBox(Handle, Reconst_smes69_2.c_str(), Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION);

      if (choice==IDYES)
      {
        vSave(this);
      }
      if (choice==IDCANCEL) return;
    }
    oqGetFrmla->ParamByName("an_meas")->AsInteger=(long)cbObjType->Items->Objects[cbObjType->ItemIndex];
    vRead();
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::btOkClick(TObject *Sender)
{
 if (btSave->Enabled)
   vSave(this);
 if(!btSave->Enabled)
   ModalResult=mrOk;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::btSaveClick(TObject *Sender)
{
  vSave(this);
  pcEditFormula->Tag = 0;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::FormCreate(TObject *Sender)
{
  vRead();

 oqMeas->Execute();
 while (!oqMeas->Eof) {
   measst->Add(oqMeas->FieldByName("VCODE")->AsString);
   oqMeas->Next();
 }
 oqMeas->Close();

 measst->Sort();

  //заполнение списка объектов
  oqObjType->Execute();

 while (!oqObjType->Eof) {
   cbObjType->Items->AddObject(oqObjType->FieldByName("VNAME")->AsString,(TObject*)oqObjType->FieldByName("nid")->AsInteger);
   oqObjType->Next();
 }

 oqObjType->Close();

 for (int i=0; i<cbObjType->Items->Count;i++)
 {
  if ((long)cbObjType->Items->Objects[i]==oqGetFrmla->ParamByName("an_meas")->AsInteger)
  {
    cbObjType->ItemIndex=i;
    Temp=i;
    Temp2=i;
    break;
  }
 }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::btShowTreeClick(TObject *Sender)
{
 Tr->Show();
}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::editFrmlaDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
  SetFocus();
  Accept=Source->ClassNameIs("TTreeView");
  TTreeView *Tree=(TTreeView *)Source;
  if (Tree->Selected->HasChildren)
  {
    Accept=false; return;
  }
 editFrmla->SetFocus();
 try
 {
  long Ps=editFrmla->Perform(EM_CHARFROMPOS, 0, MAKELONG(X,Y));
  editFrmla->SelStart=LOWORD(Ps);
  sbEditFrmla->Panels->Items[0]->Text=IntToStr((int)editFrmla->CaretPos.y+1)+": "+IntToStr((int)editFrmla->CaretPos.x+1);
 }
 catch (Exception &exception)
 {
  Application->ShowException(&exception);
 }
}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::editFrmlaDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
  try
  {
    TTreeView *Tree=(TTreeView *)Source;
    TfmTree::SFunction *Data=(TfmTree::SFunction*)Tree->Selected->Data;

    if (Data->ntype==1)
    {
      edMemo->Text="";
      editFrmla->Text="";
      vtArg->Clear();
    }
    AnsiString FuncStr=Data->vvalue;
    int i=editFrmla->SelStart;
    start=editFrmla->SelStart;
    end=FuncStr.Length();

    editFrmla->Text=editFrmla->Text.Delete(i+1,editFrmla->SelLength);
    editFrmla->Text=editFrmla->Text.Insert(FuncStr,i+1);
    editFrmla->SelStart=i;
    editFrmla->SelLength=FuncStr.Length();
    editFrmla->SetFocus();

      if (Data->ntype==1)
  {
    tbAnalyseClick(Sender);
    oqArguments->ParamByName("an_id")->AsInteger=Data->nid;
    oqArguments->Execute();
    vtArg->DisableControls();
    vtArg->Open();
    while (!oqArguments->Eof)
    {
    vtArg->First();
    while (!vtArg->Eof)
    {
      if (vtArg->FieldByName("vtArgVNAME")->AsString==oqArguments->FieldByName("VNAME")->AsString)
      {
        vtArg->Edit();
        vtArg->FieldByName("vtArgVPARAM")->AsString=oqArguments->FieldByName("VPARAM")->AsString;
        vtArg->FieldByName("vtArgVMEMO")->AsString=oqArguments->FieldByName("VMEMO")->AsString;
        vtArg->FieldByName("vtArgVShift")->AsFloat=0; // по умолчанию
        vtArg->Post();
        vtArg->Last();
      }
      else vtArg->Next();
    }
    oqArguments->Next();
    }
    vtArg->EnableControls();
    oqArguments->Close();
  }


  }
  catch (Exception &exception)
  {
	  Application->ShowException(&exception);
  }
  sbEditFrmla->Panels->Items[0]->Text=IntToStr((int)editFrmla->CaretPos.y+1)+": "+IntToStr((int)editFrmla->CaretPos.x+1);
  //editFrmla->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::editFrmlaMouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
  sbEditFrmla->Panels->Items[0]->Text=IntToStr((int)editFrmla->CaretPos.y+1)+": "+IntToStr((int)editFrmla->CaretPos.x+1);
}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::editFrmlaKeyUp(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
  sbEditFrmla->Panels->Items[0]->Text=IntToStr((int)editFrmla->CaretPos.y+1)+": "+IntToStr((int)editFrmla->CaretPos.x+1);

}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::FormShow(TObject *Sender)
{
 sbEditFrmla->Panels->Items[0]->Text=IntToStr((int)editFrmla->CaretPos.y+1)+": "+IntToStr((int)editFrmla->CaretPos.x+1);
  editFrmla->SetFocus();

}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::FormDestroy(TObject *Sender)
{
  Tr->Close();
  delete Tr;
  delete ls;
  delete measst;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::edMemoChange(TObject *Sender)
{
  btSave->Enabled=true;
}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::editFrmlaChange(TObject *Sender)
{
  btSave->Enabled=true;
}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::vtArgAfterEdit(TDataSet *DataSet)
{
  btSave->Enabled=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::cbObjTypeSelect(TObject *Sender)
{
  Temp2=cbObjType->ItemIndex;
  if (btSave->Enabled)
  {
    cbObjType->ItemIndex=Temp;

    int choice=MessageBox(Handle, Reconst_smes69_2.c_str(), Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION);
    if (choice==IDYES)
    {
        vSave(this);
        if((editFrmla->Text=="")||(argFree)||(!compiled)) return;
    }
    if (choice==IDCANCEL)
        return;
    if (choice==IDNO)
        cbObjType->ItemIndex=Temp2;
  }
  oqGetFrmla->ParamByName("an_meas")->AsInteger=(long)cbObjType->Items->Objects[cbObjType->ItemIndex];

  vRead();

  Temp=cbObjType->ItemIndex;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::grArgColumns1EditButtonClick(
      TObject *Sender, bool &Handled)
{
  static k;
  TfmSelectPoint*sp;
  GROUPDATAFORM gdf(vtArgvtArgVPARAM->AsString);
  if(vtArgvtArgVPARAM->AsString.IsEmpty())
    gdf.gid=id;
  sp = new TfmSelectPoint(this, &gdf);
  sp->Caption = Reconst_smes69_3;
  sp->HelpContext=16031;
  if(sp->ShowModal()==mrOk){
    vtArg->Edit();
    vtArgvtArgVPARAM->AsString=gdf.Meas;
    if(vtArgvtArgVNAME->AsString=="")
      vtArgvtArgVNAME->AsString="P"+IntToStr(k++);
    if (vtArgvtArgVMEMO->AsString=="")
      vtArgvtArgVMEMO->AsString=sp->TreeViewMeas->Selected->Text;
      //vtArgvtArgVPntName->AsString=sp->tvMain->Selected->Text;
      oqPntName->ParamByName("av_param")->AsString=gdf.Meas;
      oqPntName->Execute();
      vtArgvtArgVPntName->AsString=oqPntName->ParamByName("av_pntname")->AsString;
    vtArg->Post();
  }
  delete sp;
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::tbAddArgClick(TObject *Sender)
{
    Argument=grArg->Fields[0]->Text;
    int i=editFrmla->SelStart;

    editFrmla->Text=editFrmla->Text.Delete(i+1,editFrmla->SelLength);
    editFrmla->Text=editFrmla->Text.Insert(Argument,i+1);
    editFrmla->SelStart=i;
    editFrmla->SelLength=Argument.Length();
    editFrmla->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::iaDeleteExecute(TObject *Sender)
{
  if(MessageBox(Handle,AnsiString(Reconst_smes69_4).c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)!=IDYES)
    return;
  try
  {
  oqClear->ParamByName("an_mid")->AsInteger=id;
  oqClear->ParamByName("an_meas")->AsInteger=(long)cbObjType->Items->Objects[cbObjType->ItemIndex];
  oqClear->Execute();
  edMemo->Text="";
  editFrmla->Text="";
  vtArg->Clear();
  btSave->Enabled=false;
  dmMain->orases->Commit();
  }
  catch (Exception &exception){
    dmMain->orases->Rollback();
  	Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::tbAnalyseClick(TObject *Sender)
{
  SavePlace = vtArg->GetBookmark();
  if(editFrmla->Text.Trim()==""){
    MessageBox(Handle, Reconst_smes69_5.c_str(),Application->Title.c_str(),MB_OK | MB_ICONERROR);
    return;
  }
  SFormula *sf;
  if(vtArg->State==dsEdit)
    vtArg->Post();

  oqAnalyse->ParamByName("at_paramname")->Length=0;
  oqAnalyse->ParamByName("at_paramname")->Length=500;
  oqAnalyse->ParamByName("av_formula")->AsString=editFrmla->Text;
  oqAnalyse->Execute();
  if(oqAnalyse->ParamByName("code")->AsInteger!=0){
    MessageBox(Handle,oqAnalyse->ParamByName("av_error")->AsString.c_str(),Application->Title.c_str(),MB_OK|MB_ICONERROR);
    oqAnalyse->Close();
    return;
  }
  vtArg->DisableControls();
  vtArg->First();
  int i=0;
  while(!vtArg->Eof){
    sf=new SFormula(vtArgvtArgVNAME->AsString,vtArgvtArgVPARAM->AsString,vtArgvtArgVMEMO->AsString,vtArgvtArgValue->AsFloat,vtArgvtArgVShift->AsFloat);
    ls->Capacity=++i;
    ls->Add((void*)sf);
    vtArg->Next();
  }
  vtArg->Clear(); 
  for (int i=1; i<=oqAnalyse->ParamByName("at_paramname")->Length; i++){
    if(oqAnalyse->ParamByName("at_paramname")->ItemAsString[i].Trim().IsEmpty())
      break;
    vtArg->Append();
    vtArgvtArgVNAME->AsString=oqAnalyse->ParamByName("at_paramname")->ItemAsString[i];
    vtArgvtArgValue->AsFloat=0;
    vtArgvtArgVShift->AsFloat=0;
    for(int k=0;k<ls->Count;k++){
      sf=(SFormula*)ls->Items[k];
      if(sf->vname==vtArgvtArgVNAME->AsString){
        vtArgvtArgVPARAM->AsString=sf->vparam;
        vtArgvtArgVMEMO->AsString=sf->vmemo;
        vtArgvtArgValue->AsFloat=sf->val;
        vtArgvtArgVShift->AsFloat=sf->shift;
        oqPntName->ParamByName("av_param")->AsString=sf->vparam;
        oqPntName->Execute();
        vtArgvtArgVPntName->AsString=oqPntName->ParamByName("av_pntname")->AsString;

        break;
      }
    }
    vtArg->Post();
  }
  for(int i=0; i<ls->Count; i++){
    delete (SFormula*)ls->Items[i];
  }
  ls->Clear();
  vtArg->First();
  vtArg->EnableControls();
  oqAnalyse->Close();
  grArg->SetFocus();

  vtArg->GotoBookmark(SavePlace);
  vtArg->FreeBookmark(SavePlace);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::tbTestClick(TObject *Sender)
{
 Compiling(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::FormCloseQuery(TObject *Sender,
      bool &CanClose)
{
  if (btSave->Enabled){
    int choice=MessageBox(Handle, Reconst_smes69_2.c_str(), Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION);
    if (choice==IDYES){
      vSave(this);
      if((editFrmla->Text=="")||(argFree)||(!compiled))  CanClose=false;
    }
    if (choice==IDCANCEL)
      CanClose=false;
  }
}
//---------------------------------------------------------------------------
void	__fastcall TfmEditFormula::WMInsertFormula(TMessage& Message)
{
  editFrmlaDragDrop(NULL,(TObject *)Message.WParam,0,0);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::iaSaveFormulaExecute(TObject *Sender)
{
  SavePlace = vtArg->GetBookmark();
  argFree=false;
  vtArg->First();
  while (!vtArg->Eof){
   if ((vtArg->FieldByName("vtArgVNAME")->AsString=="")||(vtArg->FieldByName("vtArgVPARAM")->AsString=="")) argFree=true;
   vtArg->Next();
  }
  if((editFrmla->Text.Trim()=="")||(argFree)){
    MessageBox(Handle, Reconst_smes69_1.c_str(),Application->Title.c_str(),MB_OK | MB_ICONERROR);
    return;
  }
  try {
    oqSaveFormula->ParamByName("an_id")->Clear();
    oqSaveFormula->ParamByName("an_parent")->Clear();
    oqSaveFormula->ParamByName("an_type")->AsInteger=1;
    oqSaveFormula->ParamByName("av_name")->AsString=Reconst_smes69_7;
    oqSaveFormula->ParamByName("av_formula")->AsString=editFrmla->Text;
    oqSaveFormula->ParamByName("av_memo")->AsString=edMemo->Text;

    int i=0;
    vtArg->First();
    while (!vtArg->Eof)
    {
      i++;
      oqSaveFormula->ParamByName("at_name")->ItemAsString[i]=vtArg->FieldByName("vtArgVNAME")->AsString;
      oqSaveFormula->ParamByName("at_param")->ItemAsString[i]=vtArg->FieldByName("vtArgVPARAM")->AsString;
      oqSaveFormula->ParamByName("at_memo")->ItemAsString[i]=vtArg->FieldByName("vtArgVMEMO")->AsString;
      vtArg->Next();
    }

    if(!i)
    {
      i++;
      oqSaveFormula->ParamByName("at_name")->ItemAsString[i]="";
      oqSaveFormula->ParamByName("at_param")->ItemAsString[i]="";
      oqSaveFormula->ParamByName("at_memo")->ItemAsString[i]="";
    }

    oqSaveFormula->ParamByName("at_name")->Length=i;
    oqSaveFormula->ParamByName("at_param")->Length=i;
    oqSaveFormula->ParamByName("at_memo")->Length=i;
    oqSaveFormula->Execute();
    dmMain->orases->Commit();

    TfmTree::SFunction *sf=new TfmTree::SFunction;

    sf->nid=oqSaveFormula->ParamByName("an_id")->AsInteger;
    sf->nparent=0;
    sf->ntype=1;
    sf->vname=Reconst_smes69_7;
    sf->vvalue=editFrmla->Text;
    sf->vmemo=edMemo->Text;

    TTreeNode *NewNode=Tr->tvFunctions->Items->AddChildObject(NULL,sf->vname,sf);
    NewNode->ImageIndex=2;
    NewNode->SelectedIndex=2;
    Tr->Show();
    Tr->tvFunctions->SetFocus();
    NewNode->Selected=true;
  }
  catch (Exception &exception){
    dmMain->orases->Rollback();
  	Application->ShowException(&exception);
  }
  vtArg->GotoBookmark(SavePlace);
  vtArg->FreeBookmark(SavePlace);
}
//---------------------------------------------------------------------------
void __fastcall TfmEditFormula::iaEditParamsExecute(TObject *Sender)
{
  int z;

  SavePlace = vtArg->GetBookmark();
  static k;
  TfmSelectPoint*sp;
  GROUPDATAFORM gdf(vtArgvtArgVPARAM->AsString);
  if(vtArgvtArgVPARAM->AsString.IsEmpty())
    gdf.gid=id;
  sp = new TfmSelectPoint(this, &gdf);
  sp->Caption = Reconst_smes69_3;
  if(sp->ShowModal()==mrOk){

    if (!grArg->SelectedRows->Count){
      vtArg->Edit();
      if(vtArgvtArgVPARAM->AsString.IsEmpty()){
          if((!vtArgvtArgVNAME->AsString.IsEmpty())&&measst->Find(vtArgvtArgVNAME->AsString.UpperCase(),z))
            vtArgvtArgVPARAM->AsString=TdmMain::GetStr(gdf.Meas,0,".")+"."+TdmMain::GetStr(gdf.Meas,1,".")+"."+vtArgvtArgVNAME->AsString.UpperCase();
          else
            vtArgvtArgVPARAM->AsString=gdf.Meas;
      }
      else{
          vtArgvtArgVPARAM->AsString=TdmMain::GetStr(gdf.Meas,0,".")+"."+TdmMain::GetStr(gdf.Meas,1,".")+"."+TdmMain::GetStr(vtArgvtArgVPARAM->AsString,2,".");
      }
      if(vtArgvtArgVNAME->AsString=="")
        vtArgvtArgVNAME->AsString="P"+IntToStr(k++);
      if (vtArgvtArgVMEMO->AsString=="")
        vtArgvtArgVMEMO->AsString=sp->TreeViewMeas->Selected->Text;
        //Добавление имени объекта по его ИД
      oqPntName->ParamByName("av_param")->AsString=vtArgvtArgVPARAM->AsString;
      oqPntName->Execute();
      vtArgvtArgVPntName->AsString=oqPntName->ParamByName("av_pntname")->AsString;
      vtArg->Post();
   }

   else{
    for (int i=0; i<grArg->SelectedRows->Count; i++){
      vtArg->GotoBookmark((void *)grArg->SelectedRows->Items[i].c_str());
      vtArg->Edit();
      if(vtArgvtArgVPARAM->AsString.IsEmpty()){
        if((!vtArgvtArgVNAME->AsString.IsEmpty())&&measst->Find(vtArgvtArgVNAME->AsString.UpperCase(),z))
          vtArgvtArgVPARAM->AsString=TdmMain::GetStr(gdf.Meas,0,".")+"."+TdmMain::GetStr(gdf.Meas,1,".")+"."+vtArgvtArgVNAME->AsString.UpperCase();
        else
          vtArgvtArgVPARAM->AsString=gdf.Meas;
      }
      else
        vtArgvtArgVPARAM->AsString=TdmMain::GetStr(gdf.Meas,0,".")+"."+TdmMain::GetStr(gdf.Meas,1,".")+"."+TdmMain::GetStr(vtArgvtArgVPARAM->AsString,2,".");

      if(vtArgvtArgVNAME->AsString=="")
        vtArgvtArgVNAME->AsString="P"+IntToStr(k++);
      if (vtArgvtArgVMEMO->AsString=="")
        vtArgvtArgVMEMO->AsString=sp->TreeViewMeas->Selected->Text;
        //Добавление имени объекта по его ИД
        oqPntName->ParamByName("av_param")->AsString=vtArgvtArgVPARAM->AsString;
        oqPntName->Execute();
        vtArgvtArgVPntName->AsString=oqPntName->ParamByName("av_pntname")->AsString;

      vtArg->Post();
    }
   }
  }
  delete sp;
  vtArg->GotoBookmark(SavePlace);
  vtArg->FreeBookmark(SavePlace);

}
//---------------------------------------------------------------------------
bool __fastcall TfmEditFormula::Compiling(TObject *Sender)
{
  if(vtArg->State==dsEdit)
    vtArg->Post();

  if(editFrmla->Text.Trim()==""){
    MessageBox(Handle, Reconst_smes69_5.c_str(),Application->Title.c_str(),MB_OK | MB_ICONERROR);
    return false;

  }

  oqTest->ParamByName("av_formula")->AsString=editFrmla->Text;
  int i=0;

  vtArg->DisableControls();
  vtArg->First();
  while (!vtArg->Eof)
  {
    i++;
    oqTest->ParamByName("at_paramname")->ItemAsString[i]=vtArgvtArgVNAME->AsString;
    if(vtArgvtArgValue->AsString=="")  oqTest->ParamByName("at_paramvalue")->ItemAsInteger[i]=0;
    else
      oqTest->ParamByName("at_paramvalue")->ItemAsFloat[i]=vtArgvtArgValue->AsFloat;

    vtArg->Next();
  }
  vtArg->First();
  vtArg->EnableControls();

  if(!i)
    {
      i++;
      oqTest->ParamByName("at_paramname")->ItemAsString[i]=" ";
      oqTest->ParamByName("at_paramvalue")->ItemAsInteger[i]=0;
    }

    oqTest->ParamByName("at_paramname")->Length=i;
    oqTest->ParamByName("at_paramvalue")->Length=i;

  oqTest->Execute();
  if (!oqTest->ParamByName("code")->AsInteger) //Если нет ошибки
  {
        sbResult->SimpleText=Reconst_smes69_10+oqTest->ParamByName("an_res")->AsString;
        return true;

  }else{
      ShowMessage (oqTest->ParamByName("av_error")->AsString);
      sbResult->SimpleText="############";
      return false;
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::tbOccurrencesShow(TObject *Sender)
{
  if(0 == pcEditFormula->Tag)
  { //если первы раз открыли вкладку или сделали какие то изменения и нажали кнопку приминить
    TreeMid->Items->Clear();
    ReadTreeMid(NULL);
    ReadTreeOccurr(NULL);
    pcEditFormula->Tag = 1;
  }
}
//---------------------------------------------------------------------------

void __fastcall  TfmEditFormula::ReadTreeMid(TTreeNode* Node)
{

  if(!Node)
    oqTree->ParamByName("an_mid")->AsInteger = id;
  else if(Node->getFirstChild()->Text == "1") //срабатывает при Expanding
  { oqTree->ParamByName("an_mid")->AsInteger = (int)Node->Data;
    Node->DeleteChildren();
  }
  else
    return; //еcли ветка была построена
  oqTree->Execute();
  oqTree->First();
  TTreeNode *CurrNode = NULL;
  while(!oqTree->Eof)
  { int nid = oqTree->FieldByName("IND")->AsInteger;
    CurrNode = TreeMid->Items->AddChildObject(Node,
                                              oqTree->FieldByName("TEXT")->AsString,
                                              (void*)oqTree->FieldByName("PARAM")->AsInteger);
    if(1 == oqTree->FieldByName("HAVECHILDE")->AsInteger)
    { TreeMid->Items->AddChildObject(CurrNode,"1", NULL);
      nid = 94;     //иконка функции
    }
    else
    { if(4 == nid)
        nid = 92;  //зеленый кружок
      else
        nid = 93; //синий кружок
    }
    CurrNode->ImageIndex    = nid;
    CurrNode->StateIndex    = nid;
    CurrNode->SelectedIndex = nid;
    oqTree->Next();
  }//end while
}

//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::TreeMidExpanding(TObject *Sender, TTreeNode *Node, bool &AllowExpansion)
{
  ReadTreeMid(Node);
}
//---------------------------------------------------------------------------

void 	__fastcall TfmEditFormula::ReadTreeOccurr(TTreeNode* Node)
{
  if(!Node){
    oqOccurr->ParamByName("an_mid")->AsInteger = id;
    oqOccurr->ParamByName("an_param")->Clear();
 } else if(Node->getFirstChild()->Text == "1") //срабатывает при Expanding
  { oqOccurr->ParamByName("an_mid")->AsInteger = id;
    oqOccurr->ParamByName("an_param")->AsInteger = (int)Node->Data;
    Node->DeleteChildren();
  }
  else
    return; //еcли ветка была построена
  oqOccurr->Execute();
  oqOccurr->First();
  TTreeNode *CurrNode = NULL;
  while(!oqOccurr->Eof)
  { CurrNode = TreeOccurr->Items->AddChildObject(Node,
                                                  oqOccurr->FieldByName("TEXT")->AsString,
                                                  (void*)oqOccurr->FieldByName("MID")->AsInteger);
   int nid=oqOccurr->FieldByName("IND")->AsInteger ;
    if(1 == oqOccurr->FieldByName("HAVECHILDE")->AsInteger)
    {
      TreeOccurr->Items->AddChildObject(CurrNode,"1", NULL);
      nid = 94;     //иконка функции
    }
    else
    { if(4 == nid)
        nid = 92;  //зеленый кружок
      else
        nid = (1 == nid)?94:93; //синий кружок
    }
    CurrNode->ImageIndex    = nid;
    CurrNode->StateIndex    = nid;
    CurrNode->SelectedIndex = nid;
    oqOccurr->Next();
  }//end while
}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::TreeOccurrExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  ReadTreeOccurr(Node);
}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::cbHourPeriodClick(TObject *Sender)
{
  cbThirty_min->Enabled = cbHourPeriod->Checked;
  if(!cbHourPeriod->Checked)
    cbThirty_min->Checked = false;
  btSave->Enabled=true;
}
//---------------------------------------------------------------------------

void __fastcall TfmEditFormula::cbThirty_minClick(TObject *Sender)
{
  btSave->Enabled=true;
}
//---------------------------------------------------------------------------

