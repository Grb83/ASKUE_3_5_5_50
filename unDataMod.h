//---------------------------------------------------------------------------

#ifndef unDataModH
#define unDataModH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include "Ora.hpp"
#include "MemDS.hpp"
#include <Db.hpp>
#include "OraScript.hpp"
#include <ExtCtrls.hpp>
#include "DBAccess.hpp"
#include "OdacVcl.hpp"
#include <DB.hpp>
#include "DBGridEh.hpp"
#include "uOraDBConnection.h"
//---------------------------------------------------------------------------
#define CHK_ALL_LIMITS 1 //Контролировать ограничения
#define ONLY_DEMO_VER 0 //Временная версия 0 или дата типа 201306
//---------------------------------------------------------------------------
#define CHK_LIC_POINT 0
#define CHK_LIC_TASK 1
#define CHK_LIC_PROTOCOL 2
#define CHK_LIC_TYPE 3
#define SAA_MAXLICPOINT 8
#define CHK_LIC_TASK_MANUAL 0
#define CHK_LIC_TASK_MONITOR 1
#define CHK_LIC_TASK_GROUP 2
#define CHK_LIC_TASK_CALC 3
#define CHK_LIC_TASK_MAKCREATE 4
#define CHK_LIC_TASK_MAKSEND 5
#define CHK_LIC_TASK_MAKRETRIVE 6
#define CHK_LIC_TASK_MONITORING 7
const int LicPoint[]={0,2,5,10,20,50,100,1000000};//Ограничение количества точек
#define SAA_MAXLICPOINT 8
//---------------------------------------------------------------------------
const TCursor crDragCopy = 1;
const TCursor crDragUsd  = 2;
const TCursor crDragMain = 3;
//---------------------------------------------------------------------------
//AnsiString Uname=AnsiString("T")+AnsiString("es")+AnsiString("t");
//AnsiString Pass=AnsiString("Q")+AnsiString("W")+AnsiString("e");
//---------------------------------------------------------------------------
AnsiString GetRas(AnsiString spred,AnsiString scurr,AnsiString sdig,AnsiString skc,bool &conv,double &proc);
AnsiString SAATrim(AnsiString Str);
void InitGlobalVariable(void);
void SetStringInfo(TStrings *st,AnsiString s,AnsiString field1,AnsiString field2,TOraQuery *quMain);
//---------------------------------------------------------------------------
typedef struct VerInfo{
    AnsiString vver;
    DWORD HVer;
    DWORD LVer;
}TVerInfo;
//---------------------------------------------------------------------------
TVerInfo GetFileVerInfo(AnsiString filename);
//---------------------------------------------------------------------------
// результат выполнения  sql запроса
const AnsiString BASE_SCHEME="RYDA.";
//---------------------------------------------------------------------------
typedef struct {   // структура таблицы пользователей
    int User_Id;
	  AnsiString UserName;
    AnsiString Pasword;
    AnsiString uName;
    int Admin;
    int Role_Id;
}SCONNECT;

typedef struct { //структура таблицы ролей
    int Role_Id;
    int Monitor;
}SROLS;

enum TAccess {accDenied=0, accWrite=1, accRead};
//---------------------------------------------------------------------------
//===== 20.05.2005 Frizyuk A.M. Start
const int TASK_RIGHTS_DISABLE   = -1;
const int TASK_RIGHTS_READ      = 0;
const int TASK_RIGHTS_WRITE     = 1;
const int TASK_RIGHTS_ERROR     = 0xFF;

