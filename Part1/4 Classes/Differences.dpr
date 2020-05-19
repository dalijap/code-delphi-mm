program Differences;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

type
  TType1 = class(TObject)
  public
    procedure OverriddenMethod; virtual;
    procedure HiddenMethod; virtual;
    procedure IgnoredMethod; virtual;
  end;

  TType2 = class(TType1)
  public
    procedure OverriddenMethod; override;
    procedure HiddenMethod; reintroduce; virtual;
    procedure TestMethod;
  end;

procedure TType1.OverriddenMethod;
begin
  WriteLn('TType1 Override');
end;

procedure TType1.HiddenMethod;
begin
  WriteLn('TType1 Hidden');
end;

procedure TType1.IgnoredMethod;
begin
  WriteLn('Calling Override ...');
  OverriddenMethod;
end;

procedure TType2.OverriddenMethod;
begin
  WriteLn('TType2 Override');
end;

procedure TType2.HiddenMethod;
begin
  WriteLn('TType2 Hidden');
end;

procedure TType2.TestMethod;
begin
  WriteLn('Internal inheritance test ...');
  inherited OverriddenMethod;
  OverriddenMethod;
  inherited HiddenMethod;
  HiddenMethod;
  inherited IgnoredMethod;
  IgnoredMethod;
end;

var
  Object1: TType1;
  Object2: TType2;
begin
  Object1 := TType1.Create;
  try
    Object1.OverriddenMethod;
    Object1.HiddenMethod;
    Object1.IgnoredMethod;
  finally
    Object1.Free;
  end;

  Object1 := TType2.Create;
  try
    Object1.OverriddenMethod;
    Object1.HiddenMethod;
    Object1.IgnoredMethod;
  finally
    Object1.Free;
  end;

  Object2 := TType2.Create;
  try
    Object2.OverriddenMethod;
    Object2.HiddenMethod;
    Object2.IgnoredMethod;
    Object2.TestMethod;
  finally
    Object2.Free;
  end;

  Readln;

end.
