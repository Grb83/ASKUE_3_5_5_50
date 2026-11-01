//---------------------------------------------------------------------------
#ifndef MonitorListH
#define MonitorListH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include "DBAccess.hpp"
#include "MemDS.hpp"
#include "Ora.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
#define MON_NAME_LEN 150
//---------------------------------------------------------------------------
class TfmMonitorList : public TForm
{
__published:	// IDE-managed Components
    TPanel *Panel2;
    TPanel *Panel4;
    TBitBtn *bbClose;
    TPanel *Panel1;
    TTreeView *tvMonitors;
    TImageList *ImageList1;
  TOraQuery *oqMonitor;
  TBlobField *oqMonitorDFILE;
  TFloatField *oqMonitorNPARENT;
    TImageList *ImageList2;
    void __fastcall bbCloseClick(TObject *Sender);
    void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
    void __fastcall tvMonitorsCollapsed(TObject *Sender, TTreeNode *Node);
    void __fastcall tvMonitorsExpanded(TObject *Sender, TTreeNode *Node);
    void __fastcall tvMonitorsExpanding(TObject *Sender, TTreeNode *Node, bool &AllowExpansion);
    void __fastcall tvMonitorsDblClick(TObject *Sender);
    void __fastcall tvMonitorsDeletion(TObject *Sender, TTreeNode *Node);
  void __fastcall tvMonitorsKeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
private:	// User declarations
    typedef struct {  //МОНИТОРЫ
        long Monitor_Id;
        long MSchema;
        char Name[MON_NAME_LEN];
        long DSize;
        long HaveChild;
    }MONITORS;
public:		// User declarations
    __fastcall TfmMonitorList(TComponent* Owner);
    bool __fastcall ReadTreeNode(TTreeNode* NodeParent);// Читает ветку дерева
    bool __fastcall ProvOpenMonitor(TObject *Sender,long aMonitorID);
    bool __fastcall TabuByProperty();  // по мотивам аналогичной ф-ии в SupperMain'e - вертаем нужно ли отключать дереао с мониторами если клиент c неродным кодом предприятия (уехал на другую базу)

};
//---------------------------------------------------------------------------
extern PACKAGE TfmMonitorList *fmMonitorList;
//---------------------------------------------------------------------------
#endif

