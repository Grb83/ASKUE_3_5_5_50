object ManForm: TManForm
  Left = 502
  Top = 372
  Width = 464
  Height = 316
  HelpContext = 625
  Caption = #1052#1086#1085#1080#1090#1086#1088
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 235
    Width = 448
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtnForm: TButton
      Left = 0
      Top = 0
      Width = 70
      Height = 23
      Caption = #1060#1086#1088#1084#1072
      TabOrder = 0
      OnClick = BitBtnFormClick
    end
    object BitBtnParam: TButton
      Left = 72
      Top = 0
      Width = 70
      Height = 23
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      TabOrder = 1
      TabStop = False
      OnClick = BitBtnParamClick
    end
    object BitBtnPrevios: TButton
      Left = 140
      Top = 0
      Width = 70
      Height = 23
      Caption = '&<<'
      TabOrder = 2
      TabStop = False
      OnClick = BitBtnPreviosClick
    end
    object BitBtnNext: TButton
      Left = 210
      Top = 0
      Width = 70
      Height = 23
      Caption = '>&>'
      TabOrder = 3
      TabStop = False
      OnClick = BitBtnNextClick
    end
    object Panel2: TPanel
      Left = 378
      Top = 0
      Width = 70
      Height = 23
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 4
      object BitBtnClose: TButton
        Left = 0
        Top = 0
        Width = 70
        Height = 23
        Caption = #1047#1072#1082#1088#1099#1090#1100
        TabOrder = 0
        OnClick = BitBtnCloseClick
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 10
    Top = 7
    object File: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      OnClick = FileClick
      object CreateMonitor: TMenuItem
        Caption = #1057#1086#1079#1076'&'#1072#1090#1100' '#1084#1086#1085#1080#1090#1086#1088
        OnClick = CreateMonitorClick
      end
      object OpenMonitor: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100' &'#1084#1086#1085#1080#1090#1086#1088' ...'
        OnClick = OpenMonitorClick
      end
      object OpenEdit: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100' &'#1088#1077#1076#1072#1082#1090#1086#1088
        OnClick = OpenEditClick
      end
      object N7: TMenuItem
        Caption = '-'
        GroupIndex = 7
      end
      object N3: TMenuItem
        Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1099#1081' '#1086#1087#1088#1086#1089
        GroupIndex = 7
        OnClick = N3Click
      end
      object NM5: TMenuItem
        Caption = #1060#1086#1085#1086#1074#1099#1077' '#1087#1088#1086#1094#1077#1089#1089#1099'...'
        GroupIndex = 7
        OnClick = NM5Click
      end
      object N4: TMenuItem
        Caption = '-'
        GroupIndex = 7
      end
      object SaveMonitor: TMenuItem
        Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1084#1086#1085#1080#1090#1086#1088
        GroupIndex = 7
        OnClick = SaveMonitorClick
      end
      object SaveMonitorAs: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1084#1086#1085#1080#1090#1086#1088' &'#1082#1072#1082' ...'
        GroupIndex = 7
        OnClick = SaveMonitorAsClick
      end
      object EditMonitorList: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1084#1086#1085#1080#1090#1086#1088#1086#1074'...'
        GroupIndex = 7
        OnClick = EditMonitorListClick
      end
      object MenuItemSetupMonitor: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1090#1080#1083#1077#1081' '#1084#1086#1085#1080#1090#1086#1088#1072' ...'
        GroupIndex = 7
        OnClick = MenuItemSetupMonitorClick
      end
      object N5: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1074' '#1092#1072#1081#1083
        Enabled = False
        GroupIndex = 7
        Visible = False
      end
      object N2: TMenuItem
        Caption = '-'
        GroupIndex = 7
        Visible = False
      end
      object PrintRep: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1072
        GroupIndex = 7
        Visible = False
        OnClick = PrintRepClick
      end
      object PrintTable: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100' '#1090#1072#1073#1083#1080#1094#1099'...'
        GroupIndex = 7
        Visible = False
        OnClick = PrintTableClick
      end
      object PrintGraph: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100' '#1075#1088#1072#1092#1080#1082#1072'...'
        GroupIndex = 7
        Visible = False
        OnClick = PrintGraphClick
      end
      object SaveRepToFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1086#1090#1095#1077#1090' '#1082#1072#1082'...'
        GroupIndex = 7
        Visible = False
        OnClick = SaveRepToFileClick
      end
      object SaveGraphToFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1075#1088#1072#1092#1080#1082' '#1082#1072#1082'...'
        GroupIndex = 7
        Visible = False
        OnClick = SaveGraphToFileClick
      end
      object SaveMultyTableToFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1084#1091#1083#1100#1090#1080#1090#1072#1073#1083#1080#1094#1091' '#1074' '#1092#1072#1081#1083'...'
        Enabled = False
        GroupIndex = 7
        Visible = False
      end
      object SaveTableToFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1074' '#1092#1072#1081#1083'...'
        GroupIndex = 7
        Visible = False
        OnClick = SaveTableToFileClick
      end
      object N8: TMenuItem
        Caption = '-'
        GroupIndex = 7
      end
      object Exit: TMenuItem
        Caption = #1042'&'#1099#1093#1086#1076
        GroupIndex = 7
        OnClick = ExitClick
      end
    end
    object Monitor: TMenuItem
      Caption = '&'#1052#1086#1085#1080#1090#1086#1088
      GroupIndex = 30
      object Rotate: TMenuItem
        Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1085#1072' 90'
        GroupIndex = 30
        OnClick = RotateClick
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 30
      end
      object AddBottom: TMenuItem
        Tag = 3
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1089#1085#1080#1079#1091
        GroupIndex = 30
        OnClick = AddPanelClick
      end
      object AddRight: TMenuItem
        Tag = 2
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1089#1087#1088#1072#1074#1072
        GroupIndex = 30
        OnClick = AddPanelClick
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 51
    Top = 8
  end
  object oqMonitor: TOraQuery
    Session = dmMain.orases
    SQL.Strings = (
      'begin '
      '  if :par1>0 then '
      
        '    ryda.editmonitors_pg.upd_p(:par1,:par2,:par3,:par4,:par5,:pa' +
        'r6,0);  '
      '  else'
      
        '    ryda.editmonitors_pg.ins_p(:par2,:par3,:par4,:par5,:par6,0,:' +
        'par1);'
      '  end if;'
      'end;')
    Left = 24
    Top = 70
    ParamData = <
      item
        DataType = ftInteger
        Name = 'par1'
        ParamType = ptInputOutput
      end
      item
        DataType = ftInteger
        Name = 'par2'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'par3'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'par4'
        ParamType = ptInput
        Size = 256
      end
      item
        DataType = ftInteger
        Name = 'par5'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'par6'
        ParamType = ptInput
      end>
    object oqMonitorDFILE: TBlobField
      FieldName = 'DFILE'
    end
    object oqMonitorNPARENT: TFloatField
      FieldName = 'NPARENT'
    end
  end
end
