Program TStreamReaderReadFile;

{$mode objfpc}{$H+}{$J-}

Uses
        Classes,
        SysUtils,
        streamex;

Var
        reader: TStreamReader;
        fileStream: TFileStream;
        line, filename: string;
        i: integer;
Begin
        // filename to read
        filename := 'cake-ipsum-.txt';
        Try
                fileStream := TFileStream.Create(filename, fmOpenRead);
                Try
                        reader := TStreamReader.Create(fileStream);
                        Try
                                // Set line counter to 1
                                i := 1;
                                While not reader.EOF Do
                                Begin
                                        line := reader.ReadLine;
                                        WriteLn(Format('line %d is: %s', [i, line]));
                                        i := i + 1;
                                End;
                        Finally
                                reader.Free;
                        End;
                Finally
                        fileStream.Free;
                End;
        Except
                on E: Exception Do
                        WriteLn('Error: ' + E.Message);
        End;

        // Pause console
        ReadLn;
End.
