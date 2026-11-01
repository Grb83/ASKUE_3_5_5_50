//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "unViewTree.h"
#include "Main.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmViewTree *fmViewTree;
//---------------------------------------------------------------------------
__fastcall TfmViewTree::TfmViewTree(TComponent* Owner, const AnsiString &Title, const long &ID, const int &Flag)
  : TForm(Owner), id(ID), flag(Flag)
{
  try
  {
  //GRB ADD 21.02.2020
  {
  oraID = new TOraNumber();
  oraFlag = new TOraNumber();
  nodeData = new TOraNumber();

  grbTestMID = new TOraNumber();
  grbHasChild = new TOraNumber();
  grbIMIND = new TOraNumber();
  }
  //end add
  Caption = Title;
  TreeView1->Images = ((TMainForm*)Owner)->iImageList;
  dmMain->oqCursor->Params->Clear();
  dmMain->oqCursor->SQL->Text = "begin "+SchemeName+"un_main_pg.ShowChannelList2(:par1, :par2, :FLAG, :par3); end;";
  dmMain->oqCursor->ParamByName("par3")->ParamType = ptOutput;
  dmMain->oqCursor->ParamByName("par3")->DataType  = ftCursor;
  ReadTreeOccurr(NULL);
  }// end try
  catch(Exception&e)
  {
    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfmViewTree::TreeView1Expanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
  dmMain->oqCursor->Params->Clear();
  dmMain->oqCursor->SQL->Text = "begin "+SchemeName+"un_main_pg.ShowChannelList2(:par1, :par2, :FLAG, :par3); end;";
  dmMain->oqCursor->ParamByName("par3")->ParamType = ptOutput;
  dmMain->oqCursor->ParamByName("par3")->DataType  = ftCursor;

  ReadTreeOccurr(Node);
}
//---------------------------------------------------------------------------

void __fastcall TfmViewTree::TreeView1Changing(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
  if(Node->Data)
    IDObj->Text = (int)Node->Data;
}
//---------------------------------------------------------------------------

void 	__fastcall TfmViewTree::ReadTreeOccurr(TTreeNode* Node)
{
  if(!Node)
  {
    //GRB ADD 21.02.2020
    {
    oraID->AsInteger = id;
    dmMain->oqCursor->ParamByName("par1")->AsNumber=oraID;
    }
    //END ADD
    //GRB COMMENT 21.02.2020
    //dmMain->oqCursor->ParamByName("par1")->AsInteger = id;

    dmMain->oqCursor->ParamByName("par2")->Clear();
  }
  else if(Node->getFirstChild()->Text == "1") //вызывается при Expanding
  {
    //GRB ADD 21.02.2020
    {
    oraID->AsInteger = id;
    //ТУТ ВЫЛЕТЫ!
    dmMain->oqCursor->ParamByName("par1")->AsNumber=oraID;
    nodeData->AsInteger = (int)Node->Data;
    dmMain->oqCursor->ParamByName("par2")->AsNumber = nodeData;
    }
    //END ADD
    //GRB COMMENT 21.02.2020
    //dmMain->oqCursor->ParamByName("par1")->AsInteger = id;
    //dmMain->oqCursor->ParamByName("par2")->AsInteger = (int)Node->Data;
    Node->DeleteChildren();
  }
  else
    return; //если все построено
    //GRB ADD 21.02.2020
   {
   oraFlag->AsInteger = flag;
   dmMain->oqCursor->ParamByName("FLAG")->AsNumber = oraFlag;
   }
  //GRB COMMENT 21.02.2020
  //dmMain->oqCursor->ParamByName("FLAG")->AsInteger = flag;
  dmMain->oqCursor->Execute();
  dmMain->oqCursor->First();
  TTreeNode *CurrNode = NULL;
  while(!dmMain->oqCursor->Eof)
  {
    //24.02.2020 GRB ADD test
    //grbTestMID = new TOraNumber();  ->moved into constructor
    grbTestMID->AsInteger = dmMain->oqCursor->FieldByName("MID")->AsInteger;
    CurrNode = TreeView1->Items->AddChildObject(Node,
                                                  dmMain->oqCursor->FieldByName("VNAME")->AsString,
                                                  (void*)grbTestMID->AsInteger);
    //end add
    /*CurrNode = TreeView1->Items->AddChildObject(Node,
                                                  dmMain->oqCursor->FieldByName("VNAME")->AsString,
                                                  (void*)dmMain->oqCursor->FieldByName("MID")->AsInteger);    */
    //grbHasChild = new TOraNumber(); ->moved into constructor
    grbHasChild->AsInteger  = dmMain->oqCursor->FieldByName("HAVECHILDE")->AsInteger;
    //if(1 == dmMain->oqCursor->FieldByName("HAVECHILDE")->AsInteger)
    if (1 == grbHasChild->AsInteger)
      TreeView1->Items->AddChildObject(CurrNode,"1", NULL);
    //CurrNode->ImageIndex    = dmMain->oqCursor->FieldByName("IMIND")->AsInteger;
    //grbIMIND = new TOraNumber();  ->moved into constructor
    grbIMIND->AsInteger = dmMain->oqCursor->FieldByName("IMIND")->AsInteger;
    CurrNode->ImageIndex = grbIMIND->AsInteger;
    CurrNode->StateIndex    = CurrNode->ImageIndex;
    CurrNode->SelectedIndex = CurrNode->ImageIndex;
    dmMain->oqCursor->Next();
  }//end while
}
//---------------------------------------------------------------------------

void __fastcall TfmViewTree::FormClose(TObject *Sender,
      TCloseAction &Action)
{
  /*if (oraID!=NULL)
        delete oraID;
  if (oraFlag!=NULL)
        delete oraFlag;
  if (nodeData!=NULL)
        delete nodeData;
  if (grbTestMID!=NULL)
        delete grbTestMID;
  if (grbHasChild!=NULL)
        delete grbHasChild;
  if (grbIMIND!=NULL)
        delete grbIMIND;  */

}
//---------------------------------------------------------------------------

