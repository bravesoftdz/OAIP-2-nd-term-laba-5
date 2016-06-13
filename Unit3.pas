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
  changed : boolean;

procedure AddClientRecord(var list : PTClientList);
procedure ChangeClientInfo(var list : PTClientList; count : integer);
procedure DeleteClientRecord(var list : PTClientList; count : integer);

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

procedure ClearFields;
begin
  Form3.NameEdit.Clear;
  Form3.AgeEdit.Clear;
  Form3.WeightEdit.Clear;
  Form3.HeightEdit.Clear;
  Form3.AgeMinEdit.Clear;
  Form3.AgeMaxEdit.Clear;
  Form3.WeightMinEdit.Clear;
  Form3.WeightMaxEdit.Clear;
  Form3.HeightMinEdit.Clear;
  Form3.HeightMaxEdit.Clear;
end;

procedure AddClientRecord(var list : PTClientList);
begin
  ClearFields;
  form3.Show;
  changed := false;
  client := list;
  while client^.next <> nil do client := client^.next;
  new(client^.next);
  client := client^.next;
  new(client^.data);
end;

procedure FillFields;
begin
  try
    Form3.NameEdit.Text := client^.data^.name;
    Form3.AgeEdit.Text := intToStr(client^.data^.age);
    Form3.WeightEdit.Text := intToStr(client^.data^.weight);
    Form3.HeightEdit.Text := intToStr(client^.data^.height);
    Form3.AgeMinEdit.Text := intToStr(client^.data^.partnerAge[MIN]);
    Form3.AgeMaxEdit.Text := intToStr(client^.data^.partnerAge[MAX]);
    Form3.WeightMinEdit.Text := intToStr(client^.data^.partnerWeight[MIN]);
    Form3.WeightMaxEdit.Text := intToStr(client^.data^.partnerWeight[MAX]);
    Form3.HeightMinEdit.Text := intToStr(client^.data^.partnerHeight[MIN]);
    Form3.HeightMaxEdit.Text := intToStr(client^.data^.partnerHeight[MAX]);
  except
    ShowMessage('Запись не была выбрана');
  end;
end;

procedure ChangeClientInfo(var list : PTClientList; count : integer);
var
  i : integer;
begin
  form3.Show;
  i := 0;
  client := list;
  while i <= count do
  begin
    client := client^.next;
    if client^.visible then inc(i);
  end;
  FillFields;
end;

procedure DeleteClientRecord(var list : PTClientList; count : integer);
var
  i : integer;
  pnt, temp : PTClientList;
begin
  pnt := list;
  i := 0;
  while i < count do
  begin
    pnt := pnt^.next;
    if pnt^.visible then inc(i);
  end;
  temp := pnt^.next;
  pnt^.next := pnt^.next^.next;
  Dispose(temp);
end;

procedure TForm3.AddButtonClick(Sender: TObject);
begin
  if Form3.CheckInputData then
  try
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
  except
    ShowMessage('Запись не была выбран');
  end;
end;

procedure TForm3.BackButtonClick(Sender: TObject);
begin
  Form3.Close;
end;

end.
