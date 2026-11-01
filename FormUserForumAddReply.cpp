//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FormUserForumAddReply.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TUserForumAddReply *UserForumAddReply;
//---------------------------------------------------------------------------
__fastcall TUserForumAddReply::TUserForumAddReply(TComponent* Owner)
  : TForm(Owner)
{
  topicId = 0;
}
//---------------------------------------------------------------------------

void __fastcall TUserForumAddReply::replyMessageChange(TObject *Sender)
{
  buttonOK->Enabled = replyMessage->Text.Length() > 0;  
}
//---------------------------------------------------------------------------
void __fastcall TUserForumAddReply::buttonOKClick(TObject *Sender)
{
  addReplyQuery->ParamByName("user_name")->AsString = addReplyQuery->Session->Username;
  addReplyQuery->ParamByName("topic_id")->AsInteger = topicId;
  addReplyQuery->ParamByName("message")->AsString = replyMessage->Text;
  addReplyQuery->Execute();
}
//---------------------------------------------------------------------------
