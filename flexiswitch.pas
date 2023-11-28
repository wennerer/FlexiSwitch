unit FlexiSwitch;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, LResources, Forms, Controls, Graphics, Dialogs,
  IntfGraphics, LCLIntf, LCLProc, GraphType, outsourced, ExtCtrls;

type
  TDirection = (fsRight,fsLeft);

type

  { TFlexiSwitch }

  TFlexiSwitch = class(TCustomControl)
  private
    FBestTextHeight: boolean;
   FImages             : Array[0..1] of TCustomBitmap;
   FFinalImage         : TCustomBitmap;
   FInitialImage       : TCustomBitmap;
   FDisabledColor      : TColor;
   FEnabledBlendFaktor : Double;
   FCapLeft            : integer;
   FCapTop             : integer;
   FEnabled            : boolean;
   FFont               : TFont;
   FCaption            : TCaption;
   FDirection          : TDirection;
   FAngel              : Double;
   FInitialCaption     : TCaption;
   FFinalCaption       : TCaption;
   FRotation           : Double;
   FSpeed              : integer;
   FTextStyle          : TTextStyle;
   FTimer              : TTimer;
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
   FRoll               : boolean;
   FRollPos            : Integer;
   FButtonSize         : Integer;
   FBackgroundImage    : TCustomBitmap;
   FButtonImage        : TCustomBitmap;
   FBorderImage        : TCustomBitmap;
   procedure FTimerTimer(Sender: TObject);
   function CalculateTextRect:TRect;
   procedure SetAlignment(AValue: TAlignment);
   procedure SetBestTextHeight(AValue: boolean);
   procedure SetBorderColor(AValue: TColor);
   procedure SetButtonColor(AValue: TColor);
   procedure SetCapLeft(AValue: integer);
   procedure SetCapTop(AValue: integer);
   procedure SetDirection(AValue: TDirection);
   procedure SetDisabledColor(AValue: TColor);
   procedure SetFinalBgrdColor(AValue: TColor);
   procedure SetFinalCaption(AValue: TCaption);
   procedure SetFont(AValue: TFont);
   procedure SetHoverColor(AValue: TColor);
   procedure SetInitialBgrdColor(AValue: TColor);
   procedure SetInitialCaption(AValue: TCaption);
   procedure SetLayout(AValue: TTextLayout);
   procedure SetSpeed(AValue: integer);
   procedure SetTextStyle(AValue: TTextStyle);
   procedure SetEnabled(aValue: boolean);reintroduce;

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
   procedure LoadImagesfromFile(InitialFilename,FinalFilename: string);
   procedure Paint; override;

   property HoverBlendFaktor : Double read FHoverBlendFaktor write FHoverBlendFaktor;
   property Angel : Double read FAngel write FAngel;
   property Rotation : Double read FRotation write FRotation;
   property TextStyle: TTextStyle read FTextStyle write SetTextStyle;
   //The colour of the control when enable := false
   //Die Farbe des Controlls wenn enable := false
   property DisabledColor : TColor read FDisabledColor write SetDisabledColor;
   //How translucent is the DisabledColor (1=opaque,0=transparent)
   //Wie transparent die DisabledColor ist (1=undurchsichtig,0=durchsichtig)
   property EnabledBlendFaktor : Double read FEnabledBlendFaktor write FEnabledBlendFaktor;
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
   property BorderColor : TColor read FBorderColor write SetBorderColor default clNone;
   //The color of a hoverevent (clNone = no hover)
   //Die Farbe eines Hoverereignisses (clNone = kein Hover)
   property HoverColor : TColor read FHoverColor write SetHoverColor default clNone;
   //
   //
   property Roll : boolean read FRoll write FRoll default true;
   //
   //
   property Direction        : TDirection read FDirection write SetDirection default fsLeft;
   //
   //
   property Speed            : integer read FSpeed write SetSpeed default 10;
   //
   //
   property InitialCaption   : TCaption read FInitialCaption write SetInitialCaption;
   //
   //
   property FinalCaption     : TCaption read FFinalCaption  write SetFinalCaption;
   //The font to be used for text display in this switch.
   //Die Schrift die für die Textanzeige in diesem Schalter verwendet werden soll.
   property Font: TFont read fFont write SetFont;
   //Alignment of the text in the caption (left, center, right)
   //Ausrichtung des Textes in der Caption (Links,Mitte,Rechts)
   property CaptionAlignment:TAlignment read FTextStyle.Alignment write SetAlignment default taCenter;
   //Alignment of the text in the caption (top, center, bottom)
   //Ausrichtung des Textes in der Caption (Oben,Mitte,Unten)
   property CaptionLayout:TTextLayout read FTextStyle.Layout write SetLayout default tlCenter;
   //The horizontal distance of the text in the text rectangle (only effective with taLeftJustify)
   //Der horizontale Abstand des Textes im Textrechteck (nur wirksam mit taLeftJustify)
   property CaptionHorMargin : integer read FCapLeft write SetCapLeft default 0;
   //The vertical distance of the text in the text rectangle (only effective with tlTop)
   //Der vertikale Abstand des Textes im Textrechteck (nur wirksam mit tlTop)
   property CaptionVerMargin : integer read FCapTop write SetCapTop default 0;
   //Determines whether the control reacts on mouse or keyboard input.
   //Legt fest, ob das Steuerelement auf Maus- oder Tastatureingaben reagiert.
   property Enabled : boolean read FEnabled write SetEnabled default true;
   //
   //
   property BestTextHeight : boolean read FBestTextHeight write SetBestTextHeight default true;
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
var lv : integer;
begin
  inherited Create(AOwner);
  Width                := 60;
  FOldWidth            := 60;
  Height               := 26;
  FOldHeight           := 26;
  FPortion             :=  0;
  FMargin              :=  3;
  FRollPos             :=  0;
  FHover               := false;
  FHoverBlendFaktor    := 0.3;
  FRoll                := true;
  FAngel               :=  0;
  FRotation            := 30;
  FDirection           := fsLeft;
  FEnabled             := true;
  FInitialBgrdColor    := rgb(200,0,0);
  FFinalBgrdColor      := rgb(0,200,0);
  FButtonColor         := clWhite;
  FBorderColor         := clNone;
  FHoverColor          := clNone;
  FEnabledBlendFaktor  := 0.7;
  FDisabledColor       := clWhite;
  FBestTextHeight      := true;

  FTimer            := TTimer.Create(nil);
  FSpeed            := 10;
  FTimer.Interval   := FSpeed;
  FTimer.Enabled    := false;
  FTimer.OnTimer    :=@FTimerTimer;

  FInitialCaption   := 'OFF';
  FFinalCaption     := 'ON';
  FCaption          := FInitialCaption;
  FFont             := TFont.Create;
  FFont.Color       := clWhite;
  FFont.Style       := [fsbold];

  FTextStyle.Alignment := taCenter;
  FTextStyle.Layout    := tlCenter;
  FTextStyle.SingleLine:= true;
  FTextStyle.Wordbreak := false;
  FTextStyle.Clipping  := true;

  FBackgroundImage := TPortableNetworkGraphic.Create;
  FBackgroundImage.LoadFromResourceName(HInstance,'backbround_180_78');
  FButtonImage := TPortableNetworkGraphic.Create;
  FButtonImage.LoadFromResourceName(HInstance,'button_72_72');
  FBorderImage := TPortableNetworkGraphic.Create;
  FBorderImage.LoadFromResourceName(HInstance,'border');
  for lv := 0 to High(FImages) do
    FImages[lv] := TPortableNetworkGraphic.Create;
  FImages[0].LoadFromResourceName(HInstance,'off');
  FImages[1].LoadFromResourceName(HInstance,'ok');
  FInitialImage := TPortableNetworkGraphic.Create;
  FInitialImage.Assign(FImages[0]);
  FFinalImage := TPortableNetworkGraphic.Create;
  FFinalImage.Assign(FImages[1]);
