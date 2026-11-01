//---------------------------------------------------------------------------
#ifndef VIT_InputExcelH
#define VIT_InputExcelH
//---------------------------------------------------------------------------
#include "DrawTable.h"
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <StdCtrls.hpp>
#include "Vit_Meter.h"
#include "Main.h"
#include <ImgList.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
#define WM_SELECTCELL (WM_USER+100)
#define MAXINPUT	5000
//---------------------------------------------------------------------------
class TFormVITInputExcel : public TMainForm
{
__published:	// IDE-managed Components
  TDrawTable *DrawTable1;
   TBitBtn *btCheck;
   TBitBtn *btParam;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall DrawTable1SetEditText(TObject *Sender, int ACol, int ARow,
	const AnsiString Value);
	void __fastcall DrawTable1GetEditMask(TObject *Sender, int ACol, int ARow,
	AnsiString &Value);
	void __fastcall DrawTable1KeyDown(TObject *Sender, WORD &Key,
	TShiftState Shift);
	void __fastcall DrawTable1DrawCell(TObject *Sender, int Col, int Row, TRect &Rect, TGridDrawState State);
   void __fastcall DrawTable1KeyPress(TObject *Sender, char &Key);
private:	// User declarations
   void __fastcall MainProc(TObject *Sender);
   POINTDATAFORM pointPOL;
   typedef struct{
    	char Mid[20];
      char Name[150];
      char Type[20];
      char Position[20];
      char Entype[20];
      char Mtrsn[20];
      char KC[20];
      char Digits[20];
      char Date_time[20];
      char EM[20];
      char EM_N[20]; //Новые показания
      char E_N[20];  //Новый расход
      bool editRecord;
   }POINTLASTINPUT;
   POINTLASTINPUT pointLastInput[MAXINPUT];
   long prov;	// Состояние проверки 0-Не проводилась, 1-проводилась (сохранять нельзя), 2-проводилась (сохранять можно)
   unsigned long CountStr; // Количество строчек в результате запроса
   long ttable;
   AnsiString tname;
   AnsiString addwhere;
   void __fastcall SetAccess(TAccess value);
public:		// User declarations
	__fastcall TFormVITInputExcel(TComponent* Owner,AnsiString, long ttable,long rezerv, TAccess = accDenied);
   void __fastcall vFindAgainClick(TObject*);
   void __fastcall vFindClick(TObject*);
protected:
	void __fastcall WMSelectCell(TMessage & Message);
   void __fastcall vSave(TObject* Sender);
   void __fastcall vRefresh(TObject* Sender);
   void __fastcall vCheck(TObject* Sender);
   void __fastcall vParams(TObject* Sender);
	BEGIN_MESSAGE_MAP
		MESSAGE_HANDLER(WM_SELECTCELL, TMessage, WMSelectCell)
	END_MESSAGE_MAP(TForm)
};
//---------------------------------------------------------------------------
#endif

