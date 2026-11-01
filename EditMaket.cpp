//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "EditMaket.h"
#include "Reconst.hpp"
#include "unViewTree.h"
//---------------------------------------------------------------------------
#define  MAXTABLESIZE 256
#pragma package(smart_init)
//#pragma link "Main"
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
UINT CF_MAKETS_TREENODE; // описание формата для буфера обмена
extern HANDLE UpdateMonitors;
//extern TSupperMainForm *SupperMainForm;
//---------------------------------------------------------------------------
TEditMaketForm::MAKET::MAKET(TMType type)
{
    ZeroMemory(this,sizeof(*this));
    Type = type;
    switch(type)
    {
    case mtMaket:
    case mtGroup:
    case mtPoint:
    case mtAgrGroup:
    case mtSubGroup:
    case mtFolder:
        break;
    }
}
//---------------------------------------------------------------------------
//инициализация данных формы
__fastcall TEditMaketForm::TEditMaketForm(TComponent* Owner, AnsiString Name, TAccess a)
   : TMainForm(Owner, Name, a)
{
    CountNodes_Del = 0;
    realdeletion = false;
    Mouse->DragImmediate = false;
    m_Sel2Paste = NULL;

    iaNew->Caption = Reconst_smes24_1;
    iaNewFolder->OnUpdate = vUpdate;
    ShowAction(iaNew);
    ShowAction(iaNewFolder);
    ShowAction(iaDelete);
    ShowAction(iaClone);
    MaketListTVChange(MaketListTV,MaketListTV->Selected);
    // регистрация формата для буфера обмена
    CF_MAKETS_TREENODE = RegisterClipboardFormat("CF_MAKETS_TREENODE");
    if(!CF_MAKETS_TREENODE)
    {
        char mess[1025];
        LPVOID lpMsgBuf;
        FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
            NULL, GetLastError(),
            MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
            (LPTSTR) &lpMsgBuf,  0,  NULL);
        strncpy(mess, (char*)lpMsgBuf, 1024);
        LocalFree(lpMsgBuf);
        throw Exception(mess);
    }
}
//---------------------------------------------------------------------------

