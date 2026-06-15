Program ClassicCountLine;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cthreads,
 {$ENDIF}
        Classes,
        SysUtils;

Const
        BUFFER_SIZE = 131072;

Var
        filename: string;
        textFile: System.TextFile;
        buffer: Array [0..BUFFER_SIZE - 1] Of char;
        line: string;
        total: int64;

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

        // Assign filename to a TextFile variable - set the name of the file for reading
        AssignFile(textFile, filename);

        // Perform the read operation in a try..except block to handle errors gracefully
        Try
                // Open the file for reading
                Reset(textFile);
                // Set buffer
                SetTextBuf(textFile, buffer);

                // Keep reading lines until the end of the file is reached
                While not EOF(textFile) Do
                Begin
                        ReadLn(textFile, line);
                        total := total + 1;
                End;

                // Close the file
                CloseFile(textFile);

                // User feedback
                WriteLn('Total number of lines: ', IntToStr(total));

        Except
                on E: Exception Do
                        WriteLn('File handling error occurred. Details: ', E.Message);
        End;
End.
