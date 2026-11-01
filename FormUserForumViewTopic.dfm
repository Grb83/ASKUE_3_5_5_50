object UserForumViewTopic: TUserForumViewTopic
  Left = 243
  Top = 211
  Width = 837
  Height = 589
  HelpContext = 2402101
  Caption = #1058#1077#1084#1072': '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 829
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      829
      29)
    object Label1: TLabel
      Left = 111
      Top = 7
      Width = 108
      Height = 15
      Align = alCustom
      AutoSize = False
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1090#1074#1077#1090#1086#1074': '
    end
    object Label2: TLabel
      Left = 267
      Top = 7
      Width = 128
      Height = 15
      AutoSize = False
      Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1086#1090#1074#1077#1090#1072':'
    end
    object answersStaticText: TStaticText
      Left = 223
      Top = 6
      Width = 28
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = '0'
      Color = clHighlightText
      ParentColor = False
      TabOrder = 0
    end
    object replyButton: TBitBtn
      Left = 2
      Top = 3
      Width = 93
      Height = 23
      Caption = #1054#1090#1074#1077#1090#1080#1090#1100
      TabOrder = 1
      OnClick = replyButtonClick
    end
    object dateStaticText: TStaticText
      Left = 400
      Top = 6
      Width = 109
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clHighlightText
      ParentColor = False
      TabOrder = 2
    end
    object returnButton: TBitBtn
      Left = 665
      Top = 3
      Width = 161
      Height = 23
      Anchors = [akRight, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103' '#1082' '#1089#1087#1080#1089#1082#1091' '#1090#1077#1084
      ParentBiDiMode = False
      TabOrder = 3
      OnClick = returnButtonClick
    end
  end
  object dataGrid: TDBCtrlGrid
    Left = 0
    Top = 113
    Width = 829
    Height = 449
    Align = alClient
    AllowDelete = False
    AllowInsert = False
    ColCount = 1
    DataSource = receiveRepliesDataSource
    PanelHeight = 89
    PanelWidth = 813
    TabOrder = 1
    RowCount = 5
    object messageMemo: TDBMemo
      Left = 176
      Top = 0
      Width = 637
      Height = 89
      Align = alClient
      BevelOuter = bvRaised
      BevelKind = bkTile
      BorderStyle = bsNone
      DataField = 'VMESSAGE'
      DataSource = receiveRepliesDataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 176
      Height = 89
      Align = alLeft
      BevelOuter = bvNone
      Color = clWindow
      TabOrder = 1
      object authorNameText: TDBText
        Left = 2
        Top = 8
        Width = 170
        Height = 25
        Alignment = taCenter
        DataField = 'NAME'
        DataSource = receiveRepliesDataSource
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dateText: TDBText
        Left = 2
        Top = 32
        Width = 170
        Height = 17
        Alignment = taCenter
        DataField = 'DDATE'
        DataSource = receiveRepliesDataSource
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 29
    Width = 829
    Height = 84
    Align = alTop
    Caption = 'Panel2'
    TabOrder = 2
    object topicMessageMemo: TMemo
      Left = 209
      Top = 1
      Width = 619
      Height = 82
      Align = alClient
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 208
      Height = 82
      Align = alLeft
      BevelOuter = bvLowered
      Caption = 'Panel4'
      TabOrder = 1
      object topicAuthorLabel: TLabel
        Left = 4
        Top = 8
        Width = 199
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object topicDateLabel: TLabel
        Left = 4
        Top = 32
        Width = 199
        Height = 13
        Alignment = taCenter
        AutoSize = False
      end
    end
  end
  object receiveRepliesQuery: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin'
      '  ryda.USERFORUM_PG.receiveReplies(:topic_id, :s_result);'
      'end;')
    Left = 152
    Top = 200
    ParamData = <
      item
        Name = 'topic_id'
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
  object receiveRepliesDataSource: TOraDataSource
    DataSet = receiveRepliesQuery
    Left = 152
    Top = 240
  end
end
