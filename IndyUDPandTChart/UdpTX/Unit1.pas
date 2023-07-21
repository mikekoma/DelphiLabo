unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ValEdit,
  Vcl.ExtCtrls, VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.Series,
  VclTee.TeeProcs, VclTee.Chart, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, IdGlobal;

const
  PARAM_HOST = 'Host';
  PARAM_PORT = 'Port';
  PARAM_CHANNELNO = 'ChannelNo';
  PARAM_SAMPLEFREQ = 'SampleFreq';
  PARAM_OFFSET1 = 'Offset1';
  PARAM_GAIN1 = 'Gain1';
  PARAM_CYCLE1 = 'Cycle1';
  PARAM_OFFSET2 = 'Offset2';
  PARAM_GAIN2 = 'Gain2';
  PARAM_CYCLE2 = 'Cycle2';
  PARAM_OFFSET3 = 'Offset3';
  PARAM_GAIN3 = 'Gain3';
  PARAM_CYCLE3 = 'Cycle3';

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    btnStart: TButton;
    btnStop: TButton;
    btnSend: TButton;
    btnTestParam: TButton;
    ValueListEditor1: TValueListEditor;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    IdUDPClient1: TIdUDPClient;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnTestParamClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private 宣言 }
    sample_freq: integer;
    sita: array [0 .. 2] of double;
    delta: array [0 .. 2] of double;
    offset: array [0 .. 2] of double;
    gain: array [0 .. 2] of double;
    cycle: array [0 .. 2] of double;
    procedure memo(str: string);
    procedure ui_enable(enb: boolean);
    procedure correct_params;
    function get_param_double(index: string): double;
    function get_param_int(index: string): integer;
    function get_param_str(index: string): string;
    procedure update_chart;
    procedure send_packet;
    procedure update_chart2;
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  for var ch := 0 to 2 do
  begin
    sita[ch] := 0;
  end;

  Memo1.Clear;
  ui_enable(true);
end;

procedure TForm1.btnSendClick(Sender: TObject);
begin
  send_packet;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  memo('start');
  ui_enable(false);

  correct_params;
  update_chart;

  IdUDPClient1.Host := get_param_str(PARAM_HOST);
  IdUDPClient1.Port := get_param_int(PARAM_PORT);
  IdUDPClient1.Active := true;

  Timer1.Enabled := true;

  memo('Host = ' + IdUDPClient1.Host);
  memo('Port = ' + IdUDPClient1.Port.ToString);
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  memo('stop');
  Timer1.Enabled := false;
  ui_enable(true);
  IdUDPClient1.Active := false;
end;

procedure TForm1.btnTestParamClick(Sender: TObject);
begin
  correct_params;
  update_chart2;
end;

function TForm1.get_param_double(index: string): double;
begin
  Result := StrToFloat(ValueListEditor1.Values[index]);
end;

function TForm1.get_param_int(index: string): integer;
begin
  Result := StrToInt(ValueListEditor1.Values[index]);
end;

function TForm1.get_param_str(index: string): string;
begin
  Result := ValueListEditor1.Values[index];
end;

procedure TForm1.memo(str: string);
begin
  Memo1.Lines.Add(str);
end;

// ループ回す順序を、ch⇒x
procedure TForm1.update_chart;
var
  val: double;
  st: double;
  ser: TLineSeries;
begin
  for var ch := 0 to 2 do
  begin
    st := sita[ch];
    ser := TLineSeries(Chart1.SeriesList.Items[ch]);
    ser.Clear;
    for var x := 0 to sample_freq - 1 do
    begin
      val := gain[ch] * sin(st) + offset[ch];
      st := st + delta[ch];
      ser.AddXY(x, val);
    end;
    sita[ch] := st;
  end;
end;

// ループ回す順序を、x⇒ch
procedure TForm1.update_chart2;
var
  val: double;
  st: double;
begin
  for var ch := 0 to 2 do
  begin
    TLineSeries(Chart1.SeriesList.Items[ch]).Clear;
  end;

  for var x := 0 to sample_freq - 1 do
  begin
    for var ch := 0 to 2 do
    begin
      st := sita[ch];
      val := gain[ch] * sin(st) + offset[ch];
      st := st + delta[ch];
      sita[ch] := st;
      TLineSeries(Chart1.SeriesList.Items[ch]).AddXY(x, val);
    end;
  end;
end;

procedure TForm1.correct_params;
begin
  sample_freq := Round(get_param_double(PARAM_SAMPLEFREQ));
  memo('sample_freq=' + sample_freq.ToString);

  for var i := 1 to 3 do
  begin
    offset[i - 1] := get_param_double('Offset' + i.ToString);
    gain[i - 1] := get_param_double('Gain' + i.ToString);
    cycle[i - 1] := get_param_double('cycle' + i.ToString);
    delta[i - 1] := (2 * pi * cycle[i - 1]) / double(sample_freq);

    memo('offset' + i.ToString + '=' + offset[i - 1].ToString);
    memo('gain' + i.ToString + '=' + gain[i - 1].ToString);
    memo('cycle' + i.ToString + '=' + cycle[i - 1].ToString);
  end;
end;

procedure TForm1.ui_enable(enb: boolean);
begin
  // enb
  btnStart.Enabled := enb;
  btnTestParam.Enabled := enb;
  ValueListEditor1.Enabled := enb;

  // not enb
  btnStop.Enabled := not enb;
  btnSend.Enabled := not enb;
end;

procedure TForm1.send_packet;
var
  arr: TIdBytes;
  val: double;
  st: double;
  index: integer;
  wd: Int16;
begin
  SetLength(arr, sample_freq * 2 * 3);

  index := 0;
  for var x := 0 to sample_freq - 1 do
  begin
    for var ch := 0 to 2 do
    begin
      st := sita[ch];
      val := gain[ch] * sin(st) + offset[ch];
      st := st + delta[ch];
      sita[ch] := st;
      wd := Round(val);
      arr[index] := Byte(wd shr 8); // ビッグエンディアン
      inc(index);
      arr[index] := Byte(wd);
      inc(index);
    end;
  end;

  IdUDPClient1.SendBuffer(arr);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  send_packet;
end;

end.
