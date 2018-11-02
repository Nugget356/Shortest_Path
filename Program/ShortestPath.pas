unit ShortestPath;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.GIFImg, GridItemClass, Generics.Collections, SearchClass;

type
  TfrmShortestPath = class(TForm)
    lblGridSize: TLabel;
    edtwidth: TEdit;
    lblx: TLabel;
    edtheight: TEdit;
    btnGrid: TButton;
    rgrpObject: TRadioGroup;
    rgrpSearchType: TRadioGroup;
    btnSearch: TButton;
    btnReset: TButton;
    pnlGrid: TPanel;
    btnSaveLocations: TButton;
    lblValidation: TLabel;
    procedure btnGridClick(Sender: TObject);
    procedure ObjectChanger(sender:TObject);
    procedure btnResetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveLocationsClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure EstablishConnections;

  private
    { Private declarations }

  item: TGridItem;
  onClickEvent : TNotifyEvent;
  GridItem:TGridItem;
  gridItemDictionary : TDictionary<string, TGridItem>;
  connectionsFrom, connectionsTo : TList<string>;
  XSize,YSize : integer;
  Seeker,Target,StopChange:Boolean;
  public
    { Public declarations }
    Procedure FindAllConnections(var connections:array of string;Key:String);
    function findSeeker() : TGridItem;
    function findTarget() : TGridItem;
    //Procedure Refresh(Sender: TObject);
  end;
var
frmShortestPath: TfrmShortestPath;

implementation

{$R *.dfm}

procedure TfrmShortestPath.btnResetClick(Sender: TObject);
{Procedure used to clear the grid, destroy components, recreates dictionarys and lists
and disables objects}
begin
  //Clears the grid, clears the lists of connections and the dictionary's.
  pnlGrid.DestroyComponents;
  gridItemDictionary := TDictionary<string, TGridItem>.Create;
  connectionsFrom := TList<string>.Create;
  connectionsTo := TList<string>.Create;
  //Disables everything
  edtwidth.Enabled:=False;
  edtHeight.Enabled:=False;
  btnGrid.Enabled:=False;
  rgrpObject.Enabled:=False;
  btnSaveLocations.Enabled:=False;
  rgrpSearchType.Enabled:=False;
  btnSearch.Enabled:=False;
  StopChange:= False;
  lblValidation.Enabled:=False;
  Seeker:=False;
  Target:=False;

  //Enables only the grid set up
  edtwidth.Enabled:=True;
  edtheight.Enabled:=True;
  btnGrid.Enabled:=True;
end;

Procedure TfrmShortestPath.FindAllConnections(var connections:array of string;Key:String);
{This procedure wil go to every node and work out the connections
to and from the neighbouring nodes.}
var I, count: Integer;
Begin
  //setting Count to 0
  count := 0;
  //from 0 to however many items there is do
  for I := 0 to connectionsFrom.Count -1 do
    begin
      //if the connection from I is the same as the key do
      if connectionsFrom.Items[I] = Key then
      begin
        //if it is found then the connection will be established
        connections[count] := connectionsTo.Items[I];
        count := count +1;
      end;
    end;
End;

procedure TfrmShortestPath.btnSaveLocationsClick(Sender: TObject);
{This procedure will validate that 1 Target and 1 Seeker has been placed,
Disable appropriate objects and will run the establishconnections procedure.}
begin
  if (Seeker <> True) or (Target <> True) then
    ShowMessage('You need to place at least 1 Target and 1 Seeker')
  else
  Begin
    //Disables the ability to change the objects
    rgrpObject.Enabled:=False;
    btnSaveLocations.Enabled:=False;
    //Enables the user to pick which search he would like to perform
    rgrpSearchType.Enabled:=True;
    btnSearch.Enabled:=True;
    //Setting the StopChange to true which will prevent the user from changing the grid
    StopChange:=True;
    //This lets us make a connection between each Image.
    EstablishConnections;
  End;
end;

