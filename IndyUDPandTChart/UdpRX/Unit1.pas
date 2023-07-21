unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections, System.SyncObjs, System.Diagnostics, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VclTee.TeEngine,
  VclTee.Series, VclTee.TeeProcs, VclTee.Chart, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.ValEdit, Vcl.StdCtrls, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPServer, IdGlobal, IdSocketHandle;

type
  TIxSimpleData = class(TObject)
  public
    queue_remain: integer;
    Buffer: TIdBytes;
  end;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    chkActive: TCheckBox;
    Timer1: TTimer;
    ValueListEditor1: TValueListEditor;
    Memo1: TMemo;
    IdUDPServer1: TIdUDPServer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private 宣言 }
    ChartWidth: integer; // チャートの幅
    UpdateFreq: integer; // チャート更新周期
    ChartX: integer;
    ChartW: integer;
    Queue: TThreadedQueue<TIxSimpleData>;
    interval: integer;
    queue_cnt: integer;
    critical_section: TCriticalSection;
    procedure memo(str: string);
    procedure ui_enable(enb: boolean);
    function get_param_int(index: string): integer;
    procedure correct_params;
    procedure start_udp;
    procedure stop_udp;
    procedure draw_chart(arr: TIdBytes);
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Clear;

  Queue := TThreadedQueue<TIxSimpleData>.Create(1000, INFINITE, 10); // Depth, PushTimeout, PopTimeout

  ChartX := 0;
  ChartW := 0;
  queue_cnt := 0;

  critical_section := TCriticalSection.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  IdUDPServer1.Active := false;
  Timer1.Enabled := false;

  Queue.DoShutDown;
  while not Queue.ShutDown do;
  Queue.Free;

  critical_section.Free;
end;

procedure TForm1.memo(str: string);
begin
  Memo1.Lines.Add(str);
end;

procedure TForm1.ui_enable(enb: boolean);
begin
  ValueListEditor1.Enabled := enb;
end;

function TForm1.get_param_int(index: string): integer;
begin
  Result := StrToInt(ValueListEditor1.Values[index]);
end;

procedure TForm1.correct_params;
begin
  ChartWidth := get_param_int('ChartWidth');
  UpdateFreq := get_param_int('UpdateFreq');

  interval := 1000 div UpdateFreq;
end;

procedure TForm1.chkActiveClick(Sender: TObject);
begin
  if chkActive.Checked then
    start_udp
  else
    stop_udp;
end;

procedure TForm1.start_udp;
begin
  memo('start');
  ui_enable(false);
  correct_params;

  IdUDPServer1.DefaultPort := get_param_int('Port');
  IdUDPServer1.Active := true;

  Timer1.interval := interval;
  Timer1.Enabled := true;

  Memo1.Lines.Add('receive port = ' + IntToStr(IdUDPServer1.DefaultPort));
end;

procedure TForm1.stop_udp;
begin
  memo('stop');
  ui_enable(true);
  IdUDPServer1.Active := false;
  Timer1.Enabled := false;
end;

procedure TForm1.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  sz: integer;
  ofs: integer;
  sd: TIxSimpleData;
begin
  // program1 ここでチャート更新
  // draw_chart(AData);

  // program2 そのままキューに突っ込む
  // Queue.PushItem(AData);

  // pogram3 分割してキューに突っ込む
  sz := Length(AData) div UpdateFreq;
  ofs := 0;
  for var I := 0 to UpdateFreq - 1 do
  begin
    sd := TIxSimpleData.Create;
    SetLength(sd.Buffer, sz);
    Move(AData[ofs], sd.Buffer[0], sz);

    critical_section.Acquire;
    if I = 0 then
      sd.queue_remain := queue_cnt//初回のみQueueの残量を入れる。本来は0が望ましいが、そうはならない
    else
      sd.queue_remain := 0;
    inc(queue_cnt);
    critical_section.Release;

    Queue.PushItem(sd);
    inc(ofs, sz);
  end;

end;

procedure TForm1.draw_chart(arr: TIdBytes); // パラメータはコピー渡し
var
  val: Int16;
  ch: integer;
  index: integer;
begin
  Chart1.AutoRepaint := false; // 自動更新を停止して描画速度を上げる

  ch := 0;
  index := 0;
  while index < Length(arr) do
  begin
    val := arr[index];
    val := Int16(val shl 8); // ビッグエンディアン
    inc(index);
    val := val or Byte(arr[index]);
    inc(index);
    TLineSeries(Chart1.SeriesList.Items[ch]).AddXY(ChartX, val);
    inc(ch);
    if ch > 2 then
    begin
      ch := 0;
      inc(ChartX);
      inc(ChartW);
      if ChartW > ChartWidth then
      begin
        for var I := 0 to 2 do
          TLineSeries(Chart1.SeriesList.Items[I]).Delete(0);
      end;
    end;
  end;

  Chart1.AutoRepaint := true; // 自動更新再開
  Chart1.Invalidate; // 自動更新を再開しただけだと今回の更新がきかないので明示的に再描画
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  sd: TIxSimpleData;
  wr: TWaitResult;
  sw: TStopWatch;
  cnt: integer;
  loop_on: boolean;
  queue_remain: integer;
  str: string;
begin
  loop_on := true;
  while loop_on do
  begin
    wr := Queue.PopItem(sd);
    if (wr = TWaitResult.wrSignaled) and (sd <> nil) then
    begin
      critical_section.Acquire;
      dec(queue_cnt);
      cnt := queue_cnt;
      critical_section.Release;
      sw := TStopWatch.StartNew;
      draw_chart(sd.Buffer);
      loop_on := sd.queue_remain <> 0;
      queue_remain := sd.queue_remain;
      sd.Free;

      str := 'len=' + Length(sd.Buffer).ToString;
      str := str + ' queue=' + cnt.ToString;
      str := str + ' draw=' + sw.ElapsedMilliseconds.ToString;
      if loop_on then
        str := str + ' one more=' + queue_remain.ToString;
      memo(str);
    end
    else
      break;
  end;
end;

end.