end;

destructor TFlexiSwitch.Destroy;
var lv : integer;
begin
 FBackgroundImage.Free;
 FButtonImage.Free;
 FBorderImage.Free;
 FInitialImage.Free;
 FFinalImage.Free;
 for lv := 0 to High(FImages) do FImages[lv].Free;
 FTimer.Free;
 FFont.Free;
 inherited Destroy;
end;

procedure TFlexiSwitch.MouseEnter;
begin
 if not Enabled then exit;
 inherited MouseEnter;
 FHover := true;
 Invalidate;
end;

procedure TFlexiSwitch.MouseLeave;
begin
 if not Enabled then exit;
 inherited MouseLeave;
 FHover := false;
 Invalidate;
end;

procedure TFlexiSwitch.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
 if not Enabled then exit;
 inherited MouseMove(Shift, X, Y);
 //FHover := true;
 Invalidate;
end;

procedure TFlexiSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 if not Enabled then exit;
 inherited MouseDown(Button, Shift, X, Y);
 FHover := false;
 Invalidate;
end;

procedure TFlexiSwitch.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 if not Enabled then exit;
 inherited MouseUp(Button, Shift, X, Y);
  if not FTimer.Enabled then
   begin
    //if FDirection = fsRight then FDirection := fsLeft else FDirection := fsRight;
    FDirection := TDirection((ord(FDirection) + 1) mod 2);
    FTimer.Enabled:= true;
    //if Assigned(OnClick) then OnClick(self);
   end;
