//---------------------------------------------------------------------------
#ifndef InteriorExRepOutH
#define InteriorExRepOutH

#include "Interior.h"
//---------------------------------------------------------------------------
class TInteriorExRepOutPriv;
//---------------------------------------------------------------------------
class TInteriorExRepOut : public TInterior
{
  public:
    __fastcall TInteriorExRepOut(TComponent* Owner,TSplitterForm *,TFormDescr*,Classes::TNotifyEvent );
    virtual __fastcall ~TInteriorExRepOut(void);
    virtual void __fastcall Invalidate(int Table) {}; // Эта форма не обновляется
    virtual void __fastcall Place(void);
  private:
    TInteriorExRepOutPriv *d;
    void __fastcall PassParamsToExcel();
    void __fastcall PassParamsToExcelAndRefr();
};
//---------------------------------------------------------------------------
#endif  //INTERIOREXREPOUT_H
