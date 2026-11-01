//---------------------------------------------------------------------------
#ifndef InteriorExOpFormH
#define InteriorExOpFormH
//---------------------------------------------------------------------------
#include "Interior.h"
#include <OleCtnrs.hpp>
//---------------------------------------------------------------------------
class TInteriorExOpFormPriv;
//---------------------------------------------------------------------------
class TInteriorExOpForm : public TInterior
{
  public:
    __fastcall TInteriorExOpForm(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
    virtual __fastcall ~TInteriorExOpForm(void);
    virtual void __fastcall Invalidate(int Table);
    virtual void __fastcall Place(void);
    void PrintActiveSheet();
    void Preview();
    void DoVerb();// Для активации Excela в окне АСКУЭ
    void __fastcall PrintRep();
    void __fastcall SaveRepToFile(TSaveDialog *aSaveDialog);
    //chig
    void __fastcall PassParamsToExcel();
    void __fastcall PassParamsToExcelAndRefr();
    //e chig
  private:
    int NumAlert;
    long CountSheets;
    TOleContainer *ocCont;
    AnsiString ExcelWindowName;
    WideString fName;

  TInteriorExOpFormPriv *d;
};
//---------------------------------------------------------------------------
#endif
