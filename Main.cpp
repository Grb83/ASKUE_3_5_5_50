//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "TaskMenu.h"
#include "Main.h"
#include "Monitor.h"
#include "Saa_SelectForm.h"
#include "Saa_SelectGroup.h"
#include "Saa_SelectGroupProc.h"
#include "SupperMain.h"
#include "Reconst.hpp"
//end add by NNV
//---------------------------------------------------------------------------
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------

__fastcall TMainForm::TMainForm(TComponent* Owner, AnsiString Name, TAccess acc)
	: TForm(Owner)
{
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
  //this->OldCreateOrder = false;
  try
  { if (acc == accDenied)
      throw Exception(Reconst_smes43_1);

    Access  = acc;
    if (Name!="")
    { TaskName  = Name;
      Caption   = Name;
    }
    iaPoints->OnExecute   = vPoints;
    iaSave->OnExecute     = vSave;
    iaNew->OnExecute      = vNew;
    iaDelete->OnExecute   = vDelete;
    iaBlock->OnExecute    = vBlock;
    iaUnblock->OnExecute  = vUnblock;
    iaClone->OnExecute    = vClone;
    iaReceipt->OnExecute  = vReceipt;
    iaParams->OnExecute   = vParams;
    iaCheck->OnExecute    = vCheck;

    iaSave->OnUpdate      = vUpdate;
    iaCheck->OnUpdate     = vUpdate;
    iaNew->OnUpdate       = vUpdate;
    iaDelete->OnUpdate    = vUpdate;
    iaClone->OnUpdate     = vUpdate;
    iaReceipt->OnUpdate   = vUpdate;
    iaBlock->OnUpdate     = vUpdate;
    iaUnblock->OnUpdate   = vUpdate;
    iaDeleteSAA->OnUpdate = vUpdate;
    iaPasteSAA->OnUpdate  = vUpdate;

    mnEdit->OnClick         = vEditClick;
    iaCutSAA->OnExecute     = vAnyEditClick;
    iaCopySAA->OnExecute    = vAnyEditClick;
    iaPasteSAA->OnExecute   = vAnyEditClick;
    iaDeleteSAA->OnExecute  = vAnyEditClick;
    iaSelectSAA->OnExecute  = vAnyEditClick;
    iaFind->OnExecute       = vFindClick;
    iaFindAgain->OnExecute  = vFindAgainClick;
    iaMTX->OnExecute       = vMTX;
  }
  catch (Exception &e)
  { Application->ShowException(&e);
    Close();
  }
}
//----------------------------------------------------------------------------
__fastcall TMainForm::~TMainForm()
{
  // Циклическое удаление всех подпунктов меню mMon
  // с учетом выдклкнной памяти в поле Tag
  if (mMon->Count != 0)
  { TMenuItem *mi = mMon->Items[0];
    while (mMon->Count != 0)
    { if (mi->Count > 0)
        mi = mi->Items[0];
      else
      { if ((FORMS *)mi->Tag != NULL)
          delete (FORMS *)mi->Tag;
        mi  = mi->Parent;
        mi->Delete(0);
      }
    }
  }
}
//----------------------------------------------------------------------------
void __fastcall TMainForm::vEditClick(TObject *Sender)
{
  TCustomEdit *pEdit;
  try
  { pEdit = dynamic_cast<TCustomEdit *>(ActiveControl);
    if (pEdit != NULL)
    { bool  HasSelection;
      mnPaste->Enabled  = Clipboard()->HasFormat(CF_TEXT);
      HasSelection      = pEdit->SelLength > 0;
      mnCut->Enabled    = HasSelection;
      mnCopy->Enabled   = HasSelection;
      mnDelete->Enabled = HasSelection;
      mnSelect->Enabled = true;
    }
    else
    { mnCut->Enabled    = false;
      mnCopy->Enabled   = false;
      mnPaste->Enabled  = false;
      mnDelete->Enabled = false;
      mnSelect->Enabled = false;
    }
  }
  catch (Exception &e)
  {
  }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::vAnyEditClick(TObject *Sender)
{
  TCustomEdit *pEdit;
  TComponent  *pMenu;
  try
  { pEdit = dynamic_cast<TCustomEdit *>(ActiveControl);
    pMenu = dynamic_cast<TComponent *>(Sender);
    if ((pEdit != NULL) && (pMenu != NULL))
      switch (pMenu->Tag)
      { case 1:
          pEdit->CutToClipboard();
          break;
        case 2:
          pEdit->CopyToClipboard();
          break;
        case 3:
          pEdit->PasteFromClipboard();
          break;
        case 4:
          pEdit->ClearSelection();
          break;
        case 5:
          pEdit->SelectAll();
          break;
        default:
          return;
       }
  }
  catch (Exception &e)
  {
  }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::iaCloseExecute(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------
//методы обработки свойства EditRec - признак редактирования записей из БД
void __fastcall TMainForm::SetEditRec(bool value)
{
  if (FEditRec == value)
    return;
  FEditRec        = value;
  iaSave->Enabled = value;
//  if (iaNew->Visible) iaNew->Enabled = value;
//  adefRefresh->Enabled = value;
}
bool __fastcall TMainForm::GetEditRec()
{
  return  FEditRec;
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::iaRefreshExecute(TObject *Sender)
{
  if (EditRec)
    switch (MessageBox(Handle, Reconst_smes43_2.c_str(),
                        Application->Title.c_str(),
                        MB_YESNOCANCEL | MB_ICONQUESTION))
    { case IDYES:
        if (Access == accDenied && Access == accRead)
          throw Exception(Reconst_smes43_3);
        vSave(Sender);
        if (EditRec)
          return;
        break;
      case IDCANCEL:
        return;
    }
  vRefresh(Sender);
  EditRec = false;
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::SetAccess(TAccess value)
{
  try{
  HWND  hFocusedWnd = GetFocus();
  FAccess = value;
  if (FAccess == accDenied)
  { if (EditRec)
    { if (MessageBox(Handle, Reconst_smes43_4.c_str(),
                      Caption.c_str(),
                      MB_YESNO | MB_ICONQUESTION | MB_DEFBUTTON1) == IDYES)
        vSave(this);
      else
        EditRec = false;
    }
    ::SetFocus(hFocusedWnd);
    Close();
  }
  if (FAccess == accRead && EditRec)
  { if (MessageBox(Handle, Reconst_smes43_6.c_str(),
                    Caption.c_str(),
                    MB_YESNO | MB_ICONQUESTION | MB_DEFBUTTON1) == IDYES)
      vSave(this);
    else
      vRefresh(this);
    ::SetFocus(hFocusedWnd);
  }
  bool  wr = value == accWrite;
  if (!wr)
    iaSave->Enabled = wr;
    }catch (Exception &ex){
      MessageBox(Handle,"Не хватает памяти для работы с деревом(Валится в Main.cpp::SetAccess). Закройте и откройте 2 раза по крестику текущую задачу",
            "Память не выделяется",MB_OK|MB_ICONINFORMATION);
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::ShowAction(TAction* Action, bool bShow)
{
  Action->Enabled = bShow;
  Action->Visible = bShow;
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::FormCloseQuery(TObject *Sender, bool &CanClose)
{
  try{
  CanClose  = false;
  if (EditRec && (FAccess == accWrite))
  { SendMessage(Application->MainForm->ClientHandle, WM_MDIACTIVATE, (WPARAM)this->Handle, 0);
    switch (MessageBox(Handle, Reconst_smes43_5.c_str(),
                        Caption.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1))
    { case IDCANCEL:
        return;
      case IDYES:
        vSave(Sender);
        if (EditRec)
          return;
    }
  }
  CanClose  = true;
  }catch (Exception &ex){
        MessageBox(Handle,"Валится в Main.cpp::FormCloseQuery. Закройте и откройте 2 раза по крестику текущую задачу",
            "Память не выделяется",MB_OK|MB_ICONINFORMATION);
  }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::vUpdate(TObject * Sender)
{
  if ((Access != accWrite) && ((TAction *)Sender)->Enabled)
    ((TAction *)Sender)->Enabled  = false;
}
//---------------------------------------------------------------------------
// добавление пунктов в меню pm - перечень точек, для которых точка с ид mid является УСД
void __fastcall TMainForm::getUSDList(TPopupMenu* pm, long mid, Classes::TNotifyEvent&OnClick)
{
  dmMain->oqCursor->Params->Clear();
  dmMain->oqCursor->SQL->Text = "begin "+SchemeName+"un_main_pg.get_USDList(:par1,:par2); end;";
  dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
  dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
  char  name[256];
  try{
    while (pm->Items->Count>2)
      pm->Items->Delete(2);
    dmMain->oqCursor->ParamByName("par1")->AsInteger = mid;
    dmMain->oqCursor->Execute();
    int i=0;
    while(!dmMain->oqCursor->Eof){
      strcpy(name,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
      repl_delimiters(name, " ");
      TMenuItem *mi = NewItem(AnsiString(name), 0, false, true, OnClick, 0, "miN" + IntToStr(i) + "USDList");
      mi->Tag = dmMain->oqCursor->FieldByName("MID")->AsInteger;
      pm->Items->Add(mi);
      dmMain->oqCursor->Next();
      i++;
    }
  }catch (Exception &e){
    throw e;
  }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::repl_delimiters(char*source, const char* byrepl)
{
  int pos = AnsiString(source).LastDelimiter("\n\r");
  int len = strlen(byrepl);

  for(; pos != 0; pos = AnsiString(source).LastDelimiter("\n\r"))
  { if (len == 1)
      source[pos - 1] = byrepl[0];
    else
    { for(int r = strlen(source); r >= pos; r--)
        source[r + 2] = source[r];
      strncpy(&source[pos - 1], byrepl, len);
    }
  }
}
//---------------------------------------------------------------------------
// поиск узла с ид = id и установка Selected на нем в дереве точек tv. OnReadNode - процедура чтения ветви дерева tv
void __fastcall TMainForm::FindNode(TTreeView*tv, long id, TReadTreeNode&OnReadNode,TGetNodeId&GetNodeId, char*sql)
{
    // Запрос - путь к точке :1 начиная с коренного узла
    AnsiString sqlText = "begin "+SchemeName+"un_main_pg.find_node(:par1,:par2); end;";;
    long parmid=id;
    long pointsTree[MAXCOUNTLEVEL];
    TTreeNode*Node;
    try{
        ZeroMemory(&pointsTree,sizeof(pointsTree));
        dmMain->oqCursor->Params->Clear();
        if(sql)
          dmMain->oqCursor->SQL->Text=sql;
        else
        { dmMain->oqCursor->SQL->Text=sqlText;
          dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
          dmMain->oqCursor->ParamByName("par2")->DataType  = ftCursor;
        }
        Node = tv->Items->GetFirstNode();
        dmMain->oqCursor->ParamByName("par1")->AsInteger= parmid;
        dmMain->oqCursor->Execute();
        unsigned long rowCount=0;
        int j=0;
        while(!dmMain->oqCursor->Eof&&j< MAXCOUNTLEVEL){
          pointsTree[j]= dmMain->oqCursor->FieldByName("mid")->AsInteger;
          dmMain->oqCursor->Next();
          j++;
        }
        rowCount=j;
        for(unsigned long i=0; i<rowCount; i++)
        { while(Node)
          {
            if(pointsTree[i]==GetNodeId(Node))
              break;
            Node=Node->getNextSibling();
          }
          if((i<rowCount-1)&&(Node!=NULL))
          {  if((Node->HasChildren && !Node->getFirstChild()) ||
                (Node->getFirstChild() && !Node->getFirstChild()->Data))
             { Node->DeleteChildren();
               if(!OnReadNode(Node))
                 break;
             }
              Node=Node->getFirstChild();
          }
          else if(!Node)
            Node = tv->Items->GetFirstNode();
          else
            break;
        }//end for
        tv->Selected = Node;
    }catch (Exception &exception){
        Application->ShowException(&exception);
        tv->Selected=Node;
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::FormClose(TObject *Sender, TCloseAction &Action)
{
	Action = caFree;
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::vFindClick(TObject*Sender)
{
   if(!FindForm)
      new TFindForm(this);
   FindForm->cbMeasure->SelectAll();
   if(FindForm->ShowModal()==mrOk)
      vFindAgainClick(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TMainForm::vFindAgainClick(TObject*Sender)
{
   if(!FindForm)
      return;
   MessageBox(this->Handle, "Find Again", "Message", MB_OK|MB_ICONINFORMATION);
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::SetPopupMenu(TObject *Sender, int id,AnsiString PointName)
{
    TMenuItem*mi;
    mi = dynamic_cast<TMenuItem*>(Sender);
    FORMS *fms = (FORMS*)mi->Tag;
    if(mi==mMon){
      if(!fms) fms = new FORMS;
      ZeroMemory(fms, sizeof(FORMS));
      fms->gid = id;
      mi->Tag = (int)fms;
    }
    if(fms && fms->tmplCode!=0){
     // char prBChs[50];
     AnsiString prBChs;
     // char prEChs[50];
     AnsiString prEChs;
      TFormDescr *fd = new TFormDescr;

      TDateTime taBeg = TDateTime::CurrentDate()-1;
      TDateTime taEnd = taBeg + 1;
      int isPoint = 1;/////////////////

       prBChs= taBeg.FormatString("dd.mm.yyyy hh:nn:ss");
       prEChs= taEnd.FormatString("dd.mm.yyyy hh:nn:ss");
      //создание объекта формы и ево первоначальная настройка
      ManForm = new TManForm(SupperMainForm);
      ManForm->OnProgressBarStepBy=SupperMainForm->ProgressBarStepBy;
      TBaseMonitorForm *p=new TBaseMonitorForm(ManForm->PageCtrlSplt,ManForm->OnProgressBarStepBy);
      ManForm->PageCtrlSplt->AddChild(p,alTop);
      //вызов процедуры
      if (fms->tmplCode == PL_SQL_REP_F){

        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"FILEREPORT_PG.main_p(:par1,:par2,to_date(:par3,'dd.mm.yyyy hh24:mi:ss'),\
             to_date( :par4,'dd.mm.yyyy hh24:mi:ss'),:par5); end;";

         dmMain->oqCursor->ParamByName("par1")->AsInteger=fms->fid;
         dmMain->oqCursor->ParamByName("par2")->AsInteger=id;
         dmMain->oqCursor->ParamByName("par3")->AsString=prBChs;
         dmMain->oqCursor->ParamByName("par4")->AsString=prEChs;
         dmMain->oqCursor->ParamByName("par5")->AsInteger=isPoint;
         dmMain->oqCursor->Execute();

      }
      //заполнение передаваемой структуры
      fd->IdFormTree = fms->fid;
      fd->NameForm = fms->name;
      fd->CodeTemplate = fms->tmplCode;
      fd->IdGroup = id;
      fd->NameAlert = fms->alertname;
      fd->NameGroup = fms->procname;
      fd->IsPoints = isPoint;
      fd->CeilingIdGroup = fd->IdGroup;
      fd->DateTime = taEnd;
      fd->DateTimePar = taBeg;
      fd->startmid = fms->startmid;
      fd->NameGroup = PointName;
      //устанавливаем разрешенные компоненты
      fd->EnableControls.Clear();
      char*ch = &fms->enablecontrols[0];
      if(*ch=='1') fd->EnableControls<<TFormDescr::ctrlGroup;
      ch++;
      if(*ch=='1') fd->EnableControls<<TFormDescr::ctrlMonth;
      ch++;
      if(*ch=='1') fd->EnableControls<<TFormDescr::ctrlDay;
      ch++;
      if(*ch=='1') fd->EnableControls<<TFormDescr::ctrlHour;
      ch++;
      if(*ch=='1') fd->EnableControls<<TFormDescr::ctrlMinute;
      ch++;
      if(*ch=='1') fd->EnableControls<<TFormDescr::ctrlCalendar;
      ch++;
      if(*ch=='1') fd->EnableControls<<TFormDescr::ctrlPoint;

      PostMessage(ManForm->PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)new TFormDescr(*fd));
      ModalResult = mrOk;
    }else
   createSubMenu_M(mi,id);
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::createSubMenu_M(TMenuItem*mi, int id)
{
    FORMS *n, *fms = (FORMS*)mi->Tag;
    TMenuItem*chMi;

    FORMS mas[MAXCOUNTLEVEL];
    ZeroMemory(mas, sizeof(mas));
    if(fms->tmplCode != 0)
      for(int i = 0; i < MAXCOUNTLEVEL; i++)
        memcpy(&mas[i], fms, sizeof(FORMS));

    try
    {
        long cnt = mi->Count;
        if(!fms || fms->fid==0){
            dmMain->oqCursor->Params->Clear();
            dmMain->oqCursor->SQL->Text="begin "+SchemeName+"un_main_pg.createSubMenu_1(:par1,:par2,:par3); end;";
            dmMain->oqCursor->ParamByName("par1")->AsInteger=UserRol.Monitor;
            dmMain->oqCursor->ParamByName("par2")->AsInteger=id;
            dmMain->oqCursor->ParamByName("par3")->ParamType = ptOutput;
            dmMain->oqCursor->ParamByName("par3")->DataType = ftCursor;
            dmMain->oqCursor->Execute();
            int i=0;
            while(!dmMain->oqCursor->Eof&&i<MAXCOUNTLEVEL){
            mas[i].fid = dmMain->oqCursor->FieldByName("fid")->AsInteger;
            strcpy(mas[i].name,dmMain->oqCursor->FieldByName("nameform")->AsString.c_str());
            mas[i].tmplCode=dmMain->oqCursor->FieldByName("codetemplate")->AsInteger;
             chMi = new TMenuItem(mi);
             chMi->Caption = mas[i].name;
             n = new FORMS;
             memcpy(n, &mas[i], sizeof(FORMS));
             chMi->Tag = (long)n;
             chMi->OnClick = mi->OnClick;
              if(n->tmplCode==0)
                chMi->Insert(0,new TMenuItem(mi));
             mi->Insert(0,chMi);
             dmMain->oqCursor->Next();
             i++;
             }

        }else{
            dmMain->oqCursor->Params->Clear();
            dmMain->oqCursor->SQL->Text="begin "+SchemeName+"un_main_pg.createSubMenu_2(:par1,:par2,:par3,:par4); end;";
            dmMain->oqCursor->ParamByName("par1")->AsInteger=UserRol.Monitor;
            dmMain->oqCursor->ParamByName("par2")->AsInteger=id;
            dmMain->oqCursor->ParamByName("par3")->AsInteger=fms->fid;
            dmMain->oqCursor->ParamByName("par4")->ParamType = ptOutput;
            dmMain->oqCursor->ParamByName("par4")->DataType = ftCursor;
            dmMain->oqCursor->Execute();
            int i=0;
            while(!dmMain->oqCursor->Eof&&i<MAXCOUNTLEVEL){
            mas[i].fid = dmMain->oqCursor->FieldByName("fid")->AsInteger;
            strcpy(mas[i].name,dmMain->oqCursor->FieldByName("nameform")->AsString.c_str());
            mas[i].tmplCode=dmMain->oqCursor->FieldByName("codetemplate")->AsInteger;
            strcpy(mas[i].enablecontrols,dmMain->oqCursor->FieldByName("enablecontrols")->AsString.c_str());
            mas[i].step=dmMain->oqCursor->FieldByName("stepprofile")->AsInteger;
            strcpy(mas[i].alertname,dmMain->oqCursor->FieldByName("namealert")->AsString.c_str());
            mas[i].startmid=dmMain->oqCursor->FieldByName("mid")->AsInteger;
              chMi = new TMenuItem(mi);
              chMi->Caption = mas[i].name;
              n = new FORMS;
              memcpy(n, &mas[i], sizeof(FORMS));
              chMi->Tag = (long)n;
              chMi->OnClick = mi->OnClick;
               if(n->tmplCode==0)
                 chMi->Insert(0,new TMenuItem(mi));
              mi->Insert(0,chMi);
              dmMain->oqCursor->Next();
              i++;
             }
        }
        for(long i=0; i<cnt; i++){
            n = (FORMS*)mi->Items[mi->Count-1]->Tag;
            if(n)
                delete n;
            mi->Delete(mi->Count-1);
        }
        if(mi->Count==0){
            mi->Add(new TMenuItem(mi));
        }
    }catch(Exception&e){
        throw Exception(e);
    }
}
//end add by NNV
//---------------------------------------------------------------------------
void    __fastcall TMainForm::WM_SetActiveNode(TMessage& Message)
{
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::createSubMenu(TMenuItem*mi)
{
    FORMS *n, *fms = (FORMS*)mi->Tag;
    TMenuItem*chMi;
    try
    {
        long cnt = mi->Count;
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"un_main_pg.createSubMenu(:par1,:par2,:par3,:par4); end;";
        if(!fms || fms->fid==0)
            dmMain->oqCursor->ParamByName("par1")->AsInteger=0;
        else{
            dmMain->oqCursor->ParamByName("par1")->AsInteger=fms->fid;
        }
         dmMain->oqCursor->ParamByName("par2")->AsInteger= UserRol.Monitor;
         /*dmMain->oqCursor->ParamByName("par3")->DataType=ftInteger;
         dmMain->oqCursor->ParamByName("par3")->ParamType=ptInputOutput;*/
         dmMain->oqCursor->ParamByName("par3")->AsInteger=fms->gid;
         dmMain->oqCursor->ParamByName("par4")->ParamType = ptOutput;
         dmMain->oqCursor->ParamByName("par4")->DataType = ftCursor;
   //      dmMain->oqCursor->Open();
         dmMain->oqCursor->Execute();
   //      Screen->Cursor=crDefault;
        while(!dmMain->oqCursor->Eof){
            n = new FORMS;
            ZeroMemory(n, sizeof(FORMS));
            if(!dmMain->oqCursor->FieldByName("fid")->IsNull)
            n->fid=dmMain->oqCursor->FieldByName("fid")->AsInteger;
         if(!dmMain->oqCursor->FieldByName("codetemplate")->IsNull)
            n->tmplCode=dmMain->oqCursor->FieldByName("codetemplate")->AsInteger;
         if(!dmMain->oqCursor->FieldByName("nameform")->IsNull)
            strcpy(n->name,dmMain->oqCursor->FieldByName("nameform")->AsString.c_str());
         if(!dmMain->oqCursor->FieldByName("commentform")->IsNull)
            strcpy(n->comment,dmMain->oqCursor->FieldByName("commentform")->AsString.c_str());
         if(!dmMain->oqCursor->FieldByName("enablecontrols")->IsNull)
            strcpy(n->enablecontrols,dmMain->oqCursor->FieldByName("enablecontrols")->AsString.c_str());
         if(!dmMain->oqCursor->FieldByName("stepprofile")->IsNull)
            n->step=dmMain->oqCursor->FieldByName("stepprofile")->AsInteger;
         if(!dmMain->oqCursor->FieldByName("namealert")->IsNull)
            strcpy(n->alertname,dmMain->oqCursor->FieldByName("namealert")->AsString.c_str());
         if(!dmMain->oqCursor->FieldByName("vprocname")->IsNull)
            strcpy(n->procname,dmMain->oqCursor->FieldByName("vprocname")->AsString.c_str());
         if(!dmMain->oqCursor->ParamByName("par3")->IsNull)
            n->gid=dmMain->oqCursor->ParamByName("par3")->AsInteger;
         if(!dmMain->oqCursor->FieldByName("mid")->IsNull)
            n->startmid=dmMain->oqCursor->FieldByName("mid")->AsInteger;

                chMi = new TMenuItem(mi);
                chMi->Caption = n->name;
                chMi->Tag = (long)n;
                chMi->OnClick = mi->OnClick;
                if(n->tmplCode==0)
                    chMi->Insert(0,new TMenuItem(mi));
                mi->Insert(0,chMi);
           dmMain->oqCursor->Next();
          }
  //        dmMain->oqCursor->Close();
        for(long i=0; i<cnt; i++){
            n = (FORMS*)mi->Items[mi->Count-1]->Tag;
            if(n)
                delete n;
            mi->Delete(mi->Count-1);
        }
        if(mi->Count==0){
            mi->Add(new TMenuItem(mi));
        }
    }catch(Exception&e){
        throw Exception(e);
    }
}
// END Add by KSS (04.06.2004)
//---------------------------------------------------------------------------
void __fastcall TMainForm::createSubMenu_G(TMenuItem*mi)
{
    FORMS *n, *fms = (FORMS*)mi->Tag;
    long m_role = UserRol.Monitor;
    FORMS mas[MAXCOUNTLEVEL];
    TMenuItem*chMi;

    try
    {
        long cnt = mi->Count;
        ZeroMemory(mas, sizeof(mas));
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"un_main_pg.createSubMenu_G(:par1,:par2,:par3,:par4); end;";
        if(!fms || fms->fid==0)
            dmMain->oqCursor->ParamByName("par1")->AsInteger = 0;
        else{
            dmMain->oqCursor->ParamByName("par1")->AsInteger = fms->fid;
        }

             dmMain->oqCursor->ParamByName("par2")->AsInteger=m_role;
             dmMain->oqCursor->ParamByName("par3")->AsInteger=fms->gid;
             dmMain->oqCursor->ParamByName("par4")->ParamType = ptOutput;
             dmMain->oqCursor->ParamByName("par4")->DataType = ftCursor;
             dmMain->oqCursor->Execute();
             int i=0;
             while(!dmMain->oqCursor->Eof&&i<MAXCOUNTLEVEL){
             mas[i].fid=dmMain->oqCursor->FieldByName("fid")->AsInteger;
             mas[i].tmplCode=dmMain->oqCursor->FieldByName("codetemplate")->AsInteger;
             strcpy(mas[i].name,dmMain->oqCursor->FieldByName("nameform")->AsString.c_str());
             strcpy(mas[i].comment,dmMain->oqCursor->FieldByName("commentform")->AsString.c_str());
             strcpy(mas[i].enablecontrols,dmMain->oqCursor->FieldByName("enablecontrols")->AsString.c_str());
             mas[i].step=dmMain->oqCursor->FieldByName("stepprofile")->AsInteger;
             strcpy(mas[i].alertname,dmMain->oqCursor->FieldByName("namealert")->AsString.c_str());
             strcpy(mas[i].procname,dmMain->oqCursor->FieldByName("vprocname")->AsString.c_str());
             mas[i].gid=fms->gid;

                chMi = new TMenuItem(mi);
                chMi->Caption = mas[i].name;
                n = new FORMS;
                memcpy(n, &mas[i], sizeof(FORMS));
                chMi->Tag = (long)n;
                chMi->OnClick = mi->OnClick;
                if(n->tmplCode==0)
                    chMi->Insert(0,new TMenuItem(mi));
                mi->Insert(0,chMi);
           dmMain->oqCursor->Next();
             i++;
        }
        for(long i=0; i<cnt; i++){
            n = (FORMS*)mi->Items[mi->Count-1]->Tag;
            if(n)
                delete n;
            mi->Delete(mi->Count-1);
        }
        if(mi->Count==0){
            mi->Add(new TMenuItem(mi));
        }
    }catch(Exception&e){
        throw Exception(e);
    }
}
// END Add by KSS (22.06.2004)
//---------------------------------------------------------------------------

