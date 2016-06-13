unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Unit1;

type
  TForm3 = class(TForm)
    NameEdit: TEdit;
    ClientInfoLabel: TLabel;
    NameLabel: TLabel;
    AgeLabel: TLabel;
    AgeEdit: TEdit;
    HeightEdit: TEdit;
    HeightLabel: TLabel;
    WeightLabel: TLabel;
    WeightEdit: TEdit;
    PartnerInfoLabel: TLabel;
    MinimumLabel: TLabel;
    AgeMaxEdit: TEdit;
    AgeMinEdit: TEdit;
    MaximumLabel: TLabel;
    HeightMaxEdit: TEdit;
    HeightMinEdit: TEdit;
    WeightMaxEdit: TEdit;
    WeightMinEdit: TEdit;
    Splitter2: TSplitter;
    BackButton: TButton;
    AddButton: TButton;
    procedure BackButtonClick(Sender: TObject);
    function CheckInputData : boolean;
    procedure AddButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  client : PTClientList;

procedure AddClient(var list : PTClientList);
procedure ChangeClientInfo(var list : PTClientList; count : integer);

implementation

{$R *.dfm}

function TForm3.CheckInputData : boolean;
begin
  Result := (Form3.NameEdit.Text <> '') and (Form3.AgeEdit.Text <> '') and
            (Form3.HeightEdit.Text <> '') and (Form3.WeightEdit.Text <> '') and
            (Form3.AgeMinEdit.Text <> '') and (Form3.AgeMaxEdit.Text <> '') and
            (Form3.WeightMinEdit.Text <> '') and (Form3.WeightMaxEdit.Text <> '') and
            (Form3.HeightMinEdit.Text <> '') and (Form3.HeightMaxEdit.Text <> '');
end;

procedure AddClient(var list : PTClientList);
begin
  form3.Show;
  client := list;
  while client^.next <> nil do client := client^.next;
  new(client^.next);
  client := client^.next;
  new(client^.data);
end;

procedure ChangeClientInfo(var list : PTClientList; count : integer);
var
  i : integer;
begin
  client := list;
  for i := 0 to count do client := client^.next;
end;

procedure TForm3.AddButtonClick(Sender: TObject);
begin
  if Form3.CheckInputData then
  begin
    client^.data^.name := Form3.NameEdit.Text;
    client^.data^.age := strToInt(Form3.AgeEdit.Text);
    client^.data^.weight := strToInt(Form3.WeightEdit.Text);
    client^.data^.height := strToInt(Form3.HeightEdit.Text);
    client^.data^.partnerAge[MIN] := strToInt(Form3.AgeMinEdit.Text);
    client^.data^.partnerAge[MAX] := strToInt(Form3.AgeMaxEdit.Text);
    client^.data^.partnerWeight[MIN] := strToInt(Form3.WeightMinEdit.Text);
    client^.data^.partnerWeight[MAX] := strToInt(Form3.WeightMaxEdit.Text);
    client^.data^.partnerHeight[MIN] := strToInt(Form3.HeightMinEdit.Text);
    client^.data^.partnerHeight[MAX] := strToInt(Form3.HeightMaxEdit.Text);
    client^.next := nil;
    client := nil;
    Form3.Close;
  end;
end;

procedure TForm3.BackButtonClick(Sender: TObject);
begin
  Form3.Close;
end;

end.
