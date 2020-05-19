program StaticBinding;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TRectangle = class(TObject)
  public
    procedure Draw;
  end;

  TSquare = class(TRectangle)
  public
    procedure Draw;
  end;

procedure TRectangle.Draw;
begin
  Writeln('Draw rectangle');
end;

procedure TSquare.Draw;
begin
  Writeln('Draw square');
end;

var
  Rectangle: TRectangle;
  Square: TSquare;

begin
  Rectangle := TRectangle.Create;
  try
    // Calls TRectangle.Draw
    Rectangle.Draw;
  finally
    Rectangle.Free;
  end;

  Rectangle := TSquare.Create;
  try
    // Still calls TRectangle.Draw,
    // even though the TSquare subclass has a Draw function of its own
    Rectangle.Draw;
    // Casts Rectangle to a TSquare and calls TSquare.Draw on it.
    // This would crash the program if Rectangle weren't a TSquare.
    TSquare(Rectangle).Draw;
  finally
    Rectangle.Free;
  end;

  Square := TSquare.Create;
  try
    // Calls TSquare.Draw
    Square.Draw;
  finally
    Square.Free;
  end;

  Readln;

end.
