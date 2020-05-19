program Wild;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

procedure Proc;
var
  Obj: TObject;
begin
  Writeln('Object address ', NativeUInt(Obj), ', is nil ', Obj = nil, ', assigned ', Assigned(Obj));
  Writeln(Obj.ToString);
end;

begin
  try
    Proc;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.

