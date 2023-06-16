unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, FMX.Platform, IxSampleThread;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    SpinBox1: TSpinBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { private 宣言 }
    [volatile] thread_live: boolean;
    thread: TIxSampleThread;
    procedure onterminate_thread(Sender: TObject);
  public
    { public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  num: integer;
begin
  // スレッドが起動していたら実行しない
  if thread_live then
    Exit;

  Button1.Enabled := false;
  try
    Memo1.Lines.Add('処理開始');
    // ------------------------------------
    // スレッド生成
    // ------------------------------------
    thread := TIxSampleThread.Create(True); // 停止状態で生成
    thread.FreeOnTerminate := True; // 終了時解放
    thread.OnTerminate := onterminate_thread; // 終了時イベント発生
    thread_live := True;

    // ------------------------------------
    // スレッドに渡すデータ準備
    // ------------------------------------
    num := Round(SpinBox1.Value);
    for var i := 0 to Round(num) - 1 do
    begin
      thread.Queue.Enqueue(i.ToString);
    end;

    // ------------------------------------
    // スレッド起動
    // ------------------------------------
    thread.Resume;

    // ------------------------------------
    // スレッド終了まち
    // ------------------------------------
    while thread_live do
      Application.ProcessMessages;

  finally
    Button1.Enabled := True;
  end;

  Memo1.Lines.Add('処理終了');
end;

{
  注意
  FormDestroyでスレッドを停止した時はOnTerminate発生しない
}
procedure TForm1.onterminate_thread(Sender: TObject);
begin
  thread_live := false;
  Memo1.Lines.Add('OnTerminateイベント：スレッド終了');
end;

end.
