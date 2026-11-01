object UserForumMain: TUserForumMain
  Left = 240
  Top = 221
  Width = 844
  Height = 469
  HelpContext = 2402101
  Caption = #1060#1086#1088#1091#1084' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 836
    Height = 29
    ButtonHeight = 21
    Caption = 'ToolBar1'
    TabOrder = 0
    object newTopic: TBitBtn
      Left = 0
      Top = 2
      Width = 113
      Height = 21
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1090#1077#1084#1091
      Constraints.MaxWidth = 113
      Constraints.MinWidth = 113
      TabOrder = 0
      OnClick = newTopicClick
    end
    object Splitter1: TSplitter
      Left = 113
      Top = 2
      Width = 32
      Height = 21
      Cursor = crArrow
      ResizeStyle = rsNone
    end
    object Label1: TLabel
      Left = 145
      Top = 2
      Width = 47
      Height = 21
      AutoSize = False
      Caption = #1040#1074#1090#1086#1088#1099':  '
      Layout = tlCenter
    end
    object usersComboBox: TComboBox
      Left = 192
      Top = 2
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = usersComboBoxChange
    end
    object Splitter2: TSplitter
      Left = 337
      Top = 2
      Width = 16
      Height = 21
      Cursor = crArrow
      ResizeStyle = rsNone
    end
    object Label2: TLabel
      Left = 353
      Top = 2
      Width = 125
      Height = 21
      AutoSize = False
      Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1090#1077#1084#1099' '#1089':  '
      Layout = tlCenter
    end
    object fromCalendar: TDateTimePicker
      Left = 478
      Top = 2
      Width = 79
      Height = 21
      CalAlignment = dtaLeft
      Date = 40192.6622184143
      Time = 40192.6622184143
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
      OnChange = fromCalendarChange
    end
    object Label3: TLabel
      Left = 557
      Top = 2
      Width = 24
      Height = 21
      AutoSize = False
      Caption = ' '#1087#1086':  '
      Layout = tlCenter
    end
    object tillCalendar: TDateTimePicker
      Left = 581
      Top = 2
      Width = 81
      Height = 21
      CalAlignment = dtaLeft
      Date = 40192.6630504861
      Time = 40192.6630504861
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
      OnChange = tillCalendarChange
    end
  end
  object topicsGrid: TDBGridEh
    Left = 0
    Top = 29
    Width = 836
    Height = 413
    Align = alClient
    AllowedOperations = []
    AllowedSelections = [gstRecordBookmarks, gstRectangle, gstAll]
    DataSource = receiveTopicsDataSource
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColWidthsChanged = topicsGridColWidthsChanged
    OnDblClick = topicsGridDblClick
    OnTitleClick = topicsGridTitleClick
    Columns = <
      item
        EditButtons = <>
        FieldName = 'NMESSAGE'
        Footers = <>
        Visible = False
        Width = 0
      end
      item
        EditButtons = <>
        FieldName = 'DDATE'
        Footers = <>
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072
        Width = 110
      end
      item
        EditButtons = <>
        FieldName = 'NAME'
        Footers = <>
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1040#1074#1090#1086#1088
        Width = 190
      end
      item
        EditButtons = <>
        FieldName = 'VSUBJECT'
        Footers = <>
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1084#1072
        Width = 200
      end
      item
        EditButtons = <>
        FieldName = 'TOTAL_REPLIES'
        Footers = <>
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1042#1089#1077#1075#1086' '#1086#1090#1074#1077#1090#1086#1074
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'LAST_REPLY'
        Footers = <>
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1086#1090#1074#1077#1090#1072
        Width = 140
      end>
  end
  object SortPanel: TPanel
    Left = 108
    Top = 32
    Width = 15
    Height = 15
    BevelOuter = bvNone
    TabOrder = 2
    object AscImage: TImage
      Left = 1
      Top = 1
      Width = 13
      Height = 13
      Picture.Data = {
        07544269746D6170DE000000424DDE0000000000000076000000280000000D00
        00000D0000000100040000000000680000000000000000000000100000000000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00FFFFFFFFFFFFF000FFFFFFFFFFFFF000FFFFFF0FFFFFF000FFFFF000FFFF
        F000FFFFF000FFFFF000FFFF00000FFFF000FFFF00000FFFF000FFF0000000FF
        F000FFF0000000FFF000FF000000000FF000FF000000000FF000FFFFFFFFFFFF
        F000FFFFFFFFFFFFF000}
      Transparent = True
      Visible = False
    end
    object DescImage: TImage
      Left = 1
      Top = 1
      Width = 13
      Height = 13
      Picture.Data = {
        07544269746D6170DE000000424DDE0000000000000076000000280000000D00
        00000D0000000100040000000000680000000000000000000000100000000000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00FFFFFFFFFFFFF000FFFFFFFFFFFFF000FF000000000FF000FF000000000F
        F000FFF0000000FFF000FFF0000000FFF000FFFF00000FFFF000FFFF00000FFF
        F000FFFFF000FFFFF000FFFFF000FFFFF000FFFFFF0FFFFFF000FFFFFFFFFFFF
        F000FFFFFFFFFFFFF000}
      Transparent = True
    end
  end
  object receiveTopicsQuery: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      
        '  ryda.USERFORUM_PG.receiveTopics(:user_id, :date_from, :date_ti' +
        'll, :order_by, :o_direction, :s_result);'
      'end;')
    Left = 112
    Top = 80
    ParamData = <
      item
        Name = 'user_id'
        ParamType = ptInput
        Value = ''
        ExtDataType = 107
      end
      item
        DataType = ftDateTime
        Name = 'date_from'
        ParamType = ptInput
        Value = 40191d
      end
      item
        DataType = ftDateTime
        Name = 'date_till'
        ParamType = ptInput
        Value = 40193d
      end
      item
        DataType = ftString
        Name = 'order_by'
        ParamType = ptInput
      end
      item
        Name = 'o_direction'
        ParamType = ptInput
        Value = ''
        ExtDataType = 107
      end
      item
        DataType = ftCursor
        Name = 's_result'
        Value = 'Object'
      end>
  end
  object receiveTopicsDataSource: TOraDataSource
    DataSet = receiveTopicsQuery
    Left = 112
    Top = 112
  end
  object receiveUsersQuery: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  ryda.USERFORUM_PG.receiveUsers(:s_return);'
      'end;')
    Left = 72
    Top = 80
    ParamData = <
      item
        DataType = ftCursor
        Name = 's_return'
        Value = 'Object'
      end>
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 48
    Top = 200
  end
end
