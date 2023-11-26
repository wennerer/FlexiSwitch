unit FlexiSwitch;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  IntfGraphics, LCLIntf, LCLProc, GraphType, outsourced;

type

  { TFlexiSwitch }

  TFlexiSwitch = class(TCustomControl)
  private
   FBorderColor        : TColor;
   FButtonColor        : TColor;
   FFinalBgrdColor     : TColor;
   FHoverColor         : TColor;
   FHover              : boolean;
   FHoverBlendFaktor   : Double;
   FInitialBgrdColor   : TColor;
   FOldWidth           : integer;
   FOldHeight          : integer;
   FPortion            : Double;
   FMargin             : Integer;
   FRollPos            : Integer;
   FButtonSize         : Integer;
   FBackgroundImage    : TCustomBitmap;
   FButtonImage        : TCustomBitmap;
   FBorderImage        : TCustomBitmap;
   procedure SetBorderColor(AValue: TColor);
   procedure SetButtonColor(AValue: TColor);
   procedure SetFinalBgrdColor(AValue: TColor);
   procedure SetHoverColor(AValue: TColor);
   procedure SetInitialBgrdColor(AValue: TColor);
  protected
   procedure CalculateBounds;
   procedure CalculateButton;
  public
   constructor Create(AOwner: TComponent); override;
   destructor  Destroy; override;
   procedure MouseEnter; override;
   procedure MouseLeave; override;
   procedure MouseMove({%H-}Shift: TShiftState; X, Y: Integer);override;
   procedure MouseDown({%H-}Button: TMouseButton;{%H-}Shift: TShiftState; X, Y: Integer);override;
   procedure MouseUp({%H-}Button: TMouseButton; {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Integer);override;
   //procedure LoadImagesfromFile(InitialFilename,FinalFilename: string);
   procedure Paint; override;

   property HoverBlendFaktor : Double read FHoverBlendFaktor write FHoverBlendFaktor;
  published
   //The initial background colour
   //Die anfängliche Hintergrundfarbe
   property InitialBgrdColor : TColor read FInitialBgrdColor write SetInitialBgrdColor default $000000C8;
   //The final background colour
   //Die finale Hintergrundfarbe
   property FinalBgrdColor : TColor read FFinalBgrdColor write SetFinalBgrdColor default $0000C800;
   //The color of the button
   //Die Farbe des Buttons
   property ButtonColor : TColor read FButtonColor write SetButtonColor default clWhite;
   //The color of the border (clNone = no Border)
   //Farbe des Randes (clNone = keinRand)
   property BorderColor : TColor read FBorderColor write SetBorderColor default clRed;
   //The color of a hoverevent (clNone = no hover)
   //Die Farbe eines Hoverereignisses (clNone = kein Hover)
   property HoverColor : TColor read FHoverColor write SetHoverColor default clNone;
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
  FBorderColor      := clRed;
  FHoverColor       := clNone;
  FHover            := false;
  FHoverBlendFaktor := 0.9;

  FBackgroundImage := TPortableNetworkGraphic.Create;
  FBackgroundImage.LoadFromResourceName(HInstance,'backbround_180_78');
  FButtonImage := TPortableNetworkGraphic.Create;
  FButtonImage.LoadFromResourceName(HInstance,'button_72_72');
  FBorderImage := TPortableNetworkGraphic.Create;
  FBorderImage.LoadFromResourceName(HInstance,'border');
end;

destructor TFlexiSwitch.Destroy;
begin
 FBackgroundImage.Free;
 FButtonImage.Free;
 inherited Destroy;
end;

procedure TFlexiSwitch.MouseEnter;
begin
 inherited MouseEnter;
 FHover := true;
 Invalidate;
end;

procedure TFlexiSwitch.MouseLeave;
begin
 inherited MouseLeave;
 FHover := false;
 Invalidate;
end;

procedure TFlexiSwitch.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
end;

procedure TFlexiSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 inherited MouseDown(Button, Shift, X, Y);
 FHover := false;
 Invalidate;
end;

procedure TFlexiSwitch.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
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
    i      : integer;
begin
 if FBorderColor = clNone then i:=2 else i:=3;
 Factor       := (i * 100) / 26;
 FMargin      := round((Height / 100) * Factor);

 FButtonSize := Height - (2 * FMargin);
end;


procedure TFlexiSwitch.Paint;
var BackgroundBmp,ButtonBmp,BorderBmp,HoverBmp,RollBmp : TBitmap;
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

 //Draw the border
 if FBorderColor <> clNone then
  begin
   TempImg1       := FBorderImage.CreateIntfImage;
   TempImg2       := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   BorderBmp      := TBitmap.Create;
   try
    ChangeBorderColor(TempImg1,FBorderColor);
    TempImg2.SetSize(Width,Height);
    StretchDrawImgToImg(TempImg1,TempImg2,Width,Height);
    BorderBmp.PixelFormat:= pf32Bit;
    BorderBmp.Assign(TempImg2);
    Canvas.Draw(0,0,BorderBmp);
   finally
    TempImg1.Free;
    TempImg2.Free;
    BorderBmp.Free;
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

 //Draw a hover event
 if FHoverColor <> clNone then
  if FHover then
  begin
   TempImg1       := FBackgroundImage.CreateIntfImage;
   TempImg2       := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   TempImg3       := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   HoverBmp      := TBitmap.Create;
   try
    ChangeColor(TempImg1,FHoverColor);
    TempImg2.SetSize(TempImg1.Width,TempImg1.Height);
    BlendImages(TempImg1,TempImg2,FHoverBlendFaktor);
    TempImg3.SetSize(Width,Height);
    StretchDrawImgToImg(TempImg1,TempImg3,Width,Height);
    BorderBmp.PixelFormat:= pf32Bit;
    BorderBmp.Assign(TempImg3);
    Canvas.Draw(0,0,BorderBmp);
   finally
    TempImg1.Free;
    TempImg2.Free;
    TempImg3.Free;
    HoverBmp.Free;
   end;
  end;











end;

{$Include flexiswitch_setter.inc}
end.
