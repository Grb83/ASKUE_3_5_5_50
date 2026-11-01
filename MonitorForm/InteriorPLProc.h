//---------------------------------------------------------------------------
#ifndef InteriorPLProcH
#define InteriorPLProcH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <Menus.hpp>
#include "Interior.h"
#include <OleCtnrs.hpp>
//---------------------------------------------------------------------------
class TInteriorPLProc : public TInterior
{
  public:
    __fastcall TInteriorPLProc(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
    virtual __fastcall ~TInteriorPLProc(void);
    virtual void __fastcall Invalidate(int Table);
    virtual void __fastcall Place(void);
    virtual void __fastcall PrintRep();
    virtual void __fastcall SaveRepToFile(TSaveDialog *aSaveDialog);
    static void __fastcall LoadReportData(TRichEdit* reData);
    static void __fastcall WriteRepToFile( AnsiString PPName, int PPPrintMode,TRichEdit* reTmp);
    static void __fastcall UnivPrintRep(TComponent* Owner,int lMode,TRichEdit* reTmp);
    static void __fastcall UnivSaveRepToFile(TSaveDialog *aSaveDialog,TRichEdit* reTmp);
    static bool __fastcall isStickCharInReport (TRichEdit* reTmp, int PPPrintMode);
  private:
    int NumAlert;
    TOleContainer* ocCont;
    TRichEdit* REdit;
};
#endif
