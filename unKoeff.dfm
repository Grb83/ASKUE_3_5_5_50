object fmKoeff: TfmKoeff
  Left = 397
  Top = 225
  HelpContext = 17033
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1088#1072#1089#1095#1077#1090#1085#1086#1075#1086' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1072
  ClientHeight = 418
  ClientWidth = 422
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
    Top = 388
    Width = 422
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 237
      Top = 0
      Width = 185
      Height = 30
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btOk: TBitBtn
        Left = 16
        Top = 4
        Width = 75
        Height = 25
        Caption = 'OK'
        TabOrder = 0
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
      object btCancel: TBitBtn
        Left = 98
        Top = 4
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
    object DBNavigator1: TDBNavigator
      Left = 0
      Top = 0
      Width = 233
      Height = 30
      DataSource = dsMain
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete]
      Align = alLeft
      ConfirmDelete = False
      TabOrder = 1
    end
  end
  object grMain: TDBGridEh
    Left = 0
    Top = 0
    Width = 422
    Height = 388
    Align = alClient
    DataSource = dsMain
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        EditButtons = <>
        FieldName = 'DSTART'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1089
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'DEND'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1087#1086
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'KC'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'MID'
        Footers = <>
        Visible = False
      end>
  end
  object dsMain: TDataSource
    DataSet = oqData
    OnDataChange = dsMainDataChange
    Left = 46
    Top = 45
  end
  object oqData: TOraQuery
    SQLInsert.Strings = (
      
        'begin ryda.FEEDERSCOEF_PG.upd_p(:mid ,:old_dstart,:dstart , :den' +
        'd ,:kc); end;')
    SQLDelete.Strings = (
      'begin ryda.FEEDERSCOEF_PG.del_p(:mid ,:dstart); end;')
    SQLUpdate.Strings = (
      
        'begin ryda.FEEDERSCOEF_PG.upd_p(:mid ,:old_dstart,:dstart ,:dend' +
        ' ,:kc); end;')
    Session = dmMain.orases
    SQL.Strings = (
      'begin ryda.FEEDERSCOEF_PG.getinfo(:mid,:ret_t); end;'
      ''
      '/*select to_date('#39'22.01.2008'#39','#39'dd.mm.yyyy '#39') sdate,'
      'to_date('#39'25.01.2009'#39','#39'dd.mm.yyyy s'#39') fdate,'
      '2 koeff from dual*/')
    CachedUpdates = True
    AutoCommit = False
    OnNewRecord = oqDataAfterInsert
    Left = 172
    Top = 44
    ParamData = <
      item
        DataType = ftInteger
        Name = 'mid'
        ParamType = ptInput
      end
      item
        DataType = ftCursor
        Name = 'ret_t'
        Value = 'Object'
      end>
  end
end
