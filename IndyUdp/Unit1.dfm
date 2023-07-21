object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    628
    442)
  TextHeight = 15
  object btnStart: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btnStart'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 70
    Width = 612
    Height = 364
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object btnStop: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btnStop'
    TabOrder = 2
    OnClick = btnStopClick
  end
  object btnSend: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = 'btnSend'
    TabOrder = 3
    OnClick = btnSendClick
  end
  object IdUDPClient1: TIdUDPClient
    Host = '127.0.0.1'
    Port = 0
    Left = 216
    Top = 32
  end
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer1UDPRead
    Left = 312
    Top = 32
  end
end
