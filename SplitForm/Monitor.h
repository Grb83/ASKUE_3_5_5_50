//---------------------------------------------------------------------------
#ifndef MainFormH
#define MainFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Menus.hpp>
#include <Buttons.hpp>
#include "PageCtrlSpl.h"
#include <Dialogs.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include "unInteriorUni.h"


#define WM_MONITORINIT			(WM_USER+210)
#define WM_ACTIVATETHISFORM    		(WM_USER+220)
//---------------------------------------------------------------------------
class TManForm : public TForm
{
__published:	// IDE-managed Components
	TMainMenu *MainMenu1;
	TMenuItem *Monitor;
	TMenuItem *AddRight;
	TMenuItem *AddBottom;
	TMenuItem *Rotate;
	TMenuItem *SaveMonitor;
	TMenuItem *SaveMonitorAs;
	TPanel *Panel1;
	TPanel *Panel2;
	TMenuItem *File;
	TMenuItem *N7;
	TMenuItem *N8;
	TMenuItem *Exit;
	TMenuItem *CreateMonitor;
	TMenuItem *OpenMonitor;
	TMenuItem *OpenEdit;
	TMenuItem *N1;
	TButton *BitBtnClose;
	TButton *BitBtnNext;
	TButton *BitBtnPrevios;
	TButton *BitBtnParam;
	TButton *BitBtnForm;
	TMenuItem *MenuItemSetupMonitor;
        TMenuItem *EditMonitorList;
	TMenuItem *N2;
	TMenuItem *PrintRep;
        TMenuItem *PrintGraph;
        TMenuItem *SaveRepToFile;
        TMenuItem *SaveGraphToFile;
        TSaveDialog *SaveDialog1;
        TMenuItem *PrintTable;
  TMenuItem *N3;
  TMenuItem *N4;
  TMenuItem *NM5;
        TMenuItem *SaveTableToFile;
  TOraQuery *oqMonitor;
  TBlobField *oqMonitorDFILE;
  TFloatField *oqMonitorNPARENT;
        TMenuItem *N5;
        TMenuItem *SaveMultyTableToFile;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall AddPanelClick(TObject *Sender);

	void __fastcall DeletePanelClick(TObject *Sender);
	void __fastcall N12Click(TObject *Sender);
	void __fastcall N13Click(TObject *Sender);
	void __fastcall N1Click(TObject *Sender);
	void __fastcall N2Click(TObject *Sender);
	void __fastcall RotateClick(TObject *Sender);

	void __fastcall N5Click(TObject *Sender);
	void __fastcall SaveMonitorClick(TObject *Sender);
	void __fastcall BitBtnCloseClick(TObject *Sender);
	void __fastcall BitBtnFormClick(TObject *Sender);
	void __fastcall BitBtnParamClick(TObject *Sender);

	void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
	void __fastcall FileClick(TObject *Sender);
	void __fastcall CreateMonitorClick(TObject *Sender);
	void __fastcall OpenMonitorClick(TObject *Sender);
	void __fastcall ExitClick(TObject *Sender);
	void __fastcall OpenEditClick(TObject *Sender);


	void __fastcall SaveMonitorAsClick(TObject *Sender);
	void __fastcall BitBtnPreviosClick(TObject *Sender);
	void __fastcall BitBtnNextClick(TObject *Sender);
	void __fastcall EditMonitorListClick(TObject *Sender);
	void __fastcall Save_Monitor(AnsiString aName, long aMSchema);

	void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
	void __fastcall MenuItemSetupMonitorClick(TObject *Sender);
	void __fastcall EditParamMonitorClick(TObject *Sender);
	void __fastcall PrintRepClick(TObject *Sender);
     void __fastcall FormActivate(TObject *Sender);
        void __fastcall menuSetupMonitorRefreshClick(TObject *Sender);
        void __fastcall PrintGraphClick(TObject *Sender);
        void __fastcall SaveRepToFileClick(TObject *Sender);
        void __fastcall SaveGraphToFileClick(TObject *Sender);
        void __fastcall PrintTableClick(TObject *Sender);
  void __fastcall N3Click(TObject *Sender);
  void __fastcall NM5Click(TObject *Sender);
        void __fastcall SaveTableToFileClick(TObject *Sender);
        //GRB ADD 07.02.2019
        void __fastcall SaveMultyTableToFileClick(TObject *Sender);
private:	// User declarations
protected:	// User declarations
	void __fastcall WMMonitorInit(TMessage & Message);
	void __fastcall WMRefreshData(TMessage & Message);
/* Kas*/void __fastcall WMActivateThisForm(TMessage & Message);
	BEGIN_MESSAGE_MAP
		MESSAGE_HANDLER(WM_MONITORINIT, TMessage, WMMonitorInit)
		MESSAGE_HANDLER(WM_REFRESHDATA, TMessage, WMRefreshData)
          MESSAGE_HANDLER(WM_ACTIVATETHISFORM, TMessage, WMActivateThisForm)
	END_MESSAGE_MAP(TForm)
public:		// User declarations
	__fastcall TManForm(TComponent* Owner);
	Classes::TNotifyEvent OnProgressBarStepBy;
     static int NumMonitor;
     TPageCtrlSplt *PageCtrlSplt;
     //GRB ADD
     //TfmInteriorUni *fmInteriorUni;
     HCURSOR hCursor;
     long Monitor_Id, nParent;// ИД монитора и его родитель в дереве. Нужно для сохранения монитора

  //===== 20.05.2005 Frizyuk A.M. Start
  void __fastcall MonitorMenuEnabled();
  //===== 20.05.2005 Frizyuk A.M. Finish
};
//---------------------------------------------------------------------------
extern TManForm *ManForm;
//---------------------------------------------------------------------------
#endif
