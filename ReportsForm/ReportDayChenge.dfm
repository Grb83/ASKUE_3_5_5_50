object fmRepDayChange: TfmRepDayChange
  Left = 289
  Top = 211
  BorderStyle = bsDialog
  Caption = 'Смена дня расчета'
  ClientHeight = 69
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 43
    Width = 256
    Height = 26
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 94
      Top = 1
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 176
      Top = 1
      Width = 75
      Height = 25
      Caption = 'Отмена'
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 256
    Height = 43
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 15
      Width = 73
      Height = 13
      Caption = 'День расчета:'
    end
    object EditRepDay: TEdit
      Left = 128
      Top = 11
      Width = 121
      Height = 21
      MaxLength = 2
      TabOrder = 0
    end
  end
end
