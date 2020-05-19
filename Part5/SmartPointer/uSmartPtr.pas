unit uSmartPtr;

interface

// SmartPointer implementation with anonymous method

type
  ISmartPointer<T> = reference to function: T;

  TSmartPointer<T: class, constructor> = class(TInterfacedObject, ISmartPointer<T>)
  private
    FValue: T;
    function Invoke: T;
  public
    constructor Create; overload;
    constructor Create(AValue: T); overload;
    destructor Destroy; override;
  end;

implementation

constructor TSmartPointer<T>.Create;
begin
  inherited Create;
  FValue := T.Create;
end;

constructor TSmartPointer<T>.Create(AValue: T);
begin
  inherited Create;
  FValue := AValue;
end;

destructor TSmartPointer<T>.Destroy;
begin
  writeln('Smart Pointer Free ' + FValue.ClassName);
  FValue.Free;
  inherited;
end;

function TSmartPointer<T>.Invoke: T;
begin
  Result := FValue;
end;

end.
