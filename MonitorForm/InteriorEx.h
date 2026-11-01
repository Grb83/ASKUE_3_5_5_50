//---------------------------------------------------------------------------
#ifndef InteriorExH
#define InteriorExH

#include "Interior.h"
#include <OleCtnrs.hpp>
//---------------------------------------------------------------------------
class TInteriorExPriv;
//---------------------------------------------------------------------------
class TInteriorEx : public TInterior
{
  public:
    __fastcall TInteriorEx(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
    virtual __fastcall ~TInteriorEx(void);
    virtual void __fastcall Invalidate(int Table);
    virtual void __fastcall Place(void);
    void __fastcall PrintRep();
    void __fastcall SaveRepToFile(TSaveDialog *aSaveDialog);
    //chig
    void __fastcall PassParamsToExcel();
    void __fastcall PassParamsToExcelAndRefr();
    //e chig
  private:
    TOleContainer* ocCont;
    //AnsiString ExFileName;
    //AnsiString ExcelWindowName;
    //void __fastcall CreateExcelFile();

    TInteriorExPriv *d;
};
#endif
