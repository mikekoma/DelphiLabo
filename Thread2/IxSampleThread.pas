unit IxSampleThread;

interface

uses
  System.Classes, System.Generics.Collections, System.SyncObjs, System.SysUtils;

type
  TIxSampleThread = class(TThread)
  private
    { Private éŒ¾ }
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
  FreeOnTerminate := True; // I—¹‰ğ•ú
  Queue := TQueue<string>.Create;
end;

procedure TIxSampleThread.Execute;
var
  value: string;
begin
  while (not Terminated) and (Queue.Count > 0) do
  begin
    value := Queue.Dequeue;
    sleep(1000); // 1•b
  end;
  Queue.Free;
end;

end.
