object FindForm: TFindForm
  Left = 346
  Top = 262
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 201
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lMeasure: TLabel
    Left = 15
    Top = 12
    Width = 74
    Height = 13
    Caption = #1048#1089#1082#1072#1090#1100' '#1090#1077#1082#1089#1090' :'
  end
  object bbOk: TBitBtn
    Left = 200
    Top = 168
    Width = 89
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    TabOrder = 5
    OnClick = bbOkClick
    Kind = bkOK
  end
  object bbCancel: TBitBtn
    Left = 296
    Top = 168
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 6
    Kind = bkCancel
  end
  object rgDirection: TRadioGroup
    Left = 8
    Top = 57
    Width = 137
    Height = 56
    Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
    ItemIndex = 1
    Items.Strings = (
      #1042'&'#1074#1077#1088#1093
      #1042'&'#1085#1080#1079)
    TabOrder = 2
  end
  object cbCase: TCheckBox
    Left = 8
    Top = 40
    Width = 137
    Height = 17
    Caption = #1057' '#1091#1095#1105#1090#1086#1084' &'#1088#1077#1075#1080#1089#1090#1088#1072
    TabOrder = 1
  end
  object rgOrigin: TRadioGroup
    Left = 8
    Top = 113
    Width = 137
    Height = 57
    Caption = #1054#1073#1083#1072#1089#1090#1100' '#1087#1086#1080#1089#1082#1072
    ItemIndex = 1
    Items.Strings = (
      #1057' &'#1090#1077#1082#1091#1097#1077#1081' '#1087#1086#1079#1080#1094#1080#1080
      #1055'&'#1086' '#1074#1089#1077#1081' '#1090#1072#1073#1083#1080#1094#1077)
    TabOrder = 3
  end
  object gbParams: TGroupBox
    Left = 168
    Top = 40
    Width = 225
    Height = 113
    Caption = #1057' '#1091#1095#1105#1090#1086#1084' '#1087#1086#1079#1080#1094#1080#1080' '#1085#1072' '#1084#1072#1090#1088#1080#1094#1077' '#1059#1057#1044' :'
    TabOrder = 4
    object cbAP: TCheckBox
      Left = 8
      Top = 17
      Width = 105
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = #1040#1082#1090#1080#1074' &'#1087#1088#1080#1105#1084' :'
      ParentBiDiMode = False
      TabOrder = 0
      OnClick = cbClick
    end
    object cbAM: TCheckBox
      Left = 8
      Top = 41
      Width = 105
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = #1040#1082#1090#1080#1074' &'#1086#1090#1076#1072#1095#1072' :'
      ParentBiDiMode = False
      TabOrder = 2
      OnClick = cbClick
    end
    object cbRP: TCheckBox
      Left = 8
      Top = 65
      Width = 105
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = #1056#1077#1072'&'#1082#1090#1080#1074' '#1087#1088#1080#1105#1084' :'
      ParentBiDiMode = False
      TabOrder = 4
      OnClick = cbClick
    end
    object cbRM: TCheckBox
      Left = 8
      Top = 89
      Width = 105
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = #1056#1077#1072#1082'&'#1090#1080#1074' '#1086#1090#1076#1072#1095#1072' :'
      ParentBiDiMode = False
      TabOrder = 6
      OnClick = cbClick
    end
    object eAP: TEdit
      Left = 120
      Top = 14
      Width = 97
      Height = 21
      Color = clMenu
      Enabled = False
      TabOrder = 1
    end
    object eAM: TEdit
      Left = 120
      Top = 38
      Width = 97
      Height = 21
      Color = clMenu
      Enabled = False
      TabOrder = 3
    end
    object eRP: TEdit
      Left = 120
      Top = 62
      Width = 97
      Height = 21
      Color = clMenu
      Enabled = False
      TabOrder = 5
    end
    object eRM: TEdit
      Left = 120
      Top = 86
      Width = 97
      Height = 21
      Color = clMenu
      Enabled = False
      TabOrder = 7
    end
  end
  object cbMeasure: TComboBox
    Left = 96
    Top = 8
    Width = 289
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
end
