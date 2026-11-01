object FormCounter: TFormCounter
  Left = 55
  Top = 339
  HelpContext = 525
  BorderStyle = bsDialog
  ClientHeight = 290
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 265
    Width = 1000
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 255
      Height = 25
      Align = alLeft
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      object btSave: TBitBtn
        Left = 96
        Top = 1
        Width = 67
        Height = 25
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Visible = False
        OnClick = btSaveClick
        NumGlyphs = 2
      end
      object BitBtn1: TBitBtn
        Left = 4
        Top = 1
        Width = 85
        Height = 25
        Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = BitBtn1Click
        NumGlyphs = 2
      end
    end
    object Panel4: TPanel
      Left = 843
      Top = 0
      Width = 157
      Height = 25
      Align = alRight
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      object btOk: TBitBtn
        Left = 14
        Top = 1
        Width = 67
        Height = 25
        Caption = #1054#1050
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btOkClick
        NumGlyphs = 2
      end
      object btCancel: TBitBtn
        Left = 87
        Top = 1
        Width = 67
        Height = 25
        Cancel = True
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btCancelClick
        NumGlyphs = 2
      end
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 1000
    Height = 265
    Align = alClient
    AllowedOperations = [alopUpdateEh]
    DataSource = DS1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    TitleLines = 2
    UseMultiTitle = True
    OnKeyPress = DBGridEh1KeyPress
    Columns = <
      item
        EditButtons = <>
        FieldName = 'VName'
        Footers = <>
        ReadOnly = True
        Width = 200
      end
      item
        EditButtons = <>
        FieldName = 'date_count'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'MTRSN'
        Footers = <>
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'DIGITS'
        Footers = <>
        Title.Caption = #1056#1072#1079#1088#1103#1076#1085#1086#1089#1090#1100
        Width = 84
      end
      item
        DblClickNextVal = True
        EditButtons = <
          item
            Style = ebsEllipsisEh
            OnClick = DBGridEh1Columns4EditButtons0Click
          end>
        FieldName = 'MTYPE'
        Footers = <>
        Title.Caption = #1058#1080#1087
        Width = 286
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'MCURRENT'
        Footers = <>
        Title.Caption = '('#1040')'
        Width = 40
      end
      item
        EditButtons = <>
        FieldName = 'MPOWER'
        Footers = <>
        Title.Caption = '(V)'
        Width = 40
      end
      item
        EditButtons = <>
        FieldName = 'MYEAR'
        Footers = <>
        Title.Caption = #1055#1083#1086#1084#1073#1072'|'#1043#1086#1076
        Width = 30
      end
      item
        EditButtons = <>
        FieldName = 'MQUARTER'
        Footers = <>
        Title.Caption = #1055#1083#1086#1084#1073#1072'|'#1050#1074'.'
        Width = 30
      end
      item
        EditButtons = <>
        FieldName = 'MCONST'
        Footers = <>
        Title.Caption = #1048#1084#1087'./'#1082#1042#1090#1095
        Width = 70
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'MCLASS'
        Footers = <>
        Title.Caption = #1050#1083'.'
        Width = 40
      end>
  end
  object VT1: TVirtualTable
    FieldDefs = <
      item
        Name = 'VName'
        DataType = ftString
        Size = 127
      end
      item
        Name = 'date_count'
        DataType = ftDate
      end
      item
        Name = 'MTRSN'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'DIGITS'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'MTYPE'
        DataType = ftString
        Size = 75
      end
      item
        Name = 'MCURRENT'
        DataType = ftFloat
      end
      item
        Name = 'MPOWER'
        DataType = ftInteger
      end
      item
        Name = 'MYEAR'
        DataType = ftInteger
      end
      item
        Name = 'MQUARTER'
        DataType = ftInteger
      end
      item
        Name = 'MCONST'
        DataType = ftInteger
      end
      item
        Name = 'MCLASS'
        DataType = ftFloat
      end>
    Left = 500
    Top = 212
    Data = {
      02000B000500564E616D6501007F000A00646174655F636F756E740900000005
      004D5452534E01001E00060044494749545301001E0005004D5459504501004B
      0008004D43555252454E540600000006004D504F5745520300000005004D5945
      41520300000008004D515541525445520300000006004D434F4E535403000000
      06004D434C41535306000000000000000000}
    object VName: TStringField
      DisplayLabel = #1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072
      FieldName = 'VName'
      Size = 127
    end
    object date_count: TDateField
      FieldName = 'date_count'
    end
    object MTRSN: TStringField
      DisplayLabel = #1047'-'#1076' '#8470
      FieldName = 'MTRSN'
      Size = 30
    end
    object DIGITS: TStringField
      DisplayWidth = 30
      FieldName = 'DIGITS'
      Size = 30
    end
    object MTYPE: TStringField
      FieldName = 'MTYPE'
      Size = 50
    end
    object MCURRENT: TFloatField
      Alignment = taLeftJustify
      FieldName = 'MCURRENT'
    end
    object MPOWER: TIntegerField
      FieldName = 'MPOWER'
    end
    object MYEAR: TIntegerField
      FieldName = 'MYEAR'
    end
    object MQUARTER: TIntegerField
      FieldName = 'MQUARTER'
    end
    object MCONST: TIntegerField
      FieldName = 'MCONST'
    end
    object MCLASS: TFloatField
      Alignment = taLeftJustify
      FieldName = 'MCLASS'
    end
  end
  object DS1: TDataSource
    DataSet = VT1
    OnDataChange = DS1DataChange
    Left = 462
    Top = 216
  end
end
