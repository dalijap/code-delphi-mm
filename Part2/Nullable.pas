unit Nullable;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Defaults;

type
  TNullable<T> = record
  strict private
    FValue: T;
    FHasValue: IInterface;
    function GetValue: T;
    function GetHasValue: boolean;
  public
    constructor Create(AValue: T);
    function ValueOrDefault: T; overload;
    function ValueOrDefault(Default: T): T; overload;
    property HasValue: boolean read GetHasValue;
    property Value: T read GetValue;
    class operator Implicit(Value: TNullable<T>): T;
    class operator Implicit(Value: T): TNullable<T>;
    class operator Explicit(Value: TNullable<T>): T;
    class operator NotEqual(const Left, Right: TNullable<T>): boolean;
    class operator Equal(const Left, Right: TNullable<T>): boolean;
  end;

procedure SetFakeInterface(var Intf: IInterface);

implementation

function NopAddRef(inst: Pointer): integer; stdcall;
begin
  Result := -1;
end;

function NopRelease(inst: Pointer): integer; stdcall;
begin
  Result := -1;
end;

function NopQueryInterface(inst: Pointer; const IID: TGUID; out Obj): HResult; stdcall;
begin
  Result := E_NOINTERFACE;
end;

const
  FakeInterfaceVTable: array [0 .. 2] of Pointer = (@NopQueryInterface, @NopAddRef, @NopRelease);
  FakeInterfaceInstance: Pointer                 = @FakeInterfaceVTable;

procedure SetFakeInterface(var Intf: IInterface);
begin
  Intf := IInterface(@FakeInterfaceInstance);
end;

constructor TNullable<T>.Create(AValue: T);
begin
  FValue := AValue;
  SetFakeInterface(FHasValue);
end;

function TNullable<T>.GetHasValue: boolean;
begin
  Result := FHasValue <> nil;
end;

function TNullable<T>.GetValue: T;
begin
  if not HasValue then raise Exception.Create('Invalid operation, Nullable type has no value');
  Result := FValue;
end;

function TNullable<T>.ValueOrDefault: T;
begin
  if HasValue then Result := FValue
  else Result := default (T);
end;

function TNullable<T>.ValueOrDefault(Default: T): T;
begin
  if not HasValue then Result := default
  else Result := FValue;
end;

class operator TNullable<T>.Explicit(Value: TNullable<T>): T;
begin
  Result := Value.Value;
end;

class operator TNullable<T>.Implicit(Value: TNullable<T>): T;
begin
  Result := Value.Value;
end;

class operator TNullable<T>.Implicit(Value: T): TNullable<T>;
begin
  Result := TNullable<T>.Create(Value);
end;

class operator TNullable<T>.Equal(const Left, Right: TNullable<T>): boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  if Left.HasValue and Right.HasValue then
    begin
      Comparer := TEqualityComparer<T>.Default;
      Result := Comparer.Equals(Left.Value, Right.Value);
    end
  else Result := Left.HasValue = Right.HasValue;
end;

class operator TNullable<T>.NotEqual(const Left, Right: TNullable<T>): boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  if Left.HasValue and Right.HasValue then
    begin
      Comparer := TEqualityComparer<T>.Default;
      Result := not Comparer.Equals(Left.Value, Right.Value);
    end
  else Result := Left.HasValue <> Right.HasValue;
end;

end.
