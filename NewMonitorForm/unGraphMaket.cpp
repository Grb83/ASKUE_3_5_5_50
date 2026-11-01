//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unGraphMaket.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmGraphMaket *fmGraphMaket;
//---------------------------------------------------------------------------
__fastcall TfmGraphMaket::TfmGraphMaket(TComponent* Owner,TList* lst,AnsiString sTitle,AnsiString razm_x,AnsiString razm_y)
        : TForm(Owner)
{
  double xmin,xmax,ymin,ymax;
  Caption=sTitle;
  chGraph->Title->Text->Clear();
  chGraph->Title->Text->Add(sTitle);
  chGraph->Series[0]->Clear();
  if(!lst->Count)
    return;
  xmin=xmax=((TItems*)lst->Items[0])->x;
  ymin=ymax=((TItems*)lst->Items[0])->y;
  for(int i=0;i<lst->Count;i++){
    chGraph->Series[0]->AddXY(((TItems*)lst->Items[i])->x,((TItems*)lst->Items[i])->y,"");
    if(xmin > ((TItems*)lst->Items[i])->x)
      xmin=((TItems*)lst->Items[i])->x;
    if(xmax < ((TItems*)lst->Items[i])->x)
      xmax=((TItems*)lst->Items[i])->x;
    if(ymin > ((TItems*)lst->Items[i])->y)
      ymin=((TItems*)lst->Items[i])->y;
    if(ymax < ((TItems*)lst->Items[i])->y)
      ymax=((TItems*)lst->Items[i])->y;
  }
  chGraph->ZoomPercent( 100 );
  int dy=1;
  if(int((ymax-ymin)/6) != 0)
    dy=int((ymax-ymin)/6);
  chGraph->BottomAxis->Maximum = xmax;
  chGraph->BottomAxis->Minimum = xmin;
  chGraph->BottomAxis->Title->Caption=razm_x;
  chGraph->LeftAxis->Minimum = ymin-dy;
  chGraph->LeftAxis->Maximum = ymax+dy;
  chGraph->LeftAxis->Title->Caption=razm_y;
  chGraph->ZoomPercent( 100 );
  this->ymin=ymin-dy;
  this->ymax=ymax+dy;
}
//---------------------------------------------------------------------------
void __fastcall TfmGraphMaket::chGraphUndoZoom(TObject *Sender)
{
  chGraph->ZoomPercent( 100 );
  chGraph->LeftAxis->Minimum = ymin;
  chGraph->LeftAxis->Maximum = ymax;
  chGraph->ZoomPercent( 100 );
}
//---------------------------------------------------------------------------
void __fastcall TfmGraphMaket::FormKeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
  if(Key==27)
    Close();
}
//---------------------------------------------------------------------------

void __fastcall TfmGraphMaket::tbSaveClick(TObject *Sender)
{
  AnsiString fname;
  SaveDialog1->Title = "SAA";
  SaveDialog1->DefaultExt = "txt";
  SaveDialog1->FileName= "SAA";
  SaveDialog1->Filter = "SAA";
  SaveDialog1->Options << ofOverwritePrompt;
  if(SaveDialog1->Execute())
    fname=SaveDialog1->FileName;
  else
    fname="";
  if(fname.IsEmpty())
    return;
  chGraph->SaveToBitmapFile(fname);
}
//---------------------------------------------------------------------------

void __fastcall TfmGraphMaket::tbPrintClick(TObject *Sender)
{
  int tmpH,tmpW,tmpWMargin,tmpHMargin; // margins
  TPrinterOrientation OldOrientation;

  if(PrintDialog1->Execute()){
   /// for(int i=0;i<PrintDialog1->Copies;i++)
     // chGraph->Print();
    Screen->Cursor = crHourGlass;
    OldOrientation=Printer()->Orientation;  // <-- save paper orientation
    Printer()->Orientation=poLandscape; // <-- Force Horizontal paper
    try {
      for(int i=0;i<PrintDialog1->Copies;i++){
        Printer()->BeginDoc();       // <-- start printer job
        try {
          Printer()->Title=Application->Title;
          chGraph->PrintResolution= 0;
          tmpW=Printer()->PageWidth;
          tmpWMargin=floor(5.0*tmpW/100.0); // <-- 5% margins
          tmpW=tmpW-2*tmpWMargin;  // <-- left and right margins
          tmpW=tmpW; // half height for left and right charts

          // CALCULATE VERTICAL MARGIN
          tmpH=Printer()->PageHeight;
          tmpHMargin=floor(5.0*tmpH/100.0);  // <-- 5% margins
          tmpH=tmpH-2*tmpHMargin;  // <-- bottom and top margins
          tmpH=tmpH; // half height for top and bottom charts

          // left / top chart
          chGraph->PrintPartial( Rect( tmpWMargin,tmpHMargin,
                                     tmpWMargin+tmpW,tmpHMargin+tmpH ) );

          Printer()->EndDoc(); // <-- end job and print !!
        }catch (...) {
           Printer()->Abort();
           Printer()->EndDoc();
           throw;
        }
      }
    }
    __finally {
      Printer()->Orientation=OldOrientation;  // <-- restore paper orientation
      Screen->Cursor=crDefault; // <-- restore cursor
    }
  }
}
//---------------------------------------------------------------------------

