unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

const
  MIN = 1;
  MAX = 2;
  WOMAN_FILE = 'woman.myext';
  MAN_FILE = 'man.myext';

type
  TMyCountType = byte;
  //��� ������, �������� ������ � �������� ����������� � ������������ ���������� ��������
  TDiapason = array [MIN..MAX] of TMyCountType;
  TName = string[50];

  //��� ������, ������ ������ � �������
  TClient = record
    name : TName;                                 //���
    age : TMyCountType;                           //�������
    weight : TMyCountType;                        //���
    height : TMyCountType;                        //����
    partnerAge : TDiapason;                       //�������� �������� ��������
    partnerWeight : TDiapason;                    //�������� ���� ��������
    partnerHeight : TDiapason;                    //�������� ����� �������
  end;

  //��������� �� ������ ��������
  PTClientList = ^TClientList;
  TClientList = record
    data : ^TClient;                              //������ � �������
    visible : boolean;
    next : PTClientList;                          //�������� �� ���������� �������
  end;

  TForm1 = class(TForm)
    WomanListBox: TListBox;
    ManListBox: TListBox;
    ManAgreeButton: TButton;
    WomanAgreeButton: TButton;
    ManAddButton: TButton;
    ManChangeButton: TButton;
    ManDeleteButton: TButton;
    WomanAddButton: TButton;
    WomanChangeButton: TButton;
    WomanDeleteButton: TButton;
    CloseImage: TImage;
    RefreshImage: TImage;
    ManDisagreeButton: TButton;
    WomanDisagreeButton: TButton;
    ManAgreeImage: TImage;
    WomanAgreeImage: TImage;
    procedure CloseImageClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CreateManList;
    procedure CreateWomanList;
    procedure ManAddButtonClick(Sender: TObject);
    procedure RefreshImageClick(Sender: TObject);
    procedure WomanAddButtonClick(Sender: TObject);
    procedure ManChangeButtonClick(Sender: TObject);
    procedure WomanChangeButtonClick(Sender: TObject);
    procedure ManDeleteButtonClick(Sender: TObject);
    procedure WomanDeleteButtonClick(Sender: TObject);
    procedure ManAgreeButtonClick(Sender: TObject);
    procedure WomanAgreeButtonClick(Sender: TObject);
    procedure ManDisagreeButtonClick(Sender: TObject);
    procedure WomanDisagreeButtonClick(Sender: TObject);
    procedure ManListBoxClick(Sender: TObject);
    procedure WomanListBoxClick(Sender: TObject);
  private
    manAgree, womanAgree : boolean;
  public
    manList, womanList : PTClientList;
  end;


var
  Form1: TForm1;

procedure CreateList(var list : PTClientList; const fileName : string);

implementation

{$R *.dfm}

uses
  Unit3;


//������� ��������� �� �����
//���������� 1, ���� ���1 > �����2
//���������� 0, ���� ���1 = �����2
//���������� -1, ���� ���1 < �����2
function CompareByName(const Client1, Client2 : PTClientList) : integer;
begin
  Result := 0;
  if client1.data^.name > client2.data^.name then inc(Result)
  else if client1.data^.name < client1.data^.name then dec(Result);
end;

//������� ��������� �� ��������
//���������� 1, ���� �������1 > ��������2
//���������� 0, ���� �������1 = ��������2
//���������� -1, ���� �������1 < ��������2
function CompareByAge(const client1, client2 : PTClientList) : integer;
begin
  Result := 0;
  if client1.data^.age > client2.data^.age then inc(Result)
  else if client1.data^.age < client1.data^.age then dec(Result);
end;

//������� ��������� �� ����
//���������� 1, ���� ���1 > ����2
//���������� 0, ���� ���1 = ����2
//���������� -1, ���� ����1 < ����2
function CompareByWeight(const client1, client2 : PTClientList) : integer;
begin
  Result := 0;
  if client1.data^.weight > client2.data^.weight then inc(Result)
  else if client1.data^.weight < client1.data^.weight then dec(Result);
end;

//������� ��������� �� �����
//���������� 1, ���� ����1 > �����2
//���������� 0, ���� ����1 = �����2
//���������� -1, ���� ����1 < �����2
function CompareByHeight(const client1, client2 : PTClientList) : integer;
begin
  Result := 0;
  if client1.data^.height > client2.data^.height then inc(Result)
  else if client1.data^.height < client1.data^.height then dec(Result);
