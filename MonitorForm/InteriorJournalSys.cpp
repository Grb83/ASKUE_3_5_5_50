//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "InteriorJournalSys.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "Filter.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
int filter=0;
int adv_filter2 = 0;
AnsiString sAdvFilter;
int TJournalDescrSys[3] = {20,150,518+sizeof(long)};
AnsiString code2;
//---------------------------------------------------------------------------
__fastcall TJournalInteriorSys::TJournalInteriorSys(TComponent* Owner,TSplitterForm *aSP,TFormDescr* aFD,Classes::TNotifyEvent OnProgr):
	TJournalInterior(Owner,aSP,aFD,OnProgr )
{
}
//---------------------------------------------------------------------------

void __fastcall TJournalInteriorSys::Place(void)
{
    TJournalInterior::Place();
    try
    {
	    dynamic_cast<TBaseMonitorForm*>(Owner)->Caption = fd->NameGroup+Reconst_smes117_1 + DateToStr(fd->DateTime);
	  	dynamic_cast<TBaseMonitorForm*>(Owner)->HelpContext = 26;
      VT_PrintData->FieldByName("Data1")->DisplayWidth = 17;
      VT_PrintData->FieldByName("Data1")->DisplayLabel = Reconst_smes116_3;
      VT_PrintData->FieldByName("Data2")->DisplayWidth = 40;
      VT_PrintData->FieldByName("Data2")->DisplayLabel = Reconst_smes117_2;
      VT_PrintData->FieldByName("Data3")->DisplayWidth = 130;
      VT_PrintData->FieldByName("Data3")->DisplayLabel = Reconst_smes117_3;
      VT_PrintData->FieldByName("Data4")->DisplayWidth = 40;
      VT_PrintData->FieldByName("Data4")->DisplayLabel = Reconst_smes117_4;
      MessageGrid->Columns->Items[4]->Visible = true;
      MessageGrid->OnDrawColumnCell = MessageGridDrawColumnCell;
      MessageGrid->OnEnter=OnClickPanel;
    }
    catch(Exception &e)
    {};
}
//---------------------------------------------------------------------------

