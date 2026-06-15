Program TStringListBlankFIle;

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
