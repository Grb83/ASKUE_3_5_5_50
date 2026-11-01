//---------------------------------------------------------------------------
#ifndef MonitorFormH
#define MonitorFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
#include <ImgList.hpp>
#include "Grids.hpp"
#include "SplitForm.h"
#include "Interior.h"
//---------------------------------------------------------------------------
//Требоания к владельцу на проведение манипуляций с формой
#define WM_CLOSESPLTCHILD		(WM_USER+200)
#define WM_RESTSPLTCHILD		(WM_USER+201)
#define WM_MAXSPLTCHILD			(WM_USER+202)
#define WM_ACTIVESPLTCHILD		(WM_USER+203)
#define WM_DEACTIVESPLTCHILD	(WM_USER+204)
//Команды от владельца на отображение фокусного состояния формы
#define WM_SPLTSETFOCUS			(WM_USER+205)//isMaximized=Message.WParam;
#define WM_SPLTKILLFOCUS		(WM_USER+206)//isMaximized=Message.WParam;
//Команды от владельца на формирование соодержимого формы
#define WM_REFRESHDATA			(WM_USER+207)//Message.WParam=&NameAlert,Message.LParam=&VCursor;
#define WM_REFRESHFORM			(WM_USER+208)//Message.LParam=&fd
#define WM_SETSPLITORIENT		(WM_USER+209)
#define WM_PROGRESS				(WM_USER+210)//Message.LParam=0 - прекратить прорисовку
//---------------------------------------------------------------------------
class TBaseMonitorForm : public TForm
{
__published:	// IDE-managed Components
	TPaintBox *PaintBoxCaption;
	TLabel *LabelComment;
	TPopupMenu *PopupMenuBaseForm;
	TMenuItem *Maximize;
	TMenuItem *Restore;
	TMenuItem *HideTable;
	TMenuItem *HideGraphics;
	TMenuItem *Panel;
	TMenuItem *View;
	TMenuItem *ChartFXLines;
	TMenuItem *ChartFXColumns;
	TMenuItem *ByGroup;
	TMenuItem *ByProfile;
  TMenuItem *IsValid;
	TMenuItem *N1;
	TMenuItem *N3;
	TBevel *Bevel1;
	TImageList *ImageListTask;
	TPopupMenu *PopupMenuDU;
	TMenuItem *MenuItemGroup;
	TMenuItem *MenuItem6;
	TMenuItem *MenuItemPanel;
	TMenuItem *MenuItemMax;
	TMenuItem *MenuItemMin;
	TMenuItem *MenuItemMainGroup;
	TMenuItem *MenuItemAttr;
	TMenuItem *N2;
	TMenuItem *SmallFont;
	TMenuItem *SmallFont2;
  TMenuItem *N4;
  TMenuItem *N5;
  TMenuItem *miFormula;
  
	void __fastcall PaintBoxCaptionPaint(TObject *Sender);
	void __fastcall FormResize(TObject *Sender);
	void __fastcall PaintBoxCaptionMouseDown(TObject *Sender, TMouseButton Button,
    	TShiftState Shift, int X, int Y);
	void __fastcall PaintBoxCaptionMouseMove(TObject *Sender, TShiftState Shift,
	    int X, int Y);
	void __fastcall PaintBoxCaptionMouseUp(TObject *Sender, TMouseButton Button,
    	TShiftState Shift, int X, int Y);
	void __fastcall FormActivate(TObject *Sender);
	void __fastcall FormDeactivate(TObject *Sender);
	void __fastcall FormPaint(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall MaximizeClick(TObject *Sender);
	void __fastcall RestoreClick(TObject *Sender);
	void __fastcall DeleteClick(TObject *Sender);
	void __fastcall PaintBoxCaptionDblClick(TObject *Sender);
	void __fastcall HideGraphicsClick(TObject *Sender);
	void __fastcall PopupMenuBaseFormPopup(TObject *Sender);
	void __fastcall LabelCommentMouseUp(TObject *Sender, TMouseButton Button,
    	TShiftState Shift, int X, int Y);
	void __fastcall PanelClick(TObject *Sender);
	void __fastcall ViewClick(TObject *Sender);
	void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
	void __fastcall SmallFontClick(TObject *Sender);
public:		// User declarations
	TSplitterForm* SplitterForm;
	TInterior* Interior;
	Classes::TNotifyEvent OnProgressBarStepBy;
	bool isMaximized;
	bool isActive;
	bool isSmallFont;
	enum { btNone,btClose,btMaxRest } isPressButton;
	HANDLE hMutex;
protected:	// User declarations
	void __fastcall WMSpltSetFocus(TMessage & Message);
	void __fastcall WMSpltKillFocus(TMessage & Message);
	void __fastcall WMRefreshData(TMessage & Message);
	void __fastcall WMRefreshForm(TMessage & Message);
	void __fastcall WMSetSpitOrient(TMessage & Message);
	BEGIN_MESSAGE_MAP
		MESSAGE_HANDLER(WM_SPLTSETFOCUS, TMessage, WMSpltSetFocus)
		MESSAGE_HANDLER(WM_SPLTKILLFOCUS, TMessage, WMSpltKillFocus)
		MESSAGE_HANDLER(WM_REFRESHDATA, TMessage, WMRefreshData)
		MESSAGE_HANDLER(WM_REFRESHFORM, TMessage, WMRefreshForm)
		MESSAGE_HANDLER(WM_SETSPLITORIENT, TMessage, WMSetSpitOrient)
	END_MESSAGE_MAP(TForm)
public:		// User declarations
	__fastcall TBaseMonitorForm(TComponent* Owner,Classes::TNotifyEvent OnProgrBar);
    __fastcall ~TBaseMonitorForm();
	TFormDescr* GetFormDescr(void);
	void __fastcall MaximizeMonitorForm(void);
	void __fastcall RestoreMonitorForm(void);
	void __fastcall DeleteMonitorForm(void);
	virtual bool __fastcall SaveMonitorForm(TStream*);
	virtual bool __fastcall LoadMonitorForm(TStream*);

};
//---------------------------------------------------------------------------
extern TBaseMonitorForm *BaseMonitorForm;
extern CRITICAL_SECTION ListInteriorCriticalSection;
extern TList *ListInterior;
//---------------------------------------------------------------------------
#endif

