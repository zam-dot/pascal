Program UnzipEx01;

{$mode objfpc}{$H+}{$J-}

Uses
        zipper;

Var
        unZip: TUnZipper;

Begin
        unZip := TUnZipper.Create;
        Try
                unZip.FileName := 'simple.zip';
                unZip.OutputPath := 'output_folder';
                unZip.UnZipAllFiles;
        Finally
                unZip.Free;
        End;
        WriteLn('File unzipped successfully.');
End.
