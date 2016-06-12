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
  //тип массив, хранящий данные о желаемых минимальных и максимальных параметрах партнёра
  TDiapason = array [MIN..MAX] of TMyCountType;
  TName = string[50];

  TClientItem = record
    name : TName;                                 //имя
    age : TMyCountType;                           //возраст
    weight : TMyCountType;                        //вес
    height : TMyCountType;                        //рост
    partnerAge : TDiapason;                       //диапазон возраста партнёра
    partnerWeight : TDiapason;                    //диапазон веса партнёра
    partnerHeight : TDiapason;                    //диапазон ромта парнёра
  end;
  //класс клиент, хранит персональные данные о клиенте
  //является элементом структуры TList
  TClient = class(TObject)
  private
    name : TName;                                 //имя
    age : TMyCountType;                           //возраст
    weight : TMyCountType;                        //вес
    height : TMyCountType;                        //рост
    partnerAge : TDiapason;                       //диапазон возраста партнёра
    partnerWeight : TDiapason;                    //диапазон веса партнёра
    partnerHeight : TDiapason;                    //диапазон роcта парнёра
  public
    //свойство изменения имени клиента
    property clientName : TName
      read name write name;
    //свойство изменения возраста клиента
    property clientAge : TMyCountType
      read age write age;
    //свойство изменения веса клиента
    property clientWeight : TMyCountType
      read weight write weight;
    //свойство изменения роста клиента
    property clientHeight : TMyCountType
      read height write height;
    //свойство изменения минимального возраста партнёра
    property partnerAgeMin : TMyCountType
      read partnerAge[MIN] write partnerAge[MIN];
    //свойство изменения максимального возраста партнёра
    property partnerAgeMax : TMyCountType
      read partnerAge[MAX] write partnerAge[MAX];
    //свойство изменения минмимального веса партнёра
    property partnerWeightMin : TMyCountType
      read partnerWeight[MIN] write partnerWeight[MAX];
    //свойство изменения максимального веса партнёра
    property partnerWeightMax : TMyCountType
      read partnerWeight[MAX] write partnerWeight[MAX];
    //свойство изменения минимального роста партнёра
    property partnerHeightMin : TMyCountType
      read partnerHeight[MIN] write partnerHeight[MIN];
    //свойство изменения максимального роста партнёра
    property partnerHeightMax : TMyCountType
      read partnerHeight[MAX] write partnerHeight[MAX];
    //конструктор создания учётной записи
    constructor Create(const clientItem : TClientItem);
  end;

  TClientRecord = record
    name : TName;
    age : TMyCountType;
    weight : TMyCountType;                        //вес
    height : TMyCountType;                        //рост
    partnerAge : TDiapason;                       //диапазон возраста партнёра
    partnerWeight : TDiapason;                    //диапазон веса партнёра
    partnerHeight : TDiapason;
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
    procedure CloseImageClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CreateManList;
    procedure CreateWomanList;
  private
    manList : TList;
    womanList : TList;
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

procedure CreateList(var list : TList; const fileName : string);

implementation

{$R *.dfm}

//создане новой учётной записи клиента
constructor TClient.Create(const clientItem : TClientItem);
begin
  //сохранение переданных результатов
  self.name := ClientItem.name;
  self.age := ClientItem.age;
  self.weight := ClientItem.weight;
  self.height := ClientItem.height;
  self.partnerAge := ClientItem.partnerAge;
  self.partnerWeight := ClientItem.partnerWeight;
  self.partnerHeight := ClientItem.partnerHeight;
end;

//функция сравнения по имени
//возвращает 1, если имя1 > имени2
//возвращает 0, если имя1 = имени2
//возвращает -1, если имя1 < имени2
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

//функция сравнения по возрасту
//возвращает 1, если возраст1 > возраста2
//возвращает 0, если возраст1 = возрасту2
//возвращает -1, если возраст1 < возраста2
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

//функция сравнения по весу
//возвращает 1, если вес1 > веса2
//возвращает 0, если вес1 = весу2
//возвращает -1, если веса1 < веса2
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

//функция сравнения по росту
//возвращает 1, если рост1 > роста2
//возвращает 0, если рост1 = росту2
//возвращает -1, если рост1 < роста2
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

//функция проверяет, входит ли передаваемое значение в диапазон
//возвращает TRUE, если входит, FALSE, если нет
function ParameterInDiapason(param : TMyCountType; var diapason : TDiapason) : boolean;
begin
  Result := (param >= diapason[MIN]) and (param <= diapason[MAX]);
end;

procedure TForm1.CreateManList;
begin
  Form1.manList := TList.Create;
  CreateList(Form1.manList, MAN_FILE);
end;

procedure TForm1.CreateWomanList;
begin
  Form1.womanList := TList.Create;
  CreateList(Form1.womanList, WOMAN_FILE);
end;

procedure CreateList(var list : TList; const fileName : string);
var
  F : file of TClientItem;
  clientItem : TClientItem;
  client : TClient;
begin
  AssignFile(F, fileName);
  if FileExists(fileName) then
  try
    Reset(F);
    while not EOF(F) do
    begin
      Read(F, clientItem);
      client := TClient.Create(clientItem);
    end;
  finally
    CloseFile(F);
  end;

end;

procedure TForm1.CloseImageClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Form1.CreateManList;
  Form1.CreateWomanList;
end;

end.
