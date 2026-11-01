//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FormUserForumViewTopic.h"
#include "FormUserForumAddReply.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TUserForumViewTopic *UserForumViewTopic = NULL;
//---------------------------------------------------------------------------
__fastcall TUserForumViewTopic::TUserForumViewTopic(TComponent* Owner)
  : TForm(Owner)
{
  topicId = 0;
  topicTitle = "";
  ModalShowed = false;
}
//---------------------------------------------------------------------------
__fastcall TUserForumViewTopic::~TUserForumViewTopic()
{
  UserForumViewTopic = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TUserForumViewTopic::UpdateReplies()
{
  receiveRepliesQuery->ParamByName("topic_id")->AsInteger = topicId;
  receiveRepliesQuery->Execute();

  int count = 0;
  count = receiveRepliesQuery->FieldByName("total_replies")->AsInteger;
  answersStaticText->Caption = IntToStr(count);
  dateStaticText->Caption = count > 0 ? (receiveRepliesQuery->FieldByName("last_reply")->AsDateTime).DateTimeString() : AnsiString("");
}
//---------------------------------------------------------------------------
void __fastcall TUserForumViewTopic::FormResize(TObject *Sender)
{
  returnButton->Left = Panel1->Width - returnButton->Width - 2;
}
//---------------------------------------------------------------------------
void __fastcall TUserForumViewTopic::returnButtonClick(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------
void __fastcall TUserForumViewTopic::FormShow(TObject *Sender)
{
  UpdateReplies();  
}
//---------------------------------------------------------------------------

void __fastcall TUserForumViewTopic::replyButtonClick(TObject *Sender)
{
	TUserForumAddReply *f = new TUserForumAddReply(this);
  f->topicId = topicId;
  f->replyTitle->Caption = topicTitle;
  f->replyMessage->Lines->Clear();
  f->buttonOK->Enabled = false;
  ModalShowed = true;
  if(f->ShowModal() == mrOk)
  { UpdateReplies();
  }
  ModalShowed = false;
  delete f;
}
//---------------------------------------------------------------------------

void __fastcall TUserForumViewTopic::FormClose(TObject *Sender,
      TCloseAction &Action)
{
  Action = caFree;
}
//---------------------------------------------------------------------------

void __fastcall TUserForumViewTopic::FormCreate(TObject *Sender)
{
  replyButton->Enabled = dmMain->GetTaskRights(UsCon.Role_Id, 104) == TASK_RIGHTS_WRITE;
}
//---------------------------------------------------------------------------

