unit uZWeak;

interface

uses
  System.TypInfo,
  System.Rtti,
  System.Classes,
  System.Generics.Collections;

type
// support declarations
  PInterface = ^IInterface;

  IWeak = interface
    procedure Zero;
  end;

  WeakReferences = class
  strict private
    class var Interceptors: TObjectDictionary<TClass, TVirtualMethodInterceptor>;
    class var Instances: TObjectDictionary<Pointer, TList<IWeak>>;
    class constructor ClassCreate;
    class destructor ClassDestroy;
  public
    class procedure AddInterceptor(const Instance: TObject); static;
    class procedure RemoveInstance(const Instance: TObject); static;
    class procedure AddReference(const Ref: IWeak; const Instance: TObject); static;
    class procedure RemoveReference(const Ref: IWeak; const Instance: Pointer); static;
  end;

// Zeroing weak reference container
  IWeak<T> = interface
    procedure Clear;
    function GetRef: T;
    property Ref: T read GetRef;
  end;

  TWeak<T> = class(TInterfacedObject, IWeak, IWeak<T>)
  protected
    FRef: Pointer;
    function GetRef: T;
    procedure Zero;
  public
    constructor Create(const Instance: T);
    destructor Destroy; override;
    procedure Clear;
    property Ref: T read GetRef;
  end;

implementation

class constructor WeakReferences.ClassCreate;
begin
  Interceptors := TObjectDictionary<TClass, TVirtualMethodInterceptor>.Create([doOwnsValues]);
  Instances := TObjectDictionary < Pointer, TList < IWeak >>.Create([doOwnsValues]);
end;

class destructor WeakReferences.ClassDestroy;
begin
  Instances.Free;
  Interceptors.Free;
end;

class procedure WeakReferences.AddInterceptor(const Instance: TObject);
var
  Interceptor: TVirtualMethodInterceptor;
  FreeMethod: TRttiMethod;
begin
  if not Interceptors.TryGetValue(Instance.ClassType, Interceptor) then
    begin
      FreeMethod := TRttiContext.Create.GetType(Instance.ClassType).GetMethod('FreeInstance');
      Interceptor := TVirtualMethodInterceptor.Create(Instance.ClassType);
      Interceptor.OnBefore := procedure(Intercepted: TObject; Method: TRttiMethod; const Args: TArray<TValue>; out DoInvoke: boolean; out Result: TValue)
        begin
          if Method = FreeMethod then
            begin
              RemoveInstance(Intercepted);
              DoInvoke := true;
            end;
        end;
      Interceptors.Add(Instance.ClassType, Interceptor);
    end;
  Interceptor.Proxify(Instance);
end;

class procedure WeakReferences.RemoveInstance(const Instance: TObject);
var
  Value: TList<IWeak>;
  i: integer;
begin
  TMonitor.Enter(Instances);
  try
    if Instances.TryGetValue(Instance, Value) then
      begin
        for i := 0 to Value.Count - 1 do Value[i].Zero;
        Instances.Remove(Instance);
      end;
  finally
    TMonitor.Exit(Instances);
  end;
end;

class procedure WeakReferences.AddReference(const Ref: IWeak; const Instance: TObject);
var
  Value: TList<IWeak>;
begin
  TMonitor.Enter(Instances);
  try
    AddInterceptor(Instance);
    if not Instances.TryGetValue(Instance, Value) then
      begin
        Value := TList<IWeak>.Create;
        Instances.Add(Instance, Value);
      end;
    Value.Add(Ref);
  finally
    TMonitor.Exit(Instances);
  end;
end;

class procedure WeakReferences.RemoveReference(const Ref: IWeak; const Instance: Pointer);
var
  Value: TList<IWeak>;
  i: integer;
begin
  TMonitor.Enter(Instances);
  try
    if Instances.TryGetValue(Instance, Value) then
      begin
        i := Value.IndexOf(Ref);
        if i >= 0 then Value.Delete(i);
      end
  finally
    TMonitor.Exit(Instances);
  end;
end;

constructor TWeak<T>.Create(const Instance: T);
var
  Obj: TObject;
  Intf: IInterface;
begin
  inherited Create;
  if PPointer(@Instance)^ <> nil then
    case PTypeInfo(TypeInfo(T)).Kind of
      tkClass:
        begin
          FRef := PPointer(@Instance)^;
          PObject(@Obj)^ := FRef;
          WeakReferences.AddReference(Self, Obj);
        end;
      tkInterface:
        begin
          FRef := PPointer(@Instance)^;
          Intf := IInterface(FRef);
          Obj := TObject(Intf);
          WeakReferences.AddReference(Self, Obj);
        end;
    end;
end;

destructor TWeak<T>.Destroy;
begin
  Clear;
  inherited;
end;

function TWeak<T>.GetRef: T;
begin
  if FRef <> nil then
    case PTypeInfo(TypeInfo(T)).Kind of
      tkClass: PObject(@Result)^ := FRef;
      tkInterface: PInterface(@Result)^ := IInterface(FRef);
      else Result := default (T);
    end
  else Result := default (T);
end;

procedure TWeak<T>.Zero;
begin
  FRef := nil;
end;

procedure TWeak<T>.Clear;
var
  Tmp: Pointer;
  Obj: TObject;
  Intf: IInterface;
begin
  if FRef = nil then Exit;
  Tmp := FRef;
  FRef := nil;
  case PTypeInfo(TypeInfo(T)).Kind of
    tkClass:
      begin
        PObject(@Obj)^ := Tmp;
        WeakReferences.RemoveReference(Self, Obj);
      end;
    tkInterface:
      begin
        Intf := IInterface(Tmp);
        Obj := TObject(Intf);
        WeakReferences.RemoveReference(Self, Obj);
      end;
  end;
end;

end.
