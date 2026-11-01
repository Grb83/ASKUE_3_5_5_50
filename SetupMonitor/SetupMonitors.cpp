//---------------------------------------------------------------------------
#include <vcl.h>
#include <registry.hpp>
#include <stdio.h>
#pragma hdrstop
#include "SetupMonitors.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma resource "*.dfm"
TFormSetupMonitors *FormSetupMonitors;
double mas[] = {12,8,7,6,8,13,18,19,17,10,3};
//---------------------------------------------------------------------------
__fastcall TFormSetupMonitors::TFormSetupMonitors(TComponent* Owner)
	: TForm(Owner)//,pLine(NULL)
{
   // инициализация структур с индикацией истории данных add by KSS
   pLine=NULL;
   dsAll.kSymbFontSize = 80;
   dsMan.kSymbFontSize = 80;
   dsOvCh.kSymbFontSize = 80;
   dsAll.fSymbUL = 7;   dsAll.fSymbUR = 7;   dsAll.fSymbBL = 7; dsAll.fSymbBR = 7;
   dsMan.fSymbUL = 7;
   dsOvCh.fSymbUR = 7;   dsOvCh.fSymbBL = 7;
//Описываем цвета символы для мониторов
   strncpy(dsAll.cSymbUL," P ",sizeof(dsAll.cSymbUL));
   strncpy(dsAll.cSymbUR," O ",sizeof(dsAll.cSymbUR));
   strncpy(dsAll.cSymbBL," Т ",sizeof(dsAll.cSymbBL));
   strncpy(dsAll.cSymbBR," Н ",sizeof(dsAll.cSymbBR));
   dsAll.colUL = clWhite;  dsAll.bkcolUL = clGreen; //ручной ввод
   dsAll.colUR = clWhite;  dsAll.bkcolUR = clBlue;  //обходник
   dsAll.colBL = clWhite;  dsAll.bkcolBL = clFuchsia;//тревога
   dsAll.colBR = clWhite;  dsAll.bkcolBR = clRed;   //недостоверные данные (дырка)

//Описываем цвета символы для примера отображения симафоров
   strncpy(dsMan.cSymbUL," P ",sizeof(dsMan.cSymbUL));
   strncpy(dsOvCh.cSymbUR," O ",sizeof(dsOvCh.cSymbUR));
   strncpy(dsOvCh.cSymbBR," Н ",sizeof(dsOvCh.cSymbBR));
   dsMan.colUL = clWhite;  dsMan.bkcolUL = clGreen;
   dsOvCh.colUR = clWhite;   dsOvCh.bkcolUR = clBlue;
   dsOvCh.colBR = clWhite;   dsOvCh.bkcolBR = clRed;

   dsElectr.kSymbFontSize = 80;
   dsElectr.fSymbUR = 7;
   strncpy(dsElectr.cSymbUR," E ",sizeof(dsElectr.cSymbUR));
   dsElectr.colUR = clRed;  dsElectr.bkcolUR = clRed;

   pLine = new TLineSeries(Chart);
   pLine->ParentChart=Chart;
   pLine->Marks->Visible = false;
   pLine->Marks->Clip = true;
   pLine->XValues->Order=loNone;
   pLine->YValues->Order=loDescending;
   pLine->Marks->Style=smsValue;
   pLine->Pointer->Visible = false;
   pLine->Pointer->Style = psCircle;
   pLine->Pointer->HorizSize = 3;
   pLine->Pointer->VertSize = 3;
   pLine->LinePen->Width=2;
   pLine->XValues->DateTime=false;//true;
   pLine->Title=Reconst_smes129_1;
   pLine->AddArray(mas,sizeof(mas)/sizeof(mas[0])-1);

   pBar = new TBarSeries(Chart);
   pBar->ParentChart=Chart;
   pBar->Marks->Visible = false;
   pBar->Marks->Clip = true;
   pBar->XValues->Order=loNone;
   pBar->YValues->Order=loDescending;
   pBar->Marks->Style=smsValue;
   pBar->XValues->DateTime=false;//true;
   pBar->Title=Reconst_smes129_1;
   pBar->AddArray(mas,sizeof(mas)/sizeof(mas[0])-1);

   pPie = new TPieSeries(Chart);
   pPie->ParentChart=Chart;
   pPie->Marks->Visible = false;
   pPie->Marks->Clip = true;
   pPie->XValues->Order=loNone;
   pPie->YValues->Order=loDescending;
   pPie->Marks->Style=smsValue;
   pPie->XValues->DateTime=false;//true;
   pPie->Title=Reconst_smes129_1;
   pPie->AddArray(mas,sizeof(mas)/sizeof(mas[0])-1);
   pPie->Circled = true;
   if(PowerProfile <= 15)
   {
     RadioGroupProfilePower->Items->Add(IntToStr(PowerProfile)+AnsiString(Reconst_smes129_2));
     RadioGroupProfilePower->Columns=2;
    }

#if ONLY_DEMO_VER>0 //Проверка ограничений
   if(dmMain->SystemDate>TDateTime(ONLY_DEMO_VER/100, ONLY_DEMO_VER%100, 1)){
    dmMain->orases=dmMain->orasesAlert;
    Close();
    Application->Terminate();
   }
#endif

}

