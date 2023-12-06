unit outsourced;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, IntfGraphics, Graphics, LCLIntf, LCLType, LazCanvas,
  FPImage, FPCanvas;

function RotatePoint(const APoint: TPoint; AAngle: Double): TPoint;
procedure RotateImage(Img: TFPCustomImage; Angle: Double);
procedure BlendImages(Img1, Img2: TFPCustomImage; AFactor: Double);
procedure AlphaImages(Img1: TFPCustomImage; AFactor: Double);
procedure ChangeColor(Img: TLazIntfImage;aColor : TColor);
procedure ChangeBorderColor(Img: TLazIntfImage;aColor : TColor);
Procedure StretchDrawImgToImg(SourceImg, DestImg: TLazIntfImage; DestWidth, DestHeight: integer);
function System_ToRGB(clSys:TColor):TColor;
function PointInaCircle(aRect:TRect;x,y:integer) : boolean;

implementation

function RotatePoint(const APoint: TPoint; AAngle: Double): TPoint;
var
  sa, ca: Double;
begin
  SinCos(AAngle, sa, ca);
  Result.X := Round( ca * APoint.X + sa * APoint.Y);
  Result.Y := Round(-sa * APoint.X + ca * APoint.Y);
end;

procedure RotateImage(Img: TFPCustomImage; Angle: Double);
var
  Buffer: TFPCustomImage;
  x, y: Integer;
  C, P: TPoint;
begin
  Buffer := TFPMemoryImage.Create(Img.Width, Img.Height);
  C := Point(Img.Width div 2, Img.Height div 2);
  for y := 0 to Buffer.Height-1 do
    for x := 0 to Buffer.Width-1 do
    begin
      P := RotatePoint(Point(x, y) - C, Angle) + C;

      if (P.X >= 0) and (P.Y >= 0) and (P.X < Img.Width) and (P.Y < Img.Height) then
        Buffer.Colors[x, y] := Img.Colors[P.X, P.Y]
      else
        Buffer.Colors[x, y] := colTransparent;
    end;
  for y := 0 to Img.Height-1 do
   for x := 0 to Img.Width-1 do
      Img.Colors[x, y] := Buffer[x, y];
  Buffer.Free;
end;

procedure BlendImages(Img1, Img2: TFPCustomImage; AFactor: Double);
var
  x, y: Integer;
  r,g,b,a: Word;
  f1, f2: Double;
begin
  f1 := 1.0 - AFactor;
  f2 := AFactor;
  for y := 0 to Img1.Height-1 do
    for x := 0 to Img1.Width-1 do
    begin
      r := round(f1 * Img1.Colors[x, y].Red   + f2 * Img2.Colors[x, y].Red);
      g := round(f1 * Img1.Colors[x, y].Green + f2 * Img2.Colors[x, y].Green);
      b := round(f1 * Img1.Colors[x, y].Blue  + f2 * Img2.Colors[x, y].Blue);
      a := round(f1 * Img1.Colors[x, y].Alpha + f2 * Img2.Colors[x, y].Alpha);
      Img1.Colors[x, y] := FPColor(r, g, b, a);
    end;
end;

procedure AlphaImages(Img1: TFPCustomImage; AFactor: Double);
var
  x, y: Integer;
  r,g,b,a: Word;
  f1: Double;
begin
 f1 := AFactor;
 for y := 0 to Img1.Height-1 do
    for x := 0 to Img1.Width-1 do
    begin
      r := round(f1 * Img1.Colors[x, y].Red   );
      g := round(f1 * Img1.Colors[x, y].Green );
      b := round(f1 * Img1.Colors[x, y].Blue  );
      a := round(f1 * Img1.Colors[x, y].Alpha );
      Img1.Colors[x, y] := FPColor(r, g, b, a);
    end;
end;

procedure ChangeColor(Img: TLazIntfImage;aColor : TColor);
var Image1                 : TCustomBitmap;
    Image2                 : TLazIntfImage;
    valR,valG,valB,valA    : byte;
    valRNew,valGNew,valBNew: byte;
    valtemp1,valtemp2      : byte;
    x,y                    : integer;
    P                      : TPoint;
