//---------------------------------------------------------------------------

#ifndef RequestMonitoringH
#define RequestMonitoringH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Main.h"
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <ComCtrls.hpp>
#include <Mask.hpp>
#include <ToolWin.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
struct sGroupStatus
{
    long Gid;
    long HaveChild;
    long Mid;
    char Name[150];
    //char Short_name[50];
    //GRB ADD 19.10.2020 - add for points
    long parentGroup;
    //GRB ADD 19.10.2020 - add for groups 'gid/mid'
    char idob [30];
    char Profile[20];
    char Halfhour[20];
    char Bill[20];
    char Months[20];
    int Count;
    int HalfCount;
    int BillCount;
    int MonthsCount;
    int TestHalfCount ;
    int isgroup;
    int nblocking;
    int nparent;
    int Type;
    //GRB ADD 11.09.2020 - резервируем под EIC код который надо показывать в таблице
    char EIC[50];
};
  //GRB ADD 17.11.2020 - структурка для возвращения Gid и Name по значению для переходов в мониторы по добавленному контекстному меню по выбранному из таблицы а не дерева исп-ся в getGidLName
  struct fixPanelOnTree{
	  long Gid;
	  AnsiString NameGroup;
	  AnsiString ShortName;
	  bool was_result;
  };
  
class TfmRequestMonitoring : public TMainForm
{
__published:	// IDE-managed Components
        TAction *acReceipt_data_absence;
        TPanel *Panel1;
        TPanel *Panel2;
        TTreeView *tvGroupStatus;
        TListView *lvInfo;
        TPanel *Panel7;
        TPanel *Panel3;
        TSplitter *Splitter1;
        TAction *acChangeDateControll;
        TLabel *lDateTimeControll;
  TPanel *Panel4;
  TGroupBox *GroupBox1;
  TDateTimePicker *DateTimePicker1;
  TMaskEdit *MaskEdit1;
  TRadioButton *RadioButton1;
  TRadioButton *RadioButton2;
  TPanel *Panel5;
  TGroupBox *GroupBox2;
  TCheckBox *CheckBox1;
  TCheckBox *CheckBox2;
  TCheckBox *CheckBox3;
  TPanel *Panel6;
  TToolBar *ToolBar1;
  TToolButton *ToolButton1;
  TToolButton *tbCanal;
  TToolButton *ToolButton3;
  TToolButton *ToolButton4;
  TGroupBox *GroupBox3;
  TPanel *Panel8;
  TPanel *Panel9;
  TRadioButton *rbGroup;
  TRadioButton *rbCanal;
  TRadioButton *rbPoints;
  TAction *aAutoRefresh;
  TTimer *Timer1;
  TRadioButton *rbMaket;
  TRadioButton *rbCom;
  TOraQuery *oqGetAcc;
  TPanel *Panel10;
  TLabel *Label1;
  TDateTimePicker *dtTimeControl;
  TSpeedButton *sbRef;
  TSpeedButton *sbAutoRefresh;
  TCheckBox *cbNotFull;
        TMenuItem *mnFile;
        TMenuItem *MnExcelItem;
        TSaveDialog *SaveDialog1;
        TOraQuery *oqCursor2;
        void __fastcall tvGroupStatusDeletion(TObject *Sender,
          TTreeNode *Node);
        void __fastcall tvGroupStatusExpanding(TObject *Sender,
          TTreeNode *Node, bool &AllowExpansion);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall tvGroupStatusChange(TObject *Sender,
          TTreeNode *Node);
        void __fastcall iaRefreshExecute(TObject *Sender);
  void __fastcall RadioButton1Click(TObject *Sender);
  void __fastcall RadioButton2Click(TObject *Sender);
  void __fastcall CheckBox1Click(TObject *Sender);
  void __fastcall lvInfoDblClick(TObject *Sender);
  void __fastcall tbCanalClick(TObject *Sender);
  void __fastcall ToolButton3Click(TObject *Sender);
  void __fastcall ToolButton4Click(TObject *Sender);
  void __fastcall iaCloseExecute(TObject *Sender);
  void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
  void __fastcall aAutoRefreshExecute(TObject *Sender);
  void __fastcall Timer1RefreshMonitor(TObject *Sender);
  void __fastcall miManualInpClick(TObject *Sender);
  void __fastcall cbNotFullClick(TObject *Sender);
        void __fastcall MnExcelItemClick(TObject *Sender);
  //GRB ADD 23.10.2020
  void __fastcall iaMonExecute(TObject *Sender);
  void __fastcall MonSelectClick(TObject *Sender);
  void __fastcall PopupMenu1Popup(TObject *Sender);

  void __fastcall mMonClick(TObject *Sender);

  
private:	// User declarations
      int __fastcall TestImage (sGroupStatus* ptrGroupStatus);
      void __fastcall InitRegistry(void);
      void __fastcall WriteReg(void);
	  //GRB ADD 20.10.2020
	  int __fastcall getTypeTree();
      bool Test;
      TMenuItem* miManIn;
      TMenuItem* miManMetr;
protected:
        AnsiString FDateControl; 
        void __fastcall vSave(TObject* Sender);
        void __fastcall vRefresh(TObject* Sender);
        bool __fastcall ReadNode(TTreeView* tv,TTreeNode* NodeParent, AnsiString aDateControl,bool IfInsert=true);// Читает ветку дерева Точек или Групп
        void __fastcall vInit(TObject* Sender);
public:		// User declarations
        __fastcall TfmRequestMonitoring(TComponent* Owner, AnsiString Name, TAccess a);
        //GRB ADD 23.10.2020
        void __fastcall createSubMenu_F(TMenuItem*);
        //GRB ADD 26.10.2020
        static void __fastcall createSubMenu_G(TMenuItem*mi);
		//17.11.2020 -возвращает Gid и Name по значению для переходов в мониторы по добавленному контекстному меню по выбранному из таблицы а не дерева исп-ся в MonSelectClick
		fixPanelOnTree __fastcall getGidLName();
};
//---------------------------------------------------------------------------
extern PACKAGE TfmRequestMonitoring *fmRequestMonitoring;
//---------------------------------------------------------------------------
#endif
