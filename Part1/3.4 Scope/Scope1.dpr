program Scope1;

var
  x: Integer;

procedure Proc;
var
  x: Integer;
begin
  x := 5;
  Writeln('Local ', x);
  Writeln('Global accessed from Proc ', Scope1.x);
end;

begin
  x := 3;
  writeln('Global ', x);
  Proc;
  Writeln('Global ', x);
  Readln;
end.


