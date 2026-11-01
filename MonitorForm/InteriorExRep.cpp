//---------------------------------------------------------------------------
#include <vcl.h>
#include <utilcls.h>
#pragma hdrstop
#include "unDataMod.h"
#include "InteriorExRep.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
/*! Для обеспечения простоты работы с Excel в Интерьерах
*/
class TInteriorExRepPriv
{
public:
  TInteriorExRepPriv()
    :xlAutoActivate(3), xlAutoClose(2), xlAutoDeactivate(4), xlAutoOpen(1)
    ,sheetindex(1)
  { disconnectEx();
  }
  ~TInteriorExRepPriv()
  { disconnectEx();
  }
  /*! Отсоединение от книги и листа в Excel
  */
  void __fastcall disconnectEx()
  { book      = Null();
    sheet     = Null();
    currsheet = Null();
  }
  /*! Проверка на присоединение к Excel

      \return true вслучае присоединения, иначе - false.
  */
  bool __fastcall isConnected()
  { return  !VarIsNull(book);
  }
  /*! Установка рабочей книги, где:
      \param container - Указатель на контейнер, содержащий объект Excel

      \return true если установка прошла успешно, иначе - false.

      \attention вслучае установки рабочей книги переменная \b book
        принимает значение рабочей книги, иначе ей присваивается
        значение \b Null()
  */
  bool __fastcall setBook(TOleContainer *container);
  /*! Выбор необходимой страницы Excel, где:
      \param sheetname - Строка с наименованием необходимой страницы

      \return true если нужная страница выбрана, иначе - false.

      \attention вслучае выбора страницы переменная \b sheet
        принимает значение данной страницы, иначе ей присваивается
        значение \b Null()
  */
  bool __fastcall setSheet(AnsiString sheetname);
  /*! \overload
      Выбор необходимой страницы по индексу, где:
      \param sheetnum - индекс необходимой страницы
  */
  bool __fastcall setSheet(int sheetnum);
  /*! Активация страницы, где:
      \param sheetnum - индекс необходимой страницы

      \return true если нужная страница выбрана, иначе - false.

      \attention вслучае активации страницы переменная \b sheet
        принимает значение данной страницы, иначе ей присваивается
        значение \b Null()
  */
  bool __fastcall activateSheet(int sheetnum);
  /*! Получение количества страниц в книге

      \return количество страниц в книге.
  */
  int __fastcall sheetCount()
  { return  book.OlePropertyGet("Worksheets").OlePropertyGet("Count");
  }

  Variant book;         //===== Объект загруженная WorkBook
  Variant sheet;        //===== Объект текущей страницы
  Variant currsheet;    //===== Текущая страница

