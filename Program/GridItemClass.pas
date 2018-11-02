unit GridItemClass;

interface
uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type TGridItem = class (TImage)
  private
    CurrentState : string;
    Posx:Integer;
    Posy:Integer;
    distance:integer;

    leftConnection : TGridItem;
    rightConnection : TGridItem;
    topConnection : TGridItem;
    bottomConnection: TGridItem;

    parentNode : TGridItem;

    visited : boolean;
  public
    //constructor Create(pCurrentState:String;pPosx,pPosy:Integer);
    function getCurrentState : string;
    function getPosx :Integer;
    function getPosy :Integer;

    function getLeftConnection : TGridItem;
    function getRightConnection : TGridItem;
    function getTopConnection : TGridItem;
    function getBottomConnection : TGridItem;
    function getParentNode : TGridItem;
    function getVisited : boolean;
    function getDistance:integer;
    procedure setCurrentState(pCurrentState : string);
    procedure setPosx (pPosx :Integer);
    procedure setPosy (pPosy :Integer);
    procedure setDistance(pDistance:Integer);
    procedure setLeftConnection(pLeftConnection : TGridItem);
    procedure setRightConnection(pRightConnection : TGridItem);
    procedure setTopConnection(pTopConnection : TGridItem);
    procedure setBottomConnection(pBottomConnection : TGridItem);

    procedure setParentNode(pParentNode : TGridItem);

    procedure setVisited(pVisited : boolean);
end;

implementation

  //Appropriate Setters and Getters provided

  function TGridItem.getCurrentState;
  begin
    getCurrentState := currentState;
  end;

  function TgridItem.getPosx;
  begin
    getPosx := Posx;
  end;

  function TGridItem.getPosy;
  begin
    getPosy := Posy;
  end;


  function TGridItem.getDistance:integer;
  begin
     getDistance:=distance;
  end;

  procedure TGridItem.setPosx(pPosx: Integer);
  begin
    Posx := pPosx;
  end;

  procedure TGridItem.setPosy(pPosy: Integer);
  begin
    Posy := pPosy
  end;

  procedure TGridItem.setCurrentState(pCurrentState: string);
  begin
    CurrentState := pCurrentState;
  end;


  procedure TGridItem.setDistance(pDistance: Integer);
  begin
      distance:=pDistance;
  end;


  function TGridItem.getLeftConnection;
  begin
    getLeftConnection := leftConnection;
  end;

  function TGridItem.getRightConnection;
  begin
    getRightConnection := rightConnection;
  end;

  function TGridItem.getTopConnection;
  begin
    getTopConnection := topConnection;
  end;

  function TGridItem.getBottomConnection;
  begin
    getBottomConnection := bottomConnection;
  end;

  function TGridItem.getParentNode;
  begin
    getParentNode := parentNode;
  end;

  function TGridItem.getVisited;
  begin
    getVisited := visited;
  end;





  procedure TGridItem.setLeftConnection(pLeftConnection: TGridItem);
  begin
    leftConnection := pLeftConnection;
  end;

  procedure TGridItem.setRightConnection(pRightConnection: TGridItem);
  begin
    rightConnection := pRightConnection;
  end;

  procedure TGridItem.setTopConnection(pTopConnection: TGridItem);
  begin
    topConnection := pTopConnection;
  end;

  procedure TGridItem.setBottomConnection(pBottomConnection: TGridItem);
  begin
    bottomConnection := pBottomConnection;
  end;

  procedure TGridItem.setParentNode(pParentNode: TGridItem);
  begin
    parentNode := pParentNode;
  end;

  procedure TGridItem.setVisited(pVisited: Boolean);
  begin
    visited := pVisited;
  end;

end.