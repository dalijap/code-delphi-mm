program NilComparisonFunc;

{$APPTYPE CONSOLE}

type
  TObjectFunction = function: TObject;

function GetObject: TObject;
begin
  Result := nil;
end;

var
  f: TObjectFunction;
begin
  f := GetObject;
  if f <> nil then Writeln('f is not nil')
  else Writeln('f is nil');

  Readln;
end.
