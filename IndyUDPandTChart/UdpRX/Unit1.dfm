object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'UdpRX'
  ClientHeight = 441
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 273
    Height = 441
    Align = alLeft
    TabOrder = 0
    object chkActive: TCheckBox
      Left = 16
      Top = 8
      Width = 97
      Height = 17
      Caption = 'Active'
      TabOrder = 0
      OnClick = chkActiveClick
    end
    object ValueListEditor1: TValueListEditor
      Left = 16
      Top = 31
      Width = 241
      Height = 122
      Strings.Strings = (
        'Port=55555'
        'ChartWidth=400'
        'UpdateFreq=10')
      TabOrder = 1
      ColWidths = (
        97
        138)
    end
    object Memo1: TMemo
      Left = 16
      Top = 159
      Width = 241
      Height = 274
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 2
      WordWrap = False
    end
  end
  object Chart1: TChart
    Left = 273
    Top = 0
    Width = 451
    Height = 441
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 1
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TLineSeries
      HoverElement = [heCurrent]
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      HoverElement = [heCurrent]
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      HoverElement = [heCurrent]
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 48
    Top = 280
  end
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer1UDPRead
    Left = 48
    Top = 216
  end
end
