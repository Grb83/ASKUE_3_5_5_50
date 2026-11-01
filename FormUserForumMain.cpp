//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FormUserForumMain.h"
#include "FormUserForumAddTopic.h"
#include "FormUserForumViewTopic.h"
#include "FormUserForumAddReply.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "DBGridEh"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TUserForumMain *UserForumMain = NULL;
//---------------------------------------------------------------------------
__fastcall TUserForumMain::TUserForumMain(TComponent* Owner, AnsiString Name, TAccess a)
  : TMainForm(Owner, Name, a)
{
  UserForumMain = this;
  SortOrder = -1;
  SortField = "ddate";
}
//---------------------------------------------------------------------------
__fastcall TUserForumMain::~TUserForumMain()
{
  UserForumMain = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::UpdateUserList()
{
  usersComboBox->Clear();
  usersComboBox->Items->AddObject("--- Все авторы ---", (TObject *)(Integer(0)));

  receiveUsersQuery->Execute();
  while (!receiveUsersQuery->Eof)
  {
    usersComboBox->Items->AddObject(receiveUsersQuery->FieldByName("name")->AsString, (TObject *)receiveUsersQuery->FieldByName("user_id")->AsInteger);
    receiveUsersQuery->Next();
  }
  usersComboBox->ItemIndex = 0;

  receiveUsersQuery->Close();
  UpdateData();
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::UpdateData()
{
  receiveTopicsQuery->ParamByName("user_id")->AsInteger = (int)usersComboBox->Items->Objects[usersComboBox->ItemIndex];
  receiveTopicsQuery->ParamByName("date_from")->AsDateTime = fromCalendar->DateTime;
  receiveTopicsQuery->ParamByName("date_till")->AsDateTime = tillCalendar->DateTime + 1;
  receiveTopicsQuery->ParamByName("order_by")->AsString = SortField;
  receiveTopicsQuery->ParamByName("o_direction")->AsInteger = SortOrder;
  receiveTopicsQuery->Execute();

  UpdateSortPanel();
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::usersComboBoxChange(TObject *Sender)
{
  UpdateData();
}
//---------------------------------------------------------------------------

void __fastcall TUserForumMain::fromCalendarChange(TObject *Sender)
{
  UpdateData();
}
//---------------------------------------------------------------------------

void __fastcall TUserForumMain::tillCalendarChange(TObject *Sender)
{
  UpdateData();
}
//---------------------------------------------------------------------------

void __fastcall TUserForumMain::newTopicClick(TObject *Sender)
{
	TUserForumAddTopic *f = new TUserForumAddTopic(this);
  f->topicTitle->Text = "";
  f->topicMessage->Lines->Clear();
  f->buttonOK->Enabled = false;
  if(f->ShowModal() == mrOk)
  { UpdateUserList();
  }
  delete f;
}
//---------------------------------------------------------------------------


void __fastcall TUserForumMain::topicsGridDblClick(TObject *Sender)
{
  if (receiveTopicsQuery->Eof)
    return;

  if(UserForumViewTopic == NULL)
    UserForumViewTopic = new TUserForumViewTopic(Application);

  UserForumViewTopic->Caption = "Тема: " + receiveTopicsQuery->FieldByName("vsubject")->AsString;
  UserForumViewTopic->topicAuthorLabel->Caption = receiveTopicsQuery->FieldByName("name")->AsString;
  UserForumViewTopic->topicDateLabel->Caption = (receiveTopicsQuery->FieldByName("ddate")->AsDateTime).DateTimeString();
  UserForumViewTopic->topicMessageMemo->Text = receiveTopicsQuery->FieldByName("vmessage")->AsString;
  UserForumViewTopic->topicId = receiveTopicsQuery->FieldByName("nmessage")->AsInteger;
  UserForumViewTopic->topicTitle = receiveTopicsQuery->FieldByName("vsubject")->AsString;
  UserForumViewTopic->Show();
  Timer1->Enabled = true;
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::vSave(TObject *Sender)
{
 //-----
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::vRefresh(TObject *Sender)
{
  UpdateUserList();
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::FormShow(TObject *Sender)
{
  fromCalendar->DateTime = TDateTime::CurrentDate() - 14;
  tillCalendar->DateTime = TDateTime::CurrentDate();
  SortOrder = -1;
  SortField = "ddate";
  UpdateUserList();
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::Timer1Timer(TObject *Sender)
{
  if (UserForumViewTopic == NULL)
  { UpdateData();
    Timer1->Enabled = false;
    return;
  }
  else
  { if (!UserForumViewTopic->Active && this->Active && !UserForumViewTopic->ModalShowed)
    { Timer1->Enabled = false;
      UserForumViewTopic->Close();
      UpdateData();
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::FormClose(TObject *Sender,
      TCloseAction &Action)
{
  Action = caFree;
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::UpdateSortPanel()
{
  AscImage->Visible = (SortOrder > 0);
  DescImage->Visible = (SortOrder < 0);
  int left = 14;
  for (int i = 1; i <= abs(SortOrder); i++)
  { left += topicsGrid->Columns->Items[i]->Width + 1;
  }
  left -= 17;
  SortPanel->Left = left;
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::topicsGridColWidthsChanged(TObject *Sender)
{
  UpdateSortPanel();
}
//---------------------------------------------------------------------------
int __fastcall TUserForumMain::GetOrderColumnNumber()
{
  for (int i = 1; i <= 5; i++)
  { if (topicsGrid->Columns->Items[i]->FieldName.AnsiCompareIC(SortField) == 0)
      return i;
  }
  return -1;
}
//---------------------------------------------------------------------------
void __fastcall TUserForumMain::topicsGridTitleClick(TColumnEh *Column)
{
  SortField = Column->FieldName;
  int number = GetOrderColumnNumber();
  SortOrder = (number == abs(SortOrder)) ? -SortOrder : number;
  UpdateData();
}
//---------------------------------------------------------------------------

void __fastcall TUserForumMain::FormCreate(TObject *Sender)
{
  newTopic->Enabled = dmMain->GetTaskRights(UsCon.Role_Id, 104) == TASK_RIGHTS_WRITE;  
}
//---------------------------------------------------------------------------

