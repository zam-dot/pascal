Program ZipEx03;

{$mode objfpc}{$H+}{$J-}

// Usage:
// ZipEx03 output_zip.zip input_file1.txt input_file2.txt

Uses
        Zipper;

// A function that takes 2 arguments.
// The first, the name of the zip file to be created.
// The second, an array of file names to be zipped.
Procedure ZipFiles (Const zipFilename: string; Const FilesToZip: Array Of string);
Var
        zip: TZipper;
        index: integer;
Begin
        zip := TZipper.Create;
        Try
                zip.FileName := zipFilename;
                For index := 0 To high(FilesToZip) Do
                        zip.Entries.AddFileEntry(FilesToZip[index], FilesToZip[index]);
                zip.ZipAllFiles;
        Finally
                WriteLn('Success! ', zipFilename, ' has been created!');
                zip.Free;
        End;
End;

Var
        fileIndex, noFiles: integer;
        filesToZip: Array Of string;

// Main block
Begin

        // Check if user specified input files
        noFiles := ParamCount - 1;
        If noFiles < 1 Then
        Begin
                WriteLn('It seems you did not specify input file(s). Please try again.');
                Halt(0);
        End;

        // Build array of input file names
        SetLength(filesToZip, noFiles);
        For fileIndex := 2 To ParamCount Do
                filesToZip[fileIndex - 2] := ParamStr(fileIndex);

        // Optional -- Display info to user
        WriteLn('Output file name: ', ParamStr(1));
        WriteLn('No of files for zipping: ', noFiles);
        For fileIndex := 0 To high(filesToZip) Do
                WriteLn(' - ', filesToZip[fileIndex]);

        // Now, zip the files in the array
        ZipFiles(ParamStr(1), filesToZip);
End.
