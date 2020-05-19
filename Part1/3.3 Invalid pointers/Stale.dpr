program Stale;

uses
  //FastMM4,
  System.Classes;

procedure Proc;
var
  Obj, Ref: TObject;
  Owner, Child: TComponent;
begin
  Obj := TObject.Create;
  Ref := Obj;
  Writeln('Obj created, Ref assigned');
  Writeln('Obj address ', NativeInt(Obj), ', is nil ', Obj = nil, ', assigned ', Assigned(Obj));
  Writeln('Ref address ', NativeInt(Ref), ', is nil ', Ref = nil, ', assigned ', Assigned(Ref));
  Writeln(Ref.ToString);
  Obj.Free;
  Obj := nil;

  // at this point, Ref is a stale pointer
  Writeln('Obj released');
  Writeln('Obj address ', NativeInt(Obj), ', is nil ', Obj = nil, ', assigned ', Assigned(Obj));
  Writeln('Ref address ', NativeInt(Ref), ', is nil ', Ref = nil, ', assigned ', Assigned(Ref));
  Writeln(Ref.ToString);

  // Some unrelated code that will overwrite memory
  // Note: whether or not Obj memory will actually be overwritten with following code, depends on the Delphi version.
  // That does not mean that some Delphi versions are protected from stale references, only that slightly diferent
  // code is needed to produce stale reference you can easily detect with simple Ref.ToString code
  // FastMM4 in full debug mode can be used to detect access to released objects - stale and dangling references

  Owner := TComponent.Create(nil);
  Child := TComponent.Create(Owner);
  Writeln('Ref address ', NativeInt(Ref), ', is nil ', Ref = nil, ', assigned ', Assigned(Ref));
  Writeln(Ref.ToString);
  Owner.Free;
end;

begin
  Proc;
  Readln;
end.

