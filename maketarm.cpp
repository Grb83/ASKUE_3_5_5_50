//---------------------------------------------------------------------------

#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "maketarm.h"
#include "unDataMod.h"
#include "DeportProcRun.h"
#include "SetupMonitors.h"
#include "InteriorPLProc.h"

#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "MemDS"
#pragma link "VirtualTable"
#pragma link "DBGridEh"
#pragma link "DBAccess"
#pragma link "Ora"
#pragma link "PrnDbgeh"
#pragma resource "*.dfm"
TfmMaketArm *fmMaketArm;
bool isViewedMaket = false;
const AnsiString delim = L"\u2665"; //единый непечатный разделитель для строк хранилищ вида TStringList, хранящих частичную информацию о сформированных макетах, обход ограничения о записи структуры строк

//---------------------------------------------------------------------------
__fastcall TfmMaketArm::TfmMaketArm(TComponent* Owner, AnsiString Name, TAccess a)
   : TMainForm(Owner, Name, a)
{
  MessageGrid->OnDrawColumnCell = MessageGridDrawColumnCell;
  FInUn=NULL;
  ReplaceRyda(this,BASE_SCHEME,SchemeName);
  dtFrom->DateTime=TDateTime::CurrentDate()-1;
  dtTill->DateTime=TDateTime::CurrentDate()+1;
  //orderStr=" order by 2 desc,3,6";
  orderStr=0;
  reMaket->Font=FormSetupMonitors->REdPLSQLRep->Font;
  MaketInfa->ActivePage=Journal;
 }
//---------------------------------------------------------------------------
 int __fastcall TfmMaketArm::getMaketId(){
        return oqMaketArm->Fields->FieldByName("nmaket")->AsInteger;
 }
