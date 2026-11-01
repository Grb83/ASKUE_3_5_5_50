//---------------------------------------------------------------------------
#ifndef InteriorExRepH
#define InteriorExRepH

#include "Interior.h"
#include <OleCtnrs.hpp>
//---------------------------------------------------------------------------
class TInteriorExRepPriv;
//---------------------------------------------------------------------------
class TInteriorExRep : public TInterior
{
  public:
    __fastcall TInteriorExRep(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
    virtual __fastcall ~TInteriorExRep(void);
    virtual void __fastcall Invalidate(int Table);
    virtual void __fastcall Place(void);
    void NextSheet();
    void PreviousSheet();
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
    int CurrentSheet;
    long CountSheets;
    int NumAlert;
    TOleContainer *ocCont;
    AnsiString ExFileName;
    AnsiString ExcelWindowName;
    WideString fName;
    //void __fastcall CreateExcelFile();

    TInteriorExRepPriv  *d;
};
//---------------------------------------------------------------------------
#endif
