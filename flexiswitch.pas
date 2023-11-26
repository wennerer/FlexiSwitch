unit FlexiSwitch;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  IntfGraphics, LCLIntf, GraphType, outsourced;

type

  { TFlexiSwitch }

  TFlexiSwitch = class(TCustomControl)
  private
    FButtonColor: TColor;
   FFinalBgrdColor     : TColor;
   FInitialBgrdColor   : TColor;
   FOldWidth           : integer;
   FOldHeight          : integer;
   FPortion            : Double;
   FMargin             : Integer;
   FRollPos            : Integer;
   FButtonSize         : Integer;
   FBackgroundImage    : TCustomBitmap;
   FButtonImage        : TCustomBitmap;
   procedure SetButtonColor(AValue: TColor);
   procedure SetFinalBgrdColor(AValue: TColor);
   procedure SetInitialBgrdColor(AValue: TColor);
  protected
   procedure CalculateBounds;
   procedure CalculateButton;
  public
   constructor Create(AOwner: TComponent); override;
   destructor  Destroy; override;
   //procedure LoadImagesfromFile(InitialFilename,FinalFilename: string);
   procedure Paint; override;
  published
   //The initial background colour
   //Die anfängliche Hintergrundfarbe
   property InitialBgrdColor : TColor read FInitialBgrdColor write SetInitialBgrdColor default $000000C8;
   //The final background colour
   //Die finale Hintergrundfarbe
   property FinalBgrdColor : TColor read FFinalBgrdColor write SetFinalBgrdColor default $0000C800;
   //
   //
   property ButtonColor : TColor read FButtonColor write SetButtonColor default clWhite;
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I flexiswitch_icon.lrs}
  RegisterComponents('Misc',[TFlexiSwitch]);
  {$R images.res}
end;

{ TFlexiSwitch }

constructor TFlexiSwitch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width      := 60;
  FOldWidth  := 60;
  Height     := 26;
  FOldHeight := 26;
  FPortion   :=  0;
  FMargin    :=  3;
  FRollPos   :=  0;
  FInitialBgrdColor := rgb(200,0,0);
  FFinalBgrdColor   := rgb(0,200,0);
  FButtonColor      := clWhite;

  FBackgroundImage := TPortableNetworkGraphic.Create;
  FBackgroundImage.LoadFromResourceName(HInstance,'backbround_180_78');
  FButtonImage := TPortableNetworkGraphic.Create;
  FButtonImage.LoadFromResourceName(HInstance,'button_72_72');
end;

destructor TFlexiSwitch.Destroy;
begin
 FBackgroundImage.Free;
 FButtonImage.Free;
 inherited Destroy;
end;

procedure TFlexiSwitch.CalculateBounds;
var Factor : double;
begin
 if Width < 20  then
  begin
   Width  :=  10;
   Height :=   9;
  end;
 if width > 180 then
  begin
   Width  := 180;
   Height :=  78;
  end;

 if width <> FOldWidth then
   begin
    Factor := Width / 60;
    Height := round(Factor * 26);
    FOldWidth := Width;
   end;
  if Height <> FOldHeight then
   begin
    Factor := Height / 26;
    Width := round(Factor * 60);
    FOldHeight := Height;
   end;
end;

procedure TFlexiSwitch.CalculateButton;
var Factor : double;
begin
 Factor       := (2 * 100) / 26;
 FMargin      := round((Height / 100) * Factor);

 FButtonSize := Height - (2 * FMargin);
end;


procedure TFlexiSwitch.Paint;
var BackgroundBmp, ButtonBmp, RollBmp : TBitmap;
    TempImg1,TempImg2,TempImg3        : TLazIntfImage;
    //TeRec      : TRect;
begin
 CalculateBounds;

 //Draw the background
 if (FInitialBgrdColor <> clNone) and (FFinalBgrdColor <> clNone) then
  begin
   TempImg1 := FBackgroundImage.CreateIntfImage;
   TempImg2 := FBackgroundImage.CreateIntfImage;
   TempImg3 := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   BackgroundBmp  := TBitmap.Create;
   try
    ChangeColor(TempImg1,FInitialBgrdColor);
    ChangeColor(TempImg2,FFinalBgrdColor);
    BlendImages(TempImg1,TempImg2,FPortion);
    TempImg3.SetSize(Width,Height);
    StretchDrawImgToImg(TempImg1,TempImg3,width,height);
    BackgroundBmp.PixelFormat:= pf32Bit;
    BackgroundBmp.Assign(TempImg3);
    Canvas.Draw(0,0,BackgroundBmp);
   finally
    TempImg1.Free;
    TempImg2.Free;
    TempImg3.Free;
    BackgroundBmp.Free;
   end;
  end;
 CalculateButton;

 //Draw the button
 if FButtonColor <> clNone then
  begin
   TempImg1       := FButtonImage.CreateIntfImage;
   TempImg2       := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   ButtonBmp      := TBitmap.Create;
   try
    ChangeColor(TempImg1,FButtonColor);
    TempImg2.SetSize(FButtonSize,FButtonSize);
    StretchDrawImgToImg(TempImg1,TempImg2,FButtonSize,FButtonSize);
    ButtonBmp.PixelFormat:= pf32Bit;
    ButtonBmp.Assign(TempImg2);
    Canvas.Draw(FMargin+FRollPos,FMargin,ButtonBmp);
   finally
    TempImg1.Free;
    TempImg2.Free;
    ButtonBmp.Free;
   end;
  end;













end;

{$Include flexiswitch_setter.inc}
end.
