//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unEnrgValid.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmEnrgValid *fmEnrgValid;
//---------------------------------------------------------------------------
__fastcall TfmEnrgValid::TfmEnrgValid(TComponent* Owner,  char isvalid[32], AnsiString Name,AnsiString NameForm)
  : TForm(Owner)
{
  Caption = Caption + " " + Name + " за " + NameForm + "     " + AnsiString(isvalid);
  ReadData(isvalid);
}
//---------------------------------------------------------------------------
void __fastcall TfmEnrgValid::FormResize(TObject *Sender)
{
   lblRequir->Left = (this->Width - lblRequir->Width) / 2;
}
//---------------------------------------------------------------------------
void __fastcall TfmEnrgValid::ReadData(char isval[32])
{
 //isval = "101000000111000000000000";

 AnsiString Msg = " ";

 if (isval[0]!='\0')
 {
    if (!StrToInt(isval[0]))      //QualityValue = 0
    {
      if (StrToInt(isval[1])) Msg = " EN 50160  ";
      if (StrToInt(isval[2])) Msg = " ГОСТ 13109 и" + Msg;

      Msg = Msg.SubString(1, (Msg.Length() - 2));
      Msg = "Электроэнергия соответсвует требованиям" + Msg;

      this->Height = 130;
    }
    else                          //QualityValue = 1
    {
      TImage *im;
      int start = -1, fin = -1;

      Msg = "Несоответствие качества требованиям";
      Panel4->Visible = true;

      pcUnRequir->Pages[1]->TabVisible = StrToInt(isval[1]);
      pcUnRequir->Pages[0]->TabVisible = StrToInt(isval[2]);

      if (!pcUnRequir->Pages[0]->TabVisible) pcUnRequir->ActivePageIndex = 1;

      if (pcUnRequir->Pages[0]->TabVisible)   //GOST
      {
        start = 0; fin = 12;
      }

      if (pcUnRequir->Pages[1]->TabVisible)   //EN
      {
        if (start == -1) start = 13; fin = 24;
      }

      for(int i=0;i<ComponentCount;i++)
      {
        im=dynamic_cast<TImage *>(Components[i]);

        if(im && (im->Tag >= start) && (im->Tag <= fin))
        {
          if((isval[im->Tag]) && (StrToInt(isval[im->Tag])))
            ImageList1->Draw(im->Canvas, 0 , 0 , 0, true);
          else
            ImageList1->Draw(im->Canvas, 0 , 0 , 1, true);
        }
      }
  }
 }
 lblRequir->Caption = Msg;
}
//---------------------------------------------------------------------------
void __fastcall TfmEnrgValid::Action1Execute(TObject *Sender)
{
  Close();  
}
//---------------------------------------------------------------------------

