unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

const
  MIN = 1;
  MAX = 2;
  MAN = TRUE;
  WOMAT = FALSE;
  WOMAN_INFO = 'woman.myext';
  MAN_INFO = 'man.myext';

type
  TMyCountType = byte;
  //��� ������, �������� ������ � �������� ����������� � ������������ ���������� ��������
  TDiapason = array [MIN..MAX] of TMyCountType;
  TName = string[50];

  //����� ������, ������ ������������ ������ � �������
  //�������� ��������� ��������� TList
  TClient = class(TObject)
  private
    name : TName;                                 //���
    age : TMyCountType;                           //�������
    weight : TMyCountType;                        //���
    height : TMyCountType;                        //����
    partnerAge : TDiapason;                       //�������� �������� ��������
    partnerWeight : TDiapason;                    //�������� ���� ��������
    partnerHeight : TDiapason;                    //�������� ����� �������
  public
    //�������� ��������� ����� �������
    property clientName : TName
      read name write name;
    //�������� ��������� �������� �������
    property clientAge : TMyCountType
      read age write age;
    //�������� ��������� ���� �������
    property clientWeight : TMyCountType
      read weight write weight;
    //�������� ��������� ����� �������
    property clientHeight : TMyCountType
      read height write height;
    //�������� ��������� ������������ �������� ��������
    property partnerAgeMin : TMyCountType
      read partnerAge[MIN] write partnerAge[MIN];
    //�������� ��������� ������������� �������� ��������
    property partnerAgeMax : TMyCountType
      read partnerAge[MAX] write partnerAge[MAX];
    //�������� ��������� ������������� ���� ��������
    property partnerWeightMin : TMyCountType
      read partnerWeight[MIN] write partnerWeight[MAX];
    //�������� ��������� ������������� ���� ��������
    property partnerWeightMax : TMyCountType
      read partnerWeight[MAX] write partnerWeight[MAX];
    //�������� ��������� ������������ ����� ��������
    property partnerHeightMin : TMyCountType
      read partnerHeight[MIN] write partnerHeight[MIN];
    //�������� ��������� ������������� ����� ��������
    property partnerHeightMax : TMyCountType
      read partnerHeight[MAX] write partnerHeight[MAX];
    //����������� �������� ������� ������
    constructor Create (const name : TName; const age : TMyCountType;
                        const weight : TMyCountType; const height : TMyCountType;
                        const partnerAge : TDiapason; const partnerWeight : TDiapason;
                        const partnerHeight : TDiapason);
  end;

  TClientRecord = record
    name : TName;
    age : TMyCountType;
    weight : TMyCountType;                        //���
    height : TMyCountType;                        //����
    partnerAge : TDiapason;                       //�������� �������� ��������
    partnerWeight : TDiapason;                    //�������� ���� ��������
    partnerHeight : TDiapason;
  end;

  TForm1 = class(TForm)
    ListBox1: TListBox;
    ListBox2: TListBox;
    AgreeManButton: TButton;
    AgreeWomanButton: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Image1: TImage;
  private
    manList : TList;
    womanList : TList;
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

procedure CreateList(var list : TList; flag : boolean);

implementation

{$R *.dfm}

//������� ����� ������� ������ �������
constructor TClient.Create (const name : TName; const age : TMyCountType;
                        const weight : TMyCountType; const height : TMyCountType;
                        const partnerAge : TDiapason; const partnerWeight : TDiapason;
                        const partnerHeight : TDiapason);
begin
  //���������� ���������� �����������
  self.name := name;
  self.age := age;
  self.weight := weight;
  self.height := height;
  self.partnerAge := partnerAge;
  self.partnerWeight := partnerWeight;
  self.partnerHeight := partnerHeight;
end;

//������� ��������� �� �����
//���������� 1, ���� ���1 > �����2
//���������� 0, ���� ���1 = �����2
//���������� -1, ���� ���1 < �����2
function CompareByName(Item1 : Pointer; Item2 : Pointer) : integer;
var
  client1, client2 : TClient;
begin
  Result := 0;
  client1 := TClient(Item1);
  client2 := TClient(Item2);
  if client1.name > client2.name then inc(Result)
  else if client1.name < client1.name then dec(Result);
end;

//������� ��������� �� ��������
//���������� 1, ���� �������1 > ��������2
//���������� 0, ���� �������1 = ��������2
//���������� -1, ���� �������1 < ��������2
function CompareByAge(Item1 : Pointer; Item2 : Pointer) : integer;
var
  client1, client2 : TClient;
begin
  Result := 0;
  client1 := TClient(Item1);
  client2 := TClient(Item2);
  if client1.age > client2.age then inc(Result)
  else if client1.age < client1.age then dec(Result);
end;

//������� ��������� �� ����
//���������� 1, ���� ���1 > ����2
//���������� 0, ���� ���1 = ����2
//���������� -1, ���� ����1 < ����2
function CompareByWeight(Item1 : Pointer; Item2 : Pointer) : integer;
var
  client1, client2 : TClient;
begin
  Result := 0;
  client1 := TClient(Item1);
  client2 := TClient(Item2);
  if client1.weight > client2.weight then inc(Result)
  else if client1.weight < client1.weight then dec(Result);
end;

//������� ��������� �� �����
//���������� 1, ���� ����1 > �����2
//���������� 0, ���� ����1 = �����2
//���������� -1, ���� ����1 < �����2
function CompareByHeight(Item1 : Pointer; Item2 : Pointer) : integer;
var
  client1, client2 : TClient;
begin
  Result := 0;
  client1 := TClient(Item1);
  client2 := TClient(Item2);
  if client1.height > client2.height then inc(Result)
  else if client1.height < client1.height then dec(Result);
end;

//������� ���������, ������ �� ������������ �������� � ��������
//���������� TRUE, ���� ������, FALSE, ���� ���
function ParameterInDiapason(param : TMyCountType; var diapason : TDiapason) : boolean;
begin
  Result := (param >= diapason[MIN]) and (param <= diapason[MAX]);
end;

procedure CreateManList;
begin
  Form1.manList := TList.Create;
  CreateList(Form1.manList);
end;

procedure CreateWomanList;
begin
  Form1.womanList := TList.Create;
  CreateList(Form1.womanList);
end;

procedure CreateList(var list : TList; flag : boolean);
begin

end;

end.
