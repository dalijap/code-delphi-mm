program TreeNullObjectSingle;

{$APPTYPE CONSOLE}

var
  Count: Integer;

type
  TNode = class(TObject)
  strict protected
    FValue: Integer;
    FLeft, FRight: TNode;
    function GetLeft: TNode; virtual;
    function GetRight: TNode; virtual;
    procedure SetLeft(const Value: TNode);
    procedure SetRight(const Value: TNode);
  public
    constructor Create(AValue: Integer);
    destructor Destroy; override;
    function IsNull: boolean; virtual;
    property Value: Integer read FValue;
    property Left: TNode read GetLeft write SetLeft;
    property Right: TNode read GetRight write SetRight;
  end;

  TNullNode = class(TNode)
  public
    class var Instance: TNode;
    class constructor ClassCreate;
    class destructor ClassDestroy;
  strict protected
    function GetLeft: TNode; override;
    function GetRight: TNode; override;
  public
    constructor Create;
    function IsNull: boolean; override;
  end;

  TBinarySearchTree = class(TObject)
  protected
    function DoSearch(AValue: Integer; ANode: TNode): TNode;
    procedure DoPrint(ANode: TNode);
  public
    Root: TNode;
    constructor Create;
    destructor Destroy; override;
    procedure Insert(AValue: Integer);
    function Search(AValue: Integer): TNode;
    procedure Print;
  end;

constructor TNode.Create(AValue: Integer);
begin
  Inc(Count);
  FValue := AValue;
  FLeft := TNullNode.Instance;
  FRight := TNullNode.Instance;
end;

destructor TNode.Destroy;
begin
  if not Left.IsNull then FLeft.Free;
  if not Right.IsNull then FRight.Free;
  inherited;
end;

function TNode.GetLeft: TNode;
begin
  Result := FLeft;
end;

function TNode.GetRight: TNode;
begin
  Result := FRight;
end;

function TNode.IsNull: boolean;
begin
  Result := false;
end;

procedure TNode.SetLeft(const Value: TNode);
begin
  FLeft := Value;
end;

procedure TNode.SetRight(const Value: TNode);
begin
  FRight := Value;
end;

class constructor TNullNode.ClassCreate;
begin
  Instance := TNullNode.Create;
end;

class destructor TNullNode.ClassDestroy;
begin
  Instance.Free;
end;

constructor TNullNode.Create;
begin
  Inc(Count);
end;

function TNullNode.GetLeft: TNode;
begin
  Result := Self;
end;

function TNullNode.GetRight: TNode;
begin
  Result := Self;
end;

function TNullNode.IsNull: boolean;
begin
  Result := true;
end;

constructor TBinarySearchTree.Create;
begin
  Root := TNullNode.Instance;
end;

destructor TBinarySearchTree.Destroy;
begin
  if not Root.IsNull then Root.Free;
  inherited;
end;

procedure TBinarySearchTree.Insert(AValue: Integer);
var
  Node, Current, Parent: TNode;
begin
  Node := TNode.Create(AValue);
  if Root.IsNull then Root := Node
  else
    begin
      Current := Root;
      while true do
        begin
          Parent := Current;
          if AValue < Parent.Value then
            begin
              Current := Current.Left;
              if Current.IsNull then
                begin
                  Parent.Left := Node;
                  break;
                end;
            end
          else
            begin
              Current := Current.Right;
              if Current.IsNull then
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
  if ANode.IsNull or (AValue = ANode.Value) then Result := ANode
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
  if not ANode.IsNull then
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
// code using single null object implementation
// is the same as code using multiple one
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
    if Tree.Search(10).IsNull then Writeln('10 not found')
    else Writeln('10 found');
  finally
    Tree.Free;
  end;
  Writeln('Total Count: ', Count);

  Readln;
end.
