Program ReadTextFileOverloading;

{$mode objfpc}{$H+}{$J-}

Uses
        Classes, StreamEx, SysUtils;

// Procedure to read a text file from stream
Procedure ReadTextFile (Const AStream: TStream); OVERRIDE;
Var
        inputReader: TStreamReader;
        line: string;
Begin
        inputReader := TStreamReader.Create(AStream);
        Try
                While not inputReader.EOF Do
                Begin
                        line := inputReader.ReadLine;
                        WriteLn(line);
                End;
        Finally
                inputReader.Free;
        End;
End;

// Procedure to read a text file by file name
Procedure ReadTextFile (Const filename: string); OVERRIDE;
Var
        fileStream: TFileStream;
Begin
        fileStream := TFileStream.Create(filename, fmOpenRead);
        Try
                ReadTextFile(fileStream);
        Finally
                fileStream.Free;
        End;
End;

// MAIN
Begin
        Try
                ReadTextFile('overloading.pas');
        Except
                on E: Exception Do
                        WriteLn('Error: ' + E.Message);
        End;
End.
