unit GraphNodeClass;

interface
type
  TGraphNode = Class
    private
      valueStored : integer;
      leftConnection : TGraphNode;
      rightConnection : TGraphNode;
      parentNode : TGraphNode;
      visited : boolean;
    published
      Constructor Create(pValue: integer);
      Procedure setLeftConnection(pNode : TGraphNode);
      Procedure setRightConnection(pNode : TGraphNode);
      Procedure setParentNode(pNode : TGraphNode);
      Procedure setVisited(pVisited : Boolean);
      Function getLeftConnection() : TGraphNode;
      Function getRightConnection() : TGraphNode;
      Function getParentNode() : TGraphNode;
      Function getValue() : integer;
      Function getVisited() : boolean;
  End;

implementation

  Constructor TGraphNode.Create(pValue : integer);
  begin
    valueStored := pValue;
    leftConnection := nil;
    rightConnection := nil;
    parentNode := nil;
    visited := false;
  end;

  Procedure TGraphNode.setLeftConnection(pNode : TGraphNode);
  begin
    leftConnection := pNode;
  end;

  Procedure TGraphNode.setRightConnection(pNode: TGraphNode);
  begin
    rightConnection := pNode;
  end;

  Procedure TGraphNode.setParentNode(pNode: TGraphNode);
  begin
    parentNode := pNode;
  end;

  Procedure TGraphNode.setVisited(pVisited: Boolean);
  begin
    visited := pVisited;
  end;

  Function TGraphNode.getLeftConnection;
  begin
    getLeftConnection := leftConnection;
  end;

  Function TGraphNode.getRightConnection;
  begin
    getRightConnection := rightConnection;
  end;

  Function TGraphNode.getParentNode;
  begin
    getParentNode := parentNode;
  end;

  Function TGraphNode.getValue;
  begin
    getValue := valueStored;
  end;

  Function TGraphNode.getVisited;
  begin
    getVisited := visited;
  end;

end.
