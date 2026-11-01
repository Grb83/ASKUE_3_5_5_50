object fmDepartmens: TfmDepartmens
  Left = 225
  Top = 170
  BorderStyle = bsDialog
  Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
  ClientHeight = 276
  ClientWidth = 577
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 251
    Width = 577
    Height = 25
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 2
      Top = 0
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn3: TBitBtn
      Left = 160
      Top = 0
      Width = 75
      Height = 25
      Caption = #1053#1086#1074#1086#1077
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 240
      Top = 0
      Width = 75
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object BitBtn5: TBitBtn
      Left = 416
      Top = 0
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 4
      OnClick = BitBtn5Click
      NumGlyphs = 2
    end
    object BitBtn6: TBitBtn
      Left = 497
      Top = 0
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 5
      OnClick = BitBtn6Click
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 80
      Top = 0
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object StringGridDep: TStringGrid
    Left = 0
    Top = 0
    Width = 577
    Height = 251
    Align = alClient
    ColCount = 2
    DefaultColWidth = 500
    DefaultRowHeight = 17
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing]
    TabOrder = 1
    OnGetEditText = StringGridDepGetEditText
    ColWidths = (
      50
      500)
  end
end
