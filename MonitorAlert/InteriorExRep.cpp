//---------------------------------------------------------------------------
#include <vcl.h>
#include <utilcls.h>
#include "SupperMain.h" // Add KAS 17.07.2001
#pragma hdrstop
#include "InteriorExRep.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
extern int ExcelWindowsCount;
extern int ExcelActiveWindowsCount;
//---------------------------------------------------------------------------
template <class T> T* _getAddress(T& object)
{
  return  reinterpret_cast<T *>(&reinterpret_cast<int &>(object));
}
//---------------------------------------------------------------------------
__fastcall TInteriorExRep::TInteriorExRep(TComponent* Owner,TSplitterForm *aSP,TFormDescr* aFD,Classes::TNotifyEvent OnProgr):
	TInterior(Owner,aSP,aFD,OnProgr )
{
  if (!dynamic_cast<TWinControl *>(Owner))
  { OnProgressBarStepBy(NULL);
    throw (Exception("TInteriorEx:: Владелец не оконный компонент."));
  }
  OnProgressBarStepBy(NULL);
/*  OnProgressBarStepBy(this);//10
  OnProgressBarStepBy(this);//20
  OnProgressBarStepBy(this);//30
  OnProgressBarStepBy(this);//40*/
  try
  {
    ocCont = new TOleContainer(Owner);
//    ocCont->Parent = (TWinControl*)Owner;
    ocCont->Align = alNone;//Client;
    ocCont->Height=100;
    ocCont->Width=100;
    ocCont->AutoActivate = aaDoubleClick;
    ocCont->AutoVerbMenu = false;
    ocCont->AllowInPlace = false;
    ocCont->Iconic = false;
    ocCont->SizeMode = smStretch;
    ocCont->Caption = "OLEContainer";
//    OnProgressBarStepBy(this);//50
//    OnProgressBarStepBy(this);//60
  }
  catch(Exception &exception)
  {
    Application->ShowException(&exception);
  }
}

