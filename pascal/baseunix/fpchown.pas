
program MyProgram;
{$mode objfpc}{$H+}{$J-}
uses BaseUnix;

begin
    // Changing file to owner 1000 (your user) and group 1000
    if fpChown('testex21', 1000, 1000) = 0 then
        writeln('Ownership updated!')
    else
        writeln('Failed: Are you running as root?');

end.
