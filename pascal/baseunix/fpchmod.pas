program FchmodProgram;
{$mode objfpc}{$H+}{$J-}
{
    ====================================
    File:   fchmod.pas
    Author: Sam
    Date:   2026

    Description:
    Simple chmod alternative to change permissions of files.
    Permissions bits are unsigned. StrToIntDef to safely 
    convert the string. Prefix '&' to convert to octal.

    Usage:
    fpchmod <number> <filename>
    ====================================
}
uses
    SysUtils, BaseUnix;
var
    modeStr: string;
    modeInt: cardinal;
begin
    if ParamCount < 2 then
    begin
        writeln('usage: fpchmod <octal_mode> <filename>');
        writeln('example: fpchmod 755 myfile.txt');
        halt(1);
    end;

    modeStr := ParamStr(1);
    modeInt := StrToIntDef('&' + modeStr, 0);

    if modeInt = 0 then
    begin
        writeln('Error: Invalid permission mode provided.');
        halt(1);
    end;

    if fpChmod(ParamStr(2), modeInt) = 0 then
        writeln('Permissions updated successfully.')
    else
        writeln('Error: Failed to change permissions (check file existence/privileges).');
end.
