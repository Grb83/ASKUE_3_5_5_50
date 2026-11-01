//---------------------------------------------------------------------------

#ifndef FormUserForumAddTopicH
#define FormUserForumAddTopicH
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
class TUserForumAddTopic : public TForm
{
__published:	// IDE-managed Components
  TLabel *Label1;
  TEdit *topicTitle;
  TLabel *Label2;
  TMemo *topicMessage;
  TBitBtn *buttonCancel;
  TBitBtn *buttonOK;
  TOraQuery *addTopicQuery;
  void __fastcall topicTitleChange(TObject *Sender);
  void __fastcall buttonOKClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TUserForumAddTopic(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TUserForumAddTopic *UserForumAddTopic;
//---------------------------------------------------------------------------
#endif
