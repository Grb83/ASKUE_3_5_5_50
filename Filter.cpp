//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "selectpoint.h"
#include "Filter.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmFilter *fmFilter;
int FGid=0;
int FGid_adv=0;

//---------------------------------------------------------------------------
__fastcall TfmFilter::TfmFilter(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmFilter::EditKeyPress(TObject *Sender,
      char &Key)
{
        TEdit* me = (TEdit*)Sender;
        bool setPoint = false;

/*      if((int)Key==VK_RETURN)
      {
        keybd_event(VK_RETURN, (byte) MapVirtualKey(VK_RETURN, 0), KEYEVENTF_KEYUP, 0);
        keybd_event(VK_TAB, (byte) MapVirtualKey(VK_TAB, 0), 0, 0);
        Key = NULL;
        return;
      }*/
      if(me->Text.Pos("."))
         setPoint = true;
      if(Key==',') Key = '.';
      if((Key=='.') && (setPoint))
         Key = NULL;
      if((Key != '.') && ((((int)Key)<48) || (((int)Key)>57)) && (((int)Key)!=VK_BACK))
      {
         Key = NULL;
         Beep();
      }
}
//---------------------------------------------------------------------------

void __fastcall TfmFilter::EditChange(TObject *Sender)
{
        TEdit* me = (TEdit*)Sender;

     TShiftState S;

        int DigitsAfterPoint = 0, Pos = 0;

      Pos = me->Text.Pos(".");
      if(Pos)
         DigitsAfterPoint = me->Text.Length() - Pos;
      else
      {
         if(me->Text.Length()>12)
         {
              keybd_event(VK_BACK, (byte) MapVirtualKey(VK_BACK, 0), 0, 0);
              keybd_event(VK_BACK, (byte) MapVirtualKey(VK_BACK, 0), KEYEVENTF_KEYUP, 0);
              Beep();
         }
      }
      if(DigitsAfterPoint>3)
      {
              keybd_event(VK_BACK, (byte) MapVirtualKey(VK_BACK, 0), 0, 0);
              keybd_event(VK_BACK, (byte) MapVirtualKey(VK_BACK, 0), KEYEVENTF_KEYUP, 0);
              Beep();
      }
}
//---------------------------------------------------------------------------
void __fastcall TfmFilter::btnMainSelectClick(TObject *Sender)
{
  GROUPDATAFORM gdf;
  TfmSelectPoint*sp=NULL;
  gdf.gid=FGid;
  gdf.type=3;

 sp=new TfmSelectPoint(this, &gdf);
 sp->HelpContext=25033;
// TfmSelectPoint*sp=new TfmSelectPoint(this, &gdf);
  if(sp->ShowModal()==mrOk){
        edMessValue->Clear();
        edMessValue->Text=gdf.Name;
        FGid=gdf.gid;
       }
    delete sp;
}
//---------------------------------------------------------------------------
void __fastcall TfmFilter::btnAdvFilterClick(TObject *Sender)
{
  GROUPDATAFORM gdf;
  TfmSelectPoint*sp=NULL;
  gdf.gid=FGid_adv;
  gdf.type=7;


  sp=new TfmSelectPoint(this, &gdf);
  sp->HelpContext=25033;
  if(sp->ShowModal()==mrOk){
        edAdvFilter->Clear();
        edAdvFilter->Text=gdf.Name;
        FGid_adv = gdf.gid;

        }
  delete sp;
}
//---------------------------------------------------------------------------
void __fastcall TfmFilter::btnDelAdvFilterClick(TObject *Sender)
{
    edAdvFilter->Clear();
    FGid_adv = 0;

}
//---------------------------------------------------------------------------
void __fastcall TfmFilter::btnDelAdvFilter2Click(TObject *Sender)
{
    edAdvFilter2->Clear();
    FGid_adv = 0;

}
//---------------------------------------------------------------------------
void __fastcall TfmFilter::btnAdvFilter2Click(TObject *Sender)
{
  GROUPDATAFORM gdf;
  TfmSelectPoint*sp=NULL;
  gdf.gid=FGid_adv;
  gdf.type=7;

  
  sp=new TfmSelectPoint(this, &gdf);
  sp->HelpContext=25033;
  if(sp->ShowModal()==mrOk){
        edAdvFilter2->Clear();
        edAdvFilter2->Text=gdf.Name;
        FGid_adv = gdf.gid;

     }
  delete sp;
}
//---------------------------------------------------------------------------

