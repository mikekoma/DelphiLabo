unit IxSampleThread;

interface

uses
  System.Classes, System.Generics.Collections, System.SyncObjs, System.SysUtils;

type
  TIxSampleThread = class(TThread)
  private
    { Private 宣言 }
  protected
    procedure Execute; override;
  public
    Queue: TQueue<string>;
    constructor Create(CreateSuspended: Boolean);
  end;

implementation

uses Unit1;

{ TIxCopyThread }

constructor TIxSampleThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate := True; // 終了時解放
  Queue := TQueue<string>.Create;
end;

procedure TIxSampleThread.Execute;
var
  value: string;
begin
  while (not Terminated) and (Queue.Count > 0) do
  begin
    value := Queue.Dequeue;
    sleep(1000); // 1秒
  end;
  Queue.Free;
end;

end.
