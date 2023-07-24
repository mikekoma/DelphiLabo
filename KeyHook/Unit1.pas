unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private 宣言 }
    key_event_cnt: integer;
    procedure key_hook_start;
    procedure key_hook_stop;
    procedure WMApp200(var Message: TMessage); message WM_APP + 200;
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
  KeyHookHandle: HHOOK;

  // -----------------------------------------------------------------------------
  // キーフック
  // -----------------------------------------------------------------------------
function LowLevelKeyProc(Code: integer; wPar: wParam; lPar: lParam): LRESULT; stdcall;
begin
  if Code < 0 then
  begin
    Result := CallNextHookEx(KeyHookHandle, Code, wPar, lPar);
    exit;
  end;

  if Code = HC_ACTION then
  begin
    PostMessage(Form1.Handle, WM_APP + 200, wPar, 0); // +200
  end;

  Result := CallNextHookEx(KeyHookHandle, Code, wPar, lPar);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  key_hook_start;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  key_hook_stop;
end;

procedure TForm1.key_hook_start;
begin
  // マウスのグローバルフック開始
  if KeyHookHandle = 0 then
    KeyHookHandle := SetWindowsHookEx(WH_KEYBOARD_LL, @LowLevelKeyProc, hInstance, 0);
end;

procedure TForm1.key_hook_stop;
begin
  if KeyHookHandle <> 0 then
  begin
    UnhookWindowsHookEx(KeyHookHandle);
    KeyHookHandle := 0;
  end;
end;

procedure TForm1.WMApp200(var Message: TMessage);
var
  wprm: wParam;
begin
  // Keyイベント取得
  inc(key_event_cnt);
  Caption := 'key = ' + key_event_cnt.ToString;

  wprm := Message.wParam;
  case wprm of
    WM_KEYDOWN:
      Memo1.Lines.Add('WM_KEYDOWN');
    WM_KEYUP:
      Memo1.Lines.Add('WM_KEYUP');
  else
    Memo1.Lines.Add('wParam=');
  end;

end;

end.
