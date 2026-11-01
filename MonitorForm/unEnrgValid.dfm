object fmEnrgValid: TfmEnrgValid
  Left = 299
  Top = 262
  Width = 606
  Height = 495
  HelpContext = 2807101
  Caption = #1052#1077#1090#1082#1072' '#1082#1072#1095#1077#1089#1090#1074#1072' '#1101#1083#1077#1082#1090#1088#1086#1101#1085#1077#1088#1075#1080#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 432
    Width = 598
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 368
      Top = 0
      Width = 230
      Height = 36
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnClose: TButton
        Left = 151
        Top = 6
        Width = 75
        Height = 25
        Caption = #1047#1072#1082#1088#1099#1090#1100
        ModalResult = 2
        TabOrder = 0
      end
    end
  end
  object pnlRequir: TPanel
    Left = 0
    Top = 0
    Width = 598
    Height = 432
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 598
      Height = 37
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblRequir: TLabel
        Left = 30
        Top = 10
        Width = 64
        Height = 16
        Caption = 'lblRequir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 37
      Width = 598
      Height = 395
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object pcUnRequir: TPageControl
        Left = 0
        Top = 0
        Width = 598
        Height = 395
        ActivePage = tsGOST
        Align = alClient
        TabIndex = 0
        TabOrder = 0
        object tsGOST: TTabSheet
          Caption = #1043#1054#1057#1058' 13109'
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1059#1089#1090#1072#1085#1086#1074#1080#1074#1096#1077#1077#1089#1103' '#1086#1090#1082#1083#1086#1085#1077#1085#1080#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103
            TabOrder = 0
            object QuatImage1: TImage
              Tag = 3
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel6: TPanel
            Left = 0
            Top = 30
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1056#1072#1079#1084#1072#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1081
            TabOrder = 1
            object Image1: TImage
              Tag = 4
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel7: TPanel
            Tag = 5
            Left = 0
            Top = 60
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1044#1086#1079#1072' '#1092#1083#1080#1082#1077#1088#1072
            TabOrder = 2
            object Image2: TImage
              Tag = 5
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel8: TPanel
            Tag = 6
            Left = 0
            Top = 90
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = 
              '           '#1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1080#1089#1082#1072#1078#1077#1085#1080#1103' '#1089#1080#1085#1091#1089#1086#1080#1076#1072#1083#1100#1085#1086#1089#1090#1080' '#1082#1088#1080#1074#1086#1081' '#1085#1072#1087#1088#1103#1078#1077 +
              #1085#1080#1103
            TabOrder = 3
            object Image3: TImage
              Tag = 6
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel9: TPanel
            Tag = 7
            Left = 0
            Top = 120
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = 
              '           '#1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' n-'#1086#1081' '#1075#1072#1088#1084#1086#1085#1080#1095#1077#1089#1082#1086#1081' '#1089#1086#1089#1090#1072#1074#1083#1103#1102#1097#1077#1081' '#1085#1072#1087#1088#1103#1078#1077#1085#1080 +
              #1103
            TabOrder = 4
            object Image4: TImage
              Tag = 7
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel10: TPanel
            Tag = 8
            Left = 0
            Top = 150
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1085#1077#1089#1080#1084#1084#1077#1090#1088#1080#1080' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1081
            TabOrder = 5
            object Image5: TImage
              Tag = 8
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel11: TPanel
            Tag = 9
            Left = 0
            Top = 180
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1054#1090#1082#1083#1086#1085#1077#1085#1080#1077' '#1095#1072#1089#1090#1086#1090#1099
            TabOrder = 6
            object Image6: TImage
              Tag = 9
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel12: TPanel
            Tag = 10
            Left = 0
            Top = 210
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1087#1088#1086#1074#1072#1083#1072' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103
            TabOrder = 7
            object Image7: TImage
              Tag = 10
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel13: TPanel
            Tag = 11
            Left = 0
            Top = 240
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1048#1084#1087#1091#1083#1100#1089#1085#1086#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1077
            TabOrder = 8
            object Image8: TImage
              Tag = 11
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel14: TPanel
            Tag = 12
            Left = 0
            Top = 270
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099' '#1074#1088#1077#1084#1077#1085#1085#1086#1075#1086' '#1087#1077#1088#1077#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103
            TabOrder = 9
            object Image9: TImage
              Tag = 12
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
        end
        object tsEN: TTabSheet
          Caption = 'EN 50160'
          ImageIndex = 1
          object Panel15: TPanel
            Left = 0
            Top = 0
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1054#1090#1082#1083#1086#1085#1077#1085#1080#1077' '#1095#1072#1089#1090#1086#1090#1099' (Frequency variations)'
            TabOrder = 0
            object Image10: TImage
              Tag = 13
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel16: TPanel
            Left = 0
            Top = 30
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1054#1090#1082#1083#1086#1085#1077#1085#1080#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103' (Voltage variations)'
            TabOrder = 1
            object Image11: TImage
              Tag = 14
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel17: TPanel
            Left = 0
            Top = 60
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1041#1099#1089#1090#1088#1099#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103' (Rapid voltage changes)'
            TabOrder = 2
            object Image12: TImage
              Tag = 15
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel18: TPanel
            Left = 0
            Top = 90
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1044#1086#1079#1072' '#1092#1083#1080#1082#1077#1088#1072' (Flicker)'
            TabOrder = 3
            object Image13: TImage
              Tag = 16
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel19: TPanel
            Left = 0
            Top = 120
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1055#1088#1086#1074#1072#1083#1099' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103' (Voltage dips)'
            TabOrder = 4
            object Image14: TImage
              Tag = 17
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel20: TPanel
            Left = 0
            Top = 150
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1054#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103' (Voltage interruptions)'
            TabOrder = 5
            object Image15: TImage
              Tag = 18
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel21: TPanel
            Left = 0
            Top = 180
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1042#1088#1077#1084#1077#1085#1085#1099#1077' '#1087#1077#1088#1077#1085#1072#1087#1088#1103#1077#1085#1080#1103' (Temporary overvoltages)'
            TabOrder = 6
            object Image16: TImage
              Tag = 19
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel22: TPanel
            Left = 0
            Top = 210
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1048#1084#1087#1091#1083#1100#1089#1085#1099#1077' '#1087#1077#1088#1077#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103' (Transient overvoltages)'
            TabOrder = 7
            object Image17: TImage
              Tag = 20
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel23: TPanel
            Left = 0
            Top = 240
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1053#1077#1089#1080#1084#1084#1077#1090#1088#1080#1103' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1081' (Voltage unbalance)'
            TabOrder = 8
            object Image18: TImage
              Tag = 21
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel24: TPanel
            Left = 0
            Top = 270
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1075#1072#1088#1084#1086#1085#1080#1082' (Harmonic voltage)'
            TabOrder = 9
            object Image19: TImage
              Tag = 22
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel25: TPanel
            Left = 0
            Top = 300
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = '           '#1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1080#1085#1090#1077#1088#1075#1072#1088#1084#1086#1085#1080#1082' (Interharmonic voltage)'
            TabOrder = 10
            object Image20: TImage
              Tag = 23
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
          object Panel26: TPanel
            Left = 0
            Top = 330
            Width = 590
            Height = 30
            Align = alTop
            Alignment = taLeftJustify
            Caption = 
              '           '#1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1089#1080#1075#1085#1072#1083#1086#1074' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103' (Mains signaling volta' +
              'ge)'
            TabOrder = 11
            object Image21: TImage
              Tag = 24
              Left = 5
              Top = 6
              Width = 16
              Height = 16
            end
          end
        end
      end
    end
  end
  object ImageList1: TImageList
    Left = 330
    Top = 70
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000F6F6F700D7D8D900D0D1D200D0D1
      D200D0D1D200D0D1D200D0D1D200D0D1D200D0D1D200D0D1D200D0D1D200D0D1
      D200D0D1D200D0D1D200E8E8E900FEFEFE00F6F6F700D9DADA00D2D2D300D2D2
      D300D2D2D300D2D2D300D2D2D300D2D2D300D2D2D300D2D2D300D2D2D300D2D2
      D300D2D2D300D2D2D300E8E8E900FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008B8C8F003A3D4100373A3F00373A
      3F00373A3F00373A3F00373A3F00373A3F00373A3F00373A3F00373A3F00373A
      3F00373A3F0035383D006A6C6F00E6E6E7008F9092003A3D4100373A3F00373A
      3F00373A3F00373A3F00373A3F00373A3F00373A3F00373A3F00373A3F00373A
      3F00373A3F0036393E006D707300E8E8E9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ABACAD00D5D5D600D5D5D600D5D5
      D600D5D5D600D5D5D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600DBDBDB0034363A00D0D1D200A4A5A700D5D5D600D5D5D600D5D5
      D600D5D5D600D5D5D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600DADADA0036393D00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B3B3B400DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DFDEE100E0DFE300DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDC00DFDFE00035373C00CECFD000ABACAE00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDC00DEDEDF00383A3F00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BABABB00E3E3E200E3E3E200E3E3
      E200E3E3E200E4E3E30063893E0033660200EAE8EE00E2E2E300E2E2E300E2E2
      E300E3E3E400E7E7E80035373C00CECFD000B2B3B400E3E3E200E3E3E200E3E3
      E200E3E3E200E3E3E200E2E2E300E2E2E300E2E2E300E2E2E300E2E2E300E2E2
      E300E3E3E400E7E7E800383A3F00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C1C200EAEAEA00EAEAEA00EAEA
      EA00EAEAEA00F5F1F9002F7100003A78000094B37A00EBEBEA00EBEBEA00EBEB
      EA00EAEAEB00EEEEEF0035373C00CECFD000B9B9BA00EAEAEA00EAEAEA00EAEA
      EA00EAEAEA00EAEAEA00EBEBEA00EBEBEA00EBEBEA00EBEBEA00EBEBEA00EBEB
      EA00EAEAEB00EEEEEF00373A3F00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C7C8C900F2F2F200F2F2F200F2F2
      F200F2F2F200C0D4B1003D8600003D86000034810000F3F3F300F2F2F200F2F2
      F200F3F3F300F8F8F80035363B00CECFD000BFC0C100F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200F3F3F300F7F7F700373A3F00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CECECF00F9F9F900F9F9F900F9F9
      F900FBFAFC00549E1F003F920000368D00003F9200003D910400FFFEFF00FAFA
      FA00FAFAFA00FFFFFF0034363B00CECFD000C5C6C700F9F9F900F9F9F900F9F9
      F900F9F9F900F9F9F900FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFA
      FA00FAFAFA00FEFEFE00373A3E00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D3D4D500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00358C0000328B0000FFFFFF0084B95C003D9100009FC98100FFFF
      FF00FFFFFF00FFFFFF0035383D00CECFD000CACBCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00373A3E00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D3D4D500FFFFFF00FFFFFF00FFFF
      FF00ACD093003E920000C6DEB300FFFFFF00FFFFFF00B9D7A10030890000FAFC
      F800FFFFFF00FFFFFF0035383D00CECFD000CACBCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00373A3E00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D3D4D500FFFFFF00FFFFFF00FFFF
      FF003D91010048971000FFFFFF00FFFFFF00FFFFFF00FFFFFF00E5F0DC00348C
      0000FFFFFF00FFFFFF0035383D00CECFD000CACBCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00373A3E00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D3D4D500FFFFFF00FFFFFF00FFFF
      FF00328A0000F4F8EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F0F6EB00FFFFFF0035383D00CECFD000CACBCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00373A3E00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D3D4D500FFFFFF00FFFFFF00B0D3
      960090C06C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0035383D00CECFD000CACBCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00373A3E00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D3D4D500FFFFFF00FFFFFF00A6CD
      8A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0035383D00CECFD000CACBCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00373A3E00D0D1D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D4D4D500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00393C4000D7D8D900CACBCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF003B3D4100D9DADA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000061636600CCCCCD00CBCBCC00CBCB
      CC00CBCBCC00CBCBCC00CBCBCC00CBCBCC00CBCBCC00CBCBCC00CBCBCC00CBCB
      CC00CBCBCC00CECECF008F909300F6F6F7005E606300CDCDCE00CBCBCC00CBCB
      CC00CBCBCC00CBCBCC00CBCBCC00CBCBCC00CBCBCC00CBCBCC00CBCBCC00CBCB
      CC00CBCBCC00CECFD0008E8F9100F6F6F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object ActionList1: TActionList
    Left = 436
    Top = 20
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 27
      OnExecute = Action1Execute
    end
  end
end
