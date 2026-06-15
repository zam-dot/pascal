Program TFileStreamCreateBlankTextFile;

{$mode objfpc}{$H+}{$J-}

Uses
        Classes, SysUtils;

Var
        fileName: String;
        fileStream: TFileStream;

Begin
        fileName := 'hello-text.txt';

        Try
                // Create a new file without writing anyting into it
                fileStream := TFileStream.Create(fileName, fmCreate);

                // Show a confirmation
                Writeln('Created a blank file: ', fileName);
        Finally
                // Free resources
                fileStream.Free;
        End;
End.
