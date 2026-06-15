Program ClassicNewTextFileSimple;

{$mode objfpc}{$H+}{$J-}

Var
        textFile: System.TextFile;

Begin
        AssignFile(textFile, 'output_file.txt');
        ReWrite(textFile);
        WriteLn(textFile, 'This is a new line');
        CloseFile(textFile);
End.
