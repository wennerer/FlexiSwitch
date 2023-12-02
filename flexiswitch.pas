unit FlexiSwitch;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, LResources, Forms, Controls, Graphics, Dialogs,
  IntfGraphics, LCLIntf, GraphType, PropEdits, outsourced, ExtCtrls, LMessages,
  LCLType, StdCtrls, LCLProc;

type
  TClickEvent      = procedure(Sender: TObject) of object;
type
  TMouseMoveEvent  = procedure(Sender: TObject;Shift: TShiftState;X,Y: Integer) of Object;
type
  TMouseEvent      = procedure(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer) of Object;
type
  TMouseEnterLeave = procedure(Sender: TObject) of object;
type
  TNotifyEvent     = procedure(Sender: TObject) of object;
type
  TKeyEvent        = procedure(Sender: TObject; var Key: Word; Shift: TShiftState) of Object;
type
  TKeyPressEvent   = procedure(Sender: TObject; var Key: char) of Object;
type
  TChangeEvent     = procedure(Sender: TObject) of object;


type
  TDirection = (fsRight,fsLeft);

type
  TRollImage = class (TPersistent)
   private
     aDirection : TDirection;
     ImageIndex : integer;
  end;


type

  { TThumbnail }

  TThumbnail = class(TCustomControl)
  private
    FAColor  : TColor;
    FOnClick : TClickEvent;
    FImage   : TCustomBitmap;
    procedure SetAColor(AValue: TColor);

  protected

  public
   constructor Create(AOwner: TComponent); override;
   destructor  Destroy; override;
   procedure MouseEnter; override;
   procedure MouseLeave; override;
   procedure MouseUp({%H-}Button: TMouseButton; {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Integer);override;
   procedure Paint; override;

   property aColor : TColor read FAColor write SetAColor;
   property OnClick      : TClickEvent read FOnClick     write FOnClick;
  end;

type

    { TPropertyImageSelector }

    TPropertyImageSelector = class (TPropertyEditor)
    private
     PEForm       : TCustomForm;
     FThumbnail   : array [0..39] of TThumbnail;
     FHigh        : integer;
     FRadioButton : array [0..1] of TRadioButton;
     FButton      : array [0..1] of TButton;
     FRollImage   : TRollImage;
     procedure ButtonsClick(Sender: TObject);
     procedure RadioButtons(Sender: TObject);
     procedure SelectedImage(Sender: TObject);
    protected
     procedure DoShowEditor;

    public
     procedure Edit; Override;
     function  GetValue: string;Override;
     function  GetAttributes: TPropertyAttributes; Override;
    end;


type

  { TFlexiSwitch }

  TFlexiSwitch = class(TCustomControl)
  private
   FImages             : Array[0..29] of TCustomBitmap;
   FLeftImageIndex     : integer;
   FRightImage         : TCustomBitmap;
   FLeftImage          : TCustomBitmap;
   FFocusColor         : TColor;
   FBestTextHeight     : boolean;
   FFocusedBlendFaktor : Double;
   FDisabledColor      : TColor;
   FEnabledBlendFaktor : Double;
   FCapLeft            : integer;
   FCapTop             : integer;
   FEnabled            : boolean;
   FFont               : TFont;
   FCaption            : TCaption;
   FDirection          : TDirection;
   FAngel              : Double;
   FLeftCaption        : TCaption;
   FRightCaption       : TCaption;
   FOnChange           : TChangeEvent;
   FOnClick            : TClickEvent;
   FOnEnter            : TNotifyEvent;
   FOnExit             : TNotifyEvent;
   FOnKeyDown          : TKeyEvent;
   FOnKeyPress         : TKeyPressEvent;
   FOnKeyUp            : TKeyEvent;
   FOnMouseDown        : TMouseEvent;
   FOnMouseEnter       : TMouseEnterLeave;
   FOnMouseLeave       : TMouseEnterLeave;
   FOnMouseMove        : TMouseMoveEvent;
   FOnMouseUp          : TMouseEvent;
   FRightImageIndex    : integer;
   FRollImage          : TRollImage;
   FRotation           : Double;
   FSpeed              : integer;
   FTextStyle          : TTextStyle;
   FTimer              : TTimer;
   FBorderColor        : TColor;
   FButtonColor        : TColor;
   FRightBgrdColor     : TColor;
   FHoverColor         : TColor;
   FHover              : boolean;
   FHoverBlendFaktor   : Double;
   FLeftBgrdColor   : TColor;
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
   FImagesCount        : integer;

   procedure DrawAHoverEvent;
   procedure DrawFocused;
   procedure DrawNotEnabled;
   procedure DrawTheBackground;
   procedure DrawTheBorder;
   procedure DrawTheButton;
   procedure DrawTheCaption;
   procedure DrawTheRollbutton;
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
   procedure SetLeftImageIndex(AValue: integer);
   procedure SetRightBgrdColor(AValue: TColor);
   procedure SetRightCaption(AValue: TCaption);
   procedure SetFocusColor(AValue: TColor);
   procedure SetFont(AValue: TFont);
   procedure SetHoverColor(AValue: TColor);
   procedure SetLeftBgrdColor(AValue: TColor);
   procedure SetLeftCaption(AValue: TCaption);
   procedure SetLayout(AValue: TTextLayout);
   procedure SetRightImageIndex(AValue: integer);
   procedure SetRollImage(AValue: TRollImage);
   procedure SetSpeed(AValue: integer);
   procedure SetTextStyle(AValue: TTextStyle);
   procedure SetEnabled(aValue: boolean);reintroduce;

  protected
   procedure CalculateBounds;
   procedure CalculateButton;
   procedure KeyPress(var Key: char);override;
   procedure KeyDown(var Key: Word; Shift: TShiftState);  override;
   procedure KeyUp(var Key: Word; Shift: TShiftState);  override;
   procedure CNKeyDown    (var Message: TLMKeyDown);    message CN_KEYDOWN;
   procedure DoExit;  override;
   procedure DoEnter; override;
  public
   constructor Create(AOwner: TComponent); override;
   destructor  Destroy; override;
   procedure MouseEnter; override;
   procedure MouseLeave; override;
   procedure MouseMove({%H-}Shift: TShiftState; X, Y: Integer);override;
   procedure MouseDown({%H-}Button: TMouseButton;{%H-}Shift: TShiftState; X, Y: Integer);override;
   procedure MouseUp({%H-}Button: TMouseButton; {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Integer);override;
   procedure LoadImagesfromFile(LeftFilename,RightFilename: string);
   procedure Paint; override;

   property HoverBlendFaktor : Double read FHoverBlendFaktor write FHoverBlendFaktor;
   property FocusedBlendFaktor : Double read FFocusedBlendFaktor write FFocusedBlendFaktor;
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
   //The Left background colour
   //Die linke Hintergrundfarbe
   property LeftBgrdColor : TColor read FLeftBgrdColor write SetLeftBgrdColor default $000000C8;
   //The Right background colour
   //Die rechte Hintergrundfarbe
   property RightBgrdColor : TColor read FRightBgrdColor write SetRightBgrdColor default $0000C800;
   //The color of the button
   //Die Farbe des Buttons
   property ButtonColor : TColor read FButtonColor write SetButtonColor default clNone;
   //The color of the border (clNone = no Border)
   //Farbe des Randes (clNone = keinRand)
   property BorderColor : TColor read FBorderColor write SetBorderColor default clNone;
   //The color of a hoverevent (clNone = no hover)
   //Die Farbe eines Hoverereignisses (clNone = kein Hover)
   property HoverColor : TColor read FHoverColor write SetHoverColor default clNone;
   //The color when the Control has the focus
   //Die Farbe wenn das Control den Fokus hat
   property FocusColor : TColor read FFocusColor write SetFocusColor default clRed;
   //Determines whether the RollButton(Image) rotates
   //Bestimmt ob sich der RollButton(Image) dreht
   property Roll : boolean read FRoll write FRoll default true;
   //Specifies whether the button is on the right or left at the start
   //Gibt an ob der Button beim Start rechts oder links ist
   property Direction        : TDirection read FDirection write SetDirection default fsLeft;
   //The speed at which the button moves
   //Die Geschwindigkeit mit der sich der Button bewegt
   property Speed            : integer read FSpeed write SetSpeed default 10;
   //The caption that is displayed when the button is on the left
   //Die Caption die angezeigt wird wenn der Button links ist
   property LeftCaption   : TCaption read FLeftCaption write SetLeftCaption;
   //The caption that is displayed when the button is on the right
   //Die Caption die angezeigt wird wenn der Button rechts ist
   property RightCaption     : TCaption read FRightCaption  write SetRightCaption;
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
   //Automatically adjusts the text height to the size of the control
   //Passt die Texthöhe automatisch der Größe des Controlls an
   property BestTextHeight : boolean read FBestTextHeight write SetBestTextHeight default true;

   property NewRollImage : TRollImage read FRollImage write SetRollImage;

   property LeftImageIndex : integer read FLeftImageIndex write SetLeftImageIndex default 0;


   property RightImageIndex : integer read FRightImageIndex write SetRightImageIndex default 1;



   property TabStop default TRUE;
   property PopupMenu;
   property DragMode;
   property DragKind;
   property DragCursor;
   property Align;
   property Anchors;
   property Action;
   property BidiMode;
   property BorderSpacing;
   property Constraints;
   property HelpType;
   property TabOrder;
   property Visible;

   property OnClick      : TClickEvent read FOnClick     write FOnClick;
   property OnMouseMove  : TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
   property OnMouseDown  : TMouseEvent read FOnMouseDown write FOnMouseDown;
   property OnMouseUp    : TMouseEvent read FOnMouseUp write FOnMouseUp;
   property OnMouseEnter : TMouseEnterLeave read FOnMouseEnter write FOnMouseEnter;
   property OnMouseLeave : TMouseEnterLeave read FOnMouseLeave write FOnMouseLeave;
   property OnEnter      : TNotifyEvent read FOnEnter write FOnEnter;
   property OnExit       : TNotifyEvent read FOnExit write FOnExit;
   property OnKeyPress   : TKeyPressEvent read FOnKeyPress write FOnKeyPress;
   property OnKeyDown    : TKeyEvent read FOnKeyDown write FOnKeyDown;
   property OnKeyUp      : TKeyEvent read FOnKeyUp write FOnKeyUp;
   property OnChange     : TChangeEvent read FOnChange write FOnChange;
   property OnDragDrop;
   property OnDragOver;
   property OnEndDrag;
   property OnStartDrag;


  end;

procedure Register;

implementation

procedure Register;
begin
  {$I flexiswitch_icon.lrs}
  RegisterComponents('Misc',[TFlexiSwitch]);
  RegisterPropertyEditor(TypeInfo(TRollImage),nil,'NewRollImage',TPropertyImageSelector); //Hier RollImage muss identisch mit der Property sein
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
  FHoverBlendFaktor    := 0.2;
  FRoll                := true;
  FAngel               :=  0;
  FRotation            := 30;
  FDirection           := fsLeft;
  FEnabled             := true;
  FLeftBgrdColor    := rgb(200,0,0);
  FRightBgrdColor      := rgb(0,200,0);
  FButtonColor         := clNone;
  FBorderColor         := clNone;
  FHoverColor          := clNone;
  FEnabledBlendFaktor  := 0.7;
  FFocusedBlendFaktor  := 0.1;
  FDisabledColor       := clWhite;
  FFocusColor          := clRed;
  FBestTextHeight      := true;
  TabStop              := true;

  FTimer            := TTimer.Create(nil);
  FSpeed            := 10;
  FTimer.Interval   := FSpeed;
  FTimer.Enabled    := false;
  FTimer.OnTimer    :=@FTimerTimer;

  FLeftCaption   := 'OFF';
  FRightCaption     := 'ON';
  FCaption          := FLeftCaption;
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

  FLeftImageIndex  := 0;
  FRightImageIndex := 1;
  for lv := 0 to High(FImages) do
    FImages[lv] := TPortableNetworkGraphic.Create;
  FImages[0].LoadFromResourceName(HInstance,'off');
  FImages[1].LoadFromResourceName(HInstance,'ok');
  //load more images, maximal 30

  FImagesCount := High(FImages);
  FLeftImage := TPortableNetworkGraphic.Create;
  FLeftImage.Assign(FImages[FLeftImageIndex]);
  FRightImage := TPortableNetworkGraphic.Create;
  FRightImage.Assign(FImages[FRightImageIndex]);



end;

destructor TFlexiSwitch.Destroy;
var lv : integer;
begin

 if assigned(FRollImage) then FRollImage.Free;
 FBackgroundImage.Free;
 FButtonImage.Free;
 FBorderImage.Free;
 FLeftImage.Free;
 FRightImage.Free;
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
 if Assigned(OnMouseEnter) then OnMouseEnter(self);
 Invalidate;
end;

procedure TFlexiSwitch.MouseLeave;
begin
 if not Enabled then exit;
 inherited MouseLeave;
 FHover := false;
 if Assigned(OnMouseLeave) then OnMouseLeave(self);
 Invalidate;
end;

procedure TFlexiSwitch.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
 if not Enabled then exit;
 inherited MouseMove(Shift, X, Y);
 if Assigned(OnMouseMove) then OnMouseMove(self,Shift,x,y);
 //FHover := true;
 Invalidate;
end;

procedure TFlexiSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 if not Enabled then exit;
 inherited MouseDown(Button, Shift, X, Y);
 FHover := false;
 if Assigned(OnMouseDown) then OnMouseDown(self,Button,Shift,x,y);
 Invalidate;
end;

procedure TFlexiSwitch.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 if not Enabled then exit;
 inherited MouseUp(Button, Shift, X, Y);
 if Assigned(OnMouseUp) then OnMouseUp(self,Button,Shift,x,y);
 if Assigned(OnClick) then OnClick(self);
  if not FTimer.Enabled then
   begin
    //if FDirection = fsRight then FDirection := fsLeft else FDirection := fsRight;
    FDirection := TDirection((ord(FDirection) + 1) mod 2);
    FTimer.Enabled:= true;
    if Assigned(OnChange) then OnChange(self);
   end;
end;

procedure TFlexiSwitch.LoadImagesfromFile(LeftFilename, RightFilename: string);
var oldiniimg, oldRightimg : TCustomBitmap;
begin
 oldiniimg   :=TPortableNetworkGraphic.Create;
 oldRightimg :=TPortableNetworkGraphic.Create;
 try
  if assigned(FLeftImage) then
   begin
    oldiniimg.Assign(FLeftImage);
    FreeAndNil(FLeftImage);
   end;
  if assigned(FRightImage)   then
   begin
    oldRightimg.Assign(FRightImage);
    FreeAndNil(FRightImage);
   end;
 FLeftImage := TPortableNetworkGraphic.Create;
 FRightImage   := TPortableNetworkGraphic.Create;
  try
   if fileexists(LeftFilename) and fileexists(RightFilename) then
    begin
     FLeftImage.LoadFromFile(LeftFilename);
     FRightImage.LoadFromFile(RightFilename);
     if (FLeftImage.Width <> FRightImage.Width) or (FLeftImage.Height <> FRightImage.Height) then
      begin
       FLeftImage.Assign(oldiniimg);
       FRightImage.Assign(oldRightimg);
       showmessage('The size of the images must be the same!');
      end;
    end
   else
    begin
     FLeftImage.Assign(oldiniimg);
     FRightImage.Assign(oldRightimg);
     showmessage('Incorrect path');
    end;
  except
   showmessage('Wrong Graphicformat, only PNG!');
  end;

 Finally
  oldiniimg.Free;
  oldRightimg.Free;
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

procedure TFlexiSwitch.KeyPress(var Key: char);
begin
  inherited KeyPress(Key);
  if Assigned(OnKeyPress) then OnKeyPress(self,Key);
end;

procedure TFlexiSwitch.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Assigned(OnKeyDown) then OnKeyDown(self,Key,Shift);
end;

procedure TFlexiSwitch.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if Assigned(OnKeyUp) then OnKeyUp(self,Key,Shift);
end;

procedure TFlexiSwitch.CNKeyDown(var Message: TLMKeyDown);
begin
 with Message do begin
    Result := 1;
    case CharCode of
        VK_RETURN  : begin
                      if not FEnabled then exit;
                       if not FTimer.Enabled then
                        begin
                         FDirection := TDirection((ord(FDirection) + 1) mod 2);
                         FTimer.Enabled:= true;
                         if Assigned(OnChange) then OnChange(self);
                        end;
                      Invalidate;
                      //if FGroupIndex <> 0 then CheckTheGroup;
                     end

      else begin
        Result := 0;
      end;
    end;
  end;

  inherited;
end;

procedure TFlexiSwitch.DoExit;
begin
  inherited DoExit;
  if Assigned(OnExit) then OnExit(self);
end;

procedure TFlexiSwitch.DoEnter;
begin
 inherited DoEnter;
 if Assigned(OnEnter) then OnEnter(self);
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
      FCaption := FRightCaption;
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
      FCaption := FLeftCaption;
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

procedure TFlexiSwitch.DrawTheBackground;
var TmpBmp                     : TBitmap;
    TempImg1,TempImg2,TempImg3 : TLazIntfImage;
begin
 if (FLeftBgrdColor <> clNone) and (FRightBgrdColor <> clNone) then
  begin
   TempImg1 := FBackgroundImage.CreateIntfImage;
   TempImg2 := FBackgroundImage.CreateIntfImage;
   TempImg3 := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   TmpBmp  := TBitmap.Create;
   try
    ChangeColor(TempImg1,FLeftBgrdColor);
    ChangeColor(TempImg2,FRightBgrdColor);
    BlendImages(TempImg1,TempImg2,FPortion);
    TempImg3.SetSize(Width,Height);
    StretchDrawImgToImg(TempImg1,TempImg3,width,height);
    TmpBmp.PixelFormat:= pf32Bit;
    TmpBmp.Assign(TempImg3);
    Canvas.Draw(0,0,TmpBmp);
   Finally
    TempImg1.Free;
    TempImg2.Free;
    TempImg3.Free;
    TmpBmp.Free;
   end;
  end;
end;

procedure TFlexiSwitch.DrawTheBorder;
var TmpBmp            : TBitmap;
    TempImg1,TempImg2 : TLazIntfImage;
begin
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
   Finally
    TempImg1.Free;
    TempImg2.Free;
    TmpBmp.Free;
   end;
  end;
end;

procedure TFlexiSwitch.DrawFocused;
var TmpBmp            : TBitmap;
    TempImg1,TempImg2 : TLazIntfImage;
begin
 if Focused then
  if FEnabled then
  begin
   TempImg1       := FBackgroundImage.CreateIntfImage;
   TempImg2       := TLazIntfImage.Create(0,0, [riqfRGB, riqfAlpha]);
   TmpBmp         := TBitmap.Create;
   try
    ChangeColor(TempImg1,FFocusColor);
    TempImg2.SetSize(TempImg1.Width,TempImg1.Height);
    AlphaImages(TempImg1,FFocusedBlendFaktor);
    TempImg2.SetSize(Width,Height);
    StretchDrawImgToImg(TempImg1,TempImg2,Width,Height);
    TmpBmp.PixelFormat:= pf32Bit;
    TmpBmp.Assign(TempImg2);
    Canvas.Draw(0,0,TmpBmp);
   Finally
    TempImg1.Free;
    TempImg2.Free;
    TmpBmp.Free;
   end;
  end;
end;

procedure TFlexiSwitch.DrawTheButton;
var TmpBmp            : TBitmap;
    TempImg1,TempImg2 : TLazIntfImage;
begin
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
   Finally
    TempImg1.Free;
    TempImg2.Free;
    TmpBmp.Free;
   end;
  end;
end;

procedure TFlexiSwitch.DrawTheRollbutton;
var TmpBmp                     : TBitmap;
    TempImg1,TempImg2,TempImg3 : TLazIntfImage;
begin
 if FButtonColor = clNone then
 if assigned(FLeftImage) and assigned(FRightImage) then
  begin
   TempImg1 := FLeftImage.CreateIntfImage;
   TempImg2 := FRightImage.CreateIntfImage;
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
   Finally
    TempImg1.Free;
    TempImg2.Free;
    TempImg3.Free;
    TmpBmp.Free;
   end;
 end;
end;

procedure TFlexiSwitch.DrawTheCaption;
var TeRect     : TRect;
begin
 TeRect := CalculateTextRect;
 if FBestTextHeight then FFont.Height := TeRect.Height - round(TeRect.Height * 0.35);
 Canvas.Font.Assign(FFont);
 canvas.TextRect(TeRect,TeRect.Left+FCapLeft,TeRect.Top+FCapTop,
                 FCaption,FTextStyle);
end;

procedure TFlexiSwitch.DrawAHoverEvent;
var TmpBmp            : TBitmap;
    TempImg1,TempImg2 : TLazIntfImage;
begin
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
   Finally
    TempImg1.Free;
    TempImg2.Free;
    TmpBmp.Free;
   end;
  end;
end;

procedure TFlexiSwitch.DrawNotEnabled;
var TmpBmp            : TBitmap;
    TempImg1,TempImg2 : TLazIntfImage;
begin
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
   Finally
    TempImg1.Free;
    TempImg2.Free;
    TmpBmp.Free;
   end;
  end;
end;

procedure TFlexiSwitch.Paint;
begin
 CalculateBounds;

 DrawTheBackground;

 DrawTheBorder;

 DrawFocused;

 CalculateButton;

 DrawTheButton;

 DrawTheRollbutton;

 DrawTheCaption;

 DrawAHoverEvent;

 DrawNotEnabled;

end;

{$Include flexiswitch_setter.inc}
{$Include imageselector.inc}
end.
