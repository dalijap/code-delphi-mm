program AssignedCheck;

{$APPTYPE CONSOLE}

var
  Obj: TObject;

begin
  Obj := TObject.Create;
  Obj.Free;
  // following check will be True even though Obj is no longer valid object
  if Assigned(Obj) then Writeln('Obj is assigned');

  Readln;
end.
