Program TStreamReaderCount;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cmem, cthreads,
 {$ENDIF}
        Classes,
        SysUtils,
        streamex;

Var
        filename: string;
        fStream: TFileStream;
        fReader: TStreamReader;
        total: int64;
        line:  string;

Begin
        // Get filename
        filename := ParamStr(1);

        // Do we have a valid input file?
        If not FileExists(filename) Then
        Begin
                WriteLn('Please specify a valid input file.');
                Exit;
        End;

        // Reset total
        total := 0;

        // try - except block start
        Try
                fStream := TFileStream.Create(filename, fmOpenRead or fmShareDenyWrite);
                Try
                        fReader := TStreamReader.Create(fStream, 131072, False);
                        Try
                                While not fReader.EOF Do
                                Begin
                                        // Read line
                                        line := fReader.ReadLine;
                                        // Process line here if needed
                                        // ....
                                        // Increase counter
                                        total := total + 1;
                                End;
                        Finally
                                fReader.Free;
                        End;
                Finally
                        fStream.Free;
                End;

                // User feedback
                WriteLn('Total line is: ', IntToStr(total));

        Except
                on E: Exception Do
                        WriteLn('Error: ' + E.Message);
        End; // try - except block ends
End.
