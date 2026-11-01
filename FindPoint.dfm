object fmFindPoint: TfmFindPoint
  Left = 603
  Top = 236
  HelpContext = 27031
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 467
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 16
    Top = 8
    Width = 329
    Height = 353
    TabOrder = 13
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 79
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 46
      Width = 68
      Height = 13
      Caption = #1050#1088#1072#1090#1082#1086#1077' '#1080#1084#1103':'
    end
    object Label7: TLabel
      Left = 8
      Top = 76
      Width = 66
      Height = 13
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
    end
    object Label3: TLabel
      Left = 8
      Top = 106
      Width = 85
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1095#1080#1082#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 138
      Width = 65
      Height = 13
      Caption = #1048#1076'. '#1086#1073#1098#1077#1082#1090#1072':'
    end
    object Label5: TLabel
      Left = 8
      Top = 170
      Width = 81
      Height = 13
      Caption = #1057#1074#1103#1079#1085#1086#1081' '#1085#1086#1084#1077#1088':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 198
      Width = 53
      Height = 13
      Caption = #1050#1086#1076' '#1090#1086#1095#1082#1080':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label40: TLabel
      Left = 8
      Top = 230
      Width = 50
      Height = 13
      Caption = #1051#1080#1094'/'#1089#1095#1077#1090':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 256
      Width = 78
      Height = 13
      Caption = #1048#1076'. '#1090#1086#1095#1082#1080' ('#1076#1086#1087'):'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 8
      Top = 292
      Width = 113
      Height = 13
      Caption = #1057#1074#1103#1079#1085#1086#1081' '#1082#1086#1076' '#1080#1084#1087#1086#1088#1090#1072':'
    end
    object Label10: TLabel
      Left = 8
      Top = 323
      Width = 109
      Height = 13
      Caption = #1050#1086#1076' '#1089#1090#1088#1086#1082#1080' '#1074' '#1084#1072#1082#1077#1090#1077':'
    end
  end
  object Edit1: TEdit
    Left = 152
    Top = 18
    Width = 180
    Height = 21
    MaxLength = 150
    TabOrder = 0
    OnChange = EditChange
  end
  object Edit2: TEdit
    Left = 152
    Top = 202
    Width = 180
    Height = 21
    MaxLength = 63
    TabOrder = 2
    OnChange = EditChange
  end
  object Edit3: TEdit
    Left = 152
    Top = 112
    Width = 180
    Height = 21
    MaxLength = 63
    TabOrder = 3
    OnChange = EditChange
  end
  object Edit4: TEdit
    Left = 152
    Top = 262
    Width = 180
    Height = 21
    MaxLength = 63
    TabOrder = 4
    OnChange = EditChange
  end
  object Edit5: TEdit
    Left = 152
    Top = 172
    Width = 180
    Height = 21
    MaxLength = 63
    TabOrder = 5
    OnChange = EditChange
  end
  object Edit25: TEdit
    Left = 152
    Top = 235
    Width = 180
    Height = 21
    MaxLength = 31
    TabOrder = 1
    OnChange = EditChange
  end
  object Panel1: TPanel
    Left = 0
    Top = 436
    Width = 359
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object bbOk: TBitBtn
      Left = 44
      Top = 2
      Width = 89
      Height = 25
      Caption = #1053#1072#1081#1090#1080
      Default = True
      TabOrder = 0
      OnClick = bbOkClick
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
      Left = 140
      Top = 2
      Width = 89
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      Kind = bkCancel
    end
    object BitBtn1: TBitBtn
      Left = 236
      Top = 2
      Width = 89
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 2
      OnClick = BitBtn1Click
      Glyph.Data = {
        AA030000424DAA03000000000000360000002800000011000000110000000100
        18000000000074030000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF2424731C1C71A9A9CBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFA4A4CC1D1D731F1F7200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF121275
        000067303088C8C8E4FFFFFFFFFFFFFFFFFFFFFFFFC4C4E32E2E8B00006B0B0B
        7400C29F57C19130BF8F2DBF8F2DBF8F2D543F6103028800008A251C7C9B7341
        BF8F2DBF8F2D967046231A7C00008904038A52447900BD9238E3CDA1E2CC9FE2
        CC9FE2CC9FD5C09E695EA30606AA0000A72D29A1BEABA4BCAAA42B26A50000A6
        0606A96F64A6B38A3D00C89E48FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5FC76
        76DA0606C20000BE3A3AD03636CD0000BD0505C07979E1F8F8FDC89E4800C69B
        45FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5FC8080E50909CD0000CA00
        00CA0C0CCD8686E7F8F8FEFFFFFFC69B4500C79B45FFFFFFFBFBFCFBFBFBFBFB
        FBFBFBFBFBFBFBFBFBFBC0C0EF2D2DD41414D11212D13030D6C8C8F2FBFBFCFF
        FFFFC79B4500C79B44FFFFFFF4F5F5F5F6F4F5F6F4F5F6F4F5F6F4D0D1EE6161
        DE3535D63737D63535D73333D65858DCD0D1EFFFFFFFC89B4500C59941FDFFFF
        EDEEEDF0F0EFF0F0EFF0F0EFCDCDEB6060DC3E3ED84141D98D8DE28989E24040
        D93D3DD96162DCDADBF8C89D4700C39541FBFFFFE8E7E6EBEAE9EBEAE9C6C6E6
        6969DE4B4BDB4F4FDC9291E1E6E5E8E4E3E88C8CE15656DD5656DD7676E4AB8C
        6C00C39542F9FCFFE0E0E0E5E4E3E5E4E38181E16B6BE16D6DE19796E1DEDDE3
        E5E4E3E5E4E3DBDAE39B9AE27C7CE57E7EE5867EC600C49643F4F8FFD6D5D3DC
        DBD9DCDBD98686E58080E69595DFD5D4D9DCDBD9DCDBD9DCDBD9DCDBD9D4D3DA
        9C9CDF8A8AE78E8DE600C59643F5FCFFDCE2E8E1E6ECE1E6ECA5A7E99EA0E8C1
        C5E9E1E6ECE1E6ECE1E6ECE1E6ECE1E6ECE1E6ECC0C4E7A7A9EEA093B700C395
        3DFBEEDAF7DFBBF7E2C1F7E2C1F7E2C1F7E2C1F7E2C1F7E2C1F7E2C1F7E2C1F7
        E2C1F7E2C1F7E2C1F7DFBBFBEEDAC79B4700C49438EABF7AD08508D4901ED490
        1DD4901DD4901DD4901DD4901DD4901DD4901DD4901DD4901DD4901ED08508EB
        BF7BC89B4600C28F2CEFCF99E5BC75E6C07BE6BF7BE6BF7BE6BF7BE6BF7BE6BF
        7BE6BF7BE6BF7BE6BF7BE6BF7BE7C07CE5BD75F0D19BC7993F00C69D4DBC871F
        BD8A23BD8A23BD8A23BD8A23BD8A23BD8A23BD8A23BD8A23BD8A23BD8A23BD8B
        24C0902EC29335C29233CBA45900}
    end
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 360
    Width = 329
    Height = 73
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1087#1086#1080#1089#1082#1072
    TabOrder = 7
    object Edit6: TEdit
      Left = 16
      Top = 24
      Width = 185
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0/0'
    end
    object UpDown1: TUpDown
      Left = 216
      Top = 24
      Width = 49
      Height = 25
      Min = 0
      Orientation = udHorizontal
      Position = 0
      TabOrder = 1
      Wrap = False
      OnChangingEx = UpDown1ChangingEx
    end
  end
  object Edit7: TEdit
    Left = 152
    Top = 48
    Width = 180
    Height = 21
    MaxLength = 50
    TabOrder = 8
  end
  object Edit8: TEdit
    Left = 152
    Top = 78
    Width = 180
    Height = 21
    MaxLength = 250
    TabOrder = 9
  end
  object Edit9: TEdit
    Left = 152
    Top = 144
    Width = 180
    Height = 21
    MaxLength = 63
    TabOrder = 10
  end
  object Edit10: TEdit
    Left = 152
    Top = 296
    Width = 180
    Height = 21
    MaxLength = 64
    TabOrder = 11
  end
  object Edit11: TEdit
    Left = 152
    Top = 328
    Width = 180
    Height = 21
    MaxLength = 64
    TabOrder = 12
  end
end
