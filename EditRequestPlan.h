//---------------------------------------------------------------------------
#ifndef EditRequestPlanH
#define EditRequestPlanH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Forms.hpp>
#include <ImgList.hpp>
#include <Mask.hpp>
#include <Menus.hpp>
#include <StdCtrls.hpp>
#include "Main.h"
#include <ToolWin.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
class TfmEditRequestPlan : public TMainForm
{
__published:	// IDE-managed Components
   TPanel *Panel6;
   TPanel *Panel23;
   TTreeView *tvChannelsList;
   TPanel *Panel8;
   TScrollBox *ScrollBox1;
   TPanel *paEdit;
   TPanel *Panel22;
   TCheckBox *chbBlocking;
   TPanel *Panel10;
   TLabel *Label1;
   TLabel *Label2;
   TEdit *eName;
   TMemo *mNote;
   TPanel *Panel11;
   TPanel *Panel12;
   TComboBox *cbProtocol_id;
   TPanel *Panel13;
   TComboBox *cbCom_id;
   TPanel *Panel15;
   TLabel *Label6;
   TEdit *eAddr;
   TPanel *Panel17;
   TEdit *eInit_str;
   TPanel *Panel5;
   TEdit *eCaller_Name;
   TPanel *Panel28;
   TComboBox *cbMainChannel;
   TPanel *Panel18;
   TPanel *Panel19;
   TEdit *eCycle_Tout;
   TPanel *Panel20;
   TEdit *eRetries;
   TPanel *Panel21;
   TEdit *eConnTimeWait;
   TPanel *Panel29;
   TLabel *Label3;
   TLabel *Label4;
   TLabel *Label5;
   TEdit *eDay;
   TMaskEdit *meStart;
   TMaskEdit *meEnd;
   TPanel *Panel24;
   TPanel *Panel25;
   TCheckBox *chbNet_Param;
   TCheckBox *chbJournal;
   TPanel *Panel26;
   TCheckBox *chbCurr_Data;
   TEdit *eCurr_Data_Dept;
   TPanel *Panel27;
   TCheckBox *chbBill_Data;
   TEdit *eBill_Data_Dept;
   TCheckBox *chbNReadCurr;
   TLabel *Label7;
   TPanel *Panel1;
   TEdit *eRetries_Tout;
   TAction *aBlocking;
   TAction *aBillData;
   TAction *aCurrData;
   TAction *aNetParam;
   TAction *aJournal;
   TAction *aNReadCurr;
   TAction *aNewGroup;
    TAction *aState;
    TToolBar *ToolBar1;
    TToolButton *ToolButton1;
    TToolButton *ToolButton2;
    TToolButton *ToolButton3;
    TToolButton *ToolButton4;
    TToolButton *ToolButton5;
    TToolButton *ToolButton6;
  TToolButton *ToolButton7;
  TAction *aQuick;
    TEdit *eUsdPassword;
    TEdit *eUsdName;
    TLabel *lUser;
    TLabel *lPassword;
  TCheckBox *cbBlockingTime;
  TAction *aNLockCorrectTime;
  TPanel *Panel2;
  TPanel *Panel14;
  TPanel *Panel3;
  TComboBox *cbScan;
  TOraQuery *oqEditReqPlan;
  TEdit *lbId;
  TToolButton *tbFind;
  TToolButton *ToolButton8;
  TPanel *Panel4;
  TEdit *eDopParam;
  TToolButton *tbNP;
  TAction *iaRTR56;
  TButton *btAddParam;
  TOraQuery *oqSaveP;
  TToolButton *ToolButton9;
  TAction *iaRTR;
  TToolButton *ToolButton10;
  TToolButton *ToolButton11;
	void __fastcall tvChannelsListChange(TObject *Sender, TTreeNode *Node);
	void __fastcall ControlChange(TObject *Sender);
   void __fastcall FormShow(TObject *Sender);
   void __fastcall tvChannelsListChanging(TObject *Sender, TTreeNode *Node,
      bool &AllowChange);
   void __fastcall edLongPress(TObject *Sender, char &Key);
   void __fastcall tvChannelsListDeletion(TObject *Sender, TTreeNode *Node);
   void __fastcall aExecute(TObject *Sender);
   void __fastcall tvChannelsListExpColl(TObject *Sender, TTreeNode *Node);
   void __fastcall tvChannelsListExpanding(TObject *Sender,
          TTreeNode *Node, bool &AllowExpansion);
   void __fastcall tvChannelsListDragOver(TObject *Sender, TObject *Source,
          int X, int Y, TDragState State, bool &Accept);
   void __fastcall tvChannelsListDragDrop(TObject *Sender, TObject *Source,
          int X, int Y);
   void __fastcall aNewGroupExecute(TObject *Sender);
   void __fastcall tvChannelsListMouseDown(TObject *Sender,
          TMouseButton Button, TShiftState Shift, int X, int Y);
   void __fastcall aMExecute(TObject *Sender);
    void __fastcall aStateExecute(TObject *Sender);
  void __fastcall aQuickExecute(TObject *Sender);
        void __fastcall mMonClick(TObject *Sender);
  void __fastcall cbScanChange(TObject *Sender);
  void __fastcall iaFindExecute(TObject *Sender);
  void __fastcall WM_SetActiveNode(TMessage& Message);
  void __fastcall iaMTXExecute(TObject *Sender);
  void __fastcall iaRTR56Execute(TObject *Sender);
  void __fastcall btAddParamClick(TObject *Sender);
  void __fastcall iaRTRExecute(TObject *Sender);
private:	// User declarations
   struct stChannel{ // Атрибуты канала
      long Cid;//                Ид канала                          N
      char Name[128];//          Название                           N
      char Note[2000];//         Примечание                         Y
      long PROTOCOL_ID;  //      Ид протокола	                  Y
      long COM_ID;//             Ид компорта                        Y
      char INIT_STR[200];//      Строка инициализации               Y
      char ADDR[100];//          Коммуникационый адресс             Y
      long CYCLE_TOUT;  //       Пауза между циклами                Y
      long RETRIES;      //      Кол попыток соединения             Y
      long RETRIES_TOUT; //      Пауза между попытками              Y
      long BLOCKING;      //     Блокировка                         N
      char Caller_Name[200];//   Название опросчика                 Y
      long NBILLDATA;//          Коммерческие                       N
      long NBILLDATADEPTH;//     Коммерческие глубина               Y    1
      long NCURRDATA;//          Вычитка 3-х минуток                N
      long NCURRDATADEPTH;//     3-х минутки глубина                Y    2
      long NNETPARAM;//          Параметры сети                     N
      long NJOURNAL;//           Журнал событий                     N
      char DSTART[6];//          Начало опроса  (hh24:mi)           Y    3
      char DEND[6];//            Окончание      (hh24:mi)           Y    4
      long NDAY;//               День                               Y    5
      short indicator[6];//    Флаги для контроля 4-мя long и две даты
      long NPARENT;//            Главный канал                      Y    6
      long NREADCUR; // не читать текущие сутки
      long editing;// 0 -Не трогали, 1-добавили, 2-редактировали
      long tmpCid;//    Нужно при сохранении
      long iConnTimeWait;// Время ожидания установки соединения в сек.
      char eUsdName[300];
      char eUsdPassword[300];
      long LOCKCORRECTTIME;      //     Блокировка коррекции времени N
      char DopParam[128]; //Дополнительные параметры
      TList *lsdopperiod;
      long editingperiod;// 0 -Не трогали, 2-редактировали
   };
    long __fastcall getNodeId(TObject*obj){
        TTreeNode*tn=dynamic_cast<TTreeNode*>(obj);
        if(tn)  return ((stChannel*)tn->Data)->Cid;
        else    return 0;
    }
   TfmFindPoint *fmFP;
   bool ChangeControl;
   stChannel *SelChannel;
   long *nPoints_Del; // id тех каналов которые удалены списка
                              //  и необходимо удалить из таблицы каналов
   int Points_Del_Count;
   long nsrv;
   //int CurrentScan;  //выбранный опросчик
   int OldScanIndex;
   bool __fastcall GetCombo(TComboBox *cb);
   bool __fastcall ReadChannelNode(TObject* pTreeNode); // Читает ветку каналов
   void __fastcall SetAccess(TAccess value);
   bool __fastcall AcceptNode(TTreeNode*,TTreeNode*);
   inline bool __fastcall IsChannel(TTreeNode*);
   void __fastcall changeNode(TTreeNode*, TTreeNode*);
   void __fastcall copyChildNodes(TTreeNode*,TTreeNode*);
   bool __fastcall IsOperStart(long cid);
   bool __fastcall IsRTR(long prot_id);
   void __fastcall SaveP(TTreeNode*);
public:		// User declarations
	__fastcall TfmEditRequestPlan(TComponent* Owner, AnsiString, TAccess = accDenied);
protected:
   void __fastcall vSave(TObject* Sender);
   void __fastcall vBlock(TObject* Sender);
   void __fastcall vUnblock(TObject* Sender);
   void __fastcall vPoints(TObject* Sender);
   void __fastcall vNew(TObject *Sender);
   void __fastcall vDelete(TObject* Sender);
   void __fastcall vClone(TObject* Sender);
   void __fastcall vRefresh(TObject* Sender);
   void __fastcall vEditClick(TObject*);
   void __fastcall vAnyEditClick(TObject*);
   __fastcall ~TfmEditRequestPlan();
};
//---------------------------------------------------------------------------
#endif
