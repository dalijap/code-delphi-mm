unit uLifeMgr;

interface

// SmartPointer implementation with regular interface
// for disctinction named LifetimeManager

type
  ILifetimeManager<T> = interface
    function Value: T;
  end;

  TLifetimeManager<T: class, constructor> = class(TInterfacedObject, ILifetimeManager<T>)
  private
    FValue: T;
    function Value: T;
  public
    constructor Create; overload;
    constructor Create(AValue: T); overload;
    destructor Destroy; override;
  end;

implementation

constructor TLifetimeManager<T>.Create;
begin
  inherited Create;
  FValue := T.Create;
end;

constructor TLifetimeManager<T>.Create(AValue: T);
begin
  inherited Create;
  FValue := AValue;
end;

destructor TLifetimeManager<T>.Destroy;
begin
  writeln('Lifetime Manager Free ' + FValue.ClassName);
  FValue.Free;
  inherited;
end;

function TLifetimeManager<T>.Value: T;
begin
  Result := FValue;
end;

end.
