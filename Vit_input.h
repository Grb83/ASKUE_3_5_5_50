//---------------------------------------------------------------------------
#ifndef Vit_inputH
#define Vit_inputH
//---------------------------------------------------------------------------
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <StdCtrls.hpp>
#include "Vit_Meter.h"
#include "DrawTable.h"
#include "Main.h"
#include <ActnList.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
#define MAXINPUT	5000
#define WM_SELECTCELL (WM_USER+100)
class TFormVITInput : public TMainForm
{
__published:	// IDE-managed Components
	TDrawTable *DrawTable1;
   TBitBtn *btCheck;
   TBitBtn *btParam;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall DrawTable1GetEditMask(TObject *Sender, int ACol, int ARow,
	AnsiString &Value);
	void __fastcall DrawTable1SetEditText(TObject *Sender, int ACol, int ARow,
	const AnsiString Value);
	void __fastcall DrawTable1KeyDown(TObject *Sender, WORD &Key,
	TShiftState Shift);
	void __fastcall DrawTable1DrawCell(TObject *Sender, int Col, int Row, TRect &Rect, TGridDrawState State);
  void __fastcall DrawTable1KeyPress(TObject *Sender, char &Key);
private:	// User declarations
  void MainProc(TObject *Sender);
  POINTDATAFORM pointPOL;
  typedef struct{
    char Mid[20];
    char Name[250];
    char Type[20];
    char Position[20];
    char Entype[20];
    char Mtrsn[20];
    char KC[20];
    char Digits[20];
    char Date_time[20];
    char EM[20];
    char AEM[20];
    char BEM[20];
    char CEM[20];
    char DEM[20];
    char EM_N[20]; //Новые показания
    char AEM_N[20]; //Новые показания
    char BEM_N[20]; //Новые показания
    char CEM_N[20]; //Новые показания
    char DEM_N[20]; //Новые показания
    char E_N[20];  //Новый расход
    char AE_N[20];  //Новый расход
    char BE_N[20];  //Новый расход
    char CE_N[20];  //Новый расход
    char DE_N[20];  //Новый расход
    bool editRecord;
  }POINTLASTINPUT;
  POINTLASTINPUT pointLastInput[MAXINPUT];
  long prov;	// Состояние проверки 0-Не проводилась, 1-проводилась (сохранять нельзя), 2-проводилась (сохранять можно)
  unsigned long CountStr; // Количество строчек в результате запроса
   void __fastcall SetAccess(TAccess value){TMainForm::SetAccess(value);}
public:		// User declarations
  __fastcall TFormVITInput(TComponent* Owner, AnsiString, TAccess = accDenied);
protected:
	void __fastcall WMSelectCell(TMessage & Message);
   void __fastcall vRefresh(TObject* Sender);
   void __fastcall vSave(TObject* Sender);
   void __fastcall vCheck(TObject* Sender);
   void __fastcall vParams(TObject* Sender);
	BEGIN_MESSAGE_MAP
		MESSAGE_HANDLER(WM_SELECTCELL, TMessage, WMSelectCell)
	END_MESSAGE_MAP(TForm)
};
//---------------------------------------------------------------------------
#endif
