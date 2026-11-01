//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "unDataMod.h"
#include "DuplicateCnt_InputParams.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmDuplicateCnt_InputParams *fmDuplicateCnt_InputParams;
//---------------------------------------------------------------------------
__fastcall TfmDuplicateCnt_InputParams::TfmDuplicateCnt_InputParams(TComponent* Owner,GROUPDATAFORM* sfd)
      	: TForm(Owner)
{                                                    
        pointPOL=sfd;
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt_InputParams::Main(void)
{
        dtpFrom->Date=Date()-1;
        dtpTo->Date=Date();
        if(!ReadNode(tvMain, NULL))
          bbOk->Enabled = false;
        else
          tvMain->Items->Item[0]->Selected = true;
}

//---------------------------------------------------------------------------
bool __fastcall TfmDuplicateCnt_InputParams::ReadNode(TObject* Sender, TObject* ParentNode)
{
	long CreatedSmb=0;//we create duplicated point or point, that has childs, that show to duplicated point
	TTreeView* tvPoints =(TTreeView*)Sender;
	TTreeNode* tnParentNode = (TTreeNode*)ParentNode;
        AnsiString sqlRoot,sqlChld;
        POINTSTREEDEF* pData;
        long id_node = 0;
        TTreeNode* Node;
        try
        {

         sqlRoot="select 1 HaveChild, p.mid, decode(p.ind,3,1,4,4,0) type, nvl(p.name,' ') name, ryda.util_pg.get_pointname(p.mid, 2) pinfo \
                  FROM ryda.points p, ryda.feeders f \
                  WHERE p.mid = 1000 \
                  and p.ind < 5 and p.mid = f.mid(+) and (f.nmainpoint is not null or p.ind <> 3) \
                  and exists (select * from ryda.points pp, ryda.feeders ff where parent=p.mid and pp.ind < 5 and pp.mid = ff.mid(+) and (ff.nmainpoint is not null or pp.ind <> 3)) \
                  union all \
                  select 0 HaveChild, p.mid, decode(p.ind,3,1,4,4,0) type, nvl(p.name,' ') name, ryda.util_pg.get_pointname(p.mid, 2) pinfo \
                  FROM ryda.points p, ryda.feeders f \
                  WHERE p.mid = 1000 \
                  and p.ind < 5 and p.mid = f.mid(+) and (f.nmainpoint is not null or p.ind <> 3) \
                  and not exists (select * from ryda.points pp, ryda.feeders ff where parent=p.mid and pp.ind < 5 and pp.mid = ff.mid(+) and (ff.nmainpoint is not null or pp.ind <> 3)) \
                  order by 3,4";

         sqlChld="select 1 HaveChild, p.mid, decode(p.ind,3,1,4,4,0) type, nvl(p.name,' ') name, ryda.util_pg.get_pointname(p.mid, 2) pinfo \
                  FROM ryda.points p, ryda.feeders f \
                  WHERE p.parent = :par1 \
                  and p.ind < 5 and p.mid = f.mid(+) and (f.nmainpoint is not null or p.ind <> 3) \
                  and exists (select * from ryda.points pp, ryda.feeders ff where parent=p.mid and pp.ind < 5 and pp.mid = ff.mid(+) and (ff.nmainpoint is not null or pp.ind <> 3)) \
                  union all \
                  select 0 HaveChild, p.mid, decode(p.ind,3,1,4,4,0) type, nvl(p.name,' ') name, ryda.util_pg.get_pointname(p.mid, 2) pinfo \
                  FROM ryda.points p, ryda.feeders f \
                  WHERE p.parent = :par1 \
                  and p.ind < 5 and p.mid = f.mid(+) and (f.nmainpoint is not null or p.ind <> 3) \
                  and not exists (select * from ryda.points pp, ryda.feeders ff where parent=p.mid and pp.ind < 5 and pp.mid = ff.mid(+) and (ff.nmainpoint is not null or pp.ind <> 3)) \
                  order by 3,4";
                  //GRB ADD 16.04.2020 - test trouble ODAC
                  dmMain->quMain->Params->Clear();
                  //END ADD 

                if(!tnParentNode)
                        dmMain->quMain->SQL->Text=sqlRoot;
                else
                {
                        dmMain->quMain->SQL->Text=sqlChld;
                        dmMain->quMain->ParamByName("par1")->AsInteger=((POINTSTREEDEF*)tnParentNode->Data)->Gid;

                }

                dmMain->quMain->Execute();
                while(!dmMain->quMain->Eof){
                pData = new POINTSTREEDEF;
                ZeroMemory(pData,sizeof(POINTSTREEDEF));
                pData->HaveChild=dmMain->quMain->FieldByName("HaveChild")->AsInteger;
                pData->Gid=dmMain->quMain->FieldByName("mid")->AsInteger;
                pData->Type=dmMain->quMain->FieldByName("type")->AsInteger;
                if(!dmMain->quMain->FieldByName("name")->IsNull)
                strcpy(pData->Name,dmMain->quMain->FieldByName("name")->AsString.c_str());
                        if(pData->Type==4) //пропускаем расчетную точку
                        {
                                id_node = ((POINTSTREEDEF*)tnParentNode->Data)->Gid;
                                ((POINTSTREEDEF*)tnParentNode->Data)->Gid = pData->Gid;
                                if(ReadNode(tvPoints,tnParentNode))
                                   CreatedSmb++;
                                ((POINTSTREEDEF*)tnParentNode->Data)->Gid = id_node;
                        }
                        else
                        {
                                Node = tvPoints->Items->AddChildObject(tnParentNode, pData->Name, pData);
                                Node->ImageIndex =(pData->Type)?0:1;
                                Node->SelectedIndex =(pData->Type)?0:1;
                                Node->HasChildren = pData->HaveChild;
                                CreatedSmb++;
                        }
                        dmMain->quMain->Next();
                   }

        }
        catch (Exception &exception)
        {
             Application->ShowException(&exception);
             return false;
        }
       return CreatedSmb;//если функция создала папку или точку возврат true
}

//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt_InputParams::tvMainChange(TObject *Sender,
      TTreeNode *Node)
{
        bbOk->Enabled=Node;
}
//---------------------------------------------------------------------------


