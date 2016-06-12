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
    procedure AddButtonClick(Sender: TObject);
    function CheckInputData : boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  customer : TClient;

implementation

{$R *.dfm}


procedure TForm3.AddButtonClick(Sender: TObject);
var
  item : TClientItem;
begin
  if Form3.CheckInputData then
  try
    item.name := Form3.NameEdit.Text;
    item.age := strToInt(Form3.AgeEdit.Text);
    item.height := strToInt(Form3.HeightEdit.Text);
    item.weight := strToInt(Form3.WeightEdit.Text);
    item.partnerAge[MIN] := strToInt(Form3.AgeMinEdit.Text);
    item.partnerAge[MAX] := strToInt(Form3.AgeMaxEdit.Text);
    item.partnerWeight[MIN] := strToInt(Form3.WeightMinEdit.Text);
    item.partnerWeight[MAX] := strToInt(Form3.WeightMaxEdit.Text);
    item.partnerHeight[MIN] := strToInt(Form3.HeightMinEdit.Text);
    item.partnerHeight[MAX] := strToInt(Form3.HeightMaxEdit.Text);
    customer := TClient.Create(item);
    form1.manList.Add(Unit3.customer);
    customer.Free;
    customer := nil;
    Form3.Close;
  except
    ShowMessage('Фигня');
  end;
end;

function TForm3.CheckInputData : boolean;
begin
  Result := (Form3.NameEdit.Text <> '') and (Form3.AgeEdit.Text <> '') and
            (Form3.HeightEdit.Text <> '') and (Form3.WeightEdit.Text <> '') and
            (Form3.AgeMinEdit.Text <> '') and (Form3.AgeMaxEdit.Text <> '') and
            (Form3.WeightMinEdit.Text <> '') and (Form3.WeightMaxEdit.Text <> '') and
            (Form3.HeightMinEdit.Text <> '') and (Form3.HeightMaxEdit.Text <> '');
end;

procedure TForm3.BackButtonClick(Sender: TObject);
begin
  Form3.Close;
end;

end.
