object FormSetupMonitors: TFormSetupMonitors
  Left = 594
  Top = 337
  HelpContext = 2157
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1080#1083#1077#1081' '#1076#1083#1103' '#1084#1086#1085#1080#1090#1086#1088#1086#1074
  ClientHeight = 597
  ClientWidth = 783
  Color = clBtnFace
  Constraints.MinHeight = 435
  Constraints.MinWidth = 570
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormShow
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 567
    Width = 783
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Panel3: TPanel
      Left = 627
      Top = 0
      Width = 156
      Height = 30
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object BitBtn1: TBitBtn
        Left = 2
        Top = 3
        Width = 75
        Height = 25
        TabOrder = 0
        OnClick = BitBtn1Click
        Kind = bkOK
      end
      object BitBtn2: TBitBtn
        Left = 80
        Top = 3
        Width = 75
        Height = 25
        Caption = #1054#1090#1084#1077#1085#1072
        ModalResult = 2
        TabOrder = 1
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
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 783
    Height = 567
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #1054#1073#1099#1095#1085#1099#1081' '#1084#1086#1085#1080#1090#1086#1088
      object Panel2: TPanel
        Left = 498
        Top = 0
        Width = 277
        Height = 539
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 48
          Height = 13
          Caption = #1064#1088#1080#1092#1090' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelColorFont: TLabel
          Left = 60
          Top = 8
          Width = 145
          Height = 13
          AutoSize = False
          Caption = 'MS Sans Serif,8'
        end
        object Label2: TLabel
          Left = 8
          Top = 52
          Width = 98
          Height = 13
          Caption = #1042#1099#1089#1086#1090#1072' '#1089#1090#1088#1086#1082#1080' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 8
          Top = 96
          Width = 165
          Height = 13
          Caption = #1064#1080#1088#1080#1085#1072' '#1082#1086#1083#1086#1085#1082#1080' '#1089' '#1095#1080#1089#1083#1086#1084' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object Label4: TLabel
          Left = 64
          Top = 24
          Width = 214
          Height = 13
          Caption = #1064#1080#1088#1080#1085#1072' '#1082#1086#1083#1086#1085#1082#1080' '#1089' '#1080#1084#1077#1085#1077#1084' '#1075#1088#1091#1087#1087#1099' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object ButtonColorFont: TButton
          Left = 8
          Top = 24
          Width = 25
          Height = 25
          Caption = '...'
          TabOrder = 0
          OnClick = ButtonColorFontClick
        end
        object EditColorHeight: TEdit
          Left = 8
          Top = 68
          Width = 81
          Height = 21
          TabOrder = 1
          Text = '10'
          OnChange = EditColorHeightChange
        end
        object UpDownColorHeight: TUpDown
          Left = 89
          Top = 68
          Width = 16
          Height = 21
          Associate = EditColorHeight
          Min = 10
          Position = 10
          TabOrder = 4
          Wrap = False
        end
        object EditColorWidthDigit: TEdit
          Left = 8
          Top = 114
          Width = 81
          Height = 21
          TabOrder = 2
          Text = '80'
          OnChange = EditColorHeightChange
        end
        object UpDownColorWidthDigit: TUpDown
          Left = 89
          Top = 114
          Width = 16
          Height = 21
          Associate = EditColorWidthDigit
          Min = 10
          Max = 400
          Position = 80
          TabOrder = 9
          Wrap = False
        end
        object RadioGroupProfilePower: TRadioGroup
          Left = 0
          Top = 379
          Width = 277
          Height = 85
          Align = alBottom
          Caption = #1055#1088#1086#1092#1080#1083#1100' '#1085#1072#1075#1088#1091#1079#1082#1080
          Items.Strings = (
            '60 '#1084#1080#1085#1091#1090
            '30 '#1084#1080#1085#1091#1090)
          TabOrder = 7
          OnClick = RadioGroupProfilePowerClick
        end
        object RadioGroupPowerCoeff: TRadioGroup
          Left = 0
          Top = 464
          Width = 277
          Height = 75
          Align = alBottom
          Caption = #1060#1086#1088#1084#1072#1090' '#1087#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1076#1072#1085#1085#1099#1093
          Items.Strings = (
            #1082#1042#1090#1095'/'#1082#1042#1040#1088#1095
            #1090#1099#1089'.'#1082#1042#1090#1095'/'#1090#1099#1089'.'#1082#1042#1040#1088#1095)
          TabOrder = 8
          OnClick = RadioGroupPowerCoeffClick
        end
        object GroupBox1: TGroupBox
          Left = 0
          Top = 216
          Width = 277
          Height = 73
          Align = alBottom
          Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1101#1082#1089#1087#1086#1088#1090#1072' '#1076#1072#1085#1085#1099#1093
          TabOrder = 5
          object Label9: TLabel
            Left = 8
            Top = 20
            Width = 190
            Height = 13
            Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1094#1077#1083#1086#1081' '#1080' '#1076#1088#1086#1073#1085#1086#1081' '#1095#1072#1089#1090#1080': '
          end
          object cbFormatPnt: TComboBox
            Left = 200
            Top = 16
            Width = 59
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            Text = #1090#1095#1082' (.)'
            Items.Strings = (
              #1090#1095#1082' (.)'
              #1079#1087#1090' (,)')
          end
          object cbSpecFormat: TCheckBox
            Left = 8
            Top = 44
            Width = 241
            Height = 15
            Caption = #1069#1082#1089#1087#1086#1088#1090' '#1086#1090#1095#1077#1090#1086#1074' '#1074' '#1092#1086#1088#1084#1077' '#1087#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1103
            TabOrder = 1
          end
        end
        object RadioGroupShowValidity: TRadioGroup
          Left = 0
          Top = 289
          Width = 277
          Height = 90
          Align = alBottom
          Caption = #1052#1077#1090#1082#1072' '#1082#1072#1095#1077#1089#1090#1074#1072
          Items.Strings = (
            #1053#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1084#1077#1090#1082#1091' '#1082#1072#1095#1077#1089#1090#1074#1072
            #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1084#1077#1090#1082#1091' '#1082#1072#1095#1077#1089#1090#1074#1072' '#1076#1072#1085#1085#1099#1093
            #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1084#1077#1090#1082#1091' '#1082#1072#1095#1077#1089#1090#1074#1072' '#1101#1083#1077#1082#1090#1088#1086#1101#1085#1077#1088#1075#1080#1080)
          TabOrder = 6
          OnClick = RadioGroupShowValidityClick
        end
        object RadioGroupColWidthName: TRadioGroup
          Left = 0
          Top = 144
          Width = 277
          Height = 73
          Caption = #1064#1080#1088#1080#1085#1072' '#1082#1086#1083#1086#1085#1082#1080' '#1089' '#1080#1084#1077#1085#1077#1084' '#1075#1088#1091#1087#1087#1099' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1096#1080#1088#1080#1085#1072
            #1055#1086' '#1088#1072#1079#1084#1077#1088#1091' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1075#1086)
          ParentFont = False
          TabOrder = 11
        end
        object EditColorWidthName: TEdit
          Left = 168
          Top = 160
          Width = 81
          Height = 21
          TabOrder = 3
          Text = '80'
          OnChange = EditColorHeightChange
        end
        object UpDownColorWidthName: TUpDown
          Left = 249
          Top = 160
          Width = 16
          Height = 21
          Associate = EditColorWidthName
          Min = 10
          Max = 400
          Position = 80
          TabOrder = 10
          Wrap = False
        end
      end
      object PanelColorTable: TPanel
        Left = 0
        Top = 0
        Width = 498
        Height = 539
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object DrawTableColor: TDrawTable
          Left = 0
          Top = 0
          Width = 498
          Height = 539
          Align = alClient
          DefaultDrawing = False
          RowCount = 8
          Options = []
          TabOrder = 0
          ColsWidth = '#128#64'
          RowsHeight = '#21'
          StaticStrings.Strings = (
            #1044#1077#1082#1072#1073#1088#1100
            '01.12'
            '02.12'
            '03.12'
            #1048#1084#1103' '#1075#1083#1072#1074#1085#1086#1081' '#1075#1088#1091#1087#1087#1099
            #1048#1084#1103' '#1087#1086#1076#1075#1088#1091#1087#1087#1099
            #1048#1084#1103' '#1087#1086#1076#1075#1088#1091#1087#1087#1099
            #1048#1084#1103' '#1087#1086#1076#1075#1088#1091#1087#1087#1099)
          VarStrings.Strings = (
            '99 999 999.99'
            ''
            '99 999 999.99'
            ' '
            ''
            '99 999 999.99'
            ''
            '99 999 999.99'
            '99 999 999.99'
            ''
            '99 999 999.99'
            ''
            ''
            '99 999 999.99'
            ''
            '99 999 999.99')
          TabStrings.Strings = (
            
              'c15 m0x09  0x180f# t2 b $m0x05  0x100f# t8 b- $m0x05  0x100f# t8' +
              ' b- $m0x05  0x100f# t8 b- $m0x05  0x100f'
            
              ' t2 b $m0x05  0x100f# b- c28 t42 &m0x01  0x800c#c36 t8 &m0x01  0' +
              'x800c#c36 t8 &m0x01  0x800c#c36 t8 &m0x01  0x800c#c36 t8 &m0x01 ' +
              ' 0x800c'
            
              'c15 $m0x05  0x100f#c36 &m0x01  0x800c#c5 &m0x01  0x800c#c5 &m0x0' +
              '1  0x800c#c5 &m0x01  0x800c#c5 &m0x01  0x800c')
          ColWidths = (
            128
            64
            64
            64
            64)
          RowHeights = (
            21
            21
            21
            21
            21
            21
            21
            21)
        end
      end
    end
    object tsGraph: TTabSheet
      Caption = #1043#1088#1072#1092#1080#1082
      ImageIndex = 4
      object Chart: TChart
        Left = 0
        Top = 0
        Width = 584
        Height = 539
        AllowPanning = pmNone
        AllowZoom = False
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        BackWall.Pen.Visible = False
        PrintProportional = False
        Title.Text.Strings = (
          #1056#1072#1089#1093#1086#1076' '#1101#1083#1077#1082#1090#1088#1086#1101#1085#1077#1088#1075#1080#1080)
        AxisVisible = False
        ClipPoints = False
        Frame.Visible = False
        Legend.Visible = False
        View3D = False
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        View3DOptions.Zoom = 84
        View3DWalls = False
        Align = alClient
        TabOrder = 0
        object cbDiagram: TCheckBox
          Left = 8
          Top = 8
          Width = 97
          Height = 17
          Caption = #1044#1080#1072#1075#1088#1072#1084#1084#1072
          TabOrder = 0
          OnClick = OnViewUpdate
        end
        object Series1: TPieSeries
          Marks.ArrowLength = 8
          Marks.Visible = True
          SeriesColor = clRed
          OtherSlice.Text = 'Other'
          PieValues.DateTime = False
          PieValues.Name = 'Pie'
          PieValues.Multiplier = 1
          PieValues.Order = loNone
        end
      end
      object plGraphParam: TPanel
        Left = 584
        Top = 0
        Width = 191
        Height = 539
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object cbPoints: TCheckBox
          Left = 18
          Top = 16
          Width = 97
          Height = 17
          Caption = #1058#1086#1095#1082#1080
          TabOrder = 0
          OnClick = cbPointsClick
        end
        object cbMarks: TCheckBox
          Left = 18
          Top = 40
          Width = 97
          Height = 17
          Caption = #1047#1085#1072#1095#1077#1085#1080#1103
          TabOrder = 1
          OnClick = cbMarksClick
        end
        object rgDiagramType: TRadioGroup
          Left = 2
          Top = 126
          Width = 189
          Height = 62
          Caption = #1058#1080#1087' '#1076#1080#1072#1075#1088#1072#1084#1084#1099
          ItemIndex = 0
          Items.Strings = (
            #1057#1090#1086#1083#1073#1094#1077#1074#1072#1103' '#1076#1080#1072#1075#1088#1072#1084#1084#1072
            #1050#1088#1091#1075#1086#1074#1072#1103' '#1076#1080#1072#1075#1088#1072#1084#1084#1072)
          TabOrder = 2
          OnClick = OnViewUpdate
        end
        object ChecAddFoBalanse: TRadioGroup
          Left = 2
          Top = 195
          Width = 189
          Height = 62
          Caption = #1055#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1085#1077#1073#1072#1083#1072#1085#1089#1072
          ItemIndex = 0
          Items.Strings = (
            #1054#1090#1085#1086#1089#1080#1090#1077#1083#1100#1085#1072#1103
            #1040#1073#1089#1086#1083#1102#1090#1085#1072#1103)
          TabOrder = 3
          OnClick = ChecAddFoBalanseClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1050#1088#1091#1087#1085#1099#1081' '#1084#1086#1085#1080#1090#1086#1088
      object Panel12: TPanel
        Left = 619
        Top = 0
        Width = 156
        Height = 539
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object Label11: TLabel
          Left = 8
          Top = 8
          Width = 48
          Height = 13
          Caption = #1064#1088#1080#1092#1090' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LabelBWFont: TLabel
          Left = 8
          Top = 24
          Width = 145
          Height = 13
          AutoSize = False
          Caption = 'Courier,12'
        end
        object Label12: TLabel
          Left = 8
          Top = 72
          Width = 98
          Height = 13
          Caption = #1042#1099#1089#1086#1090#1072' '#1089#1090#1088#1086#1082#1080' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 8
          Top = 120
          Width = 114
          Height = 26
          Caption = #1064#1080#1088#1080#1085#1072' '#1082#1086#1083#1086#1085#1082#1080' '#1089' '#1095#1080#1089#1083#1086#1084' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object Label14: TLabel
          Left = 8
          Top = 184
          Width = 114
          Height = 26
          Caption = #1064#1080#1088#1080#1085#1072' '#1082#1086#1083#1086#1085#1082#1080' '#1089' '#1080#1084#1077#1085#1077#1084' '#1075#1088#1091#1087#1087#1099' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object ButtonBWFont: TButton
          Left = 10
          Top = 40
          Width = 25
          Height = 25
          Caption = '...'
          TabOrder = 0
          OnClick = ButtonBWFontClick
        end
        object EditBWHeight: TEdit
          Left = 8
          Top = 88
          Width = 81
          Height = 21
          TabOrder = 1
          Text = '10'
          OnChange = EditBWHeightChange
        end
        object UpDownBWHeight: TUpDown
          Left = 89
          Top = 88
          Width = 15
          Height = 21
          Associate = EditBWHeight
          Min = 10
          Position = 10
          TabOrder = 2
          Wrap = False
        end
        object EditBWWidthDigit: TEdit
          Left = 8
          Top = 152
          Width = 81
          Height = 21
          TabOrder = 3
          Text = '80'
          OnChange = EditBWHeightChange
        end
        object UpDownBWWidthDigit: TUpDown
          Left = 89
          Top = 152
          Width = 15
          Height = 21
          Associate = EditBWWidthDigit
          Min = 10
          Max = 300
          Position = 80
          TabOrder = 4
          Wrap = False
        end
        object EditBWWidthName: TEdit
          Left = 8
          Top = 216
          Width = 81
          Height = 21
          TabOrder = 5
          Text = '80'
          OnChange = EditBWHeightChange
        end
        object UpDownBWWidthName: TUpDown
          Left = 89
          Top = 216
          Width = 15
          Height = 21
          Associate = EditBWWidthName
          Min = 10
          Max = 300
          Position = 80
          TabOrder = 6
          Wrap = False
        end
      end
      object PanelBWTable: TPanel
        Left = 0
        Top = 0
        Width = 619
        Height = 539
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object DrawTableBW: TDrawTable
          Left = 0
          Top = 0
          Width = 619
          Height = 539
          Align = alClient
          ColCount = 6
          DefaultDrawing = False
          RowCount = 8
          Options = []
          TabOrder = 0
          ColsWidth = '#128#64'
          RowsHeight = '#21'
          StaticStrings.Strings = (
            #1043#1088#1091#1087#1087#1072'/'#1058#1086#1095#1082#1072' '#1091#1095#1077#1090#1072
            ''
            #1060#1072#1082#1090#1080#1095#1077#1089#1082#1072#1103
            #1055#1083#1072#1085'/'#1051#1080#1084#1080#1090
            #1054#1090#1082#1083#1086#1085#1077#1085#1080#1077
            #1056#1077#1072#1082#1090#1080#1074#1085#1072#1103
            #1048#1084#1103' '#1087#1086#1076#1075#1088#1091#1087#1087#1099
            #1048#1084#1103' '#1087#1086#1076#1075#1088#1091#1087#1087#1099
            #1048#1084#1103' '#1087#1086#1076#1075#1088#1091#1087#1087#1099)
          VarStrings.Strings = (
            '99'
            '99 999 999.99'
            ''
            '99 999 999.99'
            ''
            '12:00'
            ''
            '99 999 999.99'
            ''
            '99 999 999.99'
            '99'
            '99 999 999.99'
            ''
            '99 999 999.99'
            ''
            '12:00'
            ''
            '99 999 999.99'
            ''
            '99 999 999.99')
          TabStrings.Strings = (
            '$ m 0x0005 0x1008 b # $ m 0x0009 0x1008 #$#$#$#$#$'
            
              '$ m 0x0005 0x0 b- a 0x24 # & m 0x0001 0x00 b a 0x25 #& b- #&#&#&' +
              '#&')
          ColWidths = (
            128
            64
            64
            64
            64
            64)
          RowHeights = (
            21
            21
            21
            21
            21
            21
            21
            21)
        end
      end
    end
    object TShPLSQLRep: TTabSheet
      Caption = #1054#1090#1095#1077#1090#1099' PL SQL'
      ImageIndex = 2
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 619
        Height = 539
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object REdPLSQLRep: TRichEdit
          Left = 0
          Top = 0
          Width = 619
          Height = 539
          Align = alClient
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Lines.Strings = (
            #1055#1088#1080#1084#1077#1088' '#1090#1077#1082#1089#1090#1072':'
            'lllllllllllllllllll1234567')
          ParentFont = False
          TabOrder = 0
        end
      end
      object Panel5: TPanel
        Left = 619
        Top = 0
        Width = 156
        Height = 539
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object Label5: TLabel
          Left = 8
          Top = 8
          Width = 48
          Height = 13
          Caption = #1064#1088#1080#1092#1090' :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object PLSQLRepFont: TLabel
          Left = 8
          Top = 24
          Width = 145
          Height = 13
          AutoSize = False
          Caption = 'MS Sans Serif,8'
        end
        object Button1: TButton
          Left = 8
          Top = 40
          Width = 25
          Height = 25
          Caption = '...'
          TabOrder = 0
          OnClick = Button1Click
        end
        object RGrPrintMode: TRadioGroup
          Left = 8
          Top = 72
          Width = 137
          Height = 41
          Caption = #1057#1087#1086#1089#1086#1073' '#1087#1077#1095#1072#1090#1080
          Columns = 2
          ItemIndex = 1
          Items.Strings = (
            'DOS'
            'Windows')
          TabOrder = 1
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1047#1074#1091#1082#1086#1074#1072#1103' '#1089#1080#1075#1085#1072#1083#1080#1079#1072#1094#1080#1103
      ImageIndex = 3
      object Label6: TLabel
        Left = 10
        Top = 103
        Width = 106
        Height = 13
        Caption = #1063#1072#1089#1090#1086#1090#1072' '#1079#1074#1091#1082#1072', '#1075#1077#1088#1094':'
      end
      object Label7: TLabel
        Left = 10
        Top = 133
        Width = 140
        Height = 13
        Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1079#1074#1091#1082#1072', '#1084#1089#1077#1082':'
      end
      object Label8: TLabel
        Left = 10
        Top = 163
        Width = 220
        Height = 13
        Caption = #1055#1072#1091#1079#1072' '#1084#1077#1078#1076#1091' '#1079#1074#1091#1082#1086#1074#1099#1084#1080' '#1089#1080#1075#1085#1072#1083#1072#1084#1080', '#1084#1089#1077#1082':'
      end
      object CheckBox1: TCheckBox
        Left = 10
        Top = 19
        Width = 405
        Height = 17
        Caption = 
          #1047#1074#1091#1082#1086#1074#1072#1103' '#1089#1080#1075#1085#1072#1083#1080#1079#1072#1094#1080#1103' '#1087#1088#1080' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1080' '#1076#1072#1085#1085#1099#1093' '#1082#1086#1084#1084#1077#1088#1095#1077#1089#1082#1086#1075#1086' '#1082#1086#1085#1090#1088#1086 +
          #1083#1103
        TabOrder = 0
      end
      object CheckBox2: TCheckBox
        Left = 10
        Top = 46
        Width = 403
        Height = 17
        Caption = 
          #1047#1074#1091#1082#1086#1074#1072#1103' '#1089#1080#1075#1085#1072#1083#1080#1079#1072#1094#1080#1103' '#1087#1088#1080' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1080' '#1076#1072#1085#1085#1099#1093' '#1090#1077#1093#1085#1080#1095#1077#1089#1082#1086#1075#1086' '#1082#1086#1085#1090#1088#1086#1083 +
          #1103
        TabOrder = 1
      end
      object Edit1: TEdit
        Left = 238
        Top = 101
        Width = 84
        Height = 21
        TabOrder = 2
        Text = '1000'
      end
      object Edit2: TEdit
        Left = 238
        Top = 132
        Width = 84
        Height = 21
        TabOrder = 3
        Text = '500'
      end
      object Edit3: TEdit
        Left = 238
        Top = 162
        Width = 84
        Height = 21
        TabOrder = 4
        Text = '300'
      end
      object CheckBox3: TCheckBox
        Left = 10
        Top = 73
        Width = 575
        Height = 19
        Caption = 
          #1047#1074#1091#1082#1086#1074#1072#1103' '#1089#1080#1075#1085#1072#1083#1080#1079#1072#1094#1080#1103' '#1087#1088#1080' '#1085#1072#1083#1080#1095#1080#1080' '#1082#1088#1080#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1089#1083#1091#1078#1073' '#1076 +
          #1080#1072#1075#1085#1086#1089#1090#1080#1082#1080' '#1080#1083#1080' '#1077#1076#1080#1085#1086#1075#1086' '#1074#1088#1077#1084#1077#1085#1080
        TabOrder = 5
      end
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Options = []
    Left = 461
    Top = 43
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 395
    Top = 155
  end
end
