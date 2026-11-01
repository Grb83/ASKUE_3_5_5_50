//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <values.h>
#include <math.h>
#pragma hdrstop
#include "unDataMod.h"
#include "InputParam.h"
#include "ManualInput.h"
#include "Reconst.hpp"
#include "GetSelectDate.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DrawTable"
#pragma link "DBGridEh"
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma link "VirtualTable"
#pragma link "PrnDbgeh"
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TfmManualInput::TfmManualInput(TComponent* Owner,AnsiString Name, long ttable,long rezerv, TAccess a)
	: TMainForm(Owner, Name, a)
{
 //rezerv-0 TaskMenu;1-EditFeeders;2-EditGroup
 ReplaceRyda(this,BASE_SCHEME,SchemeName);
 EditSum=false;
 INV=false;
 isEditFeeders=rezerv;   //Вызов из контекстного меню
 TestMid=ttable;         // Передаваемый mid
 iaCopySAA->OnExecute    = vCopyClick;
 iaPasteSAA->OnExecute    = vPasteClick;
 Access=a;
 
 }
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::FormCreate(TObject *Sender)
{
  TCount=0;
  p.Step=1;
  p.myTime=TDateTime::CurrentDate()-1;

  if (isEditFeeders==0)
  vParams(NULL);
  else {
   p.ifpoint=isEditFeeders==2?0:1;
   vParamsEditFeeders();
   }
}
//---------------------------------------------------------------------------------------
void __fastcall TfmManualInput::vParamsEditFeeders()
{


 int FRowCount;
    try{
      p.mid=TestMid;
       vtData->DisableControls();
       vtData->AfterPost=NULL;



     GetColumnName();

     tp=p;
      ReadData();


   vtData->AfterPost=vtDataAfterPost;

   dbManInput->SumList->RecalcAll();
    vtData->EnableControls();



  }catch (Exception &exception){

  	Application->ShowException(&exception);

  }
}
//---------------------------------------------------------------------------
void __fastcall TfmManualInput::vParams(TObject* Sender)
{

 TFormManualInTree *f=NULL;
 int FRowCount;
    try{

    f= new TFormManualInTree(this,&p);
    //GRB ADD
    /*if ((f->tvMain->Selected->ImageIndex == 4)||((f->tvMain->Selected->ImageIndex == 2)&&(f->tvMain->Selected->Parent->ImageIndex ==4 ) )){
     tbCopyData->Enabled = false;
    }else{
     tbCopyData->Enabled = true;
    } */
    //END ADD
    if((f->ShowModal() == mrOk)&&f->tvMain->Selected){
       vtData->DisableControls();
       vtData->AfterPost=NULL;

       NameGroup=f->tvMain->Selected->Text;

  if(Sender)
     {
    dbManInput->Columns->BeginUpdate();
    dbManInput->FrozenCols=0;
    dbManInput->FooterRowCount=0;
    dbManInput->Columns->Clear();
     vtData->Close();
     vtData->Clear();
     vtData->DeleteFields();
     }
   if(p.Step==2||p.Step==3)
  {
   INV=true;
    cbConst->Enabled=false;
  }else{
      cbConst->Enabled=true;
      INV=cbInv->Checked;
  }
      
     GetColumnName();
    // ReadMaxValue();
     tp=p;
     TestMid=p.mid;
     ReadData();

     }else{
      if(!Sender)
            Close();
    }
   vtData->AfterPost=vtDataAfterPost;

   dbManInput->SumList->RecalcAll();
    vtData->EnableControls();
    delete f;

    if(Sender){
        dbManInput->SetFocus();
       }
  }catch (Exception &exception){
    if(f)
      delete f;
  	Application->ShowException(&exception);
    if(!Sender)
         Close();
  }
}
//---------------------------------------------------------------------------
 void __fastcall TfmManualInput::GetColumnName()
{

   TColumnEh *grColumn;
   AnsiString S;
  double stepProfile;
  TDateTime tempDate;
	AnsiString formatDate;
	AnsiString formatDateSum;
  double PowerProfile;
  int ind=0;
 	unsigned short year,month,day,hour, minute, sec, msec;

   //-----------------------------------   наполнение колонок фиксированных
   AnsiString NamePoint1;
   TFieldDefs *pDefs = vtData->FieldDefs;
    TFieldDef *pDef=NULL;
    //Теперь структура таблицы
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftFloat;
    pDef->Name = "mid";
    pDef->DisplayName="mid";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftString;
    pDef->Size=400;
    pDef->Name = "name";
    pDef->DisplayName="name";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftString;
    pDef->Name = "type";
    pDef->Size=40;
    pDef->DisplayName="type";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "nmeasure";
    pDef->DisplayName="nmeasure";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftString;
    pDef->Size=200;
    pDef->Name = "mtrsn";
   pDef->DisplayName="mtrsn";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "KC";
    pDef->DisplayName="KC";
  //-------------------------------------границы
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftFloat;
    pDef->Name = "predmin";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftFloat;
    pDef->Name = "predmax";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftFloat;
    pDef->Name = "avarmin";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftFloat;
    pDef->Name = "avarmax";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftFloat;
    pDef->Name = "fizmin";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftFloat;
    pDef->Name = "fizmax";
    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftFloat;
    pDef->Name = "Field0_old";

    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftString;
    pDef->Size=400;
    pDef->Name = "name_point";

    pDef = pDefs->AddFieldDef();
    pDef->DataType = ftInteger;
    pDef->Name = "IsEdit";
    //------------------------------------------------

    //-----------------------------------------------------------------
    oqReadRow->ParamByName("par1")->AsInteger= p.mid ;
    oqReadRow->ParamByName("par2")->AsInteger= p.entype[0];
    oqReadRow->ParamByName("par3")->AsInteger= p.entype[1];
    oqReadRow->ParamByName("par4")->AsInteger= p.entype[2];
    oqReadRow->ParamByName("par5")->AsInteger= p.entype[3];
    oqReadRow->ParamByName("par6")->AsInteger= p.entype[4];
    oqReadRow->ParamByName("par7")->AsInteger= p.entype[5];
    oqReadRow->ParamByName("par8")->AsInteger= p.ifpoint;
   //-------------------------------------------------------------------
    oqReadRow->Execute();
    RowCount=0;
      while (!oqReadRow->Eof)
          {
           RowCount++;
           oqReadRow->Next();
           }
    if(!RowCount)dbManInput->ReadOnly=true;
    else  dbManInput->ReadOnly=false;
    
    p.myTime.DecodeDate(&year,&month,&day);

   switch(p.Step)
  {
  case 1: PowerProfile=30;break;
  case 2: PowerProfile=15;break;
  case 3: PowerProfile=5;break;
  default: PowerProfile=60;break;
  }

    if((IsShiftTimeZona)&&(month==10)&&( p.myTime.DayOfWeek()==1&&31-day<7))  //25 час
       ColCount=24*(60/PowerProfile)+1*(60/PowerProfile);
    else if((IsShiftTimeZona)&&(month==3)&&( p.myTime.DayOfWeek()==1&&31-day<7)) //23 час
       ColCount=24*(60/PowerProfile)-1*(60/PowerProfile);
    else
     ColCount=24*(60/PowerProfile);



    hour=1;
    stepProfile=1.0/ColCount;
     if(ColCount>24*(60/PowerProfile))//25 час
    {
    stepProfile=1.0/(ColCount-60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(ColCount-60/PowerProfile);
    }
    else if(ColCount<24*(60/PowerProfile))//23 час
    {
    stepProfile=1.0/(ColCount+60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(ColCount+60/PowerProfile);
    }
    else
    {
    	stepProfile=1.0/ColCount;
     tempDate=TDateTime(year,month,day)+hour/(double)ColCount;
     }
   	formatDate="t";
		formatDateSum="dd/mm/yyyy";

  if(!INV){  // не инверсия

    for(int i=0; i<ColCount+1; i++){
      pDef = pDefs->AddFieldDef();
      pDef->DataType = ftFloat;
      pDef->Name = "Field"+IntToStr(i);
      pDef->DisplayName="Field"+IntToStr(i);

      }
  }else{    //  инверсия
     //-----------------------
     for(int i=0; i<RowCount; i++){
      pDef = pDefs->AddFieldDef();
      pDef->DataType = ftFloat;
      pDef->Name = "Field"+IntToStr(i);
      pDef->DisplayName="Field"+IntToStr(i);

      }
      pDef = pDefs->AddFieldDef();
      pDef->DataType = ftString;
      pDef->Size=100;
      pDef->Name = "date_time";
      pDef->DisplayName="date_time";
   }

   vtData->Open();

 if(!INV){  // не инверсия
   oqReadRow->Open();
   oqReadRow->First();
    RowCount=0;
      while (!oqReadRow->Eof){
           RowCount++;
       if(vtData->State==dsInsert||vtData->State==dsEdit)
            vtData->Post();
          vtData->Append();
          if(RowCount==1)
          NamePoint1=oqReadRow->FieldByName("name")->AsString;
          else
            if(NamePoint1==oqReadRow->FieldByName("name")->AsString)
               NamePoint1=" ";
            else
               NamePoint1=oqReadRow->FieldByName("name")->AsString;

          vtData->FieldByName("mid")->AsFloat=oqReadRow->FieldByName("mid")->AsFloat;
          vtData->FieldByName("name")->AsString=NamePoint1;
          vtData->FieldByName("name_point")->AsString=oqReadRow->FieldByName("name")->AsString;
          vtData->FieldByName("type")->AsString=oqReadRow->FieldByName("type")->AsString;
          vtData->FieldByName("nmeasure")->AsInteger=oqReadRow->FieldByName("nmeasure")->AsInteger;
          vtData->FieldByName("mtrsn")->AsString=oqReadRow->FieldByName("mtrsn")->AsString;
          vtData->FieldByName("KC")->AsInteger=oqReadRow->FieldByName("KC")->AsInteger;
            NamePoint1=oqReadRow->FieldByName("name")->AsString;

           vtData->FieldByName("predmin")->AsFloat=0;
           vtData->FieldByName("predmax")->AsFloat=MAXFLOAT;
           vtData->FieldByName("avarmin")->AsFloat=0;
           vtData->FieldByName("avarmax")->AsFloat=MAXFLOAT;
           vtData->FieldByName("fizmin")->AsFloat=0;
           vtData->FieldByName("fizmax")->AsFloat=MAXFLOAT;
           vtData->FieldByName("IsEdit")->AsInteger=0;


            oqMaxValue->ParamByName("par1")->AsFloat=oqReadRow->FieldByName("mid")->AsFloat;
            oqMaxValue->ParamByName("par2")->AsInteger=oqReadRow->FieldByName("nmeasure")->AsInteger;
            oqMaxValue->Execute();

            while(!oqMaxValue->Eof){

             if (!oqMaxValue->FieldByName("predmin")->IsNull)
               vtData->FieldByName("predmin")->AsFloat=oqMaxValue->FieldByName("predmin")->AsFloat;
             if (!oqMaxValue->FieldByName("predmax")->IsNull)
               vtData->FieldByName("predmax")->AsFloat=oqMaxValue->FieldByName("predmax")->AsFloat;
             if (!oqMaxValue->FieldByName("avarmin")->IsNull)
               vtData->FieldByName("avarmin")->AsFloat=oqMaxValue->FieldByName("avarmin")->AsFloat;
             if (!oqMaxValue->FieldByName("avarmax")->IsNull)
               vtData->FieldByName("avarmax")->AsFloat=oqMaxValue->FieldByName("avarmax")->AsFloat;
             if (!oqMaxValue->FieldByName("fizmin")->IsNull)
               vtData->FieldByName("fizmin")->AsFloat=oqMaxValue->FieldByName("fizmin")->AsFloat;
             if (!oqMaxValue->FieldByName("fizmax")->IsNull)
               vtData->FieldByName("fizmax")->AsFloat=oqMaxValue->FieldByName("fizmax")->AsFloat;

            oqMaxValue->Next();
            }

          oqReadRow->Next();

          }

       //фиксированные колонки
  for(int i=0;i<4;i++)
  {
  grColumn=dbManInput->Columns->Add();
  switch(i)
  {
  case 0: grColumn->Title->Caption=Reconst_smes136_1;
          grColumn->Footer->Color=(TColor)0x0080FFFF;//clYellow;
          grColumn->Color=clBtnFace;
          grColumn->ReadOnly=true;
          grColumn->Width=0;
          break;
  case 1: grColumn->Title->Caption=Reconst_smes136_2+NameGroup;
          grColumn->FieldName="name";
          grColumn->Footer->ValueType=fvtStaticText;
          grColumn->Footer->Value=Reconst_smes136_3;
          grColumn->Color=clBtnFace;
          grColumn->Footer->Color=(TColor)0x0080FFFF;//clYellow;
          grColumn->ReadOnly=true;
          grColumn->Width=200;
          grColumn->WordWrap=true;
          break;
  case 2: grColumn->Title->Caption=Reconst_smes136_4;
          grColumn->FieldName="TYPE";
          grColumn->Color=clBtnFace;
          grColumn->Footer->Color=(TColor)0x0080FFFF;//clYellow;
          grColumn->ReadOnly=true;
          grColumn->Width=45;
          break;
  case 3: grColumn->Title->Caption=Reconst_smes136_5;
          grColumn->Color=(TColor)0x0080FFFF;//clYellow;
          grColumn->Footer->ValueType=fvtSum;
          grColumn->Footer->Color=(TColor)RGB(0,255,128);//0x0080FFFF;//clYellow;
          grColumn->ReadOnly=false;
          grColumn->Width=79;
          break;
  }

  }



    dbManInput->Columns->Items[3]->Title->Caption=dbManInput->Columns->Items[3]->Title->Caption+
      +"|"+p.myTime.FormatString(formatDateSum);

    dbManInput->Columns->Items[3]->FieldName="Field"+IntToStr(0);

    for(int z=1;z<ColCount+1;z++){
      grColumn=dbManInput->Columns->Add();
      grColumn->Tag=z+(dbManInput->FrozenCols)-2;//Запоминаем порядок (а то колонки поменяют)
      grColumn->Title->Caption=tempDate.FormatString(formatDate);
      grColumn->FieldName="Field"+IntToStr(z);
      grColumn->Footer->ValueType=fvtSum;
      //------------------------------------------

    tempDate+=stepProfile;
   

     tempDate.DecodeTime(&hour, &minute, &sec, &msec);

     if((IsShiftTimeZona)&&ColCount>24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?5-TimeZona:4-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;   //25 час
           tempDate=tempDate-ind*stepProfile;

       }
     if((IsShiftTimeZona)&&ColCount<24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?4-TimeZona:3-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;   //23 час
           tempDate=tempDate+ind*stepProfile;

       }
      //---------------------------------------------

      grColumn->Width=64;




       }
      dbManInput->FrozenCols=4;
      TCount=0;
      for(int i=0;i<6;i++){
      if(p.entype[i]) TCount++;
      }
       if(TCount>1) dbManInput->FooterRowCount=0;
       else dbManInput->FooterRowCount=1;

    }else{    //  инверсия


      GetColumnNameInv();


      for(int i=1;i<ColCount+1;i++)
        {
        if(vtData->State==dsInsert||vtData->State==dsEdit)
            vtData->Post();

        vtData->Append();
        vtData->FieldByName("date_time")->AsString=tempDate.FormatString(formatDate);
        tempDate+=stepProfile;


     tempDate.DecodeTime(&hour, &minute, &sec, &msec);

     if((IsShiftTimeZona)&&ColCount>24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?5-TimeZona:4-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;   //25 час
           tempDate=tempDate-ind*stepProfile;

       }
     if((IsShiftTimeZona)&&ColCount<24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?4-TimeZona:3-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;   //23 час
           tempDate=tempDate+ind*stepProfile;

       }


        }
        //----------------------------------7.07.2009
      if(vtData->State==dsInsert||vtData->State==dsEdit)
            vtData->Post();
      vtData->Append();
      vtData->FieldByName("date_time")->AsString=p.myTime.FormatString(formatDateSum);
      dbManInput->FooterRowCount=1;
      //---------------------------------------------
    }

     dbManInput->FixedColor=clBtnFace;
     dbManInput->Columns->EndUpdate();

   //------------------------------------------------------------------------------------------
    Caption = TaskName+" за "+p.myTime.FormatString("dd.mm.yyyy");

}

//---------------------------------------------------------------------------
void __fastcall TfmManualInput::GetColumnNameInv()     //  инверсия
{
 TColumnEh *grColumn;

          grColumn=dbManInput->Columns->Add();
          grColumn->Title->Caption=Reconst_smes136_2+NameGroup+"|"+p.myTime.FormatString("dd.mm.yyyy ");
          grColumn->FieldName="date_time";
          grColumn->Footer->ValueType=fvtStaticText;
          grColumn->Footer->Value=Reconst_smes136_6;
          grColumn->Color=clBtnFace;
          grColumn->Footer->Color=(TColor)0x0080FFFF;//clYellow;
          grColumn->ReadOnly=true;
          grColumn->Width=120;
          grColumn->WordWrap=true;

       

   oqReadRow->Open();
   oqReadRow->First();
     for(int i=0;i<RowCount;i++)
     {
     grColumn=dbManInput->Columns->Add();
     grColumn->Title->Caption=oqReadRow->FieldByName("name")->AsString+"|"+oqReadRow->FieldByName("type")->AsString;
     grColumn->FieldName="Field"+IntToStr(i);

     grColumn->Footer->ValueType=fvtStaticText;
     grColumn->Footer->Color=0x0080FFFF;//clYellow;
     grColumn->ReadOnly=false;
     grColumn->Width=64;

           TestMinMax=new MAXMIN ;
           ZeroMemory(TestMinMax, sizeof(MAXMIN));
           TestMinMax->PredMin=0;
           TestMinMax->PredMax=MAXFLOAT;
           TestMinMax->AvarMin=0;
           TestMinMax->AvarMax=MAXFLOAT;
           TestMinMax->FizMin=0;
           TestMinMax->FizMax=MAXFLOAT;
           TestMinMax->mid=oqReadRow->FieldByName("mid")->AsFloat;
           TestMinMax->meas=oqReadRow->FieldByName("nmeasure")->AsInteger;
           TestMinMax->KC=oqReadRow->FieldByName("KC")->AsFloat;
           TestMinMax->mtrsn=oqReadRow->FieldByName("mtrsn")->AsString;

            oqMaxValue->ParamByName("par1")->AsFloat=oqReadRow->FieldByName("mid")->AsFloat;
            oqMaxValue->ParamByName("par2")->AsInteger=oqReadRow->FieldByName("nmeasure")->AsInteger;
            oqMaxValue->Execute();

            while(!oqMaxValue->Eof){

             if (!oqMaxValue->FieldByName("predmin")->IsNull)
               TestMinMax->PredMin=oqMaxValue->FieldByName("predmin")->AsFloat;
             if (!oqMaxValue->FieldByName("predmax")->IsNull)
               TestMinMax->PredMax=oqMaxValue->FieldByName("predmax")->AsFloat;
             if (!oqMaxValue->FieldByName("avarmin")->IsNull)
               TestMinMax->AvarMin=oqMaxValue->FieldByName("avarmin")->AsFloat;
             if (!oqMaxValue->FieldByName("avarmax")->IsNull)
               TestMinMax->AvarMax=oqMaxValue->FieldByName("avarmax")->AsFloat;
             if (!oqMaxValue->FieldByName("fizmin")->IsNull)
               TestMinMax->FizMin=oqMaxValue->FieldByName("fizmin")->AsFloat;
             if (!oqMaxValue->FieldByName("fizmax")->IsNull)
               TestMinMax->FizMax=oqMaxValue->FieldByName("fizmax")->AsFloat;
              TestMinMax->IsEdit=0;
            oqMaxValue->Next();
            }
           grColumn->Tag=(long)TestMinMax;

  

     oqReadRow->Next();
     }
    oqReadRow->Close();


   if(dbManInput->Columns->Count>1)
          dbManInput->FrozenCols=1;
    }


//-----------------------------------------------------------------------

void __fastcall TfmManualInput::ReadData()
{
 double stepProfile;
 double Step;
  TDateTime tempDate;
	AnsiString formatDate;
	AnsiString formatDateSum;
 	unsigned short year,month,day,hour;
    /*if (p.ifpoint==0){
     tbCopyData->Enabled = false;
    }else{
     tbCopyData->Enabled = true;
    } */

 //-------------------------------------------------------------- DATA
  switch(p.Step)
  {
  case 1: Step=24*(60/30);break;
  case 2: Step=24*(60/15);break;
  case 3: Step=24*(60/5);break;
  default: Step=24;break;
  }
    oqReadData->ParamByName("par1")->AsInteger= p.mid ;
    oqReadData->ParamByName("par2")->AsInteger= p.entype[0];
    oqReadData->ParamByName("par3")->AsInteger= p.entype[1];
    oqReadData->ParamByName("par4")->AsInteger= p.entype[2];
    oqReadData->ParamByName("par5")->AsInteger= p.entype[3];
    oqReadData->ParamByName("par6")->AsInteger= p.entype[4];
    oqReadData->ParamByName("par7")->AsInteger= p.entype[5];
    oqReadData->ParamByName("par8")->AsInteger= p.ifpoint;
    oqReadData->ParamByName("par9")->AsString = p.myTime.FormatString("dd.mm.yyyy hh:nn:ss");
    oqReadData->ParamByName("par10")->AsInteger= Step;
    oqReadData->ParamByName("par11")->AsInteger= ColCount+1;
    oqReadData->ParamByName("par12")->AsString = tp.myTime.FormatString("dd.mm.yyyy hh:nn:ss");
    oqReadData->ParamByName("par13")->Length=(ColCount+1)*RowCount;
    oqReadData->ParamByName("par14")->AsInteger= p.mid;



    oqReadData->Execute();


  if(!INV)    // не инверсия

   {
   vtData->First();
    for(int k=0; k<RowCount;k++)

     {
       if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();


        for(int i=0;i<ColCount+1;i++)
              {
             // vtData->FieldByName("Field"+IntToStr(i))->OnChange=
              vtData->Edit();
                if(!oqReadData->ParamByName("par13")->ItemIsNull[(i+1)+((ColCount+1)*k)]){
                 vtData->FieldByName("Field"+IntToStr(i))->AsFloat= oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*k)];
               if(i==0)
                 vtData->FieldByName("Field0_old")->AsFloat=vtData->FieldByName("Field0")->AsFloat ;
                 } else
                vtData->FieldByName("Field"+IntToStr(i)) ->Clear();

              }
             vtData->Next();
          // }

     }
   }else{    //  инверсия

 /*  for(int k=0;k<RowCount;k++)
           {

           }*/
          for(int k=0;k<RowCount;k++)
           {
             vtData->First();
               for(int i=0;i<ColCount+2;i++)
               {
                if (i==0)
                {
                dbManInput->Columns->Items[k+1]->Footer->Value=
                    FormatFloat("0.000",oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*k)]);
                    ((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->old
                    =oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*k)];
                    ((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->SumInv
                    =oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*k)];
                i++;
                 }
              if(i<ColCount+1)
              {

                 vtData->Edit();
               if(!oqReadData->ParamByName("par13")->ItemIsNull[(i+1)+((ColCount+1)*k)])
                 vtData->FieldByName("Field"+IntToStr(k))->AsFloat=
                 oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*k)];
              else
               vtData->FieldByName("Field"+IntToStr(k)) ->Clear();
              }
              else{
               vtData->Edit();
               vtData->FieldByName("Field"+IntToStr(k))->AsFloat=StrToFloat(dbManInput->Columns->Items[k+1]->Footer->Value);
              }


               vtData->Next();
             }
         }

        vtData->First();

    }
   

}
/*Old Version before 26.01.2021 - Commented by GRB - тут был баг проявлявшийся в копировании за предыдущую дату - размножался по последнему показателю последней точки данные за точку где-то в середине
  Разрулить это красиво я не смог - написал заплатку с getLastMid() и этот случай рассматривал отдельно - на всякий случай оставляю старую версию процедуры если где ещё стрельнет
*/
//-----------------------------------------------------------------------

