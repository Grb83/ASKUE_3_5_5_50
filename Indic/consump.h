//---------------------------------------------------------------------------
#ifndef consumpH
#define consumpH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <StdCtrls.hpp>
#include "selectpoint.h"
#include "DrawTable.h"
#include "Main.h"
#include <ImgList.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
#define MAXINPUT	5000
#define WM_SELECTCELL (WM_USER+100)
#define N_MAXDATESINDAY 80
#define N_MAXCOUNTERSINPOINT 6
//---------------------------------------------------------------------------
class TfmConsump : public TMainForm
{
__published:	// IDE-managed Components
	TDrawTable *DrawTable1;
    TBitBtn *btParam;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall DrawTable1SetEditText(TObject *Sender, int ACol, int ARow,
	const AnsiString Value);
	void __fastcall DrawTable1KeyDown(TObject *Sender, WORD &Key, TShiftState Shift);
	void __fastcall DrawTable1DrawCell(TObject *Sender, int Col, int Row,
	TRect &Rect, TGridDrawState State);
    void __fastcall DrawTable1KeyPress(TObject *Sender, char &Key);
private:	// User declarations
    void MainProc(TObject *Sender);
    GROUPDATAFORM pointPOL;
    typedef struct{
        char Mid[20];
        char Name[150];
        char Type[20];
        char Entype[20];
        char Mtrsn[20];
        char KC[20];
        char Date_time[20];
        char E[20];     //Старый расход
        char E_N[20];  //Новый расход
        bool editRecord;
    }POINTLASTINPUT;
    POINTLASTINPUT pointLastInput[MAXINPUT];
    unsigned long CountStr; // Количество строчек в результате запросаs
    long ttable;
    AnsiString tname;
    void __fastcall SetAccess(TAccess value);
public:		// User declarations
	__fastcall TfmConsump(TComponent* Owner, AnsiString, long ttable,long rezerv, TAccess = accDenied, bool = false);
protected:
	void __fastcall WMSelectCell(TMessage & Message);
    void __fastcall vSave(TObject* Sender);
    void __fastcall vRefresh(TObject* Sender);
    void __fastcall vParams(TObject* Sender);
	BEGIN_MESSAGE_MAP
        MESSAGE_HANDLER(WM_SELECTCELL, TMessage, WMSelectCell)
	END_MESSAGE_MAP(TForm)
};
//---------------------------------------------------------------------------
#endif
