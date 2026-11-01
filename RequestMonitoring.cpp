//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "OperScanSched.h"
#include "LastSave.h"
#include "RequestMonitoring.h"
#include <Math.hpp>
#include "Reconst.hpp"
#include "unViewTree.h"
#include "unitperm.h"
#include "ManualInput.h"
#include "ManualInputMeter.h"
//GRB ADD 23.10.2020 - popup menu add
#include "SupperMain.h"
#include "Saa_SelectForm.h"
#include "Saa_SelectGroup.h"
#include "Saa_SelectGroupProc.h"
#include "InteriorExRep.h"
#include "InteriorExOpForm.h"
//end add
//---------------------------------------------------------------------------
#include "Monitor.h"
#include "Interior2xDrawTableChart.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TfmRequestMonitoring *fmRequestMonitoring;
//GRB ADD 23.10.2020 - Popup menu add
extern HANDLE UpdateMonitors;
extern TSupperMainForm *SupperMainForm;
//end add
//---------------------------------------------------------------------------
__fastcall TfmRequestMonitoring::TfmRequestMonitoring(TComponent* Owner, AnsiString Name, TAccess a)
        : TMainForm(Owner, Name, a)
{
 vInit (this);
}
void __fastcall TfmRequestMonitoring::vInit(TObject* Sender){
     dtTimeControl->Date=Date()-1;
     FDateControl=dtTimeControl->Date;
     DateTimePicker1->Date=Date();
     MaskEdit1->Text="01:00";
     Panel3->Caption="Данные по группе (точке) учета за " + AnsiString(FDateControl);
     Test=true;
       miManualInp->Delete(miManualInp->Count-1);
     miManIn  = new TMenuItem(mMon);

      miManIn->Caption = "Ввод количества энергии";
      miManIn->OnClick = miManualInp->OnClick;
      miManualInp->Add(miManIn);

      miManMetr  = new TMenuItem(mMon);

      miManMetr->Caption = "Ввод показаний";

      miManMetr->OnClick =miManualInp->OnClick;
      miManualInp->Add(miManMetr);

}
//---------------------------------------------------------------------------
void __fastcall TfmRequestMonitoring::vSave(TObject* Sender)
{
//
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::vRefresh(TObject* Sender)
{

      tvGroupStatus->Items->Clear();
    //  if(rbMaket->Checked||rbCom->Checked||rbCanal->Checked) tvGroupStatus->PopupMenu=NULL;
    //  else   tvGroupStatus->PopupMenu=PopupMenu1;
      ReadNode(tvGroupStatus,NULL,FDateControl,true);
}
//---------------------------------------------------------------------------
bool __fastcall TfmRequestMonitoring::ReadNode(TTreeView* tv,TTreeNode* NodeParent, AnsiString aDateControl,bool IfInsert)// Читает ветку дерева Групп
{

   sGroupStatus* ptrGroupStatus;
   TTreeNode *AddNode;
   char DateControl[20];
   long Par2;
   int TreeType;
   int test1,test2,test3;
   try
   {
         if(rbMaket->Checked||rbCom->Checked||rbCanal->Checked)
         {
          tvGroupStatus->PopupMenu=NULL;
          lvInfo->PopupMenu=NULL;
         }
        else
         {
      //   tvGroupStatus->PopupMenu=PopupMenu1;
         lvInfo->PopupMenu=PopupMenu1;
         }

          dmMain->oqCursor->Params->Clear();
          dmMain->oqCursor->SQL->Text= "begin "+SchemeName+"REQUEST_MONITORING_PG.readnode_p (:par1,:par2,:par3,:par5,:par6,:par7,:par4); end;";

          dmMain->oqCursor->ParamByName("par4")->ParamType = ptOutput;
          dmMain->oqCursor->ParamByName("par4")->DataType = ftCursor;
           if(!NodeParent)
          dmMain->oqCursor->ParamByName("par1")->Clear();
           else
          dmMain->oqCursor->ParamByName("par1")->AsInteger=((sGroupStatus*)NodeParent->Data)->Gid;
          if(rbMaket->Checked||rbCom->Checked) {
             if (NodeParent&&NodeParent->Data)
                    dmMain->oqCursor->ParamByName("par2")->AsInteger =((sGroupStatus*)NodeParent->Data)->Type;
             else
                  dmMain->oqCursor->ParamByName("par2")->AsInteger =0;
           }
           else
           dmMain->oqCursor->ParamByName("par2")->AsInteger =UsCon.Role_Id;
          if(aDateControl.IsEmpty())
           dmMain->oqCursor->ParamByName("par3")->AsDateTime=Now()-1;
          else
           dmMain->oqCursor->ParamByName("par3")->AsDateTime=aDateControl;

        if(RadioButton1->Checked)
             dmMain->oqCursor->ParamByName("par5")->Clear();
        else{
         DateTimePicker1->Time = TDateTime(MaskEdit1->Text.SubString(1,2).ToInt(),MaskEdit1->Text.SubString(4,2).ToInt(),0,0);
         dmMain->oqCursor->ParamByName("par5")->AsDateTime=DateTimePicker1->DateTime;
         }
         if(rbGroup->Checked) TreeType=1;
         if(rbCanal->Checked) TreeType=2;
         if(rbPoints->Checked) TreeType=3;
         if(rbMaket->Checked) TreeType=4;
         if(rbCom->Checked) TreeType=5;
         dmMain->oqCursor->ParamByName("par6")->AsInteger=TreeType;
         dmMain->oqCursor->ParamByName("par7")->AsInteger=IfInsert==true?1:0;
       //  dmMain->oqCursor->ParamByName("par8")->AsInteger=0;//cbNotFull->Checked==true?1:0;
         dmMain->oqCursor->Execute();

        while(!dmMain->oqCursor->Eof){
        ptrGroupStatus = new sGroupStatus;
        ZeroMemory(ptrGroupStatus,sizeof(sGroupStatus));
        ptrGroupStatus->HaveChild=dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
        ptrGroupStatus->Gid=dmMain->oqCursor->FieldByName("gid")->AsInteger;
        ptrGroupStatus->Mid=dmMain->oqCursor->FieldByName("mid")->AsInteger;
        if(!dmMain->oqCursor->FieldByName("name")->IsNull)
          strcpy(ptrGroupStatus->Name,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
        //GRB ADD 19.10.2020 - for rbPoints, rgroups, rmakets changed
        int t_tree = getTypeTree();

        ptrGroupStatus->EIC[0] = 0; 
        switch (t_tree){
        case 1:
            ptrGroupStatus->parentGroup = dmMain->oqCursor->FieldByName("parent")->AsInteger;
            if (!dmMain->oqCursor->FieldByName("idob")->IsNull)
             strcpy(ptrGroupStatus->idob,dmMain->oqCursor->FieldByName("idob")->AsString.c_str());
            if (!dmMain->oqCursor->FieldByName("vcode")->IsNull)
               strcpy(ptrGroupStatus->EIC,dmMain->oqCursor->FieldByName("vcode")->AsString.c_str());
            break;
        case 2:
            ptrGroupStatus->parentGroup = dmMain->oqCursor->FieldByName("parent")->AsInteger;
            if (!dmMain->oqCursor->FieldByName("vcode")->IsNull)
               strcpy(ptrGroupStatus->EIC,dmMain->oqCursor->FieldByName("vcode")->AsString.c_str());
            break;
        case 3:
           ptrGroupStatus->parentGroup = dmMain->oqCursor->FieldByName("parent")->AsInteger;
           if (!dmMain->oqCursor->FieldByName("vcode")->IsNull)
              strcpy(ptrGroupStatus->EIC,dmMain->oqCursor->FieldByName("vcode")->AsString.c_str());
           break;
        case 4:
           if (!dmMain->oqCursor->FieldByName("vcode")->IsNull)
              strcpy(ptrGroupStatus->EIC,dmMain->oqCursor->FieldByName("vcode")->AsString.c_str());
           break;
        default:
        break;
        }
        //END ADD
        //OLD VARIANT
        /*if(!dmMain->oqCursor->FieldByName("short_name")->IsNull)
          strcpy(ptrGroupStatus->Short_name,dmMain->oqCursor->FieldByName("short_name")->AsString.c_str());
          */
         //GRB ADD 19.10.2020 - for rbGroups

        if(!dmMain->oqCursor->FieldByName("Profile")->IsNull)
          strcpy(ptrGroupStatus->Profile,dmMain->oqCursor->FieldByName("Profile")->AsString.c_str());
        if(!dmMain->oqCursor->FieldByName("Halfhour")->IsNull)
          strcpy(ptrGroupStatus->Halfhour,dmMain->oqCursor->FieldByName("Halfhour")->AsString.c_str());
        if(!dmMain->oqCursor->FieldByName("Bill")->IsNull)
          strcpy(ptrGroupStatus->Bill,dmMain->oqCursor->FieldByName("Bill")->AsString.c_str());
        if(!dmMain->oqCursor->FieldByName("Months")->IsNull)
        strcpy(ptrGroupStatus->Months,dmMain->oqCursor->FieldByName("Months")->AsString.c_str());

        ptrGroupStatus->HalfCount=dmMain->oqCursor->FieldByName("halfcount")->AsInteger;
        ptrGroupStatus->BillCount=dmMain->oqCursor->FieldByName("billcount")->AsInteger;
        ptrGroupStatus->MonthsCount=dmMain->oqCursor->FieldByName("monthscount")->AsInteger;
        ptrGroupStatus->Count=dmMain->oqCursor->FieldByName("countpoint")->AsInteger;
        ptrGroupStatus->TestHalfCount=dmMain->oqCursor->FieldByName("ll")->AsInteger;
        if(rbCanal->Checked||(rbCom->Checked)){
        ptrGroupStatus->isgroup=dmMain->oqCursor->FieldByName("is_group")->AsInteger;
        ptrGroupStatus->nblocking=dmMain->oqCursor->FieldByName("blocking")->AsInteger;
        ptrGroupStatus->nparent=dmMain->oqCursor->FieldByName("nparent")->AsInteger;
        }
        if(rbPoints->Checked){
        ptrGroupStatus->isgroup=dmMain->oqCursor->FieldByName("is_group")->AsInteger;
        }
        if(rbMaket->Checked||rbCanal->Checked ) {
         ptrGroupStatus->Type=dmMain->oqCursor->FieldByName("Type")->AsInteger;
        }

         if((rbCom->Checked&&!NodeParent)||(rbCom->Checked&&NodeParent->Data&&((sGroupStatus*)NodeParent->Data)->Type<2)) {
         ptrGroupStatus->Type=dmMain->oqCursor->FieldByName("Type")->AsInteger;
        }
        if((rbCom->Checked&&NodeParent&&((sGroupStatus*)NodeParent->Data)->Type==2)) {
         ptrGroupStatus->Type=5;
        }

        AddNode = tv->Items->AddChildObject(NodeParent,ptrGroupStatus->Name,ptrGroupStatus);

                 AddNode->ImageIndex = TestImage(ptrGroupStatus);
                 AddNode->SelectedIndex = AddNode->ImageIndex ;
                 AddNode->HasChildren = ptrGroupStatus->HaveChild;
            dmMain->oqCursor->Next();
            }
            dmMain->oqCursor->Close();



    oqGetAcc->ParamByName("par1")->AsInteger=UsCon.Role_Id;
    oqGetAcc->Execute();
    if (!miManIn || !miManMetr) vInit(this);
     while(!oqGetAcc->Eof){
      if(oqGetAcc->FieldByName("task_cod")->AsInteger==603) miManIn->Tag=oqGetAcc->FieldByName("nacc")->AsInteger;
      if(oqGetAcc->FieldByName("task_cod")->AsInteger==608) miManMetr->Tag=oqGetAcc->FieldByName("nacc")->AsInteger;
     oqGetAcc->Next();
     }
  }
  catch (Exception &exception)
  {

       Application->ShowException(&exception);
       return false;
  }

  return true;
}
//---------------------------------------------------------------------------
int __fastcall TfmRequestMonitoring::TestImage (sGroupStatus* ptrGroupStatus)
 {
  int  Index;
  int  test1=0;
  int  test2=0;
  int  test3=0;

          if(ptrGroupStatus->TestHalfCount>0&&ptrGroupStatus->TestHalfCount>ptrGroupStatus->HalfCount)
            test1=1;
          if(ptrGroupStatus->Count>0&&ptrGroupStatus->Count>ptrGroupStatus->BillCount)
            test2=1;
          if(ptrGroupStatus->Count>0&&ptrGroupStatus->Count>ptrGroupStatus->MonthsCount)
            test3=1;
if(rbCanal->Checked || rbCom->Checked)
 {
        if  (rbCom->Checked&&(ptrGroupStatus->Type==1||ptrGroupStatus->Type==2)){
         switch (ptrGroupStatus->Type){
         case 1: Index = ((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?28:4;break;
         case 2:  Index = ((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?30:10;break;
         }
        }else{

        bool fBlock = ptrGroupStatus->nblocking;
       //  if(ptrGroupStatus->Mid == 0)
       if(ptrGroupStatus->Type == 5)
          {
            if(ptrGroupStatus->isgroup)
              Index = fBlock?23:(((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?28:4);
             else
              Index = ptrGroupStatus->nparent<0?(fBlock?11:
              (((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?29:9)):
              (fBlock?12:
              (((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?30:10));

          }else{
            if(!fBlock&&((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3)))
              Index = 1;
            else
              Index = 0;
            }
      }
     }
      if(rbGroup->Checked){
         if(ptrGroupStatus->Mid > 0){

          if((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))
            Index = 1;
                  else
            Index = 0;
            }
        if(ptrGroupStatus->Mid == 0){

           if((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))
              Index = 8;
                   else
               Index = 2;
              }
       }
    if(rbPoints->Checked)
    {
        if(ptrGroupStatus->Mid > 0){

          if((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))
            Index = 1;
                  else
            Index = 0;
            }
        if(ptrGroupStatus->Mid == 0)
        {
          if(ptrGroupStatus->isgroup)
              Index =((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?31:26;
          else
              Index =((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?28:4;

        }
     }
    if(rbMaket->Checked){
      //mtMaket=1,mtGroup=2,mtPoint=3,mtAgrGroup=4,mtSubGroup=5,mtFolder=6
     switch (ptrGroupStatus->Type){
         case 1: Index = ((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?32:3;break;
         case 2: Index = ((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?8:2;break;
         case 3: Index = ((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?1:0;break;
         case 4: Index = ((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?8:7;break;
         case 5: Index = ((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?8:2;break;
         case 6: Index = ((CheckBox1->Checked&&test1)||(CheckBox2->Checked&&test2)||(CheckBox3->Checked&&test3))?28:4;break;
         }
    }


     return Index;
  }

//-------------------------------------------------------------------------------------------
void __fastcall TfmRequestMonitoring::tvGroupStatusDeletion(
      TObject *Sender, TTreeNode *Node)
{
     if(Node->Data) delete (sGroupStatus*)Node->Data;
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::tvGroupStatusExpanding(
      TObject *Sender, TTreeNode *Node, bool &AllowExpansion)
{
  if(Node&&!Node->getFirstChild())
     ReadNode(tvGroupStatus,Node,FDateControl,false);
}
//---------------------------------------------------------------------------
void __fastcall TfmRequestMonitoring::InitRegistry(void)
{
 AnsiString RegStr="\\Software\\Grant\\Ascue\\RequestMonitoring";
  int TreeType;
  TRegistry *Reg = new TRegistry;
  try
  {
    Reg->RootKey = HKEY_CURRENT_USER;
  
    if (Reg->OpenKey(RegStr, false))
    {
      TreeType= Reg->ReadInteger("Tree"); // --tree=1 по группам; tree=2 по каналам; tree=3 по точкам;
      CheckBox1->OnClick=NULL;
      CheckBox2->OnClick=NULL;
      CheckBox3->OnClick=NULL;
      CheckBox1->Checked=Reg->ReadInteger("CheckBox1")==1?true:false;
      CheckBox2->Checked=Reg->ReadInteger("CheckBox2")==1?true:false;
      CheckBox3->Checked=Reg->ReadInteger("CheckBox3")==1?true:false;
      Reg->CloseKey();
      rbGroup->OnClick=NULL;
      rbCanal->OnClick=NULL;
      rbPoints->OnClick=NULL;
      rbMaket->OnClick=NULL;
      rbCom->Checked=NULL;

      switch(TreeType)
      {
      case 1: rbGroup->Checked=true;break;
      case 2: rbCanal->Checked=true;break;
      case 3: rbPoints->Checked=true;break;
      case 4: rbMaket->Checked=true;break;
      case 5: rbCom->Checked=true;break;
      }
      rbGroup->OnClick=iaRefreshExecute;
      rbCanal->OnClick=iaRefreshExecute;
      rbPoints->OnClick=iaRefreshExecute;
      rbMaket->OnClick=iaRefreshExecute;
      rbCom->OnClick=iaRefreshExecute;
      CheckBox1->OnClick=CheckBox1Click;
      CheckBox2->OnClick=CheckBox1Click;
      CheckBox3->OnClick=CheckBox1Click;

    }
   
  }__finally{
    delete Reg;
  }
 }
//--------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::FormShow(TObject *Sender)
{
     InitRegistry();
     ReadNode(tvGroupStatus,NULL,FDateControl,true);
     //GRB ADD 22.10.2020 - clicking on columns for repaint
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::tvGroupStatusChange(TObject *Sender,
      TTreeNode *Node)
{
       sGroupStatus* ptrGroupStatus;
       TListItem *LI;
  lvInfo->Items->BeginUpdate();
  lvInfo->Items->Clear();
  if(Node&&Node->HasChildren&&!Node->getFirstChild())
     ReadNode(tvGroupStatus,Node,FDateControl,false);
  TTreeNode *tn = Node->getFirstChild();
  int currTypeTree = getTypeTree();
  int tstEIC = -1;
  bool resTST = false;
  if(!tn)
  {    if (cbNotFull->Checked&&(Node->ImageIndex!=1||Node->ImageIndex!=8||Node->ImageIndex!=28||Node->ImageIndex!=29||Node->ImageIndex!=30||
      Node->ImageIndex!=31||Node->ImageIndex!=32)){lvInfo->Items->EndUpdate();return;}
       ptrGroupStatus = (sGroupStatus*)Node->Data;
       LI = lvInfo->Items->Add();
       LI->ImageIndex = Node->ImageIndex;
       LI->SubItems->Add(ptrGroupStatus->Name);     // 1- Группа/точка
       LI->SubItems->Add((IntToStr(ptrGroupStatus->HalfCount)+"/"+IntToStr(ptrGroupStatus->TestHalfCount)).c_str());  //2 - Гн,количество
       LI->SubItems->Add( AnsiString(ptrGroupStatus->Halfhour).c_str());                              //3 - ГН, дата
       LI->SubItems->Add((IntToStr(ptrGroupStatus->BillCount)+"/"+IntToStr(ptrGroupStatus->Count)).c_str());  //4 - За сутки, кол-во
       LI->SubItems->Add(AnsiString(ptrGroupStatus->Bill).c_str());                                          //5 - За сутки, дата
       LI->SubItems->Add((IntToStr(ptrGroupStatus->MonthsCount)+"/"+IntToStr(ptrGroupStatus->Count)).c_str());  //6 - За месяц, колво
       LI->SubItems->Add(AnsiString(ptrGroupStatus->Months).c_str());                                            //7 - За месяц, дата
       //GRB ADD 20.10.2020 - rewrite to switch
       switch (currTypeTree){
        case 1:
                LI->SubItems->Add(AnsiString(ptrGroupStatus->idob).c_str());
                break;
        case 2:
                LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
                break;
        case 3:
                if(ptrGroupStatus->Mid>0)                                                                                      //8 - id точки Mid ДЛЯ ДЕРЕВА ТОЧЕК
                        LI->SubItems->Add(AnsiString(ptrGroupStatus->Mid).c_str());
                else
                        LI->SubItems->Add(AnsiString("").c_str());
                break;
        case 5:
                LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());                                                             // 8 - или никак
                break;
        default:
                if(ptrGroupStatus->Mid>0)                                                                                      //8 - id точки Mid ДЛЯ ДЕРЕВА ТОЧЕК
                        LI->SubItems->Add(AnsiString(ptrGroupStatus->Mid).c_str());
                else
                        LI->SubItems->Add(AnsiString("").c_str());
                break;
       }
       /*if(ptrGroupStatus->Mid>0)
       LI->SubItems->Add(AnsiString(ptrGroupStatus->Mid).c_str());                                               //8 - id точки Mid ДЛЯ ДЕРЕВА ТОЧЕК
       else
       LI->SubItems->Add(AnsiString("").c_str());
        */

       //22.10.2020 - GRB Убираем каналы 1
       /*if(rbCanal->Checked ||(rbCom->Checked&&ptrGroupStatus->Type>1 )){                                         // 9 - id канала для каналов и ком-портов
        if(ptrGroupStatus->Mid==0)
          LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());                                            // 9 - id канала или так
        else
          LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Parent->Data)->Gid).c_str());                       // 9 - пэрент гида или никак
       }else
        LI->SubItems->Add(AnsiString("").c_str());                                                                // 9 - или никак
        */
      //19.10.2020 - GRB CHANGE
      switch (currTypeTree){
        case 1:
                if(ptrGroupStatus->parentGroup>0)
                        LI->SubItems->Add(AnsiString(ptrGroupStatus->parentGroup).c_str());                          // 10 - id Родителя
                else
                        LI->SubItems->Add(AnsiString("").c_str());                                                   // Либо так
                LI->SubItems->Add(AnsiString(ptrGroupStatus->EIC).c_str());                                        // 11 - код точки - для дерева точек так
                break;
        case 2:
                //GRB ADD: 20.10.2020 - так для конечных точек
                if ((LI->ImageIndex==0)||(LI->ImageIndex==1))                                                         //
                        LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Parent->Data)->Gid).c_str());
                else{

                if(ptrGroupStatus->parentGroup>0)
                        LI->SubItems->Add(AnsiString(ptrGroupStatus->parentGroup).c_str());                          // Либо так если есть
                else
                        LI->SubItems->Add(AnsiString("").c_str());
                }                                                   // Либо так
                LI->SubItems->Add(AnsiString(ptrGroupStatus->EIC).c_str());                                        // 11 - код точки - для дерева точек так
		break;
        case 3:
                if(ptrGroupStatus->parentGroup>0)
                        LI->SubItems->Add(AnsiString(ptrGroupStatus->parentGroup).c_str());                          // Либо так если есть
                else
                        LI->SubItems->Add(AnsiString("").c_str());                                                   // Либо так
                LI->SubItems->Add(AnsiString(ptrGroupStatus->EIC).c_str());                                        // 11 - код точки - для дерева точек так
		break;
        case 4:
                //тут парент
                if ((sGroupStatus*)Node->Parent!=NULL)
                        LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Parent->Data)->Gid).c_str());
                else
                        LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());

                //конец парента
                resTST = TryStrToInt (ptrGroupStatus->EIC,tstEIC);
                if ((resTST)&&(tstEIC>0)) LI->SubItems->Add(AnsiString(ptrGroupStatus->EIC).c_str());
                        else LI->SubItems->Add(AnsiString("").c_str());
                break;

		default:
                        LI->SubItems->Add(AnsiString("").c_str());
                        LI->SubItems->Add(AnsiString("").c_str());
		break;
        case 5:   ///??????
                if ((sGroupStatus*)Node->Parent!=NULL)
                        LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Parent->Data)->Gid).c_str());
                else
                        LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
                LI->SubItems->Add(AnsiString("").c_str());
                break;
	  }
          //END CHANGE
          //OLD VARIANT
         /*if(rbGroup->Checked||rbPoints->Checked)
          LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
         else    LI->SubItems->Add(AnsiString("").c_str()); */
   }
  while(tn)
  {
      if (cbNotFull->Checked&&(tn->ImageIndex!=1&&tn->ImageIndex!=8&&tn->ImageIndex!=28&&tn->ImageIndex!=29
      &&tn->ImageIndex!=30&&tn->ImageIndex!=31&&tn->ImageIndex!=32))
       {
         tn = tn->getNextSibling();
         continue;
         }
       ptrGroupStatus = (sGroupStatus*)tn->Data;
       LI = lvInfo->Items->Add();
       LI->ImageIndex = tn->ImageIndex;
       LI->SubItems->Add(ptrGroupStatus->Name);                      // 1- Группа/точка
       LI->SubItems->Add((IntToStr(ptrGroupStatus->HalfCount)+"/"+IntToStr(ptrGroupStatus->TestHalfCount)).c_str());  //2 - Гн,количество
       LI->SubItems->Add( AnsiString(ptrGroupStatus->Halfhour).c_str());                                              //3 - ГН, дата
       LI->SubItems->Add((IntToStr(ptrGroupStatus->BillCount)+"/"+IntToStr(ptrGroupStatus->Count)).c_str());          //4 - За сутки, кол-во
       LI->SubItems->Add(AnsiString(ptrGroupStatus->Bill).c_str());                                                   //5 - За сутки, дата
       LI->SubItems->Add((IntToStr(ptrGroupStatus->MonthsCount)+"/"+IntToStr(ptrGroupStatus->Count)).c_str());        //6 - За месяц, колво
       LI->SubItems->Add(AnsiString(ptrGroupStatus->Months).c_str());                                                 //7 - За месяц, дата
       //GRB ADD 19.10.2020 - to group - neeaded switch
       switch (currTypeTree){
		   case 1:
			    LI->SubItems->Add(AnsiString(ptrGroupStatus->idob).c_str());
			break;
			case 2:
			    LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
			break;
			case 3:
				if(ptrGroupStatus->Gid>0)                                                                                      //8 - id точки Gid для ГРУПП ДЛЯ ДЕРЕВА ТОЧЕК
					LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
				else
					LI->SubItems->Add(AnsiString("").c_str());
			break;
                        case 4:
                                if(ptrGroupStatus->Gid>0){
                                        if ((LI->ImageIndex==0)||(LI->ImageIndex==1)){
                                                LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Data)->Mid).c_str());
                                                break;
                                        }else
                                                                                      //8 - id точки Gid для ГРУПП ДЛЯ ДЕРЕВА ТОЧЕК
					LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
                                        }
				else
					LI->SubItems->Add(AnsiString("").c_str());
                        break;
                        case 5:
                         //!!!GRB ADD 21.10.2020 Бредоватый и избыточный код тк условия ptrGroupStatus->Mid==0 и (sGroupStatus*)Node->Parent==NULL  из того что видел(?) идут парой, но т.к он рабочий переделывать не будем!!!!
                          if(ptrGroupStatus->Mid==0)                                                                                    // 9 - id канала для каналов и ком-портов
                                LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
                         else{
                         if ((LI->ImageIndex==9)||(LI->ImageIndex==10)||(LI->ImageIndex==11)||(LI->ImageIndex==12)){
                                LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Data)->Gid).c_str());
                                break;
                                }
                         if ((sGroupStatus*)Node->Parent!=NULL)
                           LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
                          else
                        LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Data)->Gid).c_str());
                        }
                        break;

			default:
				if(ptrGroupStatus->Gid>0)                                                                                      //8 - id точки Gid для ГРУПП ДЛЯ ДЕРЕВА ТОЧЕК
					LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
				else
					LI->SubItems->Add(AnsiString("").c_str());
			break;
       }
       //22.10.2020 - Убираем каналы 2
       /*
       if(rbCanal->Checked||(rbCom->Checked&&ptrGroupStatus->Type>1 )){
        if(ptrGroupStatus->Mid==0)                                                                                    // 9 - id канала для каналов и ком-портов
          LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
        else
          if(Node&&Node->Parent&&Node->Parent->Data)
             LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Parent->Data)->Gid).c_str());                        // 9 - id канала или так
          else
            LI->SubItems->Add(AnsiString("").c_str());                                                               // 9 - id канала или никак
       }else
        LI->SubItems->Add(AnsiString("").c_str());                           // 9 - id канала или никак если ты в других деревьях
        */
        //GRB 19.10.2020 GRB CHANGE
		
		switch (currTypeTree){
			case 1:
			if(ptrGroupStatus->parentGroup>0)
				LI->SubItems->Add(AnsiString(ptrGroupStatus->parentGroup).c_str());                          // Либо так если есть
                        else
                                LI->SubItems->Add(AnsiString("").c_str());                                                   // Либо так
			LI->SubItems->Add(AnsiString(ptrGroupStatus->EIC).c_str());                                        // 11 - код точки - для дерева точек так
			break;
			case 2:
                        if ((LI->ImageIndex==0)||(LI->ImageIndex==1)){
							//04.11.2020 - GRB FIX - для дерева каналов весящие на 1м уровне вне папок каналы пишутся по другому
                            if ((ptrGroupStatus->HaveChild == 0)&&(((sGroupStatus*)Node->Data)->parentGroup==1)){
                              LI->SubItems->Add (AnsiString(((sGroupStatus*)Node->Data)->Gid).c_str());
                             break;
                            }
                            //END FIX
							
                            if ((sGroupStatus*)Node->Parent!=NULL){
                                LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Data)->Gid).c_str());
                            }else{
								
			        if(ptrGroupStatus->parentGroup>0)
				        LI->SubItems->Add(AnsiString(ptrGroupStatus->parentGroup).c_str());                          // Либо так если есть
                                else
                                        LI->SubItems->Add(AnsiString("").c_str());                                                    // Либо так
                            }
                        }else{
			if(ptrGroupStatus->parentGroup>0)
				LI->SubItems->Add(AnsiString(ptrGroupStatus->parentGroup).c_str());                          // Либо так если есть
                        else
                                LI->SubItems->Add(AnsiString("").c_str());                                                    // Либо так
                        }
			LI->SubItems->Add(AnsiString(ptrGroupStatus->EIC).c_str());                                          // 11 - код точки - для дерева точек так
			break;
			case 3:
			if(ptrGroupStatus->parentGroup>0)
				LI->SubItems->Add(AnsiString(ptrGroupStatus->parentGroup).c_str());                          // Либо так если есть
                        else
                                LI->SubItems->Add(AnsiString("").c_str());                                                   // Либо так
			LI->SubItems->Add(AnsiString(ptrGroupStatus->EIC).c_str());                                        // 11 - код точки - для дерева точек так
			break;
                        case 4:
                        //тут будет много всякого

                        if ((sGroupStatus*)Node->Parent!=NULL){
                                if ((LI->ImageIndex==0)||(LI->ImageIndex==1)){
                                 LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Data)->Gid).c_str());
                                }else
                                if ((LI->ImageIndex==2)||(LI->ImageIndex==2)||(LI->ImageIndex==8)){
                                LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Data)->Gid).c_str());

                                }else
                                LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Parent->Data)->Gid).c_str());
                        }
                        else

                                LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Data)->Gid).c_str());
                        //конец
                        resTST = TryStrToInt (ptrGroupStatus->EIC,tstEIC);
                        if ((resTST)&&(tstEIC>0)) LI->SubItems->Add(AnsiString(ptrGroupStatus->EIC).c_str());
                        else LI->SubItems->Add(AnsiString("").c_str());
                        break;
                        case 5:
                        if ((sGroupStatus*)Node->Parent!=NULL)
                                LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Parent->Data)->Gid).c_str());
                        else

                                //LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
                                LI->SubItems->Add(AnsiString(((sGroupStatus*)Node->Data)->Gid).c_str());
                        LI->SubItems->Add(AnsiString("").c_str());
                        break;
                        default:
				LI->SubItems->Add(AnsiString("").c_str());
				LI->SubItems->Add(AnsiString("").c_str());
			break;

		}
       //AND CHANGE

          //END CHANGE
         //OLD VARIANT
         /*if(rbGroup->Checked||rbPoints->Checked)
          LI->SubItems->Add(AnsiString(ptrGroupStatus->Gid).c_str());
         else    LI->SubItems->Add(AnsiString("").c_str());*/

       tn = tn->getNextSibling();
  }
  lvInfo->Items->EndUpdate();
  if(lvInfo->Items->Count)
     lvInfo->Selected=lvInfo->Items->Item[0];
    // lvInfo->SetFocus();

}
//---------------------------------------------------------------------------


