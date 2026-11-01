object FormCopyShcema: TFormCopyShcema
  Left = 361
  Top = 142
  BorderStyle = bsToolWindow
  Caption = #1042#1074#1086#1076' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103' '#1089#1093#1077#1084#1099
  ClientHeight = 133
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    262
    133)
  PixelsPerInch = 96
  TextHeight = 13
  object lSchemaName: TLabel
    Left = 10
    Top = 8
    Width = 64
    Height = 13
    Caption = #1048#1084#1103' '#1089#1093#1077#1084#1099' :'
  end
  object cbSchemaName: TComboBox
    Left = 8
    Top = 24
    Width = 243
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object cbGroupCopy: TCheckBox
    Left = 8
    Top = 48
    Width = 181
    Height = 19
    Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1089#1090#1091#1087#1085#1099#1077' '#1075#1088#1091#1087#1087#1099
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object btOk: TBitBtn
    Left = 30
    Top = 99
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1054#1050
    TabOrder = 2
    OnClick = btOkClick
    Kind = bkOK
  end
  object btCancel: TBitBtn
    Left = 160
    Top = 99
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    Kind = bkCancel
  end
  object cbFileCopy: TCheckBox
    Left = 8
    Top = 72
    Width = 201
    Height = 17
    Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080#1074#1103#1079#1072#1085#1085#1099#1077' '#1092#1072#1081#1083#1099
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
end
