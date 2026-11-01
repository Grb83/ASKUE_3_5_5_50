//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#include "Interior2xDrawTableChart.h"
#include "FormDescr.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
__fastcall TFormDescr::TFormDescr()
//:IsPoints(false)
{

  IdFormTree=0;
	CodeTemplate=0;
	IdGroup=0;
	PercentSplit=0;
	SummGroup=false;
  ZeroMemory(FAddParam,sizeof(FAddParam));
//  Эту строчечку изменил КАС по просьбе Вештака И.А. для того чтобы при открытии форма разворачивалась горизонтально.
//  Изменение этой строки взад не повлияет на работоспособность программы, системы и в целом всей "рыночной" экономики страны

//  27.06.2002 Кстати это изменение всетаки повлияло на работу некоторых форм

//  Copyright 2001
	VerticalSplit= false;
//        false;//true;   // А вот собственно сама СТРОЧЕЧКА Всего лишь true на false заменил
//добавлено для панели "Перечень отображаемых данных"
        indbird = false;
        bird = 0;
        startmid=0;

	EnableControls.Clear();
	StepProfile=stpMonth;
    //chig
    strcpy( pLProc, "" );
    //e chig

 	DateTime=TDateTime::CurrentDate();

    //chig
	DateTimePar=DateTime-1;

    ColorAttr[ 0 ].Color = clRed;
    ColorAttr[ 1 ].Color = clGreen;
    ColorAttr[ 2 ].Color = clBlue;
    ColorAttr[ 3 ].Color = clYellow;
    ColorAttr[ 4 ].Color = clPurple;
    ColorAttr[ 5 ].Color = clLime;
    for (int i=0; i<MAXGRAFICPICTURE; i++)
        ColorAttr[i].PointId = i+1;

    IsMemParActualForClones = FALSE;
    IsMemParActualForProf = FALSE;
    TableTopRow = 1;
    TableLeftCol = 1;
    //e chig

    NameForm = System::AnsiString(Reconst_smes100_3)+DateTime.DateString();
	NameGroup = NameForm;
	CommentForm = Reconst_smes100_4;
	/*
	Classes::AnsiString NameGroup;
	Classes::AnsiString ShortNameGroup;
	Classes::AnsiString NameAlert;
	*/
}
//---------------------------------------------------------------------------
__fastcall TFormDescr::TFormDescr(TFormDescr& aFD)
{
	*(fdInit*)this=aFD;
}
//---------------------------------------------------------------------------
__fastcall TFormDescr::~TFormDescr()
{
}
//---------------------------------------------------------------------------
TFormDescr& TFormDescr::operator =(TFormDescr& aFD)
{
	*(fdInit*)this=aFD;
    return *this;
	DateTimePar     = aFD.DateTimePar;
	CommentForm     = aFD.CommentForm;
	NameGroup       = aFD.NameGroup;
	ShortNameGroup  = aFD.ShortNameGroup;
  memcpy(FAddParam,aFD.FAddParam,sizeof(FAddParam));
}
//---------------------------------------------------------------------------
int __fastcall TFormDescr::GetPeriod( TDateTime DateTime )
{
//-------------------------------VNB 27.02.2008
   int period=StrToInt(DateTime.FormatString("yyyymm"));
    return period;
    }
//---------------------------------------------------------------------------
 int __fastcall TFormDescr::GetPeriodForYearStart( TDateTime DateTime )
{
//-------------------------------VNB 27.02.2008
    unsigned short year,month,day;
    DateTime.DecodeDate(&year,&month,&day);
    int period=year*100;
    return period;
    }
//---------------------------------------------------------------------------
 int __fastcall TFormDescr::GetPeriodForYearFinish( TDateTime DateTime )
{
//-------------------------------VNB 27.02.2008
    unsigned short year,month,day;
    DateTime.DecodeDate(&year,&month,&day);
    int period=(year+1)*100;
    return period;
    }
//---------------------------------------------------------------------------


