{%FlexiSwitch --- this is a part of TFlexiSwitch}



procedure TFlexiSwitch.SetFinalBgrdColor(AValue: TColor);
begin
  if FFinalBgrdColor=AValue then Exit;
  FFinalBgrdColor:=AValue;
  Invalidate;
end;

procedure TFlexiSwitch.SetHoverColor(AValue: TColor);
begin
  if FHoverColor=AValue then Exit;
  FHoverColor:=AValue;
  Invalidate;
end;

procedure TFlexiSwitch.SetButtonColor(AValue: TColor);
begin
  if FButtonColor=AValue then Exit;
  FButtonColor:=AValue;
  Invalidate;
end;

procedure TFlexiSwitch.SetBorderColor(AValue: TColor);
begin
  if FBorderColor=AValue then Exit;
  FBorderColor:=AValue;
  Invalidate;
end;

procedure TFlexiSwitch.SetInitialBgrdColor(AValue: TColor);
begin
  if FInitialBgrdColor=AValue then Exit;
  FInitialBgrdColor:=AValue;
  Invalidate;
end;
