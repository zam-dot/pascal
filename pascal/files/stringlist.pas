Program TStringListNewTextFile;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cthreads,
 {$ENDIF}
        Classes;

Var
        textFileName: string = 'hello-text.txt';
        stringList: TStringList;

Begin

        // Create TStringList object
        stringList := TStringList.Create;
        Try
                // Add lines
                stringList.Add('Hello Line 1!');
                stringList.Add('Hello Line 2!');

                // Save to a file
                stringList.SaveToFile(textFileName);
        Finally
                // Free object
                stringList.Free;
        End;

        // Pause Console
        WriteLn('Press Enter key to exit ...');
        ReadLn;

End.
