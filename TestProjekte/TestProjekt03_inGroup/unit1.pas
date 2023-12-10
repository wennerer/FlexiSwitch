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
    FlexiSwitch10: TFlexiSwitch;
    FlexiSwitch11: TFlexiSwitch;
    FlexiSwitch12: TFlexiSwitch;
    FlexiSwitch13: TFlexiSwitch;
    FlexiSwitch14: TFlexiSwitch;
    FlexiSwitch15: TFlexiSwitch;
    FlexiSwitch16: TFlexiSwitch;
    FlexiSwitch17: TFlexiSwitch;
    FlexiSwitch18: TFlexiSwitch;
    FlexiSwitch19: TFlexiSwitch;
    FlexiSwitch2: TFlexiSwitch;
    FlexiSwitch20: TFlexiSwitch;
    FlexiSwitch3: TFlexiSwitch;
    FlexiSwitch4: TFlexiSwitch;
    FlexiSwitch5: TFlexiSwitch;
    FlexiSwitch6: TFlexiSwitch;
    FlexiSwitch7: TFlexiSwitch;
    FlexiSwitch8: TFlexiSwitch;
    FlexiSwitch9: TFlexiSwitch;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
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
var lv : integer;
    s  : string;
begin
 for lv:=0 to pred(ComponentCount) do
  if Components[lv] is TFlexiSwitch then
   TFlexiSwitch(Components[lv]).SwitchMode := TSwitchMode((ord(TFlexiSwitch(Components[lv]).SwitchMode) + 1) mod 2);

 writestr(s,FlexiSwitch1.SwitchMode);
 Button1.Caption:= 'fsClick or fsSlide ['+ s+' is activ]' ;
end;

end.

