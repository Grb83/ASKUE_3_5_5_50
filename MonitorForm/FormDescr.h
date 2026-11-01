//---------------------------------------------------------------------------
#ifndef FormDescrH
#define FormDescrH
#include <classes.hpp>

#define MAXGRAFICPICTURE           6
// Длина Названия сигнала (размер поля FORMS.NAMEALERT)
#define PLLEN 200
// Длина имени формы (размер поля FORMS.NAMEFORM)
#define FNLEN 210
// Длина комментария к форме (размер поля FORMS.COMMENTFORM)
#define FCMMLEN 210
// Длина Название сигнала по форме (размер поля FORMS.NAMEALERT)
#define ANLEN 60
// Длина имени группы/точки (размер полей GROUPS.NAME или POINTS.NAME)
#define GNLEN 160
// Длина краткого имени группы/точки (размер полей GROUPS.NAME или POINTS.NAME)
#define SNLEN 60
//---------------------------------------------------------------------------
//Для разных модификаций структуры fdInit
#define INITSIZE07022006           1016
#define INITSIZE18112013           1024
//---------------------------------------------------------------------------
#define FDADDPARAMSIZE           32
// Перечень ключевых значений в опсании формы
struct fdInit
{
public:// Описание типов

	// Перечень управляющих компонентов
    /// ВНИМАНИЕ !!! изменение количества элементов в данном типе может привести к изменению размера содержащей структуры.
    /// Поэтому указанное изменение должно быть корректно отслеженно в методе LoadFormDescr (поддержка загрузки мониторов старого типа)
    /// К изменению размера приводит каждый 8+1-й элемент (размер поля EnableControls увеличивается на 1 байт) 
	enum EListEnableControls
	{
    	// Возможность выбора группы
        ctrlGroup =1,
		// Возможность выбора месячной детализации
		ctrlMonth,
		// Возможность выбора суточной детализации
		ctrlDay,
		// Возможность выбора почасовой детализации
		ctrlHour,
		// Возможность выбора поминутной детализации
        ctrlMinute,
		// Возможность выбора даты
		ctrlCalendar,
        // Возможность выбора точки
        ctrlPoint
    };
	// Перечень возможной детализации
	enum EStepProfile
	{
        stpNone=0,
		// Месячная детализация
		stpMonth=12,
		// Суточная детализация
		stpDay=31,
		// Часовая детализация
        stpHour=24,
		// Минутная детализация
        stpMinute=60
    };
	// Тип-множество выбранных управляющих компонентов
	typedef Set<enum EListEnableControls,ctrlGroup,ctrlPoint> TListEnableControls;
	// Тип-выбранная детализация
	typedef enum EStepProfile TStepProfie;
	// Тип-точка со своим цветом
	struct stColorsAttr
	{
		// Цвет
		TColor Color;
		// Ид точки
		int PointId;
	};

public:// Перечень полей

	// Ид формы
	long IdFormTree;
	// Код шаблона
	long CodeTemplate;
	// Ид группы
	long IdGroup;
	// Признак суммы по группе
	bool SummGroup;
	// Признак вертикальной компоновке
	bool VerticalSplit;
    // ????
	long PercentSplit;
	// Выбранная детализация
	TStepProfie StepProfile;
    // Признак выбора по точкам
    bool IsPoints;
	// Хранимая процедура
	char pLProc[PLLEN];
	//Здесь сохраняется перечень точек и соответствующих им цветов для случая отображения графиков
	stColorsAttr ColorAttr[MAXGRAFICPICTURE];
	bool IsMemParActualForClones;
	bool IsMemParActualForProf;
	int TableTopRow;
	int TableLeftCol;
	// Для перехода на списки и обратно
	// Ид группы с которой создали интерьер и выше которой подниматься нельзя
	long CeilingIdGroup;
	// Нужно для перехода от группы к списку
    long IdGroupList;
	// Нужно для перехода от группы к списку
	// Функция редактирования строки имен подгрупп. Предназначена для удаления номера впереди имени.
	// Используется при выводе всех табличных форм мониторов.
	long IdGroupJump;
	// Имя формы
	char nameForm[FNLEN];
	// Комментарий к форме
	char commentForm[FCMMLEN];
	// Название сигнала
	char nameAlert[ANLEN];
	// Конечная дата интервала времени
	double dateTime;
	// Начальная дата интервала времени
	double dateTimePar;
	// Имя группы
	char nameGroup[GNLEN];
	// Краткое имя группы
	char shortNameGroup[SNLEN];
	// Флаги включения управляющих компонентов
	TListEnableControls EnableControls;
//==============================================================================
  //переменные отображения и статуса компонента "перечень отображаемых данных"
  bool indbird;//флаг доступности
  int bird;//переменная состояния. задается на форме
  long startmid;
  char FAddParam[FDADDPARAMSIZE][FDADDPARAMSIZE];
};


// Описание формы
class TFormDescr: public fdInit
{
public:// Описание свойств

    __property AnsiString NameForm  = { read=GetNameForm, write=SetNameForm };
    __property AnsiString CommentForm  = { read=GetCommentForm, write=SetCommentForm };
    __property AnsiString NameAlert  = { read=GetNameAlert, write=SetNameAlert };
    __property TDateTime DateTime  = { read=GetDateTime, write=SetDateTime };
    __property TDateTime DateTimePar  = { read=GetDateTimePar, write=SetDateTimePar };
    __property AnsiString NameGroup  = { read=GetNameGroup, write=SetNameGroup };

public:// Описание методов

	void strGroup(char*);
	// Конструктор по умолчанию
	__fastcall TFormDescr();
	// Конструктор копирования
	__fastcall TFormDescr(TFormDescr&);
	// Деструктор
	__fastcall ~TFormDescr();
	// Оператор присваивания
	TFormDescr& operator =(TFormDescr&);
	// Формирования потока данных для сохранения формы
	bool __fastcall SaveFormDescr( TStream* );
  int __fastcall TFormDescr::GetPeriod(TDateTime);
  int __fastcall TFormDescr::GetPeriodForYearStart( TDateTime);
  int __fastcall TFormDescr::GetPeriodForYearFinish( TDateTime);
	// Считывание параметров сохраненной формы из потока данных
	bool __fastcall LoadFormDescr( TStream* );
    __property AnsiString ShortNameGroup  = { read=GetShortNameGroup, write=SetShortNameGroup };
private:
    void __fastcall SetNameForm(AnsiString value);
    AnsiString __fastcall GetNameForm();
    void __fastcall SetCommentForm(AnsiString value);
    AnsiString __fastcall GetCommentForm();
    void __fastcall SetNameAlert(AnsiString value);
    AnsiString __fastcall GetNameAlert();
    void __fastcall SetDateTime(TDateTime value);
    TDateTime __fastcall GetDateTime();
    void __fastcall SetDateTimePar(TDateTime value);
    TDateTime __fastcall GetDateTimePar();
    void __fastcall SetNameGroup(AnsiString value);
    AnsiString __fastcall GetNameGroup();
    void __fastcall SetShortNameGroup(AnsiString value);
    AnsiString __fastcall GetShortNameGroup();
};
//---------------------------------------------------------------------------
#endif
