program test_fillchar;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

function dump_pbyte(Buffer: PByte; num: integer): string;
var
  str: string;
  i: integer;
begin
  str := '';
  for i := 0 to num - 1 do
    str := str + ' ' + IntToHex(Buffer[i], 2);
  Result := str;
end;

function dump_var(var Buffer: array of Byte; num: integer): string;
var
  str: string;
  i: integer;
begin
  str := '';
  for i := 0 to num - 1 do
    str := str + ' ' + IntToHex(Buffer[i], 2);
  Result := str;
end;

var
  strx: string;
  bytes: TBytes;
  dynamic_arr: array of Byte;
  static_arr: array [0 .. 7] of Byte;
  static_arrw: array [0 .. 7] of Word;
  mem: PByte;
  ptr: Pointer;
  ptr_pbyte: PByte;

begin
  Writeln('RTLVersion=' + FloatToStr(System.RTLVersion));
  Writeln('CompilerVersion=' + FloatToStr(System.CompilerVersion));

  {
    procedure _FillChar(var Dest; Count: NativeInt; Value: _AnsiChr);
  }

  try
    SetLength(bytes, 8);
    SetLength(dynamic_arr, 8);
    mem := GetMemory(8);
    strx := '12345678';
    try
      Writeln('Length(bytes)=', Length(bytes)); // 8
      Writeln('Length(arrd)=', Length(dynamic_arr)); // 8
      Writeln('Length(arr)=', Length(static_arr)); // 8
      Writeln('Length(arrw)=', Length(static_arrw)); // 8←要素数。バイト数じゃない
      Writeln('Length(strx)=', Length(strx)); // 8

      // ---------------------------------------
      // FillChar引数、添え字[n]で渡す
      // ---------------------------------------
      Writeln('FillChar');
      FillChar(bytes[0], 8, 1);
      FillChar(dynamic_arr[0], 8, 2);
      FillChar(static_arr[0], 8, 3);
      FillChar(static_arrw[0], 16, 4);
      FillChar(strx[1], 8, 5);

      // ---------------------------------------
      // buffer:PByteの引数
      // ---------------------------------------
      Writeln('dump_ptr');
      Writeln(dump_pbyte(PByte(bytes), 8));
      Writeln(dump_pbyte(PByte(dynamic_arr), 8));
      Writeln(dump_pbyte(@static_arr, 8));
      Writeln(dump_pbyte(@static_arrw, 16));
      Writeln(dump_pbyte(PByte(strx), 8));

      // ---------------------------------------
      // buffer:PByteの引数
      // ---------------------------------------
      Writeln('dump_ptr');
      Writeln(dump_pbyte(PByte(bytes), 8));
      Writeln(dump_pbyte(PByte(dynamic_arr), 8));
      Writeln(dump_pbyte(@static_arr, 8));
      Writeln(dump_pbyte(@static_arrw, 16));
      Writeln(dump_pbyte(PByte(strx), 8));

      // ---------------------------------------
      // var buffer:array of byteの引数
      // ---------------------------------------
      Writeln('dump_var');
      Writeln(dump_var(bytes, 8));
      Writeln(dump_var(dynamic_arr, 8));
      Writeln(dump_var(static_arr, 8));
      Writeln(dump_var((PByte(@static_arrw))^, 8));
      Writeln(dump_var(TBytes(strx), 8));

      // ---------------------------------------
      // FillChar引数、ポインタの逆参照で渡す
      // ---------------------------------------
      Writeln('FillChar');
      FillChar(Pointer(bytes)^, 8, $20);
      FillChar(Pointer(dynamic_arr)^, 8, $22);
      // FillChar(Pointer(arr)^, 8, $23);//キャスト出来ない？
      // FillChar(Pointer(arrw)^, 16, $24);//キャスト出来ない？
      FillChar(Pointer(strx)^, 8, $25);

      // ---------------------------------------
      // buffer:PByteの引数
      // ---------------------------------------
      Writeln('dump_ptr');
      Writeln(dump_pbyte(PByte(bytes), 8));
      Writeln(dump_pbyte(PByte(dynamic_arr), 8));
      // Writeln(dump_arr(@arr, 8));
      // Writeln(dump_arr(@arrw, 16));
      Writeln(dump_pbyte(PByte(strx), 8));

    finally
      FreeMemory(mem);
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
