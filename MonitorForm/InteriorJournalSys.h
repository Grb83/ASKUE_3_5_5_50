//---------------------------------------------------------------------------
#ifndef InteriorJournalSysH
#define InteriorJournalSysH
#define SAA_MAXCOUNTJOURNALSYS 1000
//---------------------------------------------------------------------------
#include "InteriorJournal.h"
//---------------------------------------------------------------------------
class TJournalInteriorSys : public TJournalInterior
{
public:
	virtual __fastcall TJournalInteriorSys(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
	virtual void __fastcall selectData( TOraQuery *qwInter );
	virtual void __fastcall refreshData( int Table,TOraQuery *qwInter);
	virtual void __fastcall Invalidate( int Table );
	void __fastcall MessageGridDrawColumnCell(
      TObject *Sender, const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State);
	void __fastcall OnClickPanel(System::TObject* Sender);
	virtual void __fastcall Place(void);
    void __fastcall OnClickMenuItemAttr(TObject *Sender);
  virtual void __fastcall SaveTableToFile(TSaveDialog *aSaveDialog);
private:
 /*   typedef struct {  //∆”–Õ¿À  —»—“≈Ã€
	    char Date_Time[20];
        char Name[150];
        char State_Descr[518];
        long State_Cod;
    }MYJOURNAL;  */
	long GetIndexPicture(long i);
	unsigned long selectRows;

};
#endif
