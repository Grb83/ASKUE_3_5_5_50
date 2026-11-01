object FormSetPasword: TFormSetPasword
  Left = 130
  Top = 169
  HelpContext = 430
  ActiveControl = me1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1084#1077#1085#1072' '#1087#1072#1088#1086#1083#1103
  ClientHeight = 201
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 201
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 3
    Caption = ' '
    TabOrder = 0
    object Label2: TLabel
      Left = 48
      Top = 20
      Width = 102
      Height = 16
      Caption = #1057#1090#1072#1088#1099#1081' '#1087#1072#1088#1086#1083#1100':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 48
      Top = 70
      Width = 96
      Height = 16
      Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 48
      Top = 120
      Width = 124
      Height = 16
      Caption = #1055#1086#1074#1090#1086#1088#1080#1090#1100' '#1087#1072#1088#1086#1083#1100':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object btOk: TBitBtn
      Left = 78
      Top = 164
      Width = 97
      Height = 25
      Caption = 'OK'
      Default = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btOkClick
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
    object BitBtn2: TBitBtn
      Left = 280
      Top = 164
      Width = 101
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Kind = bkCancel
    end
    object me1: TMaskEdit
      Left = 196
      Top = 20
      Width = 217
      Height = 21
      CharCase = ecLowerCase
      MaxLength = 47
      PasswordChar = '#'
      TabOrder = 0
    end
    object me3: TMaskEdit
      Left = 198
      Top = 120
      Width = 217
      Height = 21
      CharCase = ecLowerCase
      MaxLength = 47
      PasswordChar = '#'
      TabOrder = 2
    end
    object me2: TMaskEdit
      Left = 196
      Top = 70
      Width = 217
      Height = 21
      CharCase = ecLowerCase
      MaxLength = 47
      PasswordChar = '#'
      TabOrder = 1
    end
  end
end
