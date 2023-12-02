unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FlexiSwitch;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    FlexiSwitch1: TFlexiSwitch;
    RadioButton1: TRadioButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
 FlexiSwitch1.LoadImagesfromFile('ok_1.png','ok.png');
end;

end.

