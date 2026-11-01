object ChangeTransformersForm: TChangeTransformersForm
  Left = 304
  Top = 184
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1040#1090#1088#1080#1073#1091#1090#1099' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088#1072
  ClientHeight = 215
  ClientWidth = 553
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
  object plTitle: TPanel
    Left = 0
    Top = 0
    Width = 553
    Height = 67
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lName: TLabel
      Left = 88
      Top = 11
      Width = 72
      Height = 16
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' :'
    end
    object lData: TLabel
      Left = 88
      Top = 41
      Width = 82
      Height = 16
      Caption = #1044#1072#1090#1072' '#1089#1084#1077#1085#1099' :'
    end
    object DataTPicker: TDateTimePicker
      Left = 192
      Top = 35
      Width = 211
      Height = 24
      CalAlignment = dtaLeft
      Date = 38217.5402050347
      Time = 38217.5402050347
      DateFormat = dfLong
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object NameEdit: TEdit
      Left = 192
      Top = 5
      Width = 233
      Height = 24
      TabStop = False
      Color = clMenu
      ReadOnly = True
      TabOrder = 0
    end
  end
  object plBottom: TPanel
    Left = 0
    Top = 184
    Width = 553
    Height = 31
    Align = alBottom
    TabOrder = 6
    DesignSize = (
      553
      31)
    object CancelBtn: TBitBtn
      Left = 471
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Kind = bkCancel
    end
    object OKBtn: TBitBtn
      Left = 391
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      Enabled = False
      TabOrder = 0
      OnClick = OKBtnClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object m_btnSave: TBitBtn
      Left = 6
      Top = 4
      Width = 131
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083'...'
      TabOrder = 2
      OnClick = m_btnSaveClick
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
  object plTime: TPanel
    Left = 0
    Top = 114
    Width = 553
    Height = 23
    Align = alTop
    Alignment = taLeftJustify
    Caption = '         '#1042#1088#1077#1084#1103' '#1089#1085#1103#1090#1080#1103' '#1080' '#1091#1089#1090#1072#1085#1086#1074#1082#1080':'
    TabOrder = 3
    object GetTimeMEdit: TMaskEdit
      Tag = 12
      Left = 184
      Top = 0
      Width = 185
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 0
      Text = '  :  '
      OnChange = onChange
    end
    object SetTimeMEdit: TMaskEdit
      Tag = 12
      Left = 370
      Top = 0
      Width = 185
      Height = 21
      TabStop = False
      Color = clMenu
      EditMask = '!90:00;1;_'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 1
      Text = '  :  '
    end
  end
  object plVal2: TPanel
    Left = 0
    Top = 160
    Width = 553
    Height = 23
    Align = alTop
    Alignment = taLeftJustify
    Caption = '         '#1042#1090#1086#1088#1080#1095#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' :'
    TabOrder = 5
    object SetVal2Edit: TEdit
      Tag = 11
      Left = 370
      Top = 0
      Width = 185
      Height = 21
      TabOrder = 1
      OnChange = onChange
    end
    object GetVal2Edit: TEdit
      Left = 184
      Top = 0
      Width = 185
      Height = 21
      TabStop = False
      Color = clMenu
      ReadOnly = True
      TabOrder = 0
    end
  end
  object plVal1: TPanel
    Left = 0
    Top = 137
    Width = 553
    Height = 23
    Align = alTop
    Alignment = taLeftJustify
    Caption = '         '#1055#1077#1088#1074#1080#1095#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' :'
    TabOrder = 4
    object GetVal1Edit: TEdit
      Left = 184
      Top = 0
      Width = 185
      Height = 21
      TabStop = False
      Color = clMenu
      ReadOnly = True
      TabOrder = 0
    end
    object SetVal1Edit: TEdit
      Tag = 11
      Left = 370
      Top = 0
      Width = 185
      Height = 21
      TabOrder = 1
      OnChange = onChange
    end
  end
  object plType: TPanel
    Left = 0
    Top = 91
    Width = 553
    Height = 23
    Align = alTop
    Alignment = taLeftJustify
    Caption = '         '#1058#1080#1087' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088#1072' :'
    TabOrder = 2
    object GetTypeEdit: TEdit
      Left = 184
      Top = 0
      Width = 185
      Height = 21
      TabStop = False
      Color = clMenu
      ReadOnly = True
      TabOrder = 0
    end
    object SetTypeEdit: TEdit
      Left = 370
      Top = 0
      Width = 185
      Height = 21
      TabStop = False
      Color = clMenu
      ReadOnly = True
      TabOrder = 1
    end
  end
  object plNames: TPanel
    Left = 0
    Top = 67
    Width = 553
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    Caption = 'plNames'
    TabOrder = 1
    object plName: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 24
      Align = alLeft
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      TabOrder = 0
    end
    object plGetName: TPanel
      Left = 185
      Top = 0
      Width = 185
      Height = 24
      Align = alLeft
      Caption = #1057#1084#1077#1085#1103#1077#1084#1099#1081' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088
      TabOrder = 1
    end
    object plSetName: TPanel
      Left = 370
      Top = 0
      Width = 183
      Height = 24
      Align = alLeft
      Caption = #1059#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1077#1084#1099#1081' '#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088
      TabOrder = 2
    end
  end
  object aSaveDialog: TSaveDialog
    Left = 464
    Top = 32
  end
end
