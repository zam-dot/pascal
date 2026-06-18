
program MyProgram;
{$mode objfpc}{$H+}{$J-}

uses BaseUnix;

begin
    writeln('Group id = ', fpgetgid, ' Effective group id = ', fpgetgid);
end.
