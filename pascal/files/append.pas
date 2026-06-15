Program ClassicAppendTextFile;

{$mode objfpc}{$H+}{$J-}

Uses
        SysUtils;

// Create a new file, the classical way
Procedure CreateNewFile (filename: string);
Var
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
                WriteLn(Format('Created a new file: ''%s''', [filename]));

        Except
                // Catch error here
                on E: EInOutError Do
                        WriteLn('Error occurred. Details: ', E.ClassName, '/', E.Message);
        End;
End;

Var
        filename: string = 'hello-text.txt';
        textFile: System.TextFile;

Begin

        // First of all, check if the input file exists.
        // If not, create a new text file
        If not FileExists(filename) Then
                CreateNewFile(filename);

        Try
                // Set filename to a file
                AssignFile(textFile, filename);

                // Enclose in try/except block to handle errors
                Try
                        // Open a file for appending.
                        Append(textFile);

                        // Adding text
                        WriteLn(textFile, 'New Line!');
                        WriteLn(textFile, 'New Line!');

                Except
                        // Catch error here
                        on E: EInOutError Do
                                WriteLn('Error occurred. Details: ', E.ClassName, '/', E.Message);
                End;

        Finally
                // Close file
                CloseFile(textFile);
        End;

        // Pause console
        WriteLn('Press Enter key to quit.');
        ReadLn;
End.