//===== 20.05.2005 Frizyuk A.M. Finish
//---------------------------------------------------------------------------
extern SCONNECT UsCon;
extern SROLS UserRol;
extern AnsiString ExFileFullName; // Переменная используется для передачи пути файла-шаблона Excel + его имя
extern AnsiString ExFilePuth; // Переменная используется для передачи пути файла-шаблона Excel
extern AnsiString SchemeName; //Имя схемы
extern long customer_id;
extern long period; //текущий период
extern AnsiString ObsoleteTimeLimit;
extern AnsiString EnterpriseName;
extern int StepPROFILE;
extern int LenPROFILE;
extern int PowerProfile;
extern int PowerCoeff;
extern int ShowValidity;
extern int RateZona;
//extern int IsShiftRateZona;
extern int TimeZona;
extern int TimeZonaMid;
extern int IsShiftTimeZona;
//-------------------------------------------------------------------------
extern AnsiString NameUser;
extern AnsiString Password;
//-------------------------------------------------------------------------
class TdmMain : public TDataModule
{
__published:	// IDE-managed Components
  TOraSession *orases;
  TOraQuery *quMain;
  TOraQuery *qwUtil;
  TOraQuery *qwInter;
  TOraQuery *qwIntMaket;
  TOraSession *orasesAlert;
  TOraQuery *qwAlert;
  TOraQuery *qwIntMaket2;
  TOraQuery *oqCursor2;
  TOraQuery *oqInit;
  TOraQuery *oqCursor;
  TOraQuery *oqInterCursor;
  TOraQuery *oqHighLightButtons;
  TOraQuery *oqFormsEX;
  TBlobField *oqFormsEXFILEBODY;
  TOraQuery *oqGTZ;
  TOraQuery *oqAlertTimeZona;
  TOraQuery *oqFindFile;
  TOraQuery *oqMenu_G;
  TTimer *tmStatus;
        TOraQuery *oqCursorUnic;
  void __fastcall DataModuleCreate(TObject *Sender);
  void __fastcall DataModuleDestroy(TObject *Sender);
  void __fastcall orasesAfterConnect(TObject *Sender);
  void __fastcall orasesBeforeConnect(TObject *Sender);
  void __fastcall tmStatusTimer(TObject *Sender);
private:	// User declarations
  long FUserId;
  AnsiString FFam;
  AnsiString FName;
  AnsiString FSecName;
  AnsiString FFullName;
  TStrings* FSrvList;
  TDateTime __fastcall FSystemDate(void);
  int FLicType;//Тип лицензии
  int PointCnt;//Лцензия на количество точек
  int FCanManualOperPoint;//Разрешен оперативный опрос точки
  void __fastcall CheckLicPoint();
//---------------------------------------------------------------------------
public:		// User declarations
  __fastcall TdmMain(TComponent* Owner);
  TVerInfo VerInf;
  __property long userid = {read=FUserId};
  __property AnsiString ufam = {read=FFam};
  __property AnsiString uname = {read=FName};
  __property AnsiString usecname = {read=FSecName};
  __property AnsiString ufullname = {read=FFullName};
  __property TDateTime SystemDate = {read=FSystemDate};
  __property TStrings* SrvList = {read=FSrvList};
  __property int LicType = {read=FLicType};
  __property int CanManualOperPoint = {read=FCanManualOperPoint};
//---------------------------------------------------------------------------
  static void __fastcall UnivSaveRepToFile(TSaveDialog *aSaveDialog,TRichEdit* reTmp);
  static void __fastcall UnivPrintRep(TComponent* Owner,int lMode,TRichEdit* reTmp);
  static void __fastcall WriteRepToFile(AnsiString PPName, int PPPrintMode,TRichEdit* reTmp);
  static void __fastcall SaveTable(TComponent* Owner,TDBGridEh *gr,AnsiString RepCaption);
  static void __fastcall SendToNotepad(TRichEdit* reTmp);
  static AnsiString GetStr(AnsiString LongStr,int Poz,AnsiString Razdel=";");
  static AnsiString __fastcall GetTmpPath(void);
  bool __fastcall GetVerApp();
  void __fastcall SetShiftTimeZona(TDateTime dd);
  void __fastcall SetCommandOff(long lmid,long lcmd);
  int __fastcall GetTaskRights(long roleid, long taskid);
  AnsiString __fastcall GetPointName(long lmid,long ldetal=0,long lshow=0);
  //05.01.2022 - GRB ADD TRY TO FIX checkrights exception
  CRITICAL_SECTION CS;
};
//---------------------------------------------------------------------------
extern PACKAGE TdmMain *dmMain;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
#endif
