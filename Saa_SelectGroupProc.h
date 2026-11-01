//---------------------------------------------------------------------------
#ifndef Saa_SelectGroupProcH
#define Saa_SelectGroupProcH
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
#include <Mask.hpp>
#include <ImgList.hpp>
#include <DbOleCtl.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
class TfmSelectGroupReportProc : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel4;
	TPanel *Panel6;
	TImageList *ImageList1;
  TPanel *Panel1;
  TPanel *paDat;
  TLabel *LbLBound1;
  TDateTimePicker *DTPickDBeg1;
  TLabel *LbHBound1;
  TDateTimePicker *DTPickDEnd1;
  TMaskEdit *MEdBeg1;
  TMaskEdit *MEdEnd1;
  TTreeView *tvMain;
  TLabel *LbDate1;
  TLabel *LbTime1;
  TOraQuery *quGroupProc;
  TOraQuery *quOk;
  TPanel *paBtn;
  TBitBtn *btOk;
  TBitBtn *btCancel;
  TPanel *paAdd1;
  TLabel *LbLBound2;
  TLabel *LbHBound2;
  TLabel *LbDate2;
  TLabel *LbTime2;
  TDateTimePicker *DTPickDBeg2;
  TDateTimePicker *DTPickDEnd2;
  TMaskEdit *MEdBeg2;
  TMaskEdit *MEdEnd2;
  TPanel *paAdd2;
  TLabel *lb51Proc;
  TEdit *ed51Proc;
  TLabel *lb51Ammount;
  TEdit *ed51Ammount;
  TRadioGroup *rbEnergy;
	void __fastcall FormShow(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall tvMainDblClick(TObject *Sender);
  void __fastcall FormKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall btOkClick(TObject *Sender);
  void __fastcall tvMainExpanding(TObject *Sender, TTreeNode *Node,
          bool &AllowExpansion);
private:	// User declarations
	int GetIndexPicture(int i);
	int GetIndexPictureJournal(int i);
	int SetVisualControls(TObject *Sender); // Обеспечивает доступность элементов и
	int ar_RGroup[4];                                     //возвращает загрузку более 2-го уровня, 200 - если загружаем
	bool GetAllTree(TObject *Sender);
  HCURSOR hCursor;
	TFormDescr *fd;
	virtual __fastcall TfmSelectGroupReportProc(TComponent* Owner):TForm(Owner){};
  AnsiString GetVisibledaddparampanel(void);
  void SetAddParam(void);
public:		// User declarations
	__fastcall TfmSelectGroupReportProc(TComponent* Owner,TFormDescr*);
  bool IsTimeFields;
  bool IsSecondBound;
};
//---------------------------------------------------------------------------
extern TfmSelectGroupReportProc *fmSelectGroupReportProc;
//---------------------------------------------------------------------------
#endif
