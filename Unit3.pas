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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  item : TClientItem;

implementation

{$R *.dfm}


procedure TForm3.AddButtonClick(Sender: TObject);
begin
  if Form3.NameEdit.Text <> '' then item.name := Form3.NameEdit.Text
  else Form3.NameEdit.SetFocus;
  if Form3.AgeEdit.Text <> '' then item.age := strToInt(Form3.AgeEdit.Text)
  else Form3.AgeEdit.SetFocus;
  if Form3.HeightEdit.Text <> '' then item.height := strToInt(Form3.HeightEdit.Text)
  else Form3.HeightEdit.SetFocus;
  if Form3.WeightEdit.Text <> '' then item.weight := strToInt(Form3.WeightEdit.Text)
  else Form3.WeightEdit.SetFocus;
  if Form3.AgeMinEdit.Text <> '' then item.partnerAge[MIN] := strToInt(Form3.AgeMinEdit.Text)
  else Form3.AgeMinEdit.SetFocus;
  if Form3.AgeMaxEdit.Text <> '' then item.partnerAge[MAX] := strToInt(Form3.AgeMaxEdit.Text)
  else Form3.AgeMaxEdit.SetFocus;
  if Form3.WeightMinEdit.Text <> '' then item.partnerWeight[MIN] := strToInt(Form3.WeightMinEdit.Text)
  else Form3.WeightMinEdit.SetFocus;
  if Form3.WeightMaxEdit.Text <> '' then item.partnerWeight[MAX] := strToInt(Form3.WeightMaxEdit.Text)
  else Form3.WeightMaxEdit.SetFocus;
  if Form3.HeightMinEdit.Text <> '' then item.partnerHeight[MIN] := strToInt(Form3.HeightMinEdit.Text)
  else Form3.HeightMinEdit.SetFocus;
  if Form3.HeightMaxEdit.Text <> '' then item.partnerHeight[MAX] := strToInt(Form3.HeightMaxEdit.Text)
  else Form3.HeightMaxEdit.SetFocus;
end;

procedure TForm3.BackButtonClick(Sender: TObject);
begin
  Form3.Close;
end;


end.