//chig
//---------------------------------------------------------------------------
void __fastcall TInteriorExRep::PassParamsToExcel()
{
  TVariantInParam Template = TNoParam(),Template1 = TNoParam();

  AnsiString prStr;
   //Присоединились к соответствующему обьекту
  pwshs = SupperMainForm->ExcelWorkbook1->Worksheets->get_Item("Сценарий");
  SupperMainForm->ExcelWorksheet1->ConnectTo(pwshs);      // необходимо обязательно для связи
   //e
  OnProgressBarStepBy(this);//70

   //Параметр Ид группы
     //Получили обьект для ввода параметров
  Template = "C9";
  pRG = SupperMainForm->ExcelWorksheet1->Get_Range(Template,Template1);
     //e
     //Вводим параметр
       //Сформировали параметр даты в виде строки
  prStr = IntToStr( fd->IdGroup );
       //e
  Template=prStr;
  pRG->set_Value(Template);
     //e Вводим параметр
   //e Параметр Ид группы

   //Параметр Начало
     //Получили обьект для ввода параметров
  Template = "C10";
  pRG = SupperMainForm->ExcelWorksheet1->Get_Range(Template,Template1);
     //e
     //Вводим параметр
       //Сформировали параметр даты в виде строки
  DateTimeToString(prStr, "dd.mm.yyyy hh:nn", fd->DateTimePar);
       //e
  Template=prStr;
  pRG->set_Value(Template);
     //e Вводим параметр
   //e Параметр Начало

   //Параметр Конец
     //Получили обьект для ввода параметров
  Template = "C11";
  pRG = SupperMainForm->ExcelWorksheet1->Get_Range(Template,Template1);
     //e
     //Вводим параметр
       //Сформировали параметр даты в виде строки
  DateTimeToString(prStr, "dd.mm.yyyy hh:nn", fd->DateTime);
       //e
  Template=prStr;
  pRG->set_Value(Template);
     //e Вводим параметр
   //e Параметр Конец
  //e Формирование параметров
};
//---------------------------------------------------------------------------
void __fastcall TInteriorExRep::PassParamsToExcelAndRefr()
{
  TVariantInParam Template = TNoParam(),Template1 = TNoParam();
  try
  {
     SupperMainForm->ExcelApplication1->Workbooks->get_Item(ExcelWindowName,_getAddress(Wb));
     SupperMainForm->ExcelWorkbook1->ConnectTo(Wb);

     //chig Формирование параметров
     PassParamsToExcel();
     //e Формирование параметров

     CurrentSheet = 1;
     SupperMainForm->ExcelWorkbook1->Worksheets->get_Count(&CountSheets);
//   Запись текущей даты в ячейку
/*     AnsiString DateStr;
     DateTimeToString(DateStr, "dd.mm.yyyy", fd->DateTime);
     pwshs = SupperMainForm->ExcelWorkbook1->Worksheets->get_Item("Сценарий");
     SupperMainForm->ExcelWorksheet1->ConnectTo(pwshs);      // необходимо обязательно для связи
     Template = "C6";
     pRG = SupperMainForm->ExcelWorksheet1->Get_Range(Template,Template1);
     Template=DateStr;
     pRG->set_Value(Template);*/
     pwshs = SupperMainForm->ExcelWorkbook1->Worksheets->get_Item("Имя БД");
     SupperMainForm->ExcelWorksheet1->ConnectTo(pwshs);      // необходимо обязательно для связи
     Template = "B4";
     pRG = SupperMainForm->ExcelWorksheet1->Get_Range(Template,Template1);
     Template=NameTNS;
     pRG->set_Value(Template);
     Template="B7";
     pRG = SupperMainForm->ExcelWorksheet1->Get_Range(Template,Template1);
     pRG->set_Value(Template);
//     pwshs = SupperMainForm->ExcelWorkbook1->Worksheets->get_Item(CurrentSheet);
//     SupperMainForm->ExcelWorksheet1->ConnectTo(pwshs);      // необходимо обязательно для связи
//     SupperMainForm->ExcelWorksheet1->Activate(LOCALE_USER_DEFAULT);
     ActiveWs = pwshs;
//     OnProgressBarStepBy(this);//80
//     OnProgressBarStepBy(this);//90
  }
  catch(...)
  {
    //begin Сечин 31.07.01
    OnProgressBarStepBy(NULL);
    throw;
    //end Сечин
  }
  OnProgressBarStepBy(NULL);
}
//e chig

