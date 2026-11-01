//---------------------------------------------------------------------------
#ifndef EditTariffH
#define EditTariffH
//---------------------------------------------------------------------------
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <StdCtrls.hpp>
#include "DrawTable.h"
#include "Main.h"
#include <ImgList.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
/* шаблон двухсвязного списка */
//---------------------------------------------------------------------------
// класс T - должен иметь конструктор по умолчанию!!!
template <class T> class ChainedList /* шаблон двухсвязного списка */
{
   struct TChainedListItem{
      T data;
      TChainedListItem *next;
      TChainedListItem *prev;
      TChainedListItem(){ next = prev = NULL; }
   } *first, *last, *curritm;
   int count;
   TChainedListItem *get(int i){
      if(i<0 || i >= count) curritm = NULL;
      else {
         curritm = first;
         while(curritm && i-->0) curritm = curritm->next;
      }
      return curritm;
   }
public:
   ChainedList(int n){
      setCount(n);
   }
   ChainedList(void){
      first = last = curritm = NULL;
      count = 0;
   }
   ~ChainedList(){
      Clear();
   }
   T& operator[](int i){
      get(i);
      if(!curritm) throw("Ошибка: выход индекса за границу списка.");
      return curritm->data;
   }
   void Clear(void){
      curritm = first;
      while(curritm){
         TChainedListItem *t = curritm;
         curritm = curritm->next;
         delete t;
      }
      count = 0;
      first = last = NULL;
   }
   void setCount(const int n){
      Clear();
      while(count<n) Add();
   }
   int Count() const { return count; }
   T* Next(void){
      curritm = curritm?curritm->next:NULL;
      return curritm?&curritm->data:NULL;
   }
   T* Prev(void){
      curritm = curritm?curritm->prev:NULL;
      return curritm?&curritm->data:NULL;
   }
   T* Add(void){
      curritm = new TChainedListItem;
      curritm->prev = last;
      if(last) last->next = curritm;
      else first = curritm;
      last = curritm;
      count++;
      return &curritm->data;
   }
   void Delete(int i){
      get(i);
      if(!curritm) return;
      if(curritm->prev) curritm->prev->next = curritm->next;
      if(curritm->next) curritm->next->prev = curritm->prev;
      if(first==curritm) first = curritm->next;
      if(last==curritm) last = curritm->prev;
      delete curritm;
      count--;
      if(!count) first = last = curritm = NULL;
   }
   T* Insert(int i){
      get(i);
      if(!curritm) return NULL;
      TChainedListItem *tmp = new TChainedListItem;
      tmp->next = curritm->next;
      tmp->prev = curritm;
      curritm->next = tmp;
      if(tmp->next) tmp->next->prev = tmp;
      if(last==curritm) last = tmp;
      count++;
      curritm = tmp;
      return &curritm->data;
   }
   T* First(void){ curritm = first;  return curritm?&curritm->data:NULL; }
   T* Last(void){ curritm = last;  return curritm?&curritm->data:NULL; }
   void Change(int i, int j){
      TChainedListItem *a = get(i);
      TChainedListItem *b = get(j);
      if(!a || !b || a==b) return;
      TChainedListItem tmp;
      // вставка tmp вместо a
      tmp.next = a->next;
      tmp.prev = a->prev;
      if(a->prev) a->prev->next = &tmp;
      if(a->next) a->next->prev = &tmp;
      // вставка a вместо b
      a->next = b->next;
      a->prev = b->prev;
      if(b->next) b->next->prev = a;
      if(b->prev) b->prev->next = a;
      // вставка b вместо tmp
      b->next = tmp.next;
      b->prev = tmp.prev;
      if(tmp.next) tmp.next->prev = b;
      if(tmp.prev) tmp.prev->next = b;
   }
};

class TEditTariffForm : public TMainForm
{
__published:	// IDE-managed Components
   TDrawTable *DrawTable;
   TPanel *plTariffType;
   TComboBox *cbTariffType;
   TLabel *Label1;
   TBitBtn *bbAdd;
   TBitBtn *bbDel;
   void __fastcall FormShow(TObject *Sender);
   void __fastcall DrawTableSetEditText(TObject *Sender, int ACol,
          int ARow, const AnsiString Value);
   void __fastcall DrawTableClick(TObject *Sender);
   void __fastcall cbTariffTypeChange(TObject *Sender);
   void __fastcall cbTariffTypeEnter(TObject *Sender);
private:
   typedef struct {
      short editing; // 0 -Не трогали, 1-вставка, 2-обновление
      char kData[50];
      char bData[50];
      double Value;
   } TARIFF;
   ChainedList<TARIFF> mTariff;
   ChainedList<TARIFF> mDeleted;
   int TreeDecr[2];
   int FCurrRow;
   int TariffTypeIndex;
   void __fastcall SetAccess(TAccess value);
   bool __fastcall Load();
   void __fastcall UpdateDrawTable(void);
   void __fastcall SetCurrRow(int value);
   int __fastcall GetCurrRow();
   bool __fastcall LoadTariffType(void);
public:		// User declarations
   __fastcall TEditTariffForm(TComponent* Owner, AnsiString, TAccess = accDenied);
   __property int CurrRow  = { read=GetCurrRow, write=SetCurrRow, default=1 };
protected:
   void __fastcall vSave(TObject* Sender);
   void __fastcall vRefresh(TObject* Sender);
   void __fastcall vNew(TObject* Sender);
   void __fastcall vDelete(TObject* Sender);
};
//---------------------------------------------------------------------------
#endif
