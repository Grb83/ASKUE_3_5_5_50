//---------------------------------------------------------------------------
#ifndef SupperMainH
#define SupperMainH
#define MONSHEMS	500
//---------------------------------------------------------------------------
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include "ASKUETypes.h"
#include <StdCtrls.hpp>
#include "MonitorForm.h"
#include <ToolWin.hpp>
#include <AppEvnts.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
class TInteriorAlert;
//---------------------------------------------------------------------------
class TSupperMainForm : public TForm
{
__published:
	TMainMenu *MainMenu1;
	TMenuItem *N1;
	TMenuItem *N4;
	TMenuItem *N5;
	TMenuItem *N6;
	TStatusBar *StatusBarSupperMain;
	TMenuItem *N11;
	TMenuItem *N12;
	TMenuItem *N13;
	TMenuItem *N14;
	TMenuItem *N15;
  TMenuItem *mnAbout;
	TProgressBar *ProgressBarMonitor;

	TBevel *Bevel1;
	TMenuItem *Window1;
	TMenuItem *TileG;
	TMenuItem *Cascade1;
	TMenuItem *N18;
	TMenuItem *TileV;
	TPanel *paTools;
	TBevel *Bevel2;
	TPanel *Panel2;
	TSpeedButton *sbHelp;
	TPanel *Panel3;
	TSpeedButton *sbCreateMonitor;
	TSpeedButton *sbOpenMonitor;
	TSpeedButton *sbOpenEditor;
	TBevel *Bevel3;
	TMenuItem *Vid;
	TMenuItem *mnTools;
	TMenuItem *mnStatus;
	TMenuItem *N2;
	TMenuItem *N9;
	TMenuItem *N10;
	TMenuItem *N16;
	TMenuItem *N19;
	TMenuItem *N20;
	TMenuItem *N21;
  TSpeedButton *sbOperScan;
	TTimer *Timer1;
	TSpeedButton *m_pUpdateButton1;
	TSpeedButton *m_pUpdateButton2;
	TSpeedButton *m_pUpdateButton3;
   TSpeedButton *m_pUpdateButton4;
   TMenuItem *N25;
  TMenuItem *mnOperScan;
   TMenuItem *N27;
   TMenuItem *EditMonitorList;
   TMenuItem *mmTools;
   TMenuItem *mmConnectionTerminal;
   TMenuItem *mmRequestTerminal;
   TMenuItem *mmMeteringTerminal;
  TMenuItem *mmMeteringMonitor;
  TPanel *plPeriod;
  TLabel *lbPeriod;
  TLabel *lbData;
  TSpeedButton *sbChangePeriod;
  TMenuItem *mnAdmin;
  TPanel *pnTimeZone;
  TMenuItem *mnFilter;
  TMenuItem *N7;
  TTimer *HighLightTimer;
  TImageList *ilServiceButton;
  TToolBar *ToolBar1;
  TToolButton *ToolButton2;
  TToolButton *spDSJournal;
  TPopupMenu *pmTimeZona;
  TStaticText *lbTZ;
  TToolBar *ToolBar2;
  TToolButton *ToolButton1;
  TImageList *ilZona;
  TPanel *Panel1;
  TSpeedButton *sbUserForum;
  TMenuItem *mmRefreshDB;
    TToolButton *sbCTS;
    TImageList *ilMain;
  TSpeedButton *btnShowTablespaceUsage;
  TBevel *Bevel5;
  TBevel *Bevel4;
  TBevel *Bevel6;
  TBevel *Bevel7;
  TBevel *Bevel8;
        TApplicationEvents *ApplicationEvents1;
        TTimer *Timer2;
	void __fastcall N6Click(TObject *Sender);
//	void __fastcall N7Click(TObject *Sender);
//	void __fastcall N8Click(TObject *Sender);
	void __fastcall StatusBarSupperMainDrawPanel(TStatusBar *StatusBar, TStatusPanel *Panel, const TRect &Rect);
	void __fastcall N13Click(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall N11Click(TObject *Sender);
	void __fastcall N1Click(TObject *Sender);
	void __fastcall TileGClick(TObject *Sender);
	void __fastcall Cascade1Click(TObject *Sender);
	void __fastcall N12Click(TObject *Sender);
	void __fastcall N15Click(TObject *Sender);
	void __fastcall TileVClick(TObject *Sender);
	void __fastcall mnAboutClick(TObject *Sender);
	void __fastcall mnToolsClick(TObject *Sender);
	void __fastcall mnStatusClick(TObject *Sender);
	void __fastcall N2Click(TObject *Sender);
	void __fastcall N9Click(TObject *Sender);
	void __fastcall N16Click(TObject *Sender);
	void __fastcall N19Click(TObject *Sender);
	void __fastcall FormKeyDown(TObject *Sender, WORD &Key, TShiftState Shift);
	void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
	void __fastcall N21Click(TObject *Sender);
//	void __fastcall N22Click(TObject *Sender);
   void __fastcall sbUserForumClick(TObject *Sender);
   void __fastcall menuSetupMonitorRefreshClick(TObject *Sender);
   void __fastcall Timer1Timer(TObject *Sender);
	void __fastcall OnChanelButtonClick(TObject *Sender);
//   void __fastcall N17Click(TObject *Sender);
   void __fastcall mnOperScanClick(TObject *Sender);
   void __fastcall N27Click(TObject *Sender);
   void __fastcall EditMonitorListClick(TObject *Sender);
   void __fastcall mmConnectionTerminalClick(TObject *Sender);
   void __fastcall mmMeteringTerminalClick(TObject *Sender);
   void __fastcall mmRequestTerminalClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall mmMeteringMonitorClick(TObject *Sender);
  void __fastcall m_pUpdateButton4Click(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall sbChangePeriodClick(TObject *Sender);
  void __fastcall mnAdminClick(TObject *Sender);
  void __fastcall mnFilterClick(TObject *Sender);
  void __fastcall sbCTSClick(TObject *Sender);
  void __fastcall spDSJournalClick(TObject *Sender);
  void __fastcall HighLightTimerTimer(TObject *Sender);
  void __fastcall TimeZoneClick(TObject *Sender);
  void __fastcall RateZoneClick(TObject *Sender);
  void __fastcall sbMinimizeClick(TObject *Sender);
  void __fastcall mmRefreshDBClick(TObject *Sender);
  void __fastcall btnShowTablespaceUsageClick(TObject *Sender);
        void __fastcall ApplicationEvents1Message(tagMSG &Msg,
          bool &Handled);
        void __fastcall Timer2Timer(TObject *Sender);
private:        // private user declarations
	typedef struct {  //МОНИТОРЫ
      long Monitor_Id;
      long MSchema;
    	char Name[150];
    	long DSize;
      int def;
   }MONITORSTART;
   int CloseCnt; // счётчик попыток закрытия приложения // add by KSS
   MONITORSTART startMon[MONSHEMS];
   AnsiString conStr;

  typedef struct {  //Часовой пояс
      long TimeZone_Id;
      int Shift;
      int dsummer;
      AnsiString name;
   }TIMEZONESHIFT;
 int CountTimeZona;
    typedef struct {  //Часовой пояс
      long TimeZone_Id;
      int nschedulelist;
      int dsummer;
      AnsiString name;
   }RATEZONESHIFT;
                                                                                                            
public:         // public user declarations
   TInteriorAlert *m_pAlertOfSysTable;
   bool __fastcall( __closure *myCopy )(void);
	void __fastcall( __closure *myPaste)(void);
	void __fastcall OnMonitorAlertTerminate(TObject *Sender);

	virtual __fastcall TSupperMainForm(TComponent* Owner);
//	virtual __fastcall ~TSupperMainForm();
	void    __fastcall UpdateSpeedButton( TMessage& Message );
   void    __fastcall WMRefreshData(TMessage& Message);
   void	__fastcall WMCreateMonitor(TMessage& Message);
	BEGIN_MESSAGE_MAP
      MESSAGE_HANDLER((WM_CREATEMONITOR),TMessage, WMCreateMonitor )
      MESSAGE_HANDLER(WM_REFRESHDATA, TMessage, WMRefreshData )
		MESSAGE_HANDLER(WM_UPDATE_SPEED_BUTTON, TMessage, UpdateSpeedButton )
	END_MESSAGE_MAP(TForm)
   TRect ProgressBarRect;
   void __fastcall ProgressBarStepBy(TObject *Sender);
   void __fastcall initMenuAccess(void);
  //===== 20.05.2005 Frizyuk A.M. Start
  void __fastcall MonitorMenuEnabled();
  //===== 20.05.2005 Frizyuk A.M. Finish
  void __fastcall InitRegistry(void);
  void __fastcall SetZona(int Rate,int TimeZonaMid);
  void __fastcall SetPeriod(AnsiString Per);
  //01.10.2019 - UNKEY CHECK IF enterprice_cod is null
  void __fastcall TabuByTime();
  void __fastcall TabuByProperty();
  bool wasTabu;
};
//---------------------------------------------------------------------------
extern TSupperMainForm *SupperMainForm;
//---------------------------------------------------------------------------
#endif
