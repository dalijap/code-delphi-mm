program NilComparison;

{$APPTYPE CONSOLE}

type
  TProcedure = procedure;

procedure Print;
begin
  Writeln('Printing');
end;

var
  p: TProcedure;

begin
  p := Print;
//  following line cannot be compiled
//  if p <> nil then p;

  if @p <> nil then p;

  Readln;
end.
