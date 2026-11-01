object fmListCounter: TfmListCounter
  Left = 470
  Top = 233
  Width = 327
  Height = 317
  Caption = #1057#1087#1080#1089#1086#1082' '#1076#1086#1089#1090#1091#1087#1085#1099#1093' '#1089#1095#1077#1090#1095#1080#1082#1086#1074
  Color = clBtnFace
  Constraints.MinHeight = 317
  Constraints.MinWidth = 327
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 265
    Width = 319
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object Panel4: TPanel
      Left = 162
      Top = 0
      Width = 157
      Height = 25
      Align = alRight
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
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
  object lbList: TListBox
    Left = 0
    Top = 0
    Width = 319
    Height = 265
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = lbListDblClick
    OnKeyDown = lbListKeyDown
  end
  object oqType: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  ryda.editfeeders_pg.get_metertypedict(:acur_t); '
      'end;')
    Left = 588
    Top = 122
    ParamData = <
      item
        DataType = ftCursor
        Name = 'ACUR_T'
        ParamType = ptOutput
        Value = 'Object'
      end>
    object oqTypeNMETERTYPE: TFloatField
      FieldName = 'NMETERTYPE'
      Required = True
    end
    object oqTypeVNAME: TStringField
      FieldName = 'VNAME'
      Size = 256
    end
    object oqTypeDIGITS: TFloatField
      FieldName = 'DIGITS'
    end
    object oqTypeMCURRENT: TFloatField
      FieldName = 'MCURRENT'
    end
    object oqTypeMPOWER: TFloatField
      FieldName = 'MPOWER'
    end
    object oqTypeMCONST: TFloatField
      FieldName = 'MCONST'
    end
    object oqTypeMCLASS: TFloatField
      FieldName = 'MCLASS'
    end
  end
end
