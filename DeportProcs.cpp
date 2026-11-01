//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <System.hpp>
#pragma hdrstop
#include "DeportProcRun.h"
#include "DeportProcs.h"
#include "Reconst.hpp"
#include "unViewTree.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmDeportProcs::TfmDeportProcs(TComponent* Owner, AnsiString Name, TAccess a)
  : TMainForm(Owner, Name, a)
{
   ShowAction(iaNew);
   ShowAction(iaDelete);
   SelProcess = NULL;
   Processes_Del_Count = 0;
   Processes_Del = NULL;
}
//---------------------------------------------------------------------------
__fastcall TfmDeportProcs::~TfmDeportProcs()
{
   Processes_Del_Count = 0;
   if(Processes_Del) delete[] Processes_Del;
   Processes_Del = NULL;
   delete PeriodName;
   PeriodName = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::FormShow(TObject *Sender)
{
  if(ReadCombo()&&ReadProcesses())
  {
      lvProcessChange(lvProcess,NULL,ctState);
      lvProcess->OnChange = lvProcessChange;
      if(lvProcess->Items->Count)
      {
        lvProcess->Selected = lvProcess->Items->Item[0];
        lvProcess->ItemFocused = lvProcess->Items->Item[0];
      }
      lvProcess->OnChanging = lvProcessChanging;
      lvProcess->SetFocus();
  }
  else
    Close();
}
//---------------------------------------------------------------------------
bool __fastcall TfmDeportProcs::ReadProcesses()
{
    stProcesses *PProcesses;
    TListItem *LI;
    try
    {
         dmMain->oqCursor->Params->Clear();
         dmMain->oqCursor->SQL->Text="begin "+SchemeName+"file_pg.read_processes(:par1,:par2); end;";
         dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
         dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;
         dmMain->oqCursor->ParamByName("par2")->AsInteger=2*(int)tbState0->Down+(int)tbState1->Down;
         dmMain->oqCursor->Execute();
           while(!dmMain->oqCursor->Eof){
            PProcesses = new stProcesses;
            ZeroMemory(PProcesses,sizeof(stProcesses));
            if(!dmMain->oqCursor->FieldByName("ntype")->IsNull)
           PProcesses->NType=dmMain->oqCursor->FieldByName("ntype")->AsInteger;
           if(!dmMain->oqCursor->FieldByName("nmaket")->IsNull)
           PProcesses->nMaket=dmMain->oqCursor->FieldByName("nmaket")->AsInteger;
           if(!dmMain->oqCursor->FieldByName("vname")->IsNull)
           strcpy(PProcesses->vName,dmMain->oqCursor->FieldByName("vname")->AsString.c_str());
           if(!dmMain->oqCursor->FieldByName("nprocedure")->IsNull)
           PProcesses->nProcedure=dmMain->oqCursor->FieldByName("nprocedure")->AsInteger;
           if(!dmMain->oqCursor->FieldByName("vnote")->IsNull)
           strcpy(PProcesses->vNote,dmMain->oqCursor->FieldByName("vnote")->AsString.c_str());
           if(!dmMain->oqCursor->FieldByName("nperiod")->IsNull)
           strcpy(PProcesses->vPeriod,dmMain->oqCursor->FieldByName("nperiod")->AsString.c_str());
           if(!dmMain->oqCursor->FieldByName("nshift")->IsNull)
           PProcesses->nShift=dmMain->oqCursor->FieldByName("nshift")->AsInteger;
           if(!dmMain->oqCursor->FieldByName("vparam")->IsNull)
           strcpy(PProcesses->vParam,dmMain->oqCursor->FieldByName("vparam")->AsString.c_str());
           if(!dmMain->oqCursor->FieldByName("verror")->IsNull)
           strcpy(PProcesses->vError,dmMain->oqCursor->FieldByName("verror")->AsString.c_str());
           if(!dmMain->oqCursor->FieldByName("NextCreated")->IsNull)
           strcpy(PProcesses->vNextCreated,dmMain->oqCursor->FieldByName("NextCreated")->AsString.c_str());
           if(!dmMain->oqCursor->FieldByName("ncycle")->IsNull)
           PProcesses->nCycle=dmMain->oqCursor->FieldByName("ncycle")->AsInteger;
           if(!dmMain->oqCursor->FieldByName("nblock")->IsNull)
           PProcesses->nBlock=dmMain->oqCursor->FieldByName("nblock")->AsInteger;
           if(!dmMain->oqCursor->FieldByName("LastCreated")->IsNull)
           strcpy(PProcesses->vLastCreated,dmMain->oqCursor->FieldByName("LastCreated")->AsString.c_str());
                LI = lvProcess->Items->Add();
                LI->ImageIndex = PProcesses->nBlock;
                LI->Data = PProcesses;
                LI->SubItems->Add(PProcesses->vName);
                LI->SubItems->Add(PProcesses->nShift);
                LI->SubItems->Add(PProcesses->vPeriod);
           dmMain->oqCursor->Next();
           }
           dmMain->oqCursor->Close();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
        return false;
    }
    return true;
}
//---------------------------------------------------------------------------
bool __fastcall TfmDeportProcs::ReadCombo()
{
    stProcedures *Proc;
    if(!PeriodName)
      PeriodName = new TStringList();
    try
    {
        cbProcName->Clear();
        PeriodName->Clear();
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"file_pg.read_combo(:par1); end;";
        dmMain->oqCursor->ParamByName("par1")->ParamType = ptOutput;
        dmMain->oqCursor->ParamByName("par1")->DataType = ftCursor;
        dmMain->oqCursor->Execute();
        while(!dmMain->oqCursor->Eof){
          Proc=new stProcedures;
          ZeroMemory(Proc,sizeof(stProcedures));
          if(!dmMain->oqCursor->FieldByName("nprocedure")->IsNull)
            Proc->nProsedure=dmMain->oqCursor->FieldByName("nprocedure")->AsInteger;
          if(!dmMain->oqCursor->FieldByName("vname")->IsNull)
            strcpy(Proc->vName,dmMain->oqCursor->FieldByName("vname")->AsString.c_str());
          if(!dmMain->oqCursor->FieldByName("nperiod")->IsNull)
            strcpy(Proc->vPeriod,dmMain->oqCursor->FieldByName("nperiod")->AsString.c_str());
          cbProcName->Items->AddObject(Proc->vName, (TObject*)Proc->nProsedure);
          PeriodName->Add(Proc->vPeriod);
          dmMain->oqCursor->Next();
        }
        dmMain->oqCursor->Close();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
        return false;
    }
    return true;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::lvProcessChanging(TObject *Sender,
      TListItem *Item, TItemChange Change, bool &AllowChange)
{
    if(!(Change==ctState)||!SelProcess||SelProcess->editing==0)
      return;
    TWinControl *Control=NULL;
    try
    {
        Control=(TWinControl *)eName;
        if(eName->Text.IsEmpty())
          throw Exception(Reconst_smes11_1);
        else
          strcpy(SelProcess->vName,eName->Text.c_str());

        Control=(TWinControl *)cbProcName;
        if(cbProcName->ItemIndex<0)
           throw Exception(Reconst_smes11_2);
        else
           SelProcess->nProcedure = (long)cbProcName->Items->Objects[cbProcName->ItemIndex];
        strcpy(SelProcess->vNote,mNote->Text.c_str());

        Control=(TWinControl *)eNShift;
        if(eNShift->Text.IsEmpty()||eNShift->Text.ToInt()<0)
          throw Exception(Reconst_smes11_3);
        else
          SelProcess->nShift = eNShift->Text.ToInt();

        strcpy(SelProcess->vParam,eParam->Text.c_str());

        SelProcess->nCycle = chbExecUnexecutingInTime->Checked;
        SelProcess->nBlock = chbBlocking->Checked;

    }
    catch (Exception &exception)
    {
        AllowChange = false;
        if(Control) Control->SetFocus();
        Application->ShowException(&exception);
    }
}
//---------------------------------------------------------------------------

void __fastcall TfmDeportProcs::lvProcessChange(TObject *Sender,
      TListItem *Item, TItemChange Change)
{
    if(!Change==ctState)
      return;
    paEdit->Enabled = ChangeControl = false;
    iaDelete->Enabled = false;
    btCanel->Enabled = false;
    SelProcess = NULL;
    for(int i=0; i<ComponentCount; i++)
    {
        if(dynamic_cast<TCustomEdit*>(Components[i]))
          ((TCustomEdit*)Components[i])->Clear();
        if(dynamic_cast<TComboBox*>(Components[i]))
          ((TComboBox*)Components[i])->ItemIndex = -1;
        if(dynamic_cast<TCheckBox*>(Components[i]))
        {
          ((TCheckBox*)Components[i])->Checked = false;
//          ControlChange(Components[i]);
        }
        if(dynamic_cast<TMemo*>(Components[i]))
          ((TMemo*)Components[i])->Clear();
    }
    lbId->Caption ="";
    if(!Item)
       return;
    SelProcess = (stProcesses*)Item->Data;
//add by NNV
    btCanel->Enabled = (SelProcess->NType == 0) ? true : false;
//end add by NNV
    eName->Text = SelProcess->vName;
    cbProcName->ItemIndex = cbProcName->Items->IndexOfObject((TObject*)SelProcess->nProcedure);
    mNote->Text = SelProcess->vNote;
    lbId->Caption = (SelProcess->nMaket>0)?IntToStr(SelProcess->nMaket):AnsiString("");
    eNShift->Text = SelProcess->nShift;
    eParam->Text = SelProcess->vParam;
    eLastDateRun->Text = SelProcess->vLastCreated;
    mError->Text = SelProcess->vError;
    eNextDateRun->Text = SelProcess->vNextCreated;
    chbExecUnexecutingInTime->Checked = SelProcess->nCycle;
    chbBlocking->Checked = SelProcess->nBlock;
    if(Access==accWrite) paEdit->Enabled = ChangeControl = true;
    iaDelete->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TfmDeportProcs::lvProcessDeletion(TObject *Sender,
      TListItem *Item)
{
   lvProcess->OnChanging = NULL;
   lvProcess->OnChange = NULL;
   if(((stProcesses*)Item->Data)->editing!=1)
   {
      Processes_Del_Count++;
      if(!Processes_Del)
        Processes_Del = new long[1];
      else
        Processes_Del = (long*)realloc(Processes_Del, (Processes_Del_Count*sizeof(long)));
      Processes_Del[Processes_Del_Count-1] = ((stProcesses*)Item->Data)->nMaket;
   }
   delete (stDeportProc*)Item->Data;
}
//---------------------------------------------------------------------------

void __fastcall TfmDeportProcs::edLongPress(TObject *Sender,
      char &Key)
{
#define Sender ((TEdit*)Sender)
  AnsiString S=(AnsiString)Key;
  AnsiString S1="0123456789\b\r";
  if(!S1.Pos(S)){
    Key=NULL;
    Beep();
    return;
  }
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::ChangeParams(TObject *Sender)
{
  if(SelProcess&&lvProcess->ItemFocused&&ChangeControl)
  {
     EditRec = true;
     SelProcess->editing = SelProcess->editing==1?1:2;
     if(Sender==eName)
        lvProcess->ItemFocused->SubItems->Strings[0] = eName->Text;
     if(Sender==chbBlocking)
         lvProcess->ItemFocused->ImageIndex = chbBlocking->Checked;
     if(Sender==eNShift)
        lvProcess->ItemFocused->SubItems->Strings[1] = eNShift->Text;
     if(Sender==cbProcName&&!(cbProcName->ItemIndex<0))
         lvProcess->ItemFocused->SubItems->Strings[2] = PeriodName->Strings[cbProcName->ItemIndex];
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::cbProcNameExit(TObject *Sender)
{
     lvProcess->OnChanging = lvProcessChanging;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::bbRunProcessClick(TObject *Sender)
{
  if(EditRec)
    throw Exception(Reconst_smes11_4);
  if(chbBlocking->Checked)
    throw Exception(Reconst_smes11_5);
  DeportProcedureRun(SelProcess->nMaket,this);
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::vSave(TObject *Sender)
{
  bool b=true;
  if(lvProcess->ItemFocused) lvProcessChanging(lvProcess,lvProcess->ItemFocused, ctState,b);
  if(!b) return;
  stProcesses ptrProc;
  int i;
  try{
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin \
                  if :par9>1 then "+SchemeName+"makets_pg.upd_m(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8); \
                  else "+SchemeName+"makets_pg.ins_m(:par2,:par3,:par4,:par5,:par6,:par7,:par8,:par1); \
                  end if; \
                end;";
    for(i=0; i<lvProcess->Items->Count; i++)
    {
      if(((stProcesses*)lvProcess->Items->Item[i]->Data)->editing>0)
      {
          memcpy(&ptrProc,(stProcesses*)lvProcess->Items->Item[i]->Data,sizeof(stProcesses));
          dmMain->oqCursor->ParamByName("par1")->DataType=ftInteger;
          dmMain->oqCursor->ParamByName("par1")->ParamType=ptInputOutput;
          dmMain->oqCursor->ParamByName("par1")->AsInteger=ptrProc.nMaket;
          dmMain->oqCursor->ParamByName("par2")->AsInteger=ptrProc.nProcedure;
          dmMain->oqCursor->ParamByName("par3")->AsString=ptrProc.vName;
          dmMain->oqCursor->ParamByName("par4")->AsString=ptrProc.vNote;
          dmMain->oqCursor->ParamByName("par5")->AsInteger=ptrProc.nBlock;
          dmMain->oqCursor->ParamByName("par6")->AsInteger=ptrProc.nCycle;
          dmMain->oqCursor->ParamByName("par7")->AsInteger=ptrProc.nShift;
          dmMain->oqCursor->ParamByName("par8")->AsString=ptrProc.vParam;
          dmMain->oqCursor->ParamByName("par9")->AsInteger=ptrProc.editing;
          dmMain->oqCursor->Execute();
          ptrProc.nMaket=dmMain->oqCursor->ParamByName("par1")->AsInteger;
      }
    }
    i = -1;
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"makets_pg.del_m(:par1); end;";
   
    for(int i=0; Processes_Del&&i<Processes_Del_Count; i++)
    {
         ptrProc.nMaket = Processes_Del[i];
         dmMain->oqCursor->ParamByName("par1")->AsInteger=ptrProc.nMaket;
         dmMain->oqCursor->Execute();
         }
    dmMain->orases->Commit();

    if(Processes_Del) delete[] Processes_Del;
    Processes_Del = NULL;
    Processes_Del_Count = 0;
    for(i=0; i<lvProcess->Items->Count; i++)
      ((stProcesses*)lvProcess->Items->Item[i]->Data)->editing = 0;
    EditRec=false;
  }
  catch (Exception &exception)
  {
     dmMain->orases->Rollback();
     Application->ShowException(&exception);
      if(!i<0)
      {
         lvProcess->Items->Item[i]->Selected = true;
         lvProcess->ItemFocused = lvProcess->Items->Item[i];
      }
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::vRefresh(TObject *Sender)
{
   lvProcess->OnChange=NULL;
   lvProcess->OnChanging=NULL;
   Screen->Cursor=crHourGlass;
   lvProcess->Items->Clear();
   if(ReadCombo()&&ReadProcesses())
      if(lvProcess->Items->Count>0){
         lvProcess->OnChange = lvProcessChange;
         lvProcess->Selected = lvProcess->Items->Item[0];
         lvProcess->ItemFocused = lvProcess->Items->Item[0];
      }
   Screen->Cursor=crDefault;
   lvProcess->OnChange = lvProcessChange;
   lvProcess->OnChanging = lvProcessChanging;
   EditRec=false;
   Processes_Del_Count = 0;
   if(Processes_Del) delete[] Processes_Del;
   Processes_Del = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::vNew(TObject *Sender)
{
    bool b=true;
    TListItem *LI;
    lvProcess->OnChange = NULL;
    lvProcess->OnChanging = NULL;
    if(lvProcess->ItemFocused) lvProcessChanging(lvProcess,lvProcess->ItemFocused, ctState,b);
    if(!b) return;
    stProcesses* NewProc = new stProcesses;
    ZeroMemory(NewProc, sizeof(stProcesses));

    NewProc->nMaket = -1;
    strcpy(NewProc->vName,Reconst_smes11_6.c_str());
    NewProc->nProcedure = (long)cbProcName->Items->Objects[0];

    NewProc->editing = 1;
    NewProc->nBlock = 1;
    LI = lvProcess->Items->Add();
    LI->ImageIndex = 1;
    LI->Data = NewProc;
    LI->SubItems->Add(NewProc->vName);
    LI->SubItems->Add("");
    LI->SubItems->Add("");
    LI->Selected = true;
    LI->Focused = true;
    EditRec = true;
    if(Access==accWrite) paEdit->Enabled = true;
    lvProcessChange(lvProcess,LI,ctState);
    ChangeParams(cbProcName);
    ChangeParams(eNShift);
    lvProcess->OnChange = lvProcessChange;
    lvProcess->OnChanging = lvProcessChanging;
    eName->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::vDelete(TObject *Sender)
{
    if(lvProcess->ItemFocused&&
       Application->MessageBox(AnsiString(Reconst_smes11_7+lvProcess->ItemFocused->SubItems->Strings[0]+"?").c_str(),
       Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES)
    {
       lvProcess->OnChanging = NULL;
       lvProcess->OnChange = NULL;
       int sel = lvProcess->ItemFocused->Index;
       lvProcess->ItemFocused->Delete();
       sel = lvProcess->Items->Count==sel?sel-1:sel;
       if(lvProcess->Items->Count==0)
           lvProcessChange(lvProcess, NULL, ctState);
       else
       {
           lvProcessChange(lvProcess, lvProcess->Items->Item[sel], ctState);
           lvProcess->Items->Item[sel]->Selected = true;
           lvProcess->Items->Item[sel]->Focused = true;
       }
       lvProcess->OnChange = lvProcessChange;
       lvProcess->OnChanging = lvProcessChanging;

       EditRec = true;
    }
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::lvProcessClick(TObject *Sender)
{
    if(!lvProcess->Selected&&lvProcess->Items->Count>0)
    {
        lvProcess->ItemFocused = lvProcess->Items->Item[lvProcess->Items->Count-1];
        lvProcess->ItemFocused->Selected = true;
    }

}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::SetAccess(TAccess value)
{
   if(FAccess != value){
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      iaNew->Enabled = wr;
      iaDelete->Enabled = wr;
      paEdit->Enabled = wr;
   }
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::Action1Execute(TObject *Sender)
{
  TfmViewTree *f = new TfmViewTree(this, Reconst_smes43_10, SelProcess->nMaket, CHANN_DISTRIBUTION);
  f->ShowModal();
  delete f;
  //ShowChannelList(this,SelProcess->nMaket, CHANN_DISTRIBUTION);
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::mMonClick(TObject *Sender)
{
   SetPopupMenu( Sender, SelProcess->nMaket,SelProcess->vName);
}
//---------------------------------------------------------------------------
void __fastcall TfmDeportProcs::tbStateClick(TObject *Sender)
{
  iaRefreshExecute(this);
}
//---------------------------------------------------------------------------

void __fastcall TfmDeportProcs::BitBtn1Click(TObject *Sender)
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
if (Language=="UKR"){
    SaveDialog1->Title = "Зберегти до файла...";
    SaveDialog1->FileName = "План виконання фонових процесів";
    SaveDialog1->DefaultExt = "xls";
    SaveDialog1->Filter = "Excel-таблиця (*.xls)|*.xls|Файл з роздільником (*.csv)|*.csv|Текстові документи (*.txt)|*.txt";
    }else{
    SaveDialog1->Title = "Сохранить в файл...";
    SaveDialog1->FileName = "План выполнения фоновых процессов";
    SaveDialog1->DefaultExt = "xls";
    SaveDialog1->Filter = "Excel-таблица (*.xls)|*.xls|Файл с разделителем (*.csv)|*.csv|Текстовые документы (*.txt)|*.txt";
    }
SaveDialog1->Options << ofOverwritePrompt;
SaveDialog1->FileName = this->Caption+ "_от_"+Date().CurrentDate();
if (SaveDialog1->Execute()){
                //GRB FIX 24.12.2022 - заменили разделитель колонок в csv-файле с запятой, на более естественный для Excel'я точку с запятой - и ниже по тексту файла меняем ;  на . в названиях колонок и данных
                AnsiString delim = ";";
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString fileName = SaveDialog1->FileName;
                //Вычитываем заголовки TListView первой строкой
                for(int i=0/*1*/;i<lvProcess->Columns->Count;i++){
                        if (i==0){
                        if (Language=="UKR") rowData = "Стан запуску";
                        else rowData = "Состояние запуска";
                        }
                        else
                        rowData = lvProcess->Columns->Items[i]->Caption;
                        //экранируем(меняем на точки) точку с запятой(разделитель) (GRB FIX от 09.04.2019 - раньше была запятая), чтобы не появлялись фейковые столбцы
                        rowData = StringReplace(rowData,";",".",TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);
                        str = str + rowData;
                        if (i!=lvProcess->Columns->Count-1) str = str+delim;
                }
                sList->Add (str);
                str = "";
                rowData ="";
                //Вычитываем значения из TListView
                for (int i = 0; i < lvProcess->Items->Count; i++){
                        for (int j = 0; j < lvProcess->Items->Item[i]->SubItems->Count; j++){
                               if (j==0){
                               rowData =  lvProcess->Items->Item[i]->ImageIndex;
                                        if (StrToInt(rowData)==0){
                                        if (Language=="UKR") rowData = "Працює";
                                        else rowData = "Запущен";
                                        }
                                        else{
                                        if (Language=="UKR") rowData = "Заблоковано";
                                        else rowData = "Заблокированый";
                                        }
                                        str = str + rowData;
                                        str = str + delim;
                               }
                               rowData =  lvProcess->Items->Item[i]->SubItems->Strings[j];
                               //экранируем(меняем на точки) точки с запятой(разделитель) (GRB FIX от 24.12.2022 - раньше была запятая), чтобы не появлялись фейковые столбцы
                               rowData =  StringReplace(rowData,";",".",TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);
                               str = str + rowData;
                               if (j != lvProcess->Items->Item[i]->SubItems->Count-1) str = str + delim;
                        }
                    sList->Add (str);
                    str="";
                }
                //TODO:Перезаписывать без предупреждения, если файл с таким именем существует?
                try{
                        if (!FileExists(fileName))
                                sList->SaveToFile(fileName);
                        else{
                                DeleteFile (fileName);
                                sList->SaveToFile(fileName);
                        }
                }catch (EFCreateError &efce){
                   throw; //To application
                }
        }
}
//---------------------------------------------------------------------------

