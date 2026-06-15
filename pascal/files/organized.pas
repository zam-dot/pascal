Program ClassicNewTextFileOrganised;

{$mode objfpc}{$H+}{$J-}

Uses
        SysUtils;

// Write or append a text to a file
Procedure WriteTextToFile (fileName: string; stringText: string);
Var
        textFile: System.TextFile;
Begin
        Try
                // Set the name of the file that will be created
                AssignFile(textFile, fileName);

                // Enclose in try/except block to handle errors
                Try
                        // Create (if not found) and open the file for writing
                        Rewrite(textFile);

                        // Adding text
                        WriteLn(textFile, stringText);

                Except
                        // Catch error here
                        on E: EInOutError Do
                                WriteLn('Error occurred. Details: ', E.ClassName, '/', E.Message);
                End;
        Finally
                // Close file
                CloseFile(textFile);
        End;
End;

Begin

        // Write a text to a file
        WriteTextToFile('hello-text.txt', 'Hello There! How are you?');
End.
