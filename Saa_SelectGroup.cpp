//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop
#include "unDataMod.h"
#include "Saa_SelectForm.h"
#include "Saa_SelectGroup.h"
#include "Monitor.h"
#include "Reconst.hpp"

//#include "SupperMain.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "DBAccess"
#pragma link "MemDS"
#pragma link "Ora"
#pragma resource "*.dfm"
#define MAXPOINT	1000
TfmSelectGroupReport *fmSelectGroupReport;
//HCURSOR hCursor;
extern TStringList  *tFileListCnt;
//---------------------------------------------------------------------------
__fastcall TfmSelectGroupReport::TfmSelectGroupReport(TComponent* Owner,TFormDescr* sfd)
	: TForm(Owner)
{
  for (int i =0; i<4; i++) ar_RGroup[i] = 10;
  fd=sfd;
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReport::tvMainChange(TObject *Sender, TTreeNode *Node)
{
  Label1->Caption = tvMain->Selected->Text;
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReport::FormShow(TObject *Sender)
{
  tvMain->Focused();		//выбрать нужный по id_Group
  fmFP=new TfmFindPoint(this);
  if (fd->IdFormTree == 1013){
        ToolButton1->Enabled = false;
  }
}
//---------------------------------------------------------------------------
bool TfmSelectGroupReport::GetAllTree(TObject *Sender)
{
  int ii;
  try{
  AnsiString sql;
     oqCursor1->Params->Clear();

     oqCursor1->SQL->Text="begin "+SchemeName+"SAA_SELECT_PG.SelectGroupReport_GetAllTree_p(:par1,:par2,:par3,:par4); end;";
     oqCursor1->ParamByName("par4")->DataType=ftCursor;
     oqCursor1->ParamByName("par4")->ParamType=ptOutput;

     oqCursor1->ParamByName("par1")->AsInteger=fd->CodeTemplate;

  if ((fd->CodeTemplate!=1000)&&(fd->CodeTemplate!=1100)){          // Обычный режим
    TTreeNode *MyTreeNode1;

    // Для макетов! Мать их!
    if(fd->CodeTemplate==MAKET_F){
        oqCursor1->ParamByName("par2")->Clear();
        oqCursor1->ParamByName("par3")->Clear();
    }else{
      if(fd->EnableControls.Contains(TFormDescr::ctrlPoint))
       //TfmSelectReportForm::AddPoints(tvMain, NULL, 3, 2);
       TfmSelectReportForm::AddPoints(tvMain, NULL, 1, 2);

        oqCursor1->ParamByName("par2")->AsInteger=fd->IdFormTree;
        oqCursor1->ParamByName("par3")->AsInteger= SetVisualControls(this);
        }
      oqCursor1->Execute();
      while (!oqCursor1->Eof){
        MyTreeNode1=tvMain->Items->AddObject(NULL,oqCursor1->FieldByName("VNAME")->AsString,(void*)(oqCursor1->FieldByName("Gid")->AsInteger));
        if (oqCursor1->FieldByName("PP")->AsInteger==1)
          tvMain->Items->AddChildObject(MyTreeNode1,"",(void*)0);
        ii = GetIndexPicture(oqCursor1->FieldByName("PR")->AsInteger);
        MyTreeNode1->ImageIndex = ii;
        MyTreeNode1->SelectedIndex = ii;
        oqCursor1->Next();
      }
    }else{
      Panel10->Enabled = true;
      TTreeNode *Node,*MyTreeNode1;
      SetVisualReg(this);
      if(fd->CodeTemplate==1000){
        Panel7->Caption = Reconst_smes55_1;
        Node = tvMain->Items->AddObject(NULL,Reconst_smes55_2,(void*)0);
        oqCursor1->ParamByName("par2")->Clear();
        oqCursor1->ParamByName("par3")->Clear();
      }else{
        Panel7->Caption = Reconst_smes55_3;
        Node = tvMain->Items->AddObject(NULL,Reconst_smes55_4,(void*)0);
        oqCursor1->ParamByName("par2")->Clear();
        oqCursor1->ParamByName("par3")->Clear();
      }
      Node->ImageIndex = 3;
      Node->SelectedIndex = 3;
      oqCursor1->Execute();
      while(!oqCursor1->Eof){
       if (fd->CodeTemplate == 1100)
         MyTreeNode1=tvMain->Items->AddChildObject(Node,oqCursor1->FieldByName("VNAME")->AsString,(void*)(-oqCursor1->FieldByName("Mid")->AsInteger));
       else
         MyTreeNode1=tvMain->Items->AddChildObject(Node,oqCursor1->FieldByName("VNAME")->AsString,(void*)(oqCursor1->FieldByName("Mid")->AsInteger));
       if(oqCursor1->FieldByName("Lev")->AsInteger==1)
          tvMain->Items->AddChildObject(MyTreeNode1,"",(void*)0);
       if(fd->CodeTemplate==1000){
          ii = GetIndexPictureJournal(oqCursor1->FieldByName("Task_Cod")->AsInteger);
        }else{
          ii = (oqCursor1->FieldByName("Task_Cod")->AsInteger==3)?2:3;
        }

        MyTreeNode1->ImageIndex=ii;
        MyTreeNode1->SelectedIndex=ii;
        oqCursor1->Next();
      }
    }
  }catch(Exception &exception){
    Application->MessageBox(exception.Message.c_str(),Reconst_smes55_5.c_str(),MB_OK|MB_ICONSTOP);
    return false;
  }
  return true;
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReport::FormCreate(TObject *Sender)
{
  // установка режымов отображения компонентов формы  ============================
  Panel11->Enabled = true;
  //устанавливаем в видимый режым панель "перечень отображаемых данных"
  if(fd->indbird){
    GroupBox1->Visible = true;
    switch(fd->bird){
      case 0:
        RadioButton1->Checked = true;
        break;
      case 1:
        RadioButton2->Checked = true;
        break;
      case 2:
        RadioButton3->Checked = true;
        break;
    }
  }
  DateTimePicker1->DateTime=fd->DateTime;
  tvMain->Items->Clear();
  GetAllTree(this);
  if(fd->IdGroup>0)
	  TfmSelectReportForm::GetSelectedTree(tvMain,fd);
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReport::btOkClick(TObject *Sender)
{
  TTreeNode *Node;
  long i;
  if(RadioButton1->Checked)
    fd->bird = 0;
  if(RadioButton2->Checked)
    fd->bird = 1;
  if(RadioButton3->Checked)
  fd->bird = 2;
  try{
    hCursor=::SetCursor(LoadCursor(NULL,IDC_WAIT));
    Node = tvMain->Selected;
    if (Node && Node->AbsoluteIndex > -1){
      fd->IdGroup = (long)Node->Data;
      fd->DateTime = DateTimePicker1->Date;
      dmMain->SetShiftTimeZona(fd->DateTime);

      fd->NameGroup = Node->Text;
      if(fd->CodeTemplate!=MAKET_F){
        TfmSelectReportForm::NEWREPORTGROUP TempRepGrList[SAA_MAXCOUNTPOINTS];
        i = (long)Node->Data;
        if(i<0)  i *= -1;
        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectGroupReport_btOkClick_p(:par1,:par2); end;";
        dmMain->oqCursor->ParamByName("par2")->DataType=ftCursor;
        dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;
        dmMain->oqCursor->ParamByName("par1")->AsInteger=i;
        dmMain->oqCursor->Execute();
        if(dmMain->oqCursor->Eof){
          if(fd->CodeTemplate==10||fd->CodeTemplate==20||fd->CodeTemplate==50||fd->CodeTemplate==51||
                        fd->CodeTemplate==52||fd->CodeTemplate==53||fd->CodeTemplate==54||fd->CodeTemplate==55||
                        fd->CodeTemplate==56||fd->CodeTemplate==57||fd->CodeTemplate==58||fd->CodeTemplate==59){
              Application->MessageBox(Reconst_smes55_7.c_str(),Reconst_smes55_5.c_str(),MB_OK|MB_ICONSTOP);
              return;
          }
        }
        fd->NameGroup = Node->Text;
        i = (long)(Node->Data);
        fd->IsPoints = i<0;
        fd->IdGroup = abs(i);
        long id;
        if (ib_RgControl)
          fd->StepProfile =(TFormDescr::EStepProfile) GetStepProfile(ar_RGroup[rg1->ItemIndex]);
        if(fd->StepProfile==TFormDescr::stpMinute)
          fd->DateTime = (int)fd->DateTime;
        if ((fd->CodeTemplate!=1000)&&(fd->CodeTemplate!=1100)){   // Обычный режим (не журналы)

         dmMain->oqCursor->Params->Clear();
         dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectGroupReport_btOkClick2_p(:par1,:par2,:par3); end;";
         dmMain->oqCursor->ParamByName("par3")->DataType=ftCursor;
         dmMain->oqCursor->ParamByName("par3")->ParamType=ptOutput;
         dmMain->oqCursor->ParamByName("par1")->AsInteger=i;
          i = fd->IdGroup;
          dmMain->oqCursor->ParamByName("par1")->AsInteger=i;
          dmMain->oqCursor->ParamByName("par2")->AsInteger=(fd->IsPoints)?1:0;
          dmMain->oqCursor->Execute();

          if(dmMain->oqCursor->Eof)
            return;
          else{
            fd->ShortNameGroup = dmMain->oqCursor->FieldByName("Name")->AsString;
            fd->SummGroup = (dmMain->oqCursor->FieldByName("GT")->AsInteger==1);
          }
        }
      }
      fd->CeilingIdGroup = fd->IdGroup;
    	PostMessage(NULL,WM_REFRESHFORM,0,(LPARAM)fd );
     	ModalResult = mrOk;
    }
    if(!Node)
      ModalResult = mrOk;
    ::SetCursor(hCursor);
  }catch(Exception &exception){
 	  Application->MessageBox(exception.Message.c_str(),Reconst_smes55_5.c_str(),MB_OK|MB_ICONSTOP);
  }
}
//---------------------------------------------------------------------------
int TfmSelectGroupReport::SetVisualControls(TObject *Sender)
{
 int i=2;
 int j=0;
 ib_RgControl = false;
 rg1->Items->Clear();
 if (fd->EnableControls.Contains(TFormDescr::ctrlGroup))
	i=200;
 if (fd->EnableControls.Contains(TFormDescr::ctrlMonth))
	 {rg1->Items->Add(Reconst_smes55_8); ar_RGroup[j++]= 1; ib_RgControl=true;}
 if (fd->EnableControls.Contains(TFormDescr::ctrlDay))
	 {rg1->Items->Add(Reconst_smes55_9); ar_RGroup[j++]= 2;ib_RgControl=true;}
 if (fd->EnableControls.Contains(TFormDescr::ctrlHour))
	 {rg1->Items->Add(Reconst_smes55_10); ar_RGroup[j++]= 3;ib_RgControl=true;}
 if (fd->EnableControls.Contains(TFormDescr::ctrlMinute))
	 {rg1->Items->Add(Reconst_smes55_11); ar_RGroup[j]= 4;ib_RgControl=true;}
 rg1->ItemIndex = GetRgIndex(this,GetStepProfileInv(fd->StepProfile));
 Panel13->Enabled=(fd->EnableControls.Contains(TFormDescr::ctrlCalendar))?true:false;

 return i;
}
//--------------------------------------------------------------------------
// VTR
void TfmSelectGroupReport::SetVisualReg(TObject *Sender)
{
 ib_RgControl=true;
 rg1->Items->Clear();
 rg1->Items->Add(Reconst_smes55_8); ar_RGroup[0]= 1;
 rg1->Items->Add(Reconst_smes55_9); ar_RGroup[1]= 2;
 rg1->Items->Add(Reconst_smes55_14); ar_RGroup[2]= 3;
 rg1->Items->Add(Reconst_smes55_10); ar_RGroup[3]= 4;
 rg1->ItemIndex = GetRgIndex(this,GetStepProfileInv(fd->StepProfile));
 Panel11->Enabled = (fd->EnableControls.Contains(TFormDescr::ctrlCalendar))?true:false;
}
//---------------------------------------------------------------------------
int TfmSelectGroupReport::GetIndexPicture(int i)
{
 if(i<10)  return 0;
	else return (i == 11)?2:1;
}
//---------------------------------------------------------------------------
int TfmSelectGroupReport::GetIndexPictureJournal(int i)
{
	return (i == 0)?3:4;
}
//---------------------------------------------------------------------------
int TfmSelectGroupReport::GetRgIndex(TObject *Sender, int i)
{
 int k = 0;
 for (int j = 0; j<4; j++)
 { if (ar_RGroup[j] == i) k = j; }
 return k;
}
//---------------------------------------------------------------------------

void __fastcall TfmSelectGroupReport::tvMainExpanding(TObject *Sender, TTreeNode *Node,
	bool &AllowExpansion)
{
  int ii;
  try{
    if((fd->CodeTemplate!=1000)&&(fd->CodeTemplate!=1100)){   // Обычный режим
      TTreeNode *MyTreeNode1;
      MyTreeNode1=Node->getFirstChild();
      if((MyTreeNode1==NULL)||((long)MyTreeNode1->Data==0)){
        Node->DeleteChildren();
      }else{
        return;
      }
      if((long)Node->Data<0)
        //TfmSelectReportForm::AddPoints(tvMain, Node, 3, 2);
        TfmSelectReportForm::AddPoints(tvMain, Node, 1, 2);
      else{

        dmMain->oqCursor->Params->Clear();
        dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectGroupReport_tvMainExp_p(:par1,:par2,:par3);end;";
        dmMain->oqCursor->ParamByName("par3")->DataType=ftCursor;
        dmMain->oqCursor->ParamByName("par3")->ParamType=ptOutput;

        dmMain->oqCursor->ParamByName("par1")->AsInteger=fd->CodeTemplate;
        dmMain->oqCursor->ParamByName("par2")->AsInteger=(long)Node->Data;
        dmMain->oqCursor->Execute();
        while(!dmMain->oqCursor->Eof){
          MyTreeNode1=tvMain->Items->AddChildObject(Node,dmMain->oqCursor->FieldByName("VNAME")->AsString,(void*)(dmMain->oqCursor->FieldByName("Gid")->AsInteger));
          if(dmMain->oqCursor->FieldByName("PP")->AsInteger==1)
	   	      tvMain->Items->AddChildObject(MyTreeNode1,"",(void*)0);
          ii = GetIndexPicture(dmMain->oqCursor->FieldByName("PR")->AsInteger);
          MyTreeNode1->ImageIndex = ii;
          MyTreeNode1->SelectedIndex = ii;
          dmMain->oqCursor->Next();
        }
      }
    }else{                                                    //Журнал
      TTreeNode *MyTreeNode1;
      MyTreeNode1=Node->getFirstChild();
      if((MyTreeNode1==NULL)||((long)MyTreeNode1->Data==0)){
        Node->DeleteChildren();
      }else{
        return;
      }

      dmMain->oqCursor->Params->Clear();
      dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectGroupReport_tvMainExp_p(:par1,:par2,:par3);end;";
      dmMain->oqCursor->ParamByName("par3")->DataType=ftCursor;
      dmMain->oqCursor->ParamByName("par3")->ParamType=ptOutput;

      dmMain->oqCursor->ParamByName("par1")->AsInteger=fd->CodeTemplate;
      if (fd->CodeTemplate==1100 && (long)Node->Data<0)
        dmMain->oqCursor->ParamByName("par2")->AsInteger = -(long)Node->Data;
      else
        dmMain->oqCursor->ParamByName("par2")->AsInteger = (long)Node->Data;
      dmMain->oqCursor->Execute();
      while(!dmMain->oqCursor->Eof){
        if (fd->CodeTemplate==1100)
          MyTreeNode1=tvMain->Items->AddChildObject(Node,dmMain->oqCursor->FieldByName("VNAME")->AsString,(void*)(-dmMain->oqCursor->FieldByName("Mid")->AsInteger));
        else
          MyTreeNode1=tvMain->Items->AddChildObject(Node,dmMain->oqCursor->FieldByName("VNAME")->AsString,(void*)(dmMain->oqCursor->FieldByName("Mid")->AsInteger));
        if(dmMain->oqCursor->FieldByName("Lev")->AsInteger==1)
          tvMain->Items->AddChildObject(MyTreeNode1,"",(void*)0);
        if(fd->CodeTemplate==1000){
          ii = GetIndexPictureJournal(dmMain->oqCursor->FieldByName("Task_Cod")->AsInteger);
        }else{
          ii = (dmMain->oqCursor->FieldByName("Task_Cod")->AsInteger==3)?2:3;
        }
		    MyTreeNode1->ImageIndex = ii;
      	MyTreeNode1->SelectedIndex = ii;
        dmMain->oqCursor->Next();
      }
    }
  }catch(Exception &exception){
   	Application->MessageBox(exception.Message.c_str(),Reconst_smes55_5.c_str(),MB_OK|MB_ICONSTOP);
	  AllowExpansion=false;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReport::tvMainDblClick(TObject *Sender)
{
	btOkClick(this);
}
//---------------------------------------------------------------------------
// Add KAS 24.02.2001 ***********************************************************
// Проверяет есть ли файл на диске
AnsiString Control_Exist_File(long FID)
{
    long IdForm = FID;
    char fName[25];
    char fDateChange[25];
    long fSize;
    HANDLE hFile = NULL;
    LPTSTR lpMsgBuf;

    FILETIME lpLastWriteTimeFile; 	// address of last write time in file Excel
    DWORD dwLowDateTime, dwHighDateTime;



   dmMain->oqCursor->Params->Clear();
   dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectGroupReport_ConExF_p(:par1,:par2);end;";
   dmMain->oqCursor->ParamByName("par2")->DataType=ftCursor;
   dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;

   dmMain->oqCursor->ParamByName("par1")->AsInteger=IdForm;


   dmMain->oqCursor->Execute();
   strcpy(fName , dmMain->oqCursor->FieldByName("FNAME")->AsString.c_str());
   strcpy(fDateChange , dmMain->oqCursor->FieldByName("FDATECHANGE")->AsString.c_str());
   fSize= dmMain->oqCursor->FieldByName("FSIZE")->AsInteger;
   if(dmMain->oqCursor->Eof){
    throw Exception(Reconst_smes55_16);
   }
   else{
        char *ptrCh = fDateChange;
        // Разбираем дату файла в базе
        if(!sscanf(ptrCh," %u",&dwLowDateTime))
            throw Exception(Reconst_smes55_17);

        ptrCh = strchr(fDateChange,'-');
        if(!sscanf(++ptrCh," %u",&dwHighDateTime))
            throw Exception(Reconst_smes55_17);


        //Ищем файл
        ExFileFullName = ExFilePuth + fName;
        //===== 06.07.2005 Frizyuk A.M. Start
        if (tFileListCnt)
          try
          { int iFName  = tFileListCnt->IndexOf(ExFileFullName);
            if (iFName < 0)
            { tFileListCnt->AddObject(ExFileFullName, (TObject *)0);
            }
            else
            { tFileListCnt->Objects[iFName] = (TObject *)(((int)tFileListCnt->Objects[iFName]) + 1);
              AnsiString  fExt  = ExtractFileExt(ExFileFullName);
              ExFileFullName.SetLength(ExFileFullName.Length() - fExt.Length());
              ExFileFullName  += IntToStr(((int)tFileListCnt->Objects[iFName])) + fExt;
            }
          }
          catch (Exception &e)
          { ExFileFullName = ExFilePuth + fName;
          }
        //===== 06.07.2005 Frizyuk A.M. Finish
        bool FE = FileExists(ExFileFullName);
        // MessageDlg( IntToStr(FE), mtInformation, TMsgDlgButtons() << mbOK, 0);
        if(FE)
        {
            hFile=CreateFile(ExFileFullName.c_str(),GENERIC_READ,FILE_SHARE_READ,NULL,
                OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL);
            if(hFile==INVALID_HANDLE_VALUE)
            {
                hFile=NULL;
                FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
                    NULL,GetLastError(),MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                    (LPTSTR) &lpMsgBuf, 0, NULL);
                throw Exception(lpMsgBuf);
            }
            bool Get_Date = GetFileTime(hFile, NULL, NULL, &lpLastWriteTimeFile);
            if(!Get_Date)
            {
                hFile=NULL;
                FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
                    NULL,GetLastError(),MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                    (LPTSTR) &lpMsgBuf, 0, NULL);
                CloseHandle(hFile);
                throw Exception(lpMsgBuf);
            }
            CloseHandle(hFile);

            if((dwLowDateTime!=lpLastWriteTimeFile.dwLowDateTime) || (dwHighDateTime!=lpLastWriteTimeFile.dwHighDateTime))
            {
                // выкачиваем файл
                ReadFile_Ex_from_DB(IdForm, fSize, ExFileFullName, dwLowDateTime, dwHighDateTime);
            }
        }
        else
        {
            // выкачиваем файл
            ReadFile_Ex_from_DB(IdForm, fSize, ExFileFullName, dwLowDateTime, dwHighDateTime);
        }
    }
    return ExFileFullName;
}
//---------------------------------------------------------------------------
// Читает текст файла из БД и создает этот файл на диске с именем FileName
void ReadFile_Ex_from_DB(long FID, long F_Size, AnsiString FileName, DWORD dwLowDateTime, DWORD dwHighDateTime)
{
  LPTSTR lpMsgBuf;
//  char *ch = NULL;
  HANDLE hFile = NULL;
  DWORD k;
  FILETIME lpLastWriteTimeFile; 	// address of last write time in file Excel

  lpLastWriteTimeFile.dwLowDateTime = dwLowDateTime;
  lpLastWriteTimeFile.dwHighDateTime = dwHighDateTime;
  
 //dmMain->oqFormsEX->Params->Clear();
  dmMain->oqFormsEX->SQL->Text="SELECT FILEBODY FROM "+SchemeName+"FORMS_EX WHERE FID=:par1";
 // dmMain->oqFormsEX->SQL->Text=" begin "+SchemeName+"saa_select_pg.SelectGroupReport_ReadFile_p(:par1,:par2);end; " ;
 // dmMain->oqFormsEX->ParamByName("par2")->DataType=ftCursor;
 // dmMain->oqFormsEX->ParamByName("par2")->ParamType=ptOutput;
  
  dmMain->oqFormsEX->ParamByName("par1")->AsInteger=FID;
  dmMain->oqFormsEX->Execute();
	if(dmMain->oqFormsEX->Eof){
    throw Exception(Reconst_smes55_19);
  }else{
          // Создаем файл на диске
  //  ch = new char[F_Size];
  //  memcpy(ch,oqMonitorFILEBODY->Value.c_str(),F_Size);
    hFile=CreateFile(FileName.c_str(),GENERIC_WRITE,FILE_SHARE_READ,NULL,
                     CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL);
    if(hFile==INVALID_HANDLE_VALUE)
      {
        hFile=NULL;
         FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
                        NULL,GetLastError(),MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                       (LPTSTR) &lpMsgBuf, 0, NULL);
        throw Exception(lpMsgBuf);
      }
//    WriteFile(hFile,ch,F_Size,&k,NULL);
   WriteFile(hFile,((TBlobField *)dmMain->oqFormsEX->FieldByName("FILEBODY"))->Value.c_str(),F_Size,&k,NULL);
   // WriteFile(hFile,dmMain->oqFormsEX->FieldByName("FILEBODY")->AsString.c_str(),F_Size,&k,NULL);
    dmMain->oqFormsEX->Close();
//    delete ch;

    if(!SetFileTime(hFile, &lpLastWriteTimeFile, &lpLastWriteTimeFile, &lpLastWriteTimeFile)){
       hFile=NULL;
       FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
                     NULL,GetLastError(),MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                    (LPTSTR) &lpMsgBuf, 0, NULL);
       CloseHandle(hFile);
       throw Exception(lpMsgBuf);
     }
    CloseHandle(hFile);
  }
}
//---------------------------------------------------------------------------
int WriteFile_Ex_to_DB(long FID, AnsiString FileName, bool autoReplace) // Закачивает файл FileName в базу
{
  LPTSTR lpMsgBuf;
  long F_Size;
  char *ch=NULL;
  int res=0;
  HANDLE hFile = NULL;
  DWORD k;
  FILETIME lpLastWriteTimeFile; 	// address of last write time in file Excel

  if(!FID)
    throw Exception(Reconst_smes55_20);

  char fName[25];
  char fDateChange[25];

    // Открываем файл
  try{
    hFile=CreateFile(FileName.c_str(),GENERIC_READ,FILE_SHARE_READ,NULL,
        OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL);
    if(hFile==INVALID_HANDLE_VALUE){
        hFile=NULL;
        FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
            NULL,GetLastError(),MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
            (LPTSTR) &lpMsgBuf, 0, NULL);
        throw Exception(lpMsgBuf);
    }
    F_Size = GetFileSize(hFile,NULL);
    if(!GetFileTime(hFile, NULL, NULL, &lpLastWriteTimeFile)){
        hFile=NULL;
        FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
            NULL,GetLastError(),MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
            (LPTSTR) &lpMsgBuf, 0, NULL);
        CloseHandle(hFile);
        throw Exception(lpMsgBuf);
    }
    ch = new char[F_Size];
    ReadFile(hFile,ch,F_Size,&k,NULL);
    CloseHandle(hFile);
    // Проверяем есть ли в базе файл для этой формы
 
    dmMain->oqCursor->Params->Clear();
    dmMain->oqCursor->SQL->Text="begin "+SchemeName+"saa_select_pg.SelectGroupReport_FileName_p(:par1,:par2);end;";
    dmMain->oqCursor->ParamByName("par2")->DataType=ftCursor;
    dmMain->oqCursor->ParamByName("par2")->ParamType=ptOutput;

    dmMain->oqCursor->ParamByName("par1")->AsInteger=FID;

    dmMain->oqCursor->Execute();
    strcpy(fName,dmMain->oqCursor->FieldByName("FNAME")->AsString.c_str());
    sprintf(fDateChange, "%u-%u", lpLastWriteTimeFile.dwLowDateTime, lpLastWriteTimeFile.dwHighDateTime);
    AnsiString fNameStr = fName;
    FileName = ExtractFileName(FileName);
    StrCopy(fName, FileName.c_str());
    //GRB ADD 16.04.2020 - test trouble ODAC
    dmMain->quMain->Params->Clear();
    //END ADD 
    if(!dmMain->oqCursor->Eof){
        if(autoReplace || MessageDlg(Reconst_smes55_21+fNameStr+Reconst_smes55_22+FileName+"?",mtConfirmation, TMsgDlgButtons() << mbYes << mbNo, 0) == mrYes){ // Заменяем файл
          dmMain->quMain->SQL->Text="UPDATE "+SchemeName+"FORMS_EX SET FNAME=:par2, FDATECHANGE=:par3, FSIZE=:par4, FILEBODY=:par5 WHERE FID=:par1";
          dmMain->quMain->ParamByName("par1")->AsInteger= FID;
          dmMain->quMain->ParamByName("par2")->AsString = fName;
          dmMain->quMain->ParamByName("par3")->AsString = fDateChange;
          dmMain->quMain->ParamByName("par4")->AsInteger = F_Size;
          dmMain->quMain->ParamByName("par5")->SetBlobData(ch,F_Size);
          dmMain->quMain->Execute();
          res = 2;
        }
    }else{
        // Заносим файл в базу
        dmMain->quMain->SQL->Text="INSERT INTO "+SchemeName+"FORMS_EX (FID, FNAME, FDATECHANGE, FSIZE, FILEBODY) VALUES(:par1, :par2, :par3, :par4, :par5)";
        dmMain->quMain->ParamByName("par1")->AsInteger= FID;
        dmMain->quMain->ParamByName("par2")->AsString = fName;
        dmMain->quMain->ParamByName("par3")->AsString = fDateChange;
        dmMain->quMain->ParamByName("par4")->AsInteger = F_Size;
        dmMain->quMain->ParamByName("par5")->SetBlobData(ch,F_Size);
        dmMain->quMain->Execute();
        res = 1;
    }
    dmMain->orases->Commit();
    delete []ch;
    return res;
  }catch(Exception &e){
    if(ch)
      delete []ch;
    throw;
  }
}
//---------------------------------------------------------------------------
// end Add **********************************************************************
void __fastcall TfmSelectGroupReport::FormKeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
  if(Key==13&&Shift==TShiftState()&&btOk->CanFocus()){
    Key=0;
    btOk->SetFocus();
    keybd_event(13, (byte) MapVirtualKey(13, 0), 0, 0);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReport::acFindExecute(TObject *Sender)
{
//GRB ADD 09.03.2021 -добавляем вызов 2-х сеттеров, определяющих контекст задачи
 fmFP->setContext(0);//и не ноль и не один а внутри файндпоинта по переданному GroupsAndPoints ставить контекст по 000 так или сяк ну или 0
 fmFP->setGroupsAndPoints(true);
 //end add
 //Задачи 1 на базе калина
 //GRB ADD 16.04.2021
 if ((fd->IdFormTree == 1001)||(fd->IdFormTree == 1123)||(fd->IdFormTree == 1009)||(fd->IdFormTree == 1002)||(fd->IdFormTree == 1066)
        ||(fd->IdFormTree == 2145)||(fd->IdFormTree == 2146)||(fd->IdFormTree == 2147)||(fd->IdFormTree == 2148)){
        fmFP->setContext(1);
        fmFP->setGroupsAndPoints(true);
 }
if ((fd->IdFormTree == 1122)||(fd->IdFormTree == 1080)||(fd->IdFormTree == 1068)||(fd->IdFormTree == 1067)){
        fmFP->setContext(1);
        fmFP->setGroupsAndPoints(true);
}
if ((fd->IdFormTree == 1069)||(fd->IdFormTree == 1086)){
        fmFP->setContext(0);
        fmFP->setGroupsAndPoints(false);

}
if ((fd->IdFormTree == 2239)||(fd->IdFormTree == 2240)){
        fmFP->setContext(1);
        fmFP->setGroupsAndPoints(false);
}
 if ((fd->IdFormTree == 1072)||(fd->IdFormTree == 1071)||(fd->IdFormTree == 1073)||(fd->IdFormTree == 1074)||(fd->IdFormTree == 1070)
        ||(fd->IdFormTree == 2225)||(fd->IdFormTree == 2226)||(fd->IdFormTree == 2228)||(fd->IdFormTree == 2229)){
        fmFP->setContext(1);
        fmFP->setGroupsAndPoints(true);
        }
 if ((fd->IdFormTree == 1089)||(fd->IdFormTree == 1091)||(fd->IdFormTree == 1090)||(fd->IdFormTree == 1092)||(fd->IdFormTree == 1093)
        ||(fd->IdFormTree == 2149)||(fd->IdFormTree == 2150)||(fd->IdFormTree == 2151)||(fd->IdFormTree == 2152)){
        fmFP->setContext(1);
        fmFP->setGroupsAndPoints(true);
        }
   if ((fd->IdFormTree == 3834)||(fd->IdFormTree == 2108)){
        fmFP->setContext(0);
        fmFP->setGroupsAndPoints(false);
   }
  if ((fd->IdFormTree == 4211)||(fd->IdFormTree == 4220)||(fd->IdFormTree == 4212)){
        fmFP->setContext(1);
        fmFP->setGroupsAndPoints(false);
  }
  if (fd->IdFormTree == 4213){
        fmFP->setContext(1);
        fmFP->setGroupsAndPoints(true);
  }
  if ((fd->IdFormTree == 4214)||(fd->IdFormTree == 4215)||(fd->IdFormTree == 4216)||(fd->IdFormTree == 4217)||(fd->IdFormTree == 4218)
        ||(fd->IdFormTree == 4219)||(fd->IdFormTree == 1081)){
        fmFP->setContext(1);
        fmFP->setGroupsAndPoints(false);
  }
  if ((fd->IdFormTree == 3525)||(fd->IdFormTree == 3526)||(fd->IdFormTree == 3527)||(fd->IdFormTree == 3528)||(fd->IdFormTree == 3529)
        ||(fd->IdFormTree == 3530)){
        fmFP->setContext(1);
        fmFP->setGroupsAndPoints(false);
  }
//END ADD
  fmFP->ShowModal();
}
//---------------------------------------------------------------------------
//установка активного узла при поиске формы
  void __fastcall TfmSelectGroupReport::WM_SetActiveNode(TMessage& Message)
{
  fd->IdGroup = (long)(Message.LParam);
 //GRB ADD 16.04.2021
 bool wasfd_IsPoints = fd->IsPoints;
 //Задача 1
 if ((fd->IdFormTree == 1001)||(fd->IdFormTree == 1123)||(fd->IdFormTree == 1009)||(fd->IdFormTree == 1002)||(fd->IdFormTree == 1066)
        ||(fd->IdFormTree == 2145)||(fd->IdFormTree == 2146)||(fd->IdFormTree == 2147)||(fd->IdFormTree == 2148)){
          int whereFind = (long)(Message.WParam);
          if (whereFind==0){
                fd->IsPoints = 1;
                TfmSelectReportForm::GetSelectedTree(tvMain,fd);
                fd->IsPoints = wasfd_IsPoints;
                return;
                }
          else {
                fd->IsPoints = 0;
                TfmSelectReportForm::GetSelectedTree(tvMain,fd);
                fd->IsPoints = wasfd_IsPoints;
                return;
          }
        }
        //задача 2.1-2.4
   if ((fd->IdFormTree == 1122)||(fd->IdFormTree == 1080)||(fd->IdFormTree == 1068)||(fd->IdFormTree == 1067)){
             int whereFind = (long)(Message.WParam);
          if (whereFind==0){
                fd->IsPoints = 1;
                TfmSelectReportForm::GetSelectedTree(tvMain,fd);
                fd->IsPoints = wasfd_IsPoints;
                return;
                }
          else {
                fd->IsPoints = 0;
                TfmSelectReportForm::GetSelectedTree(tvMain,fd);
                fd->IsPoints = wasfd_IsPoints;
                return;
          }

   }

  if ((fd->IdFormTree == 1069)||(fd->IdFormTree == 1086)){
        TfmSelectReportForm::GetSelectedTree(tvMain,fd);
        return;
  }
  if ((fd->IdFormTree == 2239)||(fd->IdFormTree == 2240)){
        fd->IsPoints = 0;
        TfmSelectReportForm::GetSelectedTree(tvMain,fd);
        fd->IsPoints = wasfd_IsPoints;
        return;
  }
  if ((fd->IdFormTree == 1072)||(fd->IdFormTree == 1071)||(fd->IdFormTree == 1073)||(fd->IdFormTree == 1074)||(fd->IdFormTree == 1070)
        ||(fd->IdFormTree == 2225)||(fd->IdFormTree == 2226)||(fd->IdFormTree == 2228)||(fd->IdFormTree == 2229)){
        int whereFind = (long)(Message.WParam);
          if (whereFind==0){
                fd->IsPoints = 1;
                TfmSelectReportForm::GetSelectedTree(tvMain,fd);
                fd->IsPoints = wasfd_IsPoints;
                return;
                }
          else {
                fd->IsPoints = 0;
                TfmSelectReportForm::GetSelectedTree(tvMain,fd);
                fd->IsPoints = wasfd_IsPoints;
                return;
          }

  }
   if ((fd->IdFormTree == 1089)||(fd->IdFormTree == 1091)||(fd->IdFormTree == 1090)||(fd->IdFormTree == 1092)||(fd->IdFormTree == 1093)
        ||(fd->IdFormTree == 2149)||(fd->IdFormTree == 2150)||(fd->IdFormTree == 2151)||(fd->IdFormTree == 2152)){
        int whereFind = (long)(Message.WParam);
          if (whereFind==0){
                fd->IsPoints = 1;
                TfmSelectReportForm::GetSelectedTree(tvMain,fd);
                fd->IsPoints = wasfd_IsPoints;
                return;
                }
          else {
                fd->IsPoints = 0;
                TfmSelectReportForm::GetSelectedTree(tvMain,fd);
                fd->IsPoints = wasfd_IsPoints;
                return;
          }

   }
    if ((fd->IdFormTree == 3834)||(fd->IdFormTree == 2108)){
        TfmSelectReportForm::GetSelectedTree(tvMain,fd);
        return;
    }
    if ((fd->IdFormTree == 4211)||(fd->IdFormTree == 4220)||(fd->IdFormTree == 4212)){
        fd->IsPoints = 0;
        TfmSelectReportForm::GetSelectedTree(tvMain,fd);
        fd->IsPoints = wasfd_IsPoints;
        return;
    }
    if (fd->IdFormTree == 4213){
        int whereFind = (long)(Message.WParam);
          if (whereFind==0){
                fd->IsPoints = 1;
                TfmSelectReportForm::GetSelectedTree(tvMain,fd);
                fd->IsPoints = wasfd_IsPoints;
                return;
                }
          else {
                fd->IsPoints = 0;
                TfmSelectReportForm::GetSelectedTree(tvMain,fd);
                fd->IsPoints = wasfd_IsPoints;
                return;
          }

    }
    if ((fd->IdFormTree == 4214)||(fd->IdFormTree == 4215)||(fd->IdFormTree == 4216)||(fd->IdFormTree == 4217)||(fd->IdFormTree == 4218)
        ||(fd->IdFormTree == 4219)||(fd->IdFormTree == 1081)){
        fd->IsPoints = 0;
        TfmSelectReportForm::GetSelectedTree(tvMain,fd);
        fd->IsPoints = wasfd_IsPoints;
        return;
    }
    if ((fd->IdFormTree == 3525)||(fd->IdFormTree == 3526)||(fd->IdFormTree == 3527)||(fd->IdFormTree == 3528)||(fd->IdFormTree == 3529)
        ||(fd->IdFormTree == 3530)){
        fd->IsPoints = 0;
        TfmSelectReportForm::GetSelectedTree(tvMain,fd);
        fd->IsPoints = wasfd_IsPoints;
        return;
    }

  //END ADD
  TfmSelectReportForm::GetSelectedTree(tvMain,fd);

}
//---------------------------------------------------------------------------
void __fastcall TfmSelectGroupReport::FormClose(TObject *Sender,
      TCloseAction &Action)
{
  delete fmFP;
}
//---------------------------------------------------------------------------


