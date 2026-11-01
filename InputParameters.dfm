object FormInputParameters: TFormInputParameters
  Left = 354
  Top = 186
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1087#1088#1086#1094#1077#1076#1091#1088#1099
  ClientHeight = 125
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    292
    125)
  PixelsPerInch = 96
  TextHeight = 13
  object lDate: TLabel
    Left = 24
    Top = 12
    Width = 246
    Height = 39
    Caption = 
      #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1090#1091', '#1085#1072#1095#1080#1085#1072#1103' '#1089' '#1082#1086#1090#1086#1088#1086#1081' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1087#1088#1086#1080#1079#1074#1077#1089#1090#1080' '#1087#1077#1088#1077#1088#1072#1089#1095#1077#1090 +
      ' '#1089#1091#1090#1086#1095#1085#1086#1075#1086' '#1088#1072#1089#1093#1086#1076#1072' '#1080' '#1043#1053', '#1074' '#1092#1086#1088#1084#1072#1090#1077': ['#1076#1076'.'#1084#1084'.'#1075#1075#1075#1075' '#1095#1095':'#1084#1080'] :'
    WordWrap = True
  end
  object bbOk: TBitBtn
    Left = 124
    Top = 93
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    TabOrder = 0
    Kind = bkOK
  end
  object bbCancel: TBitBtn
    Left = 208
    Top = 93
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    Kind = bkCancel
  end
  object meDate: TStringGrid
    Left = 24
    Top = 58
    Width = 152
    Height = 21
    Anchors = [akLeft, akBottom]
    ColCount = 1
    DefaultColWidth = 250
    DefaultRowHeight = 50
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goAlwaysShowEditor]
    ScrollBars = ssNone
    TabOrder = 2
    OnGetEditMask = meDateGetEditMask
  end
end
