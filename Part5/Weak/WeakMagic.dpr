program WeakMagic;

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
  public
    procedure UseWand;
    property Wand: IWeak<TMagicWand> read FWand write FWand;
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
  Wizard.Wand := TWeak<TMagicWand>.Create(MetalWand);
  Wizard.UseWand;
// wizard picks up wooden wand and uses it
  Wizard.Wand := TWeak<TMagicWand>.Create(WoodenWand);
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
