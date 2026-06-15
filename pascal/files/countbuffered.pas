Program TBufferedFileStreamCount;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cmem, cthreads,
 {$ENDIF}
        Classes,
        SysUtils,
        streamex;

Const
        BufferSize = 131072; // Adjust buffer size as needed

Var
        filename: string;
        fStream: TFileStream;
        total: int64;
        buffer: Array[0..BufferSize - 1] Of char;
        bytesRead: integer;
        i: integer;

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
                        Repeat
                                bytesRead := fStream.Read(buffer[0], BufferSize);
                                i := 0;
                                While i < bytesRead Do
                                Begin
                                        // Count lines in the buffer
                                        If buffer[i] = #10 Then
                                                total := total + 1;
                                        Inc(i);
                                End;
                        Until bytesRead = 0;
                Finally
                        fStream.Free;
                End;

                // User feedback
                WriteLn('Total lines:', IntToStr(total));

        Except
                on E: Exception Do
                        WriteLn('Error: ' + E.Message);
        End; // try - except block ends
End.
