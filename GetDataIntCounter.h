//---------------------------------------------------------------------------
#ifndef GetDataIntCounterH
#define GetDataIntCounterH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <Grids.hpp>
#include "DrawTable.h"
#include "CountParam.h"
//---------------------------------------------------------------------------
class TFormGetDataIntCounter : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel2;
	TEdit *Edit1;
	TPanel *Panel10;
	TBitBtn *BitBtn1;
	TPanel *Panel1;
	TDrawTable *DrawTable2;
	TPanel *Panel3;
	TPanel *Panel4;
	TDrawTable *DrawTable1;
	TPanel *Panel5;
	TBitBtn *BitBtn2;
        TBitBtn *BitBtn3;
        TPanel *Panel6;
        TPanel *Panel7;
        TDrawTable *DrawTable3;
	void __fastcall DrawTable1DrawCell(TObject *Sender, int Col, int Row,
	TRect &Rect, TGridDrawState State);
	void __fastcall DrawTable2DrawCell(TObject *Sender, int Col, int Row,
	TRect &Rect, TGridDrawState State);
	void __fastcall DrawTable3DrawCell(TObject *Sender, int Col, int Row,
	TRect &Rect, TGridDrawState State);

	void __fastcall BitBtn1Click(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
        void __fastcall BitBtn3Click(TObject *Sender);


private:	// User declarations
TBIIL* tBill;
public:		// User declarations
	__fastcall TFormGetDataIntCounter(TComponent* Owner);
	__fastcall TFormGetDataIntCounter(TComponent* Owner,TBIIL* ztBill);
};
//---------------------------------------------------------------------------
extern TFormGetDataIntCounter *FormGetDataIntCounter;
//---------------------------------------------------------------------------
#endif
