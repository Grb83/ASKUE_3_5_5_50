object fmDuplicateCnt_PS_TU: TfmDuplicateCnt_PS_TU
  Left = 326
  Top = 306
  ActiveControl = bbTree
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1055#1057'/'#1058#1059
  ClientHeight = 253
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 220
    Width = 391
    Height = 33
    Align = alBottom
    TabOrder = 0
    object bbOK: TBitBtn
      Left = 226
      Top = 4
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = bbOKClick
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
    object bbCancel: TBitBtn
      Left = 306
      Top = 4
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 391
    Height = 220
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 11
      Width = 18
      Height = 13
      Caption = #1058#1059':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 26
      Top = 39
      Width = 10
      Height = 13
      Caption = 'C:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 26
      Top = 68
      Width = 19
      Height = 13
      Caption = #1055#1054':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 96
      Width = 73
      Height = 13
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edTU: TEdit
      Left = 54
      Top = 7
      Width = 277
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 5
    end
    object bbTree: TBitBtn
      Left = 337
      Top = 7
      Width = 22
      Height = 20
      Caption = '...'
      TabOrder = 0
      OnClick = bbTreeClick
    end
    object mmComment: TMemo
      Left = 1
      Top = 112
      Width = 389
      Height = 107
      Hint = #1055#1088#1080#1095#1080#1085#1072' '#1087#1077#1088#1077#1082#1083#1102#1095#1077#1085#1080#1103'.'
      Align = alBottom
      MaxLength = 512
      TabOrder = 4
    end
    object dtpFrom: TDateTimePicker
      Left = 54
      Top = 35
      Width = 307
      Height = 21
      CalAlignment = dtaLeft
      Date = 38575.4185317824
      Time = 38575.4185317824
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object dtpTo: TDateTimePicker
      Left = 53
      Top = 64
      Width = 308
      Height = 21
      CalAlignment = dtaLeft
      Date = 38575.4186491551
      Time = 38575.4186491551
      DateFormat = dfShort
      DateMode = dmComboBox
      Enabled = False
      Kind = dtkDate
      ParseInput = False
      TabOrder = 3
    end
    object chbDateTo: TCheckBox
      Left = 365
      Top = 66
      Width = 21
      Height = 17
      Caption = '   '
      TabOrder = 2
      OnClick = chbDateToClick
    end
  end
end
