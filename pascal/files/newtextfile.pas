Program ClassicNewTextFile;

{$mode objfpc}{$H+}{$J-}

Uses
        SysUtils;

Var
        textFile: System.TextFile;

Begin
        Try
                // Set the name of the file that will be created
                AssignFile(textFile, 'output_file.txt');

                // Enclose in try/except block to handle errors
                Try
                        // Create (if not found) and open the file for writing
                        Rewrite(textFile);

                        // Adding text
                        WriteLn(textFile, 'Hello Text!');

                Except
                        // Catch error here
                        on E: EInOutError Do
                                WriteLn('Error occurred. Details: ', E.ClassName, '/', E.Message);
                End;
        Finally
                // Close file
                CloseFile(textFile);
        End;
End.
