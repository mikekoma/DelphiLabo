unit Unit1;
{
  参考ソース
  スレッドのキューに文字列を渡す
  スレッドの処理が終わるまでボタンダウンの関数を抜けない
}

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, FMX.Platform, IxSampleThread;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    SpinBox1: TSpinBox;
    Timer1: TTimer;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private 宣言 }
    thread: TIxSampleThread;
  public
    { public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  CursorService: IFMXCursorService;
  saved_cursor: TCursor;
  num: integer;
begin
  if thread.Count = 0 then
  begin
    Button1.Enabled := false;

    num := Round(SpinBox1.Value);
    thread.Count := num;
    for var i := 0 to Round(num) - 1 do
    begin
      thread.Queue.PushItem(i.ToString);
    end;

    CursorService := TPlatformServices.Current.GetPlatformService(IFMXCursorService) as IFMXCursorService;
    saved_cursor := CursorService.GetCursor; // カーソル保存
    CursorService.SetCursor(crHourGlass); // カーソルを砂時計に変える
    Memo1.Lines.Add('カーソル変更');

    while thread.Count > 0 do;

    CursorService.SetCursor(saved_cursor); // カーソルを元に戻す
    saved_cursor := 0;
    Memo1.Lines.Add('カーソル元に戻した');
    Button1.Enabled := true;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Add('a');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  thread := TIxSampleThread.Create(false);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  thread.Terminate;
  thread.Queue.DoShutDown;
end;

end.
