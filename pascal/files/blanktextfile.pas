Program ClassicCreateBlankTextFile;

{$mode objfpc}{$H+}{$J-}

Uses
        Classes,
        SysUtils;

Var
        filename: string = 'hello-text.txt';
        textFile: System.TextFile;

Begin
        // Set the name of the file that will be created
        AssignFile(textFile, filename);

        // Enclose in try/except block to handle errors
        Try
                // Open the file for writing (it will create it file doesn't exist)
                ReWrite(textFile);

                // Close file
                CloseFile(textFile);

                // Show a confirmation
                WriteLn('Created a new blank file');

        Except
                // Catch error here
                on E: EInOutError Do
                        WriteLn('Error occurred. Details: ', E.ClassName, '/', E.Message);
        End;

        // Pause console
        ReadLn;
End.
