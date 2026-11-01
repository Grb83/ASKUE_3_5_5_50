//---------------------------------------------------------------------------
#ifndef Saa_SelectGroupH
#define Saa_SelectGroupH
#define SAA_MAXCOUNTPOINTS 100
#define SAA_MAXCOUNTPATH  32
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <OleCtrls.hpp>
#include "Monitor.h"
#include <Mask.hpp>
#include <ImgList.hpp>
#include <DbOleCtl.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include <ActnList.hpp>
#include <ToolWin.hpp>

#include "FindPoint.h"
//#define WM_SETACTIVENODE1 WM_USER+2
// Add KAS 24.02.2001 ***********************************************************
AnsiString Control_Exist_File(long FID);
void ReadFile_Ex_from_DB(long FID, long F_Size, AnsiString FileName, DWORD dwLowDateTime, DWORD dwHighDateTime);
int WriteFile_Ex_to_DB(long FID, AnsiString FileName, bool autoReplace=false);
// end Add **********************************************************************
//---------------------------------------------------------------------------
class TfmSelectGroupReport : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel2;
	TPanel *Panel3;
	TBitBtn *btOk;
	TPanel *Panel4;
	TPanel *Panel5;
	TPanel *Panel6;
	TPanel *Panel7;
	TTreeView *tvMain;
	TPanel *Panel8;
	TPanel *Panel9;
	TPanel *Panel10;
	TPanel *Panel11;
	TRadioGroup *rg1;
	TPanel *Panel13;
	TImageList *ImageList1;
	TBitBtn *btCancel;
	TLabel *Label1;
     TDateTimePicker *DateTimePicker1;
        TGroupBox *GroupBox1;
        TRadioButton *RadioButton1;
        TRadioButton *RadioButton2;
        TRadioButton *RadioButton3;
  TOraQuery *oqCursor1;
  TActionList *Actions;
  TAction *acFind;
  TToolBar *ToolBar1;
  TToolButton *ToolButton1;
	void __fastcall tvMainChange(TObject *Sender, TTreeNode *Node);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall btOkClick(TObject *Sender);
	void __fastcall tvMainExpanding(TObject *Sender, TTreeNode *Node, bool &AllowExpansion);
	void __fastcall tvMainDblClick(TObject *Sender);
  void __fastcall FormKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall acFindExecute(TObject *Sender);

  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);

private:	// User declarations
	int GetRgIndex(TObject *Sender, int i);
	int GetIndexPicture(int i);
	int GetIndexPictureJournal(int i);
	void SetVisualReg(TObject *Sender); // VTR
	int SetVisualControls(TObject *Sender); // Обеспечивает доступность элементов и
	int ar_RGroup[4];                                     //возвращает загрузку более 2-го уровня, 200 - если загружаем
	bool ib_RgControl;
	bool GetAllTree(TObject *Sender);

   HCURSOR hCursor;
	TFormDescr *fd;
	virtual __fastcall TfmSelectGroupReport(TComponent* Owner):TForm(Owner){};
  TfmFindPoint *fmFP;
public:		// User declarations
	__fastcall TfmSelectGroupReport(TComponent* Owner,TFormDescr*);

  void __fastcall WM_SetActiveNode (TMessage& Message);
  BEGIN_MESSAGE_MAP
      MESSAGE_HANDLER((WM_SETACTIVENODE),TMessage, WM_SetActiveNode)
	END_MESSAGE_MAP(TForm)
};
//---------------------------------------------------------------------------
extern TfmSelectGroupReport *fmSelectGroupReport;
//---------------------------------------------------------------------------
#endif
