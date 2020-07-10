program TreeNil;

{$APPTYPE CONSOLE}

var
  Count: Integer;

type
  TNode = class(TObject)
  strict private
    FValue: Integer;
    FLeft, FRight: TNode;
  public
    constructor Create(AValue: Integer);
    destructor Destroy; override;
    property Value: Integer read FValue;
    property Left: TNode read FLeft write FLeft;
    property Right: TNode read FRight write FRight;
  end;

  TBinarySearchTree = class(TObject)
  protected
    function DoSearch(AValue: Integer; ANode: TNode): TNode;
    procedure DoPrint(ANode: TNode);
  public
    Root: TNode;
    destructor Destroy; override;
    procedure Insert(AValue: Integer);
    function Search(AValue: Integer): TNode;
    procedure Print;
  end;

constructor TNode.Create(AValue: Integer);
begin
  Inc(Count);
  FValue := AValue;
end;

destructor TNode.Destroy;
begin
  FLeft.Free;
  FRight.Free;
  inherited;
end;

destructor TBinarySearchTree.Destroy;
begin
  Root.Free;
  inherited;
end;

procedure TBinarySearchTree.Insert(AValue: Integer);
var
  Node, Current, Parent: TNode;
begin
  Node := TNode.Create(AValue);
  if Root = nil then Root := Node
  else
    begin
      Current := Root;
      while true do
        begin
          Parent := Current;
          if AValue < Parent.Value then
            begin
              Current := Current.Left;
              if Current = nil then
                begin
                  Parent.Left := Node;
                  break;
                end;
            end
          else
            begin
              Current := Current.Right;
              if Current = nil then
                begin
                  Parent.Right := Node;
                  break;
                end;
            end;
        end;
    end;
end;

function TBinarySearchTree.DoSearch(AValue: Integer; ANode: TNode): TNode;
begin
  if (ANode = nil) or (AValue = ANode.Value) then Result := ANode
  else
    if AValue < ANode.Value then Result := DoSearch(AValue, ANode.Left)
    else Result := DoSearch(AValue, ANode.Right);
end;

function TBinarySearchTree.Search(AValue: Integer): TNode;
begin
  Result := DoSearch(AValue, Root);
end;

procedure TBinarySearchTree.DoPrint(ANode: TNode);
begin
  if ANode <> nil then
    begin
      DoPrint(ANode.Left);
      Writeln(ANode.Value);
      DoPrint(ANode.Right);
    end;
end;

procedure TBinarySearchTree.Print;
begin
  DoPrint(Root);
end;

var
  Tree: TBinarySearchTree;
begin
  ReportMemoryLeaksOnShutdown := true;
  Tree := TBinarySearchTree.Create;
  try
    Tree.Insert(6);
    Tree.Insert(5);
    Tree.Insert(3);
    Tree.Insert(2);
    Tree.Insert(9);
    Tree.Insert(4);
    Tree.Insert(7);
    Tree.Insert(8);
    Tree.Insert(1);
    Tree.Print;
    if Tree.Search(10) = nil then Writeln('10 not found')
    else Writeln('10 found');
  finally
    Tree.Free;
  end;
  Writeln('Total count: ', Count);

  Readln;
end.
