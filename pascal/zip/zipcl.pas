Program ZipEx02;

{$mode objfpc}{$H+}{$J-}

// Usage:
// ZipEx02 newzip.zip file1.txt file2.txt

Uses
        Zipper;

Var
        zip: TZipper;
        index: integer;

Begin
        zip := TZipper.Create;
        Try
                // Define the file name of the zip file to be created
                zip.FileName := ParamStr(1);
                For index := 2 To ParamCount Do
                        // First argument: the names of the files to be included in the zip
                        // Second argument: the name of the file as it appears in the zip and
                        // later in the file system after unzipping
                        zip.Entries.AddFileEntry(ParamStr(index), ParamStr(index));
                // Execute the zipping operation and write the zip file.
                zip.ZipAllFiles;
        Finally
                zip.Free;
        End;
End.
