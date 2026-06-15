program DirPathFileCreateDir;

{$mode objfpc}{$H+}{$J-}

uses
 {$IFDEF UNIX}
        cthreads,
 {$ENDIF}
        Classes, SysUtils;

var
        directoryName: string;
begin
        directoryName := ConcatPaths(['demo', 'ex-01']);
        if ForceDirectories(directoryName) then
                WriteLn('Directory created successfully')
        else
                WriteLn('Failed to create directory');
end.
