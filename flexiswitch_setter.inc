{%FlexiSwitch --- this is a part of TFlexiSwitch}



procedure TFlexiSwitch.SetFinalBgrdColor(AValue: TColor);
begin
  if FFinalBgrdColor=AValue then Exit;
  if aValue = clNone then FBorderColor:= clNone else
  FFinalBgrdColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetFinalCaption(AValue: TCaption);
begin
 if aValue = '' then aValue:=' ';
 if FFinalCaption=AValue then Exit;
 FFinalCaption:=AValue;
 if FDirection = fsRight then FCaption := aValue;
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
  if aValue = clNone then FBorderColor:= clNone else
  FHoverColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetButtonColor(AValue: TColor);
begin
  if FButtonColor=AValue then Exit;
  if aValue = clNone then FBorderColor:= clNone else
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
    FCaption := FInitialCaption;
   end
   else
   begin
    FPortion:= 1;
    FAngel :=  360;
    FRollPos := width - (FButtonSize + (2*FMargin));
    FCaption := FFinalCaption;
   end;
  Invalidate;
end;

procedure TFlexiSwitch.SetDisabledColor(AValue: TColor);
begin
  if FDisabledColor=AValue then Exit;
  if aValue = clNone then FBorderColor:= clNone else
  FDisabledColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetBorderColor(AValue: TColor);
begin
  if FBorderColor=AValue then Exit;
  if aValue = clNone then FBorderColor:= clNone else
  FBorderColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetInitialBgrdColor(AValue: TColor);
begin
  if FInitialBgrdColor=AValue then Exit;
  if aValue = clNone then FBorderColor:= clNone else
  FInitialBgrdColor:=System_ToRGB(AValue);
  Invalidate;
end;

procedure TFlexiSwitch.SetInitialCaption(AValue: TCaption);
begin
 if aValue = '' then aValue:=' ';
 if FInitialCaption=AValue then Exit;
 FInitialCaption:=AValue;
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

