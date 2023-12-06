unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Spin, ColorBox, ExtCtrls, FlexiSwitch;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    ColorBox5: TColorBox;
    ColorBox6: TColorBox;
    ColorBox7: TColorBox;
    SwitchMode: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    FlexiSwitch1: TFlexiSwitch;
    aFlexiSwitch: TFlexiSwitch;
    FloatSpinEdit1: TFloatSpinEdit;
    FloatSpinEdit2: TFloatSpinEdit;
    FloatSpinEdit3: TFloatSpinEdit;
    FloatSpinEdit4: TFloatSpinEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    StaticText1: TStaticText;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    StaticText16: TStaticText;
    StaticText17: TStaticText;
    StaticText18: TStaticText;
    StaticText19: TStaticText;
    StaticText2: TStaticText;
    StaticText20: TStaticText;
    StaticText21: TStaticText;
    StaticText22: TStaticText;
    StaticText23: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    TrackBar1: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure ColorBox3Change(Sender: TObject);
    procedure ColorBox4Change(Sender: TObject);
    procedure ColorBox5Change(Sender: TObject);
    procedure ColorBox6Change(Sender: TObject);
    procedure ColorBox7Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FloatSpinEdit1Change(Sender: TObject);
    procedure FloatSpinEdit2Change(Sender: TObject);
    procedure FloatSpinEdit3Change(Sender: TObject);
    procedure FloatSpinEdit4Change(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure SwitchModeChange(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
 aFlexiSwitch.Width:= TrackBar1.Position;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked then aFlexiSwitch.Roll:= true else aFlexiSwitch.Roll:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 aFlexiSwitch.LoadImagesfromFile('Lock_01_64.png','Lock_03_64.png');
 aFlexiSwitch.ImgSizeFactor:=0.7;
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
begin
 if aFlexiSwitch.BestTextHeight then
 begin
  aFlexiSwitch.BestTextHeight := false;
  aFlexiSwitch.Font.Height:= 12;
 end
 else aFlexiSwitch.BestTextHeight := true;
end;

procedure TForm1.CheckBox3Change(Sender: TObject);
begin
  if CheckBox3.Checked then aFlexiSwitch.Enabled:=true
  else aFlexiSwitch.Enabled:=false;
end;

procedure TForm1.ColorBox1Change(Sender: TObject);
begin
 aFlexiSwitch.FocusColor:=ColorBox1.Selected;
end;

procedure TForm1.ColorBox2Change(Sender: TObject);
begin
 aFlexiSwitch.HoverColor:=ColorBox2.Selected;
end;

procedure TForm1.ColorBox3Change(Sender: TObject);
begin
 aFlexiSwitch.ButtonColor:=ColorBox3.Selected;
end;

procedure TForm1.ColorBox4Change(Sender: TObject);
begin
 aFlexiSwitch.LeftBgrdColor:= ColorBox4.Selected ;
end;

procedure TForm1.ColorBox5Change(Sender: TObject);
begin
 aFlexiSwitch.RightBgrdColor:=ColorBox5.Selected;
end;

procedure TForm1.ColorBox6Change(Sender: TObject);
begin
 aFlexiSwitch.BorderColor:=ColorBox6.Selected;
end;

procedure TForm1.ColorBox7Change(Sender: TObject);
begin
 aFlexiSwitch.Font.Color:=ColorBox7.Selected;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
 aFlexiSwitch.LeftCaption:=Edit1.Text;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
 aFlexiSwitch.RightCaption:=Edit2.Text;
end;

procedure TForm1.FloatSpinEdit1Change(Sender: TObject);
begin
 aFlexiSwitch.FocusedBlendFaktor:=FloatSpinEdit1.Value;
end;

procedure TForm1.FloatSpinEdit2Change(Sender: TObject);
begin
 aFlexiSwitch.HoverBlendFaktor:=FloatSpinEdit2.Value;
end;

procedure TForm1.FloatSpinEdit3Change(Sender: TObject);
begin
 aFlexiSwitch.EnabledBlendFaktor:=FloatSpinEdit3.Value;
end;

procedure TForm1.FloatSpinEdit4Change(Sender: TObject);
begin
 aFlexiSwitch.ImgSizeFactor:=FloatSpinEdit4.Value;
end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  if RadioButton1.Checked then aFlexiSwitch.Direction:=fsLeft
  else aFlexiSwitch.Direction:=fsRight;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
 aFlexiSwitch.Speed:=SpinEdit1.Value ;
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
 aFlexiSwitch.LeftImageIndex:=SpinEdit2.Value;
end;

procedure TForm1.SpinEdit3Change(Sender: TObject);
begin
 aFlexiSwitch.RightImageIndex:=SpinEdit3.Value;
end;

procedure TForm1.SpinEdit4Change(Sender: TObject);
begin
 aFlexiSwitch.Font.Height:=SpinEdit4.Value;
end;

procedure TForm1.SwitchModeChange(Sender: TObject);
begin
 case SwitchMode.ItemIndex of
  0: aFlexiSwitch.SwitchMode:= fsClick;
  1: aFlexiSwitch.SwitchMode:= fsSlide;
 end;
end;

end.

