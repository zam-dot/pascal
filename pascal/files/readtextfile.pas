Program ClassicReadTextFile;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cthreads,
 {$ENDIF}
        Classes,
        SysUtils;

Var
        filename: string = 'cake-ipsum.txt';
        textFile: System.TextFile;
        line: string;

Begin

        // Provide user feedback
        WriteLn(Format('Reading ''%s''', [filename]));

        // Assign filename to a TextFile variable - set the name of the file for reading
        AssignFile(textFile, filename);

        // Perform the read operation in a try..except block to handle errors gracefully
        Try
                // Open the file for reading
                Reset(textFile);

                // Keep reading lines until the end of the file is reached
                While not EOF(textFile) Do
                Begin
                        ReadLn(textFile, line);
                        WriteLn(line);
                End;

                // Close the file
                CloseFile(textFile);

        Except
                on E: Exception Do
                        WriteLn('File handling error occurred. Details: ', E.Message);
        End;

End.
