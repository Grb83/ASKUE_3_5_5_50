inherited FormControlVolueDB: TFormControlVolueDB
  Left = 158
  Top = 213
  HelpContext = 524
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = #1050#1086#1085#1090#1088#1086#1083#1100' '#1086#1073#1098#1077#1084#1072' '#1041#1044
  ClientHeight = 328
  ClientWidth = 777
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 303
    Width = 777
    inherited iplClose: TPanel
      Left = 696
    end
    object BitBtn1: TBitBtn
      Left = 190
      Top = 0
      Width = 131
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083'...'
      TabOrder = 3
      OnClick = BitBtn1Click
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF008000000080000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0080000000800000008000000080000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF008000000080000000800000008000000080000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0080000000800000008000000080000000FFFFFF0080000000800000008000
        0000800000008000000080000000FF00FF00FF00FF00FF00FF00FF00FF008000
        0000800000008000000080000000FFFFFF00FFFFFF0080000000800000008000
        000080000000800000008000000080000000FF00FF00FF00FF00800000008000
        00008000000080000000FFFFFF00FFFFFF00FFFFFF0080000000800000008000
        00008000000080000000800000008000000080000000FF00FF00FF00FF008000
        000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00FF00FF00FF00FF00
        FF0080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00FF00FF00FF00FF00
        FF00FF00FF0080000000FFFFFF00FFFFFF00FFFFFF0080000000800000008000
        00008000000080000000800000008000000080000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0080000000FFFFFF00FFFFFF0080000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FFFFFF0080000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF008000000080000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
  end
  object DBGridEh1: TDBGridEh [1]
    Left = 0
    Top = 0
    Width = 777
    Height = 303
    Align = alClient
    DataSource = DataSource1
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColEnter = DBGridEh1ColEnter
    Columns = <
      item
        Color = clBtnFace
        EditButtons = <>
        FieldName = 'Data'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1044#1072#1085#1085#1099#1077
        Width = 380
      end
      item
        EditButtons = <>
        FieldName = 'StoragePeriod'
        Footers = <>
        Title.Caption = #1057#1088#1086#1082' '#1093#1088#1072#1085#1077#1085#1080#1103' ('#1089#1091#1090#1082#1080')'
        Width = 119
      end
      item
        EditButtons = <>
        FieldName = 'Arc'
        Footers = <>
        KeyList.Strings = (
          '0'
          '1')
        PickList.Strings = (
          #1053#1077#1090
          #1044#1072)
        Title.Caption = #1040#1088#1093#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077
        Width = 118
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'Extention'
        Footers = <>
        Title.Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1080#1077
        Width = 74
      end>
  end
  inherited MenuSAA: TMainMenu
    Left = 44
    Top = 102
  end
  inherited PopupMenu1: TPopupMenu
    Left = 76
    Top = 102
  end
  inherited alDefault: TActionList
    Left = 108
    Top = 102
  end
  inherited iImageList: TImageList
    Left = 140
    Top = 102
  end
  inherited ilMenu: TImageList
    Left = 12
    Top = 102
  end
  object VirtualTable1: TVirtualTable
    AfterInsert = VirtualTable1AfterInsert
    FieldDefs = <
      item
        Name = 'Data'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'StoragePeriod'
        DataType = ftInteger
      end
      item
        Name = 'Arc'
        DataType = ftInteger
      end
      item
        Name = 'Extention'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Modified'
        DataType = ftBoolean
      end>
    Left = 26
    Top = 166
    Data = {
      02000500040044617461010064000D0053746F72616765506572696F64030000
      000300417263030000000900457874656E74696F6E01000A0008004D6F646966
      69656405000000000000000000}
    object VirtualTable1Table: TStringField
      FieldName = 'Table'
      Size = 50
    end
    object VirtualTable1Data: TStringField
      DisplayWidth = 100
      FieldName = 'Data'
      Size = 100
    end
    object VirtualTable1StoragePeriod: TIntegerField
      FieldName = 'StoragePeriod'
    end
    object VirtualTable1Arc: TIntegerField
      FieldName = 'Arc'
    end
    object VirtualTable1Extention: TStringField
      DisplayWidth = 30
      FieldName = 'Extention'
      Size = 10
    end
    object VirtualTable1Modified: TBooleanField
      FieldName = 'Modified'
    end
  end
  object DataSource1: TDataSource
    DataSet = VirtualTable1
    Left = 84
    Top = 166
  end
  object aSaveDialog: TSaveDialog
    Left = 384
    Top = 176
  end
end
