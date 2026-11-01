//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "InteriorJournal.h"
#include "unDataMod.h"
#include "MonitorForm.h"
#include "Filter.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
struct{int type; long mid;} filter1={0,0};
int TJournalDescr[3] = {20,150,518+sizeof(long)};
//---------------------------------------------------------------------------
__fastcall TJournalInterior::TJournalInterior(TComponent* Owner,TSplitterForm *aSP,TFormDescr* aFD,Classes::TNotifyEvent OnProgr):
	TInterior(Owner,aSP,aFD,OnProgr)
{
#define bmf (dynamic_cast<TBaseMonitorForm*>(Owner))
    bmf->MenuItemAttr->Caption = Reconst_smes116_1;
    bmf->MenuItemAttr->Enabled=true;
    bmf->MenuItemAttr->OnClick = OnClickMenuItemAttr;
    bmf->MenuItemMainGroup->Visible = false;
    bmf->MenuItemMainGroup->Enabled = false;
    bmf->MenuItemGroup->Visible = false;
    bmf->MenuItemGroup->Enabled = false;

    OnProgressBarStepBy(NULL);
    OnProgressBarStepBy(this);//10
    OnProgressBarStepBy(this);//20
    if( !dynamic_cast<TWinControl*>(Owner) )
    {
 	    OnProgressBarStepBy(NULL);
        throw(Exception(Reconst_smes116_2));
    }
    dsMessage = new TDataSource(Owner);
    dsMessage->DataSet = VT_PrintData;
    orderStr = "field1 desc"; 
#undef bmf
}
//---------------------------------------------------------------------------
/*! Отображение полного содержимого ячейки в отдельном окне.
*/
void __fastcall TJournalInterior::MessageGridDblClick(TObject *Sender)
{
  TPoint  tp  = MessageGrid->ScreenToClient(Mouse->CursorPos);
  TGridCoord  tgc = MessageGrid->MouseCoord(tp.x, tp.y);
  if (tgc.Y < 1)
    return;
  ShowMessage(VT_PrintData->Fields->Fields[1]->AsString + "\n" +
                VT_PrintData->Fields->Fields[2]->AsString + "\n" +
                VT_PrintData->Fields->Fields[3]->AsString);
}
//---------------------------------------------------------------------------
void __fastcall TJournalInterior::Place(void)
{
    try
    {
        dynamic_cast<TBaseMonitorForm*>(Owner)->Caption=fd->NameGroup+" от " + DateToStr(fd->DateTime);
        dynamic_cast<TBaseMonitorForm*>(Owner)->HelpContext=31;
      MessageGrid = new TDBGridEh(Owner);
      MessageGrid->Options  = MessageGrid->Options << dgAlwaysShowSelection >> dgIndicator >> dgEditing;
      MessageGrid->Parent = dynamic_cast<TBaseMonitorForm*>(Owner);
      MessageGrid->DataSource = dsMessage;
    	SplitterForm->AddChild(NULL,MessageGrid,alRight);
      MessageGrid->OnDblClick = MessageGridDblClick;
      MessageGrid->OnDrawColumnCell = MessageGridDrawColumnCell;
      MessageGrid->OnTitleClick = MessageGridTitleClick;
      //GRB ADD 25.02.2020 - фикс бага с вылетом по смене колонок с первой (тут и у наследника - InteriorJournalSys.cpp)
      MessageGrid->OnColumnMoved = MessageGridColumnMoved;
      //MessageGrid->Options << dgRowSelect << dgAlwaysShowSelection;
      //MessageGrid->Options >> dgIndicator >> dgEditing ;
      MessageGrid->ReadOnly = true;
        OnProgressBarStepBy(this);//30
        MessageGrid->PopupMenu = (dynamic_cast<TBaseMonitorForm*>(Owner))->PopupMenuDU;
        //GRB TEST 12.06.2020 - Убираем из пунктов доступного меню зазвернуть-свернуть по просьбе Виты
        MessageGrid->PopupMenu->Items->Items[5]->Visible = False;
       //END GRB
        MessageGrid->PopupMenu->AutoPopup = true;
        (dynamic_cast<TBaseMonitorForm*>(Owner))->PopupMenu->AutoPopup = false;
   		MessageGrid->OnEnter = OnClickPanel;
    
// -------------- Для печати -----------------------------------------------------------------------
    ColumnsCaption->Clear();
    VT_PrintData->Close();
    VT_PrintData->Clear();
    VT_PrintData->FieldDefs->Clear();

    TStringField* f = new TStringField(VT_PrintData);
    f->FieldName = "Data0";
    f->Size = 10;
    f->DisplayWidth = 2;
    f->DisplayLabel = " ";
    f->Index = 0;
    f->DataSet = VT_PrintData;
    MessageGrid->Columns->Add()->Field = f;
    MessageGrid->Columns->Items[0]->FieldName = f->FieldName;
    for(int i = 0; i<4; i++)
    {
          TStringField* f = new TStringField(VT_PrintData);
          f->FieldName = "Data"+IntToStr(i+1);
          f->Size = TJournalDescr[i];
          switch(i)
          {
             case 0: f->DisplayWidth = 17;
                     f->DisplayLabel = Reconst_smes116_3;
                     break;
             case 1: f->DisplayWidth = 35;
                     f->DisplayLabel = Reconst_smes116_4;
                     break;
             case 2: f->DisplayWidth = 147;
                     f->DisplayLabel = Reconst_smes116_5;
                     break;
          }
          f->Index = i+1;
          f->DataSet = VT_PrintData;
          MessageGrid->Columns->Add()->Field = f;
          MessageGrid->Columns->Items[i+1]->FieldName = f->FieldName;
          if (i==3)
            MessageGrid->Columns->Items[i+1]->Visible = false;
    }
    VT_PrintData->FieldDefs->Update();
    VT_PrintData->Open();
		OnProgressBarStepBy(this);//40
	 //	selectData(dmMain->qwInter);
     selectData(dmMain->oqInterCursor);
    ((TColumnEh*)MessageGrid->Columns->Items[1])->Title->SortMarker = smDownEh;
    MessageGrid->SetFocus();
    }
    catch(Exception &e)
    {
		if(MessageGrid)
		{
			SplitterForm->RemoveChild( MessageGrid );
			delete MessageGrid;
			MessageGrid=NULL;
		}
    }
    OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TJournalInterior::Destroy(void)
{
	if(MessageGrid)
	SplitterForm->RemoveChild(MessageGrid);
}
//---------------------------------------------------------------------------
__fastcall TJournalInterior::~TJournalInterior(void)
{
        //GRB TEST 12.06.2020 - Вертаем в пункты меню DU зазвернуть-свернуть на всякий случай
        MessageGrid->PopupMenu->Items->Items[5]->Visible = True;
	if(MessageGrid)
		delete MessageGrid;
	if(dsMessage)
    delete dsMessage;
}
//---------------------------------------------------------------------------
void __fastcall TJournalInterior::refreshData( int Table,TOraQuery *qwInter )
{
	if( Table==TABLE_FISCAL && TDateTime::CurrentDate()<=fd->DateTime)
	{
	 //	selectData(dmMain->qwInter);
    selectData(qwInter);
	}
}
//---------------------------------------------------------------------------
void __fastcall TJournalInterior::Invalidate( int Table )
{
}
//---------------------------------------------------------------------------
void __fastcall TJournalInterior::selectData( TOraQuery *qwInter )
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
  qwInter->SQL->Text = " begin "+SchemeName+"interior_pg.Journal_selectData_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7);end;";
  qwInter->ParamByName("par7")->DataType=ftCursor;
  qwInter->ParamByName("par7")->ParamType=ptOutput;

  qwInter->ParamByName("par1")->AsInteger= fd->IdGroup;
  qwInter->ParamByName("par2")->AsInteger=filter1.type;
  qwInter->ParamByName("par3")->AsInteger=filter1.mid;
  qwInter->ParamByName("par4")->AsString=orderStr;
  qwInter->ParamByName("par5")->AsString=SelectedDate;
  qwInter->ParamByName("par6")->AsInteger=stepProf;

  OnProgressBarStepBy(this);//60
// -------------- Для печати -----------------------------------------------------------------------

//  MessageGrid->Enabled=false;

  VT_PrintData->DisableControls();
  VT_PrintData->Clear();
  OnProgressBarStepBy(this);//70
  int i=0;

  qwInter->Execute();
  while(!qwInter->Eof){
    VT_PrintData->Append();
    if(!qwInter->FieldByName("field1")->IsNull)
      VT_PrintData->Fields->FieldByName("Data1")->AsString =qwInter->FieldByName("field1")->AsString;
    if(!qwInter->FieldByName("field2")->IsNull)
      VT_PrintData->Fields->FieldByName("Data2")->AsString =qwInter->FieldByName("field2")->AsString;
    if(!qwInter->FieldByName("field3")->IsNull)
      VT_PrintData->Fields->FieldByName("Data3")->AsString =qwInter->FieldByName("field3")->AsString;
    VT_PrintData->Fields->FieldByName("Data0")->AsString = IntToStr(qwInter->FieldByName("field0")->AsInteger);
    qwInter->Next();
    i++;
  }
  qwInter->Close();

  if(i>0){
    VT_PrintData->Post();
    VT_PrintData->First();
  }
  VT_PrintData->EnableControls();
  VT_PrintData->Open();
//  MessageGrid->Enabled=true;
//---------------------------------------------------------------------------
  OnProgressBarStepBy(this);//80
  OnProgressBarStepBy(this);//90
  OnProgressBarStepBy(this);//100
  OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TJournalInterior::MessageGridDrawColumnCell(
      TObject *Sender, const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{
    if (DataCol != 0||VT_PrintData->RecordCount==0||Column->Field->AsString=="")
        return;
    	dynamic_cast<TBaseMonitorForm*>(Owner)->ImageListTask->
        Draw(MessageGrid->Canvas, Rect.Left+2, Rect.Top+1, Column->Field->AsInteger%3,true);
}
//---------------------------------------------------------------------------
void __fastcall TJournalInterior::OnClickPanel(System::TObject* Sender)
{
	(dynamic_cast<TBaseMonitorForm*>(Owner))->FormActivate(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TJournalInterior::OnClickMenuItemAttr(TObject *Sender)
{
#define MAS_LEN 500
    TfmFilter *f = new TfmFilter(this);
    f->plMessages->Visible      = false;
    f->Panel2->Visible = false;
    f->plJournal->Visible = true;
    f->Panel4->Visible = false;
    f->Panel5->Visible = true;
    f->cbType->ItemIndex = filter1.type;
    f->cbSource->Items->AddObject(Reconst_smes116_6,(TObject*)0);


    dmMain->oqInterCursor->Params->Clear();
    dmMain->oqInterCursor->SQL->Text = " begin "+SchemeName+"interior_pg.Journal_OnClickMenuItemAttr_p(:par1);end;";
    dmMain->oqInterCursor->ParamByName("par1")->DataType=ftCursor;
    dmMain->oqInterCursor->ParamByName("par1")->ParamType=ptOutput;
    dmMain->oqInterCursor->Execute();
    int i=0;

    while(!dmMain->oqInterCursor->Eof){
     f->cbSource->Items->AddObject(dmMain->oqInterCursor->FieldByName("name")->AsString, (TObject*)dmMain->oqInterCursor->FieldByName("user_ID")->AsInteger);
     dmMain->oqInterCursor->Next();
     i++;
    }
    dmMain->oqInterCursor->Close();

    for(int i=0; i<f->cbSource->Items->Count; i++){
      if((long)f->cbSource->Items->Objects[i]==filter1.mid){
        f->cbSource->ItemIndex = i;
        break;
      }
    }

    f->ShowModal();
    if(f->ModalResult==mrOk){
        filter1.type = f->cbType->ItemIndex;
        filter1.mid = (long)f->cbSource->Items->Objects[f->cbSource->ItemIndex];
        refreshForm();
    }
    delete f;
#undef MAS_LEN
}
//---------------------------------------------------------------------------
void __fastcall TJournalInterior::SaveTableToFile(TSaveDialog *aSaveDialog)
{
    aSaveDialog->Title = Reconst_smes116_7;
    aSaveDialog->FileName = Reconst_smes116_8;
    aSaveDialog->DefaultExt = "xls";
    aSaveDialog->Filter = Reconst_smes111_35;
    if(aSaveDialog->Execute()){
        AnsiString RepTitle;
        TPrintDrawTable *PrintTable = new TPrintDrawTable(this);
        PrintTable->SaveTableToFile(dynamic_cast<TBaseMonitorForm*>(Owner)->Caption, dynamic_cast<TBaseMonitorForm*>(Owner)->LabelComment->Caption, ColumnsCaption, VT_PrintData,
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthName->Text.ToInt()+50:FormSetupMonitors->EditColorWidthDigit->Text.ToInt(),
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthDigit->Text.ToInt()-10:FormSetupMonitors->EditColorWidthName->Text.ToInt(),0,aSaveDialog->FileName,0);
        delete PrintTable;
    }
}
//---------------------------------------------------------------------------
void __fastcall TJournalInterior::MessageGridTitleClick(TColumnEh *Column)
{
  TColumnEh *tCol = dynamic_cast<TColumnEh *>(Column);
  if (!tCol)
    return;
  switch (tCol->Index)
  { case 0:
        orderStr  = "field0 ";
      break;
    case 1:
        orderStr  = "field1 ";
      break;
    case 2:
        orderStr  = "field2 ";
      break;
    case 3:
        orderStr  = "field3 ";
      break;
    case 4:
        orderStr  = "field4 ";
      break;
  }

  for (int i = 0; i < MessageGrid->Columns->Count; ++i)
  { if (i == tCol->Index)
      continue;
    ((TColumnEh *)MessageGrid->Columns->Items[i])->Title->SortMarker  = smNoneEh;
  }

  if (tCol->Title->SortMarker== smUpEh)
  {
    tCol->Title->SortMarker = smDownEh;
    orderStr  += "desc ";
  }
  else
    tCol->Title->SortMarker = smUpEh;


    selectData(dmMain->oqInterCursor);
}
//GRB ADD 25.02.2020 - фикс бага с вылетом по смене колонок с первой (тут и у наследника - InteriorJournalSys.cpp)
//---------------------------------------------------------------------------
void __fastcall TJournalInterior::MessageGridColumnMoved(TObject *Sender,
          int FromIndex, int ToIndex){
        if (FromIndex==0){
                MessageGrid->Columns->Items[ToIndex]->Index = FromIndex;
                return;
        }
        if (ToIndex==0) MessageGrid->Columns->Items[ToIndex]->Index = FromIndex;
}


