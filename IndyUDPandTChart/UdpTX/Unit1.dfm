object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'UdpTX'
  ClientHeight = 671
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 671
    Align = alLeft
    TabOrder = 0
    object btnStart: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 89
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 1
      OnClick = btnStopClick
    end
    object ValueListEditor1: TValueListEditor
      Left = 8
      Top = 70
      Width = 169
      Height = 372
      Strings.Strings = (
        'Host=127.0.0.1'
        'Port=55555'
        'ChannelNo=$F000'
        'SampleFreq=200'
        #9632'_CH1_'#9632'='#9632#9632#9632#9632
        'Offset1=0'
        'Gain1=80'
        'Cycle1=1.5'
        #9632'_CH2_'#9632'='#9632#9632#9632#9632
        'Offset2=0'
        'Gain2=40'
        'Cycle2=4'
        #9632'_CH3_'#9632'='#9632#9632#9632#9632
        'Offset3=0'
        'Gain3=20'
        'Cycle3=8')
      TabOrder = 2
      ColWidths = (
        70
        93)
    end
    object Memo1: TMemo
      Left = 8
      Top = 456
      Width = 169
      Height = 209
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 3
      WordWrap = False
    end
    object btnTestParam: TButton
      Left = 8
      Top = 39
      Width = 75
      Height = 25
      Caption = 'Test Param'
      TabOrder = 4
      Visible = False
      OnClick = btnTestParamClick
    end
    object btnSend: TButton
      Left = 88
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Send'
      TabOrder = 5
      Visible = False
      OnClick = btnSendClick
    end
  end
  object Chart1: TChart
    Left = 193
    Top = 0
    Width = 427
    Height = 671
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
  object IdUDPClient1: TIdUDPClient
    Port = 0
    Left = 40
    Top = 488
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 40
    Top = 560
  end
end
