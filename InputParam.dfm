object FormInputParam: TFormInputParam
  Left = 504
  Top = 192
  HelpContext = 518
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076' '#1087#1086#1087#1088#1072#1074#1086#1082
  ClientHeight = 327
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 107
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 400
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '             '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object Label7: TLabel
        Left = 6
        Top = 8
        Width = 63
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = #1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        Layout = tlCenter
      end
      object Edit1: TEdit
        Left = 78
        Top = 2
        Width = 313
        Height = 24
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 35
      Width = 400
      Height = 34
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 18
        Top = 12
        Width = 53
        Height = 13
        Caption = #1055#1077#1088#1080#1086#1076' '#1089' :'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Label2: TLabel
        Left = 222
        Top = 12
        Width = 18
        Height = 13
        Alignment = taCenter
        Caption = #1087#1086' :'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object edFrom: TMaskEdit
        Left = 178
        Top = 10
        Width = 36
        Height = 21
        AutoSelect = False
        EditMask = '!99:99;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 1
        Text = '00:00'
      end
      object dtFrom: TDateTimePicker
        Left = 78
        Top = 10
        Width = 90
        Height = 21
        CalAlignment = dtaLeft
        Date = 38818.6883014815
        Time = 38818.6883014815
        DateFormat = dfShort
        DateMode = dmComboBox
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Kind = dtkDate
        ParseInput = False
        ParentFont = False
        TabOrder = 0
      end
      object dtTill: TDateTimePicker
        Left = 252
        Top = 10
        Width = 90
        Height = 21
        CalAlignment = dtaLeft
        Date = 38818.6885512268
        Time = 38818.6885512268
        DateFormat = dfShort
        DateMode = dmComboBox
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Kind = dtkDate
        ParseInput = False
        ParentFont = False
        TabOrder = 2
      end
      object edTill: TMaskEdit
        Left = 352
        Top = 10
        Width = 36
        Height = 21
        AutoSelect = False
        EditMask = '!99:99;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 3
        Text = '00:00'
      end
    end
    object Cb_delete_all: TCheckBox
      Left = 8
      Top = 68
      Width = 375
      Height = 17
      Caption = #1059#1076#1072#1083#1103#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1089#1098#1077#1084#1072
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object cb_small_val: TCheckBox
      Left = 8
      Top = 82
      Width = 225
      Height = 17
      Caption = #1042#1074#1086#1076#1080#1090#1100' '#1084#1072#1083#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
      TabOrder = 3
    end
  end
  object Panel7: TPanel
    Left = 0
    Top = 107
    Width = 400
    Height = 188
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 1
    object Panel15: TPanel
      Left = 0
      Top = 122
      Width = 400
      Height = 62
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '       '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
      object Label6: TLabel
        Left = 5
        Top = 38
        Width = 93
        Height = 13
        Caption = #1056#1072#1089#1093#1086#1076' Q4, '#1082#1042#1040#1088#1095':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Label4: TLabel
        Left = 5
        Top = 7
        Width = 93
        Height = 13
        Caption = #1056#1072#1089#1093#1086#1076' R -, '#1082#1042#1040#1088#1095':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Edit6: TEdit
        Left = 106
        Top = 1
        Width = 285
        Height = 24
        TabOrder = 0
        OnChange = OnChange
        OnKeyPress = edLongKeyPess
      end
      object Edit7: TEdit
        Left = 106
        Top = 32
        Width = 285
        Height = 24
        AutoSize = False
        TabOrder = 1
        OnChange = OnChange
        OnKeyPress = edLongKeyPess
      end
    end
    object Panel16: TPanel
      Left = 0
      Top = 60
      Width = 400
      Height = 62
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '         '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Visible = False
      object Label3: TLabel
        Left = 5
        Top = 7
        Width = 99
        Height = 13
        Caption = #1056#1072#1089#1093#1086#1076' R +, '#1082#1042#1040#1088#1095': '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Label5: TLabel
        Left = 5
        Top = 39
        Width = 96
        Height = 13
        Caption = #1056#1072#1089#1093#1086#1076' Q2, '#1082#1042#1040#1088#1095': '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Edit5: TEdit
        Left = 106
        Top = 33
        Width = 285
        Height = 24
        TabOrder = 1
        OnChange = OnChange
        OnKeyPress = edLongKeyPess
      end
      object Edit2: TEdit
        Left = 106
        Top = 2
        Width = 285
        Height = 24
        TabOrder = 0
        OnChange = OnChange
        OnKeyPress = edLongKeyPess
      end
    end
    object Panel17: TPanel
      Left = 0
      Top = 29
      Width = 400
      Height = 31
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '         '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      object Label9: TLabel
        Left = 5
        Top = 6
        Width = 87
        Height = 13
        Caption = #1056#1072#1089#1093#1086#1076'  '#1040' -, '#1082#1042#1090#1095':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Edit4: TEdit
        Left = 106
        Top = 2
        Width = 285
        Height = 24
        TabOrder = 0
        OnChange = OnChange
        OnKeyPress = edLongKeyPess
      end
    end
    object Panel18: TPanel
      Left = 0
      Top = 0
      Width = 400
      Height = 29
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '         '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Visible = False
      DesignSize = (
        400
        29)
      object Label8: TLabel
        Left = 5
        Top = 5
        Width = 90
        Height = 13
        Caption = #1056#1072#1089#1093#1086#1076'  '#1040' +, '#1082#1042#1090#1095':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Edit3: TEdit
        Left = 106
        Top = 2
        Width = 285
        Height = 24
        Anchors = [akLeft, akTop, akRight, akBottom]
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 0
        OnChange = OnChange
        OnKeyPress = edLongKeyPess
      end
    end
  end
  object Panel10: TPanel
    Left = 0
    Top = 295
    Width = 400
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object BitBtn2: TBitBtn
      Left = 318
      Top = 4
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = BitBtn2Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn1: TBitBtn
      Left = 232
      Top = 4
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      Enabled = False
      TabOrder = 0
      OnClick = BitBtn1Click
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
  end
end
