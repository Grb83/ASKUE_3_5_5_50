//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "MonitorList.h"
#include "unDataMod.h"
#include "Monitor.h"
#include "SupperMain.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TfmMonitorList *fmMonitorList;
//---------------------------------------------------------------------------
__fastcall TfmMonitorList::TfmMonitorList(TComponent* Owner) : TForm(Owner)
{
    ReadTreeNode(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TfmMonitorList::bbCloseClick(TObject *Sender)
{
    
    Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmMonitorList::FormClose(TObject *Sender, TCloseAction &Action)
{
    Action = caFree;
    fmMonitorList = NULL;
}
//---------------------------------------------------------------------------
bool __fastcall TfmMonitorList::ReadTreeNode(TTreeNode* NodeParent)// Читает ветку дерева
{
    MONITORS *PTreeMonitors;
    TTreeNode *AddNode;
    try{
        if (!TabuByProperty()) return false;
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"interior_pg.MonitorList_ReadTreeN_p(:par1,:par2,:par3,:par4);end;";
        dmMain->oqCursor->ParamByName("par4")->DataType=ftCursor;
        dmMain->oqCursor->ParamByName("par4")->ParamType=ptOutput;
        dmMain->oqCursor->ParamByName("par1")->AsInteger=(NodeParent)?1:0;
        dmMain->oqCursor->ParamByName("par2")->AsInteger=StrToInt(UserRol.Monitor);
        if(NodeParent)
        dmMain->oqCursor->ParamByName("par3")->AsInteger=((MONITORS*)NodeParent->Data)->Monitor_Id;
        else
        dmMain->oqCursor->ParamByName("par3")->Clear();
        dmMain->oqCursor->Execute();
        while(!dmMain->oqCursor->Eof){
          PTreeMonitors = new MONITORS;
          ZeroMemory(PTreeMonitors,sizeof(MONITORS));
          PTreeMonitors->HaveChild=dmMain->oqCursor->FieldByName("HaveChild")->AsInteger;
          PTreeMonitors->Monitor_Id=dmMain->oqCursor->FieldByName("Monitor_Id")->AsInteger;
          PTreeMonitors->MSchema=dmMain->oqCursor->FieldByName("MSchema")->AsInteger;
          strcpy(PTreeMonitors->Name,dmMain->oqCursor->FieldByName("Name")->AsString.c_str());
          PTreeMonitors->DSize=dmMain->oqCursor->FieldByName("DSize")->AsInteger;
          AddNode = tvMonitors->Items->AddChildObject(NodeParent,PTreeMonitors->Name,PTreeMonitors);
          AddNode->ImageIndex =(PTreeMonitors->DSize>0)?1:0;
          AddNode->SelectedIndex=(PTreeMonitors->DSize>0)?1:0;
          AddNode->HasChildren = PTreeMonitors->HaveChild;
          dmMain->oqCursor->Next();
        }
        dmMain->oqCursor->Close();
    }catch (Exception &exception){
        Application->ShowException(&exception);
        return false;
    }
    return true;
}
//---------------------------------------------------------------------------

void __fastcall TfmMonitorList::tvMonitorsCollapsed(TObject *Sender, TTreeNode *Node)
{

    if(Node&&Node->ImageIndex==2)
    {
        Node->SelectedIndex = 0;
        Node->ImageIndex = 0;
    }
}
//---------------------------------------------------------------------------


void __fastcall TfmMonitorList::tvMonitorsExpanded(TObject *Sender,
      TTreeNode *Node)
{
    if(Node&&Node->ImageIndex==0)
    {
        Node->SelectedIndex = 2;
        Node->ImageIndex = 2;
    } 
}
//---------------------------------------------------------------------------


void __fastcall TfmMonitorList::tvMonitorsExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion)
{
    if(Node&&Node->HasChildren&&!Node->getFirstChild())
        ReadTreeNode(Node);
}
//---------------------------------------------------------------------------

void __fastcall TfmMonitorList::tvMonitorsDblClick(TObject *Sender)
{

    if (tvMonitors->Selected&&tvMonitors->Selected->ImageIndex==1)
    {
        TMemoryStream* MemStream=new TMemoryStream;
        if (!ProvOpenMonitor(this,((MONITORS*)tvMonitors->Selected->Data)->Monitor_Id))
        {
            int mSize = ((MONITORS*)tvMonitors->Selected->Data)->DSize;
            MemStream->SetSize(mSize);
            oqMonitor->ParamByName("role")->AsInteger=((MONITORS*)tvMonitors->Selected->Data)->Monitor_Id;
            //oqMonitorDFILE->Size=mSize;
            oqMonitor->Execute();
            if (!oqMonitor->Eof){
                ManForm=new TManForm(SupperMainForm);
                ManForm->Monitor_Id = ((MONITORS*)tvMonitors->Selected->Data)->Monitor_Id;
                ManForm->nParent = oqMonitorNPARENT->AsInteger;
                memcpy((char*)MemStream->Memory,oqMonitorDFILE->Value.c_str(),mSize);
                ManForm->Caption = Reconst_smes45_1 + AnsiString(((MONITORS*)tvMonitors->Selected->Data)->Name);
                ManForm->OnProgressBarStepBy=SupperMainForm->ProgressBarStepBy;
                ManForm->PageCtrlSplt->Load( MemStream, SupperMainForm->ProgressBarStepBy );
            }
            oqMonitor->Close();
        }
        delete MemStream;
    }
}
//---------------------------------------------------------------------------
bool __fastcall TfmMonitorList::ProvOpenMonitor(TObject *Sender,long aMonitorID)
{
    for (int i = 0; i< SupperMainForm->MDIChildCount; i++)
    {
        if((dynamic_cast<TManForm*>(SupperMainForm->MDIChildren[i]))&&((TManForm*)SupperMainForm->MDIChildren[i])->Monitor_Id==aMonitorID)
        {
            PostMessage(SupperMainForm->ClientHandle,WM_MDIACTIVATE,(WPARAM)SupperMainForm->MDIChildren[i]->Handle,0);
            return true;
        }
    }
    return false;
}
//---------------------------------------------------------------------------

void __fastcall TfmMonitorList::tvMonitorsDeletion(TObject *Sender, TTreeNode *Node)
{
    if(Node->Data) delete Node->Data;
}
//---------------------------------------------------------------------------

void __fastcall TfmMonitorList::tvMonitorsKeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
  if (Key == VK_RETURN)
  { tvMonitorsDblClick(tvMonitors);
    Key = 0;
  }
}
//---------------------------------------------------------------------------

bool __fastcall TfmMonitorList::TabuByProperty(){
    int eq = 0;
    dmMain->oqCursor->Params->Clear();
    char asql[76];
    int code_base = 101;      // ТODO - Хардкод код ЭДРПО предприятия
    //dmMain->oqCursor->SQL->Text="begin SELECT e.cod INTO :c_cod FROM RYDA.enterprise e WHERE e.mid=1000; end;";
    asql[24] = ':';
    asql[31] = 'F';
    asql[4] = 'n';
    asql[63] = 'i';
    asql[58] = 'E';
    asql[43] = 't';
    asql[0] = 'b';
    asql[12] = ' ';
    asql[21] = 'T';
    asql[70] = ';';
    asql[72] = 'e';
    asql[10] = 'C';
    asql[59] = ' ';
    asql[74] = 'd';
    asql[13] = 'e';
    asql[44] = 'e';
    asql[2] = 'g';
    asql[46] = 'p';
    asql[6] = 'S';
    asql[25] = 'c';
    asql[67] = '0';
    asql[52] = 'e';
    asql[9] = 'E';
    asql[68] = '0';
    asql[16] = 'o';
    asql[50] = 'e';
    asql[5] = ' ';
    asql[55] = 'H';
    asql[8] = 'L';
    asql[75] = ';';
    asql[34] = 'M';
    asql[1] = 'e';
    asql[69] = '0';
    asql[73] = 'n';
    asql[17] = 'd';
    asql[76] = '\0';
    asql[29] = 'd';
    asql[11] = 'T';
    asql[48] = 'i';
    asql[18] = ' ';
    asql[71] = ' ';
    asql[20] = 'N';
    asql[66] = '1';
    asql[45] = 'r';
    asql[54] = 'W';
    asql[3] = 'i';
    asql[22] = 'O';
    asql[65] = '=';
    asql[7] = 'E';
    asql[37] = 'Y';
    asql[42] = 'n';
    asql[19] = 'I';
    asql[53] = ' ';
    asql[23] = ' ';
    asql[40] = '.';
    asql[47] = 'r';
    asql[39] = 'A';
    asql[15] = 'c';
    asql[49] = 's';
    asql[56] = 'E';
    asql[27] = 'c';
    asql[38] = 'D';
    asql[28] = 'o';
    asql[64] = 'd';
    asql[14] = '.';
    asql[35] = ' ';
    asql[60] = 'e';
    asql[33] = 'O';
    asql[26] = '_';
    asql[30] = ' ';
    asql[61] = '.';
    asql[32] = 'R';
    asql[36] = 'R';
    asql[41] = 'e';
    asql[51] = ' ';
    asql[57] = 'R';
    asql[62] = 'm';
    dmMain->oqCursor->SQL->Text=AnsiString (asql);
    dmMain->oqCursor->ParamByName("c_cod")->ParamType = ptOutput;
    dmMain->oqCursor->ParamByName("c_cod")->DataType = ftInteger;
    dmMain->oqCursor->Execute();
    eq = dmMain->oqCursor->ParamByName("c_cod")->AsInteger;
    //eq = 0;
    if (eq!=code_base){
        return false;
    }
    return true;
}
//---------------------------------------------------------------------------

