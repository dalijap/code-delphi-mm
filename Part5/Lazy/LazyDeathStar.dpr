program LazyDeathStar;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TTIEFighter = class(TObject)
  public
    procedure Fight;
    constructor Create;
    destructor Destroy; override;
  end;

  TDeathStar = class(TObject)
  public
    constructor Create;
    destructor Destroy; override;
    procedure DestroyPlanet(const Planet: string);
  end;

  TDeathStarLazyWrapper = class(TObject)
  strict private
    FInstance: TDeathStar;
    function GetIsAssigned: boolean;
    function GetInstance: TDeathStar;
  public
    destructor Destroy; override;
    property IsAssigned: boolean read GetIsAssigned;
    property Instance: TDeathStar read GetInstance;
  end;

  TImperialFleet = class(TObject)
  strict protected
    TIE: TTIEFighter;
    DeathStar: TDeathStarLazyWrapper;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Fight;
    procedure DestroyPlanet(const Planet: string);
  end;

constructor TTIEFighter.Create;
begin
  inherited;
  Writeln('TIE ready');
end;

destructor TTIEFighter.Destroy;
begin
  Writeln('TIE destroyed');
  inherited;
end;

procedure TTIEFighter.Fight;
begin
  Writeln('TIE engaged');
end;

constructor TDeathStar.Create;
begin
  inherited;
  Writeln('Death Star constructed');
end;

destructor TDeathStar.Destroy;
begin
  Writeln('Death Star destroyed');
  inherited;
end;

procedure TDeathStar.DestroyPlanet(const Planet: string);
begin
  Writeln(Planet, ' has been destroyed!!!');
end;

destructor TDeathStarLazyWrapper.Destroy;
begin
  FInstance.Free;
  inherited;
end;

function TDeathStarLazyWrapper.GetIsAssigned: boolean;
begin
  Result := Assigned(FInstance);
end;

function TDeathStarLazyWrapper.GetInstance: TDeathStar;
begin
  if not Assigned(FInstance) then FInstance := TDeathStar.Create;
  Result := FInstance;
end;

constructor TImperialFleet.Create;
begin
  inherited;
  TIE := TTIEFighter.Create;
  DeathStar := TDeathStarLazyWrapper.Create;
end;

destructor TImperialFleet.Destroy;
begin
  Writeln('Destroying Imperial Fleet');
  if DeathStar.IsAssigned then Writeln('Death Star is operational');
  TIE.Free;
  DeathStar.Free;
  inherited;
end;

procedure TImperialFleet.DestroyPlanet(const Planet: string);
begin
  DeathStar.Instance.DestroyPlanet(Planet);
end;

procedure TImperialFleet.Fight;
begin
  TIE.Fight;
end;

var
  Fleet: TImperialFleet;

begin
  Fleet := TImperialFleet.Create;
  try
    Fleet.Fight;
    Fleet.Fight;
    Fleet.DestroyPlanet('Alderaan');
    Fleet.Fight;
  finally
    Fleet.Free;
  end;
  Readln;
end.