end;

//������� ���������, ������ �� ������������ �������� � ��������
//���������� TRUE, ���� ������, FALSE, ���� ���
function ParameterInDiapason(param : TMyCountType; var diapason : TDiapason) : boolean;
begin
  Result := (param >= diapason[MIN]) and (param <= diapason[MAX]);
end;

//��������� �������� ������ ������
procedure TForm1.CreateManList;
begin
  CreateList(manList, MAN_FILE);
end;

//��������� �������� ������ ������
procedure TForm1.CreateWomanList;
begin
  CreateList(womanList, WOMAN_FILE);
end;

//��������� ������ ������ �� ����� filename � ����������� ������ list
procedure CreateList(var list : PTClientList; const fileName : string);
var
  F : file of TClient;
  pnt : PTClientList;
begin
  AssignFile(F, fileName);               //��������� �������� ���������� � ������
  new(list);                             //������ ������ ������� ������
  list.next := nil;
  pnt := list;
  if FileExists(fileName) then           //��������� ������������� �����
  try
    Reset(F);
    while not EOF(F) do
    begin
      new(pnt^.next);                    //������ ����� ������������ ������
      pnt := pnt^.next;
      new(pnt.data);
      Read(F, pnt.data^);                //������ � ���� �� ����
      pnt^.visible := true;
      pnt^.next := nil;
    end;
  finally
    CloseFile(F);                        //��������� ����
  end;
end;

//��������� ������ ������ � ����
procedure SaveData(var list : PTClientList; const fileName : string);
var
  F : file of TClient;
begin
  AssignFile(F, fileName);               //��������� ������� ���������� � ������
  try
    Rewrite(F);                          //��������� ���� �� ����������
    list := list^.next;
    while list <> nil do
    begin
      Write(F, list^.data^);             //����� � ���� ������ �� ������
      list := list^.next;
    end;
  finally
    CloseFile(F);                        //��������� ����
  end;
end;

//������� �� �������� ����������
procedure TForm1.CloseImageClick(Sender: TObject);
begin
  SaveData(manList, MAN_FILE);           //��������� ������
  SaveData(WomanList, WOMAN_FILE);
  Close;                                 //��������� ����������
end;

//�������� �������� ������� �� ������� ����������
procedure TForm1.FormActivate(Sender: TObject);
begin
  if manList = nil then Form1.CreateManList;
  if womanList = nil then Form1.CreateWomanList;
  manAgree := false;
  womanAgree := false;
end;

//������� ���������� ������� ����� ������
function GetListSize(list : PTClientList) : integer;
begin
  Result := 0;
  while list^.next <> nil do
  begin
    inc(Result);
    list := list^.next;
  end;
end;

procedure PrintList(pnt : PTClientList; var listBox : TListBox);
begin
  while pnt <> nil do               //����� ������ � ��������
  begin
    if pnt^.visible then
      ListBox.Items.Add(pnt.data^.name + ', ' + intToStr(pnt.data^.age) + ', ' +
                        intToStr(pnt.data^.weight) + ', ' + intToStr(pnt^.data^.height));
    pnt := pnt^.next;
  end;
end;

//��������� ������ ������ � ListBox-�
procedure TForm1.RefreshImageClick(Sender: TObject);
var
  pnt : PTClientList;
begin
  Form1.ManListBox.Clear;
  Form1.ManListBox.Font.Color := clBlack;
  Form1.WomanListBox.Clear;
  Form1.WomanListBox.Font.Color := clBlack;
  pnt := manList^.next;
  while pnt <> nil do
  begin
    pnt^.visible := true;
    pnt := pnt^.next;
  end;
  pnt := womanList^.next;
  while pnt <> nil do
  begin
    pnt^.visible := true;
    pnt := pnt^.next;
  end;
  PrintList(manList^.next, Form1.ManListBox);
  PrintList(womanList^.next, Form1.WomanListBox);
end;

//������� �� ������� ����, �������� ��������� ��������� ������ �������� � ������ ������
procedure TForm1.WomanAddButtonClick(Sender: TObject);
begin
  Unit3.AddClientRecord(womanList);
end;

//������� �� ������� ����, �������� ��������� ��������� ������ �������� � ������ ������
procedure TForm1.ManAddButtonClick(Sender: TObject);
begin
  Unit3.AddClientRecord(manList);
end;

