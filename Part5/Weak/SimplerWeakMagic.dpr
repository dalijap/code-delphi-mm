program SimplerWeakMagic;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  uZWeak in 'uZWeak.pas';

type
  TMaterial = (Wood, Stone, Metal);

  TMagicWand = class(TObject)
  public
    Material: TMaterial;
    procedure Magic;
    function MaterialToString: string;
    destructor Destroy; override;
  end;

  TWizard = class(TObject)
  strict protected
    FWand: IWeak<TMagicWand>;
    function GetWand: TMagicWand;
    procedure SetWand(const Value: TMagicWand);
  public
    procedure UseWand;
    property Wand: TMagicWand read GetWand write SetWand;
  end;

procedure TMagicWand.Magic;
begin
  case Material of
    Wood: Writeln('Casting magic with wooden wand');
    Stone: Writeln('Casting magic with stone wand');
    Metal: Writeln('Casting magic with metal wand');
  end;
end;

function TMagicWand.MaterialToString: string;
begin
  case Material of
    Wood: Result := 'wood';
    Stone: Result := 'stone';
    Metal: Result := 'metal';
  end;
end;

destructor TMagicWand.Destroy;
begin
  Writeln('Wand has been destroyed: ', MaterialToString);
  inherited;
end;

function TWizard.GetWand: TMagicWand;
begin
  if Assigned(FWand) then Result := FWand.Ref
  else Result := nil;
end;

procedure TWizard.SetWand(const Value: TMagicWand);
begin
  FWand := TWeak<TMagicWand>.Create(Value);
end;

procedure TWizard.UseWand;
begin
  if Assigned(FWand) and Assigned(FWand.Ref) then FWand.Ref.Magic
  else Writeln('Cannot cast magic without a wand');
end;

var
  Wizard: TWizard;
  WoodenWand, MetalWand: TMagicWand;

begin
  ReportMemoryLeaksOnShutdown := true;
// creating wooden wand
  WoodenWand := TMagicWand.Create;
  WoodenWand.Material := Wood;
// creating metal wand
  MetalWand := TMagicWand.Create;
  MetalWand.Material := Metal;
// creating wizard
  Wizard := TWizard.Create;
// wizard uses wand before he has one
  Wizard.UseWand;
// wizard picks up metal wand and uses it
  Wizard.Wand := MetalWand;
  Wizard.UseWand;
// wizard picks up wooden wand and uses it
  Wizard.Wand := WoodenWand;
  Wizard.UseWand;
// fire destroys all wooden wands
  WoodenWand.Free;
// wizard tries to use wand but he no longer has one
  Wizard.UseWand;
// clean up
  MetalWand.Free;
  Wizard.Free;
  Readln;

end.
