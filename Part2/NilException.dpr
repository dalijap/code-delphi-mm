program NilException;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes;

type
  TFoo = class(TObject)
  public
    First: integer;
    Second: string;
  end;

var
  Foo: TFoo;

begin
  Foo := nil;
  try
    Foo.Destroy;
  except
    on E: Exception do Writeln(E.Message);
  end;

  try
    Writeln(Foo.First);
  except
    on E: Exception do Writeln(E.Message);
  end;

  try
    Writeln(Foo.Second);
  except
    on E: Exception do Writeln(E.Message);
  end;

  Readln;;

end.
