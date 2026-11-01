//---------------------------------------------------------------------------
#ifndef EditCOMportListH
#define EditCOMportListH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include <ImgList.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TFormEditCOMportList : public TMainForm
{
__published:	// IDE-managed Components
	TPanel *Panel8;
	TPanel *Panel6;
	TTreeView *TreeView1;
	TPanel *Panel5;
	TPanel *Panel9;
	TComboBox *ComboBox1;
	TPanel *Panel10;
	TPanel *Panel11;
   TLabel *Label1;
   TLabel *Label2;
   TComboBox *cbTypeList;
   TRadioGroup *RadioGroup1;
   TRadioGroup *RadioGroup2;
   TRadioGroup *RadioGroup3;
  TLabel *lTariffType;
  TComboBox *cbTariffType;
   TAction *aOneCannPol;
   TPanel *plParamBottom;
   TBitBtn *btnChanList;
  TPanel *Panel2;
  TPanel *Panel14;
  TPanel *Panel3;
  TComboBox *cbScan;
  TBitBtn *btJournal;
	void __fastcall TreeView1Change(TObject *Sender, TTreeNode *Node);
	void __fastcall RadioGroupClick(TObject *Sender);
	void __fastcall RadioGroup2Click(TObject *Sender);
	void __fastcall RadioGroup3Click(TObject *Sender);
	void __fastcall cbTypeChange(TObject *Sender);
   void __fastcall cbTypeListChange(TObject *Sender);
   void __fastcall FormShow(TObject *Sender);
   void __fastcall cbTariffTypeChange(TObject *Sender);
   void __fastcall TreeView1Deletion(TObject *Sender, TTreeNode *Node);
   void __fastcall ComboBoxChange(TObject *Sender);
   void __fastcall RadioGroup1Click(TObject *Sender);
   void __fastcall btnChanListClick(TObject *Sender);
  void __fastcall cbScanChange(TObject *Sender);
  void __fastcall btJournalClick(TObject *Sender);
private:	// User declarations
   typedef struct {
      char COM_ID[20];	   //   NUMBER,
      char NAME[12];	   //	VARCHAR2(10),
      char BAUDRATE[20];   //    - СКОРОСТЬ
      char BYTESIZE[20];   //    - ЧИСЛО БИТ
      char PARITY[20];     //    - ЧЕТНОСТЬ
      char STOPBITS[20];
      char NLINKTYPE[20];       // Ид типа соединения
      int pEdit;           //=1 new ,2-edit, 3- delete
      long nTariffType;
      int nOnlyOne;
   }COMPORTS;
   bool __fastcall LoadTariffType();
   unsigned long TreeCount;
   void __fastcall SetAccess(TAccess value);
   bool __fastcall LoadTypes(void);
  // int CurrentScan;  //выбранный опросчик
   int OldScanIndex;
public:		// User declarations
	__fastcall TFormEditCOMportList(TComponent* Owner, AnsiString, TAccess = accDenied);
   void  TreeRead();
   void  TreeWrite();
protected:
	void __fastcall vSave(TObject *Sender);
	void __fastcall vRefresh(TObject *Sender);
};
//---------------------------------------------------------------------------
#endif