begin
 Image1 := TPortableNetworkGraphic.Create;
 Image1.SetSize(Img.Width,Img.Height);
 Image2:= Image1.CreateIntfImage;
 Image2.Assign(Img);
 {$IFDEF Windows}
  valtemp1:=0;
  valtemp2:=200;
  valRNew:=GetRValue(aColor);
  valGNew:=getGvalue(aColor);
  valBNew:=getBvalue(aColor);
 {$ENDIF}
 {$IFDEF LINUX}
  valRNew:=GetBValue(aColor);
  valGNew:=getGvalue(aColor);
  valBNew:=getRvalue(aColor);
  valtemp1:=200;
  valtemp2:=0;
 {$ENDIF}
 try

   for y := 0 to  Img.height - 1 do
    begin
     for x := 0 to Img.width - 1 do
      begin
       P.X:=x;P.Y:=y;
       valR:= PRGBQUAD(Img.GetDataLineStart(P.Y))[P.X].rgbRed;
       valG:= PRGBQuad(Img.GetDataLineStart(P.Y))[P.X].rgbGreen;
       valB:= PRGBQuad(Img.GetDataLineStart(P.Y))[P.X].rgbBlue;
       valA:= PRGBQuad(Img.GetDataLineStart(P.Y))[P.X].rgbReserved;
       //if valA <> 0 then
       if valR = valtemp2 then
        if valG = 0 then
         if valB = valtemp1 then
          if ValA = 255 then
           begin
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbRed    := valRNew;
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbGreen  := valGNew;
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbBlue   := valBNew;
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbReserved:=255;
           end;
       if (ValA <> 255) and (valA <> 0) then
           begin
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbRed    := valRNew;
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbGreen  := valGNew;
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbBlue   := valBNew;
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbReserved:=valA;
           end;

      end;//for x
    end;//for y
    Img.Assign(Image2);

 finally
  Image2.Free;
  Image1.Free;
 end;
end;

procedure ChangeBorderColor(Img: TLazIntfImage;aColor : TColor);
var Image1                 : TCustomBitmap;
    Image2                 : TLazIntfImage;
    valR,valG,valB,valA    : byte;
    valRNew,valGNew,valBNew: byte;
    valtemp1,valtemp2      : byte;
    x,y                    : integer;
    P                      : TPoint;
begin
 Image1 := TPortableNetworkGraphic.Create;
 Image1.SetSize(Img.Width,Img.Height);
 Image2:= Image1.CreateIntfImage;
 Image2.Assign(Img);
 {$IFDEF Windows}
  valtemp1:=0;
  valtemp2:=200;
  valRNew:=GetRValue(aColor);
  valGNew:=getGvalue(aColor);
  valBNew:=getBvalue(aColor);
 {$ENDIF}
 {$IFDEF LINUX}
  valRNew:=GetBValue(aColor);
  valGNew:=getGvalue(aColor);
  valBNew:=getRvalue(aColor);
  valtemp1:=200;
  valtemp2:=0;
 {$ENDIF}
 try

   for y := 0 to  Img.height - 1 do
    begin
     for x := 0 to Img.width - 1 do
      begin
       P.X:=x;P.Y:=y;
       valR:= PRGBQUAD(Img.GetDataLineStart(P.Y))[P.X].rgbRed;
       valG:= PRGBQuad(Img.GetDataLineStart(P.Y))[P.X].rgbGreen;
       valB:= PRGBQuad(Img.GetDataLineStart(P.Y))[P.X].rgbBlue;
       valA:= PRGBQuad(Img.GetDataLineStart(P.Y))[P.X].rgbReserved;
       if valA <> 0 then
           begin
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbRed    := valRNew;
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbGreen  := valGNew;
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbBlue   := valBNew;
            PRGBQuad(Image2.GetDataLineStart(P.Y))[P.X].rgbReserved:=valA;
           end;


      end;//for x
    end;//for y
    Img.Assign(Image2);

 finally
  Image2.Free;
  Image1.Free;
 end;
end;


Procedure StretchDrawImgToImg(SourceImg, DestImg: TLazIntfImage; DestWidth, DestHeight: integer);
Var
  DestIntfImage: TLazIntfImage;
  DestCanvas: TLazCanvas;
Begin
  DestIntfImage := TLazIntfImage.Create(0, 0);
  DestIntfImage.Assign(DestImg);
  DestCanvas := TLazCanvas.Create(DestIntfImage);
  DestCanvas.Interpolation := TMitchelInterpolation.Create;//TFPSharpInterpolation.Create;
  DestCanvas.StretchDraw(0, 0, DestWidth, DestHeight, SourceImg);
  DestImg.Assign(DestIntfImage);
  DestCanvas.Interpolation.Free;
  DestCanvas.Free;
  DestIntfImage.Free;
End;

function System_ToRGB(clSys:TColor):TColor;
  var FPCol :  TFPColor;
  begin
   FPCol:=TColorToFPColor(ColorToRGB(clSys));
   result :=FPColorToTColor(FPCol);
  end;

function PointInaCircle(aRect:TRect;x,y:integer) : boolean;
var radius     : integer;
    a,b        : integer;
begin
 radius := (aRect.Right - aRect.Left) div 2;
 a := aRect.CenterPoint.X - x;
 b := aRect.CenterPoint.Y - y;
 result := (Round(HyPot(a,b)) <= radius);
end;
end.