procedure TfrmShortestPath.EstablishConnections;
{This Procedure will work out what is to the top, bottom, left and right
of the current node and will do this for all the nodes on the grid}
var i, J : integer;
currentItem:TGridItem;
neighbourItem:TGridItem;
connectionsTemp : array [0..3] of string;
Begin
  for J := 0 to YSize -1 do
      for I := 0 to XSize -1 do
      begin
        //this is making sure that the place on the grid exisits
        if gridItemDictionary.TryGetValue(inttostr(i)+','+inttostr(j), currentItem) then
        begin
          //rightConnection Making sure that there is an item to the right of the current position
          if gridItemDictionary.TryGetValue(inttostr(i + 1)+','+inttostr(j), neighbourItem) then
            begin
              //Checking that this item isn't classed as closed so the connection can be made.
              if neighbourItem.getCurrentState <> 'Closed'  then
              begin
                //Adding the connections
                connectionsFrom.Add(inttostr(i)+','+inttostr(j));
                connectionsTo.Add(inttostr(i + 1)+','+inttostr(j));
                neighbourItem.setParentNode(currentItem);
                currentItem.setRightConnection(neighbourItem);
              end;
            end;
          //leftConnection Making sure that there is an item to the left of the current position
          if gridItemDictionary.TryGetValue(inttostr(i - 1) +  ',' + inttostr(j), neighbourItem) then
            begin
              //Checking that this item isn't classed as closed so the connection can be made.
              if neighbourItem.getCurrentState <> 'Closed' then
              begin
                //Adding the connections
                connectionsFrom.Add(inttostr(i)+','+inttostr(j));
                connectionsTo.Add(inttostr(i-1)+','+inttostr(j));
                neighbourItem.setParentNode(currentItem);
                currentItem.setLeftConnection(neighbourItem);
              end;
            end;
          //bottomConnection Making sure that there is an item to the bottom of the current position
          if gridItemDictionary.TryGetValue(inttostr(i)+','+inttostr(j + 1), neighbourItem) then
            begin
              //Checking that this item isn't classed as closed so the connection can be made.
              if neighbourItem.getCurrentState <> 'Closed' then
              begin
                //Adding the connections
                connectionsFrom.Add(inttostr(i)+','+inttostr(j));
                connectionsTo.Add(inttostr(i)+','+inttostr(j+1));
                neighbourItem.setParentNode(currentItem);
                currentItem.setBottomConnection(neighbourItem);
              end;
            end;
          //topConnection Making sure that there is an item to the top of the current position
          if gridItemDictionary.TryGetValue(inttostr(i)+','+inttostr(j - 1), neighbourItem) then
            begin
              //Checking that this item isn't classed as closed so the connection can be made.
              if neighbourItem.getCurrentState <> 'Closed' then
              begin
                //Adding the connections
                connectionsFrom.Add(inttostr(i)+','+inttostr(j));
                connectionsTo.Add(inttostr(i)+','+inttostr(j-1));
                neighbourItem.setParentNode(currentItem);
                currentItem.setTopConnection(neighbourItem);
              end;
            end;

        end
        else
          //This should never be seen but if it does we know that there is a problem at this point.
          showmessage('Grid Item Does not exist. Please Retry or restart the program if the problem persists');

      end;
End;

function TfrmShortestPath.findSeeker() : TGridItem;
{This function will return where the seeker, or root node, is positioned on the grid}
var
  I: Integer;
  J: Integer;
  currentNode : TGridItem;
begin
  //Begin to find the seeker by going through every position it could be.
  for J := 0 to YSize -1 do
    for I := 0 to XSize -1 do
      begin
        //Accessing the item at that position
        gridItemDictionary.TryGetValue(inttostr(i)+','+inttostr(j), currentNode);
        //Checking if it's current state is a seeker
        if currentNode.getCurrentState = 'Seeker' then
          //Returning the function as the Grid Item
          findSeeker := currentNode;
      end;
end;

function TfrmShortestPath.findTarget() : TGridItem;
{This function will return where on the grid the Target node is positioned.}
var
  I: Integer;
  J: Integer;
  currentNode : TGridItem;
