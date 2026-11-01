object fmGetSelectDate: TfmGetSelectDate
  Left = 732
  Top = 379
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsToolWindow
  Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1090#1091
  ClientHeight = 130
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object plSupMain: TPanel
    Left = 0
    Top = 0
    Width = 240
    Height = 89
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 2
      Top = 18
      Width = 83
      Height = 13
      Caption = #1042#1079#1103#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1089':'
    end
    object Label2: TLabel
      Left = 2
      Top = 52
      Width = 42
      Height = 13
      Caption = #1053#1072' '#1076#1072#1090#1091':'
    end
    object dtpDate: TDateTimePicker
      Left = 88
      Top = 14
      Width = 141
      Height = 21
      CalAlignment = dtaLeft
      Date = 44582
      Time = 44582
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object CurrDate: TEdit
      Left = 88
      Top = 48
      Width = 137
      Height = 21
      Enabled = False
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 89
    Width = 240
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      240
      41)
    object BitBtn1: TBitBtn
      Left = 24
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 136
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
