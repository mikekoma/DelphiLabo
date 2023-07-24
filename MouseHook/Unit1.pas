unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private 宣言 }
    mouse_event_cnt: integer;
    procedure mouse_hook_start;
    procedure mouse_hook_stop;
    procedure WMApp100(var Message: TMessage); message WM_APP + 100;
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
  MouseHookHandle: HHOOK;

  // -----------------------------------------------------------------------------
  // マウスフック
  // -----------------------------------------------------------------------------
function LowLevelMouseProc(Code: integer; wPar: wParam; lPar: lParam): LRESULT; stdcall;
begin
  if Code < 0 then
  begin
    Result := CallNextHookEx(MouseHookHandle, Code, wPar, lPar);
    exit;
  end;

  if Code = HC_ACTION then
  begin
    PostMessage(Form1.Handle, WM_APP + 100, wPar, 0); // +100
  end;

  Result := CallNextHookEx(MouseHookHandle, Code, wPar, lPar);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  mouse_hook_start;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  mouse_hook_stop;
end;

procedure TForm1.mouse_hook_start;
begin
  // マウスのグローバルフック開始
  if MouseHookHandle = 0 then
    MouseHookHandle := SetWindowsHookEx(WH_MOUSE_LL, @LowLevelMouseProc, hInstance, 0);
end;

procedure TForm1.mouse_hook_stop;
begin
  if MouseHookHandle <> 0 then
  begin
    UnhookWindowsHookEx(MouseHookHandle);
    MouseHookHandle := 0;
  end;
end;

procedure TForm1.WMApp100(var Message: TMessage);
begin
  // Mouseイベント取得
  inc(mouse_event_cnt);
  Caption := 'mouse = ' + mouse_event_cnt.ToString;
end;

end.
