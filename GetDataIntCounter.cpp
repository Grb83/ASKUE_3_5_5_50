//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "GetDataIntCounter.h"
#include "CountParam.h"
#include "Reconst.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma resource "*.dfm"
TFormGetDataIntCounter *FormGetDataIntCounter;
//---------------------------------------------------------------------------
__fastcall TFormGetDataIntCounter::TFormGetDataIntCounter(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
__fastcall TFormGetDataIntCounter::TFormGetDataIntCounter(TComponent* Owner,TBIIL* ztBill)
	: TForm(Owner)
{
  tBill=ztBill;
}
//----------------------------------------------------------------------------
void __fastcall TFormGetDataIntCounter::DrawTable2DrawCell(TObject *Sender,
	int Col, int Row, TRect &Rect, TGridDrawState State)
{
	if( State.Contains(gdSelected)&& DrawTable2->Focused())
    {
    	DrawTable2->Canvas->Brush->Color=clBlue;
    	DrawTable2->Canvas->FillRect(Rect);
    }else if( State.Contains(gdSelected)){
            DrawTable2->Canvas->Brush->Color=clActiveBorder;
    	    DrawTable2->Canvas->FillRect(Rect);
          }
}
//---------------------------------------------------------------------------
void __fastcall TFormGetDataIntCounter::DrawTable1DrawCell(TObject *Sender,
	int Col, int Row, TRect &Rect, TGridDrawState State)
{
	if( State.Contains(gdSelected)&& DrawTable1->Focused())
    {
    	DrawTable1->Canvas->Brush->Color=clBlue;
    	DrawTable1->Canvas->FillRect(Rect);
    }else if( State.Contains(gdSelected)){
            DrawTable1->Canvas->Brush->Color=clActiveBorder;
    	    DrawTable1->Canvas->FillRect(Rect);
          }
}
//---------------------------------------------------------------------------
void __fastcall TFormGetDataIntCounter::DrawTable3DrawCell(TObject *Sender,
	int Col, int Row, TRect &Rect, TGridDrawState State)
{
	if( State.Contains(gdSelected)&& DrawTable3->Focused())
    {
    	DrawTable3->Canvas->Brush->Color=clBlue;
    	DrawTable3->Canvas->FillRect(Rect);
    }else if( State.Contains(gdSelected)){
            DrawTable3->Canvas->Brush->Color=clActiveBorder;
    	    DrawTable3->Canvas->FillRect(Rect);
          }
}
//---------------------------------------------------------------------------
void __fastcall TFormGetDataIntCounter::BitBtn1Click(TObject *Sender)
{//OK
 int j=0;
try{
     for(int i=0; i<30; i++)
       meterDemIndic[i] = DrawTable1->VarStrings->Strings[i].IsEmpty()? -1:DrawTable1->VarStrings->Strings[i].ToDouble();

     for(int i=0; i<30; i++)
     {
         if(j>=5 && j<10)
           j = 10;
         if(j>=15 && j<20)
           j = 20;
         if(j>=25 && j<30)
           j = 30;
         if(j>=35 && j<40)
           j = 40;
         if(j>=45 && j<50)
           j = 50;
         meterNewIndic[j] = DrawTable2->VarStrings->Strings[i].IsEmpty()? -1:DrawTable2->VarStrings->Strings[i].ToDouble();
         j++;
     }
     j = 5;
     for(int i=0; i<30; i++)
     {
         if(j>=10 && j<15)
           j = 15;
         if(j>=20 && j<25)
           j = 25;
         if(j>=30 && j<35)
           j = 35;
         if(j>=40 && j<45)
           j = 45;
         if(j>=50 && j<55)
           j = 55;
         meterNewIndic[j] = DrawTable3->VarStrings->Strings[i].IsEmpty()? -1:DrawTable3->VarStrings->Strings[i].ToDouble();
         j++;
     }

/*  tBill[0].ERM=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].AERM=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].BERM=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].CERM=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].DERM=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[0].EDM=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].AEDM=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].BEDM=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].CEDM=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].DEDM=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[0].Q1M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].AQ1M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].BQ1M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].CQ1M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].DQ1M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[0].Q3M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].AQ3M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].BQ3M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].CQ3M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].DQ3M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[0].Q2M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].AQ2M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].BQ2M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].CQ2M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].DQ2M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[0].Q4M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].AQ4M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].BQ4M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].CQ4M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[0].DQ4M=DrawTable1->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  //---------------------------
  i=0;

  tBill[1].ER=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].AER=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].BER=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].CER=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].DER=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[1].ED=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].AED=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].BED=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].CED=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].DED=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[1].Q1=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].AQ1=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].BQ1=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].CQ1=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].DQ1=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[1].Q3=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].AQ3=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].BQ3=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].CQ3=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].DQ3=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[1].Q2=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].AQ2=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].BQ2=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].CQ2=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].DQ2=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[1].Q4=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].AQ4=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].BQ4=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].CQ4=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[1].DQ4=DrawTable2->VarStrings->Strings[i++].ToDouble();		//NUMBER

  //---------------------------
  i=0;

  tBill[3].ERM=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].AERM=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].BERM=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].CERM=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].DERM=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[3].EDM=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].AEDM=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].BEDM=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].CEDM=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].DEDM=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[3].Q1M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].AQ1M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].BQ1M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].CQ1M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].DQ1M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[3].Q3M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].AQ3M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].BQ3M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].CQ3M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].DQ3M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[3].Q2M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].AQ2M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].BQ2M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].CQ2M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].DQ2M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,

  tBill[3].Q4M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].AQ4M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].BQ4M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].CQ4M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  tBill[3].DQ4M=DrawTable3->VarStrings->Strings[i++].ToDouble();		//NUMBER,
  */
  }
  catch(Exception &e){
   Application->MessageBox(Reconst_smes33_1.c_str(), Application->Title.c_str(), MB_OK|MB_ICONSTOP);
   return;
  }
  ModalResult=mrOk;
}
//---------------------------------------------------------------------------
void __fastcall TFormGetDataIntCounter::FormCreate(TObject *Sender)
{
  int j = 0;

  Edit1->Text=tBill[0].Name;

  for(int i=0; i<30; i++)
  {
    DrawTable1->VarStrings->Strings[i] = "";
    DrawTable2->VarStrings->Strings[i] = "";
    DrawTable3->VarStrings->Strings[i] = "";
  }

  for(int i=0; i<30; i++)
    if (meterDemIndic[i] != -1)
      DrawTable1->VarStrings->Strings[i] = meterDemIndic[i];

  for(int i=0; i<30; i++)
  {
    if(j>=5 && j<10)
      j = 10;
    if(j>=15 && j<20)
      j = 20;
    if(j>=25 && j<30)
      j = 30;
    if(j>=35 && j<40)
      j = 40;
    if(j>=45 && j<50)
      j = 50;
    if (meterNewIndic[j] != -1)
      DrawTable2->VarStrings->Strings[i] = meterNewIndic[j];
    j++;
  }

  j = 5;
  for(int i=0; i<30; i++)
  {
    if(j>=10 && j<15)
      j = 15;
    if(j>=20 && j<25)
      j = 25;
    if(j>=30 && j<35)
      j = 35;
    if(j>=40 && j<45)
      j = 45;
    if(j>=50 && j<55)
      j = 55;
    if (meterNewIndic[j] != -1)
      DrawTable3->VarStrings->Strings[i] = meterNewIndic[j];
    j++;
  }


  /*     for(int i=1; i<30; i++)
     {
         if(j>=5 && j<10)
           j = 10;
         if(j>=15 && j<20)
           j = 20;
         if(j>=25 && j<30)
           j = 30;
         if(j>=35 && j<40)
           j = 40;
         if(j>=45 && j<50)
           j = 50;
         meterNewIndic[j] = DrawTable3->VarStrings->Strings[i].IsEmpty()? -1:DrawTable3->VarStrings->Strings[i].ToDouble();
         j++;
     }
     j = 5;
     for(int i=1; i<30; i++)
     {
         if(j>=10 && j<15)
           j = 15;
         if(j>=20 && j<25)
           j = 25;
         if(j>=30 && j<35)
           j = 35;
         if(j>=30 && j<45)
           j = 45;
         if(j>=30 && j<55)
           j = 55;
         meterNewIndic[j] = DrawTable2->VarStrings->Strings[i].IsEmpty()? -1:DrawTable2->VarStrings->Strings[i].ToDouble();
         j++;
     }

/*
  int i=0;
  DrawTable1->VarStrings->Strings[i++]=tBill[0].ERM;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].AERM;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].BERM;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].CERM;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].DERM;		//NUMBER,

  DrawTable1->VarStrings->Strings[i++]=tBill[0].EDM;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].AEDM;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].BEDM;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].CEDM;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].DEDM;		//NUMBER,

  DrawTable1->VarStrings->Strings[i++]=tBill[0].Q1M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].AQ1M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].BQ1M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].CQ1M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].DQ1M;		//NUMBER,

  DrawTable1->VarStrings->Strings[i++]=tBill[0].Q3M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].AQ3M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].BQ3M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].CQ3M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].DQ3M;		//NUMBER,

  DrawTable1->VarStrings->Strings[i++]=tBill[0].Q2M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].AQ2M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].BQ2M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].CQ2M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].DQ2M;		//NUMBER,

  DrawTable1->VarStrings->Strings[i++]=tBill[0].Q4M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].AQ4M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].BQ4M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].CQ4M;		//NUMBER,
  DrawTable1->VarStrings->Strings[i++]=tBill[0].DQ4M;		//NUMBER,
  */
  //---------------------------

/*
  i=0;

  DrawTable2->VarStrings->Strings[i++]=tBill[1].ER;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].AER;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].BER;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].CER;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].DER;		//NUMBER,

  DrawTable2->VarStrings->Strings[i++]=tBill[1].ED;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].AED;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].BED;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].CED;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].DED;		//NUMBER,

  DrawTable2->VarStrings->Strings[i++]=tBill[1].Q1;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].AQ1;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].BQ1;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].CQ1;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].DQ1;		//NUMBER,

  DrawTable2->VarStrings->Strings[i++]=tBill[1].Q3;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].AQ3;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].BQ3;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].CQ3;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].DQ3;		//NUMBER,

  DrawTable2->VarStrings->Strings[i++]=tBill[1].Q2;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].AQ2;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].BQ2;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].CQ2;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].DQ2;		//NUMBER,

  DrawTable2->VarStrings->Strings[i++]=tBill[1].Q4;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].AQ4;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].BQ4;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].CQ4;		//NUMBER,
  DrawTable2->VarStrings->Strings[i++]=tBill[1].DQ4;		//NUMBER

  //---------------------------
  i=0;

  DrawTable3->VarStrings->Strings[i++]=tBill[3].ERM;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].AERM;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].BERM;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].CERM;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].DERM;		//NUMBER,

  DrawTable3->VarStrings->Strings[i++]=tBill[3].EDM;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].AEDM;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].BEDM;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].CEDM;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].DEDM;		//NUMBER,

  DrawTable3->VarStrings->Strings[i++]=tBill[3].Q1M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].AQ1M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].BQ1M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].CQ1M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].DQ1M;		//NUMBER,

  DrawTable3->VarStrings->Strings[i++]=tBill[3].Q3M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].AQ3M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].BQ3M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].CQ3M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].DQ3M;		//NUMBER,

  DrawTable3->VarStrings->Strings[i++]=tBill[3].Q2M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].AQ2M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].BQ2M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].CQ2M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].DQ2M;		//NUMBER,

  DrawTable3->VarStrings->Strings[i++]=tBill[3].Q4M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].AQ4M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].BQ4M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].CQ4M;		//NUMBER,
  DrawTable3->VarStrings->Strings[i++]=tBill[3].DQ4M;		//NUMBER,
  */
}
//---------------------------------------------------------------------------
void __fastcall TFormGetDataIntCounter::BitBtn3Click(TObject *Sender)
{
     Application->MessageBox(Reconst_smes33_2.c_str(), Reconst_smes33_3.c_str(), MB_OK);
}
//---------------------------------------------------------------------------


