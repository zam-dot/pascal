Program TFileStreamNewTextFileOrganised;

{$mode objfpc}{$H+}{$J-}

Uses
        Classes, SysUtils;

// Write text into a new file
Procedure WriteStreamToFile (fileName: string; text: string);
Var
        fileStream: TFileStream;
        size: longint;
Begin
        fileStream := TFileStream.Create(fileName, fmCreate);
        Try
                // set position at the beginning og file
                fileStream.Position := 0;
                // Write text into the file
                size := fileStream.Write(text[1], Length(text));
                // Show confirmation
                Writeln(Format('Created %s. %d bytes written.', [filename, size]));
        Finally
                // Free TFileStream object
                fileStream.Free;
        End;
End;

Var
        myText: string = 'QILT Surveys';
        filename: String = 'hello-text.txt';

Begin

        WriteStreamToFile(filename, myText);

        ReadLn;
End.
