inherited FormParamCommunicationServer: TFormParamCommunicationServer
  Top = 164
  HelpContext = 532
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1082#1086#1084#1084#1091#1085#1080#1082#1072#1094#1080#1086#1085#1085#1086#1075#1086' '#1089#1077#1088#1074#1077#1088#1072
  ClientHeight = 198
  ClientWidth = 463
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited iplBottom: TPanel
    Top = 173
    Width = 463
    TabOrder = 1
    inherited btnRefresh: TBitBtn
      TabOrder = 1
    end
    inherited iplClose: TPanel
      Left = 382
      TabOrder = 3
    end
    inherited btnSave: TBitBtn
      TabOrder = 0
    end
    object btMessage: TButton
      Left = 208
      Top = 1
      Width = 75
      Height = 25
      Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1103
      TabOrder = 2
      OnClick = btMessageClick
    end
  end
  object Panel5: TPanel [1]
    Left = 0
    Top = 0
    Width = 463
    Height = 173
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 0
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 461
      Height = 41
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '      '#1044#1086#1087#1091#1089#1090#1080#1084#1086#1077' '#1088#1072#1089#1093#1086#1078#1076#1077#1085#1080#1077' '#1074#1088#1077#1084#1077#1085#1080' [c]'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object MaskEdit1: TMaskEdit
        Left = 294
        Top = 8
        Width = 139
        Height = 24
        EditMask = '######;0; '
        MaxLength = 6
        TabOrder = 0
        OnChange = ChangeData
      end
    end
    object Panel7: TPanel
      Left = 1
      Top = 42
      Width = 461
      Height = 41
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '      '#1055#1088#1077#1076#1077#1083#1100#1085#1086#1077' '#1088#1072#1089#1093#1086#1078#1076#1077#1085#1080#1077' '#1074#1088#1077#1084#1077#1085#1080' [c]'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object MaskEdit2: TMaskEdit
        Left = 294
        Top = 10
        Width = 139
        Height = 24
        EditMask = '######;0; '
        MaxLength = 6
        TabOrder = 0
        OnChange = ChangeData
      end
    end
    object Panel8: TPanel
      Left = 1
      Top = 108
      Width = 461
      Height = 64
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object CheckBox1: TCheckBox
        Left = 18
        Top = 8
        Width = 275
        Height = 17
        Caption = '&'#1050#1086#1088#1088#1077#1082#1094#1080#1103' '#1095#1072#1089#1086#1074
        TabOrder = 0
        OnClick = ChangeData
      end
      object CheckBox4: TCheckBox
        Left = 18
        Top = 38
        Width = 273
        Height = 17
        Caption = '&'#1047#1072#1087#1080#1089#1100' '#1090#1077#1082#1091#1097#1080#1093' '#1075#1086#1076#1086#1074#1099#1093' '#1087#1086#1082#1072#1079#1072#1085#1080#1081
        TabOrder = 1
        OnClick = ChangeData
      end
    end
  end
  inherited alDefault: TActionList
    object aClockCorrect: TAction
      Caption = '&'#1050#1086#1088#1088#1077#1082#1094#1080#1103' '#1095#1072#1089#1086#1074
      ShortCut = 32850
      OnExecute = aExecute
    end
    object aWriteCurrYear: TAction
      Caption = '&'#1047#1072#1087#1080#1089#1100' '#1090#1077#1082#1091#1097#1080#1093' '#1075#1086#1076#1086#1074#1099#1093' '#1087#1086#1082#1072#1079#1072#1085#1080#1081
      ShortCut = 32848
      OnExecute = aExecute
    end
  end
  object ActionList1: TActionList
    Left = 417
    Top = 203
    object aSave: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ShortCut = 113
    end
    object aCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ShortCut = 114
    end
    object aClose: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ShortCut = 121
    end
  end
end
