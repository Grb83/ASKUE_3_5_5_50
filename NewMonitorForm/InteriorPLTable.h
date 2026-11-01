//---------------------------------------------------------------------------
#ifndef InteriorPLTableH
#define InteriorPLTableH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <Menus.hpp>
#include "Interior.h"
#include "unInteriorUni.h"
#include <OleCtnrs.hpp>
//---------------------------------------------------------------------------
class TInteriorPLTable : public TInterior
{
  public:

    __fastcall TInteriorPLTable(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
    //GRB ADD 23.01.2019 - тестовый вывод 3-х таблиц подряд в одном окне
    __fastcall TInteriorPLTable(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent, int tableNumber );

    virtual __fastcall ~TInteriorPLTable(void);
    virtual void __fastcall Invalidate(int Table);
    virtual void __fastcall Place(void);
    
    virtual void __fastcall PrintRep();
    virtual void __fastcall SaveRepToFile(TSaveDialog *aSaveDialog);
    //GRB ADD
    virtual void __fastcall SaveMultyTableToFile(TSaveDialog *aSaveDialog);

    TfmInteriorUni* FInUn;
  private:
    int NumAlert;
    TOleContainer* ocCont;

  };
#endif
