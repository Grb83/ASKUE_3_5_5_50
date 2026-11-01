//---------------------------------------------------------------------------
#ifndef SplitFormH
#define SplitFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <comctrls.hpp>
//---------------------------------------------------------------------------
class TSplitterForm : public TForm
{
__published:	// IDE-managed Components
	void __fastcall SplitFormResize(TObject *Sender);
protected:	// User declarations
	TControl *Friend,*Opponent,*activeControl;
	TAlign al;
	HDC hDC;
	HPEN hPen, hPenOld;
	TRect prevRect;
	void __fastcall AddChild( TControl* AControl, TAlign AAlign );
	void __fastcall DeleteChild( TControl* AControl );
	void __fastcall RotateChild( TControl* AControl, TTabSheet *TabSheetMax);
protected:
	virtual TSplitterForm* __fastcall New( TComponent* Owner );
public:		// User declarations
	__fastcall TSplitterForm(TComponent* Owner);

	void __fastcall SplitMouseDown(TObject *Sender, TMouseButton Button,
		TShiftState Shift, int X, int Y);

	void __fastcall SplitMouseMove(TObject *Sender, TShiftState Shift,
		int X, int Y);

	void __fastcall SplitMouseUp(TObject *Sender, TMouseButton Button,
		TShiftState Shift, int X, int Y);

	void __fastcall AddChild( TControl* ADestinControl,TControl* AControl,
		TAlign AAlign );

	void __fastcall RemoveChild( TControl* AControl );

	void __fastcall MaximizeChild( TControl* AControl, TTabSheet *TabSheetMax);

public:		// User declarations
	TPanel * Splitter;
	bool Sizing;
};
//---------------------------------------------------------------------------
class TBaseMonitorForm;
//---------------------------------------------------------------------------
class TSplitterBaseMonitorForm : /*protected*/public TSplitterForm
{
protected:
	virtual TSplitterForm* __fastcall New( TComponent* Owner );
public:		// User declarations
	__fastcall TSplitterBaseMonitorForm(TComponent* Owner);

	void __fastcall AddChild( TBaseMonitorForm* ADestinControl,TBaseMonitorForm* AControl,
		TAlign AAlign );
	void __fastcall RemoveChild( TBaseMonitorForm* AControl );
	void __fastcall MaximizeChild( TBaseMonitorForm* AControl, TTabSheet *TabSheetMax);
	void __fastcall MaximizeChild( TPanel* AControl, TTabSheet *TabSheetMax);
	bool __fastcall SaveSplitter( TStream* );
	bool LoadSplitter( TStream*,Classes::TNotifyEvent OnProgrBar,Classes::TList* );
public:		// User declarations
	TSplitterForm::Splitter;
	TSplitterForm::Sizing;
	enum typeForm
	{
		tSplitterForm=1,
		tMonitorForm=2,
	};
};
//---------------------------------------------------------------------------
#endif
