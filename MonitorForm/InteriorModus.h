//---------------------------------------------------------------------------
#ifndef InteriorModusH
#define InteriorModusH
//---------------------------------------------------------------------------
#include "Interior.h"
#include "Open_OCX.h"
#include "sdePanelXControl_OCX.h"
//---------------------------------------------------------------------------
class TModusInterior : public TInterior
{
protected:
    TfmShemEdit*HartePanel;
    TsdePanelX *ModusPanel;
    bool isPoint;
    long currId;
    char currName[200];
    void __fastcall DocDblClick(TObject*, BSTR);
    void __fastcall DocRightClick(TObject*,BSTR,int,int,int);
    void __fastcall sdeDocRightClick(TObject*,BSTR,long,long,long);
    // Визуализация строки состояния
    TMenuItem*onShowStatus;
    void __fastcall ShowStatusClick(TObject *Sender);
    // Визуализация панели инструментов
    TMenuItem*onShowTools;
    void __fastcall ShowToolsClick(TObject *Sender);
    // Мониторинг выделенной точки
    TMenuItem*onMonitoring;
    void __fastcall MonSelectClick(TObject *Sender);
    // Таймер - для реализации обновления схемы в контексте основного потока
    // так как ActiveX компонента глючит при многопоточной обработке.
    // Таймер включается сообщением из дополнительного потока и выключается при первом срабатывании.
    // Критическая секция - исключает одновременный доступ к состоянию таймера
    // обработчиком сообщения из доп. потока и обработчиком таймера.
    TTimer *Timer;
    CRITICAL_SECTION timerUpdate;
    void __fastcall OnTime(TObject *Sender);
public:
    enum eObjectType{
        otDefault=0,
        otModusActiveXeme=1
    };
    __fastcall TModusInterior(TComponent*,TSplitterForm*,TFormDescr*,Classes::TNotifyEvent, eObjectType objType=otDefault);
    virtual __fastcall ~TModusInterior();
    virtual void __fastcall selectData(  TOraQuery *qwInter  );
    virtual void __fastcall refreshData(int Table,  TOraQuery *qwInter );
    virtual void __fastcall formDescr(void);
	virtual void __fastcall PrintRep();
};

#endif