begin
  //Begin to find the Target by going through every position it could be.
  for J := 0 to YSize -1 do
    for I := 0 to XSize -1 do
      begin
        //Accessing the item at that position
        gridItemDictionary.TryGetValue(inttostr(i)+','+inttostr(j), currentNode);
        //Checking if it's current state is a Target
        if currentNode.getCurrentState = 'Target' then
          //Returning the function as the Grid Item
          findTarget := currentNode;
      end;
end;

procedure TfrmShortestPath.btnSearchClick(Sender: TObject);
{This proceudre will reset all visited nodes back to its originial state
the it will check which item in the search radio group has been selected
and will run the appropriate procedure in the search class.}
var
  searcher : TSearch;
  rootNode : TGridItem;
  targetNode : TGridItem;
  I,J: Integer;
  currentNode : TGridItem;

begin
  //Runs the function that saves all the connections.
  EstablishConnections;

  //Resets the visited nodes back to their original state.
  for J := 0 to YSize -1 do
    for I := 0 to XSize -1 do
      begin
        //Accessing the item at that position
        gridItemDictionary.TryGetValue(inttostr(i)+','+inttostr(j), currentNode);
        currentNode.setVisited(false);
        //Checking if it's current state is Visited
        if currentNode.getCurrentState = 'Visited' then
        Begin
          //Changes it back to Open
          CurrentNode.Picture.LoadFromFile('Open.jpg');
          CurrentNode.setCurrentState('Open');
        End;
      end;


  //when the search button is clicked the root node is set to where the seeker is
  rootNode := findSeeker();

  targetNode := findTarget();
  //Creating the Search Class
  searcher := TSearch.Create;
  //Checking which search algorithm the user would like to use
  case rgrpSearchType.ItemIndex of
    0: searcher.runBreadthFirstSearch(rootNode);
    1: searcher.runDepthFirstSearch(rootNode);
    2: searcher.runAStarSearch(rootNode, targetNode);
  end;
end;

procedure TfrmShortestPath.FormCreate(Sender: TObject);
//On startup the Dictionarys and lists need to be created so they are ready
//for variables to be stored in them.
begin
  gridItemDictionary := TDictionary<string, TGridItem>.Create;
  connectionsFrom := TList<string>.Create;
  connectionsTo := TList<string>.Create;
  //Setting that the Seeker and Target haven't been placed yet
  Seeker:=False;
  Target:=False;
  StopChange:=False;
  lblValidation.Enabled:=False;
end;

procedure TfrmShortestPath.ObjectChanger(sender:TObject);
{This Procedure will first validate that the Grid can be changed before anything
else happens. After it will check which item in the Object radio group it will
then change the grid item the user has clicked on accordingly to which item has
be selected. It will also validate that only 1 target an 1 seeker can be placed}
begin
  // If the user has pressed the save locations button then they
  //won't be able to chnage the grid
  if StopChange = True then
  //Shows a message if they do want to change the grid
  ShowMessage('Please press Reset if you are wanting to change the grid')
  else
  Begin
  //Checking which object the user wants to change the current block to.
  case rgrpObject.ItemIndex of
  0:begin
      //When replacing a seeker or target with an open block
      //It will set either one as not being placed
      if (sender as TGridItem).getCurrentState = 'Target' then
        Target:= False;
      if (sender as TGridItem).getCurrentState = 'Seeker' then
        Seeker:= False;
      //changes the image to Open as the user has selected.
      //Also changes its current state in the Grid Item Class
      (sender as TGridItem).picture.LoadFromFile('Open.jpg');
      (sender as TGridItem).setCurrentState('Open');
  end;
  1:begin
    //Checks if the target node has already been placed or not
    //and if it hasn't then change the image and set it as the Target
    if Target <> True then
    Begin
      //changes the image to Target as the user has selected.
      //Also changes its current state in the Grid Item Class
      (sender as TGridItem).picture.LoadFromFile('Target.jpg');
      (sender as TGridItem).setCurrentState('Target');
      //Setting that the user has placed a target
      Target:=True;
      //if the seeker and target has been placed then allow the user
      //to have access to the save locations button
      if (Seeker = True) then
      Begin
        btnSaveLocations.Enabled:=True;
        lblValidation.Enabled:=False;
      End;
    End
    //If the target has already been placed then display error message
    else
    ShowMessage('Only 1 Seeker and 1 Target can be placed');
  end;
  2:begin
    //Checks if the seeker node has already been placed or not
    //and if it hasn't then change the image and set it as the Seeker
    if Seeker <> True then
    Begin
      //changes the image to Seeker as the user has selected.
      //Also changes its current state in the Grid Item Class
      (sender as TGridItem).picture.LoadFromFile('Seeker.jpg');
      (sender as TGridItem).setCurrentState('Seeker');
      //Setting that the user has placed a seeker
      Seeker:=True;
      //if the seeker and target has been placed then allow the user to have access to the save locations button
      if (Target = True) then
      Begin
        btnSaveLocations.Enabled:=True;
        lblValidation.Enabled:=False;
      End;
    End
    //If the seeker has already been placed then display error message
    else
    ShowMessage('Only 1 Seeker and 1 Target can be placed');
  end;
  3:begin
      //When replacing a seeker or target with a Closed block
      //It will set either one as not being placed
      if (sender as TGridItem).getCurrentState = 'Target' then
        Target:= False;
      if (sender as TGridItem).getCurrentState = 'Seeker' then
        Seeker:= False;
      //changes the image to Closed as the user has selected.
      //Also changes its current state in the Grid Item Class
      (sender as TGridItem).picture.LoadFromFile('Closed.jpg');
      (sender as TGridItem).setCurrentState('Closed');
  end;
  end;
  End;
