//---------------------------------------------------------------------------

#ifndef unViewTreeH
#define unViewTreeH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>

#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
//---------------------------------------------------------------------------
class TfmViewTree : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TBitBtn *BtnOK;
  TBitBtn *BtnCancel;
  TLabel *Label1;
  TEdit *IDObj;
  TTreeView *TreeView1;
  void __fastcall TreeView1Expanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
  void __fastcall TreeView1Changing(TObject *Sender, TTreeNode *Node,
          bool &AllowChange);
        void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
private:	// User declarations
 const long id, flag;
   //GRB ADD 21.02.2020
  TOraNumber *oraID;
  TOraNumber *oraFlag;
  TOraNumber *nodeData;
  TOraNumber *grbTestMID;
  TOraNumber *grbHasChild;
  TOraNumber *grbIMIND;
 public:		// User declarations
  void __fastcall ReadTreeOccurr(TTreeNode* Node);
  __fastcall TfmViewTree(TComponent* Owner, const AnsiString &Title, const long &ID, const int &Flag);

};
//---------------------------------------------------------------------------
extern PACKAGE TfmViewTree *fmViewTree;
//---------------------------------------------------------------------------
#endif
