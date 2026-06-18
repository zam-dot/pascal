
program MyProgram;
{$mode objfpc}{$H+}{$J-}

uses SysUtils;

begin
    writeln('Path is: ', GetEnvironmentVariable('PATH'));
end.
