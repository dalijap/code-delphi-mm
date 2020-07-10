program NullObjectPattern;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes;

type
  TLogger = class(TObject)
  public
    procedure Log(const Msg: string); virtual; abstract;
  end;

  TNullLogger = class(TLogger)
  public
    procedure Log(const Msg: string); override;
  end;

  TConsoleLogger = class(TLogger)
  public
    procedure Log(const Msg: string); override;
  end;

  TRocket = class(TObject)
  protected
    Logger: TLogger;
  public
    constructor Create(ALogger: TLogger);
    procedure Design;
    procedure Build;
    procedure Launch;
    procedure Go;
  end;

procedure TNullLogger.Log(const Msg: string);
begin
// do nothing
end;

procedure TConsoleLogger.Log(const Msg: string);
begin
  Writeln('Log: ', Msg);
end;

constructor TRocket.Create(ALogger: TLogger);
begin
  inherited Create;
  Logger := ALogger;
end;

procedure TRocket.Design;
begin
  Logger.Log('Designing');
// designing code goes here
end;

procedure TRocket.Build;
begin
  Logger.Log('Building');
// rocket building code goes here
end;

procedure TRocket.Launch;
begin
  Logger.Log('Launching');
// whatever you need to launch the rocket
  Logger.Log('Looking good');
end;

procedure TRocket.Go;
begin
  Logger.Log('Going to the Moon');
  Design;
  Build;
  Launch;
  Logger.Log('See you there...');
end;

var
  SomeLogger: TLogger;
  Rocket: TRocket;
begin
  SomeLogger := TConsoleLogger.Create;
  try
    Rocket := TRocket.Create(SomeLogger);
    try
      Rocket.Go;
    finally
      Rocket.Free;
    end;
  finally
    SomeLogger.Free;
  end;

  Readln;
end.
