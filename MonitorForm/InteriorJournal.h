//---------------------------------------------------------------------------
#ifndef InteriorJournalH
#define InteriorJournalH
#define SAA_MAXCOUNTJOURNAL 1000
//---------------------------------------------------------------------------
#include "Interior.h"
#include "DBGridEh.hpp"
//---------------------------------------------------------------------------
class TJournalInterior : public TInterior
{
public:
    virtual __fastcall TJournalInterior(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
	virtual __fastcall ~TJournalInterior(void);
	virtual void __fastcall selectData( TOraQuery *qwInter );
	virtual void __fastcall refreshData( int Table,TOraQuery *qwInter );
	virtual void __fastcall Invalidate( int Table );
  void __fastcall MessageGridDblClick(TObject *Sender);
	void __fastcall MessageGridDrawColumnCell(
      TObject *Sender, const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State);
	void __fastcall OnClickPanel(System::TObject* Sender);
	virtual void __fastcall Place(void);
	virtual void __fastcall Destroy(void);
  virtual void __fastcall OnClickMenuItemAttr(TObject *Sender);
  virtual void __fastcall SaveTableToFile(TSaveDialog *aSaveDialog);
  virtual void __fastcall MessageGridTitleClick(TColumnEh *Column);
  //GRB ADD 25.02.2020 - фикс бага с вылетом по смене колонок с первой (тут и у наследника - InteriorJournalSys.cpp)
  virtual void __fastcall MessageGridColumnMoved(TObject *Sender,
          int FromIndex, int ToIndex);

protected:
    TDataSource *dsMessage;
    TDBGridEh *MessageGrid;
  /*  typedef struct {  //ЖУРНАЛ  ОПЕРАТОРА
	    char Date_Time[20];
        char Name[150];
        char Message[518];
        long Task_Job;
    }MYJOURNAL;  */
	unsigned long selectRows;
  AnsiString  orderStr;   //! Строка сортировки для запроса
private:
};
//---------------------------------------------------------------------------
#endif