__fastcall TEditMaketForm::~TEditMaketForm()
{
    MaketListTV->OnChanging = NULL;
    if(Clipboard()->HasFormat(CF_MAKETS_TREENODE))
        Clipboard()->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TEditMaketForm::SetAccess(TAccess value)
{
   if(FAccess != value) {
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      iaNew->Enabled = wr&&iaNew->Enabled;
      iaDelete->Enabled = wr;
      iaClone->Enabled = wr&&iaClone->Enabled;
      tsProperties->Enabled = wr;
      iaNewFolder->Enabled = wr&&iaNewFolder->Enabled;
   }
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::vUpdate(TObject*Sender)
{
   if((Access!=accWrite)&&((TAction*)Sender)->Enabled)
      ((TAction*)Sender)->Enabled = false;
}
//---------------------------------------------------------------------------
//установка начального состояния формы при его отображении
void __fastcall TEditMaketForm::FormShow(TObject *Sender)
{
    if(ReadTreeNode(MaketListTV,NULL)&&ReadTreeNode(PointsTV,NULL)&&LoadFormationFunc())
    {
        if(MaketListTV->Items->Count){
            MaketListTV->OnChange=MaketListTVChange;
            MaketListTV->OnChanging=MaketListTVChanging;
            MaketListTV->Selected=MaketListTV->Items->Item[0];
        }
        if(PointsTV->Items->Count){
            PointsTV->Selected=PointsTV->Items->Item[0];
        }
        Width=Width-1;
        Height=Height-1;
        MaketListTV->SetFocus();
    }else{
        Close();
    }
    plPoints->Left = 1;
    plPoints->Top = 58;
    plGroups->Left = 1;
    plGroups->Top = 116;
    plSubGroup->Left = 0;
    plSubGroup->Top = 27;
}
//---------------------------------------------------------------------------
//загрузка списка функций для макетов
bool __fastcall TEditMaketForm::LoadFormationFunc()
{
  try{
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="SELECT nprocedure, vname FROM ryda.deportprocedures where NTYPE=0 order by vname";
    cbFormationFunc->Clear();
    dmMain->quMain->Execute();
    while(!dmMain->quMain->Eof){
      cbFormationFunc->Items->AddObject(dmMain->quMain->FieldByName("vname")->AsString, (TObject *)dmMain->quMain->FieldByName("nprocedure")->AsInteger);
      dmMain->quMain->Next();
    }
  }catch (Exception &exception){
    Application->ShowException(&exception);
    return false;
  }
  return true;
}
//---------------------------------------------------------------------------
//освобождение памяти при уничтожении формы
//инициализация группы флажков CheckBox - типа измерения для всей группы
void __fastcall TEditMaketForm::GetCGB()
{
 try {
   if(!MaketListTV->Selected) return;
   ReadTreeNode(MaketListTV, MaketListTV->Selected);
   TTreeNode *tn = MaketListTV->Selected->getFirstChild();
   TCheckBoxState on[6] = {cbUnchecked};
   int i, check[6] = {1,1,1,1,1,1};
   if(!tn) ZeroMemory(check, sizeof(check));
   while(tn){
      int ind = ((MAKET*)tn->Data)->DimType-1;
      on[ind] = cbGrayed;
      for(i=0; i<6; i++)
         if(ind != i) check[i] = 0;
      tn = tn->getNextSibling();
   }
   for(i=0; i<6; i++)
      if(check[i]) on[i] = cbChecked;
   cbAPlus->State  = on[0];
   cbAMinus->State = on[1];
   cbAOvfw->State  = on[2];
   cbQPlus->State  = on[3];
   cbQMinus->State = on[4];
   cbQOvfw->State  = on[5];
 } catch (Exception &exception){
    Application->ShowException(&exception);
 }
}
//установка ггруппы флажков для типа измерения в группе (модификация всех DimType точек в группе)
void __fastcall TEditMaketForm::SetCGB(TDimention value, TCheckBoxState s)
{
   if(!MaketListTV->Selected) return;
   ReadTreeNode(MaketListTV, MaketListTV->Selected);
   TTreeNode *tn = MaketListTV->Selected->getFirstChild();
   while(tn){
      ((MAKET*)tn->Data)->DimType = (s==cbChecked)?value:dmUnknown;
      if(!((MAKET*)tn->Data)->editing)
         ((MAKET*)tn->Data)->editing = 1;
      tn = tn->getNextSibling();
   }
   if(!EditRec) EditRec = true;
   cbAPlus->OnClick = NULL;
   cbQPlus->OnClick = NULL;
   cbAMinus->OnClick = NULL;
   cbQMinus->OnClick = NULL;
   cbAOvfw->OnClick = NULL;
   cbQOvfw->OnClick = NULL;
   if(value != 1) cbAPlus->State = cbUnchecked;
   if(value != 2) cbAMinus->State = cbUnchecked;
   if(value != 3) cbAOvfw->State = cbUnchecked;
   if(value != 4) cbQPlus->State = cbUnchecked;
   if(value != 5) cbQMinus->State = cbUnchecked;
   if(value != 6) cbQOvfw->State = cbUnchecked;
   cbAPlus->OnClick = CheckedClick;
   cbQPlus->OnClick = CheckedClick;
   cbAMinus->OnClick = CheckedClick;
   cbQMinus->OnClick = CheckedClick;
   cbAOvfw->OnClick = CheckedClick;
   cbQOvfw->OnClick = CheckedClick;
}
//---------------------------------------------------------------------------
//определяет внешний вид формы при разных выбранных типах узлов
void __fastcall TEditMaketForm::SetSelType(TMType value)
{
   if(FSelType != value) {
      switch(FSelType)
      {
      case mtMaket:
         mComment->TabStop = false;
         cbFormationFunc->TabStop = false;
         cbExecUnexecutingInTime->TabStop = false;
         cbBlocking->TabStop = false;
         eSFShift->TabStop = false;
         eAddParams->TabStop = false;
         eLastDateExec->TabStop = false;
         mError->TabStop = false;
         plMaketProp->Visible = false;
         plMaketProp->Enabled = false;
         cbBlocking->Visible = false;
         cbBlocking->Enabled = false;
         break;
      case mtSubGroup:
         cbAgrGroup->TabStop = true;
         plSubGroup->Visible = false;
         eNSign->TabStop = false;
         eName->Color = clWindow;
         eName->ReadOnly = false;
         mComment->Color = clWindow;
         mComment->ReadOnly = false;
         eStrCode->Color = clWindow;
         eStrCode->ReadOnly = false;
      case mtAgrGroup:
         gbGroupDimType->Visible = true;
         gbGroupDimType->Enabled = true;
      case mtGroup:
         plGroups->Visible = false;
         plGroups->Enabled = false;
         mComment->TabStop = false;
         break;
      case mtPoint:
         plPoints->Visible = false;
         plPoints->Enabled = false;
         eName->ReadOnly = false;
         eName->Color = clWindow;
         break;
      case mtFolder:
         cbBlocking->Visible = false;
         cbBlocking->Enabled = false;
         break;
      case mtUnknown:
      default:
         plProp->Visible = true;
         plProp->Enabled = true;
         plMaketProp->Visible = false;
         plMaketProp->Enabled = false;
      }
      FSelType = value;
      switch(value)
      {
      case mtMaket:
         mComment->TabStop = true;
         cbFormationFunc->TabStop = true;
         cbExecUnexecutingInTime->TabStop = true;
         cbBlocking->TabStop = true;
         eSFShift->TabStop = true;
         eAddParams->TabStop = true;
         eLastDateExec->TabStop = true;
         mError->TabStop = true;
         plMaketProp->Visible = true;
         plMaketProp->Enabled = true;
         cbBlocking->Visible = true;
         cbBlocking->Enabled = true;
         break;
      case mtSubGroup:
         cbAgrGroup->TabStop = false;
         plSubGroup->Visible = true;
         eNSign->TabStop = true;
         eName->ReadOnly = true;
         eName->Color = clBtnFace;
         mComment->ReadOnly = true;
         mComment->Color = clBtnFace;
         eStrCode->ReadOnly = true;
         eStrCode->Color = clBtnFace;
      case mtAgrGroup:
         gbGroupDimType->Visible = false;
         gbGroupDimType->Enabled = false;
      case mtGroup:
         plGroups->Visible = true;
         plGroups->Enabled = true;
         mComment->TabStop = true;
         break;
      case mtPoint:
         plPoints->Visible = true;
         plPoints->Enabled = true;
         eName->ReadOnly = true;
         eName->Color = clBtnFace;
         break;
      case mtFolder:
         cbBlocking->Visible = true;
         cbBlocking->Enabled = true;
         break;
      case mtUnknown:
      default:
         plProp->Visible = false;
         plProp->Enabled = false;
         plMaketProp->Visible = false;
         plMaketProp->Enabled = false;
      }
   }
}
//---------------------------------------------------------------------------
//сохранение изменений в БД
void __fastcall TEditMaketForm::vSave(TObject *Sender)
{
    bool b=true;
    if(MaketListTV->Selected)
        MaketListTVChanging(MaketListTV,MaketListTV->Selected,b);
    if(!b) return;
    TTreeNode *Node = NULL;
    MAKET dMaket;
    long nParent;
    long nType;

    try{
        //GRB ADD 16.04.2020 - test trouble ODAC
        dmMain->quMain->Params->Clear();
        //END ADD 
         dmMain->quMain->SQL->Text="begin \
                        if :par1 = 1 then \
                            ryda.makets_pg.del_m(:par2); \
                        elsif :par1 = 2 OR :par1 = 4 then \
                            ryda.makets_pg.del_g(:par2); \
                        elsif :par1 = 3 then \
                            ryda.makets_pg.del_p(:par2,:par3); \
                        elsif :par1 = 5 then \
                            ryda.makets_pg.del_a(:par3,:par2); \
                        elsif :par1 = 6 then \
                            ryda.makets_pg.del_f(:par2); \
                        end if; \
                    end;";

        for(int i=0; nNodes_Del&&i<CountNodes_Del; i++)
        {
            dMaket.Type = nNodes_Del[i].Type;
            dMaket.Mid = nNodes_Del[i].Mid;
            dMaket.GroupId = nNodes_Del[i].nGroup;
            dmMain->quMain->ParamByName("par1")->AsInteger=dMaket.Type;
            dmMain->quMain->ParamByName("par2")->AsInteger=dMaket.Mid;
            dmMain->quMain->ParamByName("par3")->AsInteger=dMaket.GroupId;
            dmMain->quMain->Execute();

        }
        //GRB ADD 16.04.2020 - test trouble ODAC
        dmMain->quMain->Params->Clear();
        //END ADD 
         dmMain->quMain->SQL->Text="begin \
                     if :par1 = 1 then \
                        if :par2 = 0 then \
                           ryda.makets_pg.ins_m(:par5,:par3,:par4,:par6,:par7,:par12,:par13,:par11,:par2); \
                        else \
                           ryda.makets_pg.upd_m(:par2,:par5,:par3,:par4,:par6,:par7,:par12,:par13,:par11); \
                        end if; \
                     elsif :par1 = 2 OR :par1 = 4 then\
                        if :par2 = 0 then \
                           ryda.makets_pg.ins_g(:par11,:par8,:par3,:par4,:par2); \
                        else \
                           ryda.makets_pg.upd_g(:par2,:par11,:par8,:par3,:par4); \
                        end if; \
                     elsif :par1 = 3 then \
                        ryda.makets_pg.chg_p(:par11,:par2,:par9,:par10); \
                     elsif :par1 = 5 then \
                        ryda.makets_pg.chg_a(:par11,:par2,:par14); \
                     elsif :par1 = 6 then \
                        if :par2 = 0 then \
                           ryda.makets_pg.ins_f(:par3,:par6,:par11,:par2); \
                        else \
                           ryda.makets_pg.upd_f(:par3,:par6,:par11,:par2); \
                        end if; \
                     end if; \
                  end;";


        Node = MaketListTV->Items->GetFirstNode();
        while(Node)
        {
            if(Node->Data&&(((MAKET*)Node->Data)->editing > 0))
            {
                memcpy(&dMaket,Node->Data,sizeof(MAKET));
                if(dMaket.Type == mtAgrGroup || dMaket.Type==mtSubGroup){
                    Node = Node->GetNext();
                    continue;
                }
                if(dMaket.Type==mtPoint)
                    switch(dMaket.DimType){
                    case dmAPlus:    nType = 1; break;
                    case dmAMinus:   nType = 2; break;
                    case dmA:        nType = 5; break;
                    case dmQPlus:    nType = 3; break;
                    case dmQMinus:   nType = 4; break;
                    case dmQ:        nType = 6; break;
                    }
                if(Node->Parent && Node->Parent->Data)
                    nParent = ((MAKET*)Node->Parent->Data)->tmpMid;
                else nParent = 0;

          dmMain->quMain->ParamByName("par1")->AsInteger= dMaket.Type;
          dmMain->quMain->ParamByName("par2")->ParamType=ptInputOutput;
          dmMain->quMain->ParamByName("par2")->DataType=ftInteger;
          dmMain->quMain->ParamByName("par2")->AsInteger= dMaket.Mid;
          dmMain->quMain->ParamByName("par3")->AsString= dMaket.Name;
          dmMain->quMain->ParamByName("par4")->AsString= dMaket.Comment;
          dmMain->quMain->ParamByName("par5")->AsInteger= dMaket.FormationFunc;
          dmMain->quMain->ParamByName("par6")->AsInteger= dMaket.Blocking;
          dmMain->quMain->ParamByName("par7")->AsInteger= dMaket.ExecUnexecutingInTime;
          dmMain->quMain->ParamByName("par8")->AsString= dMaket.StrCode;
          dmMain->quMain->ParamByName("par9")->AsFloat= dMaket.KC;
          dmMain->quMain->ParamByName("par10")->AsInteger= nType;
          dmMain->quMain->ParamByName("par11")->AsInteger= nParent;
          dmMain->quMain->ParamByName("par12")->AsFloat= dMaket.SFShift;
          dmMain->quMain->ParamByName("par13")->AsString= dMaket.Params;
          dmMain->quMain->ParamByName("par14")->AsFloat= dMaket.nSign;

                dmMain->quMain->Execute();
                dMaket.Mid=dmMain->quMain->ParamByName("par2")->AsInteger;
                ((MAKET*)Node->Data)->tmpMid = dMaket.Mid;
            }
            Node = Node->GetNext();
        }

        Node = MaketListTV->Items->GetFirstNode();
        while(Node)
        {
            if(Node->Data&&(((MAKET*)Node->Data)->editing > 0))
            {
                memcpy(&dMaket,Node->Data,sizeof(MAKET));
                if(dMaket.Type!=mtAgrGroup && dMaket.Type!=mtSubGroup){
                    Node = Node->GetNext();
                    continue;
                }
                if(Node->Parent&&Node->Parent->Data)
                    nParent = ((MAKET*)Node->Parent->Data)->tmpMid;
                else nParent = 0;
                dmMain->quMain->ParamByName("par1")->AsInteger= dMaket.Type;
                dmMain->quMain->ParamByName("par2")->ParamType=ptInputOutput;
                dmMain->quMain->ParamByName("par2")->DataType=ftInteger;
                dmMain->quMain->ParamByName("par2")->AsInteger= dMaket.Mid;
                dmMain->quMain->ParamByName("par3")->AsString= dMaket.Name;
                dmMain->quMain->ParamByName("par4")->AsString= dMaket.Comment;
                dmMain->quMain->ParamByName("par5")->AsInteger= dMaket.FormationFunc;
                dmMain->quMain->ParamByName("par6")->AsInteger= dMaket.Blocking;
                dmMain->quMain->ParamByName("par7")->AsInteger= dMaket.ExecUnexecutingInTime;
                dmMain->quMain->ParamByName("par8")->AsString= dMaket.StrCode;
                dmMain->quMain->ParamByName("par9")->AsFloat= dMaket.KC;
                dmMain->quMain->ParamByName("par10")->AsInteger= nType;
                dmMain->quMain->ParamByName("par11")->AsInteger= nParent;
                dmMain->quMain->ParamByName("par12")->AsFloat= dMaket.SFShift;
                dmMain->quMain->ParamByName("par13")->AsString= dMaket.Params;
                dmMain->quMain->ParamByName("par14")->AsFloat= dMaket.nSign;

                dmMain->quMain->Execute();
                dMaket.Mid=dmMain->quMain->ParamByName("par2")->AsInteger;
                ((MAKET*)Node->Data)->tmpMid = dMaket.Mid;
            }
            Node = Node->GetNext();
        }
        dmMain->orases->Commit();
        CountNodes_Del = 0;
        Node = MaketListTV->Items->GetFirstNode();
        while(Node)
        {
            if(Node->Data&&(((MAKET*)Node->Data)->editing > 0))
            {
                ((MAKET*)Node->Data)->editing=0;
                ((MAKET*)Node->Data)->Mid=((MAKET*)Node->Data)->tmpMid;
            }
            Node=Node->GetNext();
        }
       EditRec = false;
    }
    catch (Exception &exception)
    {
        dmMain->orases->Rollback();
        Application->ShowException(&exception);
        if(Node) MaketListTV->Selected = Node;
    }
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::vRefresh(TObject *Sender)
{
    MaketListTV->OnChange=NULL;
    MaketListTV->OnChanging = NULL;
    Screen->Cursor=crHourGlass;
    MaketListTV->Items->BeginUpdate();
    MaketListTV->Items->Clear();
    PointsTV->Items->Clear();
    Screen->Cursor=crDefault;
    if(LoadFormationFunc()&&ReadTreeNode(MaketListTV, NULL)&&ReadTreeNode(PointsTV, NULL)){
        if(MaketListTV->Items->Count){
            MaketListTV->OnChange = MaketListTVChange;
            MaketListTV->Selected = MaketListTV->Items->Item[0];
            MaketListTV->OnChanging = MaketListTVChanging;
        }
    }else{
        MaketListTVChange(MaketListTV,NULL);
    }
    CountNodes_Del=0;
    EditRec = false;
    MaketListTV->Items->EndUpdate();
}
//---------------------------------------------------------------------------

void __fastcall TEditMaketForm::PointsTVCollapsed(TObject *Sender,
      TTreeNode *Node)
{
   switch(Node->ImageIndex){
   case imFolder:
      Node->ImageIndex      =imOpenFldr;
      Node->SelectedIndex   =imOpenFldr;
      break;
   case imOpenFldr:
      Node->ImageIndex      =imFolder;
      Node->SelectedIndex   =imFolder;
      break;
   }
}
//---------------------------------------------------------------------------

void __fastcall TEditMaketForm::PointsTVExpanded(TObject *Sender,
      TTreeNode *Node)
{
   switch(Node->ImageIndex){
   case imFolder:
      Node->ImageIndex=imOpenFldr;
      Node->SelectedIndex=imOpenFldr;
      break;
   case imOpenFldr:
      Node->ImageIndex=imFolder;
      Node->SelectedIndex=imFolder;
      break;
   }
}
//---------------------------------------------------------------------------

void __fastcall TEditMaketForm::PointsTVExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
   ReadTreeNode((TTreeView*)Sender,Node);
}
//---------------------------------------------------------------------------
//считывание ветки дерева
bool __fastcall TEditMaketForm::ReadTreeNode(TTreeView *tv, TTreeNode *ParentNode)
{
  TTreeNode *addNode;
  try{
    if(ParentNode){
      if(!ParentNode->getFirstChild()||ParentNode->getFirstChild()->Data)
        return true;
      ParentNode->DeleteChildren();
    }
    dmMain->quMain->Params->Clear();
    if(tv==MaketListTV){ // дерево макетов
      dmMain->quMain->SQL->Text="begin ryda.makets_pg.getmakettree(:an_id,:an_type,:acur_t); end;";
      dmMain->quMain->ParamByName("acur_t")->ParamType=ptOutput;
      dmMain->quMain->ParamByName("acur_t")->DataType=ftCursor;
      if(!ParentNode){
        dmMain->quMain->ParamByName("an_id")->AsInteger = 0;
        dmMain->quMain->ParamByName("an_type")->AsInteger = 0;//MAKET_SQL;
      }else{
        dmMain->quMain->ParamByName("an_id")->AsInteger=((MAKET*)ParentNode->Data)->Mid;
        dmMain->quMain->ParamByName("an_type")->AsInteger=((MAKET*)ParentNode->Data)->Type;
      }
    }else{ // дерево точек
      dmMain->quMain->SQL->Text="begin ryda.makets_pg.getpointstree(:an_id,:acur_t); end;";
      dmMain->quMain->ParamByName("acur_t")->ParamType=ptOutput;
      dmMain->quMain->ParamByName("acur_t")->DataType=ftCursor;
      if(!ParentNode){
        MAKET *pData = new MAKET;
        strcpy(pData->Name,Reconst_smes24_2.c_str());
        pData->Type = mtGroup;
        addNode = tv->Items->AddChildObject(NULL,pData->Name,pData);
        addNode->ImageIndex = imGroup;
        addNode->SelectedIndex= imGroup;
        dmMain->quMain->ParamByName("an_id")->AsInteger=0;
      }else{
        dmMain->quMain->ParamByName("an_id")->AsInteger=((MAKET*)ParentNode->Data)->Mid;
      }
    }
    dmMain->quMain->Execute();
    while(!dmMain->quMain->Eof){
      MAKET *pData=new MAKET;
      if(tv == MaketListTV){
        if(!ParentNode || (ParentNode && ((MAKET*)ParentNode->Data)->Type==mtFolder)){
          pData->editing=dmMain->quMain->FieldByName("HaveChild")->AsInteger;
          pData->Type=(TMType)dmMain->quMain->FieldByName("Type")->AsInteger;
          pData->Mid=dmMain->quMain->FieldByName("mid")->AsInteger;
          strcpy(pData->Name,dmMain->quMain->FieldByName("vname")->AsString.c_str());
          strcpy(pData->Comment,dmMain->quMain->FieldByName("vnote")->AsString.c_str());
          pData->FormationFunc=dmMain->quMain->FieldByName("nprocedure")->AsInteger;
          pData->Blocking=dmMain->quMain->FieldByName("nblock")->AsInteger;
          pData->ExecUnexecutingInTime=dmMain->quMain->FieldByName("ncycle")->AsInteger;
          pData->SFShift=dmMain->quMain->FieldByName("nshift")->AsFloat;
          strcpy(pData->Params,dmMain->quMain->FieldByName("vparam")->AsString.c_str());
          strcpy(pData->LastDateFormation,dmMain->quMain->FieldByName("LastDate")->AsString.c_str());
          strcpy(pData->Error,dmMain->quMain->FieldByName("verror")->AsString.c_str());
          pData->nGroup=dmMain->quMain->FieldByName("parent")->AsInteger;
        }else{
         // switch(pData->Type){
         switch(((MAKET*)ParentNode->Data)->Type){
            case mtMaket:
              pData->editing=dmMain->quMain->FieldByName("HaveChild")->AsInteger;
              pData->Type=(TMType)dmMain->quMain->FieldByName("Type")->AsInteger;
              pData->Mid=dmMain->quMain->FieldByName("mid")->AsInteger;
              strcpy(pData->Name,dmMain->quMain->FieldByName("vname")->AsString.c_str());
              strcpy(pData->Comment,dmMain->quMain->FieldByName("vnote")->AsString.c_str());
              strcpy(pData->StrCode,dmMain->quMain->FieldByName("vcode")->AsString.c_str());
              break;
            case mtGroup:
              pData->editing=dmMain->quMain->FieldByName("HaveChild")->AsInteger;
              pData->Type=(TMType)dmMain->quMain->FieldByName("Type")->AsInteger;
              pData->Mid=dmMain->quMain->FieldByName("mid")->AsInteger;
              strcpy(pData->Name,dmMain->quMain->FieldByName("vname")->AsString.c_str());
              pData->GroupId=dmMain->quMain->FieldByName("ngroup")->AsInteger;
              strcpy(pData->Short_Name,dmMain->quMain->FieldByName("short_name")->AsString.c_str());
              pData->KC=dmMain->quMain->FieldByName("nkc")->AsFloat;
              pData->DimType=(TDimention)dmMain->quMain->FieldByName("ntype")->AsInteger;
              break;
            case mtAgrGroup:
              pData->editing=dmMain->quMain->FieldByName("HaveChild")->AsInteger;
              pData->Type=(TMType)dmMain->quMain->FieldByName("Type")->AsInteger;
              pData->Mid=dmMain->quMain->FieldByName("mid")->AsInteger;
              strcpy(pData->Name,dmMain->quMain->FieldByName("vname")->AsString.c_str());
              strcpy(pData->Comment,dmMain->quMain->FieldByName("vnote")->AsString.c_str());
              strcpy(pData->StrCode,dmMain->quMain->FieldByName("vcode")->AsString.c_str());
              pData->nSign=dmMain->quMain->FieldByName("nsign")->AsFloat;
              pData->nGroup=dmMain->quMain->FieldByName("ngroup")->AsInteger;
              break;
          }
        }
      }else{
        pData->editing=dmMain->quMain->FieldByName("HaveChild")->AsInteger;
        pData->Type=(TMType)dmMain->quMain->FieldByName("Type")->AsInteger;
        pData->Mid=dmMain->quMain->FieldByName("mid")->AsInteger;
        strcpy(pData->Name,dmMain->quMain->FieldByName("vname")->AsString.c_str());
        strcpy(pData->Short_Name,dmMain->quMain->FieldByName("short_name")->AsString.c_str());
      }
      addNode = tv->Items->AddChildObject(ParentNode, pData->Name, pData);
      if(tv==MaketListTV){  // выбор пиктограммы (и подгонка DimType для точки)
        int ind;
        switch(pData->Type) {
          case mtMaket:
            if(!AnsiString(pData->Error).Trim().IsEmpty())
              ind = (pData->Blocking)?imBlMaketErr:imMaketErr;
            else
              ind = (pData->Blocking)?imBlMaket:imMaket;
            break;
          case mtSubGroup:
          case mtGroup:
            ind = (pData->nSign < 0)?imInvGroup:imGroup;
            break;
          case mtPoint:
            ind = (pData->KC < 0)?imInvPoint:imPoint;
            repl_delimiters(pData->Name, " / ");
            addNode->Text = pData->Name;
            switch(pData->DimType){
              case 1: pData->DimType = dmAPlus;     break;
              case 2: pData->DimType = dmAMinus;    break;
              case 3: pData->DimType = dmQPlus;     break;
              case 4: pData->DimType = dmQMinus;    break;
              case 5: pData->DimType = dmA;         break;
              case 6: pData->DimType = dmQ;         break;
            }
            break;
          case mtAgrGroup:
            ind = imAgrGroup;
            break;
          case mtFolder:
            ind = GetFolderInd(addNode, pData->Blocking);
            break;
        }
        addNode->ImageIndex = ind;
        addNode->SelectedIndex = ind;
      }else{
        addNode->ImageIndex =(pData->Type==3)?imPoint:imFolder;
        addNode->SelectedIndex=(pData->Type==3)?imPoint:imFolder;
      }
      pData->tmpMid = pData->Mid;
      if(pData->editing){  // проверка на наличие дочерних
        tv->Items->AddChildObject(addNode,"",(void*)0);
        pData->editing=0;
      }
      dmMain->quMain->Next();
    }
    dmMain->quMain->Close();
  }catch (Exception &exception){
    Application->ShowException(&exception);
    return false;
   }
   m_Sel2Paste = NULL;
   return true;
}
//---------------------------------------------------------------------------
//проверка возможности приёма узла pNode узлом aNode при перемещении (копировании)
bool __fastcall TEditMaketForm::CheckAcceptNode(TTreeNode* aNode, TTreeNode* pNode)
{
   if(Access==accRead)
      return false;
   try{
      if(/*!aNode||!aNode->Data||*/!pNode||!pNode->Data||aNode==pNode||aNode == pNode->Parent)
         return false;
      MAKET* movM = (MAKET*)pNode->Data;
      if (aNode && aNode->Data){ // если тянем в узел дерева
        MAKET* accM = (MAKET*)aNode->Data;
        if(movM->Type==3){ // тянем точку
           if(accM->Type==2) return true;
           if(accM->Type==1) return true;
        }else if(movM->Type==2){ // тянем группу
           if(accM->Type==1||accM->Type==2) return true;
           if(accM->Type==4 && aNode->Parent==pNode->Parent) return true;
        }else if((movM->Type==4)&&(accM->Type==4)) return true;
        else if (movM->Type==1 && accM->Type==6) return true; // макет в папку
        else if (movM->Type==6 && accM->Type==6) return true; // папку в папку
      }else{ // тянем в никуда
        if ((movM->Type==1||movM->Type==6) && !aNode)
          return true; // макет или папку в никуда
      }
      return false;
   }catch(Exception &e){
      return false;
   }
}
//---------------------------------------------------------------------------

void __fastcall TEditMaketForm::MaketListTVDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
   if(Source->ClassNameIs("TTreeView")&&Sender->ClassNameIs("TTreeView"))
      Accept = CheckAcceptNode(((TTreeView*)Sender)->GetNodeAt(X, Y), ((TTreeView*)Source)->Selected);
   else
      Accept = false;
}
//---------------------------------------------------------------------------
//изменение выделенного узла в дереве (обновление информации во вкладке параметров)
void __fastcall TEditMaketForm::MaketListTVChange(TObject *Sender,
      TTreeNode *Node)
{
    TEdit *ed;
    TMemo *mm;
    TCheckBox *cb;
    TRadioGroup *rg;
    MAKET *pData = NULL;

    if(ActiveControl) oldCtrl = ActiveControl;
    if(!Node||!Node->Data){
        iaDelete->Enabled = false;
    }else{
        if(!iaDelete->Enabled)
            iaDelete->Enabled = true;
        pData = (MAKET*)Node->Data;
        SelType = pData->Type;
    }
    for(int i=0;i<ComponentCount;i++)//снятие обработчиков видимых элементов
    {
        ed=dynamic_cast<TEdit*>(Components[i]);
        cb=dynamic_cast<TCheckBox*>(Components[i]);
        rg=dynamic_cast<TRadioGroup*>(Components[i]);
        mm=dynamic_cast<TMemo*>(Components[i]);
        if(ed){
            ed->OnChange = NULL;
            ed->Text="";
        }else if(cb){
            cb->OnClick = NULL;
            cb->Checked = false;
        }else if(rg){
            rg->OnClick = NULL;
            rg->ItemIndex = -1;
        }else if(mm){
            mm->OnChange = NULL;
            mm->Text="";
        }
    }
    if(!pData)
      return;
    // установка доступности действий
    iaNewFolder->Enabled = pData->Type == mtMaket || pData->Type == mtFolder;   // !Node->Parent
    iaNew->Enabled = !Node->Parent || pData->Type == mtFolder || pData->Type == mtMaket;
    iaClone->Enabled = pData->Type == mtMaket;
    btChanel->Enabled = pData->Type == mtMaket;
    btSign->Enabled = pData->Type == mtMaket;
    // обновление данных видимых элементов
    eName->Text = pData->Name;
    eMid->Text = IntToStr(pData->Mid);
    switch(pData->Type) {
    case mtMaket://maket
        mComment->Lines->Text = pData->Comment;
        cbFormationFunc->ItemIndex = -1;
        for(int i=0; i < cbFormationFunc->Items->Count; i++) {
            if((long)cbFormationFunc->Items->Objects[i] == pData->FormationFunc) {
                cbFormationFunc->ItemIndex = i;
                break;
            }
        }
        cbBlocking->Checked = pData->Blocking;
        eSFShift->Text = FloatToStr(pData->SFShift);
        eAddParams->Text = pData->Params;
        cbExecUnexecutingInTime->Checked = pData->ExecUnexecutingInTime;
        eLastDateExec->Text = pData->LastDateFormation;
//        if(eLastDateExec->Text!="")
//          eLastDateExec->Text= FormatDateTime("dd.mm.yyyy",StrToDateTime(eLastDateExec->Text));
        mError->Lines->Text = pData->Error;
        break;
    case mtSubGroup:
        eNSign->Text = FloatToStr(pData->nSign);
    case mtAgrGroup://agr.group
    case mtGroup://group
        mComment->Lines->Text = pData->Comment;
        eStrCode->Text = pData->StrCode;
        if(pData->Type!=5)
            cbAgrGroup->Checked = pData->Type==4;
        if(pData->Type==2)
            GetCGB();
        break;
    case mtPoint://point
        eShortName->Text=pData->Short_Name;
        eEntryFactor->Text = FloatToStr(pData->KC);
        rgDimType->ItemIndex = pData->DimType-1;
        break;
    case mtFolder:
        cbBlocking->Checked = pData->Blocking;
        break;
    }
    for(int i=0;i<ComponentCount;i++) {//установка обработчиков видимых элементов
        ed=dynamic_cast<TEdit*>(Components[i]);
        cb=dynamic_cast<TCheckBox*>(Components[i]);
        rg=dynamic_cast<TRadioGroup*>(Components[i]);
        mm=dynamic_cast<TMemo*>(Components[i]);
        if(ed){
            ed->OnChange = DataChange;
        }else if(cb){
            cb->OnClick = CheckedClick;
        }else if(rg){
            rg->OnClick = CheckedClick;
        }else if(mm){
            mm->OnChange = DataChange;
        }
    }
    try{
        ActiveControl = oldCtrl;
    }catch(Exception&e){
        ActiveControl = NULL;
    }
}
//---------------------------------------------------------------------------
//сохранение изменений параметров текущего узла при его изменении на другой
void __fastcall TEditMaketForm::MaketListTVChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
    TTreeNode*sNode = MaketListTV->Selected;
    TWinControl *errCtrl = NULL;
    try{
        if(!sNode||!sNode->Data||((MAKET*)sNode->Data)->editing!=2)
            return;
        MAKET* pData=(MAKET*)sNode->Data;

        if(pData->Type==mtMaket ||
            pData->Type==mtGroup ||
            pData->Type==mtAgrGroup)
        {
            strcpy(pData->Name, eName->Text.c_str());
            strcpy(pData->Comment, mComment->Lines->Text.c_str());
        }
        switch (pData->Type) {
        case mtMaket://maket
            errCtrl = cbFormationFunc;
            if(cbFormationFunc->ItemIndex<0)
                throw Exception(Reconst_smes24_3);
            else
                pData->FormationFunc = (long)cbFormationFunc->Items->Objects[cbFormationFunc->ItemIndex];
            pData->SFShift = StrToFloat(eSFShift->Text);
            strcpy(pData->Params, eAddParams->Text.c_str());
            pData->Blocking = cbBlocking->Checked;
            pData->ExecUnexecutingInTime = cbExecUnexecutingInTime->Checked;
            break;
        case mtGroup://group
        case mtAgrGroup:
            strcpy(pData->StrCode, eStrCode->Text.c_str());
            break;
        case mtPoint://point
            errCtrl = eEntryFactor;
            pData->KC = StrToFloat(eEntryFactor->Text);
            errCtrl = rgDimType;
            if(rgDimType->ItemIndex<0)
                throw Exception(Reconst_smes24_4);
            else switch(rgDimType->ItemIndex){
            case 0: pData->DimType = dmAPlus;  break;
            case 1: pData->DimType = dmAMinus; break;
            case 2: pData->DimType = dmA;      break;
            case 3: pData->DimType = dmQPlus;  break;
            case 4: pData->DimType = dmQMinus; break;
            case 5: pData->DimType = dmQ;      break;
            case -1:
            default:
                pData->DimType = dmUnknown;
            }
            break;
        case mtSubGroup:
            errCtrl = eNSign;
            pData->nSign = StrToFloat(eNSign->Text);
            break;
        case mtFolder:
            strcpy(pData->Name, eName->Text.c_str());
            pData->Blocking = cbBlocking->Checked;
            break;
      }
   }catch (Exception &exception){
      AllowChange=false;
	   Application->ShowException(&exception);
      if(errCtrl) {
         PageControl->ActivePageIndex = 1;
         errCtrl->SetFocus();
      }
   }
}
//---------------------------------------------------------------------------