/*void __fastcall TfmManualInput::CopyData()
{
 double stepProfile;
 double Step;
  TDateTime tempDate;
	AnsiString formatDate;
	AnsiString formatDateSum;
 	unsigned short year,month,day,hour;
   TBookmark SavePlace;
   SavePlace = vtData->GetBookmark();
 //-------------------------------------------------------------- DATA
  switch(p.Step)
  {
  case 1: Step=24*(60/30);break;
  case 2: Step=24*(60/15);break;
  case 3: Step=24*(60/5);break;
  default: Step=24;break;
  }
    oqReadData->ParamByName("par1")->AsInteger= p.mid ;    //? ???? ????????
    oqReadData->ParamByName("par2")->AsInteger= p.entype[0];
    oqReadData->ParamByName("par3")->AsInteger= p.entype[1];
    oqReadData->ParamByName("par4")->AsInteger= p.entype[2];
    oqReadData->ParamByName("par5")->AsInteger= p.entype[3];
    oqReadData->ParamByName("par6")->AsInteger= p.entype[4];
    oqReadData->ParamByName("par7")->AsInteger= p.entype[5];
    oqReadData->ParamByName("par8")->AsInteger= p.ifpoint;
    oqReadData->ParamByName("par9")->AsString = p.myTime.FormatString("dd.mm.yyyy hh:nn:ss");
    oqReadData->ParamByName("par10")->AsInteger= Step;
    oqReadData->ParamByName("par11")->AsInteger= ColCount+1;
    oqReadData->ParamByName("par12")->AsString = tp.myTime.FormatString("dd.mm.yyyy hh:nn:ss");
    oqReadData->ParamByName("par13")->Length=(ColCount+1)*RowCount;
    oqReadData->ParamByName("par14")->AsInteger= TestMid;   //?? ??? ????????


    oqReadData->Execute();


  if(!INV)    // ?? ????????

   {
     int t=0;
   vtData->First();
    for(int k=0; k<RowCount;k++)

     {
       if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

     if (TestMid==vtData->FieldByName("mid")->AsFloat)
              {
         vtData->Edit();
         vtData->FieldByName("IsEdit")->AsInteger=1;
          for(int i=0;i<ColCount+1;i++)
               {

               vtData->Edit();
               if(!oqReadData->ParamByName("par13")->ItemIsNull[(i+1)+((ColCount+1)*t)]){
                 vtData->FieldByName("Field"+IntToStr(i))->AsFloat= oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)];
               if(i==0)
                 vtData->FieldByName("Field0_old")->AsFloat=vtData->FieldByName("Field0")->AsFloat ;
                 } else
                vtData->FieldByName("Field"+IntToStr(i)) ->Clear();



                }
             t++;
           } else   vtData->Next();

            vtData->Next();

    }

   }else{    //  ????????

   //for(int k=0;k<RowCount;k++)
   //        {
   //
   //        }
            int t=0;
          for(int k=0;k<RowCount;k++)
           {
             if (TestMid==((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->mid)
              {
               vtData->First();
               ((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->IsEdit=1;
               for(int i=0;i<ColCount+2;i++)
               {



                if (i==0)
                {
                dbManInput->Columns->Items[k+1]->Footer->Value=
                    FormatFloat("0.000",oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)]);
                    ((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->old
                    =oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)];
                    ((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->SumInv
                    =oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)];
                i++;
                 }
              if(i<ColCount+1)
              {

                 vtData->Edit();
               if(!oqReadData->ParamByName("par13")->ItemIsNull[(i+1)+((ColCount+1)*t)])
                 vtData->FieldByName("Field"+IntToStr(k))->AsFloat=
                 oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)];
              else
               vtData->FieldByName("Field"+IntToStr(k)) ->Clear();

              }

              else{
               vtData->Edit();
               vtData->FieldByName("Field"+IntToStr(k))->AsFloat=StrToFloat(dbManInput->Columns->Items[k+1]->Footer->Value);

               }


               vtData->Next();
             }
             t++;
           }


         }

       // vtData->First();
        vtData->GotoBookmark(SavePlace);
     vtData->FreeBookmark(SavePlace);

  }    //  ????????
   

} */

