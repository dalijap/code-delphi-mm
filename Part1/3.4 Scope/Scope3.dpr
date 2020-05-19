program Scope3;

var
  x: Integer;

procedure Proc;
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

