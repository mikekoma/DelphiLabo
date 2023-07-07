object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'test TRegExp.IsMatch VER001'
  ClientHeight = 508
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
    Width = 39
    Height = 17
    Caption = 'Pattern'
  end
  object Label2: TLabel
    Left = 8
    Top = 93
    Width = 42
    Height = 17
    Caption = 'Replace'
  end
  object btnExec: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Exec'
    Default = True
    TabOrder = 0
    TabStop = False
    OnClick = btnExecClick
  end
  object edSource: TEdit
    Left = 8
    Top = 162
    Width = 369
    Height = 25
    TabOrder = 3
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
    Top = 189
    Width = 369
    Height = 311
    TabStop = False
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
    WordWrap = False
  end
  object edSource2: TEdit
    Left = 383
    Top = 162
    Width = 369
    Height = 25
    TabOrder = 4
    Text = 'edSource2'
  end
  object Memo2: TMemo
    Left = 383
    Top = 189
    Width = 369
    Height = 311
    TabStop = False
    Lines.Strings = (
      'Memo2')
    TabOrder = 6
    WordWrap = False
  end
  object cmbSelect: TComboBox
    Left = 89
    Top = 8
    Width = 145
    Height = 25
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 7
    Text = 'IsMatch'
    Items.Strings = (
      'IsMatch'
      'Replace')
  end
  object edReplace: TEdit
    Left = 8
    Top = 116
    Width = 744
    Height = 25
    TabOrder = 2
    Text = 'edReplace'
  end
end
