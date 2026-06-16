program MyProgram;
{$mode objfpc}{$H+}{$J-}

{
    ===================================
    program: fpaccess.pas 
    author:
    date: 2026
    
    description:
    Check the files access rights. 

    access rights:
    R_OK user has read rights.
    ===================================
}

uses FileUnit;

begin
        if ParamCount < 1 then
        begin
                writeln('usage: fpaccess <filename>');
                Halt(1);
        end;

        if CheckFileAccess(ParamStr(1), R_OK) then
                writeln('you have read access');
end.