  int sheetindex;   //===== Индекс текущей страницы

private:
  const int xlAutoActivate;
  const int xlAutoClose;
  const int xlAutoDeactivate;
  const int xlAutoOpen;
};
//---------------------------------------------------------------------------
bool __fastcall TInteriorExRepPriv::setBook(TOleContainer *container)
{
  /*  Неизвестна необходимость применения этих свойств
    SupperMainForm->ExcelApplication1->Set_Visible(LOCALE_USER_DEFAULT,false);
    SupperMainForm->ExcelApplication1->Set_DisplayAlerts(LOCALE_USER_DEFAULT, false);

    SupperMainForm->ExcelApplication1->Set_DisplayFormulaBar(LOCALE_USER_DEFAULT,false);

    long TbCount = SupperMainForm->ExcelApplication1->Toolbars->get_Count();
    for(int i=1; i<=TbCount; i++)
    {
    TbPtr = SupperMainForm->ExcelApplication1->Toolbars->get_Item(i);
    TbPtr->set_Visible(false);
    }
  */
  try{
    book  = container->OleObject.OlePropertyGet("Application").OlePropertyGet("Workbooks").OlePropertyGet("Item", Variant(1));
    book.OleProcedure("RunAutoMacros", Variant(xlAutoOpen));
    book.OleProcedure("RunAutoMacros", Variant(xlAutoActivate));
  }
  catch (Exception &e)
  { book  = Null();
  }
  return  isConnected();
}
//---------------------------------------------------------------------------
bool __fastcall TInteriorExRepPriv::setSheet(AnsiString sheetname)
{
  sheet = Null();
  try
  { if (!isConnected())
      return  false;

    Variant tVar  = book.OlePropertyGet("Worksheets");    //===== Доступ к листам
    int tCnt  = tVar.OlePropertyGet("Count");             //===== Количество листов
    //===== Перебор всех листов в поисках необходимого
    for (int i = 1; i <= tCnt; ++i){
      if (tVar.OlePropertyGet("Item", Variant(i)).OlePropertyGet("Name") == sheetname){
        sheet = tVar.OlePropertyGet("Item", Variant(i));
        break;
      }
    }
    if(VarIsNull(sheet))
      sheet = book.OlePropertyGet("Worksheets", WideString(sheetname));
  }catch (Exception &e){
    sheet = Null();
  }
  return  !VarIsNull(sheet);
}
//---------------------------------------------------------------------------
bool __fastcall TInteriorExRepPriv::setSheet(int sheetnum)
{
  sheet = Null();
  try
  { if (isConnected())
      sheet = book.OlePropertyGet("Worksheets").OlePropertyGet("Item", Variant(sheetnum));
  }
  catch (Exception &e)
  { sheet = Null;
  }
  return  !VarIsNull(sheet);
}
//---------------------------------------------------------------------------
bool __fastcall TInteriorExRepPriv::activateSheet(int sheetnum)
{
  sheet = Null();
  try
  { if (!setSheet(sheetnum))
      return  false;

    AnsiString  tName = sheet.OlePropertyGet("Name");
    if ((tName != Reconst_smes93_2) && (tName != Reconst_smes93_3) && (tName != "repfilenamedlg"))
    { sheet.OleProcedure("Activate");
      sheetindex  = sheet.OlePropertyGet("Index");
    }
  }
  catch (Exception &e)
  { sheet = Null();
  }
  return  !VarIsNull(sheet);
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

__fastcall TInteriorExRep::TInteriorExRep(TComponent* Owner,TSplitterForm *aSP,TFormDescr* aFD,Classes::TNotifyEvent OnProgr):
	TInterior(Owner,aSP,aFD,OnProgr )
{
  if( !dynamic_cast<TWinControl*>(Owner) )
  { OnProgressBarStepBy(NULL);
    throw Exception(Reconst_smes93_1);
  }
  OnProgressBarStepBy(NULL);
  try
  { ocCont  = new TOleContainer(Owner);
    //ocCont->Parent = (TWinControl*)Owner;
    ocCont->Align = alNone;//Client;
    ocCont->Height=100;
    ocCont->Width=100;
    ocCont->AutoActivate = aaDoubleClick;
    ocCont->AutoVerbMenu = false;
    ocCont->AllowInPlace = false;
    ocCont->Iconic = false;
    ocCont->SizeMode = smStretch;
    ocCont->Caption = "OLEContainer";
  }
  catch(Exception &exception)
  { Application->ShowException(&exception);
  }

  d = new TInteriorExRepPriv();
}

//chig
//---------------------------------------------------------------------------
void __fastcall TInteriorExRep::PassParamsToExcel()
{
  try
  { //===== Присоедининяемся к необходимому листу
    if (!d->setSheet(Reconst_smes93_2))
      throw Exception(Reconst_smes93_13);

    OnProgressBarStepBy(this);

    //===== Заносим Ид группы в ячейку С9
    d->sheet.OlePropertyGet("Cells", 9, 3).OlePropertySet("Value", Variant(fd->IdGroup));

    //===== Заносим дату начала в ячейку С10
    d->sheet.OlePropertyGet("Cells", 10, 3).OlePropertySet("Value", WideString(FormatDateTime("dd.mm.yyyy hh:nn", fd->DateTimePar)));
    //===== Заносим дату конца в ячейку C11
    d->sheet.OlePropertyGet("Cells", 11, 3).OlePropertySet("Value", WideString(FormatDateTime("dd.mm.yyyy hh:nn", fd->DateTime)));
  }
  catch (Exception &e)
  { Application->ShowException(&e);
    throw;
  }
}
//---------------------------------------------------------------------------
void __fastcall TInteriorExRep::PassParamsToExcelAndRefr()
{
  try
  { //===== Формирование параметров
  //GRB ADD 06.11.2019
    d->book.OlePropertyGet("Application").OlePropertySet("ScreenUpdating", false);
    ocCont->OleObject.OlePropertyGet("Application").OlePropertySet("ScreenUpdating",false);
   //END ADD
    PassParamsToExcel();


    //===== Присоедининяемся к необходимому листу
    if (!d->setSheet(Reconst_smes93_3))
      throw Exception(Reconst_smes93_14);

    //===== Запись строки связи с БД в ячейку B4
    d->sheet.OlePropertyGet("Cells", 4, 2).OlePropertySet("Value", WideString(dmMain->orases->Server));
    //===== Инициация запуска генерации отчета
    //===== Запись в ячейку B7 любых данных
    d->sheet.OlePropertyGet("Cells", 7, 2).OlePropertySet("Value", WideString("B7"));
    d->activateSheet(1);
    //GRB ADD 06.11.2019
    /*d->book.OlePropertyGet("Application").OlePropertySet("ScreenUpdating", true);
    ocCont->OleObject.OlePropertyGet("Application").OlePropertySet("ScreenUpdating",true); */
  }
  catch (Exception &e)
  { Application->ShowException(&e);
    throw;
  }
  OnProgressBarStepBy(NULL);
}

//---------------------------------------------------------------------------
void __fastcall TInteriorExRep::Place(void)
{
  try
  { dynamic_cast<TForm *>(Owner)->Caption     = Reconst_smes93_4;
    dynamic_cast<TForm *>(Owner)->HelpContext = 31;
    SplitterForm->AddChild(NULL, ocCont, alNone/*Client*/);
    ocCont->CreateObjectFromFile(ExFileFullName, false);
    ocCont->Run();
    DoVerb();

    if (!d->setBook(ocCont))
      throw Exception(Reconst_smes93_15);

    Application->ProcessMessages();
    PassParamsToExcelAndRefr();
  }
  catch (Exception &e)
  { OnProgressBarStepBy(NULL);
    Application->ShowException(&e);
    throw;
  }
  OnProgressBarStepBy(NULL);
}
//---------------------------------------------------------------------------
__fastcall TInteriorExRep::~TInteriorExRep(void)
{
  delete  d;
  d = NULL;

  if (ocCont)
  { ocCont->DestroyObject();
    delete  ocCont;
  }
  //DeleteFile(ExFileName.c_str());
}
//---------------------------------------------------------------------------
void __fastcall TInteriorExRep::Invalidate(int Table)
{
  if (Table == 1 /*PROFILE*/)
  { // Эта форма не обновляется
  }
}
//---------------------------------------------------------------------------
// Создается временный файл-копия Excel-евского шаблона
/*
void __fastcall TInteriorExRep::CreateExcelFile()
{
  char  lpBuffer[256];
  char  lpPrefx[4]  = "EMO\0";
  char  lpTempFileName[256];
  char  *pptr,
        *p  = ".tmp";

  lpBuffer[0] = 0;
  GetTempPath(244, lpBuffer);
  if (!GetTempFileName(lpBuffer, lpPrefx, 0, lpTempFileName))
    throw Exception("Не удалось создать временный файл.");

  // Нужно для Win95 +++++++++++++++++++
  ExFileName  = lpTempFileName;
  strcpy(lpTempFileName, ExFileName.LowerCase().c_str());
  //++++++++++++++++++++++++++++++++++++
  DeleteFile(lpTempFileName);
  pptr  = strstr(lpTempFileName, p);
  strcpy(pptr, ".xls");
  if (!CopyFile(ExFileFullName.c_str(), lpTempFileName, false))
    throw Exception("Не удалось создать временный файл.");
  ExFileName  = lpTempFileName;
}
*/
//---------------------------------------------------------------------------
void TInteriorExRep::NextSheet()
{
/*
  AnsiString SName;
  if (CurrentSheet < CountSheets)
  { SupperMainForm->ExcelWorksheet1->ConnectTo(ActiveWs);
    pwshs = SupperMainForm->ExcelWorksheet1->Get_Next();
    pwshs->get_Name(&fName);
    SName = fName;
    if ((SName!="Сценарий") & (SName!="Имя БД") & (SName!="repfilenamedlg"))
    { SupperMainForm->ExcelWorksheet1->ConnectTo(pwshs);// необходимо обязательно для связи//
      pwshs->Activate(LOCALE_USER_DEFAULT);
      ActiveWs = pwshs;
      CurrentSheet++;
    }
  }
  ocCont->DoVerb(ovPrimary);
  SupperMainForm->Height = SupperMainForm->Height-1; // Для того чтобы убрать ненужный скроллинг на главной форме
  SupperMainForm->Height = SupperMainForm->Height+1;
*/
  try
  { if (d->sheetindex < d->sheetCount())
    { if (d->activateSheet(d->sheetindex + 1))
        ocCont->DoVerb(ovPrimary);
    }

    //SupperMainForm->Height = SupperMainForm->Height-1; // Для того чтобы убрать ненужный скроллинг на главной форме
    //SupperMainForm->Height = SupperMainForm->Height+1;
  }
  catch (Exception &e)
  {
  }
}
//---------------------------------------------------------------------------
void TInteriorExRep::PreviousSheet()
{
/*
  AnsiString SName;
  if (1 < CurrentSheet)
  { SupperMainForm->ExcelWorksheet1->ConnectTo(ActiveWs);
    pwshs = SupperMainForm->ExcelWorksheet1->Get_Previous();
    pwshs->get_Name(&fName);
    SName = fName;
    if ((SName!="Сценарий") & (SName!="Имя БД") & (SName!="repfilenamedlg"))
    { SupperMainForm->ExcelWorksheet1->ConnectTo(pwshs);// необходимо обязательно для связи//
      pwshs->Activate(LOCALE_USER_DEFAULT);
      ActiveWs = pwshs;
      CurrentSheet--;
    }
  }
  ocCont->DoVerb(ovPrimary);
  SupperMainForm->Height  = SupperMainForm->Height-1; // Для того чтобы убрать ненужный скроллинг на главной форме
  SupperMainForm->Height  = SupperMainForm->Height+1;
*/
  try
  { if (d->sheetindex > 1)
    { if (d->activateSheet(d->sheetindex - 1))
        ocCont->DoVerb(ovPrimary);
    }
    //SupperMainForm->Height = SupperMainForm->Height-1; // Для того чтобы убрать ненужный скроллинг на главной форме
    //SupperMainForm->Height = SupperMainForm->Height+1;
  }
  catch (Exception &e)
  {
  }
}
//---------------------------------------------------------------------------
void TInteriorExRep::Preview()
{
  if (d->setSheet(d->sheetindex))
    d->sheet.OleFunction("PrintPreview");
}
//---------------------------------------------------------------------------
void __fastcall TInteriorExRep::PrintRep()
{
/*
  AnsiString SName;
  SupperMainForm->ExcelApplication1->Workbooks->get_Item(ExcelWindowName,_getAddress(Wb));
  SupperMainForm->ExcelWorkbook1->ConnectTo(Wb);
  // печать текущего листа (Add by KSS)
  pwshs = SupperMainForm->ExcelWorkbook1->ActiveSheet;
  pwshs->PrintOut(1,100,1,0,0,0,0,LOCALE_USER_DEFAULT);

  //печать всех листов
  //for (int i = 1; i<=CountSheets; i++)
  //{ pwshs = SupperMainForm->ExcelWorkbook1->Worksheets->get_Item(i);
  //  pwshs->get_Name(&fName);
  //  SName = fName;
  //  SName = SName.LowerCase();
  //  if (!SName.Pos("служебный"))
  //    if ((SName!="сценарий") & (SName!="имя бд") & (SName!="repfilenamedlg"))
  //      pwshs->PrintOut(1,100,1,0,0,0,0,LOCALE_USER_DEFAULT);
  //}
*/
  PrintActiveSheet();
}
//---------------------------------------------------------------------------

void __fastcall TInteriorExRep::SaveRepToFile(TSaveDialog *aSaveDialog)
{
  aSaveDialog->Title  = Reconst_smes93_11;
  aSaveDialog->DefaultExt = "xls";
  aSaveDialog->Filter = Reconst_smes93_12;
  if (aSaveDialog->Execute())
  { ocCont->SaveAsDocument(aSaveDialog->FileName);
  }
}
//---------------------------------------------------------------------------

void TInteriorExRep::PrintActiveSheet()
{
/*
  SupperMainForm->ExcelApplication1->Workbooks->get_Item(ExcelWindowName,_getAddress(Wb));
  SupperMainForm->ExcelWorkbook1->ConnectTo(Wb);
  ActiveWs = SupperMainForm->ExcelWorkbook1->Get_ActiveSheet();
  SupperMainForm->ExcelWorksheet1->ConnectTo(ActiveWs);      // необходимо обязательно для связи
  ActiveWs->PrintOut(1,100,1,0,0,0,0,LOCALE_USER_DEFAULT);
*/
  try{
  d->sheetindex = d->book.OlePropertyGet("ActiveSheet").OlePropertyGet("Index");
  if (d->setSheet(d->sheetindex))
    d->sheet.OleFunction("PrintOut");
  }
  catch (Exception &e){}
}
//---------------------------------------------------------------------------
void TInteriorExRep::DoVerb()
{
  try
  { //SupperMainForm->AutoScroll  = false;
    ocCont->DoVerb(ovShow);
    //SupperMainForm->Height  = SupperMainForm->Height - 1; // Для того чтобы убрать ненужный скроллинг на главной форме
    //SupperMainForm->Height  = SupperMainForm->Height + 1;
    Application->ProcessMessages();
    //SupperMainForm->AutoScroll = true;
  }
  catch (Exception &e)
  {
  }
}
//---------------------------------------------------------------------------

