object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'test TRegExp.IsMatch VER001'
  ClientHeight = 364
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = #12513#12452#12522#12458
  Font.Style = []
  TextHeight = 17
  object Label1: TLabel
    Left = 8
    Top = 39
    Width = 105
    Height = 17
    Caption = 'RegularExpressions'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'IsMatch'
    Default = True
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
  end
  object edSource: TEdit
    Left = 8
    Top = 98
    Width = 369
    Height = 25
    TabOrder = 2
    Text = '<g id="edge1" class="edge">'
  end
  object edRegexp: TEdit
    Left = 8
    Top = 62
    Width = 744
    Height = 25
    TabOrder = 1
    Text = '<g .+class="edge"'
  end
  object Memo1: TMemo
    Left = 8
    Top = 125
    Width = 369
    Height = 228
    TabStop = False
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
    WordWrap = False
  end
  object edSource2: TEdit
    Left = 383
    Top = 98
    Width = 369
    Height = 25
    TabOrder = 3
    Text = 'edSource2'
  end
  object Memo2: TMemo
    Left = 383
    Top = 125
    Width = 369
    Height = 228
    TabStop = False
    Lines.Strings = (
      'Memo2')
    TabOrder = 5
    WordWrap = False
  end
end