void __fastcall TEditMaketForm::DataChange(TObject *Sender)
{
   TTreeNode *sNode=MaketListTV->Selected;
   if(!sNode||!sNode->Data)
      return;
   if(((MAKET*)sNode->Data)->editing!=2)
      ((MAKET*)sNode->Data)->editing=2;
   if(!EditRec) EditRec = true;
   if((TEdit*)Sender==eName)
      sNode->Text=eName->Text;
   if((TEdit*)Sender==eEntryFactor)
   try{
      if(StrToFloat(eEntryFactor->Text)<0){
         sNode->ImageIndex = imInvPoint;
         sNode->SelectedIndex = imInvPoint ;
      }else{
         sNode->ImageIndex = imPoint;
         sNode->SelectedIndex = imPoint;
      }
   }catch(Exception &e){
   }
   if((TEdit*)Sender==eNSign)
   try{
      if(StrToFloat(eNSign->Text)<0){
         sNode->ImageIndex = imInvGroup;
         sNode->SelectedIndex = imInvGroup;
      }else{
         sNode->ImageIndex = imGroup;
         sNode->SelectedIndex = imGroup;
      }
   }catch(Exception &e){
   }
   MaketListTV->Invalidate();
}
//---------------------------------------------------------------------------

void __fastcall TEditMaketForm::CheckedClick(TObject *Sender)
{
    TTreeNode *sNode=MaketListTV->Selected;
    if(!sNode||!sNode->Data)
        return;
    TDimention num = dmUnknown;
    if(     Sender == cbAPlus)   num = dmAPlus;
    else if(Sender == cbAMinus)  num = dmAMinus;
    else if(Sender == cbAOvfw)   num = dmA;
    else if(Sender == cbQPlus)   num = dmQPlus;
    else if(Sender == cbQMinus)  num = dmQMinus;
    else if(Sender == cbQOvfw)   num = dmQ;
    if(num){
        if(((TCheckBox*)Sender)->State==cbUnchecked){
            ((TCheckBox*)Sender)->OnClick = NULL;
            ((TCheckBox*)Sender)->State = cbChecked;
            ((TCheckBox*)Sender)->OnClick = CheckedClick;
        }else
            SetCGB(num, ((TCheckBox*)Sender)->State);
    }else{
        if(((MAKET*)sNode->Data)->editing!=2)
            ((MAKET*)sNode->Data)->editing=2;
            if(!EditRec) EditRec = true;
    }
    if(Sender==cbBlocking){
      int ind;
      if (((MAKET*)sNode->Data)->Type==mtFolder){
        ind = GetFolderInd(sNode,cbBlocking->Checked);
      }
      else{
        if(AnsiString(((MAKET*)sNode->Data)->Error).Trim().IsEmpty())
          ind=(cbBlocking->Checked)?imBlMaket:imMaket;
        else
          ind=(cbBlocking->Checked)?imBlMaketErr:imMaketErr;
      }
      sNode->ImageIndex = ind;
      sNode->SelectedIndex = ind;
      MaketListTV->Invalidate();
    }

    if(Sender==cbAgrGroup){
        //MAKET*
        if(((TCheckBox*)Sender)->Checked)
        {
            if(!sNode->getFirstChild()||MessageBox(Application->Handle, Reconst_smes24_5.c_str(), Application->Title.c_str(), MB_OKCANCEL|MB_ICONINFORMATION)==IDOK)
            {
                if(sNode->getFirstChild()&&!sNode->getFirstChild()->Data){
                    sNode->DeleteChildren();
                    ReadTreeNode(MaketListTV, sNode);
                }
                realdeletion = true;
                sNode->DeleteChildren();
                realdeletion = false;
                sNode->ImageIndex = imAgrGroup;
                sNode->SelectedIndex = imAgrGroup;
                ((MAKET*)sNode->Data)->Type = mtAgrGroup;
                MaketListTV->Selected = NULL;
                MaketListTV->Selected = sNode;
            }else{
                cbAgrGroup->OnClick = NULL;
                cbAgrGroup->Checked = false;
                cbAgrGroup->OnClick = CheckedClick;
            }
        }else{
            if(!sNode->getFirstChild()||MessageBox(Application->Handle,
                Reconst_smes24_6.c_str(), Application->Title.c_str(),
                MB_OKCANCEL|MB_ICONINFORMATION)==IDOK)
            {
                if(sNode->getFirstChild()&&!sNode->getFirstChild()->Data){
                    sNode->DeleteChildren();
                    ReadTreeNode(MaketListTV, sNode);
                }
                realdeletion = true;
                sNode->DeleteChildren();
                realdeletion = false;
                sNode->ImageIndex = imGroup;
                sNode->SelectedIndex = imGroup;
                ((MAKET*)sNode->Data)->Type = mtGroup;
                MaketListTV->Selected = NULL;
                MaketListTV->Selected = sNode;
            }else{
                cbAgrGroup->OnClick = NULL;
                cbAgrGroup->Checked = true;
                cbAgrGroup->OnClick = CheckedClick;
            }
        }
    }
}
//---------------------------------------------------------------------------

