program ProgramName;
{$mode objfpc}{$H+}{$J-}

uses
    SysUtils;

procedure Touch(const FileName: string);
var
    F: file;
begin
    if FileExists(FileName) then
    begin
        // Update the timestamp directly using the filename
        // No need to AssignFile or open the file for this
        FileSetDate(FileName, DateTimeToFileDate(Now));
    end
    else
    begin
        // Create the empty file
        AssignFile(F, FileName);
        Rewrite(F);
        CloseFile(F);
    end;
end;

begin
    if ParamCount < 1 then
    begin
        WriteLn('usage: touch <filename>');
        Halt(1);
    end;

    Touch(ParamStr(1));
    WriteLn('file created: ', ParamStr(1));
end.