void __fastcall TfmDuplicateCnt_InputParams::bbOkClick(TObject *Sender)
{
        if(dtpFrom->Date > dtpTo->Date)
        {
                Application->MessageBox(Reconst_smes15_1.c_str(),
                        Application->Title.c_str(),MB_ICONERROR);
                return;
        }
        pointPOL->gid = ((POINTSTREEDEF*)tvMain->Selected->Data)->Gid;
        pointPOL->type = ((POINTSTREEDEF*)tvMain->Selected->Data)->Type;
        if(!paEdit->Visible&&pointPOL->type!=1) // т.е. не точка, а при добавлении нужна точка
          throw Exception(Reconst_smes15_2);
        ModalResult=mrOk;
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt_InputParams::cbAllClick(TObject *Sender)
{
        if(cbAll->Checked)
        {
                dtFrom=dtpFrom->Date;
                dtTo=dtpTo->Date;
                dtpFrom->Date=StrToDate("01.01.1900");
                dtpTo->Date=StrToDate("31.12.9999");
        }else{
                dtpFrom->Date=dtFrom;
                dtpTo->Date=dtTo;
        }
        lbFrom->Enabled=!cbAll->Checked;
        lbTo->Enabled=!cbAll->Checked;
        dtpFrom->Enabled=!cbAll->Checked;
        dtpTo->Enabled=!cbAll->Checked;

}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt_InputParams::tvMainExpanding(
      TObject *Sender, TTreeNode *Node, bool &AllowExpansion)
{
       if(Node&&!Node->getFirstChild())
         ReadNode(tvMain, Node);
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt_InputParams::tvMainExpanded(
      TObject *Sender, TTreeNode *Node)
{
      Node->ImageIndex = 2;
      Node->SelectedIndex = 2;
}
//---------------------------------------------------------------------------

void __fastcall TfmDuplicateCnt_InputParams::tvMainCollapsed(
      TObject *Sender, TTreeNode *Node)
{
      Node->ImageIndex = 1;
      Node->SelectedIndex = 1;
}
//---------------------------------------------------------------------------

