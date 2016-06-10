unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

const
  MIN = 1;
  MAX = 2;

type
  TMyCountType = byte;
  //тип массив, хранящий данные о желаемых минимальных и максимальных параметрах партнёра
  TDiapason = array [MIN..MAX] of TMyCountType;
  TName = string[50];

  //класс клиент, хранит персональные данные о клиенте
  //является элементом структуры TList
  TClient = class
  private
    name : TName;                                 //имя
    age : TMyCountType;                           //возраст
    weight : TMyCountType;                        //вес
    height : TMyCountType;                        //рост
    partnerAge : TDiapason;                       //диапазон возраста партнёра
    partnerWeight : TDiapason;                    //диапазон веса партнёра
    partnerHeight : TDiapason;                    //диапазон ромта парнёра
  public
    property clientName : TName
      read name write name;

    property clientAge : TMyCountType
      read age write age;

    property clientWeight : TMyCountType
      read weight write weight;

    property clientHeight : TMyCountType
      read height write height;

    property partnerAgeMin : TMyCountType
      read partnerAge[MIN] write partnerAge[MIN];

    property partnerAgeMax : TMyCountType
      read partnerAge[MAX] write partnerAge[MAX];

    property partnerWeightMin : TMyCountType
      read partnerWeight[MIN] write partnerWeight[MAX];

    property partnerWeightMax : TMyCountType
      read partnerWeight[MAX] write partnerWeight[MAX];

    property partnerHeightMin : TMyCountType
      read partnerHeight[MIN] write partnerHeight[MIN];

    property partnerHeightMax : TMyCountType
      read partnerHeight[MAX] write partnerHeight[MAX];
  end;

  TForm1 = class(TForm)
  private

  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}



end.
