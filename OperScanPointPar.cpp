//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "OperScanSched.h"
#include "unDataMod.h"
#include "OperScanPointPar.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfmOperScanPointPar *fmOperScanPointPar;

bool __fastcall CheckInteger( TEdit* PPEd, AnsiString PPName );

//---------------------------------------------------------------------------
__fastcall TfmOperScanPointPar::TfmOperScanPointPar(TComponent* Owner, long curr_item)
  : TForm(Owner)
{
  curr_it = curr_item;
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanPointPar::FormCreate(TObject *Sender)
{
   //Текущ канал
   Caption = AnsiString(Reconst_smes46_1)+AnsiString(fmOperScanSched->TableChannList[ curr_it ].Name)+AnsiString("'");
   //e
   //Запрос для выыбора точек канала
   dmMain->oqCursor->Params->Clear();
   dmMain->oqCursor->SQL->Text= "begin "+SchemeName+"operscan_pg.get_channel_points(:par1,:par2); end;";
   dmMain->oqCursor->ParamByName("par1")->AsString= fmOperScanSched->TableChannList[ curr_it ].Id;
   dmMain->oqCursor->ParamByName("par2")->ParamType = ptOutput;
   dmMain->oqCursor->ParamByName("par2")->DataType = ftCursor;
   dmMain->oqCursor->Execute();

   lbPoints->Items->Clear();
   lbPoints->Items->BeginUpdate();
   int i=0;
   while(!dmMain->oqCursor->Eof){
     //strcpy(TablePoints[i].Id,dmMain->oqCursor->FieldByName("mid")->AsString.c_str());
     TListItem *li;
     li=lbPoints->Items->Add();
//     li->SubItems->Add(strcpy(TablePoints[i].Name,dmMain->oqCursor->FieldByName("pname")->AsString.c_str()));
//     li->SubItems->Add(strcpy(TablePoints[i].PName,dmMain->oqCursor->FieldByName("name")->AsString.c_str()));
     li->SubItems->AddObject(dmMain->oqCursor->FieldByName("pname")->AsString,(TObject*)dmMain->oqCursor->FieldByName("mid")->AsInteger);
     li->SubItems->Add(dmMain->oqCursor->FieldByName("name")->AsString);
     dmMain->oqCursor->Next();
     i++;
   }
   lbPoints->Items->EndUpdate();
    //e Заполняем listview
   //e Заполняем спсиок

   //Выделяем
   if ( lbPoints->Items->Count > 0 )
     lbPoints->Items->Item[ 0 ]->Selected = TRUE;
   //e Выделяем

   //Умолч
   EdRetries->Text = fmOperScanSched->TableChannList[ curr_it ].Retries;
   EdRetriesTout->Text = fmOperScanSched->TableChannList[ curr_it ].RetriesTout;
   chbBill_Data->Checked = (AnsiString(fmOperScanSched->TableChannList[ curr_it ].isbilldata)==AnsiString("1"));
   eBill_Data_Dept->Text = fmOperScanSched->TableChannList[ curr_it ].isbilldatadepth;
   chbCurr_Data->Checked = (AnsiString(fmOperScanSched->TableChannList[ curr_it ].iscurrdata)==AnsiString("1"));
   eCurr_Data_Dept->Text = fmOperScanSched->TableChannList[ curr_it ].iscurrdatadepth;
   eBill_Data_Dept->Enabled=chbBill_Data->Checked;
   eCurr_Data_Dept->Enabled=chbCurr_Data->Checked;
   //e Умолч

   BitBtn1->Enabled=dmMain->CanManualOperPoint;
   BitBtn1->Visible=BitBtn1->Enabled;
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanPointPar::BitBtn1Click(TObject *Sender)
{
  //Определяем мид точки
        //тек индекс
   TListItem *Item = lbPoints->Selected;
   if (Item)
   {
      int prPointInd = Item->Index;
      //e тек индекс
      if ( -1 != prPointInd )
      {
        if
        (
          ( CheckInteger( EdRetries ,Reconst_smes46_2 ) )
          &&
          ( CheckInteger( EdRetriesTout ,Reconst_smes46_3 ) )
          &&
          (!chbBill_Data->Checked||CheckInteger( eBill_Data_Dept ,Reconst_smes46_4 ) )
          &&
          (!chbCurr_Data->Checked||CheckInteger( eCurr_Data_Dept ,Reconst_smes46_5 ) )
        )
        {
        //e
        //Вызов процедуры
          int prMId, prCId, prRetr, prRetrT;
          int prbill, prbilldept, prcurr, prcurrdept;

          //Текущ канал
           //e

       //   prCId = atoi( fmOperScanSched->TableChannList[ prChInd ].Id );
       //   prMId = atoi( TablePoints[ prPointInd ].Id );
          prCId = StrToInt( fmOperScanSched->TableChannList[ curr_it ].Id );
          prMId = (int)Item->SubItems->Objects[0];
          prRetr = StrToInt( EdRetries->Text );
          prRetrT = StrToInt( EdRetriesTout->Text.c_str() );
          prbill=chbBill_Data->Checked;
          prbilldept=prbill?StrToInt( eBill_Data_Dept->Text):0;
          prcurr=chbCurr_Data->Checked;
          prcurrdept=prcurr?StrToInt( eCurr_Data_Dept->Text):0;

          dmMain->oqCursor->Params->Clear();
          dmMain->oqCursor->SQL->Text = "begin "+SchemeName+"channels_pg.tempChannels(:par1, :par2, :par3, :par4, :par5, :par6, :par7, :par8, :par9); end;";
          dmMain->oqCursor->ParamByName("par1")->AsInteger=prCId;
          dmMain->oqCursor->ParamByName("par2")->AsInteger=prMId;
          dmMain->oqCursor->ParamByName("par3")->AsInteger=prRetr;
          dmMain->oqCursor->ParamByName("par4")->AsInteger=prRetrT;
          dmMain->oqCursor->ParamByName("par5")->AsInteger=prbill;
          dmMain->oqCursor->ParamByName("par6")->AsInteger=prbilldept;
          dmMain->oqCursor->ParamByName("par7")->AsInteger=prcurr;
          dmMain->oqCursor->ParamByName("par8")->AsInteger=prcurrdept;
          dmMain->oqCursor->ParamByName("par9")->AsString=UsCon.UserName;
          dmMain->oqCursor->Execute();
          Close();
        }
      //e Вызов процедуры
      }
  }//выбрана
}
//---------------------------------------------------------------------------
bool __fastcall CheckInteger( TEdit* PPEd, AnsiString PPName )
{
  bool prB = TRUE;
  int prInt;
  try
  {
    prInt = StrToInt( PPEd->Text );
  }
  catch(Exception &exception)
  {
    prB = FALSE;
  }
  if ( prB )
    prB
      =
      ( prInt >=1 );
  if ( !prB )
  {
    AnsiString prStr = Reconst_smes46_6 + PPName + Reconst_smes46_7;
    Application->MessageBox
      (prStr.c_str(),Application->Title.c_str(),MB_OK	|MB_ICONERROR);
  }
  return prB;
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanPointPar::BitBtn2Click(TObject *Sender)
{
    Close();
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanPointPar::edLongPress(TObject *Sender,
      char &Key)
{
#define Sender ((TEdit*)Sender)
  AnsiString S=(AnsiString)Key;
  AnsiString S1="0123456789\b\r";
  if(!S1.Pos(S)){
    Key=NULL;
    Beep();
    return;
  }
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanPointPar::chbBill_DataClick(TObject *Sender)
{
  eBill_Data_Dept->Enabled=chbBill_Data->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfmOperScanPointPar::chbCurr_DataClick(TObject *Sender)
{
  eCurr_Data_Dept->Enabled=chbCurr_Data->Checked;
}
//---------------------------------------------------------------------------

