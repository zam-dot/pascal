program MyProgram;
{$mode objfpc}{$H+}{$J-}

uses FileUnit;
{
    ===================================
    program: fpdir.pas 
    author: Sam
    date: 2026
    
    description:
    list directories like ls. 

    example:
    ./fpdir ../
    ===================================
}

begin
        if ParamCount < 1 then
        begin
                ReadDirectory('./.');
                Halt(1);
        end;
        ReadDirectory(ParamStr(1));
end.
