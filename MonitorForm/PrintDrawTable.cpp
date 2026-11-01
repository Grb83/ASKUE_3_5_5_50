//---------------------------------------------------------------------------
#include <vcl.h>
#include <ShellAPI.h>
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <registry.hpp>
#pragma hdrstop
#include "PrintDrawTable.h"
#include "Reconst.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmQR::TfmQR(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
__fastcall TPrintDrawTable::TPrintDrawTable(TComponent* Owner)
        : TComponent(Owner)
{
   RepFormList = new TList;
   RepList = new TList;
   PD = new TPrintDialog(this);
}
//---------------------------------------------------------------------------
__fastcall TPrintDrawTable::~TPrintDrawTable(void)
{
   delete RepFormList;
   delete RepList;
   delete PD;
}
//---------------------------------------------------------------------------

void __fastcall TPrintDrawTable::PrintTable(AnsiString aTitle, AnsiString aComment, TStrings *aColumnsCaption,
                                            TVirtualTable *aVT_PrintData, int aColumhNameWidth, int aColumnWidth, int aRepType, TFormDescr *fd)
{
    // aRepType = 1 Интерьер не имеет подстрок
    // aRepType = 2 Интерьер имеет подстроки
   int LeftLabelCoord = 0, ColumnCount, QRCount=1, NumLabel, NumDBText, NumField = 1,
       lColumnWidth = aColumnWidth, lColumhNameWidth = aColumhNameWidth+10;
   AnsiString LabelName, DBTextName, QRName, TitleName, CommentName, RowName, SubRowName;
   TfmQR *fmQR;
   TQuickRep *QR;
   if(PD->Execute())
   {
               switch(aRepType)
               {
                 case 1: LabelName = "SRQRLabel";
                         DBTextName = "SRQRDBText";
                         QRName = "SRQuickRep";
                         TitleName = "SRQRLabelTitle";
                         CommentName = "SRQRLabelComment";
                         RowName = "SRQRDBTextRowName";
                         SubRowName = "";
                         break;
                 case 2: LabelName = "MRQRLabel";
                         DBTextName = "MRQRDBText";
                         QRName = "MRQuickRep";
                         TitleName = "MRQRLabelTitle";
                         CommentName = "MRQRLabelComment";
                         RowName = "MRQRDBTextRowName";
                         SubRowName = "MRQRDBTextSubRowName";
                         break;
               }
               for(int i=0; i<QRCount; i++)
               {
                   fmQR = new TfmQR(this);
                   fmQR->QRGroup1->Expression = aVT_PrintData->Name+".RowName";
                   for(int j=0; !i&&j<fmQR->ComponentCount; j++) // находим координаты крайней левой ЛЕЙБЫ, чтобы от нее потом плясать
                   {
                      if((aRepType==1)&&(fmQR->Components[j]->Name==RowName))
                      {
                         ((TQRDBText*)fmQR->Components[j])->Width = lColumhNameWidth;
                         LeftLabelCoord = ((TQRDBText*)fmQR->Components[j])->Left+((TQRDBText*)fmQR->Components[j])->Width+3;
                         break;
                      }
                      if((aRepType==2)&&(fmQR->Components[j]->Name==LabelName+"1"))
                      {
                         LeftLabelCoord = ((TQRLabel*)fmQR->Components[j])->Left;
                         break;
                      }
                   }
                   for(int j=0; j<fmQR->ComponentCount; j++)
                   {
                      if(fmQR->Components[j]->Name==QRName)
                      {
                          ((TQuickRep*)fmQR->Components[j])->Page->Orientation = Printer()->Orientation;
//                          Printer()->PageHeight
  //                        Printer()->PageWidth
//                          ((TQuickRep*)fmQR->Components[j])->Page->PaperSize =
                          ((TQuickRep*)fmQR->Components[j])->PrinterSettings->Copies = PD->Copies;
                          ((TQuickRep*)fmQR->Components[j])->PrinterSettings->PrinterIndex = Printer()->PrinterIndex;
                          ((TQuickRep*)fmQR->Components[j])->DataSet = aVT_PrintData;
                          if(!i)
                          {
                             ColumnCount = ((TQuickRep*)fmQR->Components[j])->Width-((TQuickRep*)fmQR->Components[j])->Page->LeftMargin-((TQuickRep*)fmQR->Components[j])->Page->RightMargin-LeftLabelCoord;
                             ColumnCount = (ColumnCount-(ColumnCount%(lColumnWidth+3)))/(lColumnWidth+3);
                             if(ColumnCount>11) ColumnCount = 11;
                             if(ColumnCount<1)
                                throw Exception(Reconst_smes125_1);
                             QRCount = (aColumnsCaption->Count-(aColumnsCaption->Count%ColumnCount))/ColumnCount;
                             if(aColumnsCaption->Count%ColumnCount>0) QRCount++;
                          }
                          RepList->Add(fmQR->Components[j]);
                          break;
                      }
                   }
                   NumLabel = NumDBText = 1;
                   for(int j=0; j<fmQR->ComponentCount; j++) // А тут уже пошла возня
                   {
                      if(fmQR->Components[j]->Name==TitleName)
                         ((TQRLabel*)fmQR->Components[j])->Caption = aTitle;
                      if(fmQR->Components[j]->Name==CommentName)
                         ((TQRLabel*)fmQR->Components[j])->Caption = aComment;
                      if(fmQR->Components[j]->Name==RowName)
                      {
                           ((TQRDBText*)fmQR->Components[j])->DataSet = aVT_PrintData;
                           ((TQRDBText*)fmQR->Components[j])->DataField = "RowName";
                      }
                      if((SubRowName!="")&&(fmQR->Components[j]->Name==SubRowName))
                      {
                           ((TQRDBText*)fmQR->Components[j])->DataSet = aVT_PrintData;
                           ((TQRDBText*)fmQR->Components[j])->DataField = "SubRowName";
                      }
                      if(fmQR->Components[j]->Name==LabelName+IntToStr(NumLabel))
                      {
                         if((NumLabel<=ColumnCount)&&(NumLabel+i*ColumnCount<=aColumnsCaption->Count))
                         {
                           ((TQRLabel*)fmQR->Components[j])->Enabled = true;
                           ((TQRLabel*)fmQR->Components[j])->Width = lColumnWidth;
                           ((TQRLabel*)fmQR->Components[j])->Left = LeftLabelCoord+((lColumnWidth+3)*(NumLabel-1));
                           ((TQRLabel*)fmQR->Components[j])->Caption = aColumnsCaption->Strings[NumLabel-1+i*ColumnCount];
                         }
                         else ((TQRLabel*)fmQR->Components[j])->Enabled = false;
                         NumLabel++;
                      }
                      if(fmQR->Components[j]->Name==DBTextName+IntToStr(NumDBText))
                      {
                         if((NumDBText<=ColumnCount)&&(NumDBText+i*ColumnCount<=aColumnsCaption->Count))
                         {
                           ((TQRDBText*)fmQR->Components[j])->Enabled = true;
                           ((TQRDBText*)fmQR->Components[j])->Width = lColumnWidth;
                           ((TQRDBText*)fmQR->Components[j])->Left = LeftLabelCoord+((lColumnWidth+3)*(NumDBText-1));
                           ((TQRDBText*)fmQR->Components[j])->DataSet = aVT_PrintData;
                           switch(fd->CodeTemplate)
                           {
                           case DU2CHART_PARAMS:
                              ((TQRDBText*)fmQR->Components[j])->DataField = "Data"+IntToStr(NumDBText-1+i*ColumnCount);
                              break;
                           default:
                              ((TQRDBText*)fmQR->Components[j])->DataField = "Data"+IntToStr(NumDBText+i*ColumnCount);
                              break;
                           }
                         }
                         else ((TQRDBText*)fmQR->Components[j])->Enabled = false;
                         NumDBText++;
                      }
                   }
                   NumField+=ColumnCount;
                   RepFormList->Add(fmQR);
               }
               for(int i=0; i<RepList->Count; i++)
                  ((TQuickRep*)RepList->Items[i])->Print();
                  //Preview();
               for(int i=0; i<RepFormList->Count; i++)
                  delete (TfmQR*)RepFormList->Items[i];
               RepFormList->Clear();
               RepList->Clear();
            /*   while(CuurFieldNum<aColumnsCaption->Count)
               {
                  NumLabel = NumDBText = 1;
                  if(CuurFieldNum+1>(Count_QR_Use+1)*9) Count_QR_Use++;
                  fmQR[Count_QR_Use]->QuickRep1->DataSet = aVT_PrintData;
                  fmQR[Count_QR_Use]->QRLabelTitle->Caption = aTitle;
                  fmQR[Count_QR_Use]->QRLabelComment->Caption = aComment;
                  fmQR[Count_QR_Use]->QRGroup1->Expression = aVT_PrintData->Name+".RowName";
                  fmQR[Count_QR_Use]->QRDBTextRowName->DataSet = aVT_PrintData;
                  fmQR[Count_QR_Use]->QRDBTextRowName->DataField = "RowName";
                  fmQR[Count_QR_Use]->QRDBTextSubRowName->DataSet = aVT_PrintData;
                  fmQR[Count_QR_Use]->QRDBTextSubRowName->DataField = "SubRowName";
                  for(int i=0; i<fmQR[Count_QR_Use]->ComponentCount; i++)
                  {
                    if(fmQR[Count_QR_Use]->Components[i]->Name=="MRQRLabel"+IntToStr(NumLabel))
                    {
                       ((TQRLabel*)fmQR[Count_QR_Use]->Components[i])->Caption = "";
                       if((NumLabel+Count_QR_Use*9)<=aColumnsCaption->Count)
                         ((TQRLabel*)fmQR[Count_QR_Use]->Components[i])->Caption = aColumnsCaption->Strings[NumLabel-1+Count_QR_Use*9];
                       NumLabel++;
                    }
                    if(fmQR[Count_QR_Use]->Components[i]->Name=="MRQRDBText"+IntToStr(NumDBText))
                    {
                       if((NumDBText+Count_QR_Use*9)<=aColumnsCaption->Count)
                       {
                         ((TQRDBText*)fmQR[Count_QR_Use]->Components[i])->DataSet = aVT_PrintData;
                         ((TQRDBText*)fmQR[Count_QR_Use]->Components[i])->DataField = "Data"+IntToStr(NumDBText+Count_QR_Use*9);
                       }
                       NumDBText++;
                    }
                  }
                  CuurFieldNum+=9;
               }

               for(int i=0; i<Count_QR_Use+1; i++)*/
            //      fmQR[0]->DataSource1->DataSet = aVT_PrintData;
              //    fmQR[0]->ShowModal();
            //      fmQR[i]->QuickRep1->Preview();
            //      fmQR[i]->QuickRep1->Print();
   }
}
//---------------------------------------------------------------------------
void __fastcall TPrintDrawTable::SaveTableToFile(AnsiString aTitle, AnsiString aComment, TStrings *aColumnsCaption,
                                TVirtualTable *aVT_PrintData, int aColumhNameWidth, int aColumnWidth, int aRepType, AnsiString aFileName, WORD aFlags)
{
    // aRepType = 0 Интерьер простой (типа журналов)
    // aRepType = 1 Интерьер не имеет подстрок
    // aRepType = 2 Интерьер имеет подстроки
  AnsiString ExportSeparator;
    TRegistry *Reg = new TRegistry(KEY_READ);
      try
      {
        Reg->RootKey = HKEY_CURRENT_USER;
        Reg->Access = KEY_READ;
        Reg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", False);
        if(Reg->ValueExists("ExportSeparator"))
              ExportSeparator = ((Reg->ReadString("ExportSeparator") == ",") ? (",") : ("."));
        else
             ExportSeparator = (".");
      }
      __finally
      {
        delete Reg;
      }



  TBookmark SavePlace = aVT_PrintData->GetBookmark();
  aVT_PrintData->DisableControls();

       TStrings *File = new TStringList();
  try
  { AnsiString str = "",tempStr = "";

       tempStr = tempStr+aTitle;
       File->Add(tempStr);
       File->Add(aComment);
       File->Add(" ");
    switch (aRepType)
    { case 1:
          for(int i=0; i<=aColumnsCaption->Count; i++)
            str = str+(i==0?AnsiString(""):aColumnsCaption->Strings[i-1])+"\t";
          break;
        case 2:
          for(int i=0; i<=aColumnsCaption->Count+1; i++)
            str = str+(i<2?AnsiString(""):aColumnsCaption->Strings[i-2])+"\t";
          break;
        default:
          str = aColumnsCaption->Count>0?AnsiString(Reconst_smes125_2):AnsiString("");
          for(int i=0; i<aColumnsCaption->Count; i++)
            str = str+aColumnsCaption->Strings[i]+"\t";
       }
       File->Add(str);
       aVT_PrintData->First();
    for(int i=0; i<aVT_PrintData->RecordCount; i++)
    { str = "";
      switch(aRepType)
      { case 1:
          for(int j=0; j<aVT_PrintData->Fields->Count; j++)
          { if(j!=1)
            { if(j<2)
                      str = str+aVT_PrintData->Fields->Fields[j]->AsString+"\t";
              else
              { tempStr = "";
                for(int iii=1; iii<=aVT_PrintData->Fields->Fields[j]->AsString.Length(); iii++)
                { if(((BYTE)aVT_PrintData->Fields->Fields[j]->AsString[iii])!=160)
                          tempStr = tempStr+aVT_PrintData->Fields->Fields[j]->AsString[iii];
                      }
                      str = str+tempStr+"\t";
                    }
                  }
                }
                break;
             case 2:
          for(int j=0; j<aVT_PrintData->Fields->Count; j++)
          { if(j<2)
                    str = str+aVT_PrintData->Fields->Fields[j]->AsString+"\t";
            else
            { tempStr = "";
              for(int iii=1; iii<=aVT_PrintData->Fields->Fields[j]->AsString.Length(); iii++)
              { if(((BYTE)aVT_PrintData->Fields->Fields[j]->AsString[iii])!=160)
                        tempStr = tempStr+aVT_PrintData->Fields->Fields[j]->AsString[iii];
                    }
                    str = str+tempStr+"\t";
                  }
                }
                break;
             default:
                for(int j=0; j<aVT_PrintData->Fields->Count; j++)
                  str = str+aVT_PrintData->Fields->Fields[j]->AsString+"\t";


           }
   //------------------------------------------------VNB 12.03.2010
        if (ExportSeparator == ",")
              str = StringReplace(str,".",",",TReplaceFlags()<<rfReplaceAll);
            else
              str = StringReplace(str,",",".",TReplaceFlags()<<rfReplaceAll);
  //-----------------------------------------------------------end;
           File->Add(str);
           aVT_PrintData->Next();
       }
          File->SaveToFile(aFileName);
  }
  catch(Exception &e){
    Application->ShowException(&e);
  }
  delete File;
    aVT_PrintData->GotoBookmark(SavePlace);
    aVT_PrintData->FreeBookmark(SavePlace);
    aVT_PrintData->EnableControls();

}
//---------------------------------------------------------------------------

