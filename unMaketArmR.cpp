//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unMaketArmR.h"
#include <io.h>
#include <fcntl.h>
#include <sys\stat.h>
#include "InteriorPLProc.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Main"
#pragma link "DBAccess"
#pragma link "DBGridEh"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "PrnDbgeh"
#pragma resource "*.dfm"
TfmMaketArmR *fmMaketArmR;
//---------------------------------------------------------------------------
__fastcall TfmMaketArmR::TfmMaketArmR(TComponent* Owner,AnsiString Name, TAccess a)
  : TMainForm(Owner,Name, a)
{
  MessageGrid->OnDrawColumnCell = MessageGridDrawColumnCell;
  dtFrom->DateTime=TDateTime::CurrentDate()-1;
  dtTill->DateTime=TDateTime::CurrentDate()+1;
  //orderStr=" order by 3,15 desc,2,3,11 desc ";
  orderStr=" order by channel,vfilename desc,verror desc ";
  MaketInfa->ActivePage=Journal;
  ShowAction(iaDelete);
  vRefresh(this);
  for(int i = 0; i < MessageGrid->Columns->Count; ++i){
    ((TColumnEh *)MessageGrid->Columns->Items[i])->Title->SortMarker=smNoneEh;
  }
 ((TColumnEh *)MessageGrid->Columns->Items[2])->Title->SortMarker=smDownEh;
  addCheckBox1OnPanel(this);
   //07.07.2020 - GRB ADD - вычитка режима "строгости" для разбора макетов - 1 - принимать и "мусор", 2 - принимать лишь макеты с валидными данными
  int rCode = dmMain->GetTaskRights(UsCon.Role_Id, 102);  //есть ли права на запись
  //21.07.2020 - remove with block bellow
  //CheckBox1->Enabled = false; //засериваем тогда
  //21.07.2020 - BLOCK
  if (rCode != accWrite){  //раз прав нету - значит серить галку
     TCheckBox *exist =(TCheckBox *) Panel7->FindChildControl("CheckBox1");
     if (exist){
         exist->Enabled = false;
     }
  }
  //END BLOCK
  //17.07.2020 GRB ADD
  try{
  int get_regime = getStrictRegime();
  //21.07.2020 - remove with block bellow
  //CheckBox1->Checked = (bool)get_regime;
  //21.07.2020 BLOCK
  TCheckBox *exist =(TCheckBox *) Panel7->FindChildControl("CheckBox1");
  if (exist){
         exist->Checked = (bool)get_regime;
  }
  //END BLOCK
  }
  catch (Exception &ex){// в базе нету такой записи с npid = 66 или ещё что
        //21.07.2020 - remove with block bellow
        //CheckBox1->Enabled = false; //засериваем тогда
        //21.07.2020 BLOCK
        TCheckBox *exist =(TCheckBox *) Panel7->FindChildControl("CheckBox1");
        if (exist){
                exist->Enabled = false;
        }
        //END BLOCK
  }
  btnSave->Enabled = false;
  btnSave->OnClick = btnSaveClick;//а вот так криво сделано а не в панели чтобы не размножались oldCreateOrderы
  //END ADD
}
//---------------------------------------------------------------------------
__fastcall TfmMaketArmR::~TfmMaketArmR()
{
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::vRefresh(TObject* Sender)
{
  TTreeNode* Node=DeportsTree->Items->GetFirstNode();
  while(Node){
    if(Node->Data)
      delete ((MAKET*)Node->Data);
    Node->Data=NULL;
    Node=Node->GetNext();
  }
  DeportsTree->OnChange=NULL;
  DeportsTree->OnChanging=NULL;
  DeportsTree->Items->Clear();
  DeportsTree->OnChange=DeportsTreeChange;
  DeportsTree->OnChanging=DeportsTreeChanging;
  MAKET *pData=new MAKET;
  ZeroMemory(pData, sizeof(*pData));
  strcpy(pData->Name, Reconst_smes71_1.c_str());
  strcpy(pData->Name, Reconst_smes71_1.c_str());
  Node = DeportsTree->Items->AddObject(NULL,pData->Name,pData);
  Node->ImageIndex = imFolder;
  Node->SelectedIndex = imFolder;
  DeportsTree->Items->AddChildObject(Node,"0000",NULL);

  DeportsTree->Selected=DeportsTree->Items->Item[0];
  DeportsTree->Selected->Expand(false);
}
//---------------------------------------------------------------------------
bool __fastcall TfmMaketArmR::ReadTreeNode(TTreeNode *ParentNode)
{
   int ind;
   try{
      if(ParentNode->HasChildren)
        ParentNode->DeleteChildren();

    oqDeports->Params->Clear();
    oqDeports->SQL->Text="begin "+SchemeName+"MAKETRECIEVE_PG.ReadTreeNode_p(:par1,:par2); end;";
    oqDeports->ParamByName("par2")->ParamType = ptOutput;
    oqDeports->ParamByName("par2")->DataType = ftCursor;

    if(!((MAKET*)ParentNode->Data)->ObjID)
      oqDeports->ParamByName("par1")->Clear();
    else
     oqDeports->ParamByName("par1")->AsInteger= ((MAKET*)ParentNode->Data)->ObjID;


      oqDeports->Execute();
      while(!oqDeports->Eof){
        MAKET *pData=new MAKET;
        pData->ObjID=oqDeports->FieldByName("id")->AsInteger;
        pData->ObjType=oqDeports->FieldByName("ntype")->AsInteger;
        if(!oqDeports->FieldByName("vname")->IsNull)
          strcpy(pData->Name,oqDeports->FieldByName("vname")->AsString.c_str());
        pData->Blocking=oqDeports->FieldByName("nblock")->AsInteger;
        if(!oqDeports->FieldByName("verror")->IsNull)
          strcpy(pData->Error,oqDeports->FieldByName("verror")->AsString.c_str());
        TTreeNode *addNode = DeportsTree->Items->AddChildObject(ParentNode, pData->Name, pData);
        if(pData->ObjType == 1 ){
           ind = (pData->Blocking)?imBlChan:imChan;
        }else
          ind = imFolder;

        addNode->ImageIndex = ind;
        addNode->SelectedIndex = ind;

         if(oqDeports->FieldByName("HaveChild")->AsInteger==1)
            DeportsTree->Items->AddChild(addNode,"0000");
          oqDeports->Next();
      }
      //if(oqDeports->RecordCount)
       // SetIsExistsState();
      oqDeports->Close();
   }catch (Exception &exception){
  	   Application->ShowException(&exception);
      return false;
   }
   return true;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::DeportsTreeChange(TObject *Sender,
      TTreeNode *Node)
{
  TTreeNode *sNode=DeportsTree->Selected;
  MaketInfa->ActivePage=Journal;
  ReadNodeInfo();
  if( sNode->Data)
  meError->Text=((MAKET*)sNode->Data)->Error;
  else  meError->Text="";
  meError->Visible=!meError->Text.Trim().IsEmpty();
  DeportsTreeEnter(Sender);
}
//---------------------------------------------------------------------------
/*void __fastcall TfmMaketArmR::SetIsExistsState(void)
{
  TDateTime dfrom,dtill;
  MAKET *pData;
  TTreeNode* Node=DeportsTree->Items->GetFirstNode();
  if(!Node||!Node->getFirstChild()||(Node->getFirstChild()->Text=="0000"))
    return;
  SetDate(dfrom,dtill);
  oqExistsMaket->Params->Clear();
  oqExistsMaket->SQL->Text="begin "+SchemeName+"MAKETRECIEVE_PG.received_maket(:par0,to_date(:par1,'dd.mm.yyyy hh24:mi:ss'),\
                        to_date(:par2,'dd.mm.yyyy hh24:mi:ss'), :par3); end; ";

  oqExistsMaket->ParamByName("par3")->ParamType = ptOutput;
  oqExistsMaket->ParamByName("par3")->DataType = ftCursor;
  oqExistsMaket->ParamByName("par0")->AsInteger= ((MAKET*)Node->Data)->ObjID;
  oqExistsMaket->ParamByName("par1")->AsString=dfrom.FormatString("dd.mm.yyyy hh:nn:ss");
  oqExistsMaket->ParamByName("par2")->AsString=dtill.FormatString("dd.mm.yyyy hh:nn:ss");
  oqExistsMaket->Execute();
  while(Node){
    if(!(Node->Text=="0000")&&Node->Data){
      pData=(MAKET*)Node->Data;
      if(pData->ObjType==2){
        Node->ImageIndex=(pData->Blocking)?imBlMaket:imMaket;
        oqExistsMaket->First();
        while(!oqExistsMaket->Eof){
          if(pData->ObjID==oqExistsMaket->FieldByName("nmaket")->AsInteger){
            if(pData->Blocking)
              Node->ImageIndex=(oqExistsMaket->FieldByName("nstate")->AsInteger==1)?imMaketExists:imMaketVar;
            else
              Node->ImageIndex=(oqExistsMaket->FieldByName("nstate")->AsInteger==1)?imBlMaketExists:imBlMaketVar;
            break;
          }
          oqExistsMaket->Next();
        }
        Node->SelectedIndex=Node->ImageIndex;
      }
    }
    Node=Node->GetNext();
  }
  oqExistsMaket->Close();
  DeportsTree->Invalidate();
}  */
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::SetDate(TDateTime &dfrom,TDateTime &dtill)
{
  TWinControl *aControl;
  try{
    aControl=edFrom;
    StrToTime(edFrom->Text+":00");
    aControl=edTill;
    StrToTime(edTill->Text+":00");
  }catch(Exception &e){
    edFrom->Text="00:00";
    edTill->Text="00:00";
    Application->MessageBox(Reconst_smes71_5.c_str(),Application->Title.c_str(),MB_OK	|MB_ICONWARNING);
    aControl->SetFocus();
  }
  dfrom=(int)dtFrom->Date;
  dfrom=dfrom+StrToTime(edFrom->Text+":00");
  dtill=(int)dtTill->Date;
  dtill=dtill+StrToTime(edTill->Text+":00");
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::ReadNodeInfo(void)
{
 

  AnsiString sSql,sWhere,stmp;
  TDateTime dfrom,dtill;
  TTreeNode *sNode=DeportsTree->Selected;
  MAKET *pData=(MAKET*)sNode->Data;
  long ObjID=pData->ObjID;

  try{
    lbDeportation->Caption=sNode->Text;
    oqDeportInfo->DisableControls();
    oqDeportInfo->Close();
    SetDate(dfrom,dtill);
    oqDeportInfo->Close();
    oqDeportInfo->Params->Clear();
            oqDeportInfo->SQL->Text="begin "+SchemeName+"MAKETRECIEVE_PG.ReadTreeNodeInfo_p \
    (:par1,:par2,:par3, :par4,:par5,:par6,:par7 ); end;";
    oqDeportInfo->ParamByName("par7")->ParamType = ptOutput;
    oqDeportInfo->ParamByName("par7")->DataType = ftCursor;
    
    oqDeportInfo->ParamByName("par1")->AsInteger= pData->ObjType;
    if(pData->ObjID)
      oqDeportInfo->ParamByName("par2")->AsInteger=ObjID;
    else
      oqDeportInfo->ParamByName("par2")->Clear();

    oqDeportInfo->ParamByName("par3")->Table=true;
    oqDeportInfo->ParamByName("par3")->Length=1;
    oqDeportInfo->ParamByName("par3")->ItemAsInteger[1]=0;
    
    bool b=true;
    int cnt=0;
    for(int i=0;i<tbFilter->ButtonCount;i++){
      b=b&&tbFilter->Buttons[i]->Down;
      if(tbFilter->Buttons[i]->Down&&tbFilter->Buttons[i]->Tag){
        cnt++;
       oqDeportInfo->ParamByName("par3")->Length=cnt;
       oqDeportInfo->ParamByName("par3")->ItemAsInteger[cnt]=tbFilter->Buttons[i]->Tag;
      }

    }



    oqDeportInfo->ParamByName("par4")->AsString= orderStr;
    oqDeportInfo->ParamByName("par5")->AsString=dfrom.FormatString("dd.mm.yyyy hh:nn:ss");
    oqDeportInfo->ParamByName("par6")->AsString=dtill.FormatString("dd.mm.yyyy hh:nn:ss");

    oqDeportInfo->Execute();
    SetEnabledControls();
    isChange=false;
    oqDeportInfo->EnableControls();
    oqDeportInfo->First();
  }catch (Exception &exception){
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::SetEnabledControls(void)
{
 long ObjType=(DeportsTree->Selected&&DeportsTree->Selected->Data)?((MAKET*)DeportsTree->Selected->Data)->ObjType:0;
  tbSave->Enabled=(((MaketInfa->ActivePage==Maket)&&reMaket->Lines->Count)||
                   ((MaketInfa->ActivePage==Journal)&&oqDeportInfo->RecordCount) || (MaketInfa->ActivePage==OperWork /*&& fmEditMaket*/));
  tbPrint->Enabled=(((MaketInfa->ActivePage==Maket)&&reMaket->Lines->Count)||((MaketInfa->ActivePage==Journal)&&oqDeportInfo->RecordCount)||
                     (MaketInfa->ActivePage==OperWork));
//  tbReload->Enabled=((Access==accWrite)&&oqDeportInfo->RecordCount&&MaketInfa->ActivePage==Journal);
//  tbVerify->Enabled=(Access==accWrite)&&oqDeportInfo->RecordCount;
  tbLoad->Enabled=(Access==accWrite)&&oqDeportInfo->RecordCount&&oqDeportInfo->FieldByName("nstate")->AsInteger<7;
  tbPreview->Enabled=oqDeportInfo->RecordCount&&(MaketInfa->ActivePage==Journal||MaketInfa->ActivePage==OperWork);
  tbOperWork->Enabled=oqDeportInfo->RecordCount&&(MaketInfa->ActivePage==Journal||MaketInfa->ActivePage==Maket)&&oqDeportInfo->FieldByName("nstate")->AsInteger>2;
  iaDelete->Enabled=(Access==accWrite)&&oqDeportInfo->RecordCount&&
                    MaketInfa->ActivePage==Journal;
  tbLoadFromFile->Enabled=(Access==accWrite)&&ObjType&&MaketInfa->ActivePage==Journal&&ObjType==1;
  meErrorLoad->Visible=oqDeportInfo->RecordCount&&!oqDeportInfo->FieldByName("verror")->AsString.IsEmpty();
  if(meErrorLoad->Visible&&meErrorLoad->Text!=oqDeportInfo->FieldByName("verror")->AsString)
    meErrorLoad->Text=oqDeportInfo->FieldByName("verror")->AsString;
  tbNotepad->Enabled=(MaketInfa->ActivePage==Maket)&&(reMaket->Visible && reMaket->Lines->Count);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::edChange(TObject *Sender)
{
  isChange=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::edExit(TObject *Sender)
{
  if(isChange){
    ReadNodeInfo();
  //  SetIsExistsState();
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbStateClick(TObject *Sender)
{
   ReadNodeInfo();
  // SetIsExistsState();
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbSaveClick(TObject *Sender)
{
 if(MaketInfa->ActivePage==Journal)
    SaveTable(this,/*(TDBGrid*)*/MessageGrid,TDateTime::CurrentDateTime().FormatString("dd.mm.yyyy hh:nn:ss")+"       "+lbDeportation->Caption);
 if(MaketInfa->ActivePage==Maket)
    TInteriorPLProc::UnivSaveRepToFile(SaveDialog1,reMaket);
  if((MaketInfa->ActivePage == OperWork) && FInUn)
    FInUn->vSaveToFile(this,lbMaketName->Caption);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbPrintClick(TObject *Sender)
{
  //           (,(=1-Win,<>1 -DOS),)
  if(MaketInfa->ActivePage==Maket)
    TInteriorPLProc::UnivPrintRep(this,1,reMaket);
  if(MaketInfa->ActivePage==Journal)
    PrintGrid();
  if((MaketInfa->ActivePage==OperWork) &&FInUn)
    FInUn->PrintData(this,lbMaketName->Caption);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::PrintGrid(void)
{
  TTreeNode *sNode=DeportsTree->Selected;
  MAKET *pData=(MAKET*)sNode->Data;
  AnsiString S;
  switch(pData->ObjType){
    case 0:
     // if(isOldTree)
        S=Reconst_smes71_6;
    /*  else{
        if(sNode->Index == 0)
          S=Reconst_smes71_7;
        else
          S=Reconst_smes71_8;
      } */
      break;
    case 1:
      S=Reconst_smes71_9+sNode->Text;
    break;
    case 2:
      S=sNode->Text;
    break;  
  }
  PrintMessageGrid->DBGridEh->Columns->Items[0]->Visible=false;
  PrintMessageGrid->PageHeader->CenterText->Clear();
  PrintMessageGrid->PageHeader->CenterText->Add(Reconst_smes71_10+S+Reconst_smes71_11+
   dtFrom->Date.FormatString("dd.mm.yyyy ")+edFrom->Text+Reconst_smes71_12+
   dtTill->Date.FormatString("dd.mm.yyyy ")+edTill->Text);
  PrintMessageGrid->PageHeader->CenterText->Add(" ");
  PrintMessageGrid->PageHeader->RightText->Text=TDateTime::CurrentDate().FormatString("dd.mm.yyyy hh:nn:ss");
  PrintMessageGrid->Preview();
  PrintMessageGrid->DBGridEh->Columns->Items[0]->Visible=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::MaketInfaChange(TObject *Sender)
{
 SetEnabledControls();
 MessageGridEnter(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::DeportsTreeExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  if(Node && Node->Data && Node->HasChildren && Node->getFirstChild()->Text == "0000")
    ReadTreeNode(Node);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::dtChange(TObject *Sender)
{
  ReadNodeInfo();
 // SetIsExistsState();
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::MessageGridDblClick(TObject *Sender)
{
  if(!oqDeportInfo->RecordCount || oqDeportInfo->FieldByName("nstate")->AsInteger<=2)
    return;
  tbOperWorkClick(Sender);
}
//---------------------------------------------------------------------------
bool __fastcall TfmMaketArmR::ReloadMaketForm(long ObjID,long nPreview)
{
  return true;
  /*try{
    if(fmEditMaket&&(!nPreview||fmEditMaket->MaketType!=nPreview)){
      delete fmEditMaket;
      fmEditMaket=NULL;
    }
    if(!ObjID||!nPreview)
      return true;
    if(!fmEditMaket){
      switch(nPreview){
        case MAKET_TYPE_DEF:
          fmEditMaket=new TfmMaketDef(this,Access);
          break;
        case MAKET_TYPE_30817:
          fmEditMaket=new TfmMaketView(this,Access);
          break;
        default:
          return true;
      }
      fmEditMaket->Parent=OperWork;
    }
    fmEditMaket->ReloadDataR(ObjID);
    if(!fmEditMaket->Visible)
      fmEditMaket->Show();
  }catch(Exception &e){
    Application->ShowException(&e);
    return false;
  }
  return true;  */
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::DeportsTreeChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
  bool CanClose=true;
  /*if(fmEditMaket&&fmEditMaket->EditRec){
    fmEditMaket->FormCloseQuery(fmEditMaket,CanClose);
  } */
  AllowChange=CanClose;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::FormCloseQuery(TObject *Sender,
      bool &CanClose)
{
  //TfmBaseTask::FormCloseQuery(this,CanClose);
  /*if(CanClose&&fmEditMaket&&fmEditMaket->EditRec){
    fmEditMaket->FormCloseQuery(fmEditMaket,CanClose);
  } */
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::MessageGridTitleClick(TColumnEh *Column)
{
  TColumnEh *tCol = dynamic_cast<TColumnEh *>(Column);
  if (!tCol)
    return;
  orderStr  = " order by "+IntToStr(tCol->Index+1)+" ";
  for(int i = 0; i < MessageGrid->Columns->Count; ++i){
    if(i==tCol->Index)
      continue;
    ((TColumnEh *)MessageGrid->Columns->Items[i])->Title->SortMarker=smNoneEh;
  }
  if (tCol->Title->SortMarker == smDownEh){
    tCol->Title->SortMarker = smUpEh;
    orderStr+="desc ";
  }else{
    tCol->Title->SortMarker = smDownEh;
    //orderStr+="desc ";
  }
  //orderStr+=",15 desc,2,3,11 desc";
   orderStr+=",vfilename desc,verror desc ";
  ReadNodeInfo();
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::MessageGridDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
  if (DataCol != 0)
    return;
  MessageGrid->Canvas->FillRect(Rect);
  if(oqDeportInfo->RecordCount){
    int i=108;
    switch(Column->Field->AsInteger){
      case 0: //Предупр
      case 3:
      case 5:
        break;
      case 7: //OK
        i+=1;
        break;
      default: //Err
        i+=2;
    }

   ImageList1->Draw(MessageGrid->Canvas, Rect.Left + 2, Rect.Top + 1,i,true);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::oqDeportInfoAfterScroll(TDataSet *DataSet)
{
  SetEnabledControls();
  MessageGridEnter(this);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbReloadClick(TObject *Sender)
{

  long oper=oqDeportInfo->FieldByName("noperation")->AsInteger;;
  try{
    for (int i=0; i < MessageGrid->SelectedRows->Count; i++)
    {
      oqDeportInfo->GotoBookmark((void *)MessageGrid->SelectedRows->Items[i].c_str());
      oqVspom->SQL->Text="begin "+SchemeName+"maketrecieve_pg.reload_maket(:oper); end;";
      oqVspom->ParamByName("oper")->AsInteger=oqDeportInfo->FieldByName("noperation")->AsInteger;
      oqVspom->Execute();
      oqVspom->Session->Commit();
    }
    ReadNodeInfo();
   // SetIsExistsState();
    oqDeportInfo->Locate("noperation",oper,TLocateOptions()<<loPartialKey);
    if(MaketInfa->ActivePage == Maket)
      SetLabelState(lbState,imState);
    if(MaketInfa->ActivePage == OperWork)
      SetLabelState(lbMaketState,imMaketState);
  }catch(Exception &exception){
    oqVspom->Session->Rollback();
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbVerifyClick(TObject *Sender)
{
  long oper=oqDeportInfo->FieldByName("noperation")->AsInteger;
  try{
     for (int i=0; i < MessageGrid->SelectedRows->Count; i++){
      oqDeportInfo->GotoBookmark((void *)MessageGrid->SelectedRows->Items[i].c_str());
      oqVspom->SQL->Text="begin "+SchemeName+"maketrecieve_pg.verify_maket(:oper); end;";
      oqVspom->ParamByName("oper")->AsInteger=oqDeportInfo->FieldByName("noperation")->AsInteger;
      oqVspom->Execute();
      oqVspom->Session->Commit();
    }
    ReadNodeInfo();
   // SetIsExistsState();
    oqDeportInfo->Locate("noperation",oper,TLocateOptions()<<loPartialKey);
    if(MaketInfa->ActivePage == Maket)
      SetLabelState(lbState,imState);
    if(MaketInfa->ActivePage == OperWork)
      SetLabelState(lbMaketState,imMaketState);
  }catch(Exception &exception){
    oqVspom->Session->Rollback();
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbLoadClick(TObject *Sender)
{
  long oper=oqDeportInfo->FieldByName("noperation")->AsInteger;
  try{
     
    oqIsLoad->SQL->Text="begin :ret:="+SchemeName+"maketrecieve_pg.is_loaded(:oper); end;";
      oqIsLoad->ParamByName("oper")->AsInteger=oqDeportInfo->FieldByName("noperation")->AsInteger;
      oqIsLoad->ParamByName("ret")->DataType=ftInteger;
      oqIsLoad->ParamByName("ret")->ParamType=ptOutput;
      oqIsLoad->Execute();

      AnsiString text=Reconst_smes71_13+ oqDeportInfo->FieldByName("channel")->AsString +Reconst_smes71_14
                        +oqDeportInfo->FieldByName("ddate")->AsDateTime.FormatString("dd.mm.yyyy")+
                        Reconst_smes71_15;

    if(oqIsLoad->ParamByName("ret")->AsInteger&&Application->MessageBox(text.c_str(), Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDNO)
    return;


    for (int i=0; i < MessageGrid->SelectedRows->Count; i++){
      oqDeportInfo->GotoBookmark((void *)MessageGrid->SelectedRows->Items[i].c_str());
      oqVspom->SQL->Text="begin "+SchemeName+"maketrecieve_pg.load_maket(:oper); end;";
      oqVspom->ParamByName("oper")->AsInteger=oqDeportInfo->FieldByName("noperation")->AsInteger;
      oqVspom->Execute();
     oqVspom->Session->Commit();
      }

    ReadNodeInfo();
   // SetIsExistsState();
    oqDeportInfo->Locate("noperation",oper,TLocateOptions()<<loPartialKey);
    if(MaketInfa->ActivePage == Maket)
      SetLabelState(lbState,imState);
    if(MaketInfa->ActivePage == OperWork)
      SetLabelState(lbMaketState,imMaketState);

  }catch(Exception &exception){
    oqVspom->Session->Rollback();
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
/*void __fastcall TfmMaketArmR::tbOperWorkClick(TObject *Sender)
{
  if(!oqDeportInfo->RecordCount)
    return;
  ReloadMaketForm(oqDeportInfo->FieldByName("noperation")->AsInteger,MAKET_TYPE_30817);
  lbMaketName->Caption=Reconst_smes71_16+oqDeportInfo->FieldByName("ntypem")->AsString+
                       Reconst_smes71_17+oqDeportInfo->FieldByName("c_ddate")->AsString+
                       Reconst_smes71_18+oqDeportInfo->FieldByName("channel")->AsString;
  SetLabelState(lbMaketState,imMaketState);
  MaketInfa->ActivePage=OperWork;
  SetEnabledControls();
}  */
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbPreviewClick(TObject *Sender)
{
  try{
   // oqVspom->SQL->Text="select vmaket from oik.rmakets where noperation="+oqDeportInfo->FieldByName("noperation")->AsString;
    oqVspom->SQL->Text="begin "+SchemeName+"MAKETRECIEVE_PG.PreviewClick_p(:par1,:par2); end;";
    oqVspom->ParamByName("par2")->ParamType = ptOutput;
    oqVspom->ParamByName("par2")->DataType = ftCursor;
    oqVspom->ParamByName("par1")->AsInteger=oqDeportInfo->FieldByName("noperation")->AsInteger;
    oqVspom->Execute();
    reMaket->Lines->Text=oqVspom->FieldByName("vmaket")->AsString;
    oqVspom->Close();
    lbRepName->Caption=Reconst_smes71_19+oqDeportInfo->FieldByName("ntypem")->AsString+
                       Reconst_smes71_20+oqDeportInfo->FieldByName("c_ddate")->AsString+
                       Reconst_smes71_21+oqDeportInfo->FieldByName("channel")->AsString;
    SetLabelState(lbState,imState);
    MaketInfa->ActivePage=Maket;
    reMaket->SetFocus();
    SetEnabledControls();
  }catch(Exception &exception){
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::vDelete(TObject *Sender)
{
  AnsiString str="";
  try{
    if(MessageGrid->SelectedRows->Count > 1)
      str=Reconst_smes71_22;
    else
      str=Reconst_smes71_23+oqDeportInfo->FieldByName("channel")->AsString+
          Reconst_smes71_14+oqDeportInfo->FieldByName("c_dcreate")->AsString+"?";
    if(Application->MessageBox(str.c_str(), Application->Title.c_str(), MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2)==IDYES){
      for (int i=0; i < MessageGrid->SelectedRows->Count; i++){
        oqDeportInfo->GotoBookmark((void *)MessageGrid->SelectedRows->Items[i].c_str());
        oqVspom->SQL->Text="begin "+SchemeName+"maketrecieve_pg.delete_maket("+oqDeportInfo->FieldByName("noperation")->AsString +"); commit; end;";
        oqVspom->Execute();
      }
      ReadNodeInfo();
    //  SetIsExistsState();
    }
  }catch(Exception &exception){
    oqVspom->Session->Rollback();
    Application->ShowException(&exception);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbLoadFromFileClick(TObject *Sender)
{

  int oper=0;
  bool is_blob=false;
  try{
    if(OpenDialog1->Execute()){
      // находим как грузить, в BLOB или в CLOB
      oqVspom->Params->Clear();
      oqVspom->SQL->Text="begin :loadblob := "+SchemeName+"COMSRVFILE_PG.is_blobchannel(:an_cid); end;";
      oqVspom->ParamByName("an_cid")->AsInteger = ((MAKET*)DeportsTree->Selected->Data)->ObjID;
      oqVspom->ParamByName("loadblob")->ParamType = ptOutput;
      oqVspom->ParamByName("loadblob")->DataType = ftInteger;
      oqVspom->Execute();
      is_blob = (oqVspom->ParamByName("loadblob")->AsInteger == 1);

      oqVspom->Params->Clear();
      if (is_blob){
        oqVspom->SQL->Text="begin "+SchemeName+"comsrvfile_pg.load_file_b(:an_cid,:av_filename,:ad_filedate,:ab_data,:an_auto,:an_operation); end;";
        oqVspom->ParamByName("ab_data")->DataType = ftOraBlob;
        oqVspom->ParamByName("ab_data")->ParamType = ptInput;
        oqVspom->ParamByName("ab_data")->AsOraBlob->LoadFromFile(OpenDialog1->FileName);
      }else{
        oqVspom->SQL->Text="begin "+SchemeName+"comsrvfile_pg.load_file_c(:an_cid,:av_filename,:ad_filedate,:ac_data,:an_auto,:an_operation); end;";
        oqVspom->ParamByName("ac_data")->DataType = ftOraClob;
        oqVspom->ParamByName("ac_data")->ParamType = ptInput;
        oqVspom->ParamByName("ac_data")->AsOraClob->LoadFromFile(OpenDialog1->FileName);
      }
      oqVspom->ParamByName("an_cid")->AsInteger=((MAKET*)DeportsTree->Selected->Data)->ObjID;
      oqVspom->ParamByName("av_filename")->AsString=ExtractFileName(OpenDialog1->FileName);
      oqVspom->ParamByName("ad_filedate")->AsDateTime=FileDateToDateTime(FileAge(OpenDialog1->FileName));
      oqVspom->ParamByName("an_auto")->AsInteger=0;
      oqVspom->ParamByName("an_operation")->ParamType = ptOutput;
      oqVspom->ParamByName("an_operation")->DataType = ftInteger;
      oqVspom->Execute();
      oper=oqVspom->ParamByName("an_operation")->AsInteger;

      oqVspom->Session->Commit();
      oqVspom->Params->Clear();
      oqVspom->SQL->Text="begin "+SchemeName+"maketrecieve_pg.load_maket(:oper); end;";
      oqVspom->ParamByName("oper")->AsInteger=oper;
      oqVspom->Execute();
      oqVspom->Session->Commit();
    }
  }catch(Exception &exception){
    oqVspom->Session->Rollback();
    Application->ShowException(&exception);
  }
  TStringList *lst=new TStringList();
  TTreeNode* Node=DeportsTree->Selected;
  while(Node && Node->Data){
    if(Node->Level != 0)
      lst->Add(((MAKET*)Node->Data)->ObjID);
    else
      lst->Add(Node->Index);
    Node=Node->Parent;
  }
  DeportsTree->OnChange=NULL;
  DeportsTree->OnChanging=NULL;
  vRefresh(Sender);
  Node=DeportsTree->Items->Item[0];
  while(Node && Node->Index != lst->Strings[lst->Count-1]){
    Node=Node->getNextSibling();
  }
  Node->Expand(false);
  Node=Node->getFirstChild();
  for(int i=(lst->Count-2);i>=0;i--){
    while(Node && Node->Data && ((MAKET*)Node->Data)->ObjID != lst->Strings[i].ToInt()){
      Node=Node->getNextSibling();
    }
    if(Node){
      Node->Expand(false);
      if(Node->getFirstChild())
        Node=Node->getFirstChild();
      else
        break;  
    }else
      break;
  }
  if(Node)
    DeportsTree->Selected=Node;
  lst->Clear();
  delete lst;
  DeportsTree->OnChange=DeportsTreeChange;
  DeportsTree->OnChanging=DeportsTreeChanging;
  ReadNodeInfo();
 // SetIsExistsState();
  if(oper)
    oqDeportInfo->Locate("noperation",oper,TLocateOptions()<<loPartialKey);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbTreeClick(TObject *Sender)
{
  tbTree->Down=!Splitter1->Visible;
  Splitter1->Visible=tbTree->Down;
  Panel2->Visible=tbTree->Down;
}
//---------------------------------------------------------------------------

void __fastcall TfmMaketArmR::DeportsTreeEnter(TObject *Sender)
{
  int num=0,count=0;
  TTreeNode* Node;
  if(DeportsTree->Selected){
    num=DeportsTree->Selected->Index+1;
    if(DeportsTree->Selected->Level != 0)
      count=DeportsTree->Selected->Parent->Count;
    else{
      count=num-1;
      Node=DeportsTree->Selected;
      while(Node){
        count++;
        Node=Node->getNextSibling();
      }
    }
  }
  //PostMessage(Application->MainForm->Handle,WM_SETSTATUS, num,count);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::MessageGridEnter(TObject *Sender)
{
//  int num,count;
//  num=oqDeportInfo->RecNo;
//  count=oqDeportInfo->RecordCount;
  //PostMessage(Application->MainForm->Handle,WM_SETSTATUS, num,count);
}
//---------------------------------------------------------------------------

void __fastcall TfmMaketArmR::reMaketSelectionChange(TObject *Sender)
{
 // PostMessage(Application->MainForm->Handle,WM_SETSTATUS,reMaket->CaretPos.y+1,reMaket->CaretPos.x+1);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::SetLabelState(TLabel *lb,TImage *img)
{
  if(oqDeportInfo->RecordCount){
    int i=108;
    switch(oqDeportInfo->FieldByName("nstate")->AsInteger){
      case 0: //Предупр
      case 3:
      case 5:
        break;
      case 7: //OK
        i+=1;
        break;
      default: //Err
        i+=2;
    }
    //btn->ImageIndex=i;
    img->Canvas->Brush->Color=clBtnFace;
    img->Canvas->FillRect(TRect(0,0,100,100));
   // iImageList->Draw(img->Canvas, 2, 1,i,true);
    ImageList1->Draw(img->Canvas, 2, 1,i,true);
    lb->Caption=oqDeportInfo->FieldByName("vstate")->AsString;
    img->Refresh();
  }
}
//---------------------------------------------------------------------------
/*void __fastcall TfmMaketArmR::SetViewTask(TViewTask value)
{
  TfmMaketArmR::SetViewTask(value);
  isOldTree=!value.nview;
  vRefresh(this);
  TTreeNode* Node=DeportsTree->Items->Item[0];
  // nview           object         :   state (num_page)
  // 0 -channel     id_channel        1,def   - journal
  // 1 -makets      id_maket          2   -  Preview
  //                                  3   -  OperWork

  Node->Expand(false);
  Node=Node->getFirstChild();
  while(Node && Node->Data && ((MAKET*)Node->Data)->ObjID!=value.object){
    Node=Node->getNextSibling();
  }
  if(Node)
    DeportsTree->Selected=Node;
  switch(value.state){
    case 2: if(!oqDeportInfo->Eof) tbPreviewClick(tbPreview);
    break;
    case 3: if(!oqDeportInfo->Eof) tbOperWorkClick(tbOperWork);
    break;
    default:  MaketInfa->ActivePage=Journal;
  }

}  */
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbJournalClick(TObject *Sender)
{
    MaketInfa->ActivePage=Journal;
    SetEnabledControls();
}
//---------------------------------------------------------------------------

/*void __fastcall TfmMaketArmR::SetStateWindow()
{
   AnsiString RegStr="\\Software\\Grant\\Ascue\\"+ExtractFileName(Application->ExeName)+"\\Tasks";

  TRegistry *Reg = new TRegistry;
  try{
    Reg->RootKey = HKEY_CURRENT_USER;
    if (!Reg->KeyExists(RegStr)){
      if (Reg->OpenKey(RegStr, true)){
        Reg->WriteInteger("StateTree",0);
        Reg->CloseKey();
      }
    }
    if (Reg->OpenKey(RegStr, false)){
      isOldTree=!Reg->ReadInteger("StateTree");
      Reg->CloseKey();
    }
  }__finally{
    delete Reg;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::SaveStateWindow()
{

  AnsiString RegStr="\\Software\\Grant\\Ascue\\"+ExtractFileName(Application->ExeName)+"\\Tasks";
  TRegistry *Reg = new TRegistry;
  try{
    Reg->RootKey = HKEY_CURRENT_USER;
    if(Reg->OpenKey(RegStr, true)){
      Reg->WriteInteger("StateTree",isOldTree?0:1);
      Reg->CloseKey();
    }
  }__finally{
    delete Reg;
  }
}   */
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::FormClose(TObject *Sender,
      TCloseAction &Action)
{
 // SaveStateWindow();
  TMainForm::FormClose(Sender,Action);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbNotepadClick(TObject *Sender)
{
  TdmMain::SendToNotepad(reMaket);
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbTimerClick(TObject *Sender)
{
  Timer1->Enabled=tbTimer->Down;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::Timer1Timer(TObject *Sender)
{
  Timer1->Enabled=false;
  if(MaketInfa->ActivePage==Journal)
    ReadNodeInfo();
 // SetIsExistsState();
  Timer1->Enabled=tbTimer->Down;
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption)
{
  AnsiString s,fname;
  TStringList *StringList;
  TBookmark SavePlace;
  AnsiString  tab = char(9);
  TSaveDialog *sd=new TSaveDialog(Owner);
  TDataSet  *ds = gr->DataSource->DataSet;
  if (!ds || !ds->Active){
    Application->MessageBox(Reconst_smes71_24.c_str(),Application->Title.c_str(),MB_OK | MB_ICONSTOP);
    return;
  }
  sd->Title = Reconst_smes71_25;
  sd->DefaultExt = "txt";
  sd->FileName=Reconst_smes71_26;
  sd->Filter = Reconst_smes71_27;
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
    Application->MessageBox(AnsiString(Reconst_smes71_28+
                              fname +Reconst_smes71_29+IntToStr(cn) +Reconst_smes71_30).c_str(),
                            Application->Title.c_str(),
                            MB_OK | MB_ICONINFORMATION);
  }
  catch (Exception &e){
    delete  StringList;
    throw;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::tbOperWorkClick(TObject *Sender)
{
lbMaketName->Caption=Reconst_smes71_16+oqDeportInfo->FieldByName("ntypem")->AsString+
                       Reconst_smes71_17+oqDeportInfo->FieldByName("c_ddate")->AsString+
                       Reconst_smes71_18+oqDeportInfo->FieldByName("channel")->AsString;
  SetLabelState(lbMaketState,imMaketState);


if(FInUn) delete FInUn;
 FInUn=NULL;
if(!oqDeportInfo->RecordCount)  return;
   TFormDescr *fd=new TFormDescr;
   //fd=NULL;

   fd->IdGroup=oqDeportInfo->Fields->FieldByName("noperation")->AsInteger;
  // fd->CodeTemplate=-5555;
   fd->IdFormTree=-7777;
   fd->SummGroup=false;
   fd->VerticalSplit=false;
   fd->StepProfile=31;
   fd->IsPoints=0;
   fd->bird=0;
  // fd->dateTimePar=oqDeportInfo->Fields->FieldByName("Period")->AsDateTime;  //dfrom
   //GRB CHANGE 22.10.2021
   //FInUn = new TfmInteriorUni(Owner,fd);
   if (oqDeportInfo->FieldByName("ntypem")->AsString=="30902"){
        oqVspom->SQL->Text="begin "+SchemeName+"MAKETRECIEVE_PG.PreviewClick_p(:par1,:par2); end;";
        oqVspom->ParamByName("par2")->ParamType = ptOutput;
        oqVspom->ParamByName("par2")->DataType = ftCursor;
        oqVspom->ParamByName("par1")->AsInteger=oqDeportInfo->FieldByName("noperation")->AsInteger;
        oqVspom->Execute();
        oqVspom->FieldByName("vmaket")->AsString;
        TStringList* maketRow = new TStringList();
        maketRow->Text = oqVspom->FieldByName("vmaket")->AsString;
        oqVspom->Close();

        FInUn = new TfmInteriorUni(Owner,fd,true,maketRow);
        FInUn->Parent=OperWork;
        FInUn->Align=alClient;
        FInUn->vRefreshReceive30902(this);
        if(!FInUn->Visible)
                FInUn->Show();
        MaketInfa->ActivePage=OperWork;
        SetEnabledControls();
        return;
        }
   else
        FInUn = new TfmInteriorUni(Owner,fd);
   //END CHANGE
   FInUn->Parent=OperWork;
   FInUn->Align=alClient;
   FInUn->vRefresh(this);
   if(!FInUn->Visible)
          FInUn->Show();
   MaketInfa->ActivePage=OperWork;
   SetEnabledControls();
}
//-----------------------------------------------------------------------------------
//19.02.2020 - GRB ADD - Заплатка запрещающая перенос местами 1-го столбца таблицы (со статусом) с любым - иначе летит исключение по несовпадению типов в DrawCell
void __fastcall TfmMaketArmR::MessageGridColumnMoved(TObject *Sender,
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
//07.07.2020 - GRB ADD Вычитка установленного в БД параметра строгости как значения чекбокса по умолчанию
int __fastcall TfmMaketArmR::getStrictRegime(){
     int ret = -1;
      dmMain->quMain->Close();
      dmMain->quMain->SQL->Text="begin :par1:="+SchemeName+"util_pg.get_rubbish(); end;";
      dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
      dmMain->quMain->ParamByName("par1")->DataType=ftInteger;
      dmMain->quMain->Execute();
      dmMain->quMain->Session->Commit();
      if(!dmMain->quMain->ParamByName("par1")->IsNull){
        ret=dmMain->quMain->ParamByName ("par1")->AsInteger;
      }
      else{
       ret = 1;///???? зачем
       throw (Exception ("Отсутствует параметр строгости приёма макетов таблице"+SchemeName+".Parameter. Выполнение задачи невозможно"));
      }
      return ret;
}
//---------------------------------------------------------------------------
//07.07.2020 - GRB ADD Передача в БД параметра строгости как значения чекбокса
void __fastcall TfmMaketArmR::setStrictRegime(bool regime){
       //21.07.2020 - remove with block bellow
       //bool mode_maket = CheckBox1->Checked;
       //21.07.2020 - BLOCK
        bool mode_maket = false;
        TCheckBox *exist =(TCheckBox *) Panel7->FindChildControl("CheckBox1");
        if (exist){
         mode_maket =  exist->Checked;
        }
       //end block
        try{
        dmMain->quMain->Close();
        dmMain->quMain->SQL->Text="begin "+SchemeName+"admin_pg.rubbish_m(:par1); end;";
        dmMain->quMain->ParamByName("par1")->ParamType=ptInputOutput;
        dmMain->quMain->ParamByName("par1")->DataType=ftString;
        dmMain->quMain->ParamByName("par1")->AsString = IntToStr((int)mode_maket);
        dmMain->quMain->Execute();
        dmMain->quMain->Session->Commit();
        }catch (Exception &ex){
        //21.07.2020 - remove with block bellow
        //CheckBox1->Checked = !mode_maket;
        //21.07.2020 - BLOCK
        TCheckBox *exist =(TCheckBox *) Panel7->FindChildControl("CheckBox1");
        if (exist){
         exist->Checked= !mode_maket;
        }
       //end block
          AnsiString str = "Не могу вызвать admin_pg.rubbish_m. "+ex.Message;
          Application->MessageBox(str.c_str(),
                            NULL, NULL);

        }
}
//07.07.2020 - GRB ADD По нажатию на кнопку "сохранить" посылаем на базу выбранный юзером на чекбоксе уровень строгости
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::btnSaveClick(TObject *Sender)
{
        //21.07.2020 - remove with block bellow
        //bool regime = CheckBox1->Checked;
        //21.07.2020 - BLOCK
        bool regime = false;
        TCheckBox *exist =(TCheckBox *) Panel7->FindChildControl("CheckBox1");
        if (exist){
         regime= exist->Checked;
        }
       //end block
        setStrictRegime(regime);
        btnSave->Enabled = false;
}
//END ADD
//---------------------------------------------------------------------------
void __fastcall TfmMaketArmR::addCheckBox1OnPanel (TObject *Sender){
        TCheckBox *exist =(TCheckBox *) Panel7->FindChildControl("CheckBox1");
        if (!exist){
            TCheckBox *cbx = new TCheckBox (Sender);
            cbx->Parent = Panel7;
            cbx->Name = "CheckBox1";
            //Начали локализацию
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
            if (Language =="UKR") cbx->Caption = "Заборонити прийом 'чужих' макетів";
            else
            cbx->Caption = "Запретить приём 'чужих' макетов";
            cbx->Width = 241;
            cbx->Left = 384;
            cbx->Top = 9;
            cbx->Checked = false;
            cbx->OnClick = CheckBox1Click;
            }
}
//---------------------------------------------------------------------------
//07.07.2020 - GRB ADD Нажатие на чекбокс "строгости" разрешает нажимать на кнопку "Сохранить"
//---------------------------------------------------------------------------

void __fastcall TfmMaketArmR::CheckBox1Click(TObject *Sender)
{
        btnSave->Enabled = true;
}
//---------------------------------------------------------------------------





