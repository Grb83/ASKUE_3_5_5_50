//---------------------------------------------------------------------------
#ifndef EditFidersH
#define EditFidersH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <Db.hpp>
#include <DBCGrids.hpp>
#include <DBCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Forms.hpp>
#include <ImgList.hpp>
#include <Mask.hpp>
#include <StdCtrls.hpp>
#include <Menus.hpp>
#include "Main.h"
#include "VirtualTable.hpp"
#include "EditCounter.h"
#include <ToolWin.hpp>
#include <DB.hpp>
#include <dbcgrids.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"

#define COUNTNULLLOSS  16
#define COUNTNULLPOINTS  8
#define UKRAINE_ZONE "Торговая зона Украина"
#define BURSHTIN_ZONE "Торговая зона Бурштын"
#define UKRAINE_ZONE_CODE "62Y-MGA-00000--W"
#define BURSHTIN_ZONE_CODE "62Y-MGA-00001--S"
#define PANEL31_HEIGHT_SMALL 49
#define PANEL31_HEIGHT_WITH_CHECKBOX 85
#define PANEL31_HEIGHT_ALL 289


//---------------------------------------------------------------------------
class TFormEditFiders : public TMainForm
{
__published:	// IDE-managed Components
	TPanel *Panel7;
	TPanel *Panel8;
    TTreeView *TreeView1;
    TActionList *ActionList1;
    TAction *aInsGroup;
    TAction *aEdit;
    TPanel *Panel3;
    TPanel *Panel4;
    TDataSource *dsMain;
    TPopupMenu *pmUSDList;
    TMenuItem *miCapUSDList;
    TMenuItem *miSepUSDList;
    TAction *aIntellect;
    TAction *aQuadr;
    TAction *aEarthing;
    TAction *aBypasser;
    TAction *aCheckBill;
    TAction *aCheckMonth;
    TAction *aInverted;
    TAction *aDataAbsence;
    TPopupMenu *pmDuplList;
    TMenuItem *miCapDuplList;
    TMenuItem *miSepDuplList;
    TAction *aChannelList;
    TAction *aGroupList;
    TAction *aLastSave;
    TToolBar *tbTools;
    TToolButton *tbNew;
    TToolButton *tbNewGroup;
    TToolButton *tbDel;
    TToolButton *tbMetEdit;
    TToolButton *btChannels;
    TToolButton *tbGroups;
    TToolButton *tbLastSave;
    TToolButton *ToolButton8;
    TToolButton *tbRclcData;
    TToolButton *tbDelData;
    TAction *aRclcData;
    TAction *aDelData;
        TPopupMenu *pmAddNode;
        TMenuItem *N3;
        TMenuItem *N6;
        TAction *iaNewCalcNode;
        TMenuItem *N7;
        TMenuItem *N8;
  TToolButton *ToolButton1;
  TToolButton *tbFind;
  TToolButton *ToolButton2;
  TToolButton *ToolButton3;
  TAction *acSampleHours;
  TOraQuery *oqSaveLoss;
  TOraQuery *oqSavePointTimeInfo;
  TOraQuery *oqSavePointCalcParam;
  TToolButton *tbMaket;
  TAction *aMaketList;
  TToolButton *ToolButton4;
  TToolButton *ToolButton5;
  TAction *acMeterParameter;
  TAction *aNodeUp;
  TAction *aNodeDown;
  TSpeedButton *sbUp;
  TSpeedButton *sbDown;
  TPopupMenu *pmOppositeList;
  TMenuItem *N9;
  TMenuItem *N10;
  TToolButton *tbGuid;
  TAction *aGuid;
  TToolButton *tbSpezParam;
  TToolButton *tbLimit2;
  TAction *aSpezPar;
  TAction *aBorder2Par;
  TPageControl *pcMain;
  TTabSheet *tsParam;
  TPanel *paOldEdit;
  TScrollBox *ScrollBox1;
  TPanel *paEdit;
  TPanel *Panel10;
  TLabel *Label3;
  TLabel *lCode;
  TEdit *Edit12;
  TEdit *eCode;
  TPanel *Panel11;
  TPanel *Panel9;
  TPanel *Panel43;
  TEdit *Edit3;
  TEdit *Edit4;
  TEdit *Edit5;
  TEdit *Edit6;
  THeaderControl *HeaderControl1;
  TPanel *Panel12;
  TPanel *Panel18;
  TPanel *Panel15;
  TPanel *Panel16;
  TLabel *Label32;
  TCheckBox *CheckBox1;
  TCheckBox *CheckBox2;
  TEdit *Edit7;
  TCheckBox *cbBlockAutomaticPoll;
  TCheckBox *CheckBox5;
  TPanel *plUSDPoints;
  TSpeedButton *btnUSDDrop;
  TSpeedButton *btnUSDSelect;
  TSpeedButton *sbUSDList;
  TEdit *eUSDPoint;
  TPanel *plDuplPoints;
  TSpeedButton *btnMainDrop;
  TSpeedButton *btnMainSelect;
  TSpeedButton *sbMainList;
  TEdit *eDuplPoint;
  TPanel *Panel17;
  TPanel *Panel20;
  TPanel *plUFirst;
  TEdit *Edit9;
  TPanel *plIFirst;
  TEdit *Edit10;
  TPanel *plKMeter;
  TEdit *Edit16;
  TPanel *plCellNum;
  TEdit *Edit8;
  TPanel *plKC;
  TEdit *Edit15;
  TPanel *plUSecond;
  TEdit *Edit14;
  TPanel *plISecond;
  TEdit *Edit11;
  TPanel *plAddInfo;
  TEdit *Edit13;
  TPanel *plOV;
  TCheckBox *CheckBox3;
  TCheckBox *CheckBox4;
  TCheckBox *InvertedCB;
  TPanel *plTimeZoneW;
  TComboBox *cbTimeZoneW;
  TPanel *plTimeZoneS;
  TComboBox *cbTimeZoneS;
  TPanel *Panel19;
  TPanel *Panel21;
  TPanel *Panel32;
  TPanel *Panel33;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label6;
  TLabel *Label7;
  TEdit *Edit18;
  TEdit *Edit17;
  TEdit *Edit19;
  TEdit *Edit20;
  TPanel *Panel34;
  TEdit *Edit21;
  TPanel *Panel22;
  TPanel *plIClassTN;
  TEdit *edClassTN;
  TPanel *plIClassTT;
  TEdit *edClassTT;
  TPanel *Panel51;
  TPanel *Panel53;
  TSpeedButton *SpeedButton1;
  TSpeedButton *sbOpposit;
  TSpeedButton *sbOppList;
  TEdit *eOpp;
  TPanel *Panel54;
  TPanel *Panel55;
  TPanel *Panel31;
  TLabel *Label4;
  TLabel *Label5;
  TEdit *Edit1;
  TEdit *Edit2;
  TTabSheet *tsMainSpec;
  TPanel *plParamSpec;
  TPanel *Panel47;
  TLabel *Label33;
  TLabel *Label35;
  TLabel *Label36;
  TLabel *Label37;
  TEdit *Edit22;
  TEdit *Edit23;
  TEdit *Edit24;
  TCheckBox *CheckBox7;
  TEdit *eCode4;
  TPanel *Panel48;
  TPanel *Panel27;
  TPanel *Panel28;
  TPanel *Panel29;
  TPanel *Panel30;
  TButton *btLimit;
  TPanel *Panel49;
  TPanel *Panel52;
  TPanel *Panel50;
  TEdit *eOpposite;
  TPanel *Panel58;
  TSpeedButton *sbOpposite;
  TSpeedButton *sbDelOpposite;
  TSpeedButton *sbListOpposite;
  TPanel *paCalcPoint2;
  TTabSheet *tsAddParam;
  TScrollBox *Panel1;
  TPanel *paAddParam;
  TPanel *paCalcType;
  TPanel *Panel35;
  TPanel *Panel36;
  TCheckBox *CalcBillCB;
  TCheckBox *CalcMonthCB;
  TPanel *paTime;
  TPanel *Panel37;
  TPanel *Panel38;
  TLabel *Label26;
  TLabel *Label27;
  TEdit *edTw;
  TEdit *edTf;
  TBitBtn *btSetTime;
  TPanel *paCalcPoint1;
  TPanel *paCalcPoint;
  TPanel *Panel40;
  TPanel *Panel41;
  TPanel *paCalcGroup;
  TSpeedButton *sbGroupDrop;
  TSpeedButton *sbGroupSel;
  TEdit *eGroup;
  TPanel *paCalcFormula;
  TSpeedButton *sbDeleteFormula;
  TSpeedButton *sbFormula;
  TEdit *edFormula;
  TPanel *Panel23;
  TLabel *Label49;
  TLabel *Label50;
  TLabel *Label51;
  TComboBox *cbCalcType;
  TEdit *edCurrPower;
  TEdit *edMonthConsumpt;
  TBitBtn *btCalcParam;
  TPanel *Panel5;
  TPanel *Panel39;
  TPanel *Panel42;
  TLabel *lTech;
  TLabel *lComm;
  TEdit *eComm;
  TEdit *eTech;
  TCheckBox *cbDataAbsence;
  TPanel *plVerifyBase;
  TPanel *plVerifyParam;
  TEdit *eVerifyParam;
  TPanel *plVerifyTitle;
  TPanel *pAddParamBase;
  TPanel *pAddParam;
  TEdit *eAddParams;
  TPanel *pAddParamTitle;
  TPanel *pImportCodeBase;
  TPanel *pImportCode;
  TEdit *eImportCode;
  TPanel *pImportCodeTitle;
  TPanel *plVerifyBaseDay;
  TPanel *plVerifyDay;
  TEdit *eVerifyDay;
  TPanel *plVerifyTitleDay;
  TPanel *Panel26;
  TPanel *Panel14;
  TButton *btTU;
  TPanel *Panel6;
  TPanel *Panel44;
  TTabSheet *tsLoss;
  TScrollBox *sbLoss;
  TPanel *paLoss;
  TPanel *paSimpleLoss;
  TLabel *Label23;
  TLabel *Label24;
  TLabel *Label25;
  TEdit *edLineLoss;
  TEdit *edATrLoss;
  TEdit *edRTrLoss;
  TPanel *Panel13;
  TLabel *Label22;
  TLabel *Label29;
  TComboBox *cbLossType;
  TComboBox *cbCalcR;
  TPanel *paFormulaLoss;
  TDBCtrlGrid *DBCtrlGrid1;
  TLabel *Label28;
  TLabel *Label10;
  TLabel *Label11;
  TLabel *Label18;
  TLabel *Label12;
  TLabel *Label13;
  TLabel *Label14;
  TLabel *Label15;
  TLabel *Label16;
  TLabel *Label17;
  TLabel *Label19;
  TLabel *Label20;
  TLabel *Label21;
  TLabel *Label30;
  TLabel *Label31;
  TDBText *DBText2;
  TBevel *Bevel1;
  TLabel *Label8;
  TDBEdit *DBEdit13;
  TDBEdit *DBEdit1;
  TDBEdit *DBEdit7;
  TDBEdit *DBEdit5;
  TDBEdit *DBEdit8;
  TDBEdit *DBEdit9;
  TDBEdit *DBEdit2;
  TDBEdit *DBEdit3;
  TDBEdit *DBEdit4;
  TDBEdit *DBEdit6;
  TDBEdit *DBEdit10;
  TDBEdit *DBEdit11;
  TDBEdit *DBEdit12;
  TDBCheckBox *DBCheckBox1;
  TDBEdit *DBEdit14;
  TDBCheckBox *DBCheckBox2;
  TDBEdit *DBText1;
  TDBEdit *DBEdit15;
  TPanel *Panel2;
  TBitBtn *btAddParam;
  TBitBtn *btDelParam;
  TBitBtn *btSetFormula;
  TBitBtn *btSetTimeP;
  TToolButton *tbKoeff;
  TToolButton *tbPrior;
  TSpeedButton *sbKMeter;
  TSpeedButton *sbKC;
  TToolButton *tbURD;
  TAction *aURD;
  TLabel *lSource;
  TPanel *Panel24;
  TLabel *Label38;
  TLabel *lSource2;
  TComboBox *cbIntgr;
  TLabel *lbIntegr;
  TCheckBox *cbNLockSwitch;
  TCheckBox *cbNLockSwitch1;
  TPanel *Panel25;
  TPanel *Panel45;
  TPanel *Panel65;
  TComboBox *cbTimeZoneW_1;
  TPanel *Panel66;
  TComboBox *cbTimeZoneS_1;
  TPanel *Panel67;
  TCheckBox *cbDataWithOB;
  TOraQuery *oqCursor2;
  TToolButton *tbOccurr;
  TAction *aOccurr;
  TEdit *eDopNum;
  TLabel *lbDopNum;
  TPanel *Panel46;
  TLabel *lbNote;
  TMemo *mNote;
  TPanel *Panel56;
  TLabel *Label39;
  TMemo *mNote2;
  TOraQuery *oqGetAcc;
  TToolButton *tbclonFormul;
  TOraQuery *oqClonF;
  TLabel *Label40;
  TEdit *Edit25;
  TLabel *Label9;
  TEdit *lbId;
  TLabel *lbCapStateOFF;
  TLabel *lbStateOFF;
        TOraQuery *oqGetCompanyInfo; //запрос на выборку данных из базы о кодах и названиях торговых зон
        TEdit *Edit28; //Поле ввода EIC-кода для обобщённой точки учёта (у которой с_type = 4)
        TLabel *Label46;// "Код EIC" для точки
        TRadioGroup *RadioGroup2; //Выбор входит или нет точка в EIC на форме редактирования точки (2-я закладка Основные Параметры) ItemIndex = 0 - не входит, 1 - входит
        TRadioGroup *RadioGroup1; //Выбор с_type при вводе группы с EIC и показ пользователю иерархии при просмотре группы. ItemIndex = 0 - торговая зона, 1 - область учёта, 2 - потребитель.
        TEdit *Edit26;  //Поле ввода EIC-кода для группы учёта (у которой с_type = [1,2,3])
        TLabel *Label41; //Код EIC
        TComboBox *ComboBox1;// Выбор имени торговой зоны Украина-Бурштын при вводе группы с c_type = 1. В обработчике оnChange для него меняется код торговой зоны в Edit26 и Enabled меняется на false.
        TLabel *Label44; // "Торговая зона"
   //END ADD
    void __fastcall TreeView1Expanding(TObject *Sender, TTreeNode *Node,
           bool &AllowExpansion);
    void __fastcall TreeView1Changing(TObject *Sender, TTreeNode *Node,
           bool &AllowChange);
    void __fastcall TreeView1Change(TObject *Sender, TTreeNode *Node);
    void __fastcall TreeView1Deletion(TObject *Sender, TTreeNode *Node);
    void __fastcall FormShow(TObject *Sender);
    void __fastcall EditChange(TObject *Sender);
    void __fastcall CheckBoxClick(TObject *Sender);
    void __fastcall edLongKeyPress(TObject *Sender, char &Key);
    void __fastcall edDoubleKeyPress(TObject *Sender, char &Key);
    void __fastcall tvMainExpCol(TObject *Sender, TTreeNode *Node);
    void __fastcall TreeView1DragOver(TObject *Sender, TObject *Source,
           int X, int Y, TDragState State, bool &Accept);
    void __fastcall TreeView1DragDrop(TObject *Sender, TObject *Source,
           int X, int Y);
    void __fastcall btInsGroupClick(TObject *Sender);
    void __fastcall btEditClick(TObject *Sender);
    void __fastcall Edit3Exit(TObject *Sender);
    void __fastcall Edit4Exit(TObject *Sender);
    void __fastcall Edit5Exit(TObject *Sender);
    void __fastcall Edit6Exit(TObject *Sender);
    void __fastcall cbChange(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall btAddParamClick(TObject *Sender);
    void __fastcall btDelParamClick(TObject *Sender);
    void __fastcall TableAfterEdit(TDataSet *DataSet);
    void __fastcall TableAfterDelete(TDataSet *DataSet);
    void __fastcall TableAfterInsert(TDataSet *DataSet);
    void __fastcall DisplayLoss(TTreeNode *Node);
    void __fastcall btSetTimeClick(TObject *Sender);
    void __fastcall btSetTimePClick(TObject *Sender);
    void __fastcall btnUSDDropClick(TObject *Sender);
    void __fastcall btnUSDSelectClick(TObject *Sender);
    void __fastcall OnUSDListClick(TObject *Sender);
    void __fastcall sbUSDListClick(TObject *Sender);
    void __fastcall miCapUSDListDrawItem(TObject *Sender, TCanvas *ACanvas,
           TRect &ARect, bool Selected);
    void __fastcall CopyClick(TObject *Sender);
    void __fastcall PasteClick(TObject *Sender);
    void __fastcall aCbExecute(TObject *Sender);
    void __fastcall btSetFormulaClick(TObject *Sender);
    void __fastcall btCalcParamClick(TObject *Sender);
    void __fastcall aMExecute(TObject *Sender);
    void __fastcall btnAddListClick(TObject *Sender);
    void __fastcall btnLastSaveClick(TObject *Sender);
    void __fastcall iaMonExecute(TObject *Sender);
    void __fastcall MonSelectClick(TObject *Sender);
    void __fastcall btnMainSelectClick(TObject *Sender);
    void __fastcall btnMainDropClick(TObject *Sender);
    void __fastcall sbMainListClick(TObject *Sender);
    void __fastcall aRclcDataExecute(TObject *Sender);
    void __fastcall aDelDataExecute(TObject *Sender);
        void __fastcall tbNewClick(TObject *Sender);
        void __fastcall iaNewCalcNodeExecute(TObject *Sender);
  void __fastcall btTUClick(TObject *Sender);
  void __fastcall acSampleHoursExecute(TObject *Sender);
  void __fastcall sbGroupSelClick(TObject *Sender);
  void __fastcall sbGroupDropClick(TObject *Sender);
  void __fastcall acMeterParameterExecute(TObject *Sender);
  void __fastcall cbTimeZoneChange(TObject *Sender);
  void __fastcall btSpezParamClick(TObject *Sender);
  void __fastcall btLimitClick(TObject *Sender);
  void __fastcall sbDelOppositeClick(TObject *Sender);
  void __fastcall aNodeUpExecute(TObject *Sender);
  void __fastcall aNodeDownExecute(TObject *Sender);
  void __fastcall sbListOppositeClick(TObject *Sender);
  void __fastcall sbOppositClick(TObject *Sender);
  void __fastcall sbFormulaClick(TObject *Sender);
  void __fastcall sbDeleteFormulaClick(TObject *Sender);
  void __fastcall aGuidExecute(TObject *Sender);
  void __fastcall aSpezParExecute(TObject *Sender);
  void __fastcall aBorder2ParExecute(TObject *Sender);
  void __fastcall tbKoeffClick(TObject *Sender);
  void __fastcall tbPriorClick(TObject *Sender);
  void __fastcall sbKMeterClick(TObject *Sender);
  void __fastcall aURDExecute(TObject *Sender);
  void __fastcall cbIntgrChange(TObject *Sender);
  void __fastcall PopupMenu1Popup(TObject *Sender);
  void __fastcall miManualInpClick(TObject *Sender);
  void __fastcall tbclonFormulClick(TObject *Sender);
  void __fastcall mnONOFFClick(TObject *Sender);
  //GRB ADD 30.05.2019

  void __fastcall RadioGroup1Click(TObject *Sender);//выбор для группы иерархии вхождения в mms (1 - торговая зона, 2 - область учёта, 3 - поставщик)
  void __fastcall EICCheckboxClick (TObject *Sender);//обработчик динамического чекбокса управляющего признаком вхождения в EIC
  void __fastcall addEICCheckBoxOnPanel (TObject *Sender); //добавляем checkbox(если нету) на панель динамикой
  void __fastcall removeEICCheckBoxOnPanel (TObject *Sender);//убираем checkbox(если есть) с панели динамикой
        void __fastcall RadioGroup2Click(TObject *Sender);//выбор для точки признака вхождения/не вхождения в EIC
  TStringList* __fastcall getTradeZones (AnsiString codeZone1, AnsiString codeZone2, bool is1, bool is2); // собираем список торговых зон (Украина-Бурштын по вытянутому из базы в oqGetCompanyInfo)
  void __fastcall hideTradeZones();//скрываем комбо-бокс с торговыми зонами если это не торговые зоны
  void __fastcall showTradeZones();//показываем комбо-бокс с торговыми зонами если стоим на "торговой зоне" в радиогруппе1
  AnsiString __fastcall getCodeZoneByName (AnsiString zoneName); // код торговой зоны (Украина-Бурштын) по её имени. Берётся не из базы а из констант, потенциальная дыра если будут другие торговые зоны
  void __fastcall changePanel31Height(int state);//меняет ширину панели при переходе в дереве на группу в 3 возможных состояния - [1 - имя и краткое имя(49px), 2 - оно же + чекбокс ММС EICCheckbox - 85 px, 3 - всю формаму с полями EIC - 289 px
  int __fastcall getPanel31HeightState (); //по аналогии с предыдущей вертает какое текущее состояние у панели - [1,2,3]
  void __fastcall ComboBox1Change(TObject *Sender);// подтяжка кода торговой зоны в поле кода для выбранной зоны при переключении

  //END ADD
  private:	// User declarations
    //GRB ADD 30.05.2019
  //структура, использующаяся в 2-х контекстах - для вычитки спецификации предприятия - тогда используются все поля - и для добавки mms информации в элемент дерева - тогда в ней заполняются ТОЛЬКО поля veic_code, c_type, mms
  struct EIC_INFO{
  AnsiString vfullname;
  AnsiString vshortname;
  AnsiString mms;
  AnsiString veic_code;
  AnsiString c_type;
  AnsiString tradeZoneUkr;
  AnsiString tradeZoneBrsht;
  bool isTradeZoneUkr;
  bool isTradeZoneBrsht;
  };
  //EIC_INFO getCompanyInfo (TObject *Sender);
  EIC_INFO getCompanyInfoGlobal (TObject *Sender, TStringList** companyList); //формирует как globalCompanyInfo в начале работы так и tradeZonesGlobalList для ComboBox1
  EIC_INFO globalCompanyInfo; // хранит единожды вытянутое при помощи getCompanyInfoGlobal
  TStringList* tradeZonesGlobalList;  // хранит единожды вытянутый списк торговых зон при помощи getCompanyInfoGlobal
  //END ADD
    TVirtualTable *VT_Data;
    struct DELLOSSINFO{
        long nconnectionparam;
        long mid;
        DELLOSSINFO(){ZeroMemory(this,sizeof(*this));}
    };
    struct POINTSDIV{ //дерево обьектов учета
        long Mid;
        long tmpMid;
        long Type; //= 1 - enterprise, 2-station, 3-point , 4-точка учета
        char Name[148];
        char Short_Name[48];
        long ER_POSITION;	//NUMBER, активная принятая энергия
        long Q1_POSITION;	//NUMBER, реактивная принятая энергия
        long ED_POSITION;	//NUMBER, активная отданая энергия
        long Q3_POSITION;	//NUMBER, реактивная отданая энергия
        long SMART;	//VARCHAR2(1), признак интел. счетчика
        long Q1234;	//VARCHAR2(1),реактивная энергия по квадрантам
        int CANAL;		//NUMBER, канал
        char CELLNUM[10];	    //NUMBER, номер ячейки
        double POWER1;		//NUMBER, напряжение перв
        double POWER2;		//NUMBER, напряжение втор
        double CURRENT1;	//NUMBER, А перв
        double CURRENT2;	//NUMBER, А втор
        double KC;		    //NUMBER, расчетный коэф.
        double MeterKC;		    //NUMBER, коэф. счетчика
        long nabs;            //заземленная нейтраль
        long Tag;
        char v_info[256]; // Доп. инфо. используется для L&G
        long editing;// 0 -Не трогали, 1-трогали и скопировали, 2-трогали и не скопировали
        TList *pcounter;
        int editcount;
        long ncalcbill;       //верифицировать суточные
        long ncalcmonth;      //верифицировать месячные
        long ninverted;//инверсия
        long nDataWithOB;//Данные с учетом ОВ
        long nswitch;//Обходник
        long NLockSwitch;//не переходит на ОВ
        long nlosstype;//Тип потерь
        double nwh;//Время работы
        double nfh;//Полное время работы
        double nlineloss;//Потери в линии
        double ntraloss;//Потери актив в трансформаторе
        double ntrrloss;//Потери реактив в трансформаторе
        short indic[COUNTNULLPOINTS];//    Флаги для контроля Tag,nfh, nwh, nlineloss, ntraloss, ntrrloss,ncurrpower,nmonthconsumpt
        TList *ploss;
        DELLOSSINFO delloss[32];
        long countdelloss;
        int editloss;
        long nrecompens;
        long ncalcpointtype;
        TList *pwtimeinfo;
        int edittimeinfo;
        long USDMid;// mid точки, которая является УСД для данной
        char USDText[256];// текст, информация о точке
        bool fUSD; // признак того, что точка является УСД для других точек
        long nblock;
        double ncurrpower;//Установленная мощнотсь
        double nmonthconsumpt;//Среднемесячный расход
        TList *pwcalcparam;
        int editcalcparam;
        long DataAbsence; // Сигнализация отсутствия данных
        long CommControl; // Коммерческий контроль
        short indCommControl;
        long TechControl; // Технический контроль
        short indTechControl;
        long nMainPoint;      // Признак дублирующей точки
        char MainText[256];// текст, информация о основной точке
        long Group; //ид расчет группы
        char GroupText[256];//расчет группа
        bool fMain; // признак того, что точка является основной для других точек
        char verifyParam[256];// Параметры верификации
        char AddParams[512];// Доп. параметры
        char ImportCode[64];// связной код импорта
        char vCode[32];// код точки
        long nblocktime;
        char verifyDay[32];// Параметры верификации суточных
        double classTN; //Класс точности TN
        double classTT; // Класс точности TT
        int ntimezonew, ntimezones;//временной пояс зимой и летом
        long OppositeMid;// id, информация о противоположной точке
        char Opposite[256];// текст, информация о противоположной точке
        int norder;//порядок в дереве по умолчанию 0
        char formula [100];//Измерения вычисляемые по формулам
        char vsource [32];// Наименование источника
        int integr;//Период интеграции
        long  rescanal;//Дополнительный связной номер
        char vnote[256]; //Примечание
        char vaccount[32];// Лиц счет
        int lOFF;//Признак отключения  реле питания потребителя     1-отключен -0 включен иначе неизвестно 
        char vOFF[32];// Дата отключения  реле питания потребителя
        //GRB ADD 30.05.2019
        EIC_INFO eic_info;
        POINTSDIV(){ZeroMemory(this,sizeof(*this));}
    };
    struct POINTLOSS{
        long nsobst;
        long nconnectionparam;
        long tmpnconnectionparam;
        long mid;
        char vname[128];
        double nsn;
        double nsh;
        double ndeltapidling;
        double ndeltapsc;
        double niidling;
        double nusc;
        double nro;
        double nxo;
        double nl;
        double nun;
        double nenergypercent;
        long nworkinghours;
        long nfullhours;
        long nnotincludeconsump;
        long nparallelconnection;
        short indic[COUNTNULLLOSS];//    Флаги для контроля vname - nfullhours,nparallelconnection
        long editing;
        TList *pwtimeinfo;
        int edittimeinfo;
        double nrenergypercent;
        long nprocent;
        long pMid;
        char linf[COUNTNULLLOSS];
        POINTLOSS(){ZeroMemory(this,sizeof(*this));}
    }; //Потери по формуле
      TMenuItem* miManIn;
      TMenuItem* miManMetr;
    long nPoints_Del[10000]; // id тех групп которые удалены из дерева
                                //  и необходимо удалить из таблицы POINTS
    long CountPoints_Del; // Кол-во удаляемых групп
    bool realdeletion;
    bool USDPointDeleted; // Признак удаления точки УСД
    long TypeNewNode;
    int TimeZoneUkrW;//Сдвиг Украины зимой
    int TimeZoneUkrS;//Сдвиг Украины летом
    bool __fastcall ReadTreeNode(TObject*pTreeNode);// Читает ветку дерева
    void __fastcall tvDragDrop(TTreeNode* Node, BOOL onKey = FALSE);
    void __fastcall ShowCounter(TTreeNode *Node);
    void __fastcall SaveCounter(TTreeNode *Node);
    void __fastcall SaveLoss(TTreeNode *Node);
    void __fastcall ReplaceList(TObject *Sender,int type, AnsiString ss);
    void __fastcall SetFocusInFirst();
    void __fastcall SetLossInterface();
    void __fastcall SetCalcInterface();
    void __fastcall SetFormulaLossInterface();
    void __fastcall SetButtonLossInterface();
    void __fastcall SetLoss(TTreeNode *Node);
    void __fastcall SavePointTimeInfo(TTreeNode *Node);
    void __fastcall SavePointCalcParam(TTreeNode *Node);
    void __fastcall PostData(void);
    void __fastcall SetAccess(TAccess value);
    void __fastcall CreateNode(long type_node);
    void __fastcall WM_SetActiveNode(TMessage& Message);
    TfmFindPoint *fmFP;
    void __fastcall SetAccMenuOFF(void);
    bool accOFF;
public:		// User declarations
    typedef enum {opNone, opCopy, opMove, opUSDSet, opMainSet} TOperation;
    __fastcall TFormEditFiders(TComponent* Owner, AnsiString, TAccess = accDenied);
   // static void __fastcall createSubMenu_F(TMenuItem*);
    void __fastcall createSubMenu_F(TMenuItem*);
    void __fastcall vFindClick(TObject*);
protected:
	void __fastcall vNew(TObject *Sender);
	void __fastcall vDelete(TObject *Sender);
	void __fastcall vSave(TObject *Sender);
	void __fastcall vRefresh(TObject *Sender);
  TOperation editOperation;
protected:
    void __fastcall ClearUSDRef();
    long __fastcall getNodeId(TObject*obj){
        TTreeNode*tn=dynamic_cast<TTreeNode*>(obj);
        if(tn)  return ((POINTSDIV*)tn->Data)->Mid;
        else    return 0;
    }
    void __fastcall vAnyEditClick(TObject* Sender);
    bool __fastcall AcceptNode(TTreeNode*, TTreeNode*);
    void __fastcall changeNode(TTreeNode*, TTreeNode*);
    void __fastcall vEditClick(TObject*);
    void __fastcall copyChildNodes(TTreeNode*, TTreeNode*);
    __fastcall ~TFormEditFiders();
    void __fastcall getMainList(TPopupMenu* pm, long mid, Classes::TNotifyEvent& OnClick);
    void __fastcall getListOpposite(TPopupMenu* pm, long mid, Classes::TNotifyEvent& OnClick);
    void __fastcall vUpdate(TObject * Sender);
	//GRB ADD 10.09.2020 - Пытаемся сделать отдельно корректную работу с клипбоардом Сtrl+С, Ctrl+V, Ctrl+X по тексту в эдитах и отмену Сtrl+Z c выделением Сtrl+A в эдитах формы
    void __fastcall vAnyEditClickEditFiders(TObject *Sender);
    void __fastcall modifyEdit(TCustomEdit * TCE, AnsiString toEdit);
	//GRB ADD 02.07.2021 - Проверяем
    bool __fastcall checkVerifyDailyByFormat(AnsiString checkParam);
    bool __fastcall checkFloat (AnsiString s, double d);
};
//---------------------------------------------------------------------------
#endif

