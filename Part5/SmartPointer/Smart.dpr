program Smart;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  uSmartPtr in 'uSmartPtr.pas',
  uLifeMgr in 'uLifeMgr.pas';

procedure UseStrings(Strings: TStrings);
begin
  Writeln(Trim(Strings.Text));
end;

procedure Unmanaged;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.Add('I am inside regular StringList');
    UseStrings(sl);
  finally
    sl.Free;
    writeln('Manual Free');
  end;
end;

procedure SmartPtr;
var
  sl: ISmartPointer<TStringList>;
begin
  sl := TSmartPointer<TStringList>.Create();
  sl.Add('I am inside automanaged StringList');

  UseStrings(sl);
end; // TStringList object instance inside sl wrapper will be destoyed at this point

procedure LifeManager;
var
  sl: ILifeTimeManager<TStringList>;
begin
  sl := TLifeTimeManager<TStringList>.Create();
  sl.Value.Add('I am inside automanaged StringList');
  UseStrings(sl.Value);
end; // TStringList object instance inside sl wrapper will be destoyed at this point

begin
  ReportMemoryLeaksOnShutdown := true;
  try
    SmartPtr;

    LifeManager;

    Unmanaged;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  Readln;
end.
