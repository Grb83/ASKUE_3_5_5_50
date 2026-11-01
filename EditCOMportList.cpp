//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "EditCOMportList.h"
#include "Reconst.hpp"
#include "unViewTree.h"
#include "unComportEvents.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
#define MAXCOUNTTYPE 100
#define MAXCOUNTARRAY 100
//---------------------------------------------------------------------------
#define COMLISTSIZE 100
//---------------------------------------------------------------------------
__fastcall TFormEditCOMportList::TFormEditCOMportList(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
  OldScanIndex=0;
}
//---------------------------------------------------------------------------
void  TFormEditCOMportList::TreeRead()
{
   COMPORTS *pData;
   TTreeNode* Sl;
   try{
      dmMain->oqCursor->Params->Clear();
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"COMPORTS_PG.read_tree(:par1,:par2); end;";
      dmMain->oqCursor->ParamByName("par1")->AsInteger=(int)cbScan->Items->Objects[cbScan->ItemIndex];
      dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
      dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
      dmMain->oqCursor->Execute();
      while(!dmMain->oqCursor->Eof){
      pData=new COMPORTS;
      ZeroMemory(pData, sizeof(*pData));
      if(!dmMain->oqCursor->FieldByName("com_id")->IsNull)
        strcpy(pData->COM_ID,dmMain->oqCursor->FieldByName("com_id")->AsString.c_str());
      if(!dmMain->oqCursor->FieldByName("name")->IsNull)
        strcpy(pData->NAME,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
      if(!dmMain->oqCursor->FieldByName("baudrate")->IsNull)
        strcpy(pData->BAUDRATE,dmMain->oqCursor->FieldByName("baudrate")->AsString.c_str());
      if(!dmMain->oqCursor->FieldByName("bytesize")->IsNull)
        strcpy(pData->BYTESIZE,dmMain->oqCursor->FieldByName("bytesize")->AsString.c_str());
      if(!dmMain->oqCursor->FieldByName("parity")->IsNull)
        strcpy(pData->PARITY,dmMain->oqCursor->FieldByName("parity")->AsString.c_str());
      if(!dmMain->oqCursor->FieldByName("stopbits")->IsNull)
        strcpy(pData->STOPBITS,dmMain->oqCursor->FieldByName("stopbits")->AsString.c_str());
      if(!dmMain->oqCursor->FieldByName("ncomtype")->IsNull)
        strcpy(pData->NLINKTYPE,dmMain->oqCursor->FieldByName("ncomtype")->AsString.c_str());
      if(!dmMain->oqCursor->FieldByName("ntarifftype")->IsNull)
        pData->nTariffType=dmMain->oqCursor->FieldByName("ntarifftype")->AsInteger;
      if(!dmMain->oqCursor->FieldByName("nonlyone")->IsNull)
        pData->nOnlyOne=dmMain->oqCursor->FieldByName("nonlyone")->AsInteger;
            Sl=TreeView1->Items->AddObject(NULL,pData->NAME, pData);
            Sl->ImageIndex=pData->nOnlyOne?20:21;
            Sl->SelectedIndex=Sl->ImageIndex;
        dmMain->oqCursor->Next();
        }
      Sl = TreeView1->Items->GetFirstNode();
      if(Sl)
         TreeView1->Selected = Sl;
      EditRec=false;
      TreeView1->Invalidate();
   }catch(Exception&e){
      Application->ShowException(&e);
   }
}
//---------------------------------------------------------------------------
void  TFormEditCOMportList::TreeWrite()
{  int i;
   char massag[200];
   TTreeNode* pNode;
   COMPORTS tData, *pData;
   try{
      pNode = TreeView1->Items->GetFirstNode();
      while(pNode){
         memcpy(&tData, pNode->Data, sizeof(COMPORTS));
         if(tData.pEdit){
          dmMain->oqCursor->Params->Clear();
          dmMain->oqCursor->SQL->Text="begin "+SchemeName+"comports_pg.upd_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7); end;";
          dmMain->oqCursor->ParamByName("par1")->AsString=tData.COM_ID;
          dmMain->oqCursor->ParamByName("par2")->AsString=tData.BAUDRATE;
          dmMain->oqCursor->ParamByName("par3")->AsString=tData.BYTESIZE;
          dmMain->oqCursor->ParamByName("par4")->AsString=tData.PARITY;
          dmMain->oqCursor->ParamByName("par5")->AsString=tData.STOPBITS;
          dmMain->oqCursor->ParamByName("par6")->AsString=tData.NLINKTYPE;
          dmMain->oqCursor->ParamByName("par7")->AsInteger=tData.nTariffType;
          //dmMain->oqCursor->ParamByName("par8")->AsInteger=(int)cbScan->Items->Objects[cbScan->ItemIndex];
          dmMain->oqCursor->Execute();
        }
         pNode = pNode->GetNext();
      }
      dmMain->orases->Commit();
      EditRec=false;
   }catch(Exception&e){
      Application->ShowException(&e);
      dmMain->orases->Rollback();
      TreeView1->Selected=TreeView1->Items->Item[i];
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::TreeView1Change(TObject *Sender,
	TTreeNode *Node)
{
    if(TreeView1->Selected==NULL) return;
    // снятие обработчиков
    TComboBox*cmb;
    TRadioGroup*rg;
    TCheckBox*cb;

    for(long i=0; i<ComponentCount; i++){
        cmb=dynamic_cast<TComboBox*>(Components[i]);
        rg=dynamic_cast<TRadioGroup*>(Components[i]);
        cb=dynamic_cast<TCheckBox*>(Components[i]);
        if(cmb){
            cmb->OnChange = NULL;
        }else if(rg){
            rg->OnClick = NULL;
        }else if(cb){
         cb->OnClick = NULL;
        }
    }
   COMPORTS* sGruop=(COMPORTS*)TreeView1->Selected->Data;

   RadioGroup1->ItemIndex=(-1);
   RadioGroup2->ItemIndex=(-1);
   RadioGroup3->ItemIndex=(-1);
   ComboBox1->Text=sGruop->BAUDRATE;
   cbScan->ItemIndex=OldScanIndex;
   for(int i=0; i < cbTypeList->Items->Count; i++) {
      long pff = (long)cbTypeList->Items->Objects[i];
      if(pff == atoi(sGruop->NLINKTYPE)){
         cbTypeList->ItemIndex = i;
         break;
      }
   }
   // определение типа тарифа для выделенного com-порта
   for(int i=0; i<cbTariffType->Items->Count; i++){
      long pff = (long)cbTariffType->Items->Objects[i];
      if(pff == sGruop->nTariffType){
         cbTariffType->ItemIndex = i;
         break;
      }
   }
    if(strlen(sGruop->BYTESIZE)) RadioGroup1->ItemIndex=atoi(sGruop->BYTESIZE)-4;
    if(strlen(sGruop->PARITY))   RadioGroup3->ItemIndex=atoi(sGruop->PARITY);
    if(strlen(sGruop->STOPBITS)) RadioGroup2->ItemIndex=atoi(sGruop->STOPBITS);
    // восстановление обработчиков
    for(long i=0; i<ComponentCount; i++){
        cmb=dynamic_cast<TComboBox*>(Components[i]);
        rg=dynamic_cast<TRadioGroup*>(Components[i]);
        if(cmb){
            cmb->OnChange = ComboBoxChange;
        }else if(rg){
            rg->OnClick = RadioGroupClick;
        }
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::cbTypeChange(TObject *Sender)
{
  if(TreeView1->Selected==NULL) return;
  COMPORTS* sGruop=(COMPORTS*)TreeView1->Selected->Data;
  EditRec=true;
  strcpy(sGruop->BAUDRATE,ComboBox1->Text.c_str());
  sGruop->pEdit=2;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::RadioGroup1Click(TObject *Sender)
{
  if(TreeView1->Selected==NULL) return;
  COMPORTS* sGruop=(COMPORTS*)TreeView1->Selected->Data;
  EditRec=true;
  sprintf(sGruop->BYTESIZE,"%d",(RadioGroup1->ItemIndex+4));
  sGruop->pEdit=2;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::RadioGroup2Click(TObject *Sender)
{
  if(TreeView1->Selected==NULL) return;
  COMPORTS* sGruop=(COMPORTS*)TreeView1->Selected->Data;
  EditRec=true;
  sprintf(sGruop->STOPBITS,"%d",(RadioGroup2->ItemIndex));
  sGruop->pEdit=2;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::RadioGroup3Click(TObject *Sender)
{
  if(TreeView1->Selected==NULL) return;
  COMPORTS* sGruop=(COMPORTS*)TreeView1->Selected->Data;
  EditRec=true;
  sprintf(sGruop->PARITY,"%d",(RadioGroup3->ItemIndex));
  sGruop->pEdit=2;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::vSave(TObject *Sender)
{ //save
   TreeWrite();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::vRefresh(TObject *Sender)
{ //consel
   TreeView1->Items->BeginUpdate();
   try{
   TreeView1->Items->Clear();
   LoadTypes();
   LoadTariffType();
   TreeRead();
   }catch(Exception &e){
   TreeView1->Items->EndUpdate();
   throw;
   }
   TreeView1->Items->EndUpdate();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::SetAccess(TAccess value)
{
   if(FAccess != value){
      TMainForm::SetAccess(value);
      bool wr = (FAccess = value)==accWrite;
      Panel5->Enabled = wr;
   }
}
//---------------------------------------------------------------------------
bool __fastcall TFormEditCOMportList::LoadTypes(void)
{
 try {
  dmMain->oqCursor->Params->Clear();
  dmMain->oqCursor->SQL->Text="begin "+SchemeName+"COMPORTS_PG.load_types(:par1); end;";
  dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
  dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;
  dmMain->oqCursor->Execute();
  cbTypeList->Clear();
  while(!dmMain->oqCursor->Eof){
     cbTypeList->Items->AddObject(dmMain->oqCursor->FieldByName("VNAME")->AsString,
                      (TObject *)dmMain->oqCursor->FieldByName("NCOMTYPE")->AsInteger);
     dmMain->oqCursor->Next();
     }
 } catch (Exception &exception){
   Application->ShowException(&exception);
   return false;
 }
   return true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::cbTypeListChange(TObject *Sender)
{
  if(TreeView1->Selected==NULL) return;
  COMPORTS* sGruop=(COMPORTS*)TreeView1->Selected->Data;
  EditRec=true;
  strcpy(sGruop->NLINKTYPE, IntToStr((long)cbTypeList->Items->Objects[cbTypeList->ItemIndex]).c_str());
  sGruop->pEdit=2;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::FormShow(TObject *Sender)
{
    cbScan->Items->Clear();
    for(int i=0;i<dmMain->SrvList->Count;i++)
          cbScan->Items->AddObject(dmMain->SrvList->Strings[i],(TObject *)dmMain->SrvList->Objects[i]);
    cbScan->ItemIndex=0;

  if(dmMain->SrvList->Count==1){
    Panel3->Visible=false;
    Panel3->Width=1;
    }
  vRefresh(Sender);
}
//---------------------------------------------------------------------------
//загрузка списка типов тарифа
bool __fastcall TFormEditCOMportList::LoadTariffType()
{
 try {
   dmMain->oqCursor->Params->Clear();
   dmMain->oqCursor->SQL->Text="begin "+SchemeName+"COMPORTS_PG.load_tariff_type(:par1); end;";
   dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
   dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;
   dmMain->oqCursor->Execute();
   cbTariffType->Clear();
   cbTariffType->Items->AddObject("",0);
   while(!dmMain->oqCursor->Eof)
   {
      cbTariffType->Items->AddObject(dmMain->oqCursor->FieldByName("vname")->AsString,
                                 (TObject *)dmMain->oqCursor->FieldByName("ntarifftype")->AsInteger);
      dmMain->oqCursor->Next();
    }

 } catch (Exception &exception){
   Application->ShowException(&exception);
   return false;
 }
   return true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::cbTariffTypeChange(TObject *Sender)
{
   if(TreeView1->Selected==NULL) return;
   COMPORTS* sGruop=(COMPORTS*)TreeView1->Selected->Data;
   if(sGruop->nTariffType == (long)cbTariffType->Items->Objects[cbTariffType->ItemIndex])
      return;
   EditRec=true;
   sGruop->nTariffType = (long)cbTariffType->Items->Objects[cbTariffType->ItemIndex];
   sGruop->pEdit=2;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::TreeView1Deletion(TObject *Sender,
      TTreeNode *Node)
{
   if(Node->Data)
      delete Node->Data;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::ComboBoxChange(TObject *Sender)
{
   if(Sender==ComboBox1)
      cbTypeChange(Sender);
   else if(Sender==cbTypeList)
      cbTypeListChange(Sender);
   else if(Sender==cbTariffType)
      cbTariffTypeChange(Sender);
   else if(Sender==cbScan)
       cbScanChange(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::RadioGroupClick(TObject *Sender)
{
   if(Sender==RadioGroup1)
      RadioGroup1Click(Sender);
   else if(Sender==RadioGroup2)
      RadioGroup2Click(Sender);
   else if(Sender==RadioGroup3)
      RadioGroup3Click(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::btnChanListClick(TObject *Sender)
{
   long Com;
   if(TreeView1->Selected && TreeView1->Selected->Data)
   {
      Com = StrToInt(((COMPORTS*)TreeView1->Selected->Data)->COM_ID);
      TfmViewTree *f = new TfmViewTree(this, Reconst_smes43_7, Com, CHANN_IN_COM);
      f->ShowModal();
      delete f;
      //ShowChannelList(this, Com, CHANN_IN_COM);
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::cbScanChange(TObject *Sender)
{
if(EditRec){
      switch(MessageBox(Handle,Reconst_smes17_1.c_str(),Application->Title.c_str(),MB_YESNOCANCEL|MB_ICONQUESTION|MB_DEFBUTTON1)){
      case IDYES:
         vSave(Sender);
         if(EditRec){
            cbScan->OnChange=NULL;
            cbScan->ItemIndex=OldScanIndex;
            cbScan->OnChange=cbScanChange;
            return;
         }
         break;
      case IDCANCEL:
         cbScan->OnChange=NULL;
         cbScan->ItemIndex=OldScanIndex;
         cbScan->OnChange=cbScanChange;
         return;
      case IDNO:
         EditRec = false;
      }
   }
   OldScanIndex=cbScan->ItemIndex;
   vRefresh(this);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditCOMportList::btJournalClick(TObject *Sender)
{
  AnsiString selectedCOM = "";
  if (TreeView1->Selected) selectedCOM = TreeView1->Selected->Text;
  TfmComportEvents *f=new TfmComportEvents(this,
    (int)cbScan->Items->Objects[cbScan->ItemIndex],
    selectedCOM);
  f->Show();
}
//---------------------------------------------------------------------------