bool __fastcall TFormDescr::SaveFormDescr( TStream* ostream )
{
    try{
        long fNewMonitor = -(long)sizeof(fdInit);
        ostream->WriteBuffer(&fNewMonitor, sizeof(fNewMonitor));
        ostream->WriteBuffer((fdInit*)this, sizeof(fdInit));
    }catch(Exception(&e)){
        return false;
    }
    return true;
}
//---------------------------------------------------------------------------
bool __fastcall TFormDescr::LoadFormDescr( TStream* istream )
{
    long isNewMonitor;
    istream->ReadBuffer(&isNewMonitor, sizeof(isNewMonitor));
    if(isNewMonitor < 0){
        if(-isNewMonitor == (long)sizeof(fdInit))
            istream->ReadBuffer((fdInit*)this, -isNewMonitor);
        else{ // Добавить код при изменении структуры
          switch (-isNewMonitor){
            case INITSIZE07022006:
              istream->ReadBuffer((fdInit*)this, INITSIZE07022006);
              ((fdInit*)this)->indbird=0;
              ((fdInit*)this)->bird=0;
              ((fdInit*)this)->startmid=0;
              ZeroMemory(((fdInit*)this)->FAddParam,sizeof(((fdInit*)this)->FAddParam));
              break;
            case INITSIZE18112013:
              istream->ReadBuffer((fdInit*)this, INITSIZE18112013);
              ZeroMemory(((fdInit*)this)->FAddParam,sizeof(((fdInit*)this)->FAddParam));
              break;
            default:
              return false;
          }
        }
        return true;
    }
    try{ // Загрузка монитора старого варианта
		double a;
		char buf[256];
		long len;

		//istream->ReadBuffer( &IdFormTree, sizeof(long) );
        IdFormTree = isNewMonitor;
		istream->ReadBuffer( &CodeTemplate, sizeof(long) );
		istream->ReadBuffer( &IdGroup, sizeof(long) );
		istream->ReadBuffer( &SummGroup, sizeof(bool) );
		istream->ReadBuffer( &VerticalSplit, sizeof(bool) );
		istream->ReadBuffer( &PercentSplit, sizeof(long) );
		istream->ReadBuffer( &len, sizeof(long) );

		istream->ReadBuffer( &a, sizeof(double) );
		DateTime=a;
		if(CodeTemplate!=PL_SQL_REP_F&&CodeTemplate!=PL_SQL_TABLE)
   		DateTime=TDateTime::CurrentDate()+TDateTime(DateTime.TimeString(),TDateTime::Time);

		istream->ReadBuffer( &StepProfile, sizeof(TStepProfie) );

		//chig
		//Верхняя граница времени
		istream->ReadBuffer( &a, sizeof(double) );
		DateTimePar=a;
		//e Верхняя граница времени
		//Настройки цветов
		for ( int i = 0; i < MAXGRAFICPICTURE; i++ )
		{
  			istream->ReadBuffer( &( ColorAttr[ i ].PointId ), sizeof( ColorAttr[ i ].PointId ) );
  			istream->ReadBuffer( &( ColorAttr[ i ].Color ), sizeof( ColorAttr[ i ].Color ) );
   		}
		//e Настройки цветов
		istream->ReadBuffer( &IsMemParActualForClones, sizeof( IsMemParActualForClones ) );
		istream->ReadBuffer( &IsMemParActualForProf, sizeof( IsMemParActualForProf ) );
		istream->ReadBuffer( &TableTopRow, sizeof( TableTopRow ) );
		istream->ReadBuffer( &TableLeftCol, sizeof( TableLeftCol ) );
		//e chig

		buf[0]=0;
		istream->ReadBuffer( &len, sizeof(long) );
		istream->ReadBuffer( buf, min(len,256l) );
		buf[min(len,255l)]=0;
		NameForm=buf;
		len-=256;
		while( len>0 )
		{
			istream->ReadBuffer( buf, min(len,256l) );
			len-=256;
		}

		buf[0]=0;
		istream->ReadBuffer( &len, sizeof(long) );
		istream->ReadBuffer( buf, min(len,256l) );
		buf[min(len,255l)]=0;
		CommentForm=buf;
		len-=256;
		while( len>0 )
		{
			istream->ReadBuffer( buf, min(len,256l) );
			len-=256;
		}

		buf[0]=0;
		istream->ReadBuffer( &len, sizeof(long) );
		istream->ReadBuffer( buf, min(len,256l) );
		buf[min(len,255l)]=0;
		NameGroup=buf;
		len-=256;
		while( len>0 )
		{
			istream->ReadBuffer( buf, min(len,256l) );
			len-=256;
		}

		buf[0]=0;
		istream->ReadBuffer( &len, sizeof(long) );
		istream->ReadBuffer( buf, min(len,256l) );
		buf[min(len,255l)]=0;
		ShortNameGroup=buf;
		len-=256;
		while( len>0 )
		{
			istream->ReadBuffer( buf, min(len,256l) );
			len-=256;
		}

		buf[0]=0;
		istream->ReadBuffer( &len, sizeof(long) );
		istream->ReadBuffer( buf, min(len,256l) );
		buf[min(len,255l)]=0;
		NameAlert=buf;
		len-=256;
		while( len>0 )
		{
			istream->ReadBuffer( buf, min(len,256l) );
			len-=256;
		}

		//chig
		//Имя процедуры
		buf[0]=0;
		istream->ReadBuffer( &len, sizeof(long) );
		istream->ReadBuffer( buf, min(len,256l) );
		buf[min(len,255l)]=0;
		strcpy( pLProc, buf );
		len-=256;
		while( len>0 )
		{
			istream->ReadBuffer( buf, min(len,256l) );
			len-=256;
		}
		//e Имя процедуры
		//e chig

		istream->ReadBuffer( &len, sizeof(long) );
		EnableControls.Clear();
		if( len & 0x00000001)
			EnableControls<<ctrlMonth;
		if( len & 0x00000002)
			EnableControls<<ctrlDay;
		if( len & 0x00000004)
			EnableControls<<ctrlHour;
		if( len & 0x00000008)
			EnableControls<<ctrlMinute;
		if( len & 0x00000010)
			EnableControls<<ctrlCalendar;
		if( len & 0x00000020)
			EnableControls<<ctrlGroup;
 // определение режима отображения панели "тип отображаемых данных"
                if( len & 0x00000007)
                        indbird = true;

		CeilingIdGroup = IdGroup;
		IdGroupList = 0;
		IdGroupJump = 0;
        // Инициализация дополнительных полей
        IsPoints = false;
	}
	catch(Exception &e)
	{
		return false;
	}
	return true;
}
//---------------------------------------------------------------------------
void TFormDescr::strGroup(char *str)
{
// Вставка кода по сохранению порядка расположения подгрупп при их вводе
// KAS  Закоментировал чтобы не убирало цифры перед названиями
/*    	char buf[160],c;
        buf[0]='\0';
        strcpy(buf,str);
        for(int i=0;i<(int)strlen(buf); ){
        	c=*(buf+i);
			if(c==' '|| c=='\t'||c=='\n'||c=='0'||c=='1'||c=='2'||c=='3'||c=='4'||c=='5'||c=='6'||c=='7'||c=='8'||c=='9'){
            	if(*(buf+i+1))
                	strcpy(buf+i,buf+i+1);
				else
                	*(buf+i)=0;
            }
			else {
            	i++;
				break;
            }
        }
        strcpy(str,buf);*/
}
//---------------------------------------------------------------------------

