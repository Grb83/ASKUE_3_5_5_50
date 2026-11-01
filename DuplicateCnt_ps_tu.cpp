//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop                           

#include "DuplicateCnt_InputParams.h"
#include "DuplicateCnt_ps_tu.h"
#include "Reconst.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmDuplicateCnt_PS_TU *fmDuplicateCnt_PS_TU;
//---------------------------------------------------------------------------
//__fastcall TfmDuplicateCnt_PS_TU::TfmDuplicateCnt_PS_TU(TComponent* Owner,long mid)
__fastcall TfmDuplicateCnt_PS_TU::TfmDuplicateCnt_PS_TU(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmDuplicateCnt_PS_TU::bbTreeClick(TObject *Sender)
{
        GROUPDATAFORM sfd;

        sfd.gid = 0;
        sfd.type = 0;

        TfmDuplicateCnt_InputParams *PTree=new TfmDuplicateCnt_InputParams(this,&sfd);

        PTree->Caption=Reconst_smes16_1;
        PTree->paEdit->Visible = false;
        PTree->Main();
        if(PTree->ShowModal()==mrOk)
        {
                AnsiString strName=((POINTSTREEDEF*)PTree->tvMain->Selected->Data)->Name;
                RootPoint.Gid=PTree->pointPOL->gid;
                strncpy(RootPoint.Name,strName.c_str(),148);
                edTU->Text=AnsiString(RootPoint.Name)+" ("+IntToStr(RootPoint.Gid)+")";
        }                                                                                 
        delete PTree;
}
//---------------------------------------------------------------------------
void __fastcall TfmDuplicateCnt_PS_TU::bbOKClick(TObject *Sender)
{
        if(dtpFrom->Date > dtpTo->Date)
        {
            Application->MessageBox(Reconst_smes16_2.c_str(),Application->Title.c_str(),MB_ICONERROR);
            return;
        }
        if(edTU->Text.IsEmpty())
          throw Exception(Reconst_smes16_3); 
        ModalResult=mrOk;
}
//---------------------------------------------------------------------------


void __fastcall TfmDuplicateCnt_PS_TU::chbDateToClick(TObject *Sender)
{
       dtpTo->Enabled = chbDateTo->Checked;
}
//---------------------------------------------------------------------------

