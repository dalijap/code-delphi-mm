program Classy;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

type
  TClassy = class
  public
    class var ClassLevel: integer;
    class procedure DoSomethingClassy;
  end;

class procedure TClassy.DoSomethingClassy;
begin
  Inc(ClassLevel); // Increases ClassLevel by 1.
  WriteLn('We''ve called a class method ', ClassLevel, ' times');
end;

var
  Obj: TClassy;
begin
  Obj := TClassy.Create;
  try
    Obj.DoSomethingClassy;
    // Let's short-circuit the counter a bit, shall we?
    TClassy.ClassLevel := 4;
    TClassy.DoSomethingClassy;
  finally
    Obj.Free;
  end;

  Readln;

end.
