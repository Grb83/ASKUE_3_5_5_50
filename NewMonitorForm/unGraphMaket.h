//---------------------------------------------------------------------------

#ifndef unGraphMaketH
#define unGraphMaketH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <ActnList.hpp>
#include <ComCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <ToolWin.hpp>
#include <Dialogs.hpp>
#include "math.h "
//---------------------------------------------------------------------------
class TfmGraphMaket : public TForm
{
__published:	// IDE-managed Components
        TChart *chGraph;
        TLineSeries *Series1;
  TImageList *iImageList;
  TToolBar *tbTools;
  TToolButton *tbSave;
  TToolButton *tbPrint;
  TSaveDialog *SaveDialog1;
  TPrintDialog *PrintDialog1;
        void __fastcall chGraphUndoZoom(TObject *Sender);
  void __fastcall FormKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
  void __fastcall tbSaveClick(TObject *Sender);
  void __fastcall tbPrintClick(TObject *Sender);
private:	// User declarations
        int ymin,ymax;
public:		// User declarations
        __fastcall TfmGraphMaket(TComponent* Owner,TList* lst,AnsiString sTitle,AnsiString razm_x,AnsiString razm_y);
        typedef struct{
          int x;
          double y;
        }TItems;
};
//---------------------------------------------------------------------------
extern PACKAGE TfmGraphMaket *fmGraphMaket;
//---------------------------------------------------------------------------
#endif
