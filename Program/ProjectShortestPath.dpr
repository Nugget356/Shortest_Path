program ProjectShortestPath;

uses
  Vcl.Forms,
  ShortestPath in 'ShortestPath.pas' {frmShortestPath},
  GridItemClass in 'GridItemClass.pas',
  SearchClass in 'SearchClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmShortestPath, frmShortestPath);
  Application.Run;
end.