//---------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::InitRegistry(void)
{
	int value,value2;
	char buf[32];
        int TempPowerProfile;
        int TempPowerCoeff=0;
       	TRegistry *pReg=new TRegistry;
	pReg->RootKey=HKEY_CURRENT_USER;
	if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", true) )
	{
		try
		{
         // add KSS 30.01.2004
         RadioGroupShowValidity->ItemIndex = pReg->ValueExists("ShowManual")?pReg->ReadInteger("ShowManual"):0;
         //cbShowManual->Checked = pReg->ValueExists("ShowManual")?pReg->ReadBool("ShowManual"):false;
         // end add
         // add KAS 20.04.2002
       //  int i = pReg->ValueExists("PowerProfile");
//Add by Nadtochiy при добавлении промежутка времени добавить соответстуеющий case
         if(pReg->ValueExists("PowerProfile"))
           TempPowerProfile = pReg->ReadInteger("PowerProfile");
         //GRB CHANGE
         PowerProfile = (TempPowerProfile > PowerProfile) ? TempPowerProfile : PowerProfile;
         //END CHANGE
         switch(PowerProfile)

         {
            case 60:{RadioGroupProfilePower->ItemIndex = 0; break;}
            case 30:{RadioGroupProfilePower->ItemIndex = 1; break;}
            case 15:{RadioGroupProfilePower->ItemIndex = 2; break;}
            default: {RadioGroupProfilePower->ItemIndex = 0; PowerProfile = 30;}
         }
//VNB 12.12.2008 Коэффициент представления данных
         if(pReg->ValueExists("PowerCoeff"))
           TempPowerCoeff = pReg->ReadInteger("PowerCoeff");
           PowerCoeff = (TempPowerCoeff) ? TempPowerCoeff : 1000;
         switch(PowerCoeff)
         {
            case 1:{RadioGroupPowerCoeff->ItemIndex = 0; break;}
            case 1000:{RadioGroupPowerCoeff->ItemIndex = 1; break;}

        }


         if(pReg->ValueExists("kindOfADddBalanceDiag"))
           kindOfADddBalanceDiag = pReg->ReadInteger("kindOfADddBalanceDiag");
         kindOfADddBalanceDiag = (kindOfADddBalanceDiag) ? kindOfADddBalanceDiag : 2;
         switch(kindOfADddBalanceDiag)
         {
           case 2:{ChecAddFoBalanse->ItemIndex = 0; break;}
           case 3:{ChecAddFoBalanse->ItemIndex = 1; break;}
         }

           if(pReg->ValueExists("ExportSeparator"))
              cbFormatPnt->ItemIndex=(pReg->ReadString("ExportSeparator")==",") ? 1 : 0;

           if(pReg->ValueExists("isSpecFormat"))
             cbSpecFormat->Checked = (pReg->ReadInteger("isSpecFormat")) ? 1 : 0;

 //END ADD
         //RadioGroupProfilePower->ItemIndex = PowerProfile==30 ? 0:1;
         // end Add
			if( !pReg->ValueExists("ColorFontName") )
			{
				PanelColorTable->Font->Name="MS Sans Serif";
				pReg->WriteString("ColorFontName",PanelColorTable->Font->Name);
			}
			else
				PanelColorTable->Font->Name=pReg->ReadString("ColorFontName");

			if( !pReg->ValueExists("ColorFontSize") )
				pReg->WriteInteger("ColorFontSize",value=8);
			else
				value=pReg->ReadInteger("ColorFontSize");
			PanelColorTable->Font->Size=value;
			LabelColorFont->Caption=AnsiString(PanelColorTable->Font->Name)+AnsiString(",")+AnsiString(PanelColorTable->Font->Size);

			if( !pReg->ValueExists("ColorRowsHeight") )
				pReg->WriteInteger("ColorRowsHeight",value=21);
			else
				value=pReg->ReadInteger("ColorRowsHeight");
			UpDownColorHeight->Position=(short)value;
			EditColorHeight->Text=value;
			sprintf(buf,"#%d",value);
			DrawTableColor->RowsHeight=buf;

			if( !pReg->ValueExists("ColorColsWidthName") )
				pReg->WriteInteger("ColorColsWidthName",value=120);
			else
				value=pReg->ReadInteger("ColorColsWidthName");
			UpDownColorWidthName->Position=(short)value;
			EditColorWidthName->Text=value;

			if( !pReg->ValueExists("ColorColsWidthDigit") )
				pReg->WriteInteger("ColorColsWidthDigit",value2=83);
			else
				value2=pReg->ReadInteger("ColorColsWidthDigit");
			UpDownColorWidthDigit->Position=(short)value2;
			EditColorWidthDigit->Text=value2;
			sprintf(buf,"#%d#%d",value,value2);
			DrawTableColor->ColsWidth=buf;


			if( !pReg->ValueExists("BWFontName") )
			{
				PanelBWTable->Font->Name="Courier";
				pReg->WriteString("BWFontName",PanelBWTable->Font->Name);
			}
			else
				PanelBWTable->Font->Name=pReg->ReadString("BWFontName");

			if( !pReg->ValueExists("BWFontSize") )
				pReg->WriteInteger("BWFontSize",value=12);
			else
				value=pReg->ReadInteger("BWFontSize");
			PanelBWTable->Font->Size=value;
			LabelBWFont->Caption=AnsiString(PanelBWTable->Font->Name)+AnsiString(",")+AnsiString(PanelBWTable->Font->Size);

			if( !pReg->ValueExists("BWRowsHeight") )
				pReg->WriteInteger("BWRowsHeight",value=20);
			else
				value=pReg->ReadInteger("BWRowsHeight");
			UpDownBWHeight->Position=(short)value;
			EditBWHeight->Text=value;
			sprintf(buf,"#%d",value);
			DrawTableBW->RowsHeight=buf;

			if( !pReg->ValueExists("BWColsWidthName") )
				pReg->WriteInteger("BWColsWidthName",value=200);
			else
				value=pReg->ReadInteger("BWColsWidthName");
			UpDownBWWidthName->Position=(short)value;
			EditBWWidthName->Text=value;

			if( !pReg->ValueExists("BWColsWidthDigit") )
				pReg->WriteInteger("BWColsWidthDigit",value2=100);
			else
				value2=pReg->ReadInteger("BWColsWidthDigit");
			UpDownBWWidthDigit->Position=(short)value2;
			EditBWWidthDigit->Text=value2;
			sprintf(buf,"#%d#%d",value,value2);
			DrawTableBW->ColsWidth=buf;

                        //GRB ADD 14.09.2021 - вычитываем из реестра флаг использования режима отрисовки колонки с именем группы по ширине самого длинного элемента
                        if( pReg->ValueExists("isContainedWidth") )
                                RadioGroupColWidthName->ItemIndex=(pReg->ReadInteger("isContainedWidth")==0) ? 0 : 1;
                        else
                                RadioGroupColWidthName->ItemIndex=0;
                        //end add
		}
		catch(Exception &e)
		{
                        PowerProfile = 30;
			pReg->CloseKey();
			delete pReg;
			throw;
		}
	}
	else
		throw Exception(AnsiString(Reconst_smes129_3));
	pReg->CloseKey();


  //chig
	if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\PLSQLRep", true) )
	{
		try
		{
			if( !pReg->ValueExists("PLSQLRepFontName") )
			{
				REdPLSQLRep->Font->Name="Courier New";
				pReg->WriteString("PLSQLRepFontName",REdPLSQLRep->Font->Name);
			}
			else
				REdPLSQLRep->Font->Name=pReg->ReadString("PLSQLRepFontName");

			if( !pReg->ValueExists("PLSQLRepFontSize") )
				pReg->WriteInteger("PLSQLRepFontSize",value=10);
			else
				value=pReg->ReadInteger("PLSQLRepFontSize");
			REdPLSQLRep->Font->Size=value;

			PLSQLRepFont->Caption
        =AnsiString(REdPLSQLRep->Font->Name)+AnsiString(",")+AnsiString(REdPLSQLRep->Font->Size);

			if( !pReg->ValueExists("PLSQLRepFontColor") )
				pReg->WriteInteger("PLSQLRepFontColor",REdPLSQLRep->Font->Color);
			else
				REdPLSQLRep->Font->Color=(TColor)pReg->ReadInteger("PLSQLRepFontColor");

      TFontStyles s;
			if( !pReg->ValueExists("PLSQLRepFontStyle") )
      {
        TFontStyles s = REdPLSQLRep->Font->Style;
        int i;
        memcpy((void *)&i, (void *)&s, sizeof(i));
				pReg->WriteInteger("PLSQLRepFontStyle",i);
      }
			else
      {
        int i=pReg->ReadInteger("PLSQLRepFontStyle");
        memcpy((void *)&s, (void *)&i, sizeof(s));
				REdPLSQLRep->Font->Style=s;
      }
      //Способ печати
			if( !pReg->ValueExists("PLSQLRepPrintMode") )
				pReg->WriteInteger("PLSQLRepPrintMode",value=1);
			else
				value=pReg->ReadInteger("PLSQLRepPrintMode");
      value = value? 1: 0;
      RGrPrintMode->ItemIndex = value;
      //e Способ печати
		}
		catch(Exception &e)
		{
			pReg->CloseKey();
			delete pReg;
			throw;
		}
	}
	else
		throw Exception(AnsiString(Reconst_smes129_3));
	pReg->CloseKey();
  //e chig
// add KAS
	if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitoring\\SoundWarnings", true) )
	{
		try
		{
                    FCommDataWarningSound = pReg->ValueExists("CommDataWarningSound") ? pReg->ReadBool("CommDataWarningSound"):false;
                    FTechDataWarningSound = pReg->ValueExists("TechDataWarningSound") ? pReg->ReadBool("TechDataWarningSound"):false;
                    FServiceWarningSound = pReg->ValueExists("ServiceWarningSound") ? pReg->ReadBool("ServiceWarningSound"):false;
                    FFrequency = pReg->ValueExists("Frequency") ? pReg->ReadInteger("Frequency"):1000;
                    FDuration = pReg->ValueExists("Duration") ? pReg->ReadInteger("Duration"):500;
                    FPause = pReg->ValueExists("Pause") ? pReg->ReadInteger("Pause"):300;
		}
		catch(Exception &e)
		{
			pReg->CloseKey();
			delete pReg;
			throw;
		}
	}
	else
		throw(Exception(AnsiString(Reconst_smes129_3)));
	pReg->CloseKey();
  //e KAS

   // Add by KSS // Инициализация вкладки Графика
	if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors\\Graph", true) )
	{
      try
		{
         cbPoints->Checked = pReg->ValueExists("ShowPoints") ? pReg->ReadBool("ShowPoints"):false;
         cbMarks->Checked = pReg->ValueExists("ShowMarks") ? pReg->ReadBool("ShowMarks"):false;
         rgDiagramType->ItemIndex = pReg->ValueExists("DiagramType") ? pReg->ReadInteger("DiagramType"):0;
		}
		catch(Exception &e)
		{
			pReg->CloseKey();
			delete pReg;
			throw;
		}
	}
	else
		throw Exception(AnsiString(Reconst_smes129_3));
	pReg->CloseKey();
   // End KAA
	delete pReg;
        CheckBox1->Checked = FCommDataWarningSound;
        CheckBox2->Checked = FTechDataWarningSound;
        CheckBox3->Checked = FServiceWarningSound;
        Edit1->Text = FFrequency;
        Edit2->Text = FDuration;
        Edit3->Text = FPause;
}
//---------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::ButtonColorFontClick(TObject *Sender)
{
	if( FontDialog->Execute() )
	{
		LabelColorFont->Caption=AnsiString(FontDialog->Font->Name)+AnsiString(",")+AnsiString(FontDialog->Font->Size);
		PanelColorTable->Font->Name=FontDialog->Font->Name;
		PanelColorTable->Font->Size=FontDialog->Font->Size;
		DrawTableColor->Invalidate();
	}
}
//---------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::EditColorHeightChange(TObject *Sender)
{
	DrawTableColor->RowsHeight=AnsiString("#")+(EditColorHeight->Text.IsEmpty()?AnsiString("10"):EditColorHeight->Text);
	DrawTableColor->ColsWidth=AnsiString("#")+(EditColorWidthName->Text.IsEmpty()?AnsiString("10"):EditColorWidthName->Text)+
		AnsiString("#")+(EditColorWidthDigit->Text.IsEmpty()?AnsiString("10"):EditColorWidthDigit->Text);
}
//---------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::ButtonBWFontClick(TObject *Sender)
{
	if( FontDialog->Execute() )
	{
		LabelBWFont->Caption=AnsiString(FontDialog->Font->Name)+AnsiString(",")+AnsiString(FontDialog->Font->Size);
		PanelBWTable->Font->Name=FontDialog->Font->Name;
		PanelBWTable->Font->Size=FontDialog->Font->Size;
		DrawTableBW->Invalidate();
	}
}
//---------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::EditBWHeightChange(TObject *Sender)
{
	DrawTableBW->RowsHeight=AnsiString("#")+(EditBWHeight->Text.IsEmpty()?AnsiString("10"):EditBWHeight->Text);
	DrawTableBW->ColsWidth=AnsiString("#")+(EditBWWidthName->Text.IsEmpty()?AnsiString("10"):EditBWWidthName->Text)+
		AnsiString("#")+(EditBWWidthDigit->Text.IsEmpty()?AnsiString("10"):EditBWWidthDigit->Text);
}
//---------------------------------------------------------------------------
/*void __fastcall TFormSetupMonitors::SetRateZona(int Rate)
{
   dmMain->quMain->Params->Clear();
   dmMain->quMain->SQL->Text="begin "+SchemeName+"interior_pg.set_RateZona(:par1); end;";
   dmMain->quMain->ParamByName("par1")->AsInteger= Rate;
   dmMain->quMain->Execute();
 } */
