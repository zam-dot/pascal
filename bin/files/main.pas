program MyProgram;
{$mode objfpc}{$H+}{$J-}

uses FileUnit;

begin
        if ParamCount < 1 then
        begin
                writeln('usage: main <filename>');
                Halt(1);
        end;
        ReadFromHandle(ParamStr(1));
end.