end;

procedure TFlexiSwitch.LoadImagesfromFile(InitialFilename, FinalFilename: string);
var oldiniimg, oldfinalimg : TCustomBitmap;
begin
 oldiniimg   :=TPortableNetworkGraphic.Create;
 oldfinalimg :=TPortableNetworkGraphic.Create;
 try
  if assigned(FInitialImage) then
   begin
    oldiniimg.Assign(FInitialImage);
    FreeAndNil(FInitialImage);
   end;
  if assigned(FFinalImage)   then
   begin
    oldfinalimg.Assign(FFinalImage);
    FreeAndNil(FFinalImage);
   end;
 FInitialImage := TPortableNetworkGraphic.Create;
 FFinalImage   := TPortableNetworkGraphic.Create;
  try
   if fileexists(InitialFilename) and fileexists(FinalFilename) then
    begin
     FInitialImage.LoadFromFile(InitialFilename);
     FFinalImage.LoadFromFile(FinalFilename);
     if (FInitialImage.Width <> FFinalImage.Width) or (FInitialImage.Height <> FFinalImage.Height) then
      begin
       FInitialImage.Assign(oldiniimg);
       FFinalImage.Assign(oldfinalimg);
       showmessage('The size of the images must be the same!');
      end;
    end
   else
    begin
     FInitialImage.Assign(oldiniimg);
     FFinalImage.Assign(oldfinalimg);
     showmessage('Incorrect path');
    end;
  except
   showmessage('Wrong Graphicformat, only PNG!');
  end;

 finally
  oldiniimg.Free;
  oldfinalimg.Free;
 end;
 Invalidate;
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


procedure TFlexiSwitch.FTimerTimer(Sender: TObject);
var l,l1 : integer;
    f    : double;
begin
  FCaption := '';
  l  := width - Height;
  l1 := round(l / (360/FRotation));
  f  := 1 / (360/FRotation);
  if FDirection = fsRight then
   begin
    FPortion := FPortion + f;
    FRollPos := FRollPos + l1;
    FAngel :=FAngel+FRotation;
    if FAngel >= 360 then
     begin
      FPortion := 1;
      FTimer.Enabled:= false;
      FRollPos := width - (FButtonSize + (2*FMargin));
      FCaption := FFinalCaption;
     end;
   end;
   if FDirection = fsLeft then
   begin
    FPortion := FPortion - f;
    FRollPos := FRollPos - l1;
    FAngel := FAngel - FRotation;
    f  := 1 / (360/FRotation);
    if FAngel <= 0 then
     begin
      FPortion := 0;
      FTimer.Enabled:= false;
      FRollPos := 0 ;
      FCaption := FInitialCaption;
     end;
   end;
   Invalidate;
 end;

function TFlexiSwitch.CalculateTextRect: TRect;
begin
  if FDirection = fsLeft then
  begin
   Result.Left   := FMargin + FButtonSize;
   Result.Top    := FMargin;
   Result.Right  := Width - FMargin;
   Result.Bottom := Height - FMargin;
  end else
  begin
   Result.Left   := FMargin;
   Result.Top    := FMargin;
   Result.Right  := Width - (FMargin+ FButtonSize);
   Result.Bottom := Height - FMargin;
  end;
end;

procedure TFlexiSwitch.Paint;
var TmpBmp     : TBitmap;
    TempImg1,TempImg2,TempImg3 : TLazIntfImage;
    TeRect     : TRect;
