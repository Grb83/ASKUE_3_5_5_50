//---------------------------------------------------------------------------

#ifndef FormUserForumViewTopicH
#define FormUserForumViewTopicH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include "DBAccess.hpp"
#include "unDataMod.h"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include <dbcgrids.hpp>
#include <DBCtrls.hpp>
//---------------------------------------------------------------------------
class TUserForumViewTopic : public TForm
{
__published:	// IDE-managed Components
  TBitBtn *replyButton;
  TLabel *Label1;
  TStaticText *answersStaticText;
  TLabel *Label2;
  TPanel *Panel1;
  TStaticText *dateStaticText;
  TBitBtn *returnButton;
  TOraQuery *receiveRepliesQuery;
  TDBCtrlGrid *dataGrid;
  TOraDataSource *receiveRepliesDataSource;
  TDBMemo *messageMemo;
  TDBText *authorNameText;
  TDBText *dateText;
  TPanel *Panel2;
  TLabel *topicAuthorLabel;
  TLabel *topicDateLabel;
  TMemo *topicMessageMemo;
  TPanel *Panel3;
  TPanel *Panel4;
  void __fastcall FormResize(TObject *Sender);
  void __fastcall returnButtonClick(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall replyButtonClick(TObject *Sender);
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
  void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
  void __fastcall UpdateReplies();
public:		// User declarations
  __fastcall TUserForumViewTopic(TComponent* Owner);
  __fastcall ~TUserForumViewTopic();
  int topicId;
  AnsiString topicTitle;
  bool ModalShowed;
};
//---------------------------------------------------------------------------
extern PACKAGE TUserForumViewTopic *UserForumViewTopic;
//---------------------------------------------------------------------------
#endif