inline void __fastcall TFormDescr::SetNameForm(AnsiString value)
{
    if(AnsiString(nameForm) != value) {
        strcpy(nameForm, value.SubString(1,FNLEN-1).c_str());
    }
}
inline AnsiString __fastcall TFormDescr::GetNameForm()
{
    return nameForm;
}

inline void __fastcall TFormDescr::SetCommentForm(AnsiString value)
{
    if(AnsiString(commentForm) != value) {
        strcpy(commentForm, value.SubString(1,FCMMLEN-1).c_str());
    }
}
inline AnsiString __fastcall TFormDescr::GetCommentForm()
{
    return commentForm;
}

inline void __fastcall TFormDescr::SetNameAlert(AnsiString value)
{
    if(AnsiString(nameAlert) != value) {
        strcpy(nameAlert, value.SubString(1,ANLEN-1).c_str());
    }
}
inline AnsiString __fastcall TFormDescr::GetNameAlert()
{
    return nameAlert;
}

inline void __fastcall TFormDescr::SetDateTime(TDateTime value)
{
    dateTime = value.Val;
}
inline TDateTime __fastcall TFormDescr::GetDateTime()
{
    TDateTime dt;
    try{
        dt.Val = dateTime;
    }catch(Exception&e){
        dt.Val = 0;
    }
    return dt;
}

inline void __fastcall TFormDescr::SetDateTimePar(TDateTime value)
{
    dateTimePar = value.Val;
}
inline TDateTime __fastcall TFormDescr::GetDateTimePar()
{
    TDateTime dt;
    try{
        dt.Val = dateTimePar;
    }catch(Exception&e){
        dt.Val = 0;
    }
    return dt;
}
//---------------------------------------------------------------------------
inline void __fastcall TFormDescr::SetNameGroup(AnsiString value)
{
    if(AnsiString(nameGroup) != value) {
        strcpy(nameGroup,value.SubString(1,GNLEN-1).c_str());
    }
}
inline AnsiString __fastcall TFormDescr::GetNameGroup()
{
    return nameGroup;
}

inline void __fastcall TFormDescr::SetShortNameGroup(AnsiString value)
{
    if(AnsiString(shortNameGroup) != value) {
        strcpy(shortNameGroup, value.SubString(1,SNLEN-1).c_str());
    }
}
inline AnsiString __fastcall TFormDescr::GetShortNameGroup()
{
    return shortNameGroup;
}
//---------------------------------------------------------------------------

