program WildWorking;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

procedure Clear;
var
  x: NativeUInt;
begin
  x := 0;
end;

procedure Proc;
var
  Obj: TObject;
begin
  Writeln('Object address ', NativeUInt(Obj), ', is nil ', Obj = nil, ', assigned ', Assigned(Obj));
  if Assigned(Obj) then Writeln(Obj.ToString)
  else Writeln('Obj is nil');
end;

begin
  try
    Clear;
    Proc;
  except
    on E: Exception do Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
