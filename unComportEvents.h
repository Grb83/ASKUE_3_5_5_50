//---------------------------------------------------------------------------

#ifndef unComportEventsH
#define unComportEventsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <ExtCtrls.hpp>
#include <Mask.hpp>
#include <Dialogs.hpp>
#include <ImgList.hpp>
#include "DBGridEh.hpp"
#include "GridsEh.hpp"
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TfmComportEvents : public TForm
{
__published:	// IDE-managed Components
  TPanel *paBtn;
  TPanel *Panel2;
  TBitBtn *m_btnRefreshData;
  TPanel *paCOM;
  TOraQuery *oqMain;
  TPanel *Panel3;
  TLabel *Label2;
  TDateTimePicker *dtFrom;
  TMaskEdit *edFrom;
  TPanel *Panel7;
  TLabel *Label6;
  TDateTimePicker *dtTill;
  TMaskEdit *edTill;
  TBitBtn *m_btnSave;
  TPanel *Panel1;
  TLabel *Label3;
  TComboBox *cbCOMPort;
  TSaveDialog *SaveDialog1;
  TBitBtn *Go;
  TDBGridEh *MessageGrid1;
  TDataSource *DataSource;
  TBitBtn *btnClose;
  void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
  void __fastcall m_btnCloseClick(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall GoClick(TObject *Sender);
  void __fastcall m_btnSaveClick(TObject *Sender);
  void __fastcall MessageGrid1TitleClick(TColumnEh *Column);
  TDateTime __fastcall FSystemDate(void);
private:	// User declarations
  bool desc1;
  bool desc2;
  bool desc3;
  int ssdID;
  AnsiString defaultCOM;
  int sort;// признак сортировки для запроса
  int zapros_go;
  void __fastcall SortData( void );
public:		// User declarations
  __fastcall TfmComportEvents(TComponent* Owner);
  __fastcall TfmComportEvents(TComponent* Owner, long assdID,
    AnsiString adefaultCOM);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmComportEvents *fmComportEvents;
//---------------------------------------------------------------------------
#endif
