/////////////////////////////////////////////////////////////////////////////
// FILE        : InteriorAlert.h
// SUBSYSTEM   : ASCUE/SuperMainForm
// AUTHORS     : Valeriy V. Bludov (BlVal)
// CREATED     : 07/20/2002
// REQUIRES    : [%3]
// CONTAINS    :
//      constants
//      typedefs
//      class names
//      procedure names
// DESCRIPTION :
//      Невизуальный компонент для получения событий об обновлении таблицы
//      системных сообщений. Событие приходит от фоновой нити выполнения
//      MonitorAlert. Сообщение об обновлении передается главному окну приложения
//      для обновления статусов.
// REVISIONS   :
//      MM/DD/YY - (Author) Description
/////////////////////////////////////////////////////////////////////////////
#ifndef InteriorAlertH
#define InteriorAlertH
/////////////////////////////////////////////////////////////////////////////
#include "Interior.h"
/////////////////////////////////////////////////////////////////////////////
// TInteriorAlert - компонент для получения событий об обновлении таблицы
//                 системных сообщений
// DESCRIPTION:
//      Экземпляр класса должен регистрироваться в списке ListInterior - получателей
//      сообщений об обновлениях. Фоновая нить MonitorAlert при срабатывании
//      alert от базы данных вызывает метод класса refreshData,
//      передавая в качестве аргумента номер таблицы для которой сработал alert.
// INHERITANCE:
//      TInterior
// FRIENDS:
//      None
/////////////////////////////////////////////////////////////////////////////
class TInteriorAlert : public TInterior
{
	// Friend class
	// Friend function
public:
	// Static data members
	// Static member functions
	// Data members
	__fastcall TInteriorAlert(TComponent* Owner);       // Constructors
	virtual __fastcall ~TInteriorAlert(void);       // Destructors
	// Virtual functions
	virtual void __fastcall refreshData( int Table, TOraQuery *quMain);
	// Member function
	// Inline member functions
protected:
	// ...
	__fastcall TInteriorAlert( TComponent *Owner, TSplitterForm *,
		TFormDescr *, Classes::TNotifyEvent ):TInterior( Owner ){}
private:
	// ...
};
/////////////////////////////////////////////////////////////////////////////
#endif  //_InteriorAlert_H

