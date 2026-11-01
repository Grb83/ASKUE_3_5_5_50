//---------------------------------------------------------------------------

#ifndef uOraDBConnectionH
#define uOraDBConnectionH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Ora.hpp"
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
struct TConnectParams
{
  TConnectParams();
  TConnectParams(bool aUpdateVertion);
  TConnectParams(bool aUpdateVertion,AnsiString arKey);
  bool UpdateVersion;
  AnsiString rKey;
};
extern bool ConnectDB(TOraSession* OraSession, TConnectParams* ConnectParams);
extern void ReplaceRyda(TComponent *f,AnsiString sts="RYDA.",AnsiString std="AMI.");
extern AnsiString ReplaceRyda(AnsiString s,AnsiString sts="RYDA.",AnsiString std="AMI.");
extern int KeyVer;
class TfmConnect : public TForm
{
__published:	// IDE-managed Components
    TPanel *MainPanel;
    TPanel *BottonPanel;
    TButton *ConnectBtn;
    TButton *Button2;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label3;
    TEdit *dbNameEdit;
    TEdit *dbUserEdit;
    TEdit *dbPasswdEdit;
  TGroupBox *ProfileGBox;
  TComboBox *ProfileCBox;
  TButton *ProfileDeleteBtn;
  TOraQuery *qwVersion;
    void __fastcall ConnectBtnClick(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall ProfileCBoxChange(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall ProfileDeleteBtnClick(TObject *Sender);
private:	// User declarations
    TConnectParams* FConnectParams;
    AnsiString   FdbName, FdbUser, FdbPasswd;
    void __fastcall setdbName(const AnsiString &Value)
    { FdbName           = Value.Trim();
      dbNameEdit->Text  = FdbName;
    };
    void __fastcall setdbUser(const AnsiString &Value)
    { FdbUser           = Value.Trim();
      dbUserEdit->Text  = FdbUser;
    };
    void __fastcall setdbPasswd(const AnsiString &Value)
    { FdbPasswd           = Value.Trim();
      dbPasswdEdit->Text  = FdbPasswd;
    };
public:		// User declarations
    __fastcall TfmConnect(TComponent* Owner,TConnectParams* ConnectParams);
    __property AnsiString   dbName    = {read = FdbName,    write = setdbName};
    __property AnsiString   dbUser    = {read = FdbUser,    write = setdbUser};
    __property AnsiString   dbPasswd  = {read = FdbPasswd,  write = setdbPasswd};

};
//---------------------------------------------------------------------------
#endif