//-----------------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::BitBtn1Click(TObject *Sender)
{
    TRegistry *pReg=new TRegistry;
    pReg->Access=KEY_WRITE;
	pReg->RootKey=HKEY_CURRENT_USER;

	if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors", true) )
	{
	    try
		{
      pReg->WriteInteger("ShowManual", RadioGroupShowValidity->ItemIndex);
      pReg->WriteInteger("kindOfADddBalanceDiag", kindOfADddBalanceDiag);
      pReg->WriteInteger("PowerProfile", PowerProfile);
      pReg->WriteInteger("PowerCoeff", PowerCoeff);

   //   pReg->WriteInteger("RateZona",RateZona);
      pReg->WriteString("ColorFontName",PanelColorTable->Font->Name);
			pReg->WriteInteger("ColorFontSize",PanelColorTable->Font->Size);
			pReg->WriteInteger("ColorRowsHeight",DrawTableColor->RowHeights[0]);
			pReg->WriteInteger("ColorColsWidthName",DrawTableColor->ColWidths[0]);
			pReg->WriteInteger("ColorColsWidthDigit",DrawTableColor->ColWidths[1]);

			pReg->WriteString("BWFontName",PanelBWTable->Font->Name);
			pReg->WriteInteger("BWFontSize",PanelBWTable->Font->Size);
			pReg->WriteInteger("BWRowsHeight",DrawTableBW->RowHeights[0]);
			pReg->WriteInteger("BWColsWidthName",DrawTableBW->ColWidths[0]);
			pReg->WriteInteger("BWColsWidthDigit",DrawTableBW->ColWidths[1]);

      pReg->WriteString("ExportSeparator",(cbFormatPnt->ItemIndex == 1) ? (",") : ("."));
      pReg->WriteInteger("isSpecFormat", cbSpecFormat->Checked);
      //GRB ADD 14.09.2021 Сохранение в реестр позиции использования режима отрисовки колонки с именем группы по ширине самого длинного элемента
      pReg->WriteInteger("isContainedWidth",(RadioGroupColWidthName->ItemIndex == 1) ? 1 : 0);

      //END ADD
		}
		catch(Exception &e)
		{
			pReg->CloseKey();
			delete pReg;
			throw;
		}
    }
	else
		throw Exception(AnsiString(Reconst_smes129_3));
	pReg->CloseKey();

    //chig
	if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\PLSQLRep", true) )
	{
	    try
		{
		    pReg->WriteString("PLSQLRepFontName",REdPLSQLRep->Font->Name);
			pReg->WriteInteger("PLSQLRepFontSize",REdPLSQLRep->Font->Size);
			pReg->WriteInteger("PLSQLRepFontColor",REdPLSQLRep->Font->Color);

            int i;
            memcpy(&i, &(REdPLSQLRep->Font->Style), sizeof(i));

			pReg->WriteInteger("PLSQLRepFontStyle",i);
			pReg->WriteInteger("PLSQLRepPrintMode",RGrPrintMode->ItemIndex);
		}
		catch(Exception &e)
		{
			pReg->CloseKey();
			delete pReg;
			throw;
		}
	}
	else
        throw Exception(AnsiString(Reconst_smes129_3));
	pReg->CloseKey();
    //e chig
    // add KAS
	if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitoring\\SoundWarnings", true) )
	{
	    try
		{
            FCommDataWarningSound = CheckBox1->Checked;
            FTechDataWarningSound = CheckBox2->Checked;
            FServiceWarningSound = CheckBox3->Checked;
            FFrequency = Edit1->Text.ToInt();
            FDuration = Edit2->Text.ToInt();
            FPause = Edit3->Text.ToInt();
            pReg->WriteBool("CommDataWarningSound",FCommDataWarningSound);
            pReg->WriteBool("TechDataWarningSound",FTechDataWarningSound);
            pReg->WriteBool("ServiceWarningSound",FServiceWarningSound);
            pReg->WriteInteger("Frequency",FFrequency);
            pReg->WriteInteger("Duration",FDuration);
            pReg->WriteInteger("Pause",FPause);
            // 14.01.2009 KAG start
            if (!(FCommDataWarningSound || FTechDataWarningSound || FServiceWarningSound))
              MinitoringStopSoundWarning();
            // 14.01.2009 KAG end
        }
		catch(Exception &e)
		{
		    pReg->CloseKey();
			delete pReg;
			throw;
        }
	}
	else
		throw Exception(AnsiString(Reconst_smes129_3));
    pReg->CloseKey();
    //e KAS
    // Add by KSS // Save Graph parameters
	if( pReg->OpenKey("\\SOFTWARE\\Grant\\Ascue\\Monitors\\Graph", true) )
	{
	    try
		{
            pReg->WriteBool("ShowPoints",cbPoints->Checked);
            pReg->WriteBool("ShowMarks",cbMarks->Checked);
            pReg->WriteInteger("DiagramType", rgDiagramType->ItemIndex);
        }
		catch(Exception &e)
		{
		    pReg->CloseKey();
			delete pReg;
			throw;
	    }
    }
	else
		throw Exception(AnsiString(Reconst_smes129_3));
	pReg->CloseKey();
    // end KSS
    delete pReg;
}
//---------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::FormShow(TObject *Sender)
{
  
    OnViewUpdate(Sender);
	InitRegistry();


}
//---------------------------------------------------------------------------