end;



procedure TfrmShortestPath.btnGridClick(Sender: TObject);
{This procedure will validate that the integers entered in the Width and height
text boxes are between 4 and 10 then it will correspond to the width and height
make the sizes of the grid items accordingly with the correct amount on the X and Y axis.}
var Count1,Count2,PanelWidth,PanelHeight:Integer;
begin
  //Validation to make sure that the user hasn't entered any number bigger than 10
  if (StrToInt(edtwidth.Text) > 10) Or (StrToInt(edtHeight.Text) > 10) then
  ShowMessage('Grid size must be less than 11')
  else if (StrToInt(edtwidth.Text) < 4) Or (StrToInt(edtHeight.Text) < 4) then
  ShowMessage('Grid size must be more than 0')
  else
    Begin
    //gets the size the user has inputted
    XSize:=StrToInt(edtwidth.Text);
    YSize:=StrToInt(edtheight.Text);
    //Setting what the width and height is of the panel
    PanelWidth:=670;
    PanelHeight:=670;

    //Making sure that the two sizes that user has inputted are equal to make a square
    if XSize > YSize then
      Xsize:=YSize
    else
      YSize:=Xsize;

    //creates each item as open
    for Count1 := 0 to XSize -1 do
    Begin
      for Count2 := 0 to YSize -1 do
      Begin
        //Creating the item and setting what their parametres are
        item := TGridItem.Create(pnlGrid);
        item.setPosx(count2);
        item.setPosy(count1);
        item.setCurrentState('Open');
        with item do
        begin
          //sets the parametres of the image itself
          height:=(PanelHeight Div YSize);
          width:=(PanelWidth Div XSize);
          top:=Count1*height;
          left:=Count2*Width;
          parent := pnlGrid;
          picture.LoadFromFile('Open.jpg');
          Stretch:=True;
          //If the image is clicked it will check what the user wants to change it too
          onClickEvent := ObjectChanger;
          onClick := onClickEvent;
        end;
        //Adding the Item to the dictionary
        gridItemDictionary.Add(inttostr(count2) + ',' + inttostr(count1), item);
      End;
    End;
    //Disable the users ability to edit the width and height
    //and the ability to press the create button
    edtwidth.Enabled:=False;
    edtHeight.Enabled:=False;
    btnGrid.Enabled:=False;
    lblValidation.Enabled:=True;
    //Once the grid has been created then the user can now have
    //the option to change the grid
    rgrpObject.Enabled:=True;
  End;
end;

{Procedure TfrmShortestPath.Refresh(Sender: TObject);
Begin
  Refresh;
End;     }

end.
