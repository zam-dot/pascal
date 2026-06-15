Program TBufferedFileStreamReadFile;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cmem, cthreads,
 {$ENDIF}
        Classes,
        SysUtils,
        streamex,
        bufstream;

Var
        fStream: TBufferedFileStream;
        sReader: TStreamReader;
        line: string;
        Count: int64 = 0;

Begin

        If Length(ParamStr(1)) < 1 Then
        Begin
                WriteLn('Please provide a valid input file.');
                Exit;
        End;

        Try
                // Create TBufferedFileStream object
                fStream := TBufferedFileStream.Create(ParamStr(1), fmOpenRead);
                Try
                        sReader := TStreamReader.Create(fStream);
                        Try
                                // Keep on reading until there is no more data to read
                                Count := 0;
                                While not sReader.EOF Do
                                Begin
                                        line := sReader.ReadLine;
                                        Inc(Count);
                                        WriteLn('Line ', IntToStr(Count), ' : ', line);
                                End;
                        Finally
                                sReader.Free;
                        End;
                Finally
                        fStream.Free;
                End;
        Except
                on E: Exception Do
                        WriteLn('Error: ' + E.Message);
        End;
End.
