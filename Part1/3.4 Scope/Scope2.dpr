program Scope2;

procedure Proc;
var
  x: Integer;
begin
  x := 5;
  Writeln('Local ', x);
end;

begin
  x := 3;
  writeln('Global ', x);
  Proc;
  Writeln('Global ', x);
  Readln;
end.