//---------------------------------------------------------------------------
void __fastcall TInteriorExRep::Place(void)
{
    Excel_97::ToolbarPtr TbPtr;
TVariantInParam Template = TNoParam(),Template1 = TNoParam();

  try
  {
    dynamic_cast<TBaseMonitorForm*>(Owner)->Caption = "Отчет";//fd->NameGroup+" за " + DateToStr(fd->DateTime);
    dynamic_cast<TBaseMonitorForm*>(Owner)->HelpContext = 31;
    SplitterForm->AddChild(NULL, ocCont, alNone/*Client*/);
//    OnProgressBarStepBy(this);//70
//    CreateExcelFile();
//    ocCont->CreateObjectFromFile(ExFileName, false);
    ocCont->CreateObjectFromFile(ExFileFullName, false);
    ocCont->Run();
    DoVerb();
    ExcelWindowsCount++;
    ExcelActiveWindowsCount++;
     if(ExcelWindowsCount==1)
     {
     SupperMainForm->ExcelApplication1->Connect();
     SupperMainForm->ExcelApplication1->Set_Visible(LOCALE_USER_DEFAULT,false);
     SupperMainForm->ExcelApplication1->Set_DisplayAlerts(LOCALE_USER_DEFAULT, false);

     SupperMainForm->ExcelApplication1->Set_DisplayFormulaBar(LOCALE_USER_DEFAULT,false);

     long TbCount = SupperMainForm->ExcelApplication1->Toolbars->get_Count();
     for(int i=1; i<=TbCount; i++)
     {
      TbPtr = SupperMainForm->ExcelApplication1->Toolbars->get_Item(i);
      TbPtr->set_Visible(false);
     }
      ExcelWindowName = "Лист в OLEContainer";
     }
     else
      ExcelWindowName = "Лист в OLEContainer "+IntToStr(ExcelWindowsCount);

     Application->ProcessMessages();

     //chig
     PassParamsToExcelAndRefr();
     //e chig
  }
  catch(...)
  {
    //begin Сечин 31.07.01
    OnProgressBarStepBy(NULL);
    throw;
    //end Сечин
  }
  OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
__fastcall TInteriorExRep::~TInteriorExRep(void)
{
  if(ocCont)
  {
/*   try
   {
      ocCont->Close();
      ocCont->DoVerb(-2);
   }
   catch(...)
   {}
  */    ocCont->DestroyObject();
     delete ocCont;

      // Когда закрывается последний монитор то закрываем и Excel
     ExcelActiveWindowsCount--;
     if(!ExcelActiveWindowsCount)
     {
       ExcelActiveWindowsCount = ExcelWindowsCount = 0;
       SupperMainForm->ExcelWorksheet1->Disconnect();
       SupperMainForm->ExcelWorkbook1->Disconnect();
       SupperMainForm->ExcelApplication1->Workbooks->Close(LOCALE_USER_DEFAULT);
//       SupperMainForm->ExcelApplication1->Quit();
     }

  }
//  DeleteFile(ExFileName.c_str());
}
//---------------------------------------------------------------------------
void __fastcall TInteriorExRep::Invalidate(int Table)
{
  if(Table==1 /*PROFILE*/)
  {
     // Эта форма не обновляется
  }
}
//---------------------------------------------------------------------------
// Создается временный файл-копия Excel-евского шаблона
void __fastcall TInteriorExRep::CreateExcelFile()
{
  char lpBuffer[256];
  char lpPrefx[4] = "EMO\0";
  char lpTempFileName[256];
  char *pptr, *p = ".tmp";

  lpBuffer[0]=0;
  GetTempPath(244, lpBuffer);
  if(!GetTempFileName(lpBuffer, lpPrefx, 0, lpTempFileName))
  {
    throw(Exception("Не удалось создать временный файл."));
  }
// Нужно для Win95 +++++++++++++++++++
  ExFileName = lpTempFileName;
  strcpy(lpTempFileName, ExFileName.LowerCase().c_str());
//++++++++++++++++++++++++++++++++++++
  DeleteFile(lpTempFileName);
  pptr = strstr(lpTempFileName, p);
  strcpy(pptr, ".xls");
  if(!CopyFile(ExFileFullName.c_str(), lpTempFileName, false))
  {
    throw(Exception("Не удалось создать временный файл."));
  }
  ExFileName = lpTempFileName;
}
//---------------------------------------------------------------------------
void TInteriorExRep::NextSheet()
{
    AnsiString SName;
 if(CurrentSheet<CountSheets)
 {
          SupperMainForm->ExcelWorksheet1->ConnectTo(ActiveWs);
          pwshs = SupperMainForm->ExcelWorksheet1->Get_Next();
          pwshs->get_Name(&fName);
          SName = fName;
          if((SName!="Сценарий") & (SName!="Имя БД") & (SName!="repfilenamedlg"))
          {
               SupperMainForm->ExcelWorksheet1->ConnectTo(pwshs);// необходимо обязательно для связи//
               pwshs->Activate(LOCALE_USER_DEFAULT);
               ActiveWs = pwshs;
               CurrentSheet++;
          }
 }
     ocCont->DoVerb(ovPrimary);
     SupperMainForm->Height = SupperMainForm->Height-1; // Для того чтобы убрать ненужный скроллинг на главной форме
     SupperMainForm->Height = SupperMainForm->Height+1;
}
//---------------------------------------------------------------------------
void TInteriorExRep::PreviousSheet()
{
    AnsiString SName;
 if(1<CurrentSheet)
 {
          SupperMainForm->ExcelWorksheet1->ConnectTo(ActiveWs);
          pwshs = SupperMainForm->ExcelWorksheet1->Get_Previous();
          pwshs->get_Name(&fName);
          SName = fName;
          if((SName!="Сценарий") & (SName!="Имя БД") & (SName!="repfilenamedlg"))
          {
               SupperMainForm->ExcelWorksheet1->ConnectTo(pwshs);// необходимо обязательно для связи//
               pwshs->Activate(LOCALE_USER_DEFAULT);
               ActiveWs = pwshs;
               CurrentSheet--;
          }
 }
     ocCont->DoVerb(ovPrimary);
     SupperMainForm->Height = SupperMainForm->Height-1; // Для того чтобы убрать ненужный скроллинг на главной форме
     SupperMainForm->Height = SupperMainForm->Height+1;
}
//---------------------------------------------------------------------------
void TInteriorExRep::Preview()
{
//  vWorkbook.OlePropertyGet("Worksheets",Variant(CurrentSheet)).OleFunction("PrintPreview");
}
//---------------------------------------------------------------------------
void __fastcall TInteriorExRep::PrintRep()
{
    AnsiString SName;

  SupperMainForm->ExcelApplication1->Workbooks->get_Item(ExcelWindowName,_getAddress(Wb));
  SupperMainForm->ExcelWorkbook1->ConnectTo(Wb);
  for(int i = 1; i<=CountSheets; i++)
  {
          pwshs = SupperMainForm->ExcelWorkbook1->Worksheets->get_Item(i);
          pwshs->get_Name(&fName);
          SName = fName;
          SName = SName.LowerCase();
          if(!SName.Pos("служебный"))
            if((SName!="сценарий") & (SName!="имя бд") & (SName!="repfilenamedlg"))
              pwshs->PrintOut(1,100,1,0,0,0,0,LOCALE_USER_DEFAULT);
  }
}
//---------------------------------------------------------------------------

void __fastcall TInteriorExRep::SaveRepToFile(TSaveDialog *aSaveDialog)
{
      aSaveDialog->Title = "Сохранение отчета";
      aSaveDialog->DefaultExt = "xls";
      aSaveDialog->Filter = "Книга Microsoft Excel (*.xls)|*.xls";
      if(aSaveDialog->Execute())
      {
         ocCont->SaveAsDocument(aSaveDialog->FileName);
      }
}
//---------------------------------------------------------------------------

void TInteriorExRep::PrintActiveSheet()
{
  SupperMainForm->ExcelApplication1->Workbooks->get_Item(ExcelWindowName,_getAddress(Wb));
  SupperMainForm->ExcelWorkbook1->ConnectTo(Wb);
  ActiveWs = SupperMainForm->ExcelWorkbook1->Get_ActiveSheet();
  SupperMainForm->ExcelWorksheet1->ConnectTo(ActiveWs);      // необходимо обязательно для связи
  ActiveWs->PrintOut(1,100,1,0,0,0,0,LOCALE_USER_DEFAULT);
}
//---------------------------------------------------------------------------
void TInteriorExRep::DoVerb()
{
//  SupperMainForm->AutoScroll = false;
   if(ocCont)
      ocCont->DoVerb(ovShow);
//  SupperMainForm->Height = SupperMainForm->Height-1; // Для того чтобы убрать ненужный скроллинг на главной форме
//  SupperMainForm->Height = SupperMainForm->Height+1;
   Application->ProcessMessages();
//  SupperMainForm->AutoScroll = true;
}
//---------------------------------------------------------------------------

