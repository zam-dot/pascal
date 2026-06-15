Program ZipEx01;

{$mode objfpc}{$H+}{$J-}

Uses
        zipper;

Var
        zip: TZipper;

Begin
        zip := TZipper.Create;
        Try
                zip.FileName := 'simple.zip';
                zip.Entries.AddFileEntry('file1.txt');
                zip.Entries.AddFileEntry('file2.txt');
                zip.ZipAllFiles;
        Finally
                zip.Free;
        End;
        WriteLn('File zipped successfully.');
End.
