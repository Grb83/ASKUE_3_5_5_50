//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#include <string.h>
#pragma hdrstop
#include "MonitorForm.h"
#include "InteriorFullDat.h"
#include "unDataMod.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
__fastcall TInteriorFullDat::TInteriorFullDat(TComponent* Owner,TSplitterForm *aSP,
	TFormDescr *aFD,Classes::TNotifyEvent OnProgr):TInterior(Owner,aSP,aFD,OnProgr )

{
	if( dynamic_cast<TWinControl*>(Owner) )
	{
try
{

		ClonePressed=false;
		NamesClones=new TStringList();


		//Загружаем из базы полное описание таблицы
		OnProgressBarStepBy(NULL);//0
		formDescr();
		OnProgressBarStepBy(this);//10


   	datOracle = new TCloneItem[(Clones+1)*SubColumns()*(RowCount+2)];
		//Загружаем из базы данные

    selectData( dmMain->oqInterCursor );
		OnProgressBarStepBy(this);//30
    //GRB ADD - подписываем на перерисовку
    ((TBaseMonitorForm*)Owner)->OnResize=FormShow;

}
catch(Exception &e)
{
		delete NamesClones;
		if(datOracle)
			delete [] datOracle;
		throw;
}
catch(...)
{
		delete NamesClones;
		if(datOracle)
			delete [] datOracle;
		throw(Exception(Reconst_smes110_1));
}
	}
	else
		throw(Exception(Reconst_smes110_2));
}
//---------------------------------------------------------------------------
__fastcall TInteriorFullDat::~TInteriorFullDat(void)
{
    if(DrawTable) delete DrawTable;
	if(NamesClones) delete NamesClones;
	if(datOracle) delete [] datOracle;
}
//---------------------------------------------------------------------------
//Снятие со SplitterFom таблицы и графика, вызываемтся при обновлении TBaseMonitorForm
void __fastcall TInteriorFullDat::Destroy(void)
{
	SplitterForm->RemoveChild(DrawTable);
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::Place(void)
{
    TFormSetupMonitors*psm;
    try
    {
        psm = new TFormSetupMonitors(Application);

		//Создаем таблицу
		DrawTable=new TDrawTable(Owner);
		//Укладываем таблицу  в SplitterForm
		SplitterForm->AddChild(NULL,DrawTable,alRight);
    SplitterForm->SplitFormResize(NULL);

	        // ======== Форматирование таблицы
		TPopupMenu *pPopup=
		   (dynamic_cast<TBaseMonitorForm*>(Owner))->PopupMenu;
		DrawTable->PopupMenu=pPopup;
		DrawTable->PopupMenu->AutoPopup=false;
	 	DrawTable->OnEnter=OnClickPanel;
		DrawTable->OnMouseDown=DrawTableMouseDown;
		DrawTable->OnMouseMove=DrawTableMouseMove;
		DrawTable->OnMouseUp=DrawTableMouseUp;
		DrawTable->OnKeyUp=OnKeyUp;
		DrawTable->Options>>goRangeSelect>>goFixedVertLine>>goFixedHorzLine>>goVertLine>>goHorzLine;
		DrawTable->DefaultDrawing=false;

		if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
			DrawTable->RowsHeight=AnsiString("#")+psm->EditColorHeight->Text;
		else
			DrawTable->RowsHeight=AnsiString("#")+psm->EditBWHeight->Text;

		OnProgressBarStepBy(this);//40
		if( fd->VerticalSplit )
		{
			if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
				DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthDigit->Text;
			else
				DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthDigit->Text;
			clonesInColumns();
		}
		else
		{
			if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
				DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthName->Text+
					AnsiString("#")+psm->EditColorWidthDigit->Text;
			else
				DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthName->Text+
					AnsiString("#")+psm->EditBWWidthDigit->Text;
			clonesInRows();
		}


    GetColorToSell(DrawTable,datOracle,Clones+1+!fd->SummGroup,SubColumns(),RowCount+1);
		OnProgressBarStepBy(this);//80



        //chig
        if (fd->IsMemParActualForClones)
        {
            //Восстановление состояния скроллинга
            DrawTable->TopRow = fd->TableTopRow;
            //e Восстановление состояния скроллинга
            fd->IsMemParActualForClones = FALSE;
        }
        if ( fd->IsMemParActualForProf )
        {
            //Восстановление состояния скроллинга
            DrawTable->LeftCol = fd->TableLeftCol;
            //e Восстановление состояния скроллинга
            fd->IsMemParActualForProf = FALSE;
        }
        //e
        //26.08.2021 GRB ADD
        if (GetContainedWidthStatusFromReg())
        AutoSizeNameOnly (DrawTable);
        //end ADD

        delete psm;
    }
    catch(Exception&e)
    {
		if(DrawTable){
                   SplitterForm->RemoveChild(DrawTable);
		   delete DrawTable;
    		   DrawTable=NULL;
                }
	   delete psm;
		throw(Exception(Reconst_smes105_2));
   }

}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::dataInColumns(void)
{
 AnsiString FullData;
 long clones=Clones;
	//long columns=SubColumns();
	int iClones, jColumns;
	char *ptr, tmpData[20];
	TCloneItem* ptrDatOracle;
    //Подготавливаем переменные поля для приема
    if(fd->SummGroup)
	    clones++;

    //столбцы для названий точек(времени) и и подколонок
    ColumnsCaption->Clear();
    VT_PrintData->Close();
    VT_PrintData->Clear();
    VT_PrintData->FieldDefs->BeginUpdate();
    VT_PrintData->FieldDefs->Clear();
    VT_PrintData->FieldDefs->Add("RowName", ftString, 50, false);
    VT_PrintData->FieldDefs->Add("SubRowName", ftString, 30, false);
    for(int CC = 1; CC<=clones; CC++) // RowCount+1 - Столбцы для данных
        VT_PrintData->FieldDefs->Add("Data"+IntToStr(CC), ftString, 20, false);
    VT_PrintData->FieldDefs->EndUpdate();
    VT_PrintData->Open();

	ptr = DrawTable->StructStrings->GetArray();
    if(fd->SummGroup)
    {
        jColumns = clones*SubColumns()*(RowCount+1);
        for( iClones=0 ; iClones<jColumns ; ptr+=LenFloat,++iClones )
            if(datOracle[iClones].val!=-MAXFLOAT)

                 {
                       FullData=AnsiString(datOracle[iClones].val);
                        /*  if(FullData.Length()<8)
                            {
                           FullData=FullData.Length()<6?"0"+FullData:FullData;
                           sprintf(ptr,"%s:%s:%s ",FullData.SubString(1,2),FullData.SubString(3,2), FullData.SubString(5,2));
                           }else  */
                             if(FullData.Length()>8)
                            {   sprintf(ptr,"%s:%s:%s ",FullData.SubString(5,2),FullData.SubString(7,2), FullData.SubString(9,2));
                            }else
                           sprintf(ptr,"%s.%s.%s ",FullData.SubString(5,2),FullData.SubString(7,2),FullData.SubString(1,4));
                    }
            else
                *ptr=0;
    }
	else
    {
	    ptrDatOracle=datOracle;
		for( jColumns=0; jColumns <= RowCount; ++jColumns )
		    for( ptrDatOracle+=SubColumns(),iClones=0 ;
			    iClones < clones*SubColumns() ;
                ptr+=LenFloat,++iClones,++ptrDatOracle )
			    if(ptrDatOracle->val!=-MAXFLOAT)
             {
                       FullData=AnsiString(ptrDatOracle->val);
                        /*  if(FullData.Length()<8)
                            {
                           FullData=FullData.Length()<6?"0"+FullData:FullData;
                           sprintf(ptr,"%s:%s:%s ",FullData.SubString(1,2),FullData.SubString(3,2), FullData.SubString(5,2));
                           }else   */
                               if(FullData.Length()>8)
                            {   sprintf(ptr,"%s:%s:%s ",FullData.SubString(5,2),FullData.SubString(7,2), FullData.SubString(9,2));
                            }else
                               sprintf(ptr,"%s.%s.%s ",FullData.SubString(5,2),FullData.SubString(7,2),FullData.SubString(1,4));
                    }

                else
			        *ptr=0;
    }
    for(int i=0; i<RowCount+1; i++)
        for(int j=0; j<SubColumns(); j++)
        {
            VT_PrintData->Append();
            for(int DC=1, k=!fd->SummGroup; k<clones+!fd->SummGroup; k++, DC++)
            {
                if(datOracle[k*SubColumns()+j+i*(clones+!fd->SummGroup)*SubColumns()].val!=-MAXFLOAT)

                  {
                       FullData=AnsiString(datOracle[k*SubColumns()+j+i*(clones+!fd->SummGroup)*SubColumns()].val);
                         /* if(FullData.Length()<8)
                            {
                           FullData=FullData.Length()<6?"0"+FullData:FullData;
                           sprintf(tmpData,"%s:%s:%s ",FullData.SubString(1,2),FullData.SubString(3,2), FullData.SubString(5,2));
                           }else */
                             if(FullData.Length()>8)
                            {   sprintf(tmpData,"%s:%s:%s ",FullData.SubString(5,2),FullData.SubString(7,2), FullData.SubString(9,2));
                            }else
                               sprintf(tmpData,"%s.%s.%s ",FullData.SubString(5,2),FullData.SubString(7,2),FullData.SubString(1,4));
                    }
                else
                    *tmpData=0;
                VT_PrintData->Fields->FieldByName("Data"+IntToStr(DC))->AsString = AnsiString(tmpData);
            }
            VT_PrintData->Post();
        }
}

//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::clonesInColumns(void)
{
	long clones=Clones;
	long columns=SubColumns();
	int iClones,jColumns;
	double stepProfile;

 // int gtz=TimeZona;

    if(Clones==1 && (long)NamesClones->Objects[0]==(long)NamesClones->Objects[1])
    {
       AnsiString s;
       s=DrawTable->ColsWidth;
       for( jColumns=0 ; jColumns < columns; ++jColumns )
	  s+=DrawTable->ColsWidth;

       s+="#0";
       DrawTable->ColsWidth=s;
    }
	DrawTable->RowCount=RowCount+2+(columns>1?1:0);
	if(fd->SummGroup)
	    clones++;
    DrawTable->ColCount=1+clones*columns;

 if(fd->SummGroup)
    DrawTable->FixedCols=1+(columns>1?columns:1);
 else
    DrawTable->FixedCols=1;

    DrawTable->FixedRows=2+(columns>1?1:0);

	//Подготавливаем переменные поля для приема
	int *TempStruct=new int[clones*columns];

	for(iClones=0;iClones<clones*columns;++iClones)
	   TempStruct[iClones]=LenFloat;
	DrawTable->StructStrings->Rebuild(RowCount+1,clones*columns,TempStruct);
	dataInColumns();
	delete []TempStruct;

	//Добавляем заголовки клонов

	DrawTable->StaticStrings->Clear();
	if(fd->SummGroup){
           DrawTable->StaticStrings->Add(NamesClones->Strings[0]);
           ColumnsCaption->Add(NamesClones->Strings[0]);
        }
	for( iClones=1; iClones<=Clones ; ++iClones ){
	   DrawTable->StaticStrings->Add(NamesClones->Strings[iClones]);
           ColumnsCaption->Add(NamesClones->Strings[iClones]);
        }
	//Добавляем заголовки колонок под клонами
    VT_PrintData->First();
    if(columns>1)
	    for( iClones=1; iClones<=clones ; ++iClones )
		    for( jColumns=0; jColumns<columns ; ++jColumns )
			    DrawTable->StaticStrings->Add(GetSubColumnsNames(jColumns));
    //Добавляем нумерацию профиля
	TDateTime tempDate;
	AnsiString formatDate;
	AnsiString formatDateSum;

	unsigned short year,month,day;
	unsigned short hour, minute, sec, msec;
  int ind=0;

	fd->DateTime.DecodeDate( &year, &month, &day);
	switch(fd->StepProfile)
	{
	case TFormDescr::stpDay:
		day=1;
		stepProfile=1.0;
		formatDate="dd/mm";
		formatDateSum="mmmm";
		tempDate=TDateTime(year,month,day);
		break;
	case TFormDescr::stpMonth:
		day=1;
		month=1;
		stepProfile=31.0;
		formatDate="mmmm";
		formatDateSum="yyyy";
		tempDate=TDateTime(year,month,day);
		break;
	case TFormDescr::stpHour:
		hour=1;
    if(RowCount>24*(60/PowerProfile))//25 час
    {
    stepProfile=1.0/(RowCount-60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(RowCount-60/PowerProfile);
    }
    else if(RowCount<24*(60/PowerProfile))//23 час
    {
    stepProfile=1.0/(RowCount+60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(RowCount+60/PowerProfile);
    }
    else
    {
    	stepProfile=1.0/RowCount;
     tempDate=TDateTime(year,month,day)+hour/(double)RowCount;
     }

		formatDate="t";
		formatDateSum="dd/mm/yy";

		break;
	case TFormDescr::stpMinute:
		fd->DateTime.DecodeTime(&hour, &minute, &sec, &msec);
		stepProfile=StepPROFILE*1.157407407407e-5;
		formatDate="t";
		formatDateSum=Reconst_smes105_4;
                //GRB COMMENT 15.07.2019 - баг с построением от произвольной минуты (0:30) -> (0:14:24+3 мин = 17 мин) при нажатии на точку в графике профиля - фиксим аналогично как в Interior2xDrawTableChart.cpp
                tempDate=TDateTime(year,month,day)+hour/24.0+minute/1440.0+stepProfile;
                //END GRB
                //GRB ADD
                //tempDate=TDateTime(year,month,day)+stepProfile;
                //END GRB ADD
		break;
	}

    VT_PrintData->First();

	DrawTable->StaticStrings->Add(tempDate.FormatString(formatDateSum));

  ind=0;
    for(int iii = 0; iii<columns; iii++)
    {
        VT_PrintData->Edit();
        VT_PrintData->Fields->FieldByName("RowName")->AsString = tempDate.FormatString(formatDateSum);
        VT_PrintData->Fields->FieldByName("SubRowName")->AsString = GetSubColumnsNames(iii);
        VT_PrintData->Next();
    }
	for( jColumns=1; jColumns<=RowCount ; ++jColumns )
	{
        for(int iii = 0; iii<columns; iii++)
        {
            VT_PrintData->Edit();
            VT_PrintData->Fields->FieldByName("RowName")->AsString = tempDate.FormatString(formatDate);
            VT_PrintData->Fields->FieldByName("SubRowName")->AsString = GetSubColumnsNames(iii);
            VT_PrintData->Next();
        }
       DrawTable->StaticStrings->Add(tempDate.FormatString(formatDate));
       tempDate+=stepProfile;
     //---------------
      tempDate.DecodeTime(&hour, &minute, &sec, &msec);
      //GRB ADD 15.07.2019
     if (fd->StepProfile == TFormDescr::stpMinute){
     if((IsShiftTimeZona)&&(IsDayShiftMonth(fd,10))&&!ind&&(hour==(4-TimeZona))
      && (minute==(StepPROFILE/60)))
       {
           ind=60/(StepPROFILE/60);   //25 час
           tempDate=tempDate-ind*stepProfile;
       }
     /*if((IsShiftTimeZona)&&(IsDayShiftMonth(fd,3))&&!ind&&(hour==(3-TimeZona))
      && (minute==(StepPROFILE/60)))
       {
           ind=60/(StepPROFILE/60);   //23 час
           tempDate=tempDate+ind*stepProfile;

       }*/
    }/*END ADD*/else{
      if((IsShiftTimeZona)&&RowCount>24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?5-TimeZona:4-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))


       {
           ind=60/PowerProfile;     //25 час
           tempDate=tempDate-ind*stepProfile;

       }

     if((IsShiftTimeZona)&&RowCount<24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?4-TimeZona:3-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;     //23 час
           tempDate=tempDate+ind*stepProfile;

       }

    }
    }
	//Формируем описание структуры для шапки всей таблицы опираясь
	//на количество клонов. Шапка занимает две строки.
	DrawTable->TabStrings->Clear();
	AnsiString temp;
	if( columns>1)
		temp="c15 m0x09  0x1807";
	else
		temp="c15 m0x09  0x180f";
	iClones=1;
	if(fd->SummGroup)
	{
		++iClones;
		if( columns>1)
		{
			temp+="# t2 b $m0x05  0x100b";
			for( jColumns=1; jColumns<=columns-2 ; ++jColumns )
				temp+="#<m0x05  0x100a";
			temp+="#<m0x05  0x100e";
		}
		else
			temp+="# t2 b $m0x05  0x100f";
	}
	for( ; iClones<=clones ; ++iClones )
	{
		if(columns>1)
		{
	      temp+="# t8 b- $m0x05  0x100b";
			for( jColumns=1; jColumns<=columns-2 ; ++jColumns )
				temp+="#<m0x05  0x100a";
			temp+="#<m0x05  0x100e";
        }
		else
		   temp+="# t8 b- $m0x05  0x100f";
    }
	DrawTable-> TabStrings->Add(temp);

	if(columns>1)
	{
		temp="^m0x09  0x180d";
		for( iClones=1; iClones<=clones ; ++iClones )
			for( jColumns=1; jColumns<=columns ; ++jColumns )
				temp+="#$m0x09  0x100f";
		DrawTable-> TabStrings->Add(temp);
	}

	//Формируем описание структуры для переменных строк всей таблицы опираясь
	//на количество клонов.
	iClones=1;
	if(fd->SummGroup)
	{
		temp="c15 t2 b $m0x05  0x100f";
		++iClones;
		if(columns>1)
		{
			temp+="#c28 t42 b- &m0x01  0x800d";
			for( jColumns=1; jColumns<=columns-1 ; ++jColumns )
				temp+="# &m0x01  0x800c";
		}
		else
			temp+="#c28 t42 b- &m0x01  0x800c";

		for( ; iClones<=clones ; ++iClones )
		{
			if(columns>1)
			{
				temp+="#c36 t8 &m0x01  0x800d";
				for( jColumns=1; jColumns<=columns-1 ; ++jColumns )
					temp+="# &m0x01  0x800c";
			}
			else
				temp+="#c36 t8 &m0x01  0x800c";
		}
		DrawTable-> TabStrings->Add(temp);
	}
	else
	{
		temp="c15 t2 b $m0x05  0x100f";
		iClones=1;
		for( ; iClones<=clones ; ++iClones )
		{
			if(columns>1)
			{
	   		temp+="#c36 t8 b- &m0x01  0x800d";
				for( jColumns=1; jColumns<=columns-1 ; ++jColumns )
					temp+="# &m0x01  0x800c";
			}
			else
				temp+="#c36 t8 b-  &m0x01  0x800c";
		}
		DrawTable-> TabStrings->Add(temp);
    }
	temp="c15 t8 $m0x05  0x100f";
	iClones=1;
	if(fd->SummGroup)
	{
		++iClones;
		if(columns>1)
		{
			temp+="#c36 &m0x01  0x800d";
			for( jColumns=1; jColumns<=columns-1 ; ++jColumns )
				temp+="# &m0x01  0x800c";
		}
		else
			temp+="#c36 &m0x01  0x800c";
	}
	for( ; iClones<=clones ; ++iClones )
	{
		if(columns>1)
		{
			temp+="#c5 &m0x01  0x800d";
			for( jColumns=1; jColumns<=columns-1 ; ++jColumns )
				temp+="# &m0x01  0x800c";
		}
		else
			temp+="#c5 &m0x01  0x800c";
	}
	DrawTable-> TabStrings->Add(temp);
	DrawTable->UpdateTabStrings();
}

//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::dataInRows(void)
{
  AnsiString FullData;
	long clones=Clones;
	long columns=SubColumns();
	int iClones,jColumns;
	char *ptr, tmpData[20];
	TCloneItem *ptrDataOra;
    long ptrDatOracle;

    //столбцы для названий точек(времени) и и подколонок
    ColumnsCaption->Clear();
    VT_PrintData->Close();
    VT_PrintData->Clear();
    VT_PrintData->FieldDefs->BeginUpdate();
    VT_PrintData->FieldDefs->Clear();
    VT_PrintData->FieldDefs->Add("RowName", ftString, 50, false);
    VT_PrintData->FieldDefs->Add("SubRowName", ftString, 30, false);
    for(int CC = 1; CC<=RowCount+1; CC++) // RowCount+1 - Столбцы для данных
       VT_PrintData->FieldDefs->Add("Data"+IntToStr(CC), ftString, 20, false);

    VT_PrintData->FieldDefs->EndUpdate();
    VT_PrintData->Open();
	//Подготавливаем переменные поля для приема
	if(fd->SummGroup)
	    clones++;
    ptr = DrawTable->StructStrings->GetArray();
	if(fd->SummGroup)
	{
        for( jColumns=0; jColumns < clones*columns ; ++jColumns )
        {
            ptrDatOracle = jColumns;
            iClones=0;
            for(; iClones < RowCount+1; )
            {
                if(datOracle[ptrDatOracle].val != -MAXFLOAT)
                    {
                       FullData=AnsiString(datOracle[ptrDatOracle].val);
                         /* if(FullData.Length()<8)
                            {
                           FullData=FullData.Length()<6?"0"+FullData:FullData;
                           sprintf(ptr,"%s:%s:%s ",FullData.SubString(1,2),FullData.SubString(3,2), FullData.SubString(5,2));
                           }else */
                             if(FullData.Length()>8)
                            {   sprintf(ptr,"%s:%s:%s ",FullData.SubString(5,2),FullData.SubString(7,2), FullData.SubString(9,2));
                            }else
                               sprintf(ptr,"%s.%s.%s ",FullData.SubString(5,2),FullData.SubString(7,2),FullData.SubString(1,4));
                    }
                    else
                    *ptr=0;

                ptr+=LenFloat;
                iClones++;
                ptrDatOracle += clones*columns;
            }
        }
    }
	else
	{
        for( jColumns=0; jColumns < clones*columns ; ++jColumns )
            for( ptrDatOracle = columns+jColumns,iClones=0 ;
                iClones <= RowCount ;
                ptr+=LenFloat,++iClones,ptrDatOracle+=(clones+1)*columns )
            {
                if(datOracle[ptrDatOracle].val != -MAXFLOAT)
                    {
                       FullData=AnsiString(datOracle[ptrDatOracle].val);
                         /* if(FullData.Length()<8)
                            {
                           FullData=FullData.Length()<6?"0"+FullData:FullData;
                           sprintf(ptr,"%s:%s:%s ",FullData.SubString(1,2),FullData.SubString(3,2), FullData.SubString(5,2));
                           }else  */
                             if(FullData.Length()>8)
                            {   sprintf(ptr,"%s:%s:%s ",FullData.SubString(5,2),FullData.SubString(7,2), FullData.SubString(9,2));
                            }else
                               sprintf(ptr,"%s.%s.%s ",FullData.SubString(5,2),FullData.SubString(7,2),FullData.SubString(1,4));
                    }

                else
                    *ptr=0;



            }
    }


    // Заполняем таблицу для QR
    int m = 0;

    for( jColumns=0; jColumns < (clones-m)*columns ; ++jColumns )
    {
        VT_PrintData->Append();
        for( ptrDatOracle=jColumns+(fd->SummGroup?0:columns),iClones=1; iClones<=RowCount+1; ++iClones,ptrDatOracle+=(clones+(!fd->SummGroup))*columns )
        {
            if(datOracle[ptrDatOracle].val!=-MAXFLOAT)
            {
                       FullData=AnsiString(datOracle[ptrDatOracle].val);

                        /*  if(FullData.Length()<8)
                            {
                           FullData=FullData.Length()<6?"0"+FullData:FullData;
                           sprintf(tmpData,"%s:%s:%s ",FullData.SubString(1,2),FullData.SubString(3,2), FullData.SubString(5,2));
                           }else */
                               if(FullData.Length()>8)
                            {   sprintf(tmpData,"%s:%s:%s ",FullData.SubString(5,2),FullData.SubString(7,2), FullData.SubString(9,2));
                            }else
                               sprintf(tmpData,"%s.%s.%s ",FullData.SubString(5,2),FullData.SubString(7,2),FullData.SubString(1,4));
                    }

            else
                *tmpData=0;
            VT_PrintData->Fields->FieldByName("Data"+IntToStr(iClones))->AsString = AnsiString(tmpData);
        }
        VT_PrintData->Post();
    }
}

//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::clonesInRows(void)
{
	long clones=Clones;
	long columns=SubColumns();
	int iClones,jColumns,i;
	double stepProfile;

//  int gtz=TimeZona;


    if(Clones==1 && (long)NamesClones->Objects[0]==(long)NamesClones->Objects[1])
	{
		AnsiString s;
		s=DrawTable->RowsHeight;
		for( jColumns=0 ; jColumns < columns; ++jColumns )
			s+=DrawTable->RowsHeight;

		s+="#0";
		DrawTable->RowsHeight=s;
	}
	DrawTable->ColCount=RowCount+2+(columns>1?1:0);
	if(fd->SummGroup)
		++clones;
	DrawTable->RowCount=1+clones*columns;

  DrawTable->FixedCols=2+(columns>1?1:0);

 if(fd->SummGroup)
    DrawTable->FixedRows=1+(columns>1?columns:1);
 else
    DrawTable->FixedRows=1;

    //Подготавливаем переменные поля для приема
	int *TempStruct=new int[RowCount+1];

	for(iClones=0;iClones<=RowCount;++iClones)
		TempStruct[iClones]=LenFloat;
	DrawTable->StructStrings->Rebuild(clones*columns,RowCount+1,TempStruct);
	dataInRows();
	delete []TempStruct;

	//Добавляем нумерацию профиля
	TDateTime tempDate;
	AnsiString formatDate;
	AnsiString formatDateSum;
	unsigned short year,month,day;
	unsigned short hour, minute, sec, msec;
  int ind=0; //VNB 29.09.2008

	fd->DateTime.DecodeDate( &year, &month, &day);
	switch(fd->StepProfile)
	{
	case TFormDescr::stpDay:
		day=1;
		stepProfile=1.0;
		formatDate="dd/mm";
		formatDateSum="mmmm";
		tempDate=TDateTime(year,month,day);
		break;
	case TFormDescr::stpMonth:
		day=1;
		month=1;
		stepProfile=31.0;
		formatDate="mmmm";
		formatDateSum="yyyy";
		tempDate=TDateTime(year,month,day);
		break;
	case TFormDescr::stpHour:
  hour=1;
    if(RowCount>24*(60/PowerProfile)) //25 час
    {
    stepProfile=1.0/(RowCount-60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(RowCount-60/PowerProfile);
    }
    else if(RowCount<24*(60/PowerProfile)) //23 час
    {
    stepProfile=1.0/(RowCount+60/PowerProfile);
    tempDate=TDateTime(year,month,day)+hour/(double)(RowCount+60/PowerProfile);
    }
    else
    {
    stepProfile=1.0/RowCount;
    tempDate=TDateTime(year,month,day)+hour/(double)RowCount;
    }

		formatDate="t";
		formatDateSum="ddddd";

  	break;
	case TFormDescr::stpMinute:
		fd->DateTime.DecodeTime(&hour, &minute, &sec, &msec);
		stepProfile=StepPROFILE*1.157407407407e-5;
		formatDate="t";
		formatDateSum="'Итого'";
                //GRB COMMENT 15.07.2019 - баг с построением от произвольной минуты (0:30) -> (0:14:24+3 мин = 17 мин) при нажатии на точку в графике профиля - фиксим аналогично как в Interior2xDrawTableChart.cpp
                tempDate=TDateTime(year,month,day)+hour/24.0+minute/1440.0+stepProfile;
                //END GRB
                //GRB ADD
                //tempDate=TDateTime(year,month,day)+stepProfile;
                //END GRB ADD
		break;
	}
 ind=0;
	DrawTable->StaticStrings->Clear();
	//if(fd->SummGroup)
	  DrawTable->StaticStrings->Add(tempDate.FormatString(formatDateSum));
    ColumnsCaption->Add(tempDate.FormatString(formatDateSum));

	for( jColumns=1; jColumns<=RowCount ; ++jColumns )
	{
     DrawTable->StaticStrings->Add(tempDate.FormatString(formatDate));
     ColumnsCaption->Add(tempDate.FormatString(formatDate));

     tempDate+=stepProfile;

     tempDate.DecodeTime(&hour, &minute, &sec, &msec);

     if (fd->StepProfile == TFormDescr::stpMinute){
     if((IsShiftTimeZona)&&(IsDayShiftMonth(fd,10))&&!ind&&(hour==(4-TimeZona))
      && (minute==(StepPROFILE/60)))
       {
           ind=60/(StepPROFILE/60);   //25 час
           tempDate=tempDate-ind*stepProfile;
       }
     /*if((IsShiftTimeZona)&&(IsDayShiftMonth(fd,3))&&!ind&&(hour==(3-TimeZona))
      && (minute==(StepPROFILE/60)))
       {
           ind=60/(StepPROFILE/60);   //23 час
           tempDate=tempDate+ind*stepProfile;

       }*/
    }/*END ADD*/ else{
     if((IsShiftTimeZona)&&RowCount>24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?5-TimeZona:4-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;   //25 час
           tempDate=tempDate-ind*stepProfile;

       }
     if((IsShiftTimeZona)&&RowCount<24*(60/PowerProfile)&&!ind&&(hour==(PowerProfile==60?4-TimeZona:3-TimeZona)
      && minute==(PowerProfile==60?0:PowerProfile)))

       {
           ind=60/PowerProfile;   //23 час
           tempDate=tempDate+ind*stepProfile;

       }
    }
    }
	//Добавляем заголовки клонов
    VT_PrintData->First();
	if(fd->SummGroup)
	{
	    DrawTable->StaticStrings->Add(NamesClones->Strings[0]);
		if(columns>1)
            for( jColumns=0; jColumns<columns ; ++jColumns )
            {
                VT_PrintData->Edit();
                DrawTable->StaticStrings->Add(GetSubColumnsNames(jColumns));
                VT_PrintData->Fields->FieldByName("RowName")->AsString = NamesClones->Strings[0];
                VT_PrintData->Fields->FieldByName("SubRowName")->AsString = GetSubColumnsNames(jColumns);
                VT_PrintData->Next();
            }
        else
        {
            VT_PrintData->Edit();
            VT_PrintData->Fields->FieldByName("RowName")->AsString = NamesClones->Strings[0];
            VT_PrintData->Next();
        }
    }
	for( iClones=1; iClones<=Clones ; ++iClones )
	{
	    DrawTable->StaticStrings->Add(NamesClones->Strings[iClones]);
        //Добавляем заголовки колонок под клонами
		if(columns>1)
            for( jColumns=0; jColumns<columns ; ++jColumns )
            {
                VT_PrintData->Edit();
                DrawTable->StaticStrings->Add(GetSubColumnsNames(jColumns));
                VT_PrintData->Fields->FieldByName("RowName")->AsString = NamesClones->Strings[iClones];
                VT_PrintData->Fields->FieldByName("SubRowName")->AsString = GetSubColumnsNames(jColumns);
                VT_PrintData->Next();
            }
        else
        {
            VT_PrintData->Edit();
            VT_PrintData->Fields->FieldByName("RowName")->AsString = NamesClones->Strings[iClones];
            VT_PrintData->Next();
        }
    }

    //Формируем описание структуры для шапки всей таблицы опираясь
	//на количество клонов. Шапка занимает две строки.
	DrawTable->TabStrings->Clear();
    AnsiString temp;
	if(columns>1)
	    temp="c15 m0x09  0x180b # m0x09  0x180e";
    else
	    temp="c15 m0x09  0x180f";
    //if(fd->SummGroup)
	temp+="# t2 b $m0x05  0x100f";
    for( jColumns=1; jColumns<=RowCount ; ++jColumns )
	    temp+="# t8 b- $m0x05  0x100f";

	DrawTable->TabStrings->Add(temp);

    iClones=1;
	if(fd->SummGroup)
	{
	    iClones++;
        if(columns>1)
    	    temp=" t2 b $m0x05  0x1007# t8 b- $m0x09  0x100f#c28 t42 &m0x01  0x800e";
	    else
		    temp=" t2 b $m0x05  0x100f# b- c28 t42 &m0x01  0x800c";
        for( i=1; i<=RowCount ; ++i )
            if(columns>1)
		        temp+="#c36 t8 &m0x01  0x800e";
            else
                temp+="#c36 t8 &m0x01  0x800c";
        DrawTable->TabStrings->Add(temp);

		if(columns>1)
        {
	        for( jColumns=3; jColumns<=columns ; ++jColumns )
            {
                temp="c15 ^m0x05  0x1005# $m0x09  0x100f#c28 t42 b- &m0x01  0x800c";
                for( i=1; i<=RowCount ; ++i )
				    temp+="#c36 t8 &";
                DrawTable->TabStrings->Add(temp);
            }

			temp="c15 ^m0x05  0x100d# $m0x09  0x100f#c28 t42 b- &m0x01  0x800c";
			for( i=1; i<=RowCount ; ++i )
			    temp+="#c36 t8 &";
            DrawTable->TabStrings->Add(temp);
        }
    }
	for( ; iClones<=clones ; ++iClones )
	{
	    if(columns>1)
		{
		    temp="c15 $m0x05  0x1007# $m0x09  0x100f";

			temp+="#c36 &m0x01  0x800e";
			for( i=1; i<=RowCount ; ++i )
			    temp+="#c5 &m0x01  0x800e";
        }
		else
		{
		    temp="c15 $m0x05  0x100f";

			temp+="#c36 &m0x01  0x800c";
            for( i=1; i<=RowCount ; ++i )
		        temp+="#c5 &m0x01  0x800c";
        }
		DrawTable->TabStrings->Add(temp);

		if( columns>1)
		{
		    for( jColumns=3; jColumns<=columns ; ++jColumns )
            {
	            temp="c15 ^m0x05  0x1005# $m0x09  0x100f";
		        //if(fd->SummGroup)
                temp+="#c36 &m0x01  0x800c";
	     		for( i=1; i<=RowCount ; ++i )
		      	    temp+="#c5 &m0x01  0x800c";
                DrawTable->TabStrings->Add(temp);
            }

            temp="c15 ^m0x05  0x100d# $m0x09  0x100f";
            //if(fd->SummGroup)
	     	temp+="#c36 &m0x01  0x800c";
            for( i=1; i<=RowCount ; ++i )
		  	    temp+="#c5 &m0x01  0x800c";
            DrawTable->TabStrings->Add(temp);
        }
    }
    DrawTable->UpdateTabStrings();
}
//---------------------------------------------------------------------------
//Обновление данных из базы
//NameAlert=-1 для обновления в любом случае
void __fastcall TInteriorFullDat::refreshData( int Table,TOraQuery *qwInter )
{

     selectData(qwInter);
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::Invalidate(int Table)
{


		if( fd->VerticalSplit )
			dataInColumns();
	 	else
		 	dataInRows();

		DrawTable->Invalidate();
		OnProgressBarStepBy(NULL);


}

//---------------------------------------------------------------------------

//Получает данные о считываемой таблице
void __fastcall TInteriorFullDat::formDescr( void )
{
  AnsiString SubSelect;
  fd->IdGroup = GroupJump(fd->IdGroup);
	//Заполняем необходимые поля описания формы


	Clones = 0;
  dmMain->oqInterCursor->Params->Clear();
  dmMain->oqInterCursor->SQL->Text=" begin "+SchemeName+"interior_pg.Interior_formDescr_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7); end;";
  dmMain->oqInterCursor->ParamByName("par7")->ParamType=ptOutput;
  dmMain->oqInterCursor->ParamByName("par7")->DataType=ftCursor;

  dmMain->oqInterCursor->ParamByName("par1")->AsInteger=(fd->IsPoints)?1:0;
  dmMain->oqInterCursor->ParamByName("par2")->AsInteger=fd->StepProfile;
  dmMain->oqInterCursor->ParamByName("par3")->AsInteger=fd->IdGroup;
  dmMain->oqInterCursor->ParamByName("par4")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
  dmMain->oqInterCursor->ParamByName("par5")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
  dmMain->oqInterCursor->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);

  dmMain->oqInterCursor->Execute();
	NamesClones->Clear();
  NamesClones->AddObject(fd->ShortNameGroup,(TObject*)fd->IdGroup);
  while(!dmMain->oqInterCursor->Eof){
    Clones++;
   //	fd->strGroup(dmMain->oqInterCursor->FieldByName("name")->AsString.c_str());
		NamesClones->AddObject(dmMain->oqInterCursor->FieldByName("name")->AsString,(TObject*)dmMain->oqInterCursor->FieldByName("mid")->AsInteger);
    dmMain->oqInterCursor->Next();
  }
  dmMain->oqInterCursor->Close();

	if(!Clones){
		fd->SummGroup=true;
    NamesClones->AddObject(fd->ShortNameGroup,(TObject*)fd->IdGroup);
		Clones=1;
	}
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::selectData(  TOraQuery *qwInter )
{
  unsigned long j,selectRows,clones,rowCount;
  int CountOnProgress=6;
	long iClones,IdGroup;
	AnsiString sql;
	char FirstDate[20], LastDate[20];

	struct TempStruct{
		long Count;
		double A;
    double B;
    char isvalid[32];
    TempStruct(){ZeroMemory(this,sizeof(*this));}
	};
  struct TempStruct *TempDatOracle=NULL;
  short *ind=NULL;
	TCloneItem *pDatOracle;

  try{
    rowCount=RowCount+1;
	  clones=Clones+1;
    pDatOracle=datOracle;
	  for( iClones=0; (unsigned long)iClones<clones*SubColumns()*rowCount ;++iClones,++pDatOracle ){
		  pDatOracle->val=-MAXFLOAT;
      ZeroMemory(pDatOracle->isvalid,sizeof(pDatOracle->isvalid));
    }

    ChoiceOfTimeDiap(FirstDate, LastDate);

    ind = new short[rowCount*IND_CNT];

    TempDatOracle=new struct TempStruct[rowCount*IND_CNT];

    qwInter->Params->Clear();
    qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.interiorfulldat_selectdata_p(:par7, \
                              :par8,:par9,:par10,:par11,:par12,:par13,:par1,:par2,:par3,:par4,:par5,:par6,:par14); end;";

    for(iClones=0; iClones<=Clones; ++iClones){
      IdGroup=(long)NamesClones->Objects[iClones];
      //   -----------------------------------------------------------------------------
      qwInter->ParamByName("par14")->ParamType=ptOutput;
      qwInter->ParamByName("par14")->DataType=ftCursor;

      qwInter->ParamByName("par7")->AsInteger=fd->IsPoints?1:0; ;
      qwInter->ParamByName("par8")->AsInteger=fd->StepProfile;
      qwInter->ParamByName("par9")->AsInteger=fd->CodeTemplate;
      qwInter->ParamByName("par10")->AsString=IntToStr(RowCount);
      qwInter->ParamByName("par11")->AsInteger=fd->bird;

      qwInter->ParamByName("par12")->AsInteger=(int)PowerProfile;
      if(fd->StepProfile==TFormDescr::stpHour)
        qwInter->ParamByName("par13")->AsInteger=24*(60/PowerProfile);
      else
        qwInter->ParamByName("par13")->AsInteger=StepPROFILE;

      //  ---------------------------------------------------------------------------------
      qwInter->ParamByName("par1")->AsString=FirstDate;
      qwInter->ParamByName("par2")->AsString=LastDate;
      qwInter->ParamByName("par3")->AsInteger=IdGroup;
      qwInter->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);
      qwInter->ParamByName("par4")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
      qwInter->ParamByName("par5")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);

      qwInter->Execute();
      int i=0;
      while(!qwInter->Eof&&i<(int)rowCount){
        if(!qwInter->FieldByName("BGroup")->IsNull)
          TempDatOracle[i].Count = qwInter->FieldByName("BGroup")->AsInteger;
        if(!qwInter->FieldByName("AParam")->IsNull){
          ind [1*rowCount+i]=0;
          TempDatOracle[i].A= qwInter->FieldByName("AParam")->AsFloat;}
        else
          ind [1*rowCount+i]=-1;
        if(!qwInter->FieldByName("BParam")->IsNull){
          ind [2*rowCount+i]=0;
          TempDatOracle[i].B= qwInter->FieldByName("BParam")->AsFloat;}
        else
          ind [2*rowCount+i]=-1;
        if(qwInter->FieldByName("decnsour")->AsString.Length()>=2)
          strncpy(TempDatOracle[i].isvalid,qwInter->FieldByName("decnsour")->AsString.c_str(),sizeof(TempDatOracle[i].isvalid));
        if(!qwInter->FieldByName("AParam")->IsNull&&qwInter->FieldByName("test")->IsNull ){
          TempDatOracle[i].A=-MAXFLOAT;
          TempDatOracle[i].B=-MAXFLOAT;
          strcpy(TempDatOracle[i].isvalid,AnsiString("02").c_str());
        }
        qwInter->Next();
        i++;
      }
      qwInter->Close();
      selectRows=i;
    	if( CountOnProgress ){
        --CountOnProgress;
        OnProgressBarStepBy(this);//20
      }

      for( j=0;j<selectRows;++j){
        pDatOracle=datOracle+(iClones*SubColumns()+TempDatOracle[j].Count*((Clones+1)*SubColumns()));

        if(ind[1*rowCount+j]>-1) pDatOracle->val=TempDatOracle[j].A;
          strncpy(pDatOracle->isvalid,TempDatOracle[j].isvalid,sizeof(pDatOracle->isvalid));
        if(ind[2*rowCount+j]>-1) (pDatOracle+1)->val = TempDatOracle[j].B;
          strncpy((pDatOracle+1)->isvalid,TempDatOracle[j].isvalid,sizeof(pDatOracle->isvalid));
      }
    } // end for(iClones=0; iClones<=Clones; ++iClones){
    delete [] TempDatOracle;
    delete []ind;
    while(CountOnProgress){
      --CountOnProgress;
		  OnProgressBarStepBy(this);//20
    }
  }catch(Exception &e){
    if(TempDatOracle)
      delete []TempDatOracle;
    if(ind)
      delete ind;
    while(CountOnProgress){
      --CountOnProgress;
		  OnProgressBarStepBy(this);//20
    }
    throw;
  }
}
//---------------------------------------------------------------------------
bool __fastcall TInteriorFullDat::setSplit(void)
{
 TFormSetupMonitors*psm = new TFormSetupMonitors(Application);
	fd->VerticalSplit=!fd->VerticalSplit;
	if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
		DrawTable->RowsHeight=AnsiString("#")+psm->EditColorHeight->Text;
	else
		DrawTable->RowsHeight=AnsiString("#")+psm->EditBWHeight->Text;

	if(fd->VerticalSplit)
	{
		if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
			DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthDigit->Text;
		else
			DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthDigit->Text;
		clonesInColumns();
		DrawTable->SetFocus();

	}
	else
	{
		if( dynamic_cast<TBaseMonitorForm*>(Owner)->isSmallFont )
			DrawTable->ColsWidth=AnsiString("#")+psm->EditColorWidthName->Text+
				AnsiString("#")+psm->EditColorWidthDigit->Text;
		else
			DrawTable->ColsWidth=AnsiString("#")+psm->EditBWWidthName->Text+
				AnsiString("#")+psm->EditBWWidthDigit->Text;
		clonesInRows();

	}


 	SplitterForm->SplitFormResize(NULL);
   delete psm;
   GetColorToSell(DrawTable,datOracle,Clones+1+!fd->SummGroup,SubColumns(),RowCount+1);
   return fd->VerticalSplit;
}
//---------------------------------------------------------------------------
AnsiString __fastcall TInteriorFullDat::GetSubColumnsNames(int n)
{
	static AnsiString staticNameColumns[]={"Дата","Время"};
	return staticNameColumns[n];
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::clickDialog(long ACol, long ARow )
{
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::clickComposition(long ColPressed, long RowPressed  )
{
  if(ColPressed==0){//разложение по профилю
    if( DrawTable )
      fd->TableTopRow = DrawTable->TopRow;
    fd->IsMemParActualForClones = TRUE;
		TDateTime tempDate;
		unsigned short year,month,day;
		fd->DateTime.DecodeDate( &year, &month, &day);

		if(SubColumns()==1)
			RowPressed++;
    RowPressed--;
		if(RowPressed>=2){//Декомпозиция по профилю
      switch(fd->StepProfile){
        case TFormDescr::stpMonth:
          if(fd->EnableControls.Contains(TFormDescr::ctrlDay)){
            fd->DateTime=TDateTime(year,(unsigned short)(RowPressed-1),1);
            fd->StepProfile=TFormDescr::stpDay;
            refreshForm();
          }
          break;
        case TFormDescr::stpDay:
          if(fd->EnableControls.Contains(TFormDescr::ctrlHour)){
            fd->DateTime=TDateTime(year,month,1)+(unsigned short)(RowPressed-2);
            fd->StepProfile=TFormDescr::stpHour;
            refreshForm();
          }
          break;
        case TFormDescr::stpHour:
          if(fd->EnableControls.Contains(TFormDescr::ctrlMinute)){
            fd->DateTime=TDateTime(year,month,day)+(RowPressed-2)/(double)RowCount;
            fd->StepProfile=TFormDescr::stpMinute;
            refreshForm();
          }
          break;
        case TFormDescr::stpMinute:
          break;
      }
		}else{//Композиция по профилю
  		switch(fd->StepProfile){
    		case TFormDescr::stpMonth:
		    	break;
    		case TFormDescr::stpDay:
			    if(fd->EnableControls.Contains(TFormDescr::ctrlMonth)){
    				fd->DateTime=TDateTime(year,1,1);
		    		fd->StepProfile=TFormDescr::stpMonth;
				    refreshForm();
    			}
		    	break;
    		case TFormDescr::stpHour:
		    	if(fd->EnableControls.Contains(TFormDescr::ctrlDay)){
    				fd->DateTime=TDateTime(year,month,1);
		    		fd->StepProfile=TFormDescr::stpDay;
				    refreshForm();
    			}
		    	break;
    		case TFormDescr::stpMinute:
		    	if(fd->EnableControls.Contains(TFormDescr::ctrlHour)){
    				fd->DateTime=TDateTime(year,month,day);
		    		fd->StepProfile=TFormDescr::stpHour;
				    refreshForm();
    			}
		    	break;
      }
    }
	} //end if(ColPressed==0)
	if( RowPressed==0 && fd->EnableControls.Contains(TFormDescr::ctrlGroup)){  	//Разложение по клонам
    long IdGroup,j;
    if( DrawTable )
      fd->TableLeftCol = DrawTable->LeftCol;
    fd->IsMemParActualForProf = TRUE;

    ColPressed=(ColPressed-1)/SubColumns();
    if( !fd->SummGroup )
      ColPressed++;

    IdGroup=0;
    if(ColPressed==0){
      if(fd->IdGroup==fd->IdGroupJump){//***************** Для списков
        fd->IdGroup = fd->IdGroupList; // Перешли на предприятие
        fd->IdGroupJump = 0;
        fd->IdGroupList = 0;
      }
      if(fd->IdGroup==fd->CeilingIdGroup)
        return;

      dmMain->qwInter->Params->Clear();
      dmMain->qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.Interior_clickComp1_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7); end;";
      dmMain->qwInter->ParamByName("par7")->ParamType=ptOutput;
      dmMain->qwInter->ParamByName("par7")->DataType=ftCursor;

      dmMain->qwInter->ParamByName("par1")->AsInteger=(fd->IsPoints)?1:0;
      dmMain->qwInter->ParamByName("par2")->AsInteger=fd->StepProfile;
      dmMain->qwInter->ParamByName("par3")->AsInteger=fd->IdGroup;
      dmMain->qwInter->ParamByName("par4")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
      dmMain->qwInter->ParamByName("par5")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
      dmMain->qwInter->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);
      dmMain->qwInter->Execute();

      IdGroup=dmMain->qwInter->FieldByName("IdGroup")->AsInteger;
      dmMain->qwInter->Close();
    }else
      IdGroup=(long)NamesClones->Objects[ColPressed];

    //***************** Для списков *********************************************************************************
    IdGroup = GroupJump(IdGroup);
    if(!IdGroup)
      return;
    //*************************************************************************************************************
    if( IdGroup==0 || IdGroup==fd->IdGroup )
	    return;

    dmMain->qwInter->Params->Clear();
    dmMain->qwInter->SQL->Text=" begin "+SchemeName+"interior_pg.Interior_clickComp2_p(:par1,:par2,:par3,:par4,:par5,:par6,:par7); end;";
    dmMain->qwInter->ParamByName("par7")->ParamType=ptOutput;
    dmMain->qwInter->ParamByName("par7")->DataType=ftCursor;

    dmMain->qwInter->ParamByName("par1")->AsInteger=(fd->IsPoints)?1:0;
    dmMain->qwInter->ParamByName("par2")->AsInteger=fd->StepProfile;
    dmMain->qwInter->ParamByName("par3")->AsInteger=IdGroup;
    dmMain->qwInter->ParamByName("par4")->AsInteger=fd->GetPeriodForYearStart(fd->DateTime);
    dmMain->qwInter->ParamByName("par5")->AsInteger=fd->GetPeriodForYearFinish(fd->DateTime);
    dmMain->qwInter->ParamByName("par6")->AsInteger=fd->GetPeriod(fd->DateTime);
    dmMain->qwInter->Execute();
    if( !dmMain->qwInter->Eof ){// Вставка
      fd->NameGroup=dmMain->qwInter->FieldByName("Name")->AsString;
    	fd->ShortNameGroup=dmMain->qwInter->FieldByName("ShortName")->AsString;
	    fd->IdGroup=IdGroup;
      fd->SummGroup=(dmMain->qwInter->FieldByName("GROUP_TOTAL")->AsString=="y");
      dmMain->qwInter->Close();
      refreshForm();
    }else
      dmMain->qwInter->Close();
  }
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::OnClickPanel(System::TObject* Sender)
{
  TBaseMonitorForm* f=dynamic_cast<TBaseMonitorForm*>(Owner);
  //GRB CHANGE 20.09.2021
  /*if(f)
    f->FormActivate(Sender);*/
    if (f){
        f->FormActivate(Sender);
        if (GetContainedWidthStatusFromReg())
                AutoSizeNameOnly (DrawTable);
    }
  //END ADD
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::OnKeyUp(TObject *Sender, WORD &Key,
	TShiftState Shift)
{
#define Sender ((TDrawTable*)Sender)
	if( Key==93 && Shift==TShiftState() )
	{
		TRect Rect=Sender->CellRect(Sender->Col,Sender->Row);
		POINT p;
		p.x=Rect.Right;
		p.y=Rect.Bottom;
		p=Sender->ClientToScreen(p);
		Sender->PopupMenu->Popup(p.x,p.y);
	}
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::DrawTableMouseDown(TObject *Sender,
	TMouseButton Button, TShiftState Shift, int X, int Y)
{
#define Sender ((TDrawTable*)Sender)
	TDrawTable::SAttrCell * pAtrCell;
	int ACol, ARow;
	TShiftState leftShift;
	TShiftState rightShift;
	leftShift<<ssLeft;
	rightShift<<ssRight;

	if( (Button==mbLeft && Shift==leftShift )||//нажата только левая кнопка мыши
		(Button==mbRight && Shift==rightShift) )//нажата только правая кнопка мыши
		;
	else
	{
		if( ClonePressed )
		{
			((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->
				MarginEdge=EDGE_RAISED;
			Sender->InvalidCell( ColPressed, RowPressed );
			ClonePressed=false;
		}
		ShiftPressed= TShiftState();
		return;
	}
	ShiftPressed=Shift;

	Sender->MouseToCell( X, Y, ACol, ARow );
	if( ACol==-1 || ARow==-1 )
	{
		ShiftPressed= TShiftState();
		return;
	}
	pAtrCell=(TDrawTable::SAttrCell *)Sender->GetParentCellAttr( ACol, ARow );
	if( pAtrCell->styleCell==TDrawTable::SAttrCell::cellStatic && pAtrCell->MarginEdge==EDGE_RAISED )
	{
		ClonePressed=true;
		pAtrCell=(TDrawTable::SAttrCell *)Sender->GetCellAttr( ACol, ARow );
		ColPressed=ACol;
		RowPressed=ARow;
		if( pAtrCell->styleCell!=TDrawTable::SAttrCell::cellStatic )
		{
			ColPressed-=LOWORD(pAtrCell->IndexData);
			RowPressed-=HIWORD(pAtrCell->IndexData);
		}
		((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge=EDGE_SUNKEN;
		Sender->InvalidCell( ColPressed, RowPressed );
	}
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::DrawTableMouseMove(TObject *Sender,
	TShiftState Shift, int X, int Y)
{
#define Sender ((TDrawTable*)Sender)
	TDrawTable::SAttrCell * pAtrCell;
	int ACol, ARow;
	TDrawTable::SAttrCell tempAttr;
	if( ClonePressed==false )
		return;
	Sender->MouseToCell( X, Y, ACol, ARow );
	if( ACol==-1 || ARow==-1 )
		pAtrCell=&tempAttr;
	else
		pAtrCell=(TDrawTable::SAttrCell *)Sender->GetParentCellAttr( ACol, ARow );
	if( pAtrCell->styleCell==TDrawTable::SAttrCell::cellStatic )
	{
		pAtrCell=(TDrawTable::SAttrCell *)Sender->GetCellAttr( ACol, ARow );
		if( pAtrCell->styleCell!=TDrawTable::SAttrCell::cellStatic )
		{
			ACol-=LOWORD(pAtrCell->IndexData);
			ARow-=HIWORD(pAtrCell->IndexData);
		}
		if( ACol!=ColPressed || ARow!=RowPressed )
		{
		if(((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge!=EDGE_RAISED)
		{
			((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge=EDGE_RAISED;
			Sender->InvalidCell( ColPressed, RowPressed );
		}
		}
		else
		{
		if(((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge!=EDGE_SUNKEN)
		{
			((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge=EDGE_SUNKEN;
			Sender->InvalidCell( ColPressed, RowPressed );
		}
		}
	}
	else
		if(((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge!=EDGE_RAISED)
		{
			((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge=EDGE_RAISED;
			Sender->InvalidCell( ColPressed, RowPressed );
		}
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::DrawTableMouseUp(TObject *Sender,
	TMouseButton Button, TShiftState Shift, int X, int Y)
{
#define Sender ((TDrawTable*)Sender)
	TDrawTable::SAttrCell * pAtrCell;
	int ACol, ARow;

	if( ShiftPressed == TShiftState() )
		return;

	Sender->MouseToCell( X, Y, ACol, ARow );
	if( ACol==-1 || ARow==-1 )
	{
		ShiftPressed= TShiftState();
		ClonePressed=false;
		return;
	}
	if( ClonePressed )
	{
	pAtrCell=(TDrawTable::SAttrCell *)Sender->GetParentCellAttr( ACol, ARow );
	if( pAtrCell->styleCell==TDrawTable::SAttrCell::cellStatic )
	{
		pAtrCell=(TDrawTable::SAttrCell *)Sender->GetCellAttr( ACol, ARow );
		if( pAtrCell->styleCell!=TDrawTable::SAttrCell::cellStatic )
		{
			ACol-=LOWORD(pAtrCell->IndexData);
			ARow-=HIWORD(pAtrCell->IndexData);
		}
		((TDrawTable::SAttrCell *)Sender->GetCellAttr( ColPressed, RowPressed ))->MarginEdge=EDGE_RAISED;
		Sender->InvalidCell( ColPressed, RowPressed );
		if( ACol==ColPressed && ARow==RowPressed )
		{
			//Произошел щелчок по разложению профиля или клона
			if( !fd->VerticalSplit )
			{
				ColPressed=ARow;
				RowPressed=ACol;
			}
			if( ShiftPressed == ( TShiftState()<<ssLeft ))
				//Вывод диалога
				clickDialog(ColPressed, RowPressed );
			else
				//Композиция или декомпозиция
				clickComposition(ColPressed, RowPressed );
		}
	}
	ClonePressed=false;
	}
	else//Если клон не нажимался
		if( ShiftPressed == ( TShiftState()<<ssRight ) && Sender->PopupMenu )
		{
			POINT p;
			p.x=X;
			p.y=Y;
			p=Sender->ClientToScreen(p);
			Sender->FocusCell( ACol, ARow );
			Sender->PopupMenu->Popup(p.x,p.y);
		}
	ShiftPressed =TShiftState();
#undef Sender
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::PrintTable()
{
    AnsiString RepTitle;
    TPrintDrawTable *PrintTable = new TPrintDrawTable(this);
    PrintTable->PrintTable(dynamic_cast<TBaseMonitorForm*>(Owner)->Caption, dynamic_cast<TBaseMonitorForm*>(Owner)->LabelComment->Caption, ColumnsCaption, VT_PrintData,
    fd->VerticalSplit?FormSetupMonitors->EditColorWidthName->Text.ToInt()+50:FormSetupMonitors->EditColorWidthDigit->Text.ToInt(),
    fd->VerticalSplit?FormSetupMonitors->EditColorWidthDigit->Text.ToInt()-10:FormSetupMonitors->EditColorWidthName->Text.ToInt(),1,fd);
    delete PrintTable;
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::SaveTableToFile(TSaveDialog *aSaveDialog)
{
    aSaveDialog->Title = Reconst_smes110_13;
    aSaveDialog->FileName = Reconst_smes110_14;
    aSaveDialog->DefaultExt = "xls";
    aSaveDialog->Filter = Reconst_smes110_15;
    if(aSaveDialog->Execute()){
        AnsiString RepTitle;
        TPrintDrawTable *PrintTable = new TPrintDrawTable(this);
        PrintTable->SaveTableToFile(dynamic_cast<TBaseMonitorForm*>(Owner)->Caption, dynamic_cast<TBaseMonitorForm*>(Owner)->LabelComment->Caption, ColumnsCaption, VT_PrintData,
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthName->Text.ToInt()+50:FormSetupMonitors->EditColorWidthDigit->Text.ToInt(),
        fd->VerticalSplit?FormSetupMonitors->EditColorWidthDigit->Text.ToInt()-10:FormSetupMonitors->EditColorWidthName->Text.ToInt(),1,aSaveDialog->FileName,0);
        delete PrintTable;
    }
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::ChoiceOfTimeDiap( char *FirstDate, char *LastDate)
{
   unsigned short year, month, day;
   unsigned short hour, minute, sec, msec;
   fd->DateTime.DecodeDate(&year, &month, &day);
   switch(fd->StepProfile)
   {
      case TFormDescr::stpMonth:

         strcpy( FirstDate,(TDateTime(year, 1, 1)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
         strcpy( LastDate,TDateTime(year+1, 1, 1).FormatString(DateTimeFormat).c_str());
        break;
      case TFormDescr::stpDay:

         strcpy( FirstDate,(TDateTime(year, month, 1)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
         strcpy( LastDate,(TDateTime(year, month, 1)+RowCount).FormatString(DateTimeFormat).c_str());
        break;
      case TFormDescr::stpHour:

         strcpy( FirstDate,(TDateTime(year, month, day)+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
         strcpy( LastDate,(TDateTime(year, month,day)+1).FormatString(DateTimeFormat).c_str());
        break;
      case TFormDescr::stpMinute:
      
         fd->DateTime.DecodeTime(&hour, &minute, &sec, &msec);
         strcpy( FirstDate,(TDateTime(year, month, day)+hour/24.0+minute/1440.0+1.157407407407e-5).FormatString(DateTimeFormat).c_str());
         strcpy( LastDate,(TDateTime(year, month,day)+(hour+minute/60.0+LenPROFILE/3600.0)/24.0).FormatString(DateTimeFormat).c_str());
        break;
   }
}
//---------------------------------------------------------------------------


void __fastcall TInteriorFullDat::GetColorToSell(TDrawTable*dt, TCloneItem*pClone,
   int cntClones, int cntColumns, int cntRows)
{

    long varIndex = 0;

    TDrawTable::SAttrCell* pAttr;

  //  int flag=0;
    try{



     for(int i=0; i<(fd->VerticalSplit?dt->RowCount:dt->ColCount); i++)

      for(int j=0; j<(fd->VerticalSplit?dt->ColCount:dt->RowCount); j++)
        {

            pAttr = fd->VerticalSplit?
                (TDrawTable::SAttrCell*)dt->GetCellAttr(j,i):
                (TDrawTable::SAttrCell*)dt->GetCellAttr(i,j);
            if(pAttr && pAttr->styleCell==TDrawTable::SAttrCell::cellVar){
                if(varIndex >= cntClones*cntColumns*cntRows){
                    throw Exception(Reconst_smes101_5);
                }


           if(!fd->VerticalSplit&&!fd->SummGroup&&(varIndex%(dt->RowCount-1+cntColumns)==0))varIndex+=cntColumns;
                 if(fd->VerticalSplit&&!fd->SummGroup&&(varIndex%(dt->ColCount-1+cntColumns)==0))varIndex+=cntColumns;


           if(pClone[ varIndex].isvalid[0]=='\0')  pAttr->BackgroundColor=clWhite;
           else
           {
           if(pClone[ varIndex].val!= -MAXFLOAT &&StrToInt(pClone[ varIndex].isvalid[1])==0)
                                  pAttr->BackgroundColor=clYellow;

           if(pClone[ varIndex].val!= -MAXFLOAT &&StrToInt(pClone[ varIndex].isvalid[1])==1)
                                  pAttr->BackgroundColor=clWhite;

           if(pClone[ varIndex].val == -MAXFLOAT)
            if(pClone[ varIndex].isvalid[0]!='\0'&& StrToInt(pClone[ varIndex].isvalid[1])==2)
                                  pAttr->BackgroundColor=clRed;
                     else
                                  pAttr->BackgroundColor=clWhite;
           }
           if(pAttr->FontColor==clWhite) pAttr->FontColor=clBlack;

               varIndex++;
     

         }
     
     }
    }catch(Exception&e){
        Application->ShowException(&e);
    }
}
//-------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------
//GRB ADD 15.07.2019  - является ли дата в pfd->DateTime днём перевода времени за monthNumber
//-------------------------------------------------------------------------------
bool __fastcall TInteriorFullDat::IsDayShiftMonth (TFormDescr *pfd, int monthNumber){      //Октаябрь - 10, Март - 3
   unsigned short year,month,day;
   pfd->DateTime.DecodeDate( &year, &month, &day);

  unsigned short year_leap,month_leap,day_leap;
  pfd->DateTime.DecodeDate(&year_leap,&month_leap,&day_leap);

  if((IsShiftTimeZona)&&(month_leap==monthNumber)&&( pfd->DateTime.DayOfWeek()==1&&31-day<7))
        return true;
  return false;
}
//-------------------------------------------------------------------------------
//---------------------------------------------------------------------------
//-------------------------------------------------------------------------------
//GRB ADD 26.08.2021 - два метода для автоформатирования по содержимому фиксированых колонок - исправление бага с обрезанием длинных имён в колонках
//---------------------------------------------------------------------------
void __fastcall  TInteriorFullDat::AutoSizeColGRB (TDrawTable* tsg, int columnIndex){
        int i,w,WMax;
        TFont *wasFont;
        TFont* regFont;
        try{
        WMax = atoi(tsg->ColsWidth.c_str());
        wasFont = tsg->Canvas->Font;
        regFont = GetActiveFont4MonitorFromReg();
        if (regFont!=NULL){
                tsg->Canvas->Font = regFont;
        }
        delete regFont;
        regFont = NULL;
        tsg->Canvas->Font->Style = tsg->Canvas->Font->Style << fsBold;
        for (int i = 0; i < tsg->RowCount-1; i++){
                AnsiString a_val = NamesClones->Strings[i];//tsg->GetEditText[columnIndex][i];
                w = tsg->Canvas->TextWidth(a_val);
                if (w > WMax) WMax = w;
        }
        }catch (Exception &ex){
        tsg->ColWidths[columnIndex] = WMax + 8;
        tsg->Canvas->Font = wasFont;
        try{
        delete regFont;
        regFont = NULL;
        }catch (Exception &ex){}
        }
        tsg->ColWidths[columnIndex] = WMax + 8;
        tsg->Canvas->Font = wasFont;
}
//---------------------------------------------------------------------------
void __fastcall TInteriorFullDat::AutoSizeNameOnly (TDrawTable* tsg){
                AutoSizeColGRB (tsg, 0);
}
//---------------------------------------------------------------------------
TFont * __fastcall TInteriorFullDat::GetActiveFont4MonitorFromReg (){
    TFormSetupMonitors *psm;
    TFont *retFont;
    try
    {
        retFont = new TFont();
        psm = new TFormSetupMonitors(Application);
        retFont->Name = psm->PanelColorTable->Font->Name;
        retFont->Size = psm->PanelColorTable->Font->Size;
        delete psm;
        return retFont;

    }catch (Exception &ex){
        delete psm;
        //Смелое предположение - так типа по дефолту
        retFont->Name = "MS Sans Serif";
        retFont->Size = 8;
        return retFont;
    }


}
//---------------------------------------------------------------------------
//END ADD
void __fastcall TInteriorFullDat::FormShow(TObject *Sender){
         if (GetContainedWidthStatusFromReg())
                AutoSizeNameOnly (DrawTable);
}
//---------------------------------------------------------------------------
bool __fastcall TInteriorFullDat::GetContainedWidthStatusFromReg(){
         TFormSetupMonitors *psm;
         bool ret = false;
         try{
         psm = new TFormSetupMonitors(Application);
         if (psm->RadioGroupColWidthName->ItemIndex == 1) ret = true;
         else ret = false;
         delete psm;
         }catch (Exception &ex){
                delete psm;
                return false;
         }
         return ret; 
}
//---------------------------------------------------------------------------
