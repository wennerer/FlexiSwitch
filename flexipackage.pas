{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit FlexiPackage;

{$warn 5023 off : no warning about unused units}
interface

uses
  FlexiSwitch, outsourced, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('FlexiSwitch', @FlexiSwitch.Register);
end;

initialization
  RegisterPackage('FlexiPackage', @Register);
end.