void __fastcall TfmRequestMonitoring::iaRefreshExecute(TObject *Sender)
{
    Test=true;

     if(Sender)
     if(Sender==(TObject*)rbGroup||Sender==(TObject*)rbCanal||Sender==(TObject*)rbPoints||Sender==(TObject*)rbMaket||
     Sender==(TObject*)rbCom)
      Test=false;

     FDateControl=dtTimeControl->Date;
     if(Sender==(TObject*)rbCanal){
     Panel3->Caption="Данные по каналу (точке) учета за " + AnsiString(FDateControl);
     Panel7->Caption="Контролируемые каналы учета";
     }
     if(Sender==(TObject*)rbGroup){
     Panel3->Caption="Данные по группе (точке) учета за " + AnsiString(FDateControl);
     Panel7->Caption="Контролируемые группы учета";
     }
     if(Sender==(TObject*)rbPoints){
     Panel3->Caption="Данные по точке учета за " + AnsiString(FDateControl);
     Panel7->Caption="Контролируемые точки учета";
     }
     if(Sender==(TObject*)rbMaket){
     Panel3->Caption="Данные по точке учета за " + AnsiString(FDateControl);
     Panel7->Caption="Контролируемые макеты";
     }
     if(Sender==(TObject*)rbCom )
     {
     Panel3->Caption="Данные по СОМ-порту(каналу,точке) учета за " + AnsiString(FDateControl);
     Panel7->Caption="Контролируемые СОМ-порты";
     }

     tvGroupStatus->OnChange=NULL;
     tvGroupStatus->Items->BeginUpdate();

     lvInfo->Items->BeginUpdate();
     tvGroupStatus->Items->Clear();
     lvInfo->Items->Clear();
     ReadNode(tvGroupStatus,NULL,FDateControl,Test);
     lvInfo->Items->EndUpdate();
     tvGroupStatus->Items->EndUpdate();
     tvGroupStatus->OnChange=tvGroupStatusChange;
     if(tvGroupStatus->Items->Count)
              tvGroupStatus->Selected=tvGroupStatus->Items->Item[0];
     if(lvInfo->Items->Count)
       lvInfo->Selected=lvInfo->Items->Item[0];
      // lvInfo->SetFocus();
    Test=true;
}
//---------------------------------------------------------------------------


