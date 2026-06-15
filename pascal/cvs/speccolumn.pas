Program TCSVDocumentGetSpecificCols;


{
 An example of listing the content of first two columns in a CSV file
 using TCSVDocument.
}

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cmem, cthreads,
 {$ENDIF}
        Classes,
        SysUtils,
        csvdocument,
        streamex,
        bufstream;

Procedure ReadCSV (filename: string; delimiter: char);
Var
        fileStream: TFileStream;
        buffStream: TReadBufStream;
        csvReader:  TCSVDocument;
        index, totalLines: int64;
Begin
        totalLines := 0;
        fileStream := TFileStream.Create(filename, fmOpenRead);
        Try
                buffStream := TReadBufStream.Create(fileStream, 65536);
                Try
                        csvReader := TCSVDocument.Create;
                        Try
                                // Assign a delimiter
                                csvReader.Delimiter := delimiter;

                                // Assign a source stream
                                csvReader.LoadFromStream(buffStream);

                                // Get total lines for iteration.
                                totalLines := csvReader.RowCount;

                                // Print the values of first two columns from the CSV file.
                                For index := 0 To totalLines - 1 Do
                                        WriteLn(Format('row %d: %s, %s', [(index + 1),
                                        csvReader.Cells[0, index],
                                        csvReader.Cells[1, index]]));

                        Finally
                                csvReader.Free;
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

        ReadCSV(filename, ';');
End.
