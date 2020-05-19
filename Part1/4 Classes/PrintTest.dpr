program PrintTest;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TParent = class
  public
// The virtual keyword is necessary for method overriding.
    procedure Print; virtual;
  end;

  TChild = class(TParent)
  public
    procedure Print; override;
    procedure DifferentPrint;
  end;

procedure TParent.Print;
begin
  WriteLn('This is the parent''s output.');
end;

procedure TChild.Print;
begin
// We are not calling inherited here because we want to print our own stuff.
  WriteLn('This is the child''s output.');
end;

procedure TChild.DifferentPrint;
begin
// Calls TChild's immediate parent's Print function.
// In this case, that's TParent.Print.
  inherited Print;
end;

var
  c: TChild;
begin
  c := TChild.Create;
  try
    c.Print;
    c.DifferentPrint;
  finally
    c.Free;
  end;
  Readln;
end.
