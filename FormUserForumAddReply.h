//---------------------------------------------------------------------------

#ifndef FormUserForumAddReplyH
#define FormUserForumAddReplyH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
class TUserForumAddReply : public TForm
{
__published:	// IDE-managed Components
  TLabel *Label1;
  TLabel *Label2;
  TLabel *replyTitle;
  TMemo *replyMessage;
  TBitBtn *buttonOK;
  TBitBtn *buttonCancel;
  TOraQuery *addReplyQuery;
  void __fastcall replyMessageChange(TObject *Sender);
  void __fastcall buttonOKClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TUserForumAddReply(TComponent* Owner);
  int topicId;
};
//---------------------------------------------------------------------------
extern PACKAGE TUserForumAddReply *UserForumAddReply;
//---------------------------------------------------------------------------
#endif
