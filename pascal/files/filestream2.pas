Program TFileStreamAppendTextFile;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cthreads,
 {$ENDIF}
        Classes,
        SysUtils;

Var
        filename: string = 'hello-text.txt';
        fileStream: TFileStream;
        size: longint;
        newText: string;

Begin

        // First, does the file exist?
        If FileExists(fileName) Then
                // If yes, open the file in append mode.
                fileStream := TFileStream.Create(filename, fmOpenWrite or fmShareDenyNone)
        Else
                // If not, create a a new file.
                fileStream := TFileStream.Create(filename, fmCreate);

        // Next, start appending.
        Try
                // set position at the end of the file
                fileStream.Seek(0, soFromEnd);
                // Write text into the file
                newText := LineEnding + 'A new line!';
                size := fileStream.Write(newText[1], Length(newText));
                // Show confirmation
                Writeln(Format('Appended %s. %d bytes written.', [filename, size]));
        Finally
                // Free TFileStream object
                fileStream.Free;
        End;

        // Pause console
        WriteLn('Press Enter to quit.');
        ReadLn;
End.
