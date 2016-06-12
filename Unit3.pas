unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

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
    AgeMaxLabel: TEdit;
    AgeMinLabel: TEdit;
    MaximumLabel: TLabel;
    HeightMaxLable: TEdit;
    HeightMinLabel: TEdit;
    WeightMaxLable: TEdit;
    WeightMinLabel: TEdit;
    Splitter2: TSplitter;
    BackButton: TButton;
    AddButton: TButton;
    procedure BackButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.BackButtonClick(Sender: TObject);
begin
  Form3.Close;
end;

end.