void __fastcall TfmRequestMonitoring::RadioButton1Click(TObject *Sender)
{
  RadioButton2->Checked=!RadioButton1->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::RadioButton2Click(TObject *Sender)
{
   RadioButton1->Checked=!RadioButton2->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::CheckBox1Click(TObject *Sender)
{

      TTreeNode *Node=NULL;
      tvGroupStatus->Items->BeginUpdate();
      Node=tvGroupStatus->Items->GetFirstNode();
      while(Node){
        if(Node->Data)
        {
           Node->ImageIndex = TestImage((sGroupStatus*)Node->Data);
           Node->SelectedIndex = Node->ImageIndex ;
        }
        Node=Node->GetNext();
      }
    //  tvGroupStatus->Invalidate();
     // tvGroupStatus->Repaint();
      tvGroupStatus->Items->EndUpdate();


  lvInfo->Items->BeginUpdate();

  TTreeNode *SNode=tvGroupStatus->Selected;
  TTreeNode *tn = SNode->getFirstChild();
  if(!tn)
  {
   lvInfo->Items->Item[0]->ImageIndex=SNode->ImageIndex;
  }else{
  int i=0;
   while(tn&&i<lvInfo->Items->Count){
    lvInfo->Items->Item[i]->ImageIndex=tn->ImageIndex;
    tn=tn->getNextSibling();
    i++;
   }
  }
  //lvInfo->Invalidate();
  //lvInfo->Repaint();
  lvInfo->Items->EndUpdate();
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::lvInfoDblClick(TObject *Sender)
 {
    Clipboard()->Clear();
    if( lvInfo->Focused()&&lvInfo->Selected&&
   (!lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7].Trim().IsEmpty()))
    Clipboard()->AsText=lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7];
   }
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::tbCanalClick(TObject *Sender)
{
  if(tvGroupStatus->Focused()&&tvGroupStatus->Selected && tvGroupStatus->Selected->Data&&
  ((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid&&(tvGroupStatus->Selected->ImageIndex==0||
  tvGroupStatus->Selected->ImageIndex==1))
  {
   //ShowChannelList(this, ((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid , CHANN_FOR_POINTS);
    TfmViewTree *f = new TfmViewTree(this, Reconst_smes43_8, ((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid, CHANN_FOR_POINTS);
    f->ShowModal();
    delete f;
  } else{
   if(lvInfo->Focused()&&lvInfo->Selected&&
   (!lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7].Trim().IsEmpty())&&
   (lvInfo->Items->Item[lvInfo->ItemIndex]->ImageIndex==0||lvInfo->Items->Item[lvInfo->ItemIndex]->ImageIndex==1))
   {
    //ShowChannelList(this, ((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid , CHANN_FOR_POINTS);
    TfmViewTree *f = new TfmViewTree(this, Reconst_smes43_8, ((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid, CHANN_FOR_POINTS);
    f->ShowModal();
    delete f;
   }
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::ToolButton3Click(TObject *Sender)
{
   int mid=0;
   int Index=0;
AnsiString Name="";
 if(tvGroupStatus->Focused()&&tvGroupStatus->Selected && tvGroupStatus->Selected->Data&&
 ((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid)
  {
   if (((sGroupStatus*)tvGroupStatus->Selected->Data)->Type==5)
      mid=((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid*100+2;
   else
     mid=((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid*100+3;
   Name=AnsiString(((sGroupStatus*)tvGroupStatus->Selected->Data)->Name);
   Index=tvGroupStatus->Selected->ImageIndex;
  } else{
   if(lvInfo->Focused()&&lvInfo->Selected&&(!lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7].Trim().IsEmpty()))
   {
    if (lvInfo->Items->Item[lvInfo->ItemIndex]->ImageIndex==0||lvInfo->Items->Item[lvInfo->ItemIndex]->ImageIndex==1){
     //GRB REPLACE 18.11.2020
	 AnsiString test_code = lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7];
	 int test_pos = 0;
	 test_pos = test_code.Pos("/"); 
	 if (test_pos!=0){
		 test_code = test_code.SubString(test_pos+1, test_code.Length());
	 }
	mid=StrToInt(test_code)*100+3;
	//END REPLACE	
     //GRB OLD REPLACE 18.11.2020
	/*mid=StrToInt(lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7])*100+3;*/
	}
    else{
	//GRB REPLACE 18.11.2020
	 AnsiString test_code = lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7];
	 int test_pos = 0;
	 test_pos = test_code.Pos("/"); 
	 if (test_pos!=0){
		 test_code = test_code.SubString(test_pos+1, test_code.Length());
	 }
	 mid=StrToInt(test_code)*100+2;
    //GRB OLD REPLACE 18.11.2020    
	//mid=StrToInt(lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7])*100+2;
	}
    Name=lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[0];
    Index=lvInfo->Items->Item[lvInfo->ItemIndex]->ImageIndex;
   }
  }
 if(mid>0&&(Index==0||Index==1||Index==9||Index==11||Index==29||Index==10||Index==12||Index==30)){
  TLastSaveForm * lsF = new TLastSaveForm(this,Name.c_str(),mid,accRead);
  lsF->ShowModal();
  delete lsF;
 }
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::ToolButton4Click(TObject *Sender)
{
AnsiString test_code;
if(rbGroup->Checked||rbPoints->Checked){
    if(tvGroupStatus->Focused()&&tvGroupStatus->Selected && tvGroupStatus->Selected->Data&&
   ((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid)
  {
   TfmOperScanSched::OperScanSchedShow(((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid,
   AnsiString(((sGroupStatus*)tvGroupStatus->Selected->Data)->Name),0,"",0);
   } else{
    if(lvInfo->Focused()&&lvInfo->Selected&&(!lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7].Trim( ).IsEmpty()))
    {
     //GRB REPLACE 17.11.2020
	 /*TfmOperScanSched::OperScanSchedShow(StrToInt(lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7]),
     lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[0],0,"",0);*/
	 //GRB BLOCK REPLACE 17.11.2020  
	 AnsiString test_code = lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7];
	 int test_pos = 0;
	 test_pos = test_code.Pos("/"); 
	 if (test_pos!=0){
		 AnsiString t2 = test_code.SubString(test_pos+1, test_code.Length());
	 TfmOperScanSched::OperScanSchedShow(StrToInt(t2),lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[0],0,"",0);
		 
	 }else
	 TfmOperScanSched::OperScanSchedShow(StrToInt(lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7]),
     lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[0],0,"",0);
    }
	//END REPLACE
   }
  }
 int CMid=0;
 AnsiString CName="";
  if(rbCanal->Checked||(rbCom->Checked&&(((sGroupStatus*)tvGroupStatus->Selected->Data)->Type)>1 ))
  {
    if(tvGroupStatus->Focused()&&tvGroupStatus->Selected && tvGroupStatus->Selected->Data)
    {
     if (((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid)
        {
         //27.04.2020 - ADD FOR TEST - отсутствует Parent - контекст - если не выбирать точку в списке каналов
         bool isNoParent = (((sGroupStatus*)tvGroupStatus->Selected->Parent==NULL)?true:false);
         if (isNoParent){
         TfmOperScanSched::OperScanSchedShow(((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid,
         AnsiString(((sGroupStatus*)tvGroupStatus->Selected->Data)->Name),
         -1,
         "",
         1);
         }else
         //END ADD
         TfmOperScanSched::OperScanSchedShow(((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid,
         AnsiString(((sGroupStatus*)tvGroupStatus->Selected->Data)->Name),
         ((sGroupStatus*)tvGroupStatus->Selected->Parent->Data)->Gid,
         AnsiString(((sGroupStatus*)tvGroupStatus->Selected->Parent->Data)->Name),
         1);
     }else{
        TfmOperScanSched::OperScanSchedShow(0,"",((sGroupStatus*)tvGroupStatus->Selected->Data)->Gid,
         AnsiString(((sGroupStatus*)tvGroupStatus->Selected->Data)->Name),2);
     }
    }
    if(lvInfo->Focused()&&lvInfo->Selected){
     if(!lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7].Trim().IsEmpty())
     {
       if(tvGroupStatus->Selected && tvGroupStatus->Selected->Data)
       {
       //27.04.2020 - ADD FOR TEST - отсутствует Parent если выбрать точку в списке каналов
        bool isNoCParent = (((sGroupStatus*)tvGroupStatus->Selected->Parent==NULL)?true:false);
        if (isNoCParent){
        CMid=(((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid);
        CName=AnsiString(((sGroupStatus*)tvGroupStatus->Selected->Data)->Name);
        }else{
        //END ADD
        CMid=(((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid)?((sGroupStatus*)tvGroupStatus->Selected->Parent->Data)->Gid:
        ((sGroupStatus*)tvGroupStatus->Selected->Data)->Gid;
        CName=(((sGroupStatus*)tvGroupStatus->Selected->Data)->Mid)?
        AnsiString(((sGroupStatus*)tvGroupStatus->Selected->Parent->Data)->Name):AnsiString(((sGroupStatus*)tvGroupStatus->Selected->Data)->Name);
		//GRB ADD 07.05.2021
        if ((rbCanal->Checked)){
        TfmOperScanSched::OperScanSchedShow(0,"",StrToInt(lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[8]), lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[0],2);
        return;
        }
        //end add
        }
      } //scobochki dobavil posle else

     TfmOperScanSched::OperScanSchedShow(StrToInt(lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7]),
     lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[0],
     CMid,
     CName,
     1);
      }else{
     TfmOperScanSched::OperScanSchedShow(0,"",StrToInt(lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[8]),
     lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[0],2);
     }
    }
  }

}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::iaCloseExecute(TObject *Sender)
{
  WriteReg();
  Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmRequestMonitoring::WriteReg(void)
{
  AnsiString RegStr="\\Software\\Grant\\Ascue\\RequestMonitoring";
  int TreeType;
  TRegistry *Reg = new TRegistry;
  try{
    Reg->RootKey = HKEY_CURRENT_USER;

      if (Reg->OpenKey(RegStr, true)){       // --tree=1 по группам; tree=2 по каналам; tree=3 по точкам;
        if( rbGroup->Checked)TreeType=1;
        if( rbCanal->Checked)TreeType=2;
        if( rbPoints->Checked)TreeType=3;
        if( rbMaket->Checked)TreeType=4;
        if( rbCom->Checked)TreeType=5;
        Reg->WriteInteger("Tree",TreeType);
        Reg->WriteInteger("CheckBox1",(CheckBox1->Checked?1:0));
        Reg->WriteInteger("CheckBox2",(CheckBox2->Checked?1:0));
        Reg->WriteInteger("CheckBox3",(CheckBox3->Checked?1:0));
        Reg->CloseKey();
      }

  }__finally{
    delete Reg;
  }
}
//----------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::FormCloseQuery(TObject *Sender,
      bool &CanClose)
{
 WriteReg();  
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::aAutoRefreshExecute(TObject *Sender)
{
  Timer1->Enabled = sbAutoRefresh->Down;
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::Timer1RefreshMonitor(TObject *Sender)
{
  Timer1->Enabled=false;
  iaRefreshExecute(NULL);
  Timer1->Enabled=true;
}
//---------------------------------------------------------------------------


void __fastcall TfmRequestMonitoring::miManualInpClick(TObject *Sender)
{
TAccess acc;
  int gid;
  TMainForm*Child;
  int hh;
  /*if (GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0 )*/ {



  if(lvInfo->Focused()&&lvInfo->Selected) {
     //GRB REPLACE 18.11.2020
	 AnsiString test_code = lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7];
	 int test_pos = 0;
	 test_pos = test_code.Pos("/"); 
	 if (test_pos!=0){
		 AnsiString t2 = test_code.SubString(test_pos+1, test_code.Length());
		 gid = StrToInt(t2);
	 }else{
		gid= StrToInt(lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7]); 		 
	 }
		 //END REPLACE
		//OLD REPLACE
	   //gid= StrToInt(lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[8]);
  }

  if (rbGroup->Checked)  hh=2;
  if (rbPoints->Checked ) hh=1;
  //GRB ADD FIX - Исправляем баг когда находимся в дереве групп и стоит на синей или красной точке 23.11.2020 в правой панели и по ней строим ручной ввод
  if (rbGroup->Checked){
	if(lvInfo->Focused()&&lvInfo->Selected&&(!lvInfo->Items->Item[lvInfo->ItemIndex]->SubItems->Strings[7].Trim().IsEmpty()))
   {
    if (lvInfo->Items->Item[lvInfo->ItemIndex]->ImageIndex==0||lvInfo->Items->Item[lvInfo->ItemIndex]->ImageIndex==1){
		hh=1;
	}
   }	
  }
  //END ADD 
  if(Sender==miManIn){
     acc = miManIn->Tag==1?accWrite:(miManIn->Tag==0?accRead:accDenied);

        Child= new TfmManualInput(Application,/*Name*/ miManIn->Caption, gid,hh,acc);
        Child->TaskId=603;
  }


  if(Sender==miManMetr){
      acc = miManMetr->Tag==1?accWrite:(miManMetr->Tag==0?accRead:accDenied);
      Child= new TfmManualInputMeter(Application,/*Name*/ miManMetr->Caption, gid,hh,acc);
     Child->TaskId=608;
  }
  
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmRequestMonitoring::cbNotFullClick(TObject *Sender)
{
  // iaRefreshExecute(Sender);
  if(tvGroupStatus->Selected&& tvGroupStatus->Selected->Data)
      tvGroupStatusChange(Sender, tvGroupStatus->Selected);
}
//---------------------------------------------------------------------------
//Экспорт содержимого TListView формы в csv-файл, из которого Excel может сгенерить .xls

void __fastcall TfmRequestMonitoring::MnExcelItemClick(TObject *Sender)
{
        SaveDialog1->FileName = Panel3->Caption+ "_от_"+Date().CurrentDate();
        if (SaveDialog1->Execute()){
                //GRB FIX 09.04.2019 - заменили разделитель колонок в csv-файле с запятой, на более естественный для Excel'я точку с запятой - и ниже по тексту файла меняем ;  на . в названиях колонок и данных 
                AnsiString delim = ";";
                AnsiString rowData,str="";
                TStringList* sList=new TStringList;
                AnsiString fileName = SaveDialog1->FileName;
                //Вычитываем заголовки TListView первой строкой
                for(int i=1;i<lvInfo->Columns->Count;i++){
                        rowData = lvInfo->Columns->Items[i]->Caption;
                        //экранируем(меняем на точки) точку с запятой(разделитель) (GRB FIX от 09.04.2019 - раньше была запятая), чтобы не появлялись фейковые столбцы
                        rowData = StringReplace(rowData,";",".",TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);
                        str = str + rowData;
                        if (i!=lvInfo->Columns->Count-1) str = str+delim;
                }
                sList->Add (str);
                str = "";
                rowData ="";
                //Вычитываем значения из TListView
                for (int i = 0; i < lvInfo->Items->Count; i++){
                        //for (int j = 0; j < lvInfo->Items->Item[i]->SubItems->Count-1; j++){
                        for (int j = 0; j < lvInfo->Items->Item[i]->SubItems->Count; j++){
                               rowData =  lvInfo->Items->Item[i]->SubItems->Strings[j];
                               //экранируем(меняем на точки) точки с запятой(разделитель) (GRB FIX от 09.04.2019 - раньше была запятая), чтобы не появлялись фейковые столбцы
                               rowData =  StringReplace(rowData,";",".",TReplaceFlags()<<rfReplaceAll<<rfIgnoreCase);
                               str = str + rowData;
                               if (j != lvInfo->Items->Item[i]->SubItems->Count-1) str = str + delim;
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
int __fastcall TfmRequestMonitoring::getTypeTree(){
  int ret = -1;
  if(rbGroup->Checked){
	  ret=1;
	  return ret;
  }
  if(rbCanal->Checked) {
	  ret=2;
	  return ret;
  }
  if(rbPoints->Checked){
	  ret=3;
	  return ret;
  }
  if(rbMaket->Checked){
	  ret=4;
	  return ret;
  }
  if(rbCom->Checked){
	  ret=5;
	  return ret;
  }
  return ret;
}
//GRB ADD 23.10.2020     void __fastcall createSubMenu_F(TMenuItem*),   void __fastcall MonSelectClick(TObject *Sender);, iaMonExecute(TObject *Sender), void __fastcall PopupMenu1Popup(TObject *Sender) from EdiFiders.h
//---------------------------------------------------------------------------


void __fastcall TfmRequestMonitoring::PopupMenu1Popup(TObject *Sender)
{
  PopupMenu1->Items->Items[8]->Clear();
 if(tvGroupStatus->Selected&&tvGroupStatus->Selected->Data){

      if (rbPoints->Checked)
      {
           /*PopupMenu1->Items->Items[8]->Visible = false;
           PopupMenu1->Items->Items[8]->Enabled = false;
           return;*/
        PopupMenu1->Items->Items[8]->Visible = true;
        PopupMenu1->Items->Items[8]->Enabled = true;

         FORMS *fms;
         fms=(FORMS*)mMon->Tag ;
         if(!fms) fms = new FORMS;
         ZeroMemory(fms, sizeof(FORMS));
         if(tvGroupStatus->Selected&&tvGroupStatus->Selected->Data)
          fms->gid = ((sGroupStatus*)tvGroupStatus->Selected->Data)->Gid;
          fms->tmplCode=0;
          mMon->Tag = (int)fms;
          PopupMenu1->Items->Items[8]->OnClick = MonSelectClick;
          createSubMenu_F(mMon);

          return;

       }
       //GRB ADD 26.10.2020
       if (rbGroup->Checked)
       {
           PopupMenu1->Items->Items[8]->Visible = true;
           PopupMenu1->Items->Items[8]->Enabled = true;

           FORMS *fms;
           fms=(FORMS*)mMon->Tag ;
           if(!fms) fms = new FORMS;
           ZeroMemory(fms, sizeof(FORMS));
           if(tvGroupStatus->Selected&&tvGroupStatus->Selected->Data)
             fms->gid = ((sGroupStatus*)tvGroupStatus->Selected->Data)->Gid;
           fms->tmplCode=0;
           mMon->Tag = (int)fms;
           createSubMenu_G(mMon);
           PopupMenu1->Items->Items[8]->OnClick = mMonClick;
           return;
       }else{
           PopupMenu1->Items->Items[8]->Visible = false;
           PopupMenu1->Items->Items[8]->Enabled = false;
       }

 }
}


//---------------------------------------------------------------------------
void __fastcall TfmRequestMonitoring::createSubMenu_F(TMenuItem*mi)
{

    FORMS *n, *fms = (FORMS*)mi->Tag;
    TMenuItem*chMi;

    try
    {
        long cnt = mi->Count;

         oqCursor2->Params->Clear();
         oqCursor2->SQL->Text="begin "+SchemeName+"editfeeders_pg.get_SubMenu_p(:par1,:par2,:par3,:par4); end;";
         oqCursor2->ParamByName("par4")->ParamType = ptOutput;
         oqCursor2->ParamByName("par4")->DataType = ftCursor;
         if(!fms || fms->fid==0)
         oqCursor2->ParamByName("par1")->AsInteger=0;
         else
         oqCursor2->ParamByName("par1")->AsInteger=fms->fid;
         oqCursor2->ParamByName("par2")->AsInteger= StrToInt(UserRol.Monitor);
         oqCursor2->ParamByName("par3")->DataType=ftInteger;
         oqCursor2->ParamByName("par3")->ParamType=ptInputOutput;
         oqCursor2->ParamByName("par3")->AsInteger=fms->gid;
         oqCursor2->Open();

        while(!oqCursor2->Eof){
            n = new FORMS;
            ZeroMemory(n, sizeof(FORMS));
            if(!oqCursor2->FieldByName("fid")->IsNull)
            n->fid=oqCursor2->FieldByName("fid")->AsInteger;
         if(!oqCursor2->FieldByName("codetemplate")->IsNull)
            n->tmplCode=oqCursor2->FieldByName("codetemplate")->AsInteger;
         else  n->tmplCode=0;
         if(!oqCursor2->FieldByName("nameform")->IsNull)
            strcpy(n->name,oqCursor2->FieldByName("nameform")->AsString.c_str());
         if(!oqCursor2->FieldByName("commentform")->IsNull)
            strcpy(n->comment,oqCursor2->FieldByName("commentform")->AsString.c_str());
         if(!oqCursor2->FieldByName("enablecontrols")->IsNull)
            strcpy(n->enablecontrols,oqCursor2->FieldByName("enablecontrols")->AsString.c_str());
         if(!oqCursor2->FieldByName("stepprofile")->IsNull)
            n->step=oqCursor2->FieldByName("stepprofile")->AsInteger;
         if(!oqCursor2->FieldByName("namealert")->IsNull)
            strcpy(n->alertname,oqCursor2->FieldByName("namealert")->AsString.c_str());
         if(!oqCursor2->FieldByName("vprocname")->IsNull)
            strcpy(n->procname,oqCursor2->FieldByName("vprocname")->AsString.c_str());
         if(!oqCursor2->ParamByName("par3")->IsNull)
            n->gid=oqCursor2->ParamByName("par3")->AsInteger;
        //  n->gid=fms->gid;
         if(!oqCursor2->FieldByName("mid")->IsNull)
            n->startmid=oqCursor2->FieldByName("mid")->AsInteger;

                chMi = new TMenuItem(mi);
                chMi->Caption = n->name;
                chMi->Tag = (long)n;
                chMi->OnClick = mi->OnClick;
                if(n->tmplCode==0)
                    chMi->Insert(0,new TMenuItem(mi));
                mi->Insert(0,chMi);
           oqCursor2->Next();
          }
          oqCursor2->Close();
        for(long i=0; i<cnt; i++){
            n = (FORMS*)mi->Items[mi->Count-1]->Tag;
            if(n)
                delete n;
            mi->Delete(mi->Count-1);
        }
        if(mi->Count==0){
            mi->Add(new TMenuItem(mi));
        }


          for (int i=0;i<mi->Count;i++){
           if(((FORMS*)mi->Items[i]->Tag)&&((FORMS*)mi->Items[i]->Tag)->tmplCode==0)
                    createSubMenu_F(mi->Items[i]);
          }

    }catch(Exception&e){
        throw Exception(e);
    }
}

//---------------------------------------------------------------------------
// Add by KSS (04.06.2004)
void __fastcall TfmRequestMonitoring::MonSelectClick(TObject *Sender)
{
    TMenuItem*mi=(TMenuItem*)Sender;
    FORMS*fms =(FORMS*)mi->Tag;
    if(fms && fms->tmplCode!=0)
    {
        ManForm = new TManForm(SupperMainForm);
        ManForm->OnProgressBarStepBy=SupperMainForm->ProgressBarStepBy;
    	TBaseMonitorForm *p=new TBaseMonitorForm(ManForm->PageCtrlSplt,ManForm->OnProgressBarStepBy);
	    ManForm->PageCtrlSplt->AddChild(p,alTop);
        TFormDescr* sfd=NULL;
        TForm* fmSelectGroupReportUniv=NULL;
        if(!ManForm->PageCtrlSplt->CurrentForm)
	        return;
        sfd = new TFormDescr;
	    if(ManForm->PageCtrlSplt->CurrentForm->GetFormDescr())
    	    *sfd=*(ManForm->PageCtrlSplt->CurrentForm->GetFormDescr());
        // Подготовка описания формы
        sfd->IdFormTree = fms->fid;
        sfd->CodeTemplate = fms->tmplCode;
        sfd->IdGroup = ((sGroupStatus*)tvGroupStatus->Selected->Data)->Gid;
        sfd->SummGroup = true;
        sfd->NameForm = fms->name;
        sfd->CommentForm = fms->comment;
        sfd->NameAlert = fms->alertname;
        sfd->NameGroup = ((sGroupStatus*)tvGroupStatus->Selected->Data)->Name;
        sfd->ShortNameGroup = ((sGroupStatus*)tvGroupStatus->Selected->Data)->Name;
        sfd->IsPoints=true;
		//17.11.2020 GRB CHANGE 
		fixPanelOnTree fix = getGidLName();
		if (fix.was_result){
			sfd->IdGroup = fix.Gid;
			sfd->NameGroup = fix.NameGroup;
			sfd->ShortNameGroup = fix.ShortName;
		}
		//end ADD	

        if(sfd->ShortNameGroup.Length()==0)
            sfd->ShortNameGroup = sfd->NameGroup;
        switch(fms->step){
        case 1:
            sfd->StepProfile = TFormDescr::stpMonth;
            break;
        case 2:
            sfd->StepProfile = TFormDescr::stpDay;
            break;
        case 3:
            sfd->StepProfile = TFormDescr::stpHour;
            break;
        case 4:
            sfd->StepProfile = TFormDescr::stpMinute;
            break;
        default:
            sfd->StepProfile = TFormDescr::stpNone;
        }

		sfd->EnableControls.Clear();
		char*ch = &fms->enablecontrols[0];
        if(*ch=='1')
          sfd->EnableControls<<TFormDescr::ctrlGroup;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlMonth;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlDay;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlHour;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlMinute;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlCalendar;
        ch++;
        if(*ch=='1')
            {sfd->EnableControls<<TFormDescr::ctrlPoint;sfd->startmid = fms->startmid;}
        ch++;
        if(*ch=='1')
          {sfd->indbird = true; sfd->bird = 0;}

        // Конец подготовки
        fmSelectReportForm = new TfmSelectReportForm(this,fms->fid,sfd);

        if(IsCommonRepForm(sfd->CodeTemplate))
            fmSelectGroupReportUniv = new TfmSelectGroupReportProc(this,sfd);
        else
            fmSelectGroupReportUniv = new TfmSelectGroupReport(this,sfd);
        if(EXCEL_F == sfd->CodeTemplate)
            fmSelectGroupReportUniv->ModalResult = mrOk;
        else
        {
            bool prContWork = TRUE;
            if(sfd->CodeTemplate == EXCEL_REP_F || sfd->CodeTemplate == EXCEL_OP_FORM)
            {
                TManForm *FFF = dynamic_cast<TManForm*>(SupperMainForm->ActiveMDIChild);
                if(!( FFF && FFF->PageCtrlSplt->listMonitorForms->Count<2 ) )
                {
                    Application->MessageBox(Reconst_smes20_52.c_str(),
                        Application->Title.c_str(),MB_OK|MB_ICONSTOP);
                    fmSelectGroupReportUniv->ModalResult = mrCancel;
                    prContWork = FALSE;
                }
            }
            if( prContWork )
                fmSelectGroupReportUniv->ModalResult = mrOk;
        }
        if (fmSelectGroupReportUniv->ModalResult == mrOk)
        {
            //fmSelectReportForm->fd->CodeTemplate=1;
            // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
            while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
            {
                Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
                Sleep(0);// переключить управление на другой поток, коьт занял CS
            }
            // add by KSS
            PostMessage(ManForm->PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)sfd);
        }
        delete fmSelectGroupReportUniv;
        delete fmSelectReportForm;
        Cursor = crDefault;
        }
   // }else
   //  ; //if(mi==mMon&&mi->Count==1)  createSubMenu(mi);

}
//---------------------------------------------------------------------------

// END Add by KSS (04.06.2004)
//---------------------------------------------------------------------------
void __fastcall TfmRequestMonitoring::iaMonExecute(TObject *Sender)
{
    TManForm*pMF=NULL;
    TBaseMonitorForm *p=NULL;
    HCURSOR hCursor;
    long Fid=-1;;
    TFormDescr* sfd=NULL;
    TForm* fmSelectGroupReportUniv=NULL;

    try{
        pMF = new TManForm(SupperMainForm);
        pMF->OnProgressBarStepBy = SupperMainForm->ProgressBarStepBy;
	    p = new TBaseMonitorForm(pMF->PageCtrlSplt,pMF->OnProgressBarStepBy);
    	pMF->PageCtrlSplt->AddChild(p,alTop);

    	if(!pMF->PageCtrlSplt->CurrentForm)
	    	throw Exception(Reconst_smes20_50);

        hCursor=::SetCursor(LoadCursor(NULL,IDC_WAIT));

    	sfd = new TFormDescr;
        sfd->IsPoints = true;
        //old variant 23.10.2020
        //sfd->IdGroup = ((POINTSDIV*)TreeView1->Selected->Data)->Mid;
        //GRB CHANGE 23.10.2020
        sfd->IdGroup = ((sGroupStatus*)tvGroupStatus->Selected->Data)->Gid;
        sfd->SummGroup = true;
        //sfd->NameGroup = ((POINTSDIV*)TreeView1->Selected->Data)->Name;
        sfd->NameGroup = ((sGroupStatus*)tvGroupStatus->Selected->Data)->Name;
        //sfd->ShortNameGroup = ((POINTSDIV*)TreeView1->Selected->Data)->Short_Name;
        sfd->ShortNameGroup = ((sGroupStatus*)tvGroupStatus->Selected->Data)->Name;

        fmSelectReportForm = new TfmSelectReportForm(this,Fid,sfd);

        ::SetCursor(hCursor);

        while(fmSelectReportForm->ShowModal()!=mrOk ||
            !sfd->EnableControls.Contains(TFormDescr::ctrlPoint))
        {
            if(fmSelectReportForm->ModalResult != mrOk)
                break;
            if(!sfd->EnableControls.Contains(TFormDescr::ctrlPoint))
                ShowMessage(Reconst_smes20_51);
        }
        if(fmSelectReportForm->ModalResult == mrOk)
        {
            if (IsCommonRepForm( sfd->CodeTemplate ) )
                fmSelectGroupReportUniv = new TfmSelectGroupReportProc(this,sfd);
            else
                fmSelectGroupReportUniv = new TfmSelectGroupReport(this,sfd);

            if( EXCEL_F == sfd->CodeTemplate )
                fmSelectGroupReportUniv->ModalResult = mrOk;
            else
            {
                bool prContWork = TRUE;
                if(sfd->CodeTemplate == EXCEL_REP_F || sfd->CodeTemplate == EXCEL_OP_FORM)
                {
                    TManForm *FFF = dynamic_cast<TManForm*>(SupperMainForm->ActiveMDIChild);
                    if(!( FFF && FFF->PageCtrlSplt->listMonitorForms->Count<2 ) )
                    {
                        Application->MessageBox(Reconst_smes20_52.c_str(),
                            Application->Title.c_str(),MB_OK|MB_ICONSTOP);
                        fmSelectGroupReportUniv->ModalResult = mrCancel;
                        prContWork = FALSE;
                    }
                }
                if( prContWork )
                    //fmSelectGroupReportUniv->ShowModal();
                    fmSelectGroupReportUniv->ModalResult = mrOk;
            }
            if (fmSelectGroupReportUniv->ModalResult == mrOk)
            {
        	    //fmSelectReportForm->fd->CodeTemplate=1;
                // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
                while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
                {
                    Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
                    Sleep(0);// переключить управление на другой поток, коьт занял CS
                }
                // add by KSS
                PostMessage(pMF->PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)fmSelectReportForm->fd);
            }else{
                // Повтор данного кода выбора формы
            }
        }
        else
        {
            if(sfd->CodeTemplate==EXCEL_REP_F)
            {
                TBaseMonitorForm* MF = (TBaseMonitorForm*)pMF->PageCtrlSplt->CurrentForm;
                TInteriorExRep * TIFx = (TInteriorExRep*) MF->Interior;
                TIFx->DoVerb();
            }else if(sfd->CodeTemplate==EXCEL_OP_FORM)
            {
                TBaseMonitorForm* MF = (TBaseMonitorForm*)pMF->PageCtrlSplt->CurrentForm;
                TInteriorExOpForm * TIFx = (TInteriorExOpForm*) MF->Interior;
                TIFx->DoVerb();
            }else{
                pMF->Close();
            }
        }
    }catch(Exception&e){
        if(fmSelectGroupReportUniv)
            delete fmSelectGroupReportUniv;
        if(fmSelectReportForm)
            delete fmSelectReportForm;
        ::SetCursor(hCursor);
        throw Exception(e);
    }
    delete fmSelectGroupReportUniv;
    delete fmSelectReportForm;
}

//GRB ADD 26.10.2020
//---------------------------------------------------------------------------
void __fastcall TfmRequestMonitoring::createSubMenu_G(TMenuItem*mi)
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
             dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editgroups_pg.SubMenu_p(:par1,:par2,:par3,:par4); end;";
             dmMain->oqCursor->ParamByName("par4")->ParamType = ptOutput;
             dmMain->oqCursor->ParamByName("par4")->DataType = ftCursor;
             if(!fms || fms->fid==0)
                dmMain->oqCursor->ParamByName("par1")->Clear();
             else dmMain->oqCursor->ParamByName("par1")->AsInteger=fms->fid;
             dmMain->oqCursor->ParamByName("par2")->AsInteger=m_role;
             dmMain->oqCursor->ParamByName("par3")->AsInteger=fms->gid;
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

          for (int i=0;i<mi->Count;i++){
           if(((FORMS*)mi->Items[i]->Tag)&&((FORMS*)mi->Items[i]->Tag)->tmplCode==0)
                    createSubMenu_G(mi->Items[i]);
          }
          
    }catch(Exception&e){
        throw Exception(e);
    }
}
// END Add by KSS (22.06.2004)
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// Add by KSS (22.06.2004)
void __fastcall TfmRequestMonitoring::mMonClick(TObject *Sender)
{
 /*   TMenuItem*mi;
    mi = dynamic_cast<TMenuItem*>(Sender);
    FORMS*fms = (FORMS*)mi->Tag;
    if(mi==mMon){
        if(!fms) fms = new FORMS;
        ZeroMemory(fms, sizeof(FORMS));
        if(tvGroup->Selected&&tvGroup->Selected->Data)
          fms->gid = ((POINTSDIV*)tvGroup->Selected->Data)->Id;
        mi->Tag = (int)fms;
    } */
    TMenuItem*mi= (TMenuItem*)Sender ;
    FORMS*fms = (FORMS*)mi->Tag;
    if(fms && fms->tmplCode!=0)
    {
        ManForm = new TManForm(SupperMainForm);
        ManForm->OnProgressBarStepBy=SupperMainForm->ProgressBarStepBy;
    	TBaseMonitorForm *p=new TBaseMonitorForm(ManForm->PageCtrlSplt,ManForm->OnProgressBarStepBy);
	    ManForm->PageCtrlSplt->AddChild(p,alTop);
        TFormDescr* sfd=NULL;
        TForm* fmSelectGroupReportUniv=NULL;
        if(!ManForm->PageCtrlSplt->CurrentForm)
	        return;
        sfd = new TFormDescr;
	    if(ManForm->PageCtrlSplt->CurrentForm->GetFormDescr())
    	    *sfd=*(ManForm->PageCtrlSplt->CurrentForm->GetFormDescr());
        // Подготовка описания формы
        sfd->IdFormTree = fms->fid;
        sfd->CodeTemplate = fms->tmplCode;
        sfd->IdGroup = fms->gid;
        sfd->IsPoints = false;
        sfd->SummGroup = "Сумма";//????? чо тулить((POINTSDIV*)tvGroup->Selected->Data)->nSum;
        sfd->NameForm = fms->name;
        sfd->CommentForm = fms->comment;
        sfd->NameAlert = fms->alertname;
        sfd->NameGroup = ((sGroupStatus*)tvGroupStatus->Selected->Data)->Name;
        sfd->ShortNameGroup = ((sGroupStatus*)tvGroupStatus->Selected->Data)->Name;
		//GRB ADD 17.11.2020
		fixPanelOnTree fix = getGidLName();
		if (fix.was_result){
			sfd->IdGroup = fix.Gid;
			sfd->NameGroup = fix.NameGroup;
			sfd->ShortNameGroup = fix.ShortName;
		}
		//end ADD	
		//END ADD
        if(sfd->ShortNameGroup.Length()==0)
            sfd->ShortNameGroup = sfd->NameGroup;
        switch(fms->step){
        case 1:
            sfd->StepProfile = TFormDescr::stpMonth;
            break;
        case 2:
            sfd->StepProfile = TFormDescr::stpDay;
            break;
        case 3:
            sfd->StepProfile = TFormDescr::stpHour;
            break;
        case 4:
            sfd->StepProfile = TFormDescr::stpMinute;
            break;
        default:
            sfd->StepProfile = TFormDescr::stpNone;
        }

		sfd->EnableControls.Clear();
		char*ch = &fms->enablecontrols[0];
        if(*ch=='1')
          sfd->EnableControls<<TFormDescr::ctrlGroup;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlMonth;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlDay;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlHour;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlMinute;
        ch++;
        if(*ch=='1')
		    sfd->EnableControls<<TFormDescr::ctrlCalendar;
        ch++;
        if(*ch=='1')
            sfd->EnableControls<<TFormDescr::ctrlPoint;
        ch++;
        if(*ch=='1')
          {sfd->indbird = true; sfd->bird = 0; sfd->startmid=0;}

        // Конец подготовки
        fmSelectReportForm = new TfmSelectReportForm(this,fms->fid,sfd);

        if(IsCommonRepForm(sfd->CodeTemplate))
            fmSelectGroupReportUniv = new TfmSelectGroupReportProc(this,sfd);
        else
            fmSelectGroupReportUniv = new TfmSelectGroupReport(this,sfd);
        if(EXCEL_F == sfd->CodeTemplate)
            fmSelectGroupReportUniv->ModalResult = mrOk;
        else
        {
            bool prContWork = TRUE;
            if(sfd->CodeTemplate == EXCEL_REP_F || sfd->CodeTemplate == EXCEL_OP_FORM)
            {
                TManForm *FFF = dynamic_cast<TManForm*>(SupperMainForm->ActiveMDIChild);
                if(!( FFF && FFF->PageCtrlSplt->listMonitorForms->Count<2 ) )
                {
                    Application->MessageBox(Reconst_smes22_19.c_str(),
                        Application->Title.c_str(),MB_OK|MB_ICONSTOP);
                    fmSelectGroupReportUniv->ModalResult = mrCancel;
                    prContWork = FALSE;
                }
            }
            if( prContWork )
                fmSelectGroupReportUniv->ModalResult = mrOk;
        }
        if (fmSelectGroupReportUniv->ModalResult == mrOk)
        {
            //fmSelectReportForm->fd->CodeTemplate=1;
            // перед любым обновлением мониторов необходимо инициализировать кр. секцию UpdateMonitors
            while(WaitForSingleObject(UpdateMonitors,0)!=WAIT_OBJECT_0)
            {
                Application->ProcessMessages();// если не удалось иниц-ть. CS то обновить экранные формы...
                Sleep(0);// переключить управление на другой поток, коьт занял CS
            }
            // add by KSS
            PostMessage(ManForm->PageCtrlSplt->CurrentForm->Handle,WM_REFRESHFORM,0,(LPARAM)sfd);
        }
        delete fmSelectGroupReportUniv;
        delete fmSelectReportForm;
        Cursor = crDefault;
        }
  //  }else{
  //      createSubMenu_G(mi);
  //  }
}
//---------------------------------------------------------------------------
//END ADD
//---------------------------------------------------------------------------
//17.11.2020 GRB ADD 
fixPanelOnTree __fastcall TfmRequestMonitoring::getGidLName(){
	fixPanelOnTree ret;
	ret.Gid = -1;
	ret.NameGroup = "";
	ret.ShortName = "";
	ret.was_result = false;
	for (int i = 0; i <  lvInfo->Items->Count; i++){
		if (lvInfo->Items->Item[i]->Selected){
			ret.was_result = true;
			TListItem* tstGid = lvInfo->Items->Item[i];
			for (int j = 0; j < lvInfo->Items->Item[i]->SubItems->Count; j++){
				AnsiString tstStr = lvInfo->Items->Item[i]->SubItems->Strings[j];
				if (j==0){
				ret.NameGroup = tstStr;
				ret.ShortName = tstStr;										
				}
				if (j==7){
					ret.Gid = atol (tstStr.c_str()); //ид группы из таблицы справа 
				}
				
			}
			break;
		}
	}
	return ret;
}
//END ADD		

//---------------------------------------------------------------------------







