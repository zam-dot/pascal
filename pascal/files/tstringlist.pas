Program TStringListReadTextFile;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cmem, cthreads,
 {$ENDIF}
        Classes,
        SysUtils;

Var
        filename: string = 'cake-ipsum.txt';
        stringList: TStringList;
        line: string;

// Main block
Begin

        // Provide user feedback
        WriteLn(Format('Reading ''%s''', [filename]));
        WriteLn('--------------------');

        // Start try..except
        Try
                // Create the TSTringList object
                stringList := TStringList.Create;

                // Start try..finally
                Try
                        // Read the file into a TStringList
                        stringList.LoadFromFile(filename);

                        // Use for loop to read the content of the stringList
                        For line in stringList Do
                                WriteLn(line);

                Finally
                        // Free object from memory
                        stringList.Free;
                End;

        Except
                on E: Exception Do
                        WriteLn('File handling error occurred. Details: ', E.Message);
        End; // end of try..except

        // Pause console
        WriteLn('--------------------');
        WriteLn('Press Enter key to quit.');
        ReadLn;

End.