begin
 CalculateBounds;

 //Draw the background
 if (FInitialBgrdColor <> clNone) and (FFinalBgrdColor <> clNone) then
  begin
   TempImg1 := FBackgroundImage.CreateIntfImage;
   TempImg2 := FBackgroundImage.CreateIntfImage;
   TempImg3 := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   TmpBmp  := TBitmap.Create;
   try
    ChangeColor(TempImg1,FInitialBgrdColor);
    ChangeColor(TempImg2,FFinalBgrdColor);
    BlendImages(TempImg1,TempImg2,FPortion);
    TempImg3.SetSize(Width,Height);
    StretchDrawImgToImg(TempImg1,TempImg3,width,height);
    TmpBmp.PixelFormat:= pf32Bit;
    TmpBmp.Assign(TempImg3);
    Canvas.Draw(0,0,TmpBmp);
   finally
    TempImg1.Free;
    TempImg2.Free;
    TempImg3.Free;
    TmpBmp.Free;
   end;
  end;

 //Draw the border
 if FBorderColor <> clNone then
  begin
   TempImg1       := FBorderImage.CreateIntfImage;
   TempImg2       := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   TmpBmp         := TBitmap.Create;
   try
    ChangeBorderColor(TempImg1,FBorderColor);
    TempImg2.SetSize(Width,Height);
    StretchDrawImgToImg(TempImg1,TempImg2,Width,Height);
    TmpBmp.PixelFormat:= pf32Bit;
    TmpBmp.Assign(TempImg2);
    Canvas.Draw(0,0,TmpBmp);
   finally
    TempImg1.Free;
    TempImg2.Free;
    TmpBmp.Free;
   end;
  end;

 CalculateButton;
 //Draw the button
 if FButtonColor <> clNone then
  begin
   TempImg1       := FButtonImage.CreateIntfImage;
   TempImg2       := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   TmpBmp      := TBitmap.Create;
   try
    ChangeColor(TempImg1,FButtonColor);
    TempImg2.SetSize(FButtonSize,FButtonSize);
    StretchDrawImgToImg(TempImg1,TempImg2,FButtonSize,FButtonSize);
    TmpBmp.PixelFormat:= pf32Bit;
    TmpBmp.Assign(TempImg2);
    Canvas.Draw(FMargin+FRollPos,FMargin,TmpBmp);
   finally
    TempImg1.Free;
    TempImg2.Free;
    TmpBmp.Free;
   end;
  end;

 //Draw the rollbutton
 if assigned(FInitialImage) and assigned(FFinalImage) then
  begin
   TempImg1 := FInitialImage.CreateIntfImage;
   TempImg2 := FFinalImage.CreateIntfImage;
   TempImg3 := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   TmpBmp   := TBitmap.Create;
   try
    BlendImages(TempImg1,TempImg2,FPortion);
    if FRoll then
     RotateImage(TempImg1,DegToRad(FAngel));
    TmpBmp.Pixelformat := pf32Bit;
    TempImg3.SetSize(FButtonSize,FButtonSize);
    StretchDrawImgToImg(TempImg1,TempImg3,FButtonSize,FButtonSize);
    TmpBmp.Assign(TempImg3);
    if (FDirection = fsRight) and not FTimer.Enabled then
     FRollPos := width - (FButtonSize + (2*FMargin));
    Canvas.Draw(FMargin+FRollPos,FMargin,TmpBmp);
   finally
    TempImg1.Free;
    TempImg2.Free;
    TempImg3.Free;
    TmpBmp.Free;
   end;
 end;

 //Draw a hover event
 if FHoverColor <> clNone then
  if FHover and FEnabled then
  begin
   TempImg1       := FBackgroundImage.CreateIntfImage;
   TempImg2       := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   TmpBmp         := TBitmap.Create;
   try
    ChangeColor(TempImg1,FHoverColor);
    TempImg2.SetSize(TempImg1.Width,TempImg1.Height);
    AlphaImages(TempImg1,FHoverBlendFaktor);
    TempImg2.SetSize(Width,Height);
    StretchDrawImgToImg(TempImg1,TempImg2,Width,Height);
    TmpBmp.PixelFormat:= pf32Bit;
    TmpBmp.Assign(TempImg2);
    Canvas.Draw(0,0,TmpBmp);
   finally
    TempImg1.Free;
    TempImg2.Free;
    TmpBmp.Free;
   end;
  end;

 //Draw the caption
 TeRect := CalculateTextRect;
 if FBestTextHeight then FFont.Height := TeRect.Height - round(TeRect.Height * 0.35);
 Canvas.Font.Assign(FFont);
 canvas.TextRect(TeRect,TeRect.Left+FCapLeft,TeRect.Top+FCapTop,
                 FCaption,FTextStyle);

 //Draw not enabled
 if not Enabled then
  begin
   TempImg1       := FBackgroundImage.CreateIntfImage;
   TempImg2       := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   TmpBmp         := TBitmap.Create;
   try
    ChangeColor(TempImg1,FDisabledColor);
    TempImg2.SetSize(TempImg1.Width,TempImg1.Height);
    AlphaImages(TempImg1,FEnabledBlendFaktor);
    TempImg2.SetSize(Width,Height);
    StretchDrawImgToImg(TempImg1,TempImg2,Width,Height);
    TmpBmp.PixelFormat:= pf32Bit;
    TmpBmp.Assign(TempImg2);
    Canvas.Draw(0,0,TmpBmp);
   finally
    TempImg1.Free;
    TempImg2.Free;
    TmpBmp.Free;
   end;
  end;



end;

{$Include flexiswitch_setter.inc}
end.
