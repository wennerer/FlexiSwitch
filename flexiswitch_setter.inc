{%FlexiSwitch --- this is a part of TFlexiSwitch}

procedure TFlexiSwitch.SetRightBgrdColor(AValue: TColor);
begin
  if FRightBgrdColor=AValue then Exit;
  if aValue = clNone then FRightBgrdColor:= clNone else
  FRightBgrdColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetRightCaption(AValue: TCaption);
begin
 if aValue = '' then aValue:=' ';
 if FRightCaption=AValue then Exit;
 FRightCaption:=AValue;
 if FDirection = fsRight then FCaption := aValue;
 Invalidate;
end;

procedure TFlexiSwitch.SetFocusColor(AValue: TColor);
begin
  if FFocusColor=AValue then Exit;
  if aValue = clNone then FFocusColor:= clNone else
  FFocusColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetFont(AValue: TFont);
begin
 if fFont=AValue then Exit;
 FFont.Assign(aValue);
 Invalidate;
end;

procedure TFlexiSwitch.SetHoverColor(AValue: TColor);
begin
  if FHoverColor=AValue then Exit;
  if aValue = clNone then FHoverColor:= clNone else
  FHoverColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetButtonColor(AValue: TColor);
begin
  if FButtonColor=AValue then Exit;
  if aValue = clNone then FButtonColor:= clNone else
  FButtonColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetCapLeft(AValue: integer);
begin
  if FCapLeft=AValue then Exit;
  FCapLeft:=AValue;
end;

procedure TFlexiSwitch.SetCapTop(AValue: integer);
begin
  if FCapTop=AValue then Exit;
  FCapTop:=AValue;
end;

procedure TFlexiSwitch.SetDirection(AValue: TDirection);
begin
 if FDirection=AValue then Exit;
  FDirection:=AValue;
  if AValue = fsLeft then
   begin
    FPortion := 0;
    FAngel := 0;
    FRollPos := 0;
    FCaption := FLeftCaption;
   end
   else
   begin
    FPortion:= 1;
    FAngel :=  360;
    FRollPos := width - (FButtonSize + (2*FMargin));
    FCaption := FRightCaption;
   end;
  Invalidate;
end;

procedure TFlexiSwitch.SetDisabledColor(AValue: TColor);
begin
  if FDisabledColor=AValue then Exit;
  if aValue = clNone then FDisabledColor:= clNone else
  FDisabledColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetLeftImageIndex(AValue: integer);
begin
  if FLeftImageIndex=AValue then Exit;
  FLeftImageIndex:=AValue;
  if assigned(FLeftImage) then FreeAndNil(FLeftImage);
  FLeftImage := TPortableNetworkGraphic.Create;
  FLeftImage.Assign(FImages[FLeftImageIndex]);
  Invalidate;
end;


procedure TFlexiSwitch.SetBorderColor(AValue: TColor);
begin
  if FBorderColor=AValue then Exit;
  if aValue = clNone then FBorderColor:= clNone else
  FBorderColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetLeftBgrdColor(AValue: TColor);
begin
  if FLeftBgrdColor=AValue then Exit;
  if aValue = clNone then FLeftBgrdColor:= clNone else
  FLeftBgrdColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetLeftCaption(AValue: TCaption);
begin
 if aValue = '' then aValue:=' ';
 if FLeftCaption=AValue then Exit;
 FLeftCaption:=AValue;
 if FDirection = fsLeft then FCaption := aValue;
 Invalidate;
end;

procedure TFlexiSwitch.SetLayout(AValue: TTextLayout);
begin
 if fTextStyle.Layout=AValue then exit;
 fTextStyle.Layout:=AValue;
 if aValue <> tlTop then FCapTop:=0;
 Invalidate;
end;

procedure TFlexiSwitch.SetRightImageIndex(AValue: integer);
begin
  if FRightImageIndex=AValue then Exit;
  FRightImageIndex:=AValue;
  if assigned(FRightImage) then FreeAndNil(FRightImage);
  FRightImage := TPortableNetworkGraphic.Create;
  FRightImage.Assign(FImages[FRightImageIndex]);
  Invalidate;
end;

procedure TFlexiSwitch.SetRollImage(AValue: TRollImage);
begin
 if not assigned(FRollImage) then FRollImage  := TRollImage.Create;
 if aValue.ImageIndex = -1 then
  begin
   Direction := TDirection((ord(FDirection) + 1) mod 2);
   exit;
  end;

 if aValue.aDirection = fsLeft then
  begin
   if assigned(FLeftImage) then FreeAndNil(FLeftImage);
   FLeftImage := TPortableNetworkGraphic.Create;
   FLeftImage.Assign(FImages[aValue.ImageIndex]);
   FLeftImageIndex := aValue.ImageIndex;
  end;
 if aValue.aDirection = fsRight then
  begin
   if assigned(FRightImage) then FreeAndNil(FRightImage);
   FRightImage := TPortableNetworkGraphic.Create;
   FRightImage.Assign(FImages[aValue.ImageIndex]);
   FRightImageIndex := aValue.ImageIndex;
  end;
 Invalidate;
end;

procedure TFlexiSwitch.SetSpeed(AValue: integer);
begin
  if FSpeed=AValue then Exit;
  FSpeed:=AValue;
  FTimer.Interval := AValue;
end;

procedure TFlexiSwitch.SetTextStyle(AValue: TTextStyle);
begin
 FTextStyle:=AValue;
end;

procedure TFlexiSwitch.SetEnabled(aValue: boolean);
begin
 if FEnabled = aValue then Exit;
 FEnabled:=aValue;
 Invalidate;
end;


procedure TFlexiSwitch.SetAlignment(AValue: TAlignment);
begin
 if fTextStyle.Alignment=AValue then exit;
 fTextStyle.Alignment:=AValue;
 if aValue <> taLeftJustify then FCapLeft:=0;
 Invalidate;
end;

procedure TFlexiSwitch.SetBestTextHeight(AValue: boolean);
begin
  if FBestTextHeight=AValue then Exit;
  FBestTextHeight:=AValue;
  Invalidate;
end;