//---------------------------------------------------------------------------
TStringList* __fastcall TfmMaketArm::getMaketFile(){
  TTreeNode *Node=MaketsTree->Selected;
  AnsiString sql,sProc,ObjName;
  TDateTime dt=Now();
  int ObjID;
  TStringList* retMaket = new TStringList();
  bool isLoadMaket=false;//Просмотреть сформированный макет
  try{
    edExit(NULL);
    if(!((MAKET*)Node->Data)->IsMaket&&!oqMaketArm->RecordCount)
      return retMaket;
    if(!(Node&&(oqMaketArm->RecordCount||((MAKET*)Node->Data)->ObjType)))
      return retMaket;
    if(oqMaketArm->RecordCount){
      ObjID=oqMaketArm->Fields->FieldByName("nMaket")->AsInteger;
      ObjName=oqMaketArm->Fields->FieldByName("Maket")->AsString;
      dt=oqMaketArm->Fields->FieldByName("Period")->AsDateTime;
    }else{
      if(((MAKET*)Node->Data)->ObjType==2)
        Node=Node->Parent;
      ObjID=((MAKET*)Node->Data)->ObjID;
      ObjName=AnsiString(((MAKET*)Node->Data)->Name);
      dt=TDateTime::CurrentDate()-1;
    }
    if(isLoadMaket)
      sProc="plsql1_pg.report8s_p(2)";
    else{
      if(((MAKET*)Node->Data)->IsMaket==1&&(oqMaketArm->RecordCount&&oqMaketArm->Fields->FieldByName("nPeriod")->AsInteger==7)||
         (!oqMaketArm->RecordCount&&((MAKET*)Node->Data)->nPeriod==7))
        throw Exception(Reconst_smes44_3);
      sProc="plsql3_pg.report17_p";
    }
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="begin "+SchemeName+"filereport_pg.main_p(0,"+IntToStr(ObjID)+",to_date('"+
        dt.FormatString("dd.mm.yyyy hh:nn")+"','dd.mm.yyyy hh24:mi'),to_date('"+dt.FormatString("dd.mm.yyyy hh:nn")+
        "','dd.mm.yyyy hh24:mi')+1/86400,1,'"+sProc+"'); end;";
    dmMain->quMain->Execute();
    //TInteriorPLProc::LoadReportData(reMaket); <---- insert block below
    {
        dmMain->quMain->Params->Clear();
        dmMain->quMain->SQL->Text="begin "+SchemeName+"interior_pg.PLProc_LoadReportData_p(:par1); end;";
        dmMain->quMain->ParamByName("par1")->ParamType=ptOutput;
        dmMain->quMain->ParamByName("par1")->DataType=ftCursor;
        dmMain->quMain->Execute();
        while(!dmMain->quMain->Eof){
                retMaket->Add(dmMain->quMain->FieldByName("vtext")->AsString);
                dmMain->quMain->Next();
        }
        //GRB ADD 16.04.2020 - test trouble ODAC
        dmMain->quMain->Params->Clear();
        //END ADD 
        dmMain->quMain->SQL->Text="begin "+SchemeName+"filereport_pg.clear_table; end;";
        dmMain->quMain->Execute();
        dmMain->quMain->Close();
    }
    /*lbMaketInfo->Caption=ObjName;
    if(isLoadMaket)
      lbRepName->Caption=Reconst_smes44_14+dt.FormatString("dd.mm.yyyy hh:nn");
    else
      lbRepName->Caption=Reconst_smes44_15+dt.FormatString("dd.mm.yyyy hh:nn");
    MaketInfa->ActivePage=Maket;
    reMaket->SetFocus();
    SetEnabledControls();*/
    return retMaket;
  }catch (Exception &exception){
  	Application->ShowException(&exception);
  }

}
//---------------------------------------------------------------------------
AnsiString __fastcall TfmMaketArm::getMaketType(TStringList* maket){ //-1 - ошибка разбора заголовка типа макета
  AnsiString ret="";
  const AnsiString startPos = "((//";
  const int offset = startPos.Length();
  const AnsiString endPos = ":";
  int testIntValue;
  try{
        testIntValue=0;
        AnsiString firstString = maket->Strings[0];
        ret = firstString.SubString ( firstString.AnsiPos(startPos) + offset, firstString.AnsiPos(endPos)-offset - 1);
        testIntValue = StrToInt(ret);
  }catch (Exception* ex){
        ret="-1";
  }
  return ret;
}
//---------------------------------------------------------------------------
TStringList* __fastcall TfmMaketArm::getGroupsInfoByMaketId(int maketId){
TStringList* res = new TStringList;
AnsiString vgroupname, vgroupid, vcode, record;
vgroupname = vgroupid = vcode = record = "";
try{
  dmMain->quMain->Params->Clear();
  dmMain->quMain->SQL->Text="SELECT   m.ngroup vgroupid, m.vname vgroupname, m.vcode vgroupcode FROM "+SchemeName+"maketgroups m where m.nmaket =:par1";
  dmMain->quMain->ParamByName("par1")->AsInteger=maketId;
  dmMain->quMain->Execute();
  while(!dmMain->quMain->Eof){
   vgroupname = dmMain->quMain->FieldByName("vgroupname")->AsString;
   vgroupid = dmMain->quMain->FieldByName("vgroupid")->AsString;
   vcode = dmMain->quMain->FieldByName("vgroupcode")->AsString;
   record = vgroupname +delim +vgroupid+delim+vcode;
   res->Add (record);
   dmMain->quMain->Next();
  }
  dmMain->quMain->Close();
}catch (Exception &ex){
  dmMain->quMain->Close();
  delete res;
  res = NULL;
}
return res;
}
//---------------------------------------------------------------------------
TStringList* __fastcall TfmMaketArm::getPointsNameAndPointsIDByGroupId(AnsiString groupId){
  int mid = 0;
  AnsiString name = "";
  AnsiString record ="";
  TStringList* res = new TStringList;
  try{
  dmMain->quMain->Params->Clear();
  dmMain->quMain->SQL->Text = "begin ryda.makets_pg.getmakettree(:an_id,:an_type,:acur_t); end;";
  dmMain->quMain->ParamByName("an_id")->AsInteger = StrToInt(groupId);
  dmMain->quMain->ParamByName("an_type")->AsInteger = 2;//?
  dmMain->quMain->ParamByName("acur_t")->ParamType = ptOutput;
  dmMain->quMain->ParamByName("acur_t")->DataType = ftCursor;
  dmMain->quMain->Execute();
  while(!dmMain->quMain->Eof){
    mid = dmMain->quMain->FieldByName("mid")->AsInteger;
    name = dmMain->quMain->FieldByName("vname")->AsString;
    record = name +delim +IntToStr (mid)+delim+groupId;
    res->Add(record);
    dmMain->quMain->Next();
  }
  dmMain->quMain->Close();
  }catch (Exception* ex){
  dmMain->quMain->Close();
  delete res;
  res = NULL;
  }
  return res;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::FormShow(TObject *Sender)
{
  #define clFolder    4
  TTreeNode *Node,*sNode,*uNode,*pNode;
  MaketsTree->Items->Clear();
  MAKET *pData=new MAKET;
  ZeroMemory(pData, sizeof(*pData));
  strcpy(pData->Name,Reconst_smes44_1.c_str());
  pData->ObjID=0;
  pData->IsMaket=1;
  sNode= Node = MaketsTree->Items->AddObject(NULL,pData->Name,pData);
  pData=new MAKET;
  ZeroMemory(pData, sizeof(*pData));
  strcpy(pData->Name,AnsiString("УППД").c_str());
  pData->ObjID=0;
  pData->IsMaket=0;
  pNode= uNode = MaketsTree->Items->AddObject(NULL,pData->Name,pData);
  pNode->ImageIndex = imFolder;
  pNode->SelectedIndex = imFolder;
  Node->ImageIndex = imFolder;
  Node->SelectedIndex = imFolder;
  ReadTreeNode(Node);
  Node = Node->getFirstChild();
  while(Node){
    ReadTreeNode(Node);
    Node = Node->getNextSibling();
    }
  ReadTreeNode(uNode);
  uNode = uNode->getFirstChild();
   while(uNode){
    ReadTreeNode(uNode);
    uNode = uNode->getNextSibling();
    }

  sNode->Expand(false);
  sNode->Selected=true;

  MaketsTree->SetFocus();
}
//---------------------------------------------------------------------------
bool __fastcall TfmMaketArm::ReadTreeNode(TTreeNode *ParentNode)
{
   int ind;
   MAKET *pData;
   try{
       if(ParentNode){
         ParentNode->DeleteChildren();
       }

       dmMain->quMain->Params->Clear();
       dmMain->quMain->SQL->Text="begin "+SchemeName+"MAKETARM_PG.readnode_p(:par1,:par2,:par3,:par4); end;";
       dmMain->quMain->ParamByName("par4")->ParamType = ptOutput;
       dmMain->quMain->ParamByName("par4")->DataType = ftCursor;
       dmMain->quMain->ParamByName("par1")->AsInteger=((MAKET*)ParentNode->Data)->ObjID;
       dmMain->quMain->ParamByName("par2")->AsInteger=((MAKET*)ParentNode->Data)->ObjType;
       dmMain->quMain->ParamByName("par3")->AsInteger=((MAKET*)ParentNode->Data)->IsMaket;

       TTreeNode *addNode;
       dmMain->quMain->Execute();
       while(!dmMain->quMain->Eof){
        pData=new MAKET;
        pData->ObjID=dmMain->quMain->FieldByName("nmaket")->AsInteger;
        pData->ObjType=dmMain->quMain->FieldByName("ObjType")->AsInteger;
        pData->IsMaket=dmMain->quMain->FieldByName("IsMaket")->AsInteger;
        strcpy(pData->Name,dmMain->quMain->FieldByName("vname")->AsString.c_str());
        if(!dmMain->quMain->FieldByName("nblock")->IsNull)
          pData->Blocking=dmMain->quMain->FieldByName("nblock")->AsInteger;
        if(!dmMain->quMain->FieldByName("VERROR")->IsNull)
          strcpy(pData->Error,dmMain->quMain->FieldByName("VERROR")->AsString.c_str());
        if(!dmMain->quMain->FieldByName("NPARENT")->IsNull)
          pData->Parent=dmMain->quMain->FieldByName("NPARENT")->AsInteger;
        if(!dmMain->quMain->FieldByName("NextCreated")->IsNull)
          strcpy(pData->LastSystemCreated,dmMain->quMain->FieldByName("NextCreated")->AsString.c_str());
        if(!dmMain->quMain->FieldByName("nperiod")->IsNull)
          pData->nPeriod=dmMain->quMain->FieldByName("nperiod")->AsInteger;
        addNode = MaketsTree->Items->AddChildObject(ParentNode, pData->Name, pData);
        /*if(!((MAKET*)ParentNode->Data)->ObjType){
          if(!AnsiString(pData->Error).Trim().IsEmpty())
            ind = (pData->Blocking)?imBlMaketErr:imMaketErr;
          else
            ind = (pData->Blocking)?imBlMaket:imMaket;
        }else{
          if(pData->Parent)
            ind = (pData->Blocking)?imChanelRCL:imChanelROp;
          else
            ind = (pData->Blocking)?imChanelCL:imChanelOp;
        } */

        if(pData->IsMaket==1){
          switch (pData->ObjType){
          case 0: // папка
            ind = GetFolderInd(addNode, pData->Blocking);
            break;
          case 1: // макет
            if(!AnsiString(pData->Error).Trim().IsEmpty())
              ind = (pData->Blocking)?imBlMaketErr:imMaketErr;
            else
              ind = (pData->Blocking)?imBlMaket:imMaket;
            break;
          case 2: // канал
            ind = (pData->Blocking)?imChanelCL:imChanelOp;
            break;
          }
        }else{
          ind = !pData->Parent?imFolder:(pData->Blocking)?imBlMaket:imMaket;
        }
        addNode->ImageIndex = ind;
        addNode->SelectedIndex = ind;
        if(dmMain->quMain->FieldByName("HaveChild")->AsInteger){  // проверка на наличие дочерних
          MaketsTree->Items->AddChildObject(addNode,"",(void*)0);
        }
        dmMain->quMain->Next();
       }
       dmMain->quMain->Close();

   }catch (Exception &exception){
      Application->ShowException(&exception);
      return false;
   }
     return true;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::vSave(TObject* Sender)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::vRefresh(TObject* Sender)
{
  FormShow(this);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::MaketsTreeChange(TObject *Sender, TTreeNode *Node)
{
  TTreeNode *sNode=MaketsTree->Selected;
  ReadNodeInfo();
  if(((MAKET*)sNode->Data)->ObjType==2)
    sNode=sNode->Parent;
  meError->Text=((MAKET*)sNode->Data)->Error;
  meError->Visible=!meError->Text.Trim().IsEmpty();
  if(((MAKET*)sNode->Data)->IsMaket==0){
  tbOperWork->Enabled=true;
  tbPreview->Enabled=false;
  //GRB change
  tbOperWork->Caption="Оперативная работа с данными сформированными для передачи по каналу УППД";
  tbOperWork->Hint="Оперативная работа с данными сформированными для передачи по каналу УППД";
  isViewedMaket = false;
  //end of GRB change
  tbRun->Hint="Выполнить формирование данных для передачи по каналу УППД";
  tbLoadMaket->Hint="Просмотреть сформированные данные для передачи по каналу УППД";
  tbSendM->Hint="Отправить сформированные данные по каналу УППД";
  MessageGrid->Columns->Items[2]->Title->Caption="Объект";
  MessageGrid->Columns->Items[3]->Visible=false;
  MessageGrid->Columns->Items[5]->Visible=false;
  MessageGrid->Columns->Items[7]->Visible=false;
  }else{
  //tbOperWork->Enabled=false;   COMMENTED BY GRB
  tbPreview->Enabled=(oqMaketArm->RecordCount||((MAKET*)sNode->Data)->ObjType);//true;
  //GRB change
  tbOperWork->Caption="Оперативная работа со сформированным макетом";
  tbOperWork->Hint="Оперативная работа со сформированным макетом";
  tbOperWork->Enabled=true;
  isViewedMaket = true;
  //end of GRB change
  tbRun->Hint="Выполнить формирование данных для макета";
  tbLoadMaket->Hint="Просмотреть сформированный макет";
  tbSendM->Hint="Отправить сформированный макет";
  MessageGrid->Columns->Items[2]->Title->Caption="Макет";
  MessageGrid->Columns->Items[3]->Visible=true;
  MessageGrid->Columns->Items[5]->Visible=true;
  MessageGrid->Columns->Items[7]->Visible=true;
  }
  if(MaketInfa->ActivePage==OperWork)
  {
   //if(((MAKET*)sNode->Data)->IsMaket==1||(((MAKET*)sNode->Data)->IsMaket==0&&((MAKET*)sNode->Data)->ObjType==0))
   //{

    MaketInfa->ActivePage=Journal;
   // }else
   // tbOperWorkClick(this);

  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::MaketsTreeDeletion(TObject *Sender, TTreeNode *Node)
{
  if(Node)
    delete (MAKET*)Node->Data;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::dtChange(TObject *Sender)
{
  ReadNodeInfo();
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::ReadNodeInfo(void)
{
  AnsiString stmp;
  char dfrom[20],dtill[20];
  TWinControl *aControl;
  TTreeNode *sNode=MaketsTree->Selected;
  MAKET *pData=(MAKET*)sNode->Data;
  long ObjID=pData->ObjID;
  try{
    lbMaket->Caption=sNode->Text;
    tbPreview->Enabled=false;
    tbRun->Enabled=false;
    tbLoadMaket->Enabled=false;
    tbDel->Enabled=false;

    try{
      aControl=edFrom;
      StrToTime(edFrom->Text+":00");
      aControl=edTill;
      StrToTime(edTill->Text+":00");
    }catch(Exception &e){
      edFrom->Text="00:00";
      edTill->Text="00:00";
      Application->MessageBox(Reconst_smes44_2.c_str(),Application->Title.c_str(),MB_OK	|MB_ICONWARNING);
      aControl->SetFocus();
    }
    stmp=dtFrom->Date.FormatString("dd.mm.yyyy")+" "+edFrom->Text+":00";
    strcpy(dfrom,stmp.c_str());
    stmp=dtTill->Date.FormatString("dd.mm.yyyy")+" "+edTill->Text+":00";
    strcpy(dtill,stmp.c_str());

       oqMaketArm->Params->Clear();
       oqMaketArm->SQL->Text="begin "+SchemeName+"MAKETARM_PG.readnodeinfo_p(:par1,:par2,:par3,:par4, \
                          :par5,:par6,:par7,:par8,:par9,:par10); end;";
       oqMaketArm->ParamByName("par10")->ParamType = ptOutput;
       oqMaketArm->ParamByName("par10")->DataType = ftCursor;
       oqMaketArm->ParamByName("par1")->AsInteger= ObjID;
       oqMaketArm->ParamByName("par2")->AsInteger= pData->ObjType;
       oqMaketArm->ParamByName("par3")->AsInteger=(tbState0->Down)?1:0;
       oqMaketArm->ParamByName("par4")->AsInteger=(tbState1->Down)?1:0;
       oqMaketArm->ParamByName("par5")->AsInteger=(tbState2->Down)?1:0;
       oqMaketArm->ParamByName("par6")->AsInteger=orderStr;
       oqMaketArm->ParamByName("par7")->AsString= dfrom;
       oqMaketArm->ParamByName("par8")->AsString= dtill;
       oqMaketArm->ParamByName("par9")->AsInteger=pData->IsMaket;

    oqMaketArm->Execute();

    SetEnabledControls();

    isChange=false;
  }catch (Exception &exception){

  	Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::edChange(TObject *Sender)
{
  isChange=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::edExit(TObject *Sender)
{
  if(isChange)
    ReadNodeInfo();
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::tbStateClick(TObject *Sender)
{
  ReadNodeInfo();
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::tbRunClick(TObject *Sender)
{
  TDateTime dt1=TDateTime::CurrentDate()-1;
  TDateTime dt2=TDateTime::CurrentDate();
  int ObjID;
  TTreeNode *Node=MaketsTree->Selected;
  //if(!(Node&&(oqMaketArm->RecordCount||((MAKET*)Node->Data)->ObjType)))
  if(!Node && ((MAKET*)Node->Data)->ObjType)
    return;
  if(((MAKET*)Node->Data)->IsMaket==1){
    if(oqMaketArm->RecordCount){
      ObjID=oqMaketArm->Fields->FieldByName("nMaket")->AsInteger;
    }else{
      if(((MAKET*)Node->Data)->ObjType==2) //&&((MAKET*)Node->Data)->IsMaket==1)
        Node=Node->Parent;
      ObjID=((MAKET*)Node->Data)->ObjID;
    }
  }else{
    ObjID=((MAKET*)Node->Data)->ObjID;
  }
  if(((MAKET*)Node->Data)->IsMaket==1)/*&&((MAKET*)Node->Data)->nPeriod!=2) */
    DeportProcedureRun(ObjID,this,1);
  else{
    dt2=dt1;
    if(!ShowDateStartFinishDialog(dt1,dt2,((MAKET*)Node->Data)->Name,this))
     return;
    else{
       oqRun->Params->Clear();
       oqRun->SQL->Text="begin "+SchemeName+"MAKETARM_PG.run_p(:par1,:par2,:par3);end;";
       oqRun->ParamByName("par1")->AsInteger= ObjID;
       oqRun->ParamByName("par2")->AsDateTime= dt1;
       oqRun->ParamByName("par3")->AsDateTime= dt2;
       oqRun->Execute();
    }
  }
  ReadNodeInfo();
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::tbMaketClick(TObject *Sender)
{
  TTreeNode *Node=MaketsTree->Selected;
  AnsiString sql,sProc,ObjName;
  TDateTime dt=Now();
  int ObjID;
  bool isLoadMaket=(((TControl*)Sender)->Tag==1);//Просмотреть сформированный макет
  try{
    edExit(NULL);
    if(!((MAKET*)Node->Data)->IsMaket&&!oqMaketArm->RecordCount)
      return;
    if(!(Node&&(oqMaketArm->RecordCount||((MAKET*)Node->Data)->ObjType)))
      return;
    if(oqMaketArm->RecordCount){
      ObjID=oqMaketArm->Fields->FieldByName("nMaket")->AsInteger;
      ObjName=oqMaketArm->Fields->FieldByName("Maket")->AsString;
      dt=oqMaketArm->Fields->FieldByName("Period")->AsDateTime;
    }else{
      if(((MAKET*)Node->Data)->ObjType==2)
        Node=Node->Parent;
      ObjID=((MAKET*)Node->Data)->ObjID;
      ObjName=AnsiString(((MAKET*)Node->Data)->Name);
      dt=TDateTime::CurrentDate()-1;
    }
    if(isLoadMaket)
      sProc="plsql1_pg.report8s_p(2)";
    else{
      if(((MAKET*)Node->Data)->IsMaket==1&&(oqMaketArm->RecordCount&&oqMaketArm->Fields->FieldByName("nPeriod")->AsInteger==7)||
         (!oqMaketArm->RecordCount&&((MAKET*)Node->Data)->nPeriod==7))
        throw Exception(Reconst_smes44_3);
      sProc="plsql3_pg.report17_p";
    }
  if(((MAKET*)Node->Data)->IsMaket==1)
   {
    if(!ShowDateDialog(dt,this))
      return;
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    dmMain->quMain->SQL->Text="begin "+SchemeName+"filereport_pg.main_p(0,"+IntToStr(ObjID)+",to_date('"+
        dt.FormatString("dd.mm.yyyy hh:nn")+"','dd.mm.yyyy hh24:mi'),to_date('"+dt.FormatString("dd.mm.yyyy hh:nn")+
        "','dd.mm.yyyy hh24:mi')+1/86400,1,'"+sProc+"'); end;";
    }
 else
 {
   //GRB ADD 16.04.2020 - test trouble ODAC
   dmMain->quMain->Params->Clear();
   //END ADD 
   if(isLoadMaket)
    dmMain->quMain->SQL->Text="begin "+SchemeName+"FILEREPORT_PG.get_value("+IntToStr(oqMaketArm->Fields->FieldByName("noperation")->AsInteger)+");end;";
   else
   {
    if(!ShowDateDialog(dt,this))
      return;
    dmMain->quMain->SQL->Text="begin "+SchemeName+"MAKETARM_PG.get_Preview("+IntToStr(oqMaketArm->Fields->FieldByName("nMaket")->AsInteger)+"  \
                               ,to_date('"+dt.FormatString("dd.mm.yyyy hh:nn")+"','dd.mm.yyyy hh24:mi'));end;";
   }
 }
    dmMain->quMain->Execute();
    TInteriorPLProc::LoadReportData(reMaket);
    lbMaketInfo->Caption=ObjName;
    if(isLoadMaket)
      lbRepName->Caption=Reconst_smes44_14+dt.FormatString("dd.mm.yyyy hh:nn");
    else
      lbRepName->Caption=Reconst_smes44_15+dt.FormatString("dd.mm.yyyy hh:nn");
    MaketInfa->ActivePage=Maket;
    reMaket->SetFocus();
    SetEnabledControls();
  }catch (Exception &exception){
  	Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::tbSendMClick(TObject *Sender)
{
  TDateTime dt;
  TTreeNode *Node=MaketsTree->Selected;
  try{
    edExit(NULL);
    if(!oqMaketArm->RecordCount)
      return;
    dt=oqMaketArm->Fields->FieldByName("Period")->AsDateTime;
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
 if(((MAKET*)Node->Data)->IsMaket==1)
    dmMain->quMain->SQL->Text="begin "+SchemeName+"MAKETARM_PG.send_maket("+oqMaketArm->Fields->FieldByName("nMaket")->AsString+
      ",to_date('"+dt.FormatString("dd.mm.yyyy hh:nn:ss")+"','dd.mm.yyyy hh24:mi:ss')); end;";
 else
    dmMain->quMain->SQL->Text="begin "+SchemeName+"MAKETARM_PG.send_UPPDmaket("+oqMaketArm->Fields->FieldByName("noperation")->AsString+" ); end;";
    dmMain->quMain->Execute();
    dmMain->orases->Commit();
    ReadNodeInfo();
  }catch (Exception &exception){
    dmMain->orases->Rollback();
  	Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::tbSaveClick(TObject *Sender)
{
  if(MaketInfa->ActivePage==Journal)
    SaveTable(this,MessageGrid,TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn:ss")+"       "+lbMaket->Caption);
  if(MaketInfa->ActivePage==Maket)
    TInteriorPLProc::UnivSaveRepToFile(SaveDialog1,reMaket);
  if((MaketInfa->ActivePage==OperWork) &&FInUn)
    FInUn->vSaveToFile(this,oqMaketArm->FieldByName("maket")->AsString+" за "+oqMaketArm->FieldByName("period")->AsString);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::tbPrintClick(TObject *Sender)
{
  if(MaketInfa->ActivePage==Maket)
    TInteriorPLProc::UnivPrintRep(this,FormSetupMonitors->RGrPrintMode->ItemIndex,reMaket);
  if(MaketInfa->ActivePage==Journal)
    PrintGrid();
  if((MaketInfa->ActivePage==OperWork) &&FInUn)
    FInUn->PrintData(this,oqMaketArm->FieldByName("maket")->AsString+" за "+oqMaketArm->FieldByName("period")->AsString);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::PrintGrid(void)
{
  TTreeNode *sNode=MaketsTree->Selected;
  if(!sNode)
    return;
  MAKET *pData=(MAKET*)sNode->Data;
  AnsiString S;
  switch(pData->ObjType){
    case 0:
    case 1:
    case 2:
      S=sNode->Text;
    break;  
  }
  PrintMessageGrid->DBGridEh->Columns->Items[0]->Visible=false;
  PrintMessageGrid->PageHeader->CenterText->Clear();
  PrintMessageGrid->PageHeader->CenterText->Add(Reconst_smes44_16+S+Reconst_smes44_17+
   dtFrom->Date.FormatString("dd.mm.yyyy ")+edFrom->Text+Reconst_smes44_18+
   dtTill->Date.FormatString("dd.mm.yyyy ")+edTill->Text);
  PrintMessageGrid->PageHeader->CenterText->Add(" ");
  PrintMessageGrid->PageHeader->RightText->Text=TDateTime::CurrentDate().FormatString("dd.mm.yyyy hh:nn:ss");
  PrintMessageGrid->Preview();
  PrintMessageGrid->DBGridEh->Columns->Items[0]->Visible=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::MaketInfaChange(TObject *Sender)
{
  SetEnabledControls();
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::SetEnabledControls(void)
{
  long ObjType=((MAKET*)MaketsTree->Selected->Data)->ObjType;
  long IsMaket=((MAKET*)MaketsTree->Selected->Data)->IsMaket;
  tbSave->Enabled=(((MaketInfa->ActivePage==Maket)&&reMaket->Lines->Count)||
                   ((MaketInfa->ActivePage==Journal)&&oqMaketArm->RecordCount)/*&&(!isViewedMaket)*/);
  tbPrint->Enabled=(((MaketInfa->ActivePage==Maket)&&reMaket->Lines->Count)||
                   ((MaketInfa->ActivePage==Journal)&&oqMaketArm->RecordCount));
  tbLoadMaket->Enabled=((oqMaketArm->RecordCount)||ObjType);
  tbPreview->Enabled=IsMaket&&(oqMaketArm->RecordCount||ObjType);
  tbSendM->Enabled=(MaketInfa->ActivePage==Journal)&&oqMaketArm->RecordCount;
  tbDel->Enabled=(Access==accWrite)&&oqMaketArm->RecordCount&&MaketInfa->ActivePage==Journal;
  if (IsMaket)
    tbRun->Enabled=((Access==accWrite)&&(oqMaketArm->RecordCount||ObjType));
  else
    tbRun->Enabled = (Access==accWrite);
  mMon->Enabled=ObjType;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption)
{
  AnsiString s,fname;
  TStringList *StringList;
  TBookmark SavePlace;
  AnsiString  tab = char(9);
  TSaveDialog *sd=new TSaveDialog(Owner);
  TDataSet  *ds = gr->DataSource->DataSet;
  if (!ds || !ds->Active){
    Application->MessageBox(Reconst_smes44_4.c_str(),Application->Title.c_str(),MB_OK | MB_ICONSTOP);
    return;
  }
  sd->Title = Reconst_smes44_5;
  sd->DefaultExt = "txt";
  sd->FileName=Reconst_smes44_6;
  sd->Filter = Reconst_smes44_7;
  sd->Options << ofOverwritePrompt;
  if(sd->Execute())
    fname=sd->FileName;
  else
    fname="";
  delete sd;
  if(fname.IsEmpty())
    return;

  try{
    StringList  = new TStringList;
    //Завголовок
    if(!RepCaption.IsEmpty())
      StringList->Add(RepCaption);
    s="";
    for (int i = 0; i < gr->Columns->Count; i++){
      if(gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
        if(!s.IsEmpty())
          s += tab;
        s+= gr->Columns->Items[i]->Title->Caption;
      }
    }
    StringList->Add(s);
    //Данные
    SavePlace = ds->GetBookmark();
    ds->DisableControls();
    ds->First();
    int cn  = 0;
    while (!ds->Eof){
      s="";
      for (int i = 0; i < gr->Columns->Count; i++){
        if (gr->Columns->Items[i]->Visible&&gr->Columns->Items[i]->Field){
          if(!s.IsEmpty())
            s += tab;
          if (gr->Columns->Items[i]->Field->DataType == ftDateTime)
            s += gr->Columns->Items[i]->Field->AsDateTime.FormatString("dd.mm.yyyy hh:nn:ss");
          else
            s += gr->Columns->Items[i]->Field->AsString;
        }
      }
      StringList->Add(s);
      cn++;
      ds->Next();
    }
    ds->GotoBookmark(SavePlace);
    ds->FreeBookmark(SavePlace);
    ds->EnableControls();
    StringList->SaveToFile(fname);
    delete  StringList;
    Application->MessageBox(AnsiString(AnsiString(Reconst_smes44_8) +
                              fname +
                              AnsiString(Reconst_smes44_9) +
                              IntToStr(cn) +
                              AnsiString(Reconst_smes44_10)).c_str(),
                            Application->Title.c_str(),
                            MB_OK | MB_ICONINFORMATION);
  }
  catch (Exception &e){
    delete  StringList;
    throw;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::mMonClick(TObject *Sender)
{
  TTreeNode* sNode = MaketsTree->Selected;
  if(sNode&&((MAKET*)sNode->Data)->ObjType)
   SetPopupMenu( Sender, ((MAKET*)sNode->Data)->ObjID,((MAKET*)sNode->Data)->Name);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::MessageGridDblClick(TObject *Sender)
{
  TTreeNode* sNode = MaketsTree->Selected;
  TPoint  tp  = MessageGrid->ScreenToClient(Mouse->CursorPos);
  TGridCoord tgc = MessageGrid->MouseCoord(tp.x, tp.y);
  if (tgc.Y < 1 || oqMaketArm->RecordCount<=0 )
    return;
  UINT uType;

  AnsiString s=Reconst_smes44_11+oqMaketArm->Fields->FieldByName("Maket")->AsString + "\"\n";
if(sNode&&((MAKET*)sNode->Data)->IsMaket==1){
  switch(oqMaketArm->Fields->FieldByName("nState")->AsInteger){
    case 0:
      uType=MB_OK	|MB_ICONWARNING;
      s=s+Reconst_smes44_12;
      break;
    case 1:
      uType=MB_OK	|MB_ICONINFORMATION;
      s=s+Reconst_smes44_13;
      break;
    default:
      uType=MB_OK	|MB_ICONSTOP;
      s=s+oqMaketArm->Fields->FieldByName("vError")->AsString;
  }
  Application->MessageBox(s.c_str(),Application->Title.c_str(),uType);
 }else{tbOperWorkClick(this);}
}
//---------------------------------------------------------------------------

void __fastcall TfmMaketArm::MessageGridDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
  if (DataCol != 0)
    return;
  MessageGrid->Canvas->FillRect(Rect);
  if(oqMaketArm->RecordCount)
    ilMenu->Draw(MessageGrid->Canvas, Rect.Left + 2, Rect.Top + 1,Column->Field->AsInteger + 82,true);
}
//---------------------------------------------------------------------------

void __fastcall TfmMaketArm::MessageGridTitleClick(TColumnEh *Column)
{
  TColumnEh *tCol = dynamic_cast<TColumnEh *>(Column);
  if (!tCol)
    return;
 // orderStr  = " order by "+IntToStr(tCol->Index+1)+" ";
  orderStr  = tCol->Index+1;
  for(int i = 0; i < MessageGrid->Columns->Count; ++i){
    if(i==tCol->Index)
      continue;
    ((TColumnEh *)MessageGrid->Columns->Items[i])->Title->SortMarker  = smNoneEh;
  }
  if (tCol->Title->SortMarker == smDownEh){
    tCol->Title->SortMarker = smUpEh;
   // orderStr+="desc ";
   orderStr=-orderStr;
  }else
    tCol->Title->SortMarker = smDownEh;
  //orderStr+=",2 desc,3,6";
  ReadNodeInfo();
}
//---------------------------------------------------------------------------


void __fastcall TfmMaketArm::tbOperWorkClick(TObject *Sender)
{
  lbMaketName->Caption=oqMaketArm->FieldByName("maket")->AsString+" за "+oqMaketArm->FieldByName("period")->AsString;
  if(!oqMaketArm->FieldByName("dsend")->AsString.IsEmpty()){
    switch (oqMaketArm->Fields->FieldByName("nState")->AsInteger){
      case 1:
        lbMaketName->Caption=lbMaketName->Caption+" Передан: "+oqMaketArm->FieldByName("dsend")->AsString;
        break;
      case 2:
        lbMaketName->Caption=lbMaketName->Caption+" Ошибка передачи: "+oqMaketArm->FieldByName("dsend")->AsString;
        break;
    }
  }else
    lbMaketName->Caption=lbMaketName->Caption+" Готов к передаче";

  SetLabelState(lbMaketState,imMaketState);



/*  if (!isViewedMaket)
    if(FInUn) delete FInUn;
  FInUn=NULL; */
  if(FInUn) delete FInUn;
 FInUn=NULL;
if(!oqMaketArm->RecordCount)  return;
   TFormDescr *fd=new TFormDescr;
   //fd=NULL;
   //GRB COMMENTED 22.06.2018
   //fd->IdGroup=oqMaketArm->Fields->FieldByName("noperation")->AsInteger;
   //fd->IsPoints=0;
   //END OF GRBCOMMENTED
  // fd->CodeTemplate=-5555;
   fd->IdFormTree=-5555;
   fd->SummGroup=false;
   fd->VerticalSplit=false;
   fd->StepProfile=31;
   //GRB ADDEDED 22.06.2018
   TStringList* maket;
   AnsiString maketType;
   TStringList* maketGroupsInfo;
   TStringList* cloneMaketGroupsInfo;

   TStringList* maketListPoints;
   if (isViewedMaket){
        fd->IdGroup=getMaketId();
        fd->IsPoints=1;
        maket = getMaketFile();
        maketType = getMaketType (maket);
        maketGroupsInfo = getGroupsInfoByMaketId (getMaketId());
        cloneMaketGroupsInfo = getGroupsInfoByMaketId (getMaketId());

        /*for (int i = 0; i < maketGroupsInfo->Count; i++ ){
        Application->MessageBox (maketGroupsInfo->Strings[i].c_str(), "Группы", MB_OK);
        } */

        maketListPoints = new TStringList();
        for (int i = 0; i < maketGroupsInfo->Count; i++){
          TStringList* splitGroupInfo = new TStringList();
          split (splitGroupInfo, maketGroupsInfo->Strings[i].c_str(), delim.c_str());
          TStringList* newPointsInfo = new TStringList();
          newPointsInfo = getPointsNameAndPointsIDByGroupId(splitGroupInfo->Strings[1]);
          for (int j = 0 ; j <newPointsInfo->Count; j++){
                maketListPoints->Add(newPointsInfo->Strings[j]);
          }
          delete newPointsInfo;
          delete splitGroupInfo;
        }

        /*for (int k = 0; k < maketListPoints->Count; k++){
          Application->MessageBox (maketListPoints->Strings[k].c_str(), "Точки", MB_OK);
        }

        AnsiString str = "";
        for (int i = 0; i < maket->Count; i++){
           str+= (maket->Strings[i]+"\r\n");
        }
        Application->MessageBox(str.c_str(), "Макетище", MB_OK);*/
   }else{
        fd->IdGroup=oqMaketArm->Fields->FieldByName("noperation")->AsInteger;
        fd->IsPoints=0;
   }
   //end of GRB ADDEDED
   fd->bird=0;
   fd->dateTimePar=oqMaketArm->Fields->FieldByName("Period")->AsDateTime;  //dfrom
   if (isViewedMaket){ //сформированный/отправленный макет которому вз-ие с бд уже не нужно, всё получено выше
        FInUn = new TfmInteriorUni(Owner,fd,maket,maketType.c_str(),maketGroupsInfo,cloneMaketGroupsInfo,maketListPoints,delim);
   }else{
        FInUn = new TfmInteriorUni(Owner,fd);
   }
   FInUn->Parent=OperWork;
   FInUn->Align=alClient;
   FInUn->vRefresh(this);
   if(!FInUn->Visible)
          FInUn->Show();
   MaketInfa->ActivePage=OperWork;
   if (isViewedMaket){
        delete maketListPoints;
        delete maketGroupsInfo;
        delete cloneMaketGroupsInfo;
        delete maket;
   }
}
//---------------------------------------------------------------------------

void __fastcall TfmMaketArm::MaketsTreeChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
  bool CanEdit=true;
  if(FInUn) FInUn->Close();
  AllowChange=CanEdit;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::MaketsTreeExpanded(TObject *Sender,
      TTreeNode *Node)
{
   if(!Node || !Node->Data || ((MAKET*)Node->Data)->ObjType!=0) return;

   bool bl = ((MAKET*)Node->Data)->Blocking;
   Node->ImageIndex = GetFolderInd(Node, bl);
   Node->SelectedIndex = Node->ImageIndex;
}
//---------------------------------------------------------------------------
int __fastcall TfmMaketArm::GetFolderInd(TTreeNode* Node, bool blocked)
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
void __fastcall TfmMaketArm::MaketsTreeExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  ReadTreeNode(Node);
}

//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::tbDelClick(TObject *Sender)
{
  AnsiString str="";
  AnsiString field="";
  TDateTime dt;
  try{
    if(MessageGrid->SelectedRows->Count > 1)
      str=Reconst_smes71_22;
    else
      str="Удалить информацию об отправке "+oqMaketArm->FieldByName("maket")->AsString+
          " за "+oqMaketArm->FieldByName("period")->AsString+"?";

    if( oqMaketArm->Fields->FieldByName("nState")->AsInteger!=1 &&
    Application->MessageBox(str.c_str(), Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){
      for (int i=0; i < MessageGrid->SelectedRows->Count; i++){
        oqMaketArm->GotoBookmark((void *)MessageGrid->SelectedRows->Items[i].c_str());
        dt=oqMaketArm->Fields->FieldByName("Period")->AsDateTime;
        field=oqMaketArm->Fields->FieldByName("noperation")->AsInteger==0?oqMaketArm->Fields->FieldByName("ndeportation")->AsString:oqMaketArm->Fields->FieldByName("noperation")->AsString;
        oqDel->SQL->Text="begin "+SchemeName+"maketarm_pg.delete_maket("+field+","+oqMaketArm->Fields->FieldByName("noperation")->AsString+",to_date('"+dt.FormatString("dd.mm.yyyy hh:nn:ss")+"','dd.mm.yyyy hh24:mi:ss')); commit; end;";
        oqDel->Execute();
      }
      oqDel->Session->Commit();
      ReadNodeInfo();

    } 
  }catch(Exception &exception){
   oqDel->Session->Rollback();
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmMaketArm::SpeedButton1Click(TObject *Sender)
{
    MaketInfa->ActivePage=Journal;
    SetEnabledControls();
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArm::SetLabelState(TLabel *lb,TImage *img)
{
  if(oqMaketArm->RecordCount){
    int i=28;
    switch(oqMaketArm->Fields->FieldByName("nState")->AsInteger){
      case 0: //Предупр
        break;
      case 1: //OK
        i+=1;
        break;
      default: //Err
        i+=2;
    }
    //btn->ImageIndex=i;
    img->Canvas->Brush->Color=clBtnFace;
    img->Canvas->FillRect(TRect(0,0,100,100));
    iImageList->Draw(img->Canvas, 2, 1,i,true);
    lb->Caption=oqMaketArm->FieldByName("verror")->AsString;
    img->Refresh();
  }
}

//---------------------------------------------------------------------------

//19.02.2020 - GRB ADD - Заплатка запрещающая перенос местами 1-го столбца таблицы (со статусом) с любым - иначе летит исключение по несовпадению типов в DrawCell
void __fastcall TfmMaketArm::MessageGridColumnMoved(TObject *Sender,
      int FromIndex, int ToIndex)
{
        if (FromIndex==0){
        MessageGrid->Columns->Items[ToIndex]->Index = FromIndex;
        return;
        }
        if (ToIndex==0){
        MessageGrid->Columns->Items[ToIndex]->Index = FromIndex;
        return;

        }
}
//---------------------------------------------------------------------------

