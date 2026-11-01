//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FormUserForumAddTopic.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
TUserForumAddTopic *UserForumAddTopic;
//---------------------------------------------------------------------------
__fastcall TUserForumAddTopic::TUserForumAddTopic(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TUserForumAddTopic::topicTitleChange(TObject *Sender)
{
  buttonOK->Enabled = (topicTitle->Text.Length() > 0);
}
//---------------------------------------------------------------------------
void __fastcall TUserForumAddTopic::buttonOKClick(TObject *Sender)
{
  addTopicQuery->ParamByName("user_name")->AsString = addTopicQuery->Session->Username;
  addTopicQuery->ParamByName("subject")->AsString = topicTitle->Text;
  addTopicQuery->ParamByName("message")->AsString = topicMessage->Text;
  addTopicQuery->Execute();
}
//---------------------------------------------------------------------------