void __fastcall TEditMaketForm::MaketListTVDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
   TTreeNode*Dst = ((TTreeView*)Sender)->GetNodeAt(X, Y);
   TTreeNode*Src = ((TTreeView*)Source)->Selected;
   TCursor old;
   try{
      old = Screen->Cursor;
      Screen->Cursor=crHourGlass;
      if(!Src || !Src->Data)
         throw Exception(Reconst_smes24_8);
      Src->Cut = !(GetKeyState(VK_CONTROL)&0x8000);

      changeNode(Dst, Src);

      if((Src->TreeView==PointsTV || (Dst&&((MAKET*)Dst->Data)->Type==mtAgrGroup) || !Dst) && Src->Cut)
         Src->Cut = false;
      Screen->Cursor=old;//crArrow;
   }catch (Exception &exception){
      Screen->Cursor=old;//crArrow;
  	   Application->ShowException(&exception);
   }
}
//---------------------------------------------------------------------------

void __fastcall TEditMaketForm::MaketListTVDeletion(TObject *Sender,
      TTreeNode *Node)
{
   if(Clipboard()->GetAsHandle(CF_MAKETS_TREENODE)==(unsigned int)Node)
      Clipboard()->Clear();
   if(Node&&(MaketListTV->Selected==Node)){
      MaketListTV->Selected->Cut = false;
      MaketListTV->Selected = NULL;
   }
   if(Node && Node->Data){
      MAKET*pData = (MAKET*)Node->Data;
      if(realdeletion&&pData->Mid){
         nNodes_Del[CountNodes_Del].Type = pData->Type;
         nNodes_Del[CountNodes_Del].Mid = pData->Mid;
         switch(pData->Type)
         {
         case mtPoint:
            nNodes_Del[CountNodes_Del].nGroup = pData->GroupId;
            break;
         case mtSubGroup:
            nNodes_Del[CountNodes_Del].nGroup = pData->nGroup;
            break;
         default:
            nNodes_Del[CountNodes_Del].nGroup = 0;
         }
         CountNodes_Del++;
      }
      delete (MAKET*)Node->Data;
   }
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::cbMouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
   if(!Sender->ClassNameIs("TCheckBox")||((TCheckBox*)Sender)->State==cbUnchecked)
      return;
   TCheckBox* cbCurr = (TCheckBox*)Sender;
   if(Shift.Contains(ssLeft)){
      cbCurr->OnClick = NULL;
      TCheckBoxState st = cbCurr->State;
      cbCurr->BeginDrag(false, -1);
      cbCurr->State = st;
      cbCurr->OnClick = CheckedClick;
   }
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::cbDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
   if(Sender->ClassNameIs("TCheckBox")&&Source->ClassNameIs("TCheckBox")&&
      (Sender != Source))
      Accept = true;
   else
      Accept = false;
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::cbDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
   TCheckBox*cbSrc = (TCheckBox*)Source;
   TCheckBox*cbDst = (TCheckBox*)Sender;
   int fndNum, setNum;
   if(cbSrc==cbAPlus)         fndNum = dmAPlus;
   else if(cbSrc==cbAMinus)   fndNum = dmAMinus;
   else if(cbSrc==cbAOvfw)    fndNum = dmA;
   else if(cbSrc==cbQPlus)    fndNum = dmQPlus;
   else if(cbSrc==cbQMinus)   fndNum = dmQMinus;
   else if(cbSrc==cbQOvfw)    fndNum = dmQ;
   if(cbDst==cbAPlus)         setNum = dmAPlus;
   else if(cbDst==cbAMinus)   setNum = dmAMinus;
   else if(cbDst==cbAOvfw)    setNum = dmA;
   else if(cbDst==cbQPlus)    setNum = dmQPlus;
   else if(cbDst==cbQMinus)   setNum = dmQMinus;
   else if(cbDst==cbQOvfw)    setNum = dmQ;

//   ReadTreeNode(MaketListTV, MaketListTV->Selected); - не нужно т.к. считывне было при определнии состояний CheckBox-ов
   TTreeNode*tn = MaketListTV->Selected->getFirstChild();
   MAKET*pData;
   while(tn){
      pData = (MAKET*)tn->Data;
      if(pData->DimType == fndNum){
         pData->DimType = (TDimention)setNum;
         pData->editing = 1;
      }
      tn = tn->getNextSibling();
   }
   EditRec = true;

   cbSrc->OnClick = NULL;
   cbDst->OnClick = NULL;
   cbSrc->State = cbUnchecked;
   bool allUncheckedButDst = true;
   if(cbDst!=cbAPlus  && cbUnchecked!=cbAPlus->State)   allUncheckedButDst = false;
   if(cbDst!=cbAMinus && cbUnchecked!=cbAMinus->State)  allUncheckedButDst = false;
   if(cbDst!=cbQPlus  && cbUnchecked!=cbQPlus->State)   allUncheckedButDst = false;
   if(cbDst!=cbQMinus && cbUnchecked!=cbQMinus->State)  allUncheckedButDst = false;
   if(cbDst!=cbAOvfw  && cbUnchecked!=cbAOvfw->State)   allUncheckedButDst = false;
   if(cbDst!=cbQOvfw  && cbUnchecked!=cbQOvfw->State)   allUncheckedButDst = false;
   if(allUncheckedButDst)
      cbDst->State = cbChecked;
   else
      cbDst->State = cbGrayed;
   cbSrc->OnClick = CheckedClick;
   cbDst->OnClick = CheckedClick;
}
//---------------------------------------------------------------------------
bool __fastcall TEditMaketForm::MoveNode(TTreeNode*mNode, TTreeNode*aNode)
{
   MAKET*pData;
   TTreeNode*tn;
   if(!aNode){
     pData = (MAKET*)mNode->Data;
     if(pData->Type==mtFolder || pData->Type==mtMaket){  // тянем в никуда папку или макет
       tn = mNode->Parent;
       mNode->MoveTo(NULL, naAddChild);
       pData->nGroup = 0;
       if(!pData->editing) pData->editing = 1;
       if (tn && !tn->HasChildren) // для бывшего родителя-папки оставшегося без детей надо перерисовать иконку
         MaketListTVExpanded(tn->TreeView,tn);
       if(!EditRec) EditRec = true;
       return true;
     }
     return false;
   }

   pData = (MAKET*)mNode->Data;
   if(aNode->HasChildren && !aNode->getFirstChild()->Data)
      ReadTreeNode((TTreeView*)aNode->TreeView, aNode);
   if(((MAKET*)aNode->Data)->Type == mtAgrGroup){
      MAKET *p = new MAKET;
      memcpy(p, pData, sizeof(MAKET));
      p->editing = 1;
      p->Type = mtSubGroup;
      p->nSign = 1;
      tn = MaketListTV->Items->AddChildObject(aNode, pData->Name, p);
      tn->ImageIndex = imGroup;
      tn->SelectedIndex = imGroup;
      aNode = tn;
   } else if(pData->Type==mtPoint||
      (pData->Type==mtGroup &&
      ((MAKET*)aNode->Data)->Type==mtMaket))
   {
      if((((MAKET*)aNode->Data)->Type==mtMaket)&&
        (((MAKET*)mNode->Data)->Type==mtPoint))
      {
         MAKET *p = new MAKET;
         ZeroMemory(p, sizeof(MAKET));
         p->Type = mtGroup;
         p->editing = 1;
         strcpy(p->Name, pData->Name);
         tn = MaketListTV->Items->AddChildObject(aNode, mNode->Text, p);
         tn->ImageIndex = imGroup;
         tn->SelectedIndex = imGroup;
         aNode = tn;
      }

      if(!(pData->Type==mtGroup && ((MAKET*)aNode->Data)->Type==mtMaket)){ // группу переносимую в макет не удалаем!
        nNodes_Del[CountNodes_Del].Type = pData->Type;
        nNodes_Del[CountNodes_Del].Mid = pData->Mid;
        switch(pData->Type)
        {
          case mtPoint:
            nNodes_Del[CountNodes_Del].nGroup = pData->GroupId;
            break;
          case mtSubGroup:
            nNodes_Del[CountNodes_Del].nGroup = pData->nGroup;
            break;
          default:
            nNodes_Del[CountNodes_Del].nGroup = 0;
        }
        CountNodes_Del++;
      }
      switch(pData->Type) // при переносе заменяем ид родителя на новый
      {
        case mtPoint:
          pData->GroupId = ((MAKET*)aNode->Data)->Mid;
          break;
        case mtSubGroup:
          pData->nGroup = ((MAKET*)aNode->Data)->Mid;
          break;
      }
      mNode->MoveTo(aNode, naAddChild);
      if(!pData->editing) pData->editing = 1;
   }else if (((MAKET*)aNode->Data)->Type==mtFolder || ((MAKET*)mNode->Data)->Type==mtMaket){
      tn = mNode->Parent;
      mNode->MoveTo(aNode, naAddChild);
      pData->nGroup = ((MAKET*)aNode->Data)->Mid;
      if(!pData->editing) pData->editing = 1;
      if (tn && !tn->HasChildren) // для бывшего родителя-папки оставшегося без детей надо перерисовать иконку
        MaketListTVExpanded(tn->TreeView,tn);
      MaketListTVExpanded(aNode->TreeView,aNode); // для нового родителя-папки надо тоже перерисовать иконку
   }else
    {
      if(aNode->HasChildren && !aNode->getFirstChild()->Data)
         ReadTreeNode((TTreeView*)aNode->TreeView, aNode);
      tn = mNode->getFirstChild();
      while(tn){
         tn->MoveTo(aNode, naAddChild);
         if(!((MAKET*)tn->Data)->editing)
            ((MAKET*)tn->Data)->editing = 1;
         tn = tn->getNextSibling(); ///// сечин добавил наугад
      }
      realdeletion = true;
      mNode->Delete();
      realdeletion = false;
      aNode->TreeView->Repaint();
    }
   if(!EditRec) EditRec = true;
   return true;
}
//---------------------------------------------------------------------------
bool __fastcall TEditMaketForm::CopyNode(TTreeNode*cNode, TTreeNode*aNode)
{
   TTreeNode*tn;
   if (!aNode){
     if (((MAKET*)cNode->Data)->Type==mtFolder||((MAKET*)cNode->Data)->Type==mtMaket){ // копируем в никуда папку или макет
        MAKET *pData = new MAKET;
        memcpy(pData, cNode->Data, sizeof(MAKET));
        pData->Mid = pData->tmpMid = 0;
        pData->nGroup = 0;
        tn = MaketListTV->Items->AddChildObject(NULL, pData->Name, pData);
        int ind;
        switch(pData->Type){
          case mtFolder:
           ind = (pData->Blocking)?imBlFolder:imFolder;
           break;
          case mtMaket:
           ind = (pData->Blocking)?imBlMaket:imMaket;
           break;
          default:
           ind = cNode->ImageIndex;
        }
        tn->ImageIndex = ind;
        tn->SelectedIndex = ind;
        pData->editing = 1;
        if(cNode->HasChildren)  //контроль добавления дочерних узлов
          CopyChildPoints(tn, cNode);
        if(!EditRec) EditRec = true;
        return true;
     }
     return false;
   }
   if(aNode->HasChildren && !aNode->getFirstChild()->Data)
         ReadTreeNode((TTreeView*)aNode->TreeView, aNode);
   if((((MAKET*)aNode->Data)->Type==mtMaket)||(((MAKET*)cNode->Data)->Type==mtPoint)
      ||(((MAKET*)cNode->Data)->Type==mtFolder)||(((MAKET*)aNode->Data)->Type==mtFolder))
   {
      MAKET *pData = new MAKET;
      memcpy(pData, cNode->Data, sizeof(MAKET));
      if(pData->Type!=mtPoint)
         pData->Mid = pData->tmpMid = 0;
      if((((MAKET*)aNode->Data)->Type==mtMaket)&&(((MAKET*)cNode->Data)->Type==mtPoint))
      {
         MAKET *p = new MAKET;
         ZeroMemory(p, sizeof(MAKET));
         p->Type = mtGroup;
         p->editing = 1;
         AnsiString s;
         if (cNode->Parent)
           s = AnsiString(((MAKET*)cNode->Parent->Data)->Name)+AnsiString(" - ");
         s += AnsiString(((MAKET*)cNode->Data)->Name);
         strcpy(p->Name, s.c_str());
         tn = MaketListTV->Items->AddChildObject(aNode, p->Name, p);
         tn->ImageIndex = mtGroup;
         tn->SelectedIndex = mtGroup;
         aNode = tn;
      }

      switch(pData->Type){  // заменяем ид родителя новой копии узла на ид нового родителя
          case mtPoint:
            pData->GroupId = ((MAKET*)aNode->Data)->Mid;
            break;
          case mtSubGroup:
            pData->nGroup = ((MAKET*)aNode->Data)->Mid;
            break;
          case mtMaket:
            pData->nGroup = ((MAKET*)aNode->Data)->Mid;
            break;
          case mtFolder:
            pData->nGroup = ((MAKET*)aNode->Data)->Mid;
            break;
      }
      tn = MaketListTV->Items->AddChildObject(aNode, pData->Name, pData);
      int ind;
      switch(pData->Type){ // выставляем индекс иконки узла
        case mtPoint:
         if(!pData->DimType)
            pData->DimType = dmA;
         if(cNode->TreeView == PointsTV){
            pData->KC = 1;
            //GRB ADD 16.04.2020 - test trouble ODAC
            dmMain->quMain->Params->Clear();
            //END ADD 
            dmMain->quMain->SQL->Text="SELECT ryda.util_pg.get_pointname(:par1,1)vname from dual";
            dmMain->quMain->ParamByName("par1")->AsInteger=pData->Mid;
            dmMain->quMain->Execute();
            strcpy(pData->Name,dmMain->quMain->FieldByName("vname")->AsString.c_str());
            repl_delimiters(pData->Name, " / ");
            tn->Text = pData->Name;
         }
         ind = (pData->KC < 0)?imInvPoint:imPoint;
         break;
        case mtFolder:
         ind = (pData->Blocking)?imBlFolder:imFolder;
         break;
        case mtMaket:
         ind = (pData->Blocking)?imBlMaket:imMaket;
         break;
        default:
         ind = imGroup;
      }
      tn->ImageIndex = ind;
      tn->SelectedIndex = ind;
      pData->editing = 1;
   }else tn = aNode;
   if(cNode->HasChildren&&(((MAKET*)cNode->Data)->Type!=mtPoint))  //контроль добавления дочерних узлов
      CopyChildPoints(tn, cNode);
   if(!EditRec) EditRec = true;
   return true;
}
//---------------------------------------------------------------------------

