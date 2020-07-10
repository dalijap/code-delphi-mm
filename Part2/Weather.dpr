program Weather;

{$APPTYPE CONSOLE}

uses
  Nullable;

type
  TWeatherReport = record
  public
    Hour: Integer;
    Temperature: TNullable<Integer>;
    Wind: TNullable<Integer>;
    procedure Print;
  end;

procedure TWeatherReport.Print;
begin
  write('Hour: ', Hour);
  if Temperature.HasValue then write(', Temp: ', Temperature.Value)
  else write(', Temp: not measured');
  if Wind.HasValue then Writeln(', Wind: ', Wind.Value)
  else Writeln(', Wind: not measured');
end;

var
  Report: TWeatherReport;
begin
  Report.Hour := 23;
  Report.Wind := 6;
  Report.Print;

  Readln;
end.
