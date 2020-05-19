program Overloading2;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TRectangle = class
  public
    procedure Draw(AWidth, AHeight: integer); overload;
    procedure Draw(ASize: integer); overload;
  end;

procedure TRectangle.Draw(AWidth, AHeight: integer);
begin
  Writeln('Drawing rectangle');
end;

procedure TRectangle.Draw(ASize: integer);
begin
  Writeln('Drawing square');
end;

var
  Rectangle: TRectangle;

begin
  Rectangle := TRectangle.Create;
  try
    Rectangle.Draw(10, 5);
    Rectangle.Draw(10);
  finally
    Rectangle.Free;
  end;

  Readln;

end.
