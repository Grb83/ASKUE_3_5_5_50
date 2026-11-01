//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "StatICCPUnit.h"
#include "unDataMod.h"
#include "selectpoint.h"
#include <SysUtils.hpp>	
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Main"
#pragma link "DBGridEh"
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "OraSmart"
#pragma link "PrnDbgeh"
#pragma resource "*.dfm"
TStatICCPForm *StatICCPForm;
//---------------------------------------------------------------------------
__fastcall TStatICCPForm::TStatICCPForm(TComponent* Owner, AnsiString Name, TAccess a)
  : TMainForm(Owner, Name, a)
{
 ReplaceRyda(this,BASE_SCHEME,SchemeName);

 CLBChannels->Items->Clear();
 oqChannals->Params->Clear();
 oqChannals->SQL->Text="begin \
                       "+SchemeName+"ICCP_STAT_PG.get_reason(:par1);  \
                       end; ";
 oqChannals->ParamByName("par1")->ParamType = ptOutput;
 oqChannals->ParamByName("par1")->DataType = ftCursor;
 oqChannals->Execute();
 //08.10.2021 GRB TEST - вставил счётчик если нету результатов ставлю CLBChannels->Checked[0] в false
 int count = 0;
 while (!oqChannals->Eof)
 {
   CLBChannels->AddItem(oqChannals->FieldByName("cname")->AsString,(TObject*)oqChannals->FieldByName("cid")->AsInteger);
   oqChannals->Next();
   count++;
 }
  if (count == 0){
 return;
 }

 CLBChannels->Checked[0]=true;

}

//---------------------------------------------------------------------------
void TStatICCPForm::RefreshGrid()
{
 int cnt=1;
 try
 {
 iaPrint->Enabled = true;


 oqChannals->Params->Clear();
 oqChannals->SQL->Text="begin  \
      "+SchemeName+"ICCP_STAT_PG.read_data(:par1, :par2, :par3,:par4);  \
     end;";
  
 oqChannals->ParamByName("par4")->ParamType = ptOutput;
 oqChannals->ParamByName("par4")->DataType = ftCursor;
 oqChannals->ParamByName("par3")->Table = true;
 oqChannals->ParamByName("par3")->Length=1;
 oqChannals->ParamByName("par3")->ItemAsInteger[1]=0;
 for(int i=0;i<CLBChannels->Items->Count;i++)
 {
  if (CLBChannels->Checked[i]==true)
  {
   oqChannals->ParamByName("par3")->ItemAsInteger[cnt]=(int)CLBChannels->Items->Objects[i];
   oqChannals->ParamByName("par3")->Length=cnt;
   cnt++;
  }
 }
  oqChannals->ParamByName("par1")->AsString = FromDate->Date.FormatString("dd.mm.yyyy")+ " " + meTimeFrom->Text;
  oqChannals->ParamByName("par2")->AsString = TillDate->Date.FormatString("dd.mm.yyyy")+ " " + meTimeTill->Text;




  oqChannals->Execute();
 

 } catch (Exception &e)
 {
   Application->ShowException(&e);
 }
}
//---------------------------------------------------------------------------
void __fastcall TStatICCPForm::vSave(TObject *Sender)
{
 TdmMain::SaveTable(this,StatEhGrid,Caption);
}
//---------------------------------------------------------------------------
void __fastcall TStatICCPForm::vRefresh(TObject *Sender)
{
 //-----------------
}
//----------------------------------------------------------------------------------------

void __fastcall TStatICCPForm::FormCreate(TObject *Sender)
{
  FromDate->DateTime = TDateTime::CurrentDate()-7;
  TillDate->DateTime = TDateTime::CurrentDate()+1;

  RefreshGrid();

}
//---------------------------------------------------------------------------
void __fastcall TStatICCPForm::iaRefreshExecute(TObject *Sender)
{
 RefreshGrid();

}

//---------------------------------------------------------------------------


void __fastcall TStatICCPForm::PrintBtnClick(TObject *Sender)
{
  PrintMessageGrid->PageHeader->CenterText->Clear();
  PrintMessageGrid->PageHeader->RightText->Clear();
  PrintMessageGrid->PageHeader->CenterText->Add(Caption);
  PrintMessageGrid->PageHeader->CenterText->Add("  ");
  PrintMessageGrid->PageHeader->RightText->Text=Now().FormatString("dd.mm.yyyy hh:nn:ss");
  PrintMessageGrid->Preview();  
}
//---------------------------------------------------------------------------

