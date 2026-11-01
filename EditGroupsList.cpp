//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "EditGroupsList.h"
#include "SupperMain.h"
#include "Saa_SelectForm.h"
#include "Saa_SelectGroup.h"
#include "Saa_SelectGroupProc.h"
#include "Monitor.h"
#include "Reconst.hpp"
#include "unitperm.h"
#include "ManualInput.h"
#include "ManualInputMeter.h"
#define  MAXTABLESIZE 256
#define min(a, b)  (((a) < (b)) ? (a) : (b))
//---------------------------------------------------------------------------
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
extern HANDLE UpdateMonitors;
UINT CF_GROUPS_TREENODE; // описание формата для буфера обмена

//---------------------------------------------------------------------------
__fastcall TFormEditGropsList::TFormEditGropsList(TComponent* Owner, AnsiString Name, TAccess a)
	: TMainForm(Owner, Name, a)
{
 GrbInit();
}
//---------------------------------------------------------------------------

__fastcall TFormEditGropsList::~TFormEditGropsList()
{
   if(Clipboard()->HasFormat(CF_GROUPS_TREENODE))
      Clipboard()->Clear();
}
//---------------------------------------------------------------------------


void __fastcall TFormEditGropsList::FormShow(TObject *Sender)
{
   if(ReadNode(tvGroup,NULL)&&ReadNode(tvPoint,NULL)){
      if(tvGroup->Items->Count){
         tvGroup->OnChange=tvGroupChange;
         tvGroup->OnChanging=tvGroupChanging;
         tvGroup->Selected=tvGroup->Items->Item[0];
      }
      if(tvPoint->Items->Count){
         tvPoint->Selected=tvPoint->Items->Item[0];
      }
      Width=Width-1;
      Height=Height-1;
      tvGroup->SetFocus();
   }else{
      Close();
   }

  if(customer_id==1) //Блокируем редактирование
  {
       tvGroup->DragMode = dmManual;
       tvGroup->OnDragDrop = NULL;
       tvGroup->OnDragOver = NULL;
       tvGroup->OnStartDrag = NULL;
       tvGroup->OnKeyDown = NULL;
       TabSheet1->TabVisible = false;
       edName->ReadOnly = true;
       edShortName->ReadOnly = true;
       edAvBr->ReadOnly = true;
       edTehBr->ReadOnly = true;
//       edParameter->ReadOnly = true;
//       Panel23->Enabled = false;
       grMain->ReadOnly = true;
       DBNavigator1->Enabled = false;
       Panel16->Visible = false;
       Panel16->Enabled = false;
       meStart->ReadOnly = true;
       meFinish->ReadOnly = true;

       iaClose->OnExecute = iaCloseExecute;
       ShowAction(iaNew, false);
       ShowAction(iaDelete, false);
       lbKC->Enabled=true;
       lbKC->Visible = true;
       eKC->Enabled=true;
       eKC->Visible = true;
       plPartlyCalc->Height=60;

  }else{
        PanelPeriod->Enabled=false;
        PanelPeriod->Visible=false;
        PanelPeriod->Height=0;
        lbKC->Enabled=false;
        lbKC->Visible = false;
        eKC->Enabled=false;
        eKC->Visible = false;
        plPartlyCalc->Height=32;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::tvExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if(Node&&Node->getFirstChild()&&!Node->getFirstChild()->Data){
    ReadNode((TTreeView*)Sender,Node);
  }
}
//---------------------------------------------------------------------------
bool __fastcall TFormEditGropsList::ReadNode(TTreeView* tv,TTreeNode* NodeParent)// Читает ветку дерева Групп
{

    short indicator1[10];
    POINTSDIV *PTreeTable;
    pointslim *PLimTable;
    TTreeNode *AddNode;
    long parmid,statelim,idgr;
    try{
        if(NodeParent && NodeParent->HasChildren)
            NodeParent->DeleteChildren();
        if(tv==tvGroup){
            if(!NodeParent)
                CountGroups_Del=0;

          dmMain->oqCursor->Params->Clear();
          dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editgroups_pg.ReadNodeGroup_p(:par1,:par2); end;";
          dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
          dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
          if(!NodeParent) dmMain->oqCursor->ParamByName("par1")->Clear();
          else{
          parmid=((POINTSDIV*)NodeParent->Data)->Id;
          dmMain->oqCursor->ParamByName("par1")->AsInteger=parmid;
          }

        }else{
          dmMain->oqCursor->Params->Clear();
          dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editgroups_pg.ReadNodePoints_p(:par1,:par2); end;";
          dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
          dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
            if(!NodeParent){
               PTreeTable=new POINTSDIV;
                ZeroMemory(PTreeTable,sizeof(POINTSDIV));
               strcpy(PTreeTable->Name,Reconst_smes22_9.c_str());
               AddNode = tv->Items->AddChildObject(NULL,PTreeTable->Name,PTreeTable);
               AddNode->ImageIndex =2;
                AddNode->SelectedIndex=2;
                dmMain->oqCursor->ParamByName("par1")->Clear();

            }else{

                parmid=((POINTSDIV*)NodeParent->Data)->Id;
                dmMain->oqCursor->ParamByName("par1")->AsInteger=parmid;
            }
        }
           dmMain->oqCursor->Execute();

       while(!dmMain->oqCursor->Eof){
        PTreeTable=new POINTSDIV;
        ZeroMemory(PTreeTable,sizeof(POINTSDIV));
               PTreeTable->editing=dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
               PTreeTable->Id = dmMain->oqCursor->FieldByName("gid")->AsInteger;
               PTreeTable->Type= dmMain->oqCursor->FieldByName("ind")->AsInteger;
               if(!dmMain->oqCursor->FieldByName("name")->IsNull)
               strcpy(PTreeTable->Name,dmMain->oqCursor->FieldByName("name")->AsString.c_str());
               if(!dmMain->oqCursor->FieldByName("short_name")->IsNull)
               strcpy(PTreeTable->Short_Name,dmMain->oqCursor->FieldByName("short_name")->AsString.c_str());
             if(tv==tvGroup){
                 if(!dmMain->oqCursor->FieldByName("nemergencyreserve")->IsNull)
                 PTreeTable->avbron= dmMain->oqCursor->FieldByName("nemergencyreserve")->AsInteger;
                 if(!dmMain->oqCursor->FieldByName("ntechnologyreserve")->IsNull)
                 PTreeTable->techbron= dmMain->oqCursor->FieldByName("ntechnologyreserve")->AsInteger;
                 PTreeTable->nLimits= dmMain->oqCursor->FieldByName("nLimits")->AsInteger;
                 PTreeTable->nSum= dmMain->oqCursor->FieldByName("nSum")->AsInteger;
                 PTreeTable->inverted=dmMain->oqCursor->FieldByName("inverted")->AsInteger;
                 if(!dmMain->oqCursor->FieldByName("InfoArea")->IsNull)
                 strcpy(PTreeTable->InfoArea,dmMain->oqCursor->FieldByName("InfoArea")->AsString.c_str());
                 if(!dmMain->oqCursor->FieldByName("vparam")->IsNull)
                 strcpy(PTreeTable->vparameter,dmMain->oqCursor->FieldByName("vparam")->AsString.c_str());
                 if(!dmMain->oqCursor->FieldByName("npartly")->IsNull)
                 PTreeTable->PartlyCalc= dmMain->oqCursor->FieldByName("npartly")->AsInteger;
                 if(!dmMain->oqCursor->FieldByName("nfromperiod")->IsNull)
                 PTreeTable->nfromperiod=dmMain->oqCursor->FieldByName("nfromperiod")->AsInteger;
                 if(!dmMain->oqCursor->FieldByName("ntillperiod")->IsNull)
                 PTreeTable->ntillperiod=dmMain->oqCursor->FieldByName("ntillperiod")->AsInteger;
                 PTreeTable->nkc=dmMain->oqCursor->FieldByName("kc")->AsFloat;
                 }
       AddNode = tv->Items->AddChildObject(NodeParent,PTreeTable->Name,PTreeTable);
                if(tv==tvGroup){
                    AddNode->ImageIndex =(PTreeTable->Type)?PTreeTable->inverted:(PTreeTable->Type==4)?0:2; //edited by KAG
                    AddNode->SelectedIndex=(PTreeTable->Type)?PTreeTable->inverted:(PTreeTable->Type==4)?0:2; //edited by KAG
                }else{
                   switch(PTreeTable->Type)
                   {
                     case 0:  AddNode->ImageIndex = 4;
                              AddNode->SelectedIndex=4;
                              break;
                     case 3:  AddNode->ImageIndex = 0;
                              AddNode->SelectedIndex=0;
                              break;
                     case 4:  AddNode->ImageIndex = 26;
                              AddNode->SelectedIndex=26;
                              break;
                     case 6:  AddNode->ImageIndex = 27;
                              AddNode->SelectedIndex=27;
                              break;
                     case 7:  AddNode->ImageIndex = 29;
                              AddNode->SelectedIndex=29;
                              break;
                     case 8:  AddNode->ImageIndex = 28;
                              AddNode->SelectedIndex=28;
                              break;
                     case 9:  AddNode->ImageIndex = 30;
                              AddNode->SelectedIndex=30;
                              break;

                   }

                }
                if(PTreeTable->editing){
                    tv->Items->AddChildObject(AddNode,"",(void*)0);
                    PTreeTable->editing=0;
                }
                PTreeTable->tmpId=PTreeTable->Id;

         dmMain->oqCursor->Next();
         }





        // Вычитка лимитов
        if(tv==tvGroup)
        {
           dmMain->oqCursor->Params->Clear();
          dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editgroups_pg.ReadLimit_p(:par1,:par2); end;";
          dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
          dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
            if(NodeParent)
                dmMain->oqCursor->ParamByName("par1")->AsInteger=parmid;
            else
                dmMain->oqCursor->ParamByName("par1")->Clear();

            if(NodeParent)
                AddNode = NodeParent->getFirstChild();
            else
                AddNode = tv->Items->GetFirstNode();
            if(!AddNode || AddNode->Parent!=NodeParent)
                throw Exception(Reconst_smes22_10);
            PTreeTable = (POINTSDIV*)AddNode->Data;

                dmMain->oqCursor->Execute();

     while(!dmMain->oqCursor->Eof){
     PLimTable=new pointslim;
     ZeroMemory(PLimTable,sizeof(pointslim));
      if(!dmMain->oqCursor->FieldByName("gid")->IsNull){
                indicator1[0]=0;
                PLimTable->id = dmMain->oqCursor->FieldByName("gid")->AsInteger;}
                else indicator1[0]=-1;
                if(!dmMain->oqCursor->FieldByName("date_limit")->IsNull){
                indicator1[1]=0;
                strcpy(PLimTable->date_limit, dmMain->oqCursor->FieldByName("date_limit")->AsString.c_str());}
                else indicator1[1]=-1;
                if(!dmMain->oqCursor->FieldByName("nlimitcons")->IsNull){
                indicator1[2]=0;
                PLimTable->limcons = dmMain->oqCursor->FieldByName("nlimitcons")->AsFloat;}
                else indicator1[2]=-1;
                if(!dmMain->oqCursor->FieldByName("nlimitcapm")->IsNull){
                indicator1[3]=0;
                PLimTable->limcarm = dmMain->oqCursor->FieldByName("nlimitcapm")->AsFloat;}
                else indicator1[3]=-1;
                if(!dmMain->oqCursor->FieldByName("nlimitcape")->IsNull){
                indicator1[4]=0;
                PLimTable->limcape = dmMain->oqCursor->FieldByName("nlimitcape")->AsFloat;}
                else indicator1[4]=-1;
                if(!dmMain->oqCursor->FieldByName("stmot")->IsNull){
                indicator1[5]=0;
                strcpy(PLimTable->stmot, dmMain->oqCursor->FieldByName("stmot")->AsString.c_str());}
                else indicator1[5]=-1;
                if(!dmMain->oqCursor->FieldByName("enmot")->IsNull){
                indicator1[6]=0;
                strcpy(PLimTable->enmot, dmMain->oqCursor->FieldByName("enmot")->AsString.c_str());}
                else indicator1[6]=-1;
                if(!dmMain->oqCursor->FieldByName("stevt")->IsNull){
                indicator1[7]=0;
                strcpy(PLimTable->stevt, dmMain->oqCursor->FieldByName("stevt")->AsString.c_str());}
                else indicator1[7]=-1;
                if(!dmMain->oqCursor->FieldByName("enevt")->IsNull){
                indicator1[8]=0;
                strcpy(PLimTable->enevt, dmMain->oqCursor->FieldByName("enevt")->AsString.c_str());}
                else indicator1[8]=-1;
                  while(PTreeTable->Id != PLimTable->id)
                    {
                        if(PTreeTable->plim)
                            PTreeTable->plim->Capacity = PTreeTable->plim->Count;
                        AddNode = AddNode->getNextSibling();
                        if(!AddNode || AddNode->Parent!=NodeParent)
                            throw Exception(Reconst_smes22_11);
                        PTreeTable = (POINTSDIV*)AddNode->Data;
                    }
                    // Добавление лимита к группе PTreeTable
                    if(!PTreeTable->plim)
                        PTreeTable->plim = new TList;
                    PLimTable->indcons=indicator1[2];
                    PLimTable->indcarm=indicator1[3];
                    PLimTable->indcape=indicator1[4];
                    PTreeTable->plim->Add(PLimTable);

             dmMain->oqCursor->Next();
             }
            if(!PTreeTable->plim)
                PTreeTable->plim = new TList;
            PTreeTable->plim->Capacity = PTreeTable->plim->Count;
        }

     oqGetAcc->ParamByName("par1")->AsInteger=UsCon.Role_Id;
    oqGetAcc->Execute();
     while(!oqGetAcc->Eof){
      GrbInit();
      if(oqGetAcc->FieldByName("task_cod")->AsInteger==603)miManIn->Tag=oqGetAcc->FieldByName("nacc")->AsInteger;
      if(oqGetAcc->FieldByName("task_cod")->AsInteger==608) miManMetr->Tag=oqGetAcc->FieldByName("nacc")->AsInteger;
     oqGetAcc->Next();
     }


    }catch (Exception &exception){

  	    Application->ShowException(&exception);
        return false;
    }

    return true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::ShowTable(TTreeNode *Node)
{
 if (VT_Data)
 {
 VT_Data->AfterDelete=NULL;
 dsMain->DataSet=NULL;

 if(!VT_Data->IsEmpty())
   {
      VT_Data->First();
      while(!VT_Data->Eof)
       {
        VT_Data->Delete();
       }
   }

 VT_Data->AfterDelete=TableAfterDelete;
 VT_Data->FieldByName("DateLim")->OnValidate=DATEValidate;

 if(!Node||!Node->Data||!((POINTSDIV*)Node->Data)->plim){
   dsMain->DataSet=VT_Data;
   return;
 }
 TList *list_limit=((POINTSDIV*)Node->Data)->plim;
 VT_Data->AfterInsert=NULL;
 VT_Data->AfterEdit=NULL;

  for(long i=0;i<list_limit->Count;i++)
     {
        pointslim *PLimTable=(pointslim *)list_limit->Items[i];
        VT_Data->Append();
      //  VT_Data->Fields->FieldByName("IdGroup")->AsInteger =((POINTSDIV*)Node->Data)->Id;
        VT_Data->Fields->FieldByName("DateLim")->AsString = PLimTable->date_limit;
//add by NNV
          VT_Data->Fields->FieldByName("StMorningT")->AsString = PLimTable->stmot;
          VT_Data->Fields->FieldByName("EndMorningT")->AsString = PLimTable->enmot;
          VT_Data->Fields->FieldByName("StEveningT")->AsString = PLimTable->stevt;
          VT_Data->Fields->FieldByName("EndEveningT")->AsString = PLimTable->enevt;
// end add by NNV
        if(PLimTable->indcons>-1)
          VT_Data->Fields->FieldByName("ConsLim")->AsFloat = PLimTable->limcons/1000;
        else
          VT_Data->Fields->FieldByName("ConsLim")->Clear();
        if(PLimTable->indcarm>-1)
          VT_Data->Fields->FieldByName("CarmLim")->AsFloat = PLimTable->limcarm/1000;
        else
          VT_Data->Fields->FieldByName("CarmLim")->Clear();
        if(PLimTable->indcape>-1)
          VT_Data->Fields->FieldByName("CapeLim")->AsFloat = PLimTable->limcape/1000;
        else
          VT_Data->Fields->FieldByName("CapeLim")->Clear();
        VT_Data->Post();
       }
  VT_Data->First();
  dsMain->DataSet=VT_Data;
  VT_Data->AfterInsert=TableAfterInsert;
  VT_Data->AfterEdit=TableAfterEdit;
  VT_Data->FieldByName("DateLim")->OnValidate=DATEValidate;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::tvDeletion(TObject *Sender,
      TTreeNode *Node)
{
   if(Clipboard()->GetAsHandle(CF_GROUPS_TREENODE)==(unsigned int)Node)
      Clipboard()->Clear();
   if(Node&&Node->Data){
      if(((POINTSDIV*)Node->Data)->plim)
      {
         TList *list_limit=((POINTSDIV*)Node->Data)->plim;
         if(list_limit){
            for(long i=0;i<list_limit->Count;i++)
            {
               pointslim *PLimTable=(pointslim *)list_limit->Items[i];
               delete PLimTable;
            }
            delete list_limit;
         }
      }
      if(realdeletion&&((POINTSDIV*)Node->Data)->Id)
         nGroups_Del[CountGroups_Del++]=((POINTSDIV*)Node->Data)->Id;
      delete (POINTSDIV*)Node->Data;
   }
}
//---------------------------------------------------------------------------
bool __fastcall TFormEditGropsList::SaveLimits(TTreeNode *Node)
{
  pointslim  LimTable;
  POINTSDIV PTreeTable;
  TList *ls;
  int siz_mas;
  try{
    oqSaveLimits->ParamByName("par1")->AsInteger= ((POINTSDIV*)Node->Data)->Id;
    for(int i=2;i<=9;i++){
      oqSaveLimits->ParamByName("par"+IntToStr(i))->Length=1;
      oqSaveLimits->ParamByName("par"+IntToStr(i))->Clear();
    }

    if(((POINTSDIV*)Node->Data)->plim){
      ls=((POINTSDIV*)Node->Data)->plim;
      siz_mas=min(MAXTABLESIZE,ls->Count);
      for(int k=1;k<=siz_mas;k++){
        pointslim *PLimTable=(pointslim *)ls->Items[k-1];
        for(int i=2;i<=9;i++)
          oqSaveLimits->ParamByName("par"+IntToStr(i))->Length=k;
        oqSaveLimits->ParamByName("par2")->ItemAsString[k]= PLimTable->date_limit;
        if(PLimTable->indcons>-1)
          oqSaveLimits->ParamByName("par3")->ItemAsFloat[k]=PLimTable->limcons;
        if(PLimTable->indcarm>-1)
          oqSaveLimits->ParamByName("par4")->ItemAsFloat[k]=PLimTable->limcarm;
        if(PLimTable->indcape>-1)
          oqSaveLimits->ParamByName("par5")->ItemAsFloat[k]=PLimTable->limcape;
        if(strlen(PLimTable->stmot)!=0)
          oqSaveLimits->ParamByName("par6")->ItemAsString[k]="1.01.2000 "+AnsiString(PLimTable->stmot)+":00";
        if(strlen(PLimTable->enmot)!=0)
          oqSaveLimits->ParamByName("par7")->ItemAsString[k]="1.01.2000 "+AnsiString(PLimTable->enmot)+":00";
        if(strlen(PLimTable->stevt)!=0)
          oqSaveLimits->ParamByName("par8")->ItemAsString[k]="1.01.2000 "+AnsiString(PLimTable->stevt)+":00";
        if(strlen(PLimTable->enevt)!=0)
          oqSaveLimits->ParamByName("par9")->ItemAsString[k]="1.01.2000 "+AnsiString(PLimTable->enevt)+":00";
      }
    }
    oqSaveLimits->Execute();
    return true;
  }catch (Exception &exception){
    dmMain->orases->Rollback();
    Application->ShowException(&exception);
    if(Node)
      tvGroup->Selected=Node;
  }
  return false;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::tvGroupChanging(TObject* Sender, TTreeNode* Node, bool &AllowChange)
{
 try{
  if(!tvGroup->Selected)
   return;

   if(VT_Data->State!=dsBrowse)
    VT_Data->Post();
  pointslim  LimTable;
  TList *ls;

 if(((POINTSDIV*)tvGroup->Selected->Data)->editlim==1){
    if(!((POINTSDIV*)tvGroup->Selected->Data)->plim)
           ((POINTSDIV*)tvGroup->Selected->Data)->plim=new TList;
    ls=((POINTSDIV*)tvGroup->Selected->Data)->plim;
    if(ls){
       for(long i=0;i<ls->Count;i++)
        {
         pointslim *PLimTable=(pointslim *)ls->Items[i];
         delete PLimTable;
        }
      delete ls;
      }
    if(VT_Data->IsEmpty())
      ((POINTSDIV*)tvGroup->Selected->Data)->plim=NULL;
    if(!VT_Data->IsEmpty()){
        TList *listLim=new TList;
        VT_Data->First();
        while(!VT_Data->Eof)
          {
           strcpy( LimTable.date_limit,VT_Data->FieldByName("DateLim")->AsString.c_str());
           //add by NNV
           strcpy( LimTable.stmot,VT_Data->FieldByName("StMorningT")->AsString.c_str());
           strcpy( LimTable.enmot,VT_Data->FieldByName("EndMorningT")->AsString.c_str());
           strcpy( LimTable.stevt,VT_Data->FieldByName("StEveningT")->AsString.c_str());
           strcpy( LimTable.enevt,VT_Data->FieldByName("EndEveningT")->AsString.c_str());
           //end add by NNV
           if(!VT_Data->FieldByName("ConsLim")->IsNull)
            {
             LimTable.limcons = VT_Data->FieldByName("ConsLim")->AsFloat;
             LimTable.limcons = LimTable.limcons *1000;
             LimTable.indcons = 0;
            }
           else
             LimTable.indcons = -1;
           if(!VT_Data->FieldByName("CarmLim")->IsNull)
            {
             LimTable.limcarm = VT_Data->FieldByName("CarmLim")->AsFloat;
             LimTable.limcarm = LimTable.limcarm *1000;
             LimTable.indcarm = 0;
            }
           else
            LimTable.indcarm = -1;
           if(!VT_Data->FieldByName("CapeLim")->IsNull)
            {
             LimTable.limcape = VT_Data->FieldByName("CapeLim")->AsFloat;
             LimTable.limcape = LimTable.limcape *1000;
             LimTable.indcape = 0;
            }
           else
            LimTable.indcape = -1;
           pointslim  *PLimTable= new pointslim;
           memcpy(PLimTable,&LimTable,sizeof(pointslim));
           listLim->Add(PLimTable);

           VT_Data->Next();
          }
         ((POINTSDIV*)tvGroup->Selected->Data)->plim=listLim;
    }
 }

  edAvBrExit(edAvBr);
  edTehBrExit(edTehBr);
  }catch(Exception &e){
    AllowChange=false;
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::tvGroupChange(TObject *Sender, TTreeNode *Node)
{
    AnsiString Start;
    if(ActiveControl) oldCtrl = ActiveControl;
    POINTSDIV *PTreeTable=NULL;
    if(!Node||!Node->Data){
        paEdit->Enabled=false;
        iaDelete->Enabled=false;
    }else{
        if(Access==accWrite) paEdit->Enabled=true;
        iaDelete->Enabled=true;
        PTreeTable=(POINTSDIV*)Node->Data;
    }
  SetEvents(false);
  edName->Text="";
  edShortName->Text="";
  lbId->Text="";
  edAvBr->Text="";
  edTehBr->Text="";
  edParameter->Text="";
  edParameter->Text="";
  cbPartlyCalc->ItemIndex = 0;
  cbSum->Checked=false;
  cbInvers->Checked=false;
  meStart->Text="";
  meFinish->Text="";
  if(!PTreeTable)
    return;
  edName->Text=PTreeTable->Name;
  edShortName->Text=PTreeTable->Short_Name;
  lbId->Text=IntToStr(PTreeTable->Id);
  mInfoArea->Lines->Text = PTreeTable->InfoArea;
  if(PTreeTable->nfromperiod){
  Start=IntToStr(PTreeTable->nfromperiod);
  meStart->Text=Start.SubString(5,2)+"."+Start.SubString(1,4);}
  if(PTreeTable->ntillperiod){
  Start=IntToStr(PTreeTable->ntillperiod);
  meFinish->Text=Start.SubString(5,2)+"."+Start.SubString(1,4);}
  Currency ft;
  if(PTreeTable->avbron){
    ft=StrToCurr(IntToStr(PTreeTable->avbron));
    ft=ft/1000;
    edAvBr->Text=CurrToStr(ft);
  }
  if(PTreeTable->techbron){
    ft=StrToCurr(IntToStr(PTreeTable->techbron));
    ft=ft/1000;
    edTehBr->Text=FloatToStr(ft);
  }
  edParameter->Text=PTreeTable->vparameter;
  cbPartlyCalc->ItemIndex = PTreeTable->PartlyCalc;
  cbSum->Checked=PTreeTable->nSum;
  cbInvers->Checked=PTreeTable->inverted;
  eKC->Text=PTreeTable->nkc;
  bool gr=!PTreeTable->Type;
  if (gr)
  {
    edPointId->Text="";
    lblPointId->Enabled=false;
  }
  else
  {
    lblPointId->Enabled=true;
    edPointId->Text=IntToStr(PTreeTable->Type);
  }
  edName->Enabled=gr;
  edShortName->Enabled=gr;
  cbSum->Enabled=gr;
  cbInvers->Enabled=!gr;
  cbPartlyCalc->Enabled=!gr;
  cbPartlyCalc->Color = gr ? clMenu : clWindow;
  SetEvents(true);

   /* if(tvGroup->Selected&&tvGroup->Selected->Data)
      {
         FORMS *fms;
         fms=(FORMS*)mMon->Tag ;
         if(!fms) fms = new FORMS;
         ZeroMemory(fms, sizeof(FORMS));
         if(tvGroup->Selected&&tvGroup->Selected->Data)
          fms->gid = ((POINTSDIV*)tvGroup->Selected->Data)->Id;
          fms->tmplCode=0;
          mMon->Tag = (int)fms;
          createSubMenu_G(mMon);
       }   */

  if(Node)
    ShowTable(Node);
   try{
      ActiveControl = oldCtrl;
   }catch(Exception&e){
      ActiveControl = NULL;
   }



}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::SetEvents(bool b)
{
  if(b){
    edName->OnChange=edNameChange;
    edShortName->OnChange=edShortNameChange;
    edParameter->OnChange=edParameterChange;
    cbPartlyCalc->OnChange = cbPartlyCalcChange;
    edAvBr->OnExit=edAvBrExit;
    edAvBr->OnKeyPress=edKeyPress;
    edTehBr->OnExit=edTehBrExit;
    edTehBr->OnKeyPress=edKeyPress;
    cbSum->OnClick=cbSumClick;
    cbInvers->OnClick=cbInversClick;
  }else{
    edName->OnChange=NULL;
    edShortName->OnChange=NULL;
    edParameter->OnChange=NULL;
    cbPartlyCalc->OnChange = NULL;
    edAvBr->OnExit=NULL;
    edAvBr->OnKeyPress=NULL;
    edTehBr->OnKeyPress=NULL;
    edTehBr->OnExit=NULL;
    cbSum->OnClick=NULL;
    cbInvers->OnClick=NULL;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::cbSumClick(TObject *Sender)
{
  TTreeNode* sNode=tvGroup->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  p->nSum=((TCheckBox*)Sender)->Checked;
  if(!p->editing)
    p->editing=1;
  if(!EditRec) EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::cbInversClick(TObject *Sender)
{
  TTreeNode* sNode=tvGroup->Selected;
  if(!sNode||!sNode->Data||!((POINTSDIV*)sNode->Data)->Type)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  p->inverted=((TCheckBox*)Sender)->Checked;
  sNode->ImageIndex=(long)((TCheckBox*)Sender)->Checked;
  sNode->SelectedIndex=(long)((TCheckBox*)Sender)->Checked;
  tvGroup->Invalidate();
  if(!p->editing)
    p->editing=1;
  if(!EditRec) EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::edNameChange(TObject *Sender)
{
  TTreeNode* sNode=tvGroup->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  strcpy(p->Name,((TEdit*)Sender)->Text.c_str());
  sNode->Text=((TEdit*)Sender)->Text;
  if(!p->editing)
    p->editing=1;
  if(!EditRec) EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::edShortNameChange(TObject *Sender)
{
  TTreeNode* sNode=tvGroup->Selected;
  if(!sNode||!sNode->Data||((POINTSDIV*)sNode->Data)->Type)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  strcpy(p->Short_Name,((TEdit*)Sender)->Text.c_str());
  if(!p->editing)
    p->editing=1;
  if(!EditRec) EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::edAvBrExit(TObject *Sender)
{
#define Sender ((TEdit*)Sender)
  TTreeNode* sNode=tvGroup->Selected;
  if(!sNode||!sNode->Data/*||((POINTSDIV*)sNode->Data)->Type*/)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  if(Sender->Text=="" && !p->avbron)
  return;
  if(p->avbron && Sender->Text!="")
   {
    double dd;
    dd=p->avbron;
    dd=dd/1000;
    if(Sender->Text==FloatToStr(dd))
      return;
   }

  try{
    try{
      if(!Sender->Text.IsEmpty()){
        double d=Sender->Text.ToDouble();
        d=d*1000;
        p->avbron=(long)(d);
      }
     else
     {
      if(p->avbron)
        p->avbron=NULL;
     }
    }catch(Exception &e){
      throw Exception(Reconst_smes22_12+Sender->Text+Reconst_smes22_13);
    }
  }catch(Exception &e){
  	Application->ShowException(&e);
  	Sender->SetFocus();
  }
  if(!p->editing)
    p->editing=1;
  if(!EditRec) EditRec=true;
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::edTehBrExit(TObject *Sender)
{
#define Sender ((TEdit*)Sender)
  TTreeNode* sNode=tvGroup->Selected;
  if(!sNode||!sNode->Data/*||((POINTSDIV*)sNode->Data)->Type*/)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  if(Sender->Text=="" && !p->techbron)
   return;
  if(p->techbron && Sender->Text!="")
   {
    double dd;
    dd=p->techbron;
    dd=dd/1000;
    if(Sender->Text==FloatToStr(dd))
      return;
   }

  try{
    try{
      if(!Sender->Text.IsEmpty()){
        double d=Sender->Text.ToDouble();
        d=d*1000;
        p->techbron=(long)(d);
      }
     else
     {
      if(p->techbron)
        p->techbron=NULL;
     }
    }catch(Exception &e){
      throw Exception(Reconst_smes22_12+Sender->Text+Reconst_smes22_13);
    }
  }catch(Exception &e){
  	Application->ShowException(&e);
  	Sender->SetFocus();
  }
  if(!p->editing)
    p->editing=1;
  if(!EditRec) EditRec=true;
#undef Sender
}
//---------------------------------------------------------------------------

bool __fastcall TFormEditGropsList::tvCheckDragOver(TTreeNode*accNode,TTreeNode*srcNode)
{
   if(Access==accRead){
      return false;
   }
   POINTSDIV* p=NULL;//Текущее
   POINTSDIV* s;//Перетягиваемое
   try{
      if(!srcNode||!srcNode->Data){
         return false;
      }
      s=(POINTSDIV*)srcNode->Data;
      if(accNode)
         p=(POINTSDIV*)accNode->Data;
      if(srcNode->TreeView==tvPoint){//Тянем справа
         if(!accNode){//Родитель NULL
            if(s->Type)
               return false;
         }else{//Родитель не NULL
            if(p->Type)
               return false;
         }
      }else{//С места на место
         if(!accNode){//Родитель NULL
            if(s->Type||!srcNode->Parent)
               return false;
         }else{//Родитель не NULL
            if(p->Type||srcNode->Parent==accNode||srcNode==accNode||accNode->HasAsParent(srcNode))
               return false;
         }
      }
   }catch(Exception &e){
      return false;
   }
   return true; 
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::tvGroupDragOver(TObject *Sender,
	TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
   Accept = tvCheckDragOver(
      ((TTreeView*)Sender)->GetNodeAt(X, Y),
      ((TTreeView*)Source)->Selected
   );
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::tvGroupDragDrop(TObject *Sender,
	TObject *Source, int X, int Y)
{
   TTreeNode*Dst = ((TTreeView*)Sender)->GetNodeAt(X, Y);
   TTreeNode*Src = ((TTreeView*)Source)->Selected;
   if(!Src || !Src->Data)
      throw Exception(Reconst_smes22_14);
   Src->Cut = (GetKeyState(VK_CONTROL)&0x8000);
   if(Src->TreeView==tvGroup)
      Src->Cut = !Src->Cut;

   changeNode(Dst, Src);

   if(Src->TreeView==tvPoint && Src->Cut)
      Src->Cut = false;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::vRefresh(TObject* Sender)
{
   TCursor oldc = Screen->Cursor;
   Screen->Cursor = crHourGlass;
   VT_Data->Cancel();

   tvGroup->OnChange=NULL;
   tvGroup->Visible = false;
   tvPoint->Visible = false;
   tvGroup->Items->Clear();
   tvPoint->Items->Clear();
   if(ReadNode(tvGroup,NULL)&&ReadNode(tvPoint,NULL)){
      if(tvGroup->Items->Count){
         tvGroup->OnChange=tvGroupChange;
         tvGroup->Selected=tvGroup->Items->Item[0];
         bool b=true;
         tvGroupChanging(tvGroup,tvGroup->Selected,b);
      }
      if(tvPoint->Items->Count){
         tvPoint->Selected=tvPoint->Items->Item[0];
      }
   }else
      tvGroupChange(tvGroup,NULL);
   tvPoint->Visible = true;
   tvGroup->Visible = true;

   Screen->Cursor = oldc;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::vDelete(TObject* Sender)
{
  if(!iaDelete->Enabled)
    return;
  TTreeNode *sNode=tvGroup->Selected;
  TTreeView *tv=NULL;
  if(sNode&&sNode->Data&&MessageBox(Handle,AnsiString(Reconst_smes22_15+sNode->Text+">?").c_str(),Application->Title.c_str(),MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){
    tv=(TTreeView*)sNode->TreeView;
    try{
      realdeletion=true;
      sNode->Delete();
      realdeletion=false;
    }catch(Exception &e){
      realdeletion=false;
      throw;
    }
    if(tv&&!tv->Items->Count&&tv->OnChange)
      tv->OnChange(tv,NULL);
    if(!EditRec) EditRec=true;
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::vSave(TObject* Sender)
{
  bool b=true;
  if(!EditRec)
    return;
  tvGroupChanging(tvGroup,tvGroup->Selected,b);
  if(!b)
    return;
  TTreeNode *Node=NULL;
  POINTSDIV PTreeTable;
  long ltmp=0;
  try{    
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 

    dmMain->quMain->SQL->Text="declare \
                  ln_mid NUMBER; \
                  ln_parent NUMBER; \
                  PartlyCalc NUMBER; \
                begin \
                  if :par11 = 0 then \
                    PartlyCalc := NULL; \
                  else \
                    PartlyCalc := :par11; \
                  end if; \
                  if :par5 > 0 then \
                    ln_mid := :par5; \
                  end if; \
                  if :par2 > 0 then \
                    ln_parent := :par2;\
                  end if; \
                  if :par1 > 0 then "+SchemeName+"editgroups_pg.upd_p(:par1,ln_parent,:par3,:par4,ln_mid,null,:par6,:par7,:par8,:par9,:par10, PartlyCalc, :par12, :par13);\
                  else "+SchemeName+"editgroups_pg.ins_p(ln_parent,:par3,:par4,ln_mid,null,:par6,:par7,:par8,:par9,:par10,PartlyCalc,:par12,:par13, :par1); \
                  end if; \
                end;";
    Node=tvGroup->Items->GetFirstNode();
    while(Node){
       if(Node->Data&&((POINTSDIV*)Node->Data)->editing){
         memcpy(&PTreeTable,(POINTSDIV*)Node->Data,sizeof(POINTSDIV));
         if(((POINTSDIV*)Node->Data)->avbron)
           dmMain->quMain->ParamByName("par8")->AsInteger=PTreeTable.avbron;
         else
           dmMain->quMain->ParamByName("par8")->Clear();
         if(((POINTSDIV*)Node->Data)->techbron)
           dmMain->quMain->ParamByName("par9")->AsInteger=PTreeTable.techbron;
         else
           dmMain->quMain->ParamByName("par9")->Clear();
         if(Node->Parent)
           ltmp=((POINTSDIV*)Node->Parent->Data)->tmpId;
         else
           ltmp=0;
          dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
          dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
          dmMain->quMain->ParamByName("par1")->AsInteger=PTreeTable.Id;
          dmMain->quMain->ParamByName("par2")->AsInteger=ltmp;
          dmMain->quMain->ParamByName("par3")->AsString=PTreeTable.Name;
          dmMain->quMain->ParamByName("par4")->AsString=PTreeTable.Short_Name;
          dmMain->quMain->ParamByName("par5")->AsInteger=PTreeTable.Type;
          dmMain->quMain->ParamByName("par6")->AsInteger=PTreeTable.inverted;
          dmMain->quMain->ParamByName("par7")->AsInteger=PTreeTable.nSum;
          dmMain->quMain->ParamByName("par10")->AsString=PTreeTable.vparameter;
          dmMain->quMain->ParamByName("par11")->AsInteger=PTreeTable.PartlyCalc;
          if(PTreeTable.nfromperiod)
          dmMain->quMain->ParamByName("par12")->AsInteger=PTreeTable.nfromperiod;
          else dmMain->quMain->ParamByName("par12")->Clear();
          if(PTreeTable.ntillperiod)
          dmMain->quMain->ParamByName("par13")->AsInteger=PTreeTable.ntillperiod;
          else dmMain->quMain->ParamByName("par13")->Clear();
          dmMain->quMain->Execute();
          PTreeTable.Id=dmMain->quMain->ParamByName("par1")->AsInteger;
          ((POINTSDIV*)Node->Data)->tmpId=PTreeTable.Id;
        }
        Node=Node->GetNext();
    }
	//GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 

    dmMain->quMain->SQL->Text="begin "+SchemeName+"editgroups_pg.del_p(:par1); end;";

    for(int i=0;i<CountGroups_Del;i++){
      ltmp=nGroups_Del[i];
      dmMain->quMain->ParamByName("par1")->AsInteger=ltmp;
      dmMain->quMain->Execute();

    }
    Node=tvGroup->Items->GetFirstNode();
    while(Node){
     if(Node->Data&&((POINTSDIV*)Node->Data)->editlim==1)
        SaveLimits(Node);
     Node=Node->GetNext();
    }



    dmMain->quMain->Params->Clear();
    dmMain->quMain->SQL->Text="begin "+SchemeName+"ORDERFORMULA_PG.order_formula;end;";
    dmMain->quMain->Execute();

    dmMain->orases->Commit();
    CountGroups_Del=0;
    Node=tvGroup->Items->GetFirstNode();
    while(Node){
      if(Node->Data&&((POINTSDIV*)Node->Data)->editing){
        ((POINTSDIV*)Node->Data)->editlim=0;
        ((POINTSDIV*)Node->Data)->editing=0;
        ((POINTSDIV*)Node->Data)->Id=((POINTSDIV*)Node->Data)->tmpId;
      }
      Node=Node->GetNext();
    }
    ShowTable(tvGroup->Selected);
    EditRec=false;
 
  }catch (Exception &exception){
  dmMain->orases->Rollback();

  	Application->ShowException(&exception);
    if(Node)
      tvGroup->Selected=Node;                                                 
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::tvPointExpCol(TObject *Sender,
      TTreeNode *Node)
{
  switch(Node->ImageIndex){
    case 4:
      Node->ImageIndex=5;
      Node->SelectedIndex=5;
      break;
    case 5:
      Node->ImageIndex=4;
      Node->SelectedIndex=4;
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::FormDestroy(TObject *Sender)
{
  delete vtLimits;
  delete fmFP;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::SetFlag()
{
   if(!((POINTSDIV*)tvGroup->Selected->Data))
      return;
   ((POINTSDIV*)tvGroup->Selected->Data)->editlim=1;
   EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::TableAfterInsert(TDataSet *DataSet)
{
   SetFlag();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::TableAfterDelete(TDataSet *DataSet)
{
 SetFlag();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::TableAfterEdit(TDataSet *DataSet)
{
 SetFlag();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::DATEValidate(TField *Sender)
{
#define Sender ((TField*)Sender)
 if(Sender->AsString=="")
  throw Exception(Reconst_smes22_16);
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::edKeyPress(TObject *Sender,
      char &Key)
{
#define Sender ((TEdit*)Sender)
   EditRec=true;
  AnsiString S=(AnsiString)Key;
  AnsiString S1="0123456789";
  AnsiString Sd=AnsiString(DecimalSeparator);
  if(S=="\r"||S=="\b"){
    if(S=="\r")
      Key=NULL;
    return;
  }
  AnsiString tmpStr=Sender->Text.Delete(Sender->SelStart+1,Sender->SelLength).Insert(S,Sender->SelStart+1);
  int PosSd=tmpStr.Pos(Sd);
  if((Sender->Text.Pos(Sd)&&!S1.Pos(S))||
     (!Sender->Text.Pos(Sd)&&!AnsiString(S1+Sd).Pos(S))||
     (PosSd&&tmpStr.SubString(PosSd,tmpStr.Length()+1-PosSd).Length()>4)){
    Key=NULL;
    Beep();
    return;
  }
#undef Sender
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::TableBeforePost(TDataSet *DataSet)
{
char buf[10];
 try{
  if(VT_Data->FieldByName("DateLim")->AsString=="")
   throw Exception(Reconst_smes22_16);
 }catch(Exception &e){
    grMain->SetFocus();
    throw;
 }
   try{
      try{
       if(VT_Data->FieldByName("DateLim")->AsString!=DateToStr(StrToDate(VT_Data->FieldByName("DateLim")->AsString)))
        {
          VT_Data->FieldByName("DateLim")->AsString=DateToStr(StrToDate(VT_Data->FieldByName("DateLim")->AsString));
        }
        //add by NNV
        if(!VT_Data->FieldByName("StMorningT")->AsString.IsEmpty())
         if(VT_Data->FieldByName("StMorningT")->AsString!=StrToTime(VT_Data->FieldByName("StMorningT")->AsString).FormatString("HH:NN"))
          VT_Data->FieldByName("StMorningT")->AsString = StrToTime(VT_Data->FieldByName("StMorningT")->AsString).FormatString("HH:NN");

        if(!VT_Data->FieldByName("EndMorningT")->AsString.IsEmpty())
         if(VT_Data->FieldByName("EndMorningT")->AsString!=StrToTime(VT_Data->FieldByName("EndMorningT")->AsString).FormatString("HH:NN"))
          VT_Data->FieldByName("EndMorningT")->AsString = StrToTime(VT_Data->FieldByName("EndMorningT")->AsString).FormatString("HH:NN");

        if(!VT_Data->FieldByName("StEveningT")->AsString.IsEmpty())
         if(VT_Data->FieldByName("StEveningT")->AsString!=StrToTime(VT_Data->FieldByName("StEveningT")->AsString).FormatString("HH:NN"))
          VT_Data->FieldByName("StEveningT")->AsString = StrToTime(VT_Data->FieldByName("StEveningT")->AsString).FormatString("HH:NN");

        if(!VT_Data->FieldByName("EndEveningT")->AsString.IsEmpty())
         if(VT_Data->FieldByName("EndEveningT")->AsString!=StrToTime(VT_Data->FieldByName("EndEveningT")->AsString).FormatString("HH:NN"))
          VT_Data->FieldByName("EndEveningT")->AsString = StrToTime(VT_Data->FieldByName("EndEveningT")->AsString).FormatString("HH:NN");
        //end add by NNV
      }catch(Exception &e){
        throw Exception(Reconst_smes22_17);
      }
    }catch(Exception &e){
      grMain->SetFocus();
      throw;
    }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::changeNode(TTreeNode*Dst,TTreeNode*Src)
{
   TTreeNode*newNode;
try{
   Screen->Cursor=crHourGlass;
   if(!Src || !Src->Data) return;
   if(Dst && Dst->getFirstChild() && !Dst->getFirstChild()->Data)
      ReadNode((TTreeView*)Dst->TreeView, Dst);
   if(Src->TreeView==tvPoint){//Тянем справа
      if(Src->Cut){ // Copy only child Nodes
         if(Src->HasChildren)
            copyChildNodes(Dst, Src);
      }else{// Copy all Tree of Nodes
         POINTSDIV* pGroup = new POINTSDIV();
         memcpy(pGroup,(POINTSDIV*)Src->Data,sizeof(POINTSDIV));
         newNode = tvGroup->Items->AddChildObject(Dst, Src->Text, pGroup);
         newNode->ImageIndex =(pGroup->Type==3 || pGroup->Type==4)?0:2;// edited by KAG
         newNode->SelectedIndex=(pGroup->Type==3 || pGroup->Type==4)?0:2;// edited by KAG
         pGroup->nSum=(pGroup->Type==3 || pGroup->Type==4)?0:1;         // edited by KAG
         pGroup->Type=(pGroup->Type==3 || pGroup->Type==4)?pGroup->Id:0;// edited by KAG
         pGroup->Id=0;
         pGroup->editing=1;
         pGroup->nkc=1;
         if(Src->HasChildren)
            copyChildNodes(newNode, Src);
         if(!tvGroup->Selected){
            tvGroup->OnChange=tvGroupChange;
            tvGroup->OnChanging=tvGroupChanging;
            tvGroup->Selected=tvGroup->Items->Item[0];
         }
      }
   }else{// редактирование в пределах групп
      if(Src->Cut){ // Move
         Src->MoveTo(Dst, naAddChild);
         if(!((POINTSDIV*)Src->Data)->editing)
            ((POINTSDIV*)Src->Data)->editing=1;
      }else{// Copy
         POINTSDIV* pGroup = new POINTSDIV();
         memcpy(pGroup, Src->Data, sizeof(POINTSDIV));
         if(((POINTSDIV*)Src->Data)->plim)
         {
            pGroup->plim=new TList;
            pGroup->plim->Capacity=((POINTSDIV*)Src->Data)->plim->Capacity;
            pointslim   LimTable;
            for(int i=0;i<((POINTSDIV*)Src->Data)->plim->Capacity;i++)
            {
               pointslim *PLimTable=(pointslim *)((POINTSDIV*)Src->Data)->plim->Items[i];
               strcpy(LimTable.date_limit,PLimTable->date_limit);
               //add by NNV
               strcpy(LimTable.stmot,PLimTable->stmot);
               strcpy(LimTable.enmot,PLimTable->enmot);
               strcpy(LimTable.stevt,PLimTable->stevt);
               strcpy(LimTable.enevt,PLimTable->enevt);
               //end add by NNV
               LimTable.limcons=PLimTable->limcons;
               LimTable.limcarm=PLimTable->limcarm;
               LimTable.limcape=PLimTable->limcape;
               LimTable.indcons=PLimTable->indcons;
               LimTable.indcarm=PLimTable->indcarm;
               LimTable.indcape=PLimTable->indcape;
               pointslim *PLim=new pointslim;
               memcpy(PLim,&LimTable,sizeof(pointslim));
               pGroup->plim->Add(PLim);
            }
         }
         pGroup->Id = 0;
         pGroup->editing = 1;
         newNode = tvGroup->Items->AddChildObject(Dst, Src->Text, pGroup);
         newNode->ImageIndex = Src->ImageIndex;
         newNode->SelectedIndex = Src->SelectedIndex;
         if(Src->HasChildren)
            copyChildNodes(newNode, Src);
      }
   }
   EditRec = true;
}catch (Exception &exception){
  	Application->ShowException(&exception);
}
   Screen->Cursor=crDefault;//crArrow;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::SetAccess(TAccess value)
{
   if(FAccess != value){
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      iaDelete->Enabled = wr;
      paEdit->Enabled = wr;
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::vUpdate(TObject* Sender)
{
   if((Access==accRead || customer_id==1)&&((TAction*)Sender)->Enabled)
   if(!(Access==accWrite && customer_id==1 && Sender==iaSave))
      ((TAction*)Sender)->Enabled = false;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::edParameterChange(TObject *Sender)
{
  TTreeNode* sNode=tvGroup->Selected;
  if(!sNode||!sNode->Data)
    return;
  POINTSDIV* p=(POINTSDIV*)sNode->Data;
  strcpy(p->vparameter,((TEdit*)Sender)->Text.c_str());
  if(!p->editing)
    p->editing=1;
  if(!EditRec) EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::vAnyEditClick(TObject* Sender)
{
   char buf[200];
   TTreeNode*selNode;
   TTreeView*tvControl = dynamic_cast<TTreeView*>(ActiveControl);
   TComponent *pMenu = dynamic_cast<TComponent*>(Sender);

   if(tvControl)
   try{
      if(pMenu)
         switch (pMenu->Tag){
         case 1: // Cut
            if(Clipboard()->HasFormat(CF_GROUPS_TREENODE))
               ((TTreeNode*)Clipboard()->GetAsHandle(CF_GROUPS_TREENODE))->Cut = false;
            if(tvControl->Selected && tvControl->Selected->Data && ((POINTSDIV*)tvControl->Selected->Data)->Type!=1){
               tvControl->Selected->Cut = true;
               Clipboard()->SetAsHandle(CF_GROUPS_TREENODE, (UINT)tvControl->Selected);
            }else
               Clipboard()->Clear();
            break;
         case 2: // Copy
            if(Clipboard()->HasFormat(CF_GROUPS_TREENODE))
               ((TTreeNode*)Clipboard()->GetAsHandle(CF_GROUPS_TREENODE))->Cut = false;
            if(tvControl->Selected){
               tvControl->Selected->Cut = false;
               Clipboard()->SetAsHandle(CF_GROUPS_TREENODE, (UINT)tvControl->Selected);
            }else
               Clipboard()->Clear();
            break;
         case 3: // Paste
            selNode = (TTreeNode*)Clipboard()->GetAsHandle(CF_GROUPS_TREENODE);
            if(!selNode)
               break;
            if(selNode->Cut) Clipboard()->Clear();
            if(tvCheckDragOver(tvControl->Selected, selNode))
               changeNode(tvGroup->Selected, selNode);
            else{
               selNode->Cut = false;
               MessageBox(this->Handle, Reconst_smes22_18.c_str(),
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
   selNode = NULL;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::aCbExecute(TObject *Sender)
{
   TAction*a = dynamic_cast<TAction*>(Sender);
   if(a){
      if(a==aSumma && cbSum->Enabled)
         cbSum->Checked = !cbSum->Checked;
      else if(a==aInvert && cbInvers->Enabled)
         cbInvers->Checked = !cbInvers->Checked;
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::vEditClick(TObject*Sender)
{
   TTreeNode*tn;
   if(ActiveControl==tvGroup){
      mnPaste->Enabled = Clipboard()->HasFormat(CF_GROUPS_TREENODE);
      mnCut->Enabled = tvGroup->Selected;
      mnCopy->Enabled = tvGroup->Selected;
      mnDelete->Enabled = tvGroup->Selected;
      mnSelect->Enabled = false;
   }else if(ActiveControl==tvPoint){
      mnPaste->Enabled = false;
      mnCut->Enabled = false;
      mnCopy->Enabled = tvPoint->Selected;
      mnDelete->Enabled = false;
      mnSelect->Enabled = false;
   }else
      TMainForm::vEditClick(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::copyChildNodes(TTreeNode*d, TTreeNode*s)
{
   ReadNode((TTreeView*)s->TreeView,s);
   TTreeNode *tn = s->getFirstChild();
   while(tn){
      if (((POINTSDIV*)s->Data)->Type!=4)// added by KAG
        changeNode(d, tn);
      tn = tn->getNextSibling();
   }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::aMExecute(TObject *Sender)
{
   TTreeNode*ptn;
   TAction*pa = dynamic_cast<TAction*>(Sender);
   if(pa){
      ptn = tvGroup->Selected;
      switch(pa->Tag){
      case 1:// Alt+Left
         if(ptn->Expanded)
            ptn->Collapse(false);
         else if(ptn->Parent)
            tvGroup->Selected = ptn->Parent;
         break;
      case 2:// Alt+Right
         if(!ptn->Expanded)
            ptn->Expand(false);
         else if(ptn->HasChildren)
            tvGroup->Selected = ptn->getFirstChild();
         break;
      case 3:// Alt+Up
         ptn = tvGroup->Selected->GetPrevVisible();
         if(ptn) tvGroup->Selected = ptn;
         break;
      case 4:// Alt+Down
         ptn = tvGroup->Selected->GetNextVisible();
         if(ptn) tvGroup->Selected = ptn;
         break;
      }
   }
}
//---------------------------------------------------------------------------
// Add by KSS (22.06.2004)
void __fastcall TFormEditGropsList::mMonClick(TObject *Sender)
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
        sfd->SummGroup = ((POINTSDIV*)tvGroup->Selected->Data)->nSum;
        sfd->NameForm = fms->name;
        sfd->CommentForm = fms->comment;
        sfd->NameAlert = fms->alertname;
        sfd->NameGroup = ((POINTSDIV*)tvGroup->Selected->Data)->Name;
        sfd->ShortNameGroup = ((POINTSDIV*)tvGroup->Selected->Data)->Short_Name;
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
void __fastcall TFormEditGropsList::createSubMenu_G(TMenuItem*mi)
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

void __fastcall TFormEditGropsList::cbPartlyCalcChange(TObject *Sender)
{
    TTreeNode* sNode = tvGroup->Selected;
    if(!sNode || !sNode->Data)
        return;
    POINTSDIV* p=(POINTSDIV*)sNode->Data;
    p->PartlyCalc = ((TComboBox*)Sender)->ItemIndex;
    if(!p->editing)
        p->editing=1;
    if(!EditRec) EditRec=true;
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::bbPeriodClick(TObject *Sender)  //VNB 14.02.2008
{
  TTreeNode* sNode = tvGroup->Selected;
    if(!sNode || !sNode->Data)
        return;
    POINTSDIV* p=(POINTSDIV*)sNode->Data;
    if(!meStart->Text.IsEmpty())
    p->nfromperiod = StrToInt(meStart->Text.SubString(4,4)+meStart->Text.SubString(1,2));
    else p->nfromperiod=0;
    if(!meFinish->Text.IsEmpty())
    p->ntillperiod = StrToInt(meFinish->Text.SubString(4,4)+meFinish->Text.SubString(1,2));
    else p->ntillperiod=0;
    if(!p->editing)
        p->editing=1;
    if(!EditRec) EditRec=true;
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::sbFindClick(TObject *Sender)
{
 fmFP=new TfmFindPoint(this,true);
 //GRB ADD 09.03.2021 -добавляем вызов 2-х сеттеров, определяющих контекст задачи
 fmFP->setContext(1);
 fmFP->setGroupsAndPoints(false);
 //end add
 fmFP->ShowModal();
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::WM_SetActiveNode(TMessage& Message)
{
  FindNodeGroup(Message.LParam);
}
//---------------------------------------------------------------------------
void __fastcall TFormEditGropsList::FindNodeGroup(long id)
{
    // Запрос - путь к точке :1 начиная с коренного узла

    long parmid=id;
    long pointsTree[MAXCOUNTLEVEL];
    TTreeNode*Node;
    try{
          ZeroMemory(&pointsTree,sizeof(pointsTree));
          dmMain->oqCursor->Params->Clear();
          dmMain->oqCursor->SQL->Text="begin "+SchemeName+"editgroups_pg.find_node(:par1,:par2); end;";
          dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
          dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;

        Node = tvGroup->Items->GetFirstNode();

            dmMain->oqCursor->ParamByName("par1")->AsInteger= parmid;
            dmMain->oqCursor->Execute();
            unsigned long rowCount=0;
            int j=0;
            while(!dmMain->oqCursor->Eof&&j< MAXCOUNTLEVEL){
             pointsTree[j]= dmMain->oqCursor->FieldByName("gid")->AsInteger;
               dmMain->oqCursor->Next();
             j++;
             }
             rowCount=j;
             for(unsigned long i=0; i<rowCount; i++)
             {
                 while(Node){
                    if(pointsTree[i]==GetNodeId(Node))
                        break;
                    Node=Node->getNextSibling();
                }
               if((i<rowCount-1)&&(Node!=NULL))
               {
                    if((Node->HasChildren && !Node->getFirstChild()) ||
                     (Node->getFirstChild() && !Node->getFirstChild()->Data))
                    {
                        Node->DeleteChildren();
                        if(!ReadNode(tvGroup,Node))
                            break;
                    }
                    Node=Node->getFirstChild();
                }else
                    break;
            }
        tvGroup->Selected = Node;
    }catch (Exception &exception){
        Application->ShowException(&exception);
        tvGroup->Selected=Node;
       }
   }
//-------------------------------------------------------------------------------------------------------------



void __fastcall TFormEditGropsList::PopupMenu1Popup(TObject *Sender)
{
if(tvGroup->Selected&&tvGroup->Selected->Data)
      {
         FORMS *fms;
         fms=(FORMS*)mMon->Tag ;
         if(!fms) fms = new FORMS;
         ZeroMemory(fms, sizeof(FORMS));
         if(tvGroup->Selected&&tvGroup->Selected->Data)
          fms->gid = ((POINTSDIV*)tvGroup->Selected->Data)->Id;
          fms->tmplCode=0;
          mMon->Tag = (int)fms;
          createSubMenu_G(mMon);
       }  
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::miManualInpClick(TObject *Sender)
{
 TAccess acc;
  int gid;
  TMainForm*Child;

  if(Sender==miManIn){
     acc = miManIn->Tag==1?accWrite:(miManIn->Tag==0?accRead:accDenied);
     //GRB CHANGE 25.10.2018 - TO TRIAL (need to uncomment when key will be needed)
    if(/*GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0&&*/tvGroup->Selected&&tvGroup->Selected->Data){
    //if(tvGroup->Selected&&tvGroup->Selected->Data){
          gid = ((POINTSDIV*)tvGroup->Selected->Data)->Id;

    Child= new TfmManualInput(Application,miManIn->Caption, gid,2,acc);
    Child->TaskId=603;
  }
  }

  if(Sender==miManMetr){
      acc = miManMetr->Tag==1?accWrite:(miManMetr->Tag==0?accRead:accDenied);
     //GRB CHANGE 25.10.2018 - TO TRIAL (need to uncomment when key will be needed)
    if(/*GrdGetPermission(CHK_LIC_TASK,CHK_LIC_TASK_MANUAL)>0&&*/tvGroup->Selected&&tvGroup->Selected->Data){
    //if(tvGroup->Selected&&tvGroup->Selected->Data){
          gid = ((POINTSDIV*)tvGroup->Selected->Data)->Id;

    Child= new TfmManualInputMeter(Application,miManMetr->Caption, gid,2,acc);
    Child->TaskId=608;
  }
  }
}
//---------------------------------------------------------------------------

void __fastcall TFormEditGropsList::GrbInit()
{
  if ((miManIn==NULL)||(miManMetr==NULL)){
   ShowAction(iaDelete);
     miManualInp->Delete(miManualInp->Count-1);
     miManIn  = new TMenuItem(mMon);

      miManIn->Caption = "Ввод количества энергии";
      miManIn->OnClick = miManualInp->OnClick;
      miManualInp->Add(miManIn);

      miManMetr  = new TMenuItem(mMon);

      miManMetr->Caption = "Ввод показаний";

      miManMetr->OnClick =miManualInp->OnClick;
      miManualInp->Add(miManMetr);

   iaFind->OnExecute =sbFindClick;
   vtLimits= new TVirtualTable(this);
   VT_Data = new TVirtualTable(this);
   VT_Data->AfterInsert=TableAfterInsert;
   VT_Data->AfterDelete=TableAfterDelete;
   VT_Data->AfterEdit=TableAfterEdit;
   VT_Data->BeforePost=TableBeforePost;

   VT_Data->Name = "VT_Data";

   TFieldDef *pNewDef = VT_Data->FieldDefs->AddFieldDef();
   pNewDef->Name = "DateLim";
   pNewDef->DataType = ftString;
   pNewDef->Size=10;

   pNewDef = VT_Data->FieldDefs->AddFieldDef();
   pNewDef->Name = "ConsLim";
   pNewDef->DataType = ftFloat;

   pNewDef = VT_Data->FieldDefs->AddFieldDef();
   pNewDef->Name = "CarmLim";
   pNewDef->DataType = ftFloat;

   pNewDef = VT_Data->FieldDefs->AddFieldDef();
   pNewDef->Name = "CapeLim";
   pNewDef->DataType = ftFloat;
   //add by NNV
   pNewDef = VT_Data->FieldDefs->AddFieldDef();
   pNewDef->Name = "StMorningT";
   pNewDef->DataType = ftString;

   pNewDef = VT_Data->FieldDefs->AddFieldDef();
   pNewDef->Name = "EndMorningT";
   pNewDef->DataType = ftString;

   pNewDef = VT_Data->FieldDefs->AddFieldDef();
   pNewDef->Name = "StEveningT";
   pNewDef->DataType = ftString;

   pNewDef = VT_Data->FieldDefs->AddFieldDef();
   pNewDef->Name = "EndEveningT";
   pNewDef->DataType = ftString;
   // end add by NNV
   dsMain->DataSet=VT_Data;
   grMain->Columns->Items[0]->FieldName="DateLim";
   grMain->Columns->Items[1]->FieldName="ConsLim";
   grMain->Columns->Items[2]->FieldName="CarmLim";
   grMain->Columns->Items[3]->FieldName="CapeLim";
   //add by NNV
   grMain->Columns->Items[4]->FieldName="StMorningT";
   grMain->Columns->Items[5]->FieldName="EndMorningT";
   grMain->Columns->Items[6]->FieldName="StEveningT";
   grMain->Columns->Items[7]->FieldName="EndEveningT";
   // end add by NNV

   VT_Data->Open();
   VT_Data->FieldByName("DateLim")->DisplayLabel=Reconst_smes22_1;
   VT_Data->FieldByName("ConsLim")->DisplayLabel=Reconst_smes22_2;
   VT_Data->FieldByName("CarmLim")->DisplayLabel=Reconst_smes22_3;
   VT_Data->FieldByName("CapeLim")->DisplayLabel=Reconst_smes22_4;
   //add by NNV
   VT_Data->FieldByName("StMorningT")->DisplayLabel=Reconst_smes22_5;
   VT_Data->FieldByName("EndMorningT")->DisplayLabel=Reconst_smes22_6;
   VT_Data->FieldByName("StEveningT")->DisplayLabel=Reconst_smes22_7;
   VT_Data->FieldByName("EndEveningT")->DisplayLabel=Reconst_smes22_8;
   //end add by NNV
   VT_Data->FieldByName("DateLim")->OnValidate=DATEValidate;
   // регистрация формата для буфера обмена
   CF_GROUPS_TREENODE = RegisterClipboardFormat("CF_GROUPS_TREENODE");
   if(!CF_GROUPS_TREENODE)
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
}
//---------------------------------------------------------------------------



