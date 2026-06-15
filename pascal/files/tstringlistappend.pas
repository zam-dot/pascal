Program TStringListAppend;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cthreads,
 {$ENDIF}
        Classes,
        SysUtils;

Var
        filename: string = 'hello-text.txt';
        text: TStringList;

Begin

        // First of all, check if the input file exists.
        // It not, exit program early.
        If not FileExists(fileName) Then
        Begin
                WriteLn(Format('File %s does not exist. Press Enter to quit.', [filename]));
                ReadLn;
                Exit;
        End;

        // If file exists, create a TStringList object
        text := TStringList.Create;
        Try
                // Read an existing file into TStringList object
                text.LoadFromFile(filename);

                // Append more text
                text.Add('New line!');
                text.Add('New line!');

                // Save the appended TStringList file
                text.SaveToFile(filename);
                WriteLn(Format('Saved to %s.', [filename]));

        Finally
                // Free object
                text.Free;
        End;

        // Pause Console
        WriteLn('Press Enter to exit.');
        ReadLn;

End.
