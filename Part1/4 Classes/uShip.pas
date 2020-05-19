unit uShip;

interface

type
  TPart = class;

  TShip = class(TObject)
  private
// Some kind of array or collection of TPart instances.
// The details don't matter right now.
  public
    destructor Destroy; override;
    procedure AddPart(APart: TPart);
  end;

  TPart = class(TObject)
  public
    constructor Create(AShip: TShip);
  end;

implementation

destructor TShip.Destroy;
begin
// Make sure to do whatever destruction is necessary on our part storage class.
  inherited;
end;

procedure TShip.AddPart(APart: TPart);
begin
// Add APart to whatever we're using to store parts.
end;

constructor TPart.Create(AShip: TShip);
begin
  inherited Create;
// Our constructor's parameter list differs from that of our parent,
// so we need to be more specific while invoking its constructor.
// Tell the ship to add us to its part list.
  AShip.AddPart(Self);
end;

end.
