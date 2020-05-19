program Overloading1;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

type
  TRectangle = class
  public
// We don't have to make Draw a virtual method here,
// but we're going to do it anyway.
    procedure Draw(AWidth, AHeight: integer); virtual;
  end;

  TSquare = class(TRectangle)
  public
// This is why we made Draw virtual - to point out that
// overloading a virtual method will prompt the compiler
// to throw W1010 warnings at us again unless we reintroduce it.
// Overloading a static method doesn't
// require the 'reintroduce' keyword, though.
    procedure Draw(ASize: integer); reintroduce; overload;
  end;

procedure TRectangle.Draw(AWidth, AHeight: integer);
begin
  Writeln('Drawing rectangle');
end;

procedure TSquare.Draw(ASize: integer);
begin
  Writeln('Drawing square');
end;

var
  Square: TSquare;
begin
  Square := TSquare.Create;
  try
   // Will actually draw a rectangle. Oops.
   // Maybe we need to override Draw and force it to sanitize its inputs?
   Square.Draw(10, 5);
   // Will draw a square using our overloaded Draw variant.
   Square.Draw(10);
  finally
    Square.Free;
  end;

  Readln;

end.
