
program MyProgram;
{$mode objfpc}{$H+}{$J-}

uses
        BaseUnix, Unix;
var
        pipi, pipo: text;
        s: string;
begin
        writeln('assigning pipes. ');
        if assignpipe(pipi, pipo) <> 0 then
                writeln('Error assigning popes!', fpgeterrno);
        writeln('writing to pipe, and flushing.');
        writeln(pipo, 'This is a textstring'); close(pipo);
        writeln('Reading from pipe.');
        while not eof(pipi) do
        begin
                readln(pipi, s);
                writeln('Read from pipe: ', s);
        end;
        close(pipi);
        writeln('Closed pipes.');
        writeln;
end.
