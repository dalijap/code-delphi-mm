program Dangling;

{$APPTYPE CONSOLE}

uses
  // FastMM4,
  System.SysUtils,
  System.Classes;

procedure Proc;
var
  Obj: TObject;
  Owner, Child: TComponent;
begin
// initialize Obj to nil for testing purposes
  Obj := nil;
  Writeln('Obj initialized');
  Writeln('Obj address ', NativeUInt(Obj), ', is nil ', Obj = nil, ', assigned ', Assigned(Obj));
  Obj := TObject.Create;
  Writeln('Obj created');
  Writeln('Obj address ', NativeUInt(Obj), ', is nil ', Obj = nil, ', assigned ', Assigned(Obj));
  Writeln(Obj.ToString);
  Obj.Free;
// at this point, Obj is a dangling pointer
  Writeln('Obj released');
  Writeln('Obj address ', NativeUInt(Obj), ', is nil ', Obj = nil, ', assigned ', Assigned(Obj));
  Writeln(Obj.ToString);
// Some unrelated code that will overwrite memory
// Note: whether or not Obj memory will actually be overwritten with following code, depends on the Delphi version.
// That does not mean that some Delphi versions are protected from dangling references, only that slightly diferent
// code is needed to produce dangling reference you can easily detect with simple Obj.ToString code
// FastMM4 in full debug mode can be used to detect access to released objects - stale and dangling references
  Owner := TComponent.Create(nil);
  Child := TComponent.Create(Owner);
  Writeln('Obj address ', NativeUInt(Obj), ', is nil ', Obj = nil, ', assigned ', Assigned(Obj));
  Writeln(Obj.ToString);
  Owner.Free;
end;

begin
  Proc;
  Readln;
end.