//---------------------------------------------------------------------------

//-----------------------------------------------------------------------
// GRB 26.01.2021 - REWRITE - исправление бага сверху
void __fastcall TfmManualInput::CopyData()
{
 double stepProfile;
 double Step;
  TDateTime tempDate;
	AnsiString formatDate;
	AnsiString formatDateSum;
 	unsigned short year,month,day,hour;
   TBookmark SavePlace;
   SavePlace = vtData->GetBookmark();
   long last_mid_grb = getLastMid ();

 //-------------------------------------------------------------- DATA
  switch(p.Step)
  {
  case 1: Step=24*(60/30);break;
  case 2: Step=24*(60/15);break;
  case 3: Step=24*(60/5);break;
  default: Step=24;break;
  }
    oqReadData->ParamByName("par1")->AsInteger= p.mid ;    //с чего копируем
    oqReadData->ParamByName("par2")->AsInteger= p.entype[0];
    oqReadData->ParamByName("par3")->AsInteger= p.entype[1];
    oqReadData->ParamByName("par4")->AsInteger= p.entype[2];
    oqReadData->ParamByName("par5")->AsInteger= p.entype[3];
    oqReadData->ParamByName("par6")->AsInteger= p.entype[4];
    oqReadData->ParamByName("par7")->AsInteger= p.entype[5];
    oqReadData->ParamByName("par8")->AsInteger= 1/*p.ifpoint*/; //28.01.2021 GRB - для работы в дереве групп тут меняем было p.ifpoint
    oqReadData->ParamByName("par9")->AsString = p.myTime.FormatString("dd.mm.yyyy hh:nn:ss");
    oqReadData->ParamByName("par10")->AsInteger= Step;
    oqReadData->ParamByName("par11")->AsInteger= ColCount+1;
    oqReadData->ParamByName("par12")->AsString = tp.myTime.FormatString("dd.mm.yyyy hh:nn:ss");
    oqReadData->ParamByName("par13")->Length=(ColCount+1)*RowCount;
    oqReadData->ParamByName("par14")->AsInteger= TestMid;   //на что копируем


    oqReadData->Execute();


  if(!INV)    // не инверсия

   {
     int t=0;
   vtData->First();
    for(int k=0; k<RowCount;k++)
     {
       if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

     if (TestMid==vtData->FieldByName("mid")->AsFloat)
              {
         vtData->Edit();
         vtData->FieldByName("IsEdit")->AsInteger=1;
        //26.01.2021 - Тут начинается ветка для проблемной последней точки в списке
          if ((last_mid_grb>-1)&&(TestMid==vtData->FieldByName("mid")->AsFloat)&&(last_mid_grb == vtData->FieldByName("mid")->AsFloat)){
          //if (t>3) break;
          for(int i=0;i<ColCount+1;i++){
               vtData->Edit();
               if(!oqReadData->ParamByName("par13")->ItemIsNull[(i+1)+((ColCount+1)*t)]){
				 vtData->FieldByName("Field"+IntToStr(i))->AsFloat= oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)];
               if(i==0)
                 vtData->FieldByName("Field0_old")->AsFloat=vtData->FieldByName("Field0")->AsFloat ;
                 } else
                vtData->FieldByName("Field"+IntToStr(i)) ->Clear();
              }
          }else//тут все остальные
          for(int i=0;i<ColCount+1;i++)
               {
               vtData->Edit();
               if(!oqReadData->ParamByName("par13")->ItemIsNull[(i+1)+((ColCount+1)*t)]){
				 vtData->FieldByName("Field"+IntToStr(i))->AsFloat= oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)];
               if(i==0)
                 vtData->FieldByName("Field0_old")->AsFloat=vtData->FieldByName("Field0")->AsFloat ;
                 } else
                vtData->FieldByName("Field"+IntToStr(i)) ->Clear();



                }
             t++;
           }
           //09.02.2020 - GRB COMMENT MEGA FIX - вот из за этого и были все проблемы с копированием последней точки и точек с не всеми 1 по матрице в версии Сечина
           /*else   vtData->Next();*/
           //END COMMENT
            vtData->Next();

    }

   }else{    //  инверсия

  /* for(int k=0;k<RowCount;k++)
           {

           }  */
            int t=0;
          for(int k=0;k<RowCount;k++)
           {
             if (TestMid==((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->mid)
              {
               vtData->First();
               ((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->IsEdit=1;
               for(int i=0;i<ColCount+2;i++)
               {



                if (i==0)
                {
                dbManInput->Columns->Items[k+1]->Footer->Value=
                    FormatFloat("0.000",oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)]);
                    ((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->old
                    =oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)];
                    ((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->SumInv
                    =oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)];
                i++;
                 }
              if(i<ColCount+1)
              {

                 vtData->Edit();
               if(!oqReadData->ParamByName("par13")->ItemIsNull[(i+1)+((ColCount+1)*t)])
                 vtData->FieldByName("Field"+IntToStr(k))->AsFloat=
                 oqReadData->ParamByName("par13")->ItemAsFloat[(i+1)+((ColCount+1)*t)];
              else
               vtData->FieldByName("Field"+IntToStr(k)) ->Clear();

              }

              else{
               vtData->Edit();
               vtData->FieldByName("Field"+IntToStr(k))->AsFloat=StrToFloat(dbManInput->Columns->Items[k+1]->Footer->Value);

               }


               vtData->Next();
             }
             t++;
           }


         }

       // vtData->First();
        vtData->GotoBookmark(SavePlace);
     vtData->FreeBookmark(SavePlace);

  }    //  инверсия
   

}

//---------------------------------------------------------------------------
void __fastcall TfmManualInput::vRefresh(TObject* Sender)
{


   TBookmark SavePlace;
  try{

    SavePlace = vtData->GetBookmark();
     vtData->DisableControls();
     vtData->AfterPost=NULL;
     tp=p;
     TestMid=p.mid;
     ReadData();
     vtData->AfterPost=vtDataAfterPost;
     dbManInput->SumList->RecalcAll();
     vtData->First();
     vtData->EnableControls();
     vtData->GotoBookmark(SavePlace);
     vtData->FreeBookmark(SavePlace);
  }catch(Exception &e){
    vtData->EnableControls();
    Application->ShowException(&e);
  }
  
}
//--------------------------------------------------------------------------
TBookmark __fastcall TfmManualInput::TestEditMid(TVirtualTable *tvtData,TBookmark tSavePlace, long mid)
{

       TBookmark ttSavePlace;
       vtData->GotoBookmark(tSavePlace);
       tvtData->Prior();
       if(tvtData->RecNo==1&&mid==tvtData->FieldByName("mid")->AsFloat)return vtData->GetBookmark();
       if(mid!=tvtData->FieldByName("mid")->AsFloat){
           tvtData->Next();
           return vtData->GetBookmark();
          }
       else {
       ttSavePlace=vtData->GetBookmark();
       TestEditMid(tvtData,ttSavePlace,mid);
       }
}
//---------------------------------------------------------------------------
// Сохранить
void __fastcall TfmManualInput::vSave
(TObject* Sender)
{
  TBookmark SavePlace;
   TBookmark SavePlace2;
   TBookmark SavePlace3;

  TRect Rect;
  double Step;
 	unsigned short year,month,day;
  int TestMid=0;

 TestMes=true;
 p.myTime.DecodeDate( &year, &month, &day);
try{

  SavePlace = vtData->GetBookmark();
  vtData->DisableControls();
  
if ((!INV&&!SaveCheck())||(INV&&!SaveInvCheck()))
{

 vtData->EnableControls();
// vtData->GotoBookmark(SavePlace);
 vtData->FreeBookmark(SavePlace);
 //btSave->Enabled=false;
 vtData->AfterPost=vtDataAfterPost;
 return;
}


 switch(p.Step)
  {
  case 1: Step=24*(60/30);break;
  case 2: Step=24*(60/15);break;
  case 3: Step=24*(60/5);break;
  default: Step=24;break;
  }


  oqSave->Params->Clear();
  oqSave->SQL->Text="begin "+SchemeName+"MANUAL_IN_PG.Save_Data_p(:par1,:par2,:par3,:par4,:par5,:par7,:par6);end; ";
  vtData->First();
 if(!INV){  //не инверсия
  while(!vtData->Eof)
  {

   if(vtData->FieldByName("IsEdit")->AsInteger==1)
    {
         TestMid=vtData->FieldByName("mid")->AsFloat;
         // vtData->Edit();
         // vtData->FieldByName("IsEdit")->AsInteger=0;
        if(vtData->RecNo>1)
        {
           SavePlace3 = vtData->GetBookmark();
          vtData->GotoBookmark(TestEditMid(vtData,SavePlace3,vtData->FieldByName("mid")->AsFloat));
         }
   /*MessageBox(Handle,FormatFloat("0.000",vtData->FieldByName("mid")->AsFloat).c_str(),
                        Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1); */
     int tt=1;
     while (TestMid==vtData->FieldByName("mid")->AsFloat&&!vtData->Eof)
    {
  //TestMid=vtData->FieldByName("mid")->AsFloat;
     oqSave->ParamByName("par1")->AsFloat=vtData->FieldByName("mid")->AsFloat;
     oqSave->ParamByName("par2")->AsInteger= vtData->FieldByName("nmeasure")->AsInteger;
     oqSave->ParamByName("par3")->AsString=(TDateTime(year,month,day)+0).FormatString("dd.mm.yyyy hh:nn:ss");
     oqSave->ParamByName("par4")->AsInteger=vtData->FieldByName("KC")->AsInteger;
  //if (TestMid!=vtData->FieldByName("mid")->AsFloat)
    if (tt==1)
    {
       oqSave->ParamByName("par6")->AsInteger=1;
       tt=0;
    }
    else
    oqSave->ParamByName("par6")->AsInteger=0;


 // oqSave->ParamByName("par6")->AsInteger=(vtData->RecNo==1)?1:0;
     oqSave->ParamByName("par7")->AsInteger=Step;
     oqSave->ParamByName("par5")->Table=true;
     oqSave->ParamByName("par5")->Length=1;
     oqSave->ParamByName("par5")->ItemAsFloat[1]=0;
    for(int i=1;i<ColCount+1;i++)
          {

            if(TestMes&&!GetColorAndMess( Rect, vtData->FieldByName("Field"+IntToStr(i))->AsFloat,1,true))
              {

              dmMain->orases->Rollback();
              oqSave->Close();
             // btSave->Enabled=false;
              vtData->EnableControls();
              dbManInput->SelectedIndex=i+3;
             // vtData->GotoBookmark(SavePlace);
              vtData->FreeBookmark(SavePlace);
              vtData->AfterPost=vtDataAfterPost;
              return;
               }  //if(TestMes&&!GetC

            if(!vtData->FieldByName("Field"+IntToStr(i))->IsNull)
              oqSave->ParamByName("par5")->ItemAsFloat[i]=vtData->FieldByName("Field"+IntToStr(i))->AsFloat;
              else
              oqSave->ParamByName("par5")->ItemClear(i);

              oqSave->ParamByName("par5")->Length=i;
           }  //for(int i=1;i


       oqSave->Execute();

  // dmMain->orases->Commit();
        vtData->Edit();
        vtData->FieldByName("IsEdit")->AsInteger=0;
        vtData->Next();


    }  //while (TestMid==vtData->FieldByName("mid")->AsFloat&&!vtData->Eof)

     } else vtData->Next();

  }
  
  dmMain->orases->Commit();

 }else{   // инверсия


  //-----------------------------------------------------------------------


 int Start=1;
  //oqReadRow->Open();
  //oqReadRow->First();
   for(int k=0;k<RowCount;k++)
   {
     /*    if (TestMid!=((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->mid)
         oqSave->ParamByName("par6")->AsInteger=1;
        else
           oqSave->ParamByName("par6")->AsInteger=0;

         TestMid=((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->mid;    */

        if(((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->IsEdit==1){
           TestMid=((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->mid;
           for(int y=1;y<=k+1;y++ )
      //   for(int y=1;y<=RowCount;y++ )
           {
             if(((MAXMIN*)dbManInput->Columns->Items[y]->Tag)->mid==TestMid)
             {
              Start=y;
              break;
              }

           }
       int ttinv=1;
        while (TestMid==((MAXMIN*)dbManInput->Columns->Items[Start]->Tag)->mid&&Start<=RowCount)
        {
           if(ttinv==1)
             {
              oqSave->ParamByName("par6")->AsInteger=1;
              ttinv=0;
             }
             else
              oqSave->ParamByName("par6")->AsInteger=0;

      /*  MessageBox(Handle,FormatFloat("0.000",((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->mid).c_str(),
                        Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1);  */

    //  oqSave->Params->Clear();
      oqSave->ParamByName("par3")->AsString=(TDateTime(year,month,day)+0).FormatString("dd.mm.yyyy hh:nn:ss");
      oqSave->ParamByName("par5")->Table=true;
      oqSave->ParamByName("par5")->Length=1;
      oqSave->ParamByName("par5")->ItemAsFloat[1]=0;



   /*  oqSave->ParamByName("par1")->AsFloat=((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->mid;
     oqSave->ParamByName("par2")->AsInteger= ((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->meas;
     oqSave->ParamByName("par4")->AsInteger=((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->KC;   */

     oqSave->ParamByName("par1")->AsFloat=((MAXMIN*)dbManInput->Columns->Items[Start]->Tag)->mid;
     oqSave->ParamByName("par2")->AsInteger= ((MAXMIN*)dbManInput->Columns->Items[Start]->Tag)->meas;
     oqSave->ParamByName("par4")->AsInteger=((MAXMIN*)dbManInput->Columns->Items[Start]->Tag)->KC;
     oqSave->ParamByName("par7")->AsInteger=Step;



    int i=1;
    vtData->First();
    while(!vtData->Eof)
     {
      if(i<ColCount+1)
      {
      //  if(TestMes&&!GetColorAndMess( Rect, vtData->FieldByName("Field"+IntToStr(k))->AsFloat,k+1,true))
         if(TestMes&&!GetColorAndMess( Rect, vtData->FieldByName("Field"+IntToStr(Start-1))->AsFloat,Start,true))
       {

         dmMain->orases->Rollback();
         oqSave->Close();
        // btSave->Enabled=false;
         vtData->EnableControls();
        // dbManInput->SelectedIndex=k+1;
        dbManInput->SelectedIndex=Start;
        // vtData->GotoBookmark(SavePlace);
         vtData->FreeBookmark(SavePlace);
         vtData->AfterPost=vtDataAfterPost;
        return;
       }
      
      oqSave->ParamByName("par5")->Length=i;
      /*if(!vtData->FieldByName("Field"+IntToStr(k))->IsNull){
      double jjj=vtData->FieldByName("Field"+IntToStr(k))->AsFloat;
      oqSave->ParamByName("par5")->ItemAsFloat[i]=vtData->FieldByName("Field"+IntToStr(k))->AsFloat; */
      if(!vtData->FieldByName("Field"+IntToStr(Start-1))->IsNull){
      double jjj=vtData->FieldByName("Field"+IntToStr(Start-1))->AsFloat;
      oqSave->ParamByName("par5")->ItemAsFloat[i]=vtData->FieldByName("Field"+IntToStr(Start-1))->AsFloat;
      }
      else
      oqSave->ParamByName("par5")->ItemClear(i);
      i++;
      }
      vtData->Next();
      } // while(!vtData->Eof)

       oqSave->Execute();
    //  ((MAXMIN*)dbManInput->Columns->Items[k+1]->Tag)->IsEdit=0;
       ((MAXMIN*)dbManInput->Columns->Items[Start]->Tag)->IsEdit=0;

       Start++;
       if(Start>RowCount) { k=Start;break; }
        k=Start-2;

    }    // while (TestMid==((MAXMIN*)dbManInput
   // dmMain->orases->Commit();
  //  oqReadRow->Next();
     }
   }
    
  dmMain->orases->Commit();
//vtData->EnableControls();
  }



  //-----------------------------------------------------
  vtData->EnableControls();
  vtData->GotoBookmark(SavePlace);
  vtData->FreeBookmark(SavePlace);
  vRefresh(this);
  btSave->Enabled=false;
  dbManInput->SetFocus();
  }catch(Exception&e){
     dmMain->orases->Rollback();
     Application->ShowException(&e);
   }
}

//---------------------------------------------------------------------------

void __fastcall TfmManualInput::SetAccess(TAccess value)
{
   if(FAccess != value) {
      TMainForm::SetAccess(value);
      bool wr = value==accWrite;
      iaCheck->Enabled = wr;
   }
}

//--------------------------------------------------------------------------------

void __fastcall TfmManualInput::btCheckClick(TObject *Sender)
{
TBookmark SavePlace;
 try{
    if(!INV)
    PCheck();
    else  {
     SavePlace = vtData->GetBookmark();
    ((MAXMIN*)dbManInput->Columns->Items[dbManInput->Col-1]->Tag)->IsEdit=1;
     InvCheck();
     vtData->GotoBookmark(SavePlace);
     vtData->FreeBookmark(SavePlace);
     }
    }catch(Exception &e){

      Application->ShowException(&e);
    }

 }
//-----------------------------------------------------------------------------------------
 void __fastcall TfmManualInput::PCheck()  //не инверсия
{
vtData->AfterPost=NULL;
double Sum=0;
int Index=0;
     vtData->Edit();
     vtData->FieldByName("IsEdit")->AsInteger=1;
 // vtData->First();
 // while(!vtData->Eof)
  //  {

     Sum= vtData->FieldByName("Field1")->AsFloat;

     for(int i=2;i<ColCount+1;i++)
      {

      Sum+= vtData->FieldByName("Field"+IntToStr(i))->AsFloat;
   /*   if(vtData->FieldByName("Field"+IntToStr(i))->OldValue!=vtData->FieldByName("Field"+IntToStr(i))->AsFloat)
           {
            vtData->Edit();
            vtData->FieldByName("IsEdit")->AsInteger=1;
            vtData->Post();
           }  */
      }
    if(cbConst->Checked)   // суточный расход - константа

     {

    if(

      vtData->FieldByName("Field0")->AsFloat!=vtData->FieldByName("Field0_old")->AsFloat)
       {   //Ввод суточного расхода,когда суточный расход константа

         //-------------------------------------------------------------------
         //Возврат массива данных разбитых на сутки
         Check(vtData->FieldByName("mid")->AsFloat,vtData->FieldByName("nmeasure")->AsInteger,
         vtData->FieldByName("mtrsn")->AsString,vtData->FieldByName("KC")->AsFloat,vtData->FieldByName("Field0")->AsFloat,1);


         //---------------------------------------------------------------------
      vtData->Edit();   
      vtData->FieldByName("Field0_old")->AsFloat=vtData->FieldByName("Field0")->AsFloat;
      }

    }   //if(cbConst->Checked) // суточный расход - константа
   else  //Ввод данных для часов в сутках  когда суточный расход - - можно изменять  start    //if(!cbConst->Checked)
    {

     vtData->Edit();
     if(Sum)
     vtData->FieldByName("Field0")->AsFloat=Sum;
     else
     vtData->FieldByName("Field0")->Clear();

     }
        Index++;
  //   vtData->Next();

 // } //if(!cbConst->Checked)


   if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

       btSave->Enabled=true;

     vtData->AfterPost=vtDataAfterPost;

 }

//---------------------------------------------------------------------------
void __fastcall TfmManualInput::InvCheck()
{
 vtData->AfterPost=NULL;
double Sum;
 TRect Rect;
 AnsiString s;
 int i=dbManInput->Col-2;
//for(int i=0;i<RowCount;i++)
 // {
      // oqReadRow->Open();
      // oqReadRow->First();

       vtData->First();
         Sum=0;
          while(!vtData->Eof)
           {

            Sum+= vtData->FieldByName("Field"+IntToStr(i))->AsFloat;
             vtData->Next();
            }
           vtData->Last();
          Sum=Sum-vtData->FieldByName("Field"+IntToStr(i))->AsFloat;

   if(cbConst->Checked)   // суточный расход - константа
    {
        vtData->Last();

         if(
          vtData->FieldByName("Field"+IntToStr(i))->AsFloat!=
         ((MAXMIN*)dbManInput->Columns->Items[i+1]->Tag)->old)

        {   //Ввод суточного расхода,когда суточный расход константа

           //-------------------------------------------------------------------
           //Возврат массива данных разбитых на сутки
        /*    Check(oqReadRow->FieldByName("mid")->AsFloat,oqReadRow->FieldByName("nmeasure")->AsInteger,
           oqReadRow->FieldByName("mtrsn")->AsString,oqReadRow->FieldByName("KC")->AsFloat,
            vtData->FieldByName("Field"+IntToStr(i))->AsFloat,i);  */
             Check(((MAXMIN*)dbManInput->Columns->Items[i+1]->Tag)->mid,
             ((MAXMIN*)dbManInput->Columns->Items[i+1]->Tag)->meas,
           ((MAXMIN*)dbManInput->Columns->Items[i+1]->Tag)->mtrsn,((MAXMIN*)dbManInput->Columns->Items[i+1]->Tag)->KC,
            vtData->FieldByName("Field"+IntToStr(i))->AsFloat,i);
           //---------------------------------------------------------------------

           ((MAXMIN*)dbManInput->Columns->Items[i+1]->Tag)->old
            =vtData->FieldByName("Field"+IntToStr(i))->AsFloat;

       }else{
        ((MAXMIN*)dbManInput->Columns->Items[i+1]->Tag)->SumInv=Sum;
       }


   

  }  //if(cbConst->Checked)
   else  //Ввод данных для часов в сутках  когда суточный расход - - можно изменять  start    //if(!cbConst->Checked)
    {

       vtData->Last();

       vtData->Edit();
       if(Sum){
       vtData->FieldByName("Field"+IntToStr(i))->AsFloat=Sum;
       dbManInput->Columns->Items[i+1]->Footer->Value=FormatFloat("0.000",Sum);
       ((MAXMIN*)dbManInput->Columns->Items[i+1]->Tag)->SumInv=Sum;
       }
       else
       {
       vtData->FieldByName("Field"+IntToStr(i))->Clear();
        }

  //  oqReadRow->Next();
   }
// }
   if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

       btSave->Enabled=true;

     vtData->AfterPost=vtDataAfterPost;

}
//-------------------------------------------------------------------------------
// Проверить
void __fastcall TfmManualInput::vCheck(TObject* Sender)
{
  btCheckClick(this);
}
//---------------------------------------------------------------------------

// Возврат данных при разбивке на сутки
void __fastcall TfmManualInput::Check(double mid ,int nmeasure,AnsiString mtrsn,double kc, double Field0,int Col)

{

  double Step;
      switch(p.Step)
  {
  case 1: Step=24*(60/30);break;
  case 2: Step=24*(60/15);break;
  case 3: Step=24*(60/5);break;
  default: Step=24;break;
  }
     oqSave->Params->Clear();
     oqSave->SQL->Text= "begin "+SchemeName+"MANUAL_IN_PG.test_data_p(:par1,:par2,:par3,:par4,:par5,:par6); \
                         end; ";
     oqSave->ParamByName("par1")->AsFloat= mid;
   //  oqSave->ParamByName("par2")->AsDateTime= (p.myTime+1).FormatString("dd.mm.yyyy hh:nn:ss");
     oqSave->ParamByName("par2")->AsString= (p.myTime).FormatString("dd.mm.yyyy hh:nn:ss");
     oqSave->ParamByName("par3")->AsInteger= nmeasure;
     oqSave->ParamByName("par4")->AsFloat= Field0;
     oqSave->ParamByName("par5")->AsInteger= Step;
     oqSave->ParamByName("par6")->ParamType=ptOutput;
     oqSave->ParamByName("par6")->DataType=ftFloat;
     oqSave->ParamByName("par6")->Table=true;
     oqSave->ParamByName("par6")->Length=ColCount+1;
     oqSave->Execute();



        if(!INV)
         {
         for(int i=1;i<ColCount+1;i++)
         {
          vtData->Edit();
          vtData->FieldByName("Field"+IntToStr(i))->AsFloat=oqSave->ParamByName("par6")->ItemAsFloat[i];
           }
        }else{

            vtData->First();

             for(int i=1;i<ColCount+1;i++)
           {
              vtData->Edit();
                vtData->FieldByName("Field"+IntToStr(Col))->AsFloat=
                   oqSave->ParamByName("par6")->ItemAsFloat[i];
             vtData->Next();
           }
             vtData->Last();
           dbManInput->Columns->Items[Col+1]->Footer->Value
             =FormatFloat("0.000",vtData->FieldByName("Field"+IntToStr(Col))->AsFloat);
             ((MAXMIN*)dbManInput->Columns->Items[Col+1]->Tag)->SumInv=
             vtData->FieldByName("Field"+IntToStr(Col))->AsFloat;

         }

  if(vtData->State==dsInsert||vtData->State==dsEdit)
         vtData->Post();

       btSave->Enabled=true;

}
//-------------------------------------------------------------------------------------------------
  bool __fastcall TfmManualInput::SaveCheck()
{
vtData->AfterPost=NULL;
double Sum=0;
int Index=0;


AnsiString s;
TRect Rect;

 if(!cbConst->Checked)return true;  // суточный расход - константа

        vtData->First();
  while(!vtData->Eof)
     {
       Sum= vtData->FieldByName("Field1")->AsFloat;
         for(int i=2;i<ColCount+1;i++)
      {
          Sum+= vtData->FieldByName("Field"+IntToStr(i))->AsFloat;

      }

              //Ввод данных для часов в сутках  когда суточный расход - константа  start
         if (StrToFloat(FormatFloat("0.000",Sum))!=StrToFloat(FormatFloat("0.000",vtData->FieldByName("Field0")->AsFloat)))
        {
         /*  s=FormatFloat("0.000",vtData->FieldByName("Field0")->AsFloat);
           Rect=dbManInput->CellRect(4,Index+1);
           dbManInput->Canvas->Brush->Color=clRed;
           dbManInput->Canvas->FillRect(Rect);
           dbManInput->Canvas->Font->Color=clBlack;
           dbManInput->Canvas->TextRect(Rect,Rect.Left+2,Rect.Top+2,s);  */
         if( Application->MessageBox
          ((Reconst_smes136_7+vtData->FieldByName("name_point")->AsString
          +Reconst_smes136_8+vtData->FieldByName("type")->AsString+AnsiString("\n\r")
          +Reconst_smes136_9+FormatFloat("0.000",vtData->FieldByName("Field0")->AsFloat)
          +Reconst_smes136_10+FormatFloat("0.000",Sum)+
          AnsiString(". \n\r")+Reconst_smes136_12
          ).c_str()
          ,Application->Title.c_str(),MB_YESNOCANCEL | MB_ICONQUESTION| MB_DEFBUTTON1)==IDYES)
          return true;
          else {
          dbManInput->SelectedIndex=3;
          return false;
          }
        }
        vtData->Next();
      }
     return true;
  }
 //------------------------------------------------------------------------------
 bool __fastcall TfmManualInput::SaveInvCheck()
{
 vtData->AfterPost=NULL;
double Sum;

AnsiString s;
TRect Rect;

if(!cbConst->Checked)return true;  // суточный расход - константа

for(int i=0;i<RowCount;i++)
  {
    //   oqReadRow->Open();
    //   oqReadRow->First();
        vtData->First();
         Sum=0;
          while(!vtData->Eof)
           {
            Sum+= vtData->FieldByName("Field"+IntToStr(i))->AsFloat;
             vtData->Next();
            }
           vtData->Last();
          Sum=Sum-vtData->FieldByName("Field"+IntToStr(i))->AsFloat;

        vtData->Last();
         if (StrToFloat(dbManInput->Columns->Items[i+1]->Footer->Value)!=StrToFloat(FormatFloat("0.000",Sum)))
            {
         /*   s=dbManInput->Columns->Items[i+1]->Footer->Value;
           Rect=dbManInput->CellRect(i+1,ColCount-1);
           dbManInput->Canvas->Brush->Color=clRed;
           dbManInput->Canvas->FillRect(Rect);
           dbManInput->Canvas->Font->Color=clBlack;
           dbManInput->Canvas->TextRect(Rect,Rect.Left+2,Rect.Top+2,s); */
           if( Application->MessageBox((Reconst_smes136_7+dbManInput->Columns->Items[i+1]->Title->Caption+
            Reconst_smes136_9+AnsiString("\n\r")+s+
            Reconst_smes136_10+FormatFloat("0.000",Sum)+
             AnsiString(". \n\r") +Reconst_smes136_12
            ).c_str()
           ,Application->Title.c_str(),MB_YESNOCANCEL | MB_ICONQUESTION| MB_DEFBUTTON1)==IDYES)
          return true;
          else {
          dbManInput->SelectedIndex=i+1;
          return false;
          }
        }
     //   oqReadRow->Next();
      }
     return true;
    }


 //-------------------------------------------------------------------------------
void __fastcall TfmManualInput::dbManInputDrawColumnCell(TObject *Sender,
      const TRect &Rect, int DataCol, TColumnEh *Column,
      TGridDrawState State)
{

 double Sum=0;
 AnsiString s;

 if(!INV&&cbConst->Checked&&DataCol==3){
       for(int i=1;i<ColCount+1;i++)
        {
          Sum+= vtData->FieldByName("Field"+IntToStr(i))->AsFloat;

        }

              //Ввод данных для часов в сутках  когда суточный расход - константа  start
         if (StrToFloat(FormatFloat("0.000",Sum))!=StrToFloat(FormatFloat("0.000",vtData->FieldByName("Field0")->AsFloat)))
        {
           s=FloatToStr(vtData->FieldByName("Field0")->AsFloat);
           dbManInput->Canvas->Brush->Color=clRed;
           dbManInput->Canvas->FillRect(Rect);
           dbManInput->Canvas->Font->Color=clBlack;
           dbManInput->Canvas->TextRect(Rect,Rect.Right-(dbManInput->Canvas->TextWidth(s)+3),Rect.Top+2,s);
         }
 }
 //--------------------------------------------------------------------------
 if(INV&&cbConst->Checked&&DataCol!=0&&vtData->RecNo==ColCount+1)
 {

         if (StrToFloat(dbManInput->Columns->Items[DataCol]->Footer->Value)!=StrToFloat(FormatFloat("0.000",((MAXMIN*)dbManInput->Columns->Items[DataCol]->Tag)->SumInv)))
            {
           s=dbManInput->Columns->Items[DataCol]->Footer->Value;
           dbManInput->Canvas->Brush->Color=clRed;
           dbManInput->Canvas->FillRect(Rect);
           dbManInput->Canvas->Font->Color=clBlack;
           dbManInput->Canvas->TextRect(Rect,Rect.Right-(dbManInput->Canvas->TextWidth(s)+3),Rect.Top+2,s);
         }

 }
 //--------------------------------------------------------------------
if((!INV&&DataCol<4)||(INV&&DataCol<1)||(INV&&vtData->RecNo==ColCount+1)) return;

 float TestSender=Column->Field->AsFloat;
 GetColorAndMess(Rect,TestSender,DataCol,false);

}
//---------------------------------------------------------------------------
bool __fastcall TfmManualInput::GetColorAndMess( const TRect &Rect, float TestSender,int Col,bool flag)
 {
AnsiString s;
 double MinTest;
 double MaxTest;
 bool ValueTest=true;

 double TestPredMax;
 double TestPredMin;
 double TestAvarMax;
 double TestAvarMin;
 double TestFizMax;
 double TestFizMin;

 double AColCount;

 switch(p.Step)
  {
  case 1: AColCount=2.0;break;
  case 2: AColCount=4.0;break;
  case 3: AColCount=15.0;break;
  default: AColCount=1.0;break;
  }


  if(!INV) {
  TestPredMax=vtData->FieldByName("predmax")->AsFloat/AColCount;
  TestPredMin=vtData->FieldByName("predmin")->AsFloat/AColCount;
  TestAvarMax=vtData->FieldByName("avarmax")->AsFloat/AColCount;
  TestAvarMin=vtData->FieldByName("avarmin")->AsFloat/AColCount;
  TestFizMax=vtData->FieldByName("fizmax")->AsFloat/AColCount;
  TestFizMin=vtData->FieldByName("fizmin")->AsFloat/AColCount;
  }else{
   TestPredMax=((MAXMIN*)dbManInput->Columns->Items[Col]->Tag)->PredMax/AColCount;
   TestPredMin=((MAXMIN*)dbManInput->Columns->Items[Col]->Tag)->PredMin/AColCount;
   TestAvarMax=((MAXMIN*)dbManInput->Columns->Items[Col]->Tag)->AvarMax/AColCount;
   TestAvarMin=((MAXMIN*)dbManInput->Columns->Items[Col]->Tag)->AvarMin/AColCount;
   TestFizMax=((MAXMIN*)dbManInput->Columns->Items[Col]->Tag)->FizMax/AColCount;
   TestFizMin=((MAXMIN*)dbManInput->Columns->Items[Col]->Tag)->FizMin/AColCount;

  }



   if(TestSender&&(TestSender<TestFizMin|| TestSender>TestFizMax)){
               ValueTest=false;
               MinTest=TestFizMin;
               MaxTest=TestFizMax;

                if(flag)
               {

                if(Application->MessageBox(AnsiString("Введенные показания " + FormatFloat("0.000",TestSender)
               + " выходят за физические границы: "
               ">="+FormatFloat("0.000",MinTest) + " или "+
               "<=" +FormatFloat("0.000",MaxTest)+"\n\r Продолжить сохранение?" ).c_str()
               ,Application->Title.c_str(),MB_YESNOCANCEL| MB_ICONQUESTION| MB_DEFBUTTON1)==IDYES){
               TestMes=false;
               return true;
               }else{
               TestMes=false;
               return false;
               }
               } else{

               s=FloatToStr(TestSender);
               dbManInput->Canvas->Brush->Color=clRed;
               dbManInput->Canvas->FillRect(Rect);
               dbManInput->Canvas->Font->Color=clBlack;
               dbManInput->Canvas->TextRect(Rect,Rect.Right-(dbManInput->Canvas->TextWidth(s)+3),Rect.Top+2,s);
               }

    }

   if(ValueTest&&TestSender&&(TestSender<TestAvarMin|| TestSender>TestAvarMax)){
               ValueTest=false;
               MinTest=TestAvarMin;
               MaxTest=TestAvarMax;

               if(flag)
               {
                if(Application->MessageBox(AnsiString("Введенные показания " + FormatFloat("0.000",TestSender)
               + " выходят за аварийные границы: "
               ">="+FormatFloat("0.000",MinTest) + " или "+
               "<=" +FormatFloat("0.000",MaxTest)+"\n\r Продолжить сохранение?" ).c_str()
               ,Application->Title.c_str(),MB_YESNOCANCEL| MB_ICONQUESTION| MB_DEFBUTTON1)==IDYES){
                TestMes=false;
               return true;
               }else{
               TestMes=false;
               return false;
               }
               }else{
               s=FloatToStr(TestSender);
               dbManInput->Canvas->Brush->Color=clYellow;
               dbManInput->Canvas->FillRect(Rect);
               dbManInput->Canvas->Font->Color=clBlack;
               dbManInput->Canvas->TextRect(Rect,Rect.Right-(dbManInput->Canvas->TextWidth(s)+3),Rect.Top+2,s);
               }
      }

    if(ValueTest&&TestSender&&(TestSender<TestPredMin|| TestSender>TestPredMax)){
               ValueTest=false;
               MinTest=TestPredMin;
               MaxTest=TestPredMax;

                if(flag)
               {
                if(Application->MessageBox(AnsiString("Введенные показания " + FormatFloat("0.000",TestSender)
               + " выходят за предупредительные границы: "
               ">="+FormatFloat("0.000",MinTest) + " или "+
               "<=" +FormatFloat("0.000",MaxTest)+"\n\r Продолжить сохранение?" ).c_str()
               ,Application->Title.c_str(),MB_YESNOCANCEL| MB_ICONQUESTION| MB_DEFBUTTON1)==IDYES){
                TestMes=false;
               return true;
               }else{
               TestMes=false;
               return false;
               }
               }else{
               s=FloatToStr(TestSender);
               dbManInput->Canvas->Brush->Color=clYellow;
               dbManInput->Canvas->FillRect(Rect);
               dbManInput->Canvas->Font->Color=clBlack;
               dbManInput->Canvas->TextRect(Rect,Rect.Right-(dbManInput->Canvas->TextWidth(s)+3),Rect.Top+2,s);
               }

     }
   return true;
 }

//-------------------------------------------------------------------------------



void __fastcall TfmManualInput::btSaveClick(TObject *Sender)
{
 vSave(this);
}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::tbRefreshClick(TObject *Sender)
{
  if(btSave->Enabled==true)
      {
      switch (MessageBox(Handle, Reconst_smes43_5.c_str(),
                        Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1))
      {
       case IDYES:
         if (Access == accDenied && Access == accRead)
          throw Exception(Reconst_smes43_3);
         vSave(Sender);
         break;
       }
      btSave->Enabled=false;
      }
 vRefresh(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::vtDataAfterPost(TDataSet *DataSet)
{

 //TBookmark SavePlace;
  try{
   // SavePlace = vtData->GetBookmark();
     btCheckClick(this);
   //  vtData->GotoBookmark(SavePlace);
  //   vtData->FreeBookmark(SavePlace);
  }catch(Exception &e){

    Application->ShowException(&e);
  }
}
//---------------------------------------------------------------------------


void __fastcall TfmManualInput::iaCloseExecute(TObject *Sender)
{
 /* if(btSave->Enabled==true)
      {
      switch (MessageBox(Handle, Reconst_smes43_5.c_str(),
                        Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1))
     { case IDCANCEL:
        return;
      case IDYES:
        vSave(Sender);
        break;
    }

      }   */
    vtData->AfterPost=NULL;
    ComboBox1->ItemIndex=0;
    ComboBox1Change(this);
    Close();
}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::cbInvClick(TObject *Sender)
{

   if(btSave->Enabled==true)
      {
      if(MessageBox(Handle, Reconst_smes43_5.c_str(),
                        Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1)==IDYES){
      if (Access == accDenied && Access == accRead)
          throw Exception(Reconst_smes43_3);
       vSave(Sender);
       }
      else btSave->Enabled=false;
      }


 INV=cbInv->Checked;

  if(INV&&RowCount>100)
  {
   if(MessageBox(Application->Handle,
                AnsiString(Reconst_smes136_11).c_str(), Application->Title.c_str(),
                MB_OK|MB_ICONINFORMATION)==IDOK);
   cbInv->OnClick=NULL;
   cbInv->Checked=false;
   cbInv->OnClick=cbInvClick;
   INV=false;
   return;
  }
    vtData->DisableControls();
    vtData->AfterPost=NULL;
    dbManInput->Columns->BeginUpdate();
    dbManInput->FrozenCols=0;
    dbManInput->FooterRowCount=0;
    dbManInput->Columns->Clear();
    vtData->Close();
    vtData->Clear();
    vtData->DeleteFields();
    GetColumnName();
    tp=p;
    TestMid=p.mid;
    ReadData();
    vtData->AfterPost=vtDataAfterPost;
    dbManInput->SumList->RecalcAll();
    vtData->EnableControls();
    dbManInput->SetFocus();
    
}
//---------------------------------------------------------------------------
void __fastcall TfmManualInput::vCopyClick(TObject *Sender)
{
 double Val;
 if(ActiveControl==dbManInput)
 {
 if(dbManInput->Selection->SelectionType==gstNon)
   {
   Clipboard()->Clear();
    Val=(!INV)? vtData->FieldByName("Field"+IntToStr(dbManInput->Col-4))->AsFloat:
    vtData->FieldByName("Field"+IntToStr(dbManInput->Col-2))->AsFloat;


    Clipboard()->AsText=FormatFloat("0.000",Val);

   }
 }

}
//------------------------------------------------------------------------------
void __fastcall TfmManualInput::vPasteClick(TObject *Sender)
{
try{
 if(Clipboard()->HasFormat(CF_TEXT)){
   AnsiString s =Clipboard()->AsText.Trim();
   double d=StrToFloat(s);
   vtData->DisableControls();
   vtData->Edit();
   if(!INV)
     vtData->FieldByName("Field"+IntToStr(dbManInput->Col-4))->AsFloat=d;
   else
     vtData->FieldByName("Field"+IntToStr(dbManInput->Col-2))->AsFloat=d;
   vtData->EnableControls();
   dbManInput->Invalidate();
   dbManInput->Repaint();
 }
 }catch(Exception &e){};
}
//-----------------------------------------------------------------------------------------------------

void __fastcall TfmManualInput::dbManInputMouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
/* double Val;
 TBookmark SavePlace;
 int h;

if(INV)
{
 if(dbManInput->Selection->SelectionType==gstRectangle)
  {
     vtData->GotoBookmark((void *)dbManInput->Selection->Rect->TopRow.c_str());
     if(!vtData->FieldByName("Field"+IntToStr(dbManInput->Selection->Rect->LeftCol-1))->IsNull)
     Val=vtData->FieldByName("Field"+IntToStr(dbManInput->Selection->Rect->LeftCol-1))->AsFloat;

    vtData->Next();
    SavePlace = vtData->GetBookmark();
    int i=1;
    while(!vtData->Eof)
     {

   //  if(vtData->CompareBookmarks((void *)dbManInput->Selection->Rect->BottomRow.c_str(),(void *)SavePlace)==-1 )
   //if(vtData->CompareBookmarks((void *)dbManInput->Selection->Rect->BottomRow.c_str(),(void *)vtData->Bookmark.c_str())==-1 )
    if(dbManInput->Selection->DataCellSelected(dbManInput->Selection->Rect->LeftCol-1,IntToStr(StrToInt(dbManInput->Selection->Rect->TopRow)+i)))
     {
   //  vtData->FreeBookmark(SavePlace);
    // return;
   //  }
    // vtData->FreeBookmark(SavePlace);
     vtData->Edit();
     vtData->FieldByName("Field"+IntToStr(dbManInput->Selection->Rect->LeftCol-1))->AsFloat=Val;
     vtData->Next();
     i++;
   //  SavePlace = vtData->GetBookmark();
        }
     }
   }
 }  */
}
//---------------------------------------------------------------------------


void __fastcall TfmManualInput::btInputClick(TObject *Sender)
{

bool b;
if(!INV)
 b=TFormInputParam::ShowInputParam(this,vtData->FieldByName("mid")->AsFloat,p.myTime+1);
else
  {
   oqReadRow->Open();
   oqReadRow->RecNo=dbManInput->SelectedIndex;
   b=TFormInputParam::ShowInputParam(this,oqReadRow->FieldByName("mid")->AsFloat,p.myTime+1);
   oqReadRow->Close();
   }
  if(b)
   vRefresh(this);

}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::dbManInputColEnter(TObject *Sender)
{
   if(!INV&&dbManInput->SelectedIndex<3)dbManInput->SelectedIndex=3;
   if(INV&&dbManInput->SelectedIndex<1)dbManInput->SelectedIndex=1;
 
}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::FormCloseQuery(TObject *Sender,
      bool &CanClose)
{
      if(btSave->Enabled==true)
      {
      switch (MessageBox(Handle, Reconst_smes43_5.c_str(),
                        Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1))
     { case IDCANCEL:
        return;
      case IDYES:
      if (Access == accDenied && Access == accRead)
          throw Exception(Reconst_smes43_3);
        vSave(Sender);
        break;
    }

   }
   SetKoeff(0);
}
//---------------------------------------------------------------------------



void __fastcall TfmManualInput::FormShow(TObject *Sender)
{
 if(INV) cbInv->Checked=true;  
}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::ComboBox1Change(TObject *Sender)
{
  setTimeShift->Params->Clear();
  setTimeShift->SQL->Text="begin "+SchemeName+"MANUAL_IN_PG.set_shift("+IntToStr(ComboBox1->ItemIndex)+");end;";
  setTimeShift->Execute();
 }
//---------------------------------------------------------------------------


void __fastcall TfmManualInput::dbManInputKeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
   if(Key==VK_RETURN)
           if(vtData->State==dsInsert||vtData->State==dsEdit)
              vtData->Post();
      //TBookmark SavePlace;
 // else{
/*  if(INV )
 //(Key == '.' || ((int)Key <=48 && (int)Key=>57) ||(int)Key=VK_BACK ||(int)Key=VK_DELETE) )
     {
     vtData->AfterPost=NULL;
     vtData->DisableControls();
     btCheckClick(this);
     vtData->AfterPost=vtDataAfterPost;
    // dbManInput->SumList->RecalcAll();
     vtData->EnableControls();
     dbManInput->SetFocus();

 }
//  }   */


}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::RadioGroup1Click(TObject *Sender)
{

    if(btSave->Enabled==true)
      {
      switch (MessageBox(Handle, Reconst_smes43_5.c_str(),
                        Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1))
      {
       case IDYES:
       if (Access == accDenied && Access == accRead)
          throw Exception(Reconst_smes43_3);
         vSave(Sender);
         break;
       }
      btSave->Enabled=false;

      }

   SetKoeff(RadioGroup1->ItemIndex);
   vRefresh(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TfmManualInput::SetKoeff(int f)
  {
   setTimeShift->Params->Clear();
   setTimeShift->SQL->Text="begin "+SchemeName+"MANUAL_IN_PG.set_koeff("+IntToStr(f)+");end;";
   setTimeShift->Execute();
   }

//-----------------------------------------------------------------------------------------------
void __fastcall TfmManualInput::tbCopyDataClick(TObject *Sender)
{

   TFormManualInTree *f=NULL;

    try{

    tp=p;
    p.myTime=p.myTime-1;
    if (!INV) {
    p.mid=vtData->FieldByName("mid")->AsFloat;
    TestMid=vtData->FieldByName("mid")->AsFloat;
   } else  {
   oqReadRow->Open();
   oqReadRow->RecNo=dbManInput->SelectedIndex;
   p.mid=oqReadRow->FieldByName("mid")->AsFloat;
   TestMid=oqReadRow->FieldByName("mid")->AsFloat;
   }
    f= new TFormManualInTree(this,&p, 1);
    f->paTime->Visible=false;
    f->paStep->Visible=false;
      vtData->DisableControls();
       vtData->AfterPost=NULL;
      
    if((f->ShowModal() == mrOk)&&f->tvMain->Selected){

      //  ReadData();
      CopyData();
    }

    if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

       btSave->Enabled=true;
    vtData->AfterPost=vtDataAfterPost;
    dbManInput->SumList->RecalcAll();
    vtData->EnableControls();
    p=tp;
    TestMid=tp.mid;
       delete f;

   }catch (Exception &exception){
    if(f)
      delete f;
      p=tp;

  	Application->ShowException(&exception);
   }
}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::tbCopyDataYestClick(TObject *Sender)
{

    try{
    tp=p;

    p.myTime=p.myTime-1;
    if (!INV){
    p.mid=vtData->FieldByName("mid")->AsFloat;
    TestMid=vtData->FieldByName("mid")->AsFloat;

   } else  {
   oqReadRow->Open();
   oqReadRow->RecNo=dbManInput->SelectedIndex;
   p.mid=oqReadRow->FieldByName("mid")->AsFloat;
   TestMid=oqReadRow->FieldByName("mid")->AsFloat;
   }
     vtData->DisableControls();
    vtData->AfterPost=NULL;
    //ReadData();
    CopyData();
    if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

    btSave->Enabled=true;
    vtData->AfterPost=vtDataAfterPost;
    dbManInput->SumList->RecalcAll();
    vtData->EnableControls();
    p=tp;
    TestMid=tp.mid;
   // p.myTime=p.myTime+1;
     }catch (Exception &exception){
      p=tp;
     	Application->ShowException(&exception);
   }
}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::tbDownClick(TObject *Sender)
{

 int FRowCount;
    try{
    if(btSave->Enabled==true)
      {
      switch (MessageBox(Handle, Reconst_smes43_5.c_str(),
                        Application->Title.c_str(), MB_YESNOCANCEL | MB_ICONQUESTION | MB_DEFBUTTON1))
      {
       case IDYES:
       if (Access == accDenied && Access == accRead)
          throw Exception(Reconst_smes43_3);
         vSave(Sender);
         break;
       }
      btSave->Enabled=false;

      }


    if (Sender==tbDown)
       p.myTime=p.myTime-1;
    else
       p.myTime=p.myTime+1;
       
       vtData->DisableControls();
       vtData->AfterPost=NULL;
       dbManInput->Columns->BeginUpdate();
       dbManInput->FrozenCols=0;
       dbManInput->FooterRowCount=0;
       dbManInput->Columns->Clear();
       vtData->Close();
       vtData->Clear();
       vtData->DeleteFields();

      if(p.Step==2||p.Step==3)
     {
      INV=true;
     cbConst->Enabled=false;
     }else{
      INV=cbInv->Checked;
      cbConst->Enabled=true;
     }

     GetColumnName();
    // ReadMaxValue();
     tp=p;
     TestMid=p.mid;
     ReadData();
      vtData->AfterPost=vtDataAfterPost;
      dbManInput->SumList->RecalcAll();
      vtData->EnableControls();


  }catch (Exception &exception){

  	Application->ShowException(&exception);

  }

}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::tbPrintClick(TObject *Sender)
{

  PrintMessageGrid->DBGridEh->Columns->Items[0]->Visible=false;
  PrintMessageGrid->PageHeader->CenterText->Clear();
 /* PrintMessageGrid->PageHeader->CenterText->Add(Reconst_smes71_10+S+Reconst_smes71_11+
   dtFrom->Date.FormatString("dd.mm.yyyy ")+edFrom->Text+Reconst_smes71_12+
   dtTill->Date.FormatString("dd.mm.yyyy ")+edTill->Text);  */
  PrintMessageGrid->PageHeader->CenterText->Add(Caption);
  PrintMessageGrid->PageHeader->CenterText->Add(" ");
  PrintMessageGrid->PageHeader->RightText->Text=TDateTime::CurrentDate().FormatString("dd.mm.yyyy hh:nn:ss");
  PrintMessageGrid->Preview();
  PrintMessageGrid->DBGridEh->Columns->Items[0]->Visible=true;
}
//---------------------------------------------------------------------------
void __fastcall TfmManualInput::dbManInputColExit(TObject *Sender)
{
if(INV&&vtData->Modified&& vtData->State == dsEdit)
    vtData->Post();
}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::ToolButton4Click(TObject *Sender)
{
     //Считаем сколько строк
    oqReadRow->Open();
    oqReadRow->First();
    int dim = (RowCount>0?(RowCount/*-1*/):0);
    int *array = new int[dim];
    int i = 0;
    while (!oqReadRow->Eof){
        array[i] = oqReadRow->FieldByName("mid")->AsFloat;
        i++;
        oqReadRow->Next();
    }
    oqReadRow->Close();
    //Теперь копипаст кода сохранения c изменениями в части инверсии
    for (int j = 0; j < dim; j++ ){
    try{
    tp=p;
    p.myTime=p.myTime-1;
    p.mid=array[j];
    TestMid=array[j];
    vtData->DisableControls();
    vtData->AfterPost=NULL;
    //ReadData();
    CopyData();
    if(vtData->State==dsInsert||vtData->State==dsEdit)
          vtData->Post();

    btSave->Enabled=true;
    vtData->AfterPost=vtDataAfterPost;
    dbManInput->SumList->RecalcAll();
    vtData->EnableControls();
    p=tp;
    TestMid=tp.mid;
   // p.myTime=p.myTime+1;
     }catch (Exception &exception){
      p=tp;
     	Application->ShowException(&exception);
   }
   }
    //удаляем своё
    delete [] array;
    array = NULL;
}
//26.01.2021 GRB ADD
//---------------------------------------------------------------------------
long __fastcall TfmManualInput::getLastMid (){
   vtData->First();
    long curr_mid, ret;
    curr_mid = ret = -1;
    int k=0;
    for(k; k<RowCount;k++){
        curr_mid = vtData->FieldByName("mid")->AsFloat;
        vtData->Next();
        }
    if (k > 1) ret = curr_mid;
    return ret;
}
//---------------------------------------------------------------------------

void __fastcall TfmManualInput::ToolButton6Click(TObject *Sender)
{
   TfmGetSelectDate* fm = new TfmGetSelectDate(this, tp.myTime.FormatString("dd.mm.yyyy hh:nn:ss"));
     //fm->Caption=Reconst_smes60_4;
     fm->plSupMain->Visible=true;
     if(fm->ShowModal()==mrOk){
        TDateTime datefrom = fm->DateTime;
             //Считаем сколько строк
        oqReadRow->Open();
        oqReadRow->First();
        int dim = (RowCount>0?(RowCount/*-1*/):0);
        int *array = new int[dim];
        int i = 0;
        while (!oqReadRow->Eof){
                array[i] = oqReadRow->FieldByName("mid")->AsFloat;
                i++;
                oqReadRow->Next();
        }
        oqReadRow->Close();
        //Теперь копипаст кода сохранения c изменениями в части инверсии
        for (int j = 0; j < dim; j++ ){
        try{
        tp=p;
        p.myTime=datefrom;
        p.mid=array[j];
        TestMid=array[j];
        vtData->DisableControls();
        vtData->AfterPost=NULL;
        //ReadData();
        CopyData();
        if(vtData->State==dsInsert||vtData->State==dsEdit)
                vtData->Post();

        btSave->Enabled=true;
        vtData->AfterPost=vtDataAfterPost;
        dbManInput->SumList->RecalcAll();
        vtData->EnableControls();
        p=tp;
        TestMid=tp.mid;
        // p.myTime=p.myTime+1;
        }catch (Exception &exception){
                p=tp;
     	        Application->ShowException(&exception);
        }
     }
    //удаляем своё
    delete [] array;
    array = NULL;
    }
}
//---------------------------------------------------------------------------

