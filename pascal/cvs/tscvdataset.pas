Program TCSVDatasetGetSpecificCols;

{
 An example of listing the content of first two columns in a CSV file
 using TCSVDataset.
}

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cmem, cthreads,
 {$ENDIF}
        Classes,
        SysUtils,
        streamex,
        bufstream,
        csvdataset;

// A routine to list first two columns of a CSV file
Procedure ReadCSV (filename: string;
delimiter: char = ',';
isFirstRowFieldName: boolean = False);
Var
        fileStream: TFileStream;
        buffStream: TReadBufStream;
        csvDataset: TCSVDataset;
        lineNo: int64;
Begin
        fileStream := TFileStream.Create(filename, fmOpenRead);
        Try
                buffStream := TReadBufStream.Create(fileStream, 65536);
                Try
                        csvDataset := TCSVDataset.Create(nil);
                        Try

                                // Assign a valid delimiter
                                csvDataset.CSVOptions.Delimiter := delimiter;

                                // Is the first line field names?
                                // If yes, first row will be excluded when listing rows
                                csvDataset.CSVOptions.FirstLineAsFieldNames := isFirstRowFieldName;

                                // Load CSV from the stream
                                csvDataset.LoadFromCSVStream(buffStream);

                                // Move to first record
                                csvDataset.First;

                                lineNo := 1;

                                While not csvDataset.EOF Do
                                Begin
                                        // Get the values of the first two fields here and list them.
                                        WriteLn(Format('row %d: %s, %s',
                                        [lineNo,
                                        csvDataset.Fields[0].AsString,
                                        csvDataset.Fields[1].AsString]));

                                        // Move to next
                                        csvDataset.Next;

                                        // Increment line no
                                        lineNo := lineNo + 1;
                                End;

                        Finally
                                csvDataset.Free;
                        End;
                Finally
                        buffStream.Free;
                End;
        Finally
        End;
        fileStream.Free;
End;

Var
        filename: string;

Begin

        filename := ParamStr(1);
        If not FileExists(filename) Then
        Begin
                WriteLn('Cannot find file.');
                Exit;
        End;

        ReadCSV(filename, ';', False);
End.
