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
  if Assigned(OnChange) then OnChange(self);
  if AValue = fsLeft then
   begin
    if (csDesigning in Componentstate) then
     begin
      FPortion := 0;
      FAngel   := 0;
      FRollPos := 0;
     end
    else
      FTimer.Enabled:= true;
    FCaption := FLeftCaption;
   end
   else
   begin
    if FFirst and not (csDesigning in Componentstate) then
     begin
      CalculateBounds;
      CalculateButton;
      if not (csLoading in Componentstate) then FTimer.Enabled:= true
      else
       begin
        FPortion    := 1;
        FAngel      :=  360;
        FRollPos    := width - (FButtonSize + (2*FMargin));
       end;
     end else
     begin
      if (csDesigning in Componentstate) then
        begin
         FPortion    := 1;
         FAngel      :=  360;
         FRollPos    := width - (FButtonSize + (2*FMargin));
        end else
      FTimer.Enabled:= true;
     end;
    FCaption    := FRightCaption;
    FFirstRight := true;
   end;
  if not (csLoading in Componentstate) then FFirst := false;
  Invalidate;
end;


procedure TFlexiSwitch.SetChecked(AValue: boolean);
begin
  if FChecked=AValue then Exit;
  FChecked:=AValue;
  if aValue then SetDirection(fsRight) else SetDirection(fsLeft);
end;

procedure TFlexiSwitch.SetDisabledColor(AValue: TColor);
begin
  if FDisabledColor=AValue then Exit;
  if aValue = clNone then FDisabledColor:= clNone else
  FDisabledColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetEnabledBlendFaktor(AValue: Double);
begin
  if FEnabledBlendFaktor=AValue then Exit;
  FEnabledBlendFaktor:=AValue;
  Invalidate;
end;

procedure TFlexiSwitch.SetGroupIndex(AValue: integer);
begin
  if FGRoupIndex=AValue then Exit;
  FGRoupIndex:=AValue;
end;

procedure TFlexiSwitch.SetImgSizeFactor(AValue: double);
begin
  if FImgSizeFactor=AValue then Exit;
  FImgSizeFactor:=AValue;
  Invalidate;
end;

procedure TFlexiSwitch.SetLeftImageIndex(AValue: integer);
begin
  if FLoadFromFile then
   begin
    FLoadFromFile := false;
    if assigned(FImgLeftImage) then FreeAndNil(FImgLeftImage);
    if assigned(FRightImage) then FreeAndNil(FRightImage);
    FRightImage := TPortableNetworkGraphic.Create;
    FRightImage.Assign(FImages[1]);
    FImgLeftImage := TPortableNetworkGraphic.Create;
    FImgLeftImage.Assign(FImages[0]);
    FImgSizeFactor := 1;
    FImgLeft          := 0;
    FImgTop           := 0;
   end;
  if FImgLeftImageIndex=AValue then Exit;
  if aValue < 0 then aValue := 0;
  if aValue > High(FImages) then aValue := High(FImages);
  FImgLeftImageIndex:=AValue;
  if assigned(FImgLeftImage) then FreeAndNil(FImgLeftImage);
  FImgLeftImage := TPortableNetworkGraphic.Create;
  FImgLeftImage.Assign(FImages[FImgLeftImageIndex]);
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
  if FImgLeftBgrdColor=AValue then Exit;
  if aValue = clNone then FImgLeftBgrdColor:= clNone else
  FImgLeftBgrdColor:=System_ToRGB(AValue);
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
  if FLoadFromFile then
   begin
    FLoadFromFile := false;
    if assigned(FImgLeftImage) then FreeAndNil(FImgLeftImage);
    if assigned(FRightImage) then FreeAndNil(FRightImage);
    FRightImage := TPortableNetworkGraphic.Create;
    FRightImage.Assign(FImages[1]);
    FImgLeftImage := TPortableNetworkGraphic.Create;
    FImgLeftImage.Assign(FImages[0]);
    FImgSizeFactor := 1;
    FImgLeft          := 0;
    FImgTop           := 0;
   end;
  if FRightImageIndex=AValue then Exit;
  if aValue < 0 then aValue := 0;
  if aValue > High(FImages) then aValue := High(FImages);
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
   if assigned(FImgLeftImage) then FreeAndNil(FImgLeftImage);
   FImgLeftImage := TPortableNetworkGraphic.Create;
   FImgLeftImage.Assign(FImages[aValue.ImageIndex]);
   FImgLeftImageIndex := aValue.ImageIndex;
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

procedure TFlexiSwitch.BoundsChanged;
begin
  inherited BoundsChanged;
   if (FDirection = fsRight) then
  begin
   CalculateBounds;
   CalculateButton;
   FRollPos := width - (FButtonSize + (2*FMargin));
  end;
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



