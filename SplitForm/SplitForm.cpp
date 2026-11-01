//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#include "MONITORFORM.h"
#include "SplitForm.h"
#include "Reconst.hpp"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TSplitterForm::TSplitterForm(TComponent* Owner)
	: TForm(Owner),Friend(NULL),Opponent(NULL),
    activeControl(NULL),Splitter(NULL)
{
}
//---------------------------------------------------------------------------

void __fastcall TSplitterForm::SplitMouseDown(TObject *Sender, TMouseButton Button,
	TShiftState Shift, int X, int Y)
{
    TPoint TL,BR;
	if(Button==mbLeft)
	{
		prevRect=Splitter->BoundsRect;
        TL.x=prevRect.Left; TL.y=prevRect.Top;
        BR.x=prevRect.Right; BR.y=prevRect.Bottom;
		Sizing=true;
		hDC=GetDC(NULL);
		SetROP2(hDC,R2_NOTXORPEN);
		hPen = CreatePen( PS_INSIDEFRAME , min(Splitter->Width,Splitter->Height), 0);
		hPenOld = SelectObject(hDC, hPen);
		::ClientToScreen(Handle,&TL);
		::ClientToScreen(Handle,&BR);

		Rectangle(hDC,prevRect.Left,prevRect.Top,prevRect.Right,prevRect.Bottom);
	}
}
//---------------------------------------------------------------------------
void __fastcall TSplitterForm::SplitMouseMove(TObject *Sender, TShiftState Shift,
	int X, int Y)
{
	if(Sizing)
	{
		POINT p,TL,BR;
		TRect testRect;
		p.x=X;
		p.y=Y;
		testRect=ClientRect;
        TL.x=testRect.Left; TL.y=testRect.Top;
        BR.x=testRect.Right; BR.y=testRect.Bottom;
		::ClientToScreen(Handle,&TL);
		::ClientToScreen(Handle,&BR);
		::ClientToScreen(Splitter->Handle,&p);
		if(al==alLeft || al==alRight )
		{
			if( p.x>=testRect.Left && p.x<=testRect.Right-Splitter->Width )
			{
				Rectangle(hDC,prevRect.Left,prevRect.Top,prevRect.Right,prevRect.Bottom);
				X=prevRect.Left-p.x;
				prevRect.Left-=X;
				prevRect.Right-=X;
				Rectangle(hDC,prevRect.Left,prevRect.Top,prevRect.Right,prevRect.Bottom);
			}
			else
			{
				if( p.x<testRect.Left )
					p.x=testRect.Left;
				else
					p.x=testRect.Right-Splitter->Width;
				testRect=prevRect;
				X=testRect.Left-p.x;
				testRect.Left-=X;
				testRect.Right-=X;
				if( memcmp(&testRect,&prevRect,sizeof(TRect)) )
				{
					Rectangle(hDC,prevRect.Left,prevRect.Top,prevRect.Right,prevRect.Bottom);
					prevRect=testRect;
					Rectangle(hDC,prevRect.Left,prevRect.Top,prevRect.Right,prevRect.Bottom);
				}
			}
		}
		else
		{
			if( p.y>=testRect.Top && p.y<=testRect.Bottom-Splitter->Height )
			{
				Rectangle(hDC,prevRect.Left,prevRect.Top,prevRect.Right,prevRect.Bottom);
				Y=prevRect.Top-p.y;
				prevRect.Top-=Y;
				prevRect.Bottom-=Y;
				Rectangle(hDC,prevRect.Left,prevRect.Top,prevRect.Right,prevRect.Bottom);
			}
			else
			{
				if( p.y<testRect.Top )
					p.y=testRect.Top;
				else
					p.y=testRect.Bottom-Splitter->Height;
				testRect=prevRect;
				Y=testRect.Top-p.y;
				testRect.Top-=Y;
				testRect.Bottom-=Y;
				if( memcmp(&testRect,&prevRect,sizeof(TRect)) )
				{
					Rectangle(hDC,prevRect.Left,prevRect.Top,prevRect.Right,prevRect.Bottom);
					prevRect=testRect;
					Rectangle(hDC,prevRect.Left,prevRect.Top,prevRect.Right,prevRect.Bottom);
				}
			}
		}
	}
}
//---------------------------------------------------------------------------
void __fastcall TSplitterForm::SplitMouseUp(TObject *Sender, TMouseButton Button,
	TShiftState Shift, int X, int Y)
{
	POINT p;
	int height_width;

	if(Button==mbLeft && Sizing )
	{
		Rectangle(hDC,prevRect.Left,prevRect.Top,prevRect.Right,prevRect.Bottom);
		p.x=X;
		p.y=Y;
		p=ScreenToClient(Splitter->ClientToScreen(p));
		Y=p.y;
		X=p.x;
		switch( al )
		{
			case alBottom:
				height_width=Y;
				break;
			case alTop:
				height_width=ClientHeight-Y;
				break;
			case alRight:
				height_width=X;
				break;
			case alLeft:
				height_width=ClientWidth-X;
				break;
		}
		switch( al )
		{
			case alTop:
			case alBottom:
				if(height_width>=ClientHeight-Splitter->Height)
					height_width=ClientHeight-Splitter->Height;
				if(height_width<0)
					height_width=0;
				Friend->Height=height_width;
				Opponent->Height=ClientHeight-height_width-Splitter->Height;
				Opponent->Height=Opponent->Height<0? 0:Opponent->Height;
				Splitter->Tag=MAKELONG(Friend->Height,Opponent->Height);
			if( al==alTop )
			{
				Opponent->Top=0;
				Splitter->Top=Opponent->Height;
				Friend->Top=Opponent->Height+Splitter->Height;
			}
			else
			{
				Friend->Top=0;
				Splitter->Top=Friend->Height;
				Opponent->Top=Friend->Height+Splitter->Height;
			}
				break;
			case alLeft:
			case alRight:
				if(height_width>=ClientWidth-Splitter->Width)
					height_width=ClientWidth-Splitter->Width;
				if(height_width<0)
					height_width=0;
				Friend->Width=height_width;
				Opponent->Width=ClientWidth-height_width-Splitter->Width;
				Opponent->Width=Opponent->Width<0 ? 0:Opponent->Width;
				Splitter->Tag=MAKELONG(Friend->Width ,Opponent->Width);
			if( al==alLeft )
			{
				Opponent->Left=0;
				Splitter->Left=Opponent->Width;
				Friend->Left=Opponent->Width+Splitter->Width;
			}
			else
			{
				Friend->Left=0;
				Splitter->Left=Friend->Width;
				Opponent->Left=Friend->Width+Splitter->Width;
			}
				break;
		}
		Sizing=false;
		SelectObject(hDC, hPenOld);
		DeleteObject(hPen);
		ReleaseDC(NULL,hDC);
		if(Splitter->OnClick)
			(Splitter->OnClick)(Splitter);
	}
}
//---------------------------------------------------------------------------
void __fastcall TSplitterForm::SplitFormResize(TObject *Sender)
{
	int height_width;
	double koeff;

	if( this->ControlCount < 3 )
	{
		if(Friend)
			Friend->BoundsRect=ClientRect;
		return;
	}

	height_width=HIWORD(Splitter->Tag)+LOWORD(Splitter->Tag);
	if(height_width==0)
	{
		height_width=2;
		Splitter->Tag=(unsigned long)0x00010001;
	}
	switch( al )
	{
		case alTop:
		case alBottom:
			koeff=(double)(this->ClientHeight-Splitter->Height)/(double)height_width;
			height_width=LOWORD(Splitter->Tag)*koeff;
			Friend->Height=height_width;
			Opponent->Height=this->ClientHeight-height_width-Splitter->Height;
			Opponent->Height=Opponent->Height<0? 0:Opponent->Height;
			Splitter->Tag=MAKELONG(Friend->Height ,Opponent->Height);
			Splitter->Width=this->ClientWidth;
            Opponent->Width=this->ClientWidth;
            Friend->Width=this->ClientWidth;
			Opponent->Left=0;
            Friend->Left=0;
			if( al==alTop )
			{
				Opponent->Top=0;
				Splitter->Top=Opponent->Height;
				Friend->Top=Opponent->Height+Splitter->Height;
			}
			else
			{
				Friend->Top=0;
				Splitter->Top=Friend->Height;
				Opponent->Top=Friend->Height+Splitter->Height;
			}
			break;
		case alLeft:
		case alRight:
			koeff=(double)(this->ClientWidth-Splitter->Width)/(double)height_width;
			height_width=LOWORD(Splitter->Tag)*koeff;
			Friend->Width=height_width;
			Opponent->Width=this->ClientWidth-height_width-Splitter->Width;
			Opponent->Width=Opponent->Width<0 ? 0:Opponent->Width;
			Splitter->Tag=MAKELONG(Friend->Width ,Opponent->Width);
			Splitter->Height=this->ClientHeight;
            Opponent->Height=this->ClientHeight;
            Friend->Height=this->ClientHeight;
			Opponent->Top=0;Friend->Top=0;
			if( al==alLeft )
			{
				Opponent->Left=0;
				Splitter->Left=Opponent->Width;
				Friend->Left=Opponent->Width+Splitter->Width;
			}
			else
			{
				Friend->Left=0;
				Splitter->Left=Friend->Width;
				Opponent->Left=Friend->Width+Splitter->Width;
			}
			break;
	}
}
//---------------------------------------------------------------------------
TSplitterForm* __fastcall TSplitterForm::New( TComponent* Owner )
{
	return new TSplitterForm(Owner);
}
//---------------------------------------------------------------------------
void __fastcall TSplitterForm::AddChild(TControl*AControl, TAlign AAlign )
{
	TSplitterForm *pNewSForm;
	TRect r;

	switch( ControlCount )
	{
    //Добавить 1-е дочернее окно:
    //-	Добавляем 1-е дочернее окно с выравниванием на клиентскую область
    case 0:
	        if(AControl->Parent)
		      AControl->Parent->RemoveControl(AControl);
                Friend=AControl;
		Friend->Parent=this;
		Friend->Show();
		Friend->Align=alNone;
		Friend->Width=ClientWidth;
		Friend->Height=ClientHeight;
		Friend->Left=0;
		Friend->Top=0;
        Opponent=NULL;
		Splitter=NULL;
		activeControl=NULL;
		al=alNone;
		break;
    //Добавить 2-е дочернее окно:
    //-	Добавляем 2-е дочернее окно с указанным выравниванием ( Слева, Справа, Снизу, Сверху)
    //разделяя пополам клиентскую область
    //-	Добавляем сплитер с тем же выравниванием, и настраиваем его
    //-	Запоминаем указатель на сплитер
    //-	Устанавливаем обработчики для сплитера
    case 1:
	    if(AAlign==alNone || AAlign==alClient)
		    AAlign=alRight;
        if(AControl->Parent)
		    AControl->Parent->RemoveControl(AControl);
        al=AAlign;
		Splitter = new TPanel(Owner);
		Opponent = AControl;
		Splitter->Parent=this;
		Opponent->Parent=this;
		Splitter->Show();
		Opponent->Show();
		Splitter->Align=alNone;
		Opponent->Align=alNone;
		Splitter->Tag=0x00010001;
		Splitter->OnMouseUp=TSplitterForm::SplitMouseUp;
		Splitter->OnMouseDown=TSplitterForm::SplitMouseDown;
		Splitter->OnMouseMove=TSplitterForm::SplitMouseMove;
		if( AAlign==alLeft || AAlign==alRight )
		{
		    Splitter->Cursor=crHSplit;
			Splitter->Width=3;
			Opponent->Width=(ClientWidth-3)/2;
			Friend->Width=ClientWidth-Opponent->Width-Splitter->Width;
			Splitter->Height=ClientHeight;
            Opponent->Height=ClientHeight;
            Friend->Height=ClientHeight;
			if( al==alLeft )
			{
			    Opponent->Left=0;
				Splitter->Left=Opponent->Width;
				Friend->Left=Opponent->Width+Splitter->Width;
            }
			else
			{
			    Friend->Left=0;
				Splitter->Left=Friend->Width;
				Opponent->Left=Friend->Width+Splitter->Width;
            }
        }
		else
		{
		    Splitter->Cursor=crVSplit;
			Splitter->Height=3;
			Opponent->Height=(ClientHeight-3)/2;
			Friend->Height=ClientHeight-Opponent->Height-Splitter->Height;
			Splitter->Width=ClientWidth;
            Opponent->Width=ClientWidth;
            Friend->Width=ClientWidth;
			if( al==alTop )
			{
			    Opponent->Top=0;
				Splitter->Top=Opponent->Height;
				Friend->Top=Opponent->Height+Splitter->Height;
            }
			else
            {
                Friend->Top=0;
			    Splitter->Top=Friend->Height;
				Opponent->Top=Friend->Height+Splitter->Height;
            }
        }
		break;
    //Добавить 3-е дочернее окно:
    //-	Находим текущее дочернее
    //-	Создаем форму по типу родительской, размером как у текущего дочернего
    //	и выравнивание как у текущего дочернего
    //-	Добавляем (InsertControl) в новую форму текущее дочернее как 1-е дочернее окно
    //-	Вставляем новую форму на место бывшего текущего окна
    //-	Добавляем в новую форму 3-е окно как 2-е окно для новой формы
    case 3:
	    if(activeControl==NULL)
		    throw(Exception(Reconst_smes132_1));
        if(AControl->Parent)
		    AControl->Parent->RemoveControl(AControl);
        r = activeControl->BoundsRect;
        RemoveControl(activeControl);

		pNewSForm = New(Owner);
		pNewSForm->Parent=this;
        pNewSForm->Show();
		pNewSForm->BoundsRect=r;

		pNewSForm->AddChild(activeControl,AAlign);
		pNewSForm->AddChild(AControl,AAlign);
		if(activeControl==Friend)
		    Friend=pNewSForm;
        else
		    Opponent=pNewSForm;
        break;
    }
}
//---------------------------------------------------------------------------
void __fastcall TSplitterForm::AddChild(TControl* ADestinControl,
    TControl* AControl,TAlign AAlign)
{
	if(AControl==NULL)
		throw( Exception(Reconst_smes132_2));
	else if(ADestinControl==NULL){
		activeControl=NULL;
		AddChild(AControl,AAlign );
		return;
	}else if( dynamic_cast<TSplitterForm*>(ADestinControl->Parent)){
	    ((TSplitterForm*)ADestinControl->Parent)->activeControl=ADestinControl;
		((TSplitterForm*)ADestinControl->Parent)->AddChild(AControl,AAlign );
    }else
        throw(Exception(Reconst_smes132_3));
}
//---------------------------------------------------------------------------
void __fastcall TSplitterForm::RemoveChild( TControl* AControl )
{
	if(AControl==NULL)
		return;
	if( AControl->Parent )
		if( dynamic_cast<TSplitterForm*>(AControl->Parent))
			((TSplitterForm*)AControl->Parent)->DeleteChild( AControl );
		else
			throw( Exception(Reconst_smes132_4) );
	else{
		//throw( Exception("TSplitterForm::RemoveChild: Невозможно удалить компонент, у которого нет родителя!") );
    }
}
//---------------------------------------------------------------------------
void __fastcall TSplitterForm::DeleteChild( TControl* AControl )
{
	TSplitterForm *pDelSForm;
	TRect r;

	switch( ControlCount )
	{
		case 0:
			break;
		case 1:
			if( AControl!=Friend )
				throw(Exception(Reconst_smes132_6));
			RemoveControl(AControl);
			Friend=NULL;
			if( Parent && dynamic_cast<TSplitterForm*>(Parent) )
			{
				((TSplitterForm*)Parent)->DeleteChild( this );
				Release();
			}
			break;
		case 3:
			if( AControl!=Friend && AControl!=Opponent )
				throw(Exception(Reconst_smes132_7));
			if( (!dynamic_cast<TSplitterForm*>(AControl)) ||
			(dynamic_cast<TSplitterForm*>(AControl)&& ((TSplitterForm*)AControl)->ControlCount==0))
			{
			if( AControl==Friend )
				Friend=Opponent;
			RemoveControl(AControl);
			RemoveControl(Splitter);
			delete Splitter;
			Opponent=NULL;
			Splitter=NULL;
			activeControl=NULL;
			Friend->BoundsRect=ClientRect;
			al=alNone;
			if(dynamic_cast<TSplitterForm*>(Friend))
			{
				pDelSForm=(TSplitterForm*)Friend;
				Friend=pDelSForm->Friend;
				Opponent=pDelSForm->Opponent;
				Splitter=pDelSForm->Splitter;
				activeControl=pDelSForm->activeControl;
				al=pDelSForm->al;

				//Friend->Owner=this;
				pDelSForm->RemoveControl(Friend);
				Friend->Parent=this;
				//InsertControl(Friend);

				if( Splitter )
				{
					//Splitter->Owner=this;
					pDelSForm->RemoveControl(Splitter);
					Splitter->Parent=this;
					Splitter->OnMouseUp=TSplitterForm::SplitMouseUp;
					Splitter->OnMouseDown=TSplitterForm::SplitMouseDown;
					Splitter->OnMouseMove=TSplitterForm::SplitMouseMove;
					//InsertControl(Splitter);
				}
				if( Opponent )
				{
					//Opponent->Owner=this;
					pDelSForm->RemoveControl(Opponent);
					Opponent->Parent=this;
					//InsertControl(Opponent);
				}

				RemoveControl(pDelSForm);
				delete pDelSForm;

				if(ControlCount<3)
					Friend->BoundsRect=ClientRect;
				else
					SplitFormResize(NULL);
			}
			else
			{
				if( Parent && dynamic_cast<TSplitterForm*>(Parent) )
				{
					r=BoundsRect;
					((TSplitterForm*)Parent)->DeleteChild( this );
					Release();
					Friend->BoundsRect=r;
				}
			}
			}
			else
			{
			pDelSForm=(TSplitterForm*)AControl;
			switch( pDelSForm->ControlCount )
			{
				case 1:
					if( pDelSForm == Friend )
						Friend=pDelSForm->Friend;
					else
						Opponent=pDelSForm->Friend;
					pDelSForm->Friend->BoundsRect=pDelSForm->BoundsRect;
					pDelSForm->RemoveControl(pDelSForm->Friend);
					pDelSForm->Friend->Parent=this;;
					pDelSForm->Friend->BoundsRect=pDelSForm->BoundsRect;
					RemoveControl(pDelSForm);
					break;
				default:
					throw(Exception(Reconst_smes132_8));
			}
			}
			break;
	}
}
//---------------------------------------------------------------------------
void __fastcall TSplitterForm::MaximizeChild( TControl* AControl, TTabSheet *TabSheetMax)
{
	if(AControl && AControl->Parent && dynamic_cast<TSplitterForm*>(AControl->Parent))
		((TSplitterForm*)AControl->Parent)->RotateChild( AControl, TabSheetMax);
}
//---------------------------------------------------------------------------
void __fastcall TSplitterForm::RotateChild( TControl* AControl, TTabSheet *TabSheetMax)
{
	TControl* TabSheetControl;
	if(TabSheetMax->ControlCount)
		TabSheetControl=TabSheetMax->Controls[0];
	else
		throw(Exception(Reconst_smes132_9));

	prevRect=AControl->BoundsRect;

	TabSheetMax->RemoveControl(TabSheetControl);
	RemoveControl(AControl);

	TabSheetControl->Align=alNone;
	AControl->Align=alClient;

	TabSheetControl->Parent=this;
	AControl->Parent=TabSheetMax;

	TabSheetControl->BoundsRect=prevRect;
	if( Friend==AControl)
		Friend=TabSheetControl;
	else
		Opponent=TabSheetControl;
}
//---------------------------------------------------------------------------
__fastcall TSplitterBaseMonitorForm::TSplitterBaseMonitorForm(TComponent* Owner):TSplitterForm(Owner){}
//---------------------------------------------------------------------------
void __fastcall TSplitterBaseMonitorForm::AddChild( TBaseMonitorForm* ADestinControl,TBaseMonitorForm* AControl,
	TAlign AAlign )
{
	TSplitterForm::AddChild( (TControl*)ADestinControl,(TControl*)AControl,AAlign );
}
//---------------------------------------------------------------------------
void __fastcall TSplitterBaseMonitorForm::RemoveChild( TBaseMonitorForm* AControl )
{
	TSplitterForm::RemoveChild( (TControl*)AControl );
}
//---------------------------------------------------------------------------
void __fastcall TSplitterBaseMonitorForm::MaximizeChild( TBaseMonitorForm* AControl, TTabSheet *TabSheetMax)
{
	TSplitterForm::MaximizeChild( (TControl*)AControl, TabSheetMax);
}
//---------------------------------------------------------------------------
void __fastcall TSplitterBaseMonitorForm::MaximizeChild( TPanel* AControl, TTabSheet *TabSheetMax)
{
	TSplitterForm::MaximizeChild( (TControl*)AControl, TabSheetMax);
}
//---------------------------------------------------------------------------
TSplitterForm* __fastcall TSplitterBaseMonitorForm::New( TComponent* Owner )
{
	return new TSplitterBaseMonitorForm(Owner);
}
//---------------------------------------------------------------------------
bool __fastcall TSplitterBaseMonitorForm::SaveSplitter( TStream* ostream )
{
/*
	TControl *Friend,*Opponent,*activeControl;
	TAlign al;
	TPanel * Splitter;
*/
try{
	enum typeForm typeForm;
	bool hasOpponent=false;
	long temp;
	if(Friend)
	{
		if( dynamic_cast<TBaseMonitorForm*>(Friend))
		{
			typeForm=tMonitorForm;
			ostream->WriteBuffer( &typeForm, sizeof(int));
			if(dynamic_cast<TBaseMonitorForm*>(Friend)->SaveMonitorForm(ostream)==false)
				return false;
		}
		else
		if( dynamic_cast<TSplitterBaseMonitorForm*>(Friend))
		{
			typeForm=tSplitterForm;
			ostream->WriteBuffer( &typeForm, sizeof(int));
			if(dynamic_cast<TSplitterBaseMonitorForm*>(Friend)->SaveSplitter(ostream)==false)
				return false;
		}
		else
			return false;
	}
	else
		return false;
	if( Opponent &&
		(dynamic_cast<TBaseMonitorForm*>(Opponent) ||
		dynamic_cast<TSplitterBaseMonitorForm*>(Opponent)
		))
	{
		hasOpponent=true;
		ostream->WriteBuffer( &hasOpponent, sizeof(bool));
		ostream->WriteBuffer( &(temp=(long)al), sizeof(long));
		ostream->WriteBuffer( &(temp=Splitter->Tag), sizeof(long));
		if( dynamic_cast<TBaseMonitorForm*>(Opponent))
		{
			typeForm=tMonitorForm;
			ostream->WriteBuffer( &typeForm, sizeof(int));
			if(dynamic_cast<TBaseMonitorForm*>(Opponent)->SaveMonitorForm(ostream)==false)
				return false;
		}
		else
		if( dynamic_cast<TSplitterBaseMonitorForm*>(Opponent))
		{
			typeForm=tSplitterForm;
			ostream->WriteBuffer( &typeForm, sizeof(int));
			if(dynamic_cast<TSplitterBaseMonitorForm*>(Opponent)->SaveSplitter(ostream)==false)
				return false;
		}
		else
			return false;
	}
	else
		ostream->WriteBuffer( &hasOpponent, sizeof(bool));

	return true;
}
catch(Exception &e)
{
	return false;
}
}
//---------------------------------------------------------------------------
bool TSplitterBaseMonitorForm::LoadSplitter( TStream* istream,Classes::TNotifyEvent OnProgrBar,Classes::TList* list)
{
try{
	enum typeForm tpForm;
	bool hasOpponent=false;
	long temp;
	TBaseMonitorForm* newBaseMonitorForm;
	TSplitterBaseMonitorForm* ttt;
	TAlign tempAl;

	istream->ReadBuffer( &tpForm, sizeof(int));
	switch(tpForm)
	{
		case tMonitorForm:
			newBaseMonitorForm=new TBaseMonitorForm(Owner,OnProgrBar);
			list->Add(newBaseMonitorForm);
			TSplitterForm::AddChild( NULL,newBaseMonitorForm,alClient );
			if(newBaseMonitorForm->LoadMonitorForm(istream)==false)
				return false;
			break;
		case tSplitterForm:
			(TSplitterForm*)ttt=New(Owner);
			TSplitterForm::AddChild( NULL,ttt,alClient );
			if( ttt->LoadSplitter(istream,OnProgrBar,list)==false )
				return false;
			break;
		default:
			return false;
	}
	istream->ReadBuffer( &hasOpponent, sizeof(bool));
	if( hasOpponent )
	{
		istream->ReadBuffer( &temp, sizeof(long));
		tempAl=(TAlign)temp;
		istream->ReadBuffer( &temp, sizeof(long));

		istream->ReadBuffer( &tpForm, sizeof(int));
		switch(tpForm)
		{
			case tMonitorForm:
				newBaseMonitorForm=new TBaseMonitorForm(Owner,OnProgrBar);
				list->Add(newBaseMonitorForm);
				TSplitterForm::AddChild( Friend,newBaseMonitorForm,tempAl );
				if(newBaseMonitorForm->LoadMonitorForm(istream)==false)
					return false;
				break;
			case tSplitterForm:
				(TSplitterForm*)ttt = New(Owner);
				TSplitterForm::AddChild( Friend,ttt,tempAl );
				if( ttt->LoadSplitter(istream,OnProgrBar,list)==false )
					return false;
				break;
			default:
				return false;
		}
		Splitter->Tag=temp;
	}
	return true;
}
catch(Exception &e)
{
	return false;
}
}
//---------------------------------------------------------------------------
