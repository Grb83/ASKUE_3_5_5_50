object fmAddToTree: TfmAddToTree
  Left = 336
  Top = 65
  HelpContext = 17031
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1077#1090#1074#1100
  ClientHeight = 371
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 330
    Width = 411
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Panel2: TPanel
      Left = 192
      Top = 0
      Width = 219
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnAddOk: TBitBtn
        Left = 24
        Top = 10
        Width = 85
        Height = 25
        Caption = 'OK'
        TabOrder = 0
        OnClick = btnAddOkClick
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
      object btnAddCancel: TBitBtn
        Left = 118
        Top = 10
        Width = 91
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
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 411
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 14
      Width = 50
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edAddName: TEdit
      Left = 66
      Top = 10
      Width = 337
      Height = 21
      TabOrder = 0
    end
  end
  object GrBtType: TRadioGroup
    Left = 0
    Top = 41
    Width = 411
    Height = 34
    Align = alTop
    Caption = #1058#1080#1087
    Columns = 3
    Items.Strings = (
      #1055#1072#1087#1082#1072
      #1060#1086#1088#1084#1091#1083#1072
      #1060#1091#1085#1082#1094#1080#1103' ')
    TabOrder = 1
    OnClick = GrBtTypeClick
  end
  object Panel4: TPanel
    Left = 0
    Top = 75
    Width = 411
    Height = 255
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Panel7: TPanel
      Left = 0
      Top = 125
      Width = 411
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Label3: TLabel
        Left = 4
        Top = 4
        Width = 63
        Height = 13
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      end
    end
    object memNote: TMemo
      Left = 0
      Top = 147
      Width = 411
      Height = 108
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object Panel8: TPanel
      Left = 0
      Top = 0
      Width = 411
      Height = 125
      Align = alTop
      Caption = 'Panel8'
      TabOrder = 0
      object Panel6: TPanel
        Left = 1
        Top = 28
        Width = 409
        Height = 96
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object memContains: TMemo
          Left = 0
          Top = 0
          Width = 409
          Height = 96
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 409
        Height = 27
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label2: TLabel
          Left = 4
          Top = 8
          Width = 65
          Height = 13
          Caption = #1057#1086#1076#1077#1088#1078#1080#1084#1086#1077
        end
      end
    end
  end
  object oqSaveFunc: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      
        'RYDA.EDITFORMULA_PG.save_function (:an_id, :an_parent, :an_type,' +
        ' :av_name, :av_formula, :av_memo);'
      'end;')
    AutoCommit = False
    Left = 130
    Top = 96
    ParamData = <
      item
        DataType = ftInteger
        Name = 'an_id'
        ParamType = ptInputOutput
      end
      item
        DataType = ftInteger
        Name = 'an_parent'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'an_type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'av_name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'av_formula'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'av_memo'
        ParamType = ptInput
      end>
  end
end
