Program TStreamReaderReadFileTidy;

{$mode objfpc}{$H+}{$J-}

Uses
        Classes,
        SysUtils,
        streamex;

// Read a stream of string line by line
Procedure ReadTextFile (Const fileStream: TStream);
Var
        reader: TStreamReader;
        i: integer;
        line: string;
Begin
        reader := TStreamReader.Create(fileStream);
        Try
                // Set line counter to 1
                i := 1;
                While not reader.EOF Do
                Begin
                        line := reader.ReadLine;
                        WriteLn(Format('line %d: %s', [i, line]));
                        i := i + 1;
                End;
        Finally
                reader.Free;
        End;
End;

// Open a file for reading, and pass the stream to TStreamReader for reading.
Procedure ReadTextFile (Const filename: string);
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

Var
        filename: string;

Begin
        // filename to read
        filename := 'cake-ipsum.txt';
        Try
                ReadTextFile(filename);
        Except
                on E: Exception Do
                        WriteLn('Error: ' + E.Message);
        End;

        // Pause console
        ReadLn;
End.
