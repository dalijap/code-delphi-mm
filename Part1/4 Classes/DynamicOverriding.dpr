program DynamicOverriding;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TSomeObject = class(TObject)
  public
// We could just as easily have used 'dynamic' here.
    procedure DoSomething; virtual;
  end;

  TAnotherObject = class(TSomeObject)
  public
    procedure DoSomething; override;
  end;

procedure TSomeObject.DoSomething;
begin
  WriteLn('I identify with the number 42.');
end;

procedure TAnotherObject.DoSomething;
begin
  WriteLn('I prefer the number 47.');
end;

var
  AnOverrideTest: TSomeObject;
begin
  AnOverrideTest := TSomeObject.Create;
  try
    AnOverrideTest.DoSomething;
  finally
    AnOverrideTest.Free;
  end;

  AnOverrideTest := TAnotherObject.Create;
  try
    AnOverrideTest.DoSomething;
  finally
    AnOverrideTest.Free;
  end;

  Readln;
end.
