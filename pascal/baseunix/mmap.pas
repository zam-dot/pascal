
program MyProgram;
{$mode objfpc}{$H+}{$J-}

uses BaseUnix, Unix;

var
    S: String;
    fd: cint;
    Len: longint;
    P: Pchar;

begin
    s := 'This is the string';
    Len := Length(S);
    fd := fpOpen('testfile.txt', O_wrOnly);
    if fd = -1 then
        Halt(1);
    if fpWrite(fd, S[1], Len) = -1 then
        Halt(2);
    fpClose(fd);
    fd := fpOpen('testfile.txt', O_rdOnly);

    if fd = -1 then
        Halt(3);
    P := Pchar(fpmmap(nil, len + 1, PROT_READ, MAP_PRIVATE, fd, 0));
    if longint(P) = -1 then
        Halt(4);
    Writeln('Read in memory: ', P);
    fpClose(fd);
    if fpMUnMap(P, Len) <> 0 then
        Halt(fpgeterrno);
end.
