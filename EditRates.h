//---------------------------------------------------------------------------
#ifndef EditRatesH
#define EditRatesH
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
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include "OraSmart.hpp"
//---------------------------------------------------------------------------
#define RATE_SIZE  250
#define RATE_MAX  25
//---------------------------------------------------------------------------
class TFormEditRates : public TMainForm
{
__published:	// IDE-managed Components
   TPanel *Panel5;
   TListView *TreeView;
   TPanel *Panel7;
   TBitBtn *AddRateBB;
   TBitBtn *DelRateBB;
   TPanel *Panel8;
   TPanel *Panel9;
   TBitBtn *AddZoneBB;
   TBitBtn *DelZoneBB;
   TListView *DrawTable;
   TDateTimePicker *TimeDTP;
   TDateTimePicker *DateDTP;
   TComboBox *RateCB;
   TActionList *ActionList1;
   TAction *aAddRate;
   TAction *aDelRate;
   TAction *aAddZone;
   TAction *aDelZone;
  TBitBtn *btnClone;
  TOraQuery *oqTreeWrite;
  TPanel *Panel1;
  TComboBox *cbZone;
  TSmartQuery *oqZone;
  TSmartQuery *oqDates;
  TSmartQuery *oqTime;
  TSmartQuery *oqUpdate;
  TSmartQuery *oqInsert;
  TSmartQuery *oqDelete;
  TSmartQuery *oqClone;
	void __fastcall TreeViewChange(TObject *Sender, TListItem *Item, TItemChange Change);
   void __fastcall DelRateBBClick(TObject *Sender);
   void __fastcall AddRateBBClick(TObject *Sender);
   void __fastcall DelZoneBBClick(TObject *Sender);
   void __fastcall AddZoneBBClick(TObject *Sender);
   void __fastcall FormShow(TObject *Sender);
   void __fastcall TreeViewEditing(TObject *Sender, TListItem *Item,
          bool &AllowEdit);
   void __fastcall DateDTPExit(TObject *Sender);
   void __fastcall DrawTableEditing(TObject *Sender, TListItem *Item,
          bool &AllowEdit);
   void __fastcall TimeDTPExit(TObject *Sender);
   void __fastcall DrawTableMouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
   void __fastcall RateCBExit(TObject *Sender);
   void __fastcall TreeViewFocusChange(TObject *Sender);
   void __fastcall TimeDTPUserInput(TObject *Sender,
          const AnsiString UserString, TDateTime &DateAndTime,
          bool &AllowChange);
   void __fastcall TreeViewKeyPress(TObject *Sender, char &Key);
   void __fastcall DateDTPKeyPress(TObject *Sender, char &Key);
   void __fastcall TimeDTPKeyPress(TObject *Sender, char &Key);
   void __fastcall RateCBKeyPress(TObject *Sender, char &Key);
   void __fastcall DrawTableChange(TObject *Sender, TListItem *Item,
          TItemChange Change);
   void __fastcall DateDTPEnter(TObject *Sender);
   void __fastcall DrawTableKeyPress(TObject *Sender, char &Key);
   void __fastcall RateCBEnter(TObject *Sender);
   void __fastcall TimeDTPEnter(TObject *Sender);
  void __fastcall cbZoneChange(TObject *Sender);
private:	// User declarations
   typedef struct{ //таблица дат ввода в действие тарифа
      long Rid;
      char Switch_Date[12];
      struct RATES{ // список тарифов по зонам
         char Time[8];
         long Rate;
      } RatesList[RATE_MAX];
      unsigned long RatesListCount;
      int pEdit;   //=1 new ,2-edit, 3- delete
   }RATE_LIST;

   RATE_LIST TreeTable[RATE_SIZE];
   unsigned long TreeCount;
   int Cheng;
   int posX;
   int Curent;
   void __fastcall SetAccess(TAccess value);
   int SetRatesCount();
public:		// User declarations
	__fastcall TFormEditRates(TComponent* Owner, AnsiString, TAccess = accDenied);
   void  TreeRead();
   void  TreeWrite();
protected:
   void __fastcall vSave(TObject* Sender);
   void __fastcall vRefresh(TObject* Sender);
   void __fastcall vNew(TObject* Sender);
   void __fastcall vDelete(TObject* Sender);
   void __fastcall vClone(TObject* Sender);
};
//---------------------------------------------------------------------------
#endif