void __fastcall TEditMaketForm::CopyChildPoints(TTreeNode *d, TTreeNode *s)
{
    ReadTreeNode((TTreeView*)s->TreeView, s);
    TTreeNode *tn = s->getFirstChild();
    TTreeNode *tmp;
    MAKET *pData;
    while(tn){
        if(s->TreeView != PointsTV &&
            ((MAKET*)tn->Data)->Type==mtGroup &&
            ((MAKET*)s->Data)->Type!=mtMaket)
            CopyChildPoints(d, tn);
        else if(s->TreeView != MaketListTV && ((MAKET*)tn->Data)->Type==mtGroup)
            CopyChildPoints(d, tn);
        else
        {
            pData = new MAKET;
            memcpy(pData, tn->Data, sizeof(MAKET));
            tmp = MaketListTV->Items->AddChildObjectFirst(d, pData->Name, pData);
            // настройка начального состояния
            tmp->ImageIndex = tn->ImageIndex;
            tmp->SelectedIndex = tn->SelectedIndex;
            pData->editing = 1;
            if(pData->Type!=mtPoint)
                pData->Mid = pData->tmpMid = 0;
            else
                pData->DimType = dmAPlus;

            // Копирование из дерева точек
            if(s->TreeView == PointsTV)
            {
                pData->KC = 1;
               // int rez;
                //GRB ADD 16.04.2020 - test trouble ODAC
                dmMain->quMain->Params->Clear();
                //END ADD 

                dmMain->quMain->SQL->Text="SELECT ryda.util_pg.get_pointname(:par1,1)vname from dual";
                dmMain->quMain->ParamByName("par1")->AsInteger=pData->Mid;
                dmMain->quMain->Execute();
                strcpy(pData->Name,dmMain->quMain->FieldByName("vname")->AsString.c_str());
                repl_delimiters(pData->Name, " / ");
                tmp->Text = pData->Name;
            }
            if(((MAKET*)tn->Data)->Type != mtPoint)
                CopyChildPoints(tmp, tn);
        }
        tn = tn->getNextSibling();
    }
}
//---------------------------------------------------------------------------
//добавление нового макета
void __fastcall TEditMaketForm::vNew(TObject* Sender)
{
    try{
        bool aChge = true;
        MaketListTV->OnChange = NULL;
        MaketListTV->OnChanging = NULL;
        MaketListTVChanging(MaketListTV, MaketListTV->Selected, aChge);
        if(!aChge) return;
        MAKET *pData = new MAKET;
        pData->Type = mtMaket;
        pData->editing = 2;
        strcpy(pData->Name, Reconst_smes24_9.c_str());
        pData->Blocking = true;

        TTreeNode *newMaket;
        if (MaketListTV->Selected){
          switch (((MAKET*)MaketListTV->Selected->Data)->Type){
            case mtFolder:
              if(MaketListTV->Selected->getFirstChild() && !MaketListTV->Selected->getFirstChild()->Data){
                  ReadTreeNode(MaketListTV, MaketListTV->Selected);
              }
              newMaket = MaketListTV->Items->AddChildObjectFirst(MaketListTV->Selected, pData->Name, pData);
              break;
            case mtMaket:
              newMaket = MaketListTV->Items->AddObjectFirst(MaketListTV->Selected, pData->Name, pData);
              break;
            default:
              delete pData;
              MaketListTV->OnChange = MaketListTVChange;
              MaketListTV->OnChanging = MaketListTVChanging;
              return;
          }
        }else{
          newMaket = MaketListTV->Items->AddObject(MaketListTV->Selected, pData->Name, pData);
        }
        newMaket->ImageIndex = imBlMaket;
        newMaket->SelectedIndex = imBlMaket;
        newMaket->Selected = true;
        PageControl->ActivePageIndex = 1;
        plGroups->Visible = false;
        plPoints->Visible = false;
        if(!EditRec) EditRec = true;
        MaketListTVChange(MaketListTV, newMaket);
        MaketListTV->OnChange = MaketListTVChange;
        MaketListTV->OnChanging = MaketListTVChanging;
        eName->SetFocus();
    }catch (Exception &exception){
        Application->ShowException(&exception);
    }
}
//---------------------------------------------------------------------------
//удаление узла из дерева
void __fastcall TEditMaketForm::vDelete(TObject* Sender)
{
    TTreeNode *sNode=MaketListTV->Selected;
    TTreeView *tv=NULL;
    if(sNode&&sNode->Data&&MessageBox(Handle,AnsiString(Reconst_smes24_10+sNode->Text+">?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){
        tv=(TTreeView*)sNode->TreeView;
        TTreeNode*nextNode = sNode->getNextSibling();
        if(!nextNode){
            nextNode = sNode->getPrevSibling();
            if(!nextNode) nextNode = sNode->Parent;
        }
        try{
            realdeletion=true;
            sNode->Delete();
            realdeletion=false;
        }catch(Exception &e){
            realdeletion=false;
            throw;
        }
      tv->Repaint();
      if(tv&&!tv->Items->Count&&tv->OnChange)
         tv->OnChange(tv,NULL);
      else tv->Selected = nextNode;
      if(!EditRec)
         EditRec = true;
   }
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::vAnyEditClick(TObject*Sender)
{
   TTreeNode*selNode;
   TTreeView*tvControl = dynamic_cast<TTreeView*>(ActiveControl);
   TComponent *pMenu = dynamic_cast<TComponent*>(Sender);

   if(tvControl)
   try{
      if(pMenu)
         switch (pMenu->Tag){
         case 1: // Cut
            if(tvControl==PointsTV)
               break;
            if(Clipboard()->HasFormat(CF_MAKETS_TREENODE))
               ((TTreeNode*)Clipboard()->GetAsHandle(CF_MAKETS_TREENODE))->Cut = false;
            Clipboard()->SetAsHandle(CF_MAKETS_TREENODE, (UINT)tvControl->Selected);
            if(tvControl->Selected && tvControl->Selected->Data && ((MAKET*)tvControl->Selected->Data)->Type!=1)
               tvControl->Selected->Cut = true;
            else
               Clipboard()->Clear();
            break;
         case 2: // Copy
            if(Clipboard()->HasFormat(CF_MAKETS_TREENODE))
               ((TTreeNode*)Clipboard()->GetAsHandle(CF_MAKETS_TREENODE))->Cut = false;
            Clipboard()->SetAsHandle(CF_MAKETS_TREENODE, (UINT)tvControl->Selected);
            if(tvControl->Selected && tvControl->Selected->Data && ((MAKET*)tvControl->Selected->Data)->Type!=1)
               tvControl->Selected->Cut = false;
            else
               Clipboard()->Clear();
            break;
         case 3: // Paste
            selNode = (TTreeNode*)Clipboard()->GetAsHandle(CF_MAKETS_TREENODE);
            if(!selNode)
               break;
            if(selNode->Cut) Clipboard()->Clear();
            if(CheckAcceptNode(tvControl->Selected, selNode)){
               changeNode(tvControl->Selected, selNode);
               if(((MAKET*)tvControl->Selected->Data)->Type==4 && selNode->Cut)
                  selNode->Cut = false;
            }else{
               selNode->Cut = false;
               MessageBox(this->Handle, Reconst_smes24_11.c_str(),
                  Caption.c_str(), MB_OK|MB_ICONINFORMATION);
            }
            break;
         case 4: // Delete
            vDelete(Sender);
            break;
         case 5:
            break;
         default : return;
         }
   }catch(Exception &e){
   }
   else
      TMainForm::vAnyEditClick(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::aMExecute(TObject *Sender)
{
   TTreeNode*ptn;
   TAction*pa = dynamic_cast<TAction*>(Sender);

   if(pa){
      ptn = MaketListTV->Selected;
      switch(pa->Tag){
      case 1:// Alt+Left
         if(ptn->Expanded)
            ptn->Collapse(false);
         else if(ptn->Parent)
            MaketListTV->Selected = ptn->Parent;
         break;
      case 2:// Alt+Right
         if(!ptn->Expanded)
            ptn->Expand(false);
         else if(ptn->HasChildren)
            MaketListTV->Selected = ptn->getFirstChild();
         break;
      case 3:// Alt+Up
         ptn = MaketListTV->Selected->GetPrevVisible();
         if(ptn) MaketListTV->Selected = ptn;
         break;
      case 4:// Alt+Down
         ptn = MaketListTV->Selected->GetNextVisible();
         if(ptn) MaketListTV->Selected = ptn;
         break;
      }
   }
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::vEditClick(TObject*Sender)
{
   TTreeNode*tn;
   if(ActiveControl==MaketListTV){
      mnPaste->Enabled = Clipboard()->HasFormat(CF_MAKETS_TREENODE);
      mnCut->Enabled = MaketListTV->Selected;
      mnCopy->Enabled = MaketListTV->Selected;
      mnDelete->Enabled = MaketListTV->Selected;
      mnSelect->Enabled = false;
   }else if(ActiveControl==PointsTV){
      mnPaste->Enabled = false;
      mnCut->Enabled = false;
      mnCopy->Enabled = PointsTV->Selected;
      mnDelete->Enabled = false;
      mnSelect->Enabled = false;
   }else
      TMainForm::vEditClick(Sender);
}
//---------------------------------------------------------------------------
inline void __fastcall TEditMaketForm::changeNode(TTreeNode*Dst, TTreeNode*Src)
{
   bool copy;
   if(!Src->Cut && Src->TreeView==MaketListTV && ((Dst&&((MAKET*)Dst->Data)->Type!=4) || !Dst))
   {// Copy
      CopyNode(Src, Dst);
   }else{//Перенос
      if(Src->TreeView==PointsTV){
         CopyNode(Src, Dst);
      }else
         MoveNode(Src, Dst);
   }
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::vClone(TObject *Sender)
{
    MAKET*pMaket = (MAKET*)MaketListTV->Selected->Data;
    if(!pMaket || pMaket->Type!=mtMaket)
        throw Exception(Reconst_smes24_12);
    try{
        if (EditRec)
          switch (MessageBox(Handle, Reconst_smes24_15.c_str(),
                        Application->Title.c_str(),
                        MB_YESNOCANCEL | MB_ICONQUESTION))
          { case IDYES:
                if (Access == accDenied && Access == accRead)
                  throw Exception(Reconst_smes24_16);
                vSave(Sender);
                if (EditRec)
                return;
                break;
            case IDCANCEL:
                return;
          }
        oqClone->ParamByName("old_m")->AsInteger = pMaket->Mid;
        oqClone->Execute();
        int imaket=oqClone->ParamByName("new_m")->AsInteger;
        vRefresh(this);
        // после обновления дерева надо найти клонированный узел и стать на него
        TTreeNode * tn=MaketListTV->Items->GetFirstNode();
        while(tn){
          if((MAKET*)tn->Data&&((MAKET*)tn->Data)->Type==mtMaket&&((MAKET*)tn->Data)->Mid==imaket){
            MaketListTV->Selected = tn;
            break;
          }
          if ((MAKET*)tn->Data&&((MAKET*)tn->Data)->Type==mtFolder)
            ReadTreeNode(MaketListTV,tn);
          tn=tn->GetNext();
        }
    }catch(Exception&e){
        throw;
    }
}
//--------------------------------------------------------------------------
void __fastcall TEditMaketForm::btChanelClick(TObject *Sender)
{
  TTreeNode*sNode = MaketListTV->Selected;
  /*while(sNode&&sNode->Parent)
    sNode=sNode->Parent;*/
  if(sNode&&sNode->Data&&((MAKET*)sNode->Data)->Type==mtMaket)
  {
    TfmViewTree *f = new TfmViewTree(this, Reconst_smes43_10, ((MAKET*)sNode->Data)->Mid, CHANN_DISTRIBUTION);
    f->ShowModal();
    delete f;
  }
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::mMonClick(TObject *Sender)
{
   TTreeNode* sNode = MaketListTV->Selected;
   while(sNode&&sNode->Parent)
     sNode=sNode->Parent;
  if(sNode)
   SetPopupMenu( Sender, ((MAKET*)sNode->Data)->Mid,((MAKET*)sNode->Data)->Name);
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::MaketListTVExpanded(TObject *Sender,
      TTreeNode *Node)
{
   if(!Node || !Node->Data || ((MAKET*)Node->Data)->Type!=mtFolder) return;

   bool bl = MaketListTV->Selected==Node ? cbBlocking->Checked : ((MAKET*)Node->Data)->Blocking;
   Node->ImageIndex = GetFolderInd(Node, bl);
   Node->SelectedIndex = Node->ImageIndex;
}
//---------------------------------------------------------------------------
int __fastcall TEditMaketForm::GetFolderInd(TTreeNode* Node, bool blocked)
{
   int ind;
   if(blocked)
   {
      ind = Node->Expanded?imOpenBlFolder:imBlFolder;
      ind = Node->Expanded?imOpenBlFolder:imBlFolder;
   }else{
      ind = Node->Expanded?imOpenFldr:imFolder;
      ind = Node->Expanded?imOpenFldr:imFolder;
   }
   return ind;
}
//---------------------------------------------------------------------------
void __fastcall TEditMaketForm::iaNewFolderExecute(TObject *Sender)
{
   bool b=true;
   TTreeNode* TN;

   MaketListTV->OnChange = NULL;
   MaketListTV->OnChanging = NULL;
   if(MaketListTV->Selected) MaketListTVChanging(MaketListTV,MaketListTV->Selected,b);
   if(b){
      MAKET* pMaketGroup = new MAKET(mtFolder);
      strcpy(pMaketGroup->Name,Reconst_smes26_23.c_str());
      pMaketGroup->editing = 1;
      if(MaketListTV->Selected && MaketListTV->Selected->getFirstChild() && !MaketListTV->Selected->getFirstChild()->Data){
        ReadTreeNode(MaketListTV, MaketListTV->Selected);
      }
      //if (((MAKET*)MaketListTV->Selected->Data)->Type == mtFolder)
      //  TN = MaketListTV->Items->AddChildObject(MaketListTV->Selected, pMaketGroup->Name, pMaketGroup);
      //else
        TN = MaketListTV->Items->AddObject(MaketListTV->Selected, pMaketGroup->Name, pMaketGroup);
      TN->ImageIndex = imFolder;
      TN->SelectedIndex = imFolder;
      TN->Selected = true;
      EditRec = true;
      SelType = mtFolder;
      MaketListTVChange(MaketListTV,TN);
      eName->SetFocus();
   }
   MaketListTV->OnChange = MaketListTVChange;
   MaketListTV->OnChanging = MaketListTVChanging;
}
//---------------------------------------------------------------------------


void __fastcall TEditMaketForm::btSignClick(TObject *Sender)
{
if(ElSignatureOpen->Execute()){
   EditRec = true;
}

}
//---------------------------------------------------------------------------