procedure DeletePair;
begin
  if (Form1.WomanListBox.ItemIndex <> -1) and (Form1.ManListBox.ItemIndex <> -1) then
  begin
    Unit3.DeleteClientRecord(Form1.manList, Form1.ManListBox.ItemIndex);
    Unit3.DeleteClientRecord(Form1.womanList, Form1.WomanListBox.ItemIndex);
    Form1.ManAgree := false;
    Form1.WomanAgree := false;
    Form1.ManAgreeImage.Visible := false;
    Form1.WomanAgreeImage.Visible := false;
  end;
end;

procedure TForm1.ManAgreeButtonClick(Sender: TObject);
begin
  ManAgree := true;
  ManAgreeImage.Visible := true;
  if womanAgree then DeletePair;
end;

procedure TForm1.WomanAgreeButtonClick(Sender: TObject);
begin
  WomanAgree := true;
  WomanAgreeImage.Visible := true;
  if manAgree then DeletePair;
end;

procedure TForm1.WomanChangeButtonClick(Sender: TObject);
begin
  if Form1.WomanListBox.ItemIndex <> -1 then
    Unit3.ChangeClientInfo(womanList, Form1.WomanListBox.ItemIndex);
end;

procedure TForm1.ManChangeButtonClick(Sender: TObject);
begin
  if Form1.ManListBox.ItemIndex <> -1 then
    Unit3.ChangeClientInfo(manList, Form1.ManListBox.ItemIndex);
end;

procedure TForm1.ManDeleteButtonClick(Sender: TObject);
begin
  if Form1.ManListBox.ItemIndex <> -1 then
    Unit3.DeleteClientRecord(manList, Form1.ManListBox.ItemIndex)
end;

procedure TForm1.WomanDeleteButtonClick(Sender: TObject);
begin
  if Form1.WomanListBox.ItemIndex <> -1 then
    Unit3.DeleteClientRecord(womanList, Form1.WomanListBox.ItemIndex)
end;

procedure TForm1.ManDisagreeButtonClick(Sender: TObject);
begin
  manAgreeImage.Visible := false;
  Form1.manAgree := false;
end;

procedure CheckClients(client, list : PTClientList; var checkList : PTClientList);
var
  pnt, head : PTClientList;
begin
  new(checkList);
  checkList^.next := nil;
  pnt := checkList;
  list := list^.next;
  while list <> nil do
  begin
    if not ParameterInDiapason(list^.data^.age, client^.data^.partnerAge) xor
       ParameterInDiapason(list^.data^.weight, client^.data^.partnerWeight) xor
       ParameterInDiapason(list^.data^.height, client^.data^.partnerHeight) xor
       ParameterInDiapason(client^.data^.age, list^.data^.partnerHeight) xor
       ParameterInDiapason(client^.data^.weight, list^.data^.partnerWeight) xor
       ParameterInDiapason(client^.data^.height, list^.data^.partnerHeight) then
    begin
      list^.visible := false;
    end;
    list := list^.next;
  end;
end;

function GetPnt(var list : pTClientList; index : integer) : PTClientList;
var
  i : integer;
begin
  Result := list;
  for i := 0 to index do Result := Result^.next;
end;

procedure TForm1.ManListBoxClick(Sender: TObject);
var
  checkList : PTClientList;
begin
  if Form1.ManListBox.ItemIndex <> -1 then
  begin
    CheckClients(GetPnt(manList, Form1.ManListBox.ItemIndex), womanList, checkList);
    Form1.ManListBox.Clear;
    Form1.WomanListBox.Clear;
    PrintList(manList^.next, Form1.ManListBox);
    PrintList(womanlist^.next, Form1.WomanListBox);
  end;
end;

procedure TForm1.WomanDisagreeButtonClick(Sender: TObject);
begin
  womanAgreeImage.Visible := false;
  Form1.WomanAgree := false;
end;

procedure TForm1.WomanListBoxClick(Sender: TObject);
var
  checkList : PTClientList;
begin
  if Form1.WomanListBox.ItemIndex <> -1 then
  begin
    CheckClients(GetPnt(womanList, Form1.WomanListBox.ItemIndex), ManList, checkList);
    Form1.ManListBox.Clear;
    Form1.WomanListBox.Clear;
    PrintList(manList^.next, Form1.ManListBox);
    PrintList(womanlist^.next, Form1.WomanListBox);
  end;
end;

end.


