Program TFileStreamNewTextFile;

{$mode objfpc}{$H+}{$J-}

Uses
        Classes, SysUtils;

Var
        text: string = 'QILT Surveys';
        filename: String = 'hello-text.txt';
        fileStream: TFileStream;
        size: longint;

Begin
        // Create a TFileStream object
        fileStream := TFileStream.Create(filename, fmCreate);
        Try
                // set position at the beginning of file
                fileStream.Position := 0;
                // Write text into the file
                size := fileStream.Write(text[1], Length(text));
                // Show confirmation
                Writeln(Format('Created %s. %d bytes written.', [filename, size]));
        Finally
                // Free TFileStream object
                fileStream.Free;
        End;

        // Pause console
        ReadLn;
End.