void __fastcall TFormSetupMonitors::RadioGroupProfilePowerClick(TObject *Sender)
{
//Add by Nadtochiy при добавлении промежутка времени добавить соответстуеющий case
   switch(RadioGroupProfilePower->ItemIndex)
   {
     case 0 : {PowerProfile = 60; break;}
     case 1 : {PowerProfile = 30; break;}
     case 2 : {PowerProfile = 15; break;}
   }
//end ADD
}
//---------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::RadioGroupPowerCoeffClick(
      TObject *Sender)
{
    switch(RadioGroupPowerCoeff->ItemIndex)
   {
     case 0 : {PowerCoeff = 1; break;}
     case 1 : {PowerCoeff = 1000; break;}
   }
   dmMain->quMain->Params->Clear();
   dmMain->quMain->SQL->Text="begin "+SchemeName+"interior_pg.set_powercoeff(:par1); end;";
   dmMain->quMain->ParamByName("par1")->AsInteger= PowerCoeff;
   dmMain->quMain->Execute();


}
//---------------------------------------------------------------------------


void __fastcall TFormSetupMonitors::Button1Click(TObject *Sender)
{
    FontDialog->Options << fdEffects;
    //Привносим тепараметры, что были
    FontDialog->Font=REdPLSQLRep->Font;
    //e Привносим тепараметры, что были
	if( FontDialog->Execute() )
	{
	    PLSQLRepFont->Caption=AnsiString(FontDialog->Font->Name)+AnsiString(",")+AnsiString(FontDialog->Font->Size);
        REdPLSQLRep->Font=FontDialog->Font;
    }
    FontDialog->Options >> fdEffects;
}
//---------------------------------------------------------------------------
// add by KSS
void __fastcall TFormSetupMonitors::lShowManualClick(TObject *Sender)
{
    //cbShowManual->Checked = !cbShowManual->Checked;
}
//---------------------------------------------------------------------------
// add by KSS
void __fastcall TFormSetupMonitors::MinitoringPlaySoundWarning(long aDataControlType)
{
    if(Timer1->Enabled == false)
        Timer1->Interval = FPause+FDuration;
    if(aDataControlType==0&&FCommDataWarningSound)
    {
        Timer1->Enabled = true;
        FCommBeep = 1;
    }
    if(aDataControlType==1&&FTechDataWarningSound)
    {
        Timer1->Enabled = true;
        FTechBeep = 1;
    }
    if(aDataControlType==2)
    {
      if(FServiceWarningSound)
      {
        Timer1->Enabled = true;
        FServBeep = 1;
      }
      else
      {
        MinitoringStopSoundWarning();
      }
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::MinitoringStopSoundWarning()
{
   Timer1->Enabled = false;
   try{
      if(FCommBeep)
       {
        dmMain->quMain->Params->Clear();
        dmMain->quMain->SQL->Text="begin "+SchemeName+"monitoring_pg.receipt_data_absence_p(:par1, 0); end;";
        dmMain->quMain->ParamByName("par1")->AsInteger= UsCon.Role_Id;
        dmMain->quMain->Execute();
        dmMain ->orases->Commit();
        }

    }catch(Exception &e){
          dmMain ->orases->Rollback();
          Application->ShowException(&e);
    }
  try{
     if(FTechBeep)
    {
        dmMain->quMain->Params->Clear();
        dmMain->quMain->SQL->Text="begin "+SchemeName+"monitoring_pg.receipt_data_absence_p(:par1, 1); end;";
        dmMain->quMain->ParamByName("par1")->AsInteger= UsCon.Role_Id;
        dmMain->quMain->Execute();
        dmMain ->orases->Commit();
    }

    FCommBeep = FTechBeep = FServBeep = 0;
   }catch(Exception &e){
    dmMain ->orases->Rollback();
    Application->ShowException(&e);
    }
 }
//---------------------------------------------------------------------------

void __fastcall TFormSetupMonitors::Timer1Timer(TObject *Sender)
{
    Beep(FFrequency,FDuration);
//           Sleep(FPause);
}
//---------------------------------------------------------------------------

void __fastcall TFormSetupMonitors::cbPointsClick(TObject *Sender)
{
    if(pLine)
        pLine->Pointer->Visible = cbPoints->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TFormSetupMonitors::cbMarksClick(TObject *Sender)
{
    pLine->Marks->Visible = cbMarks->Checked;
    pBar->Marks->Visible = cbMarks->Checked;
    pPie->Marks->Visible = cbMarks->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TFormSetupMonitors::OnViewUpdate(TObject *Sender)
{
    if(!cbDiagram->Checked){
        pLine->Active = true;//выбор типа отображения информации
        pBar->Active = false;
        pPie->Active = false;
    }else if(rgDiagramType->ItemIndex==0){
        pLine->Active = false;
        pBar->Active = true;
        pPie->Active = false;
    }else if(rgDiagramType->ItemIndex==1){
        pLine->Active = false;
        pBar->Active = false;
        pPie->Active = true;
    }
}
//---------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::ChecAddFoBalanseClick(TObject *Sender)
{
   switch(ChecAddFoBalanse->ItemIndex)
   {
     case 0:{kindOfADddBalanceDiag = 2; break;}
     case 1:{kindOfADddBalanceDiag = 3; break;}
   }
}
//---------------------------------------------------------------------------
void __fastcall TFormSetupMonitors::RadioGroupShowValidityClick(
      TObject *Sender)
{
   ShowValidity = RadioGroupShowValidity->ItemIndex;

    TDrawTable::SAttrCell*pAttr;
    pAttr = (TDrawTable::SAttrCell*)DrawTableColor->GetCellAttr(1,1);
    if(!pAttr)
        return;

    if(ShowValidity == 1)
        pAttr->DataSource = dsAll;

    else if (ShowValidity == 2)
        pAttr->DataSource = dsElectr;
    else
        pAttr->DataSource = dsClear;
    pAttr = (TDrawTable::SAttrCell*)DrawTableColor->GetCellAttr(3,1);
    if(!pAttr) return;
    if(ShowValidity == 1)
        pAttr->DataSource = dsMan;
    else if (ShowValidity == 2)
        pAttr->DataSource = dsElectr;
    else
        pAttr->DataSource = dsClear;
    pAttr = (TDrawTable::SAttrCell*)DrawTableColor->GetCellAttr(1,3);
    if(!pAttr)
        return;
    if(ShowValidity == 1)
        pAttr->DataSource = dsMan;

    else if (ShowValidity == 2)
        pAttr->DataSource = dsElectr;
    else
        pAttr->DataSource = dsClear;
    pAttr = (TDrawTable::SAttrCell*)DrawTableColor->GetCellAttr(3,3);
    if(!pAttr)
        return;
    if(ShowValidity == 1)
        pAttr->DataSource = dsMan;
    else if (ShowValidity == 2)
        pAttr->DataSource = dsElectr;
    else
        pAttr->DataSource = dsClear;
    pAttr = (TDrawTable::SAttrCell*)DrawTableColor->GetCellAttr(4,4);
    if(!pAttr) return;
    if(ShowValidity == 1)
        pAttr->DataSource = dsOvCh;
    else if (ShowValidity == 2)
        pAttr->DataSource = dsElectr;
    else
        pAttr->DataSource = dsClear;
    DrawTableColor->Repaint();


   dmMain->quMain->Params->Clear();
   dmMain->quMain->SQL->Text="begin "+SchemeName+"interior_pg.set_showvalidity(:par1); end;";
   dmMain->quMain->ParamByName("par1")->AsInteger= ShowValidity;
   dmMain->quMain->Execute();
}
//---------------------------------------------------------------------------