void __fastcall TJournalInteriorSys::refreshData( int Table,TOraQuery *qwInter )
{
    if( Table==TABLE_JOURNAL && TDateTime::CurrentDate()<=fd->DateTime)
    {
     //   selectData(dmMain->qwInter);
        selectData(qwInter);
    }
}
//---------------------------------------------------------------------------
void __fastcall TJournalInteriorSys::Invalidate( int Table )
{
}
//---------------------------------------------------------------------------
void __fastcall TJournalInteriorSys::selectData( TOraQuery *qwInter )
{
  int stepProf;
  unsigned short year, month, day;
	fd->DateTime.DecodeDate(&year, &month, &day);
  AnsiString SelectedDate=(TDateTime(year, month, day)).FormatString("dd'.'mm'.'yyyy hh':'nn");
    // VTR
 	switch(fd->StepProfile){
    case TFormDescr::stpMonth:
        stepProf=1;
        break;
    case TFormDescr::stpDay:
        stepProf=2;
        break;
    case TFormDescr::stpHour:
        stepProf=3;
        break;
    case TFormDescr::stpMinute:
        stepProf=4;
        break;
    default:
        stepProf=2;
  }

  OnProgressBarStepBy(this);//50

  qwInter->Params->Clear();
  qwInter->SQL->Text = " begin "+SchemeName+"interior_pg.JournalSys_selectData_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7,:par8);end;";
  qwInter->ParamByName("par8")->DataType=ftCursor;
  qwInter->ParamByName("par8")->ParamType=ptOutput;

  qwInter->ParamByName("par1")->AsInteger= fd->IdGroup;
  qwInter->ParamByName("par2")->AsInteger=filter;
  qwInter->ParamByName("par3")->AsString=code2;
  qwInter->ParamByName("par4")->AsString=orderStr;
  qwInter->ParamByName("par5")->AsString=SelectedDate;
  qwInter->ParamByName("par6")->AsInteger=stepProf;
  qwInter->ParamByName("par7")->AsInteger=adv_filter2;

  int i=0;

  selectRows=i;
  OnProgressBarStepBy(this);//60

// -------------- Для печати -----------------------------------------------------------------------
  VT_PrintData->DisableControls();
  VT_PrintData->Clear();
  OnProgressBarStepBy(this);//70
  qwInter->Execute();
  while(!qwInter->Eof){
    VT_PrintData->Append();
    if(!qwInter->FieldByName("field1")->IsNull)
      VT_PrintData->Fields->FieldByName("Data1")->AsString =qwInter->FieldByName("field1")->AsString;
    if(!qwInter->FieldByName("field2")->IsNull)
      VT_PrintData->Fields->FieldByName("Data2")->AsString =qwInter->FieldByName("field2")->AsString;
    if(!qwInter->FieldByName("field3")->IsNull)
      VT_PrintData->Fields->FieldByName("Data3")->AsString = qwInter->FieldByName("field3")->AsString;
    VT_PrintData->Fields->FieldByName("Data0")->AsString=IntToStr(qwInter->FieldByName("field0")->AsInteger);
    if(!qwInter->FieldByName("field4")->IsNull)
      VT_PrintData->Fields->FieldByName("Data4")->AsString=qwInter->FieldByName("field4")->AsString;
    qwInter->Next();
    i++;
  }
  qwInter->Close();
  if(i>0){
      VT_PrintData->Post();
      VT_PrintData->First();
  }
  VT_PrintData->EnableControls();
//---------------------------------------------------------------------------
  OnProgressBarStepBy(this);//80
  OnProgressBarStepBy(this);//90
  OnProgressBarStepBy(this);//100
  OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TJournalInteriorSys::MessageGridDrawColumnCell(
      TObject *Sender, const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
     if (DataCol != 0||VT_PrintData->RecordCount==0||Column->Field->AsString=="")
        return;
    	dynamic_cast<TBaseMonitorForm*>(Owner)->ImageListTask->
		Draw(MessageGrid->Canvas, Rect.Left+2, Rect.Top+1, GetIndexPicture(Column->Field->AsInteger),true);
}
//---------------------------------------------------------------------------
long TJournalInteriorSys::GetIndexPicture(long i)
{
    switch(i){ // установить имидж
    case -10:  return 3;
    case -100: return 4;
    case -200: return 5;
    case -300: return 6;
    case 0 :   return 7;
	default:   return 8;
    }
}
//---------------------------------------------------------------------------
void __fastcall TJournalInteriorSys::OnClickPanel(System::TObject* Sender)
{
	(dynamic_cast<TBaseMonitorForm*>(Owner))->FormActivate(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TJournalInteriorSys::OnClickMenuItemAttr(TObject *Sender)
{
#define MAS_LEN 500
    TfmFilter *f = new TfmFilter(this);
    f->plMessages->Visible      = false;
    f->Panel2->Visible = false;
    f->plJournal->Visible = true;
    f->Panel4->Visible = true;
    f->Panel5->Visible = false;
    f->lType->Caption = Reconst_smes117_5;
    f->cbType->Items->Clear();
    f->cbType->Items->Add(Reconst_smes117_6);
    f->cbType->Items->Add(Reconst_smes117_7);
    f->cbType->Items->Add(Reconst_smes117_8);
    f->cbType->ItemIndex = filter;
    f->edCode->Text = code2;
    f->edAdvFilter2->Text = sAdvFilter;
    /*f->lSource->Visible = false;
    f->cbSource->Visible = false;*/
    if (adv_filter2==0)
      f->edAdvFilter2->Text = Reconst_smes117_9;
    f->chbNot2->Checked = adv_filter2<0;
    f->ShowModal();
    if(f->ModalResult==mrOk)
    {
        filter = f->cbType->ItemIndex;
        code2 = f->edCode->Text;
        adv_filter2 = f->chbNot2->Checked?(-1)*FGid_adv:FGid_adv;
        sAdvFilter = f->edAdvFilter2->Text;
        refreshForm();
    }
    delete f;
#undef MAS_LEN
}
//---------------------------------------------------------------------------
void __fastcall TJournalInteriorSys::SaveTableToFile(TSaveDialog *aSaveDialog)
{
    aSaveDialog->Title = Reconst_smes117_10;
    aSaveDialog->FileName = Reconst_smes117_11;
    aSaveDialog->DefaultExt = "xls";
    aSaveDialog->Filter = Reconst_smes111_35;
    if(aSaveDialog->Execute())
    {
        AnsiString RepTitle;
        TPrintDrawTable *PrintTable = new TPrintDrawTable(this);
        PrintTable->SaveTableToFile(dynamic_cast<TBaseMonitorForm*>(Owner)->Caption, dynamic_cast<TBaseMonitorForm*>(Owner)->LabelComment->Caption, ColumnsCaption, VT_PrintData,
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthName->Text.ToInt()+50:FormSetupMonitors->EditColorWidthDigit->Text.ToInt(),
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthDigit->Text.ToInt()-10:FormSetupMonitors->EditColorWidthName->Text.ToInt(),0,aSaveDialog->FileName,0);
        delete PrintTable;
    }
}
//---------------------------------------------------------------------------



