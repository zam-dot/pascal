Program TFileStreamSplitFile;

{
 This program splits a text file based on a chunkSize.
 The algorithm ensures it won't split the text in the middle of a line/paragraph.

 1. Open the file and allocate memory bufers for reading chunks of data.

 2. Read the file in chunks and locate the last `\n` character in the chunk.
    Once it locates the last `\n` in the chunk, move the file pointer back to include
    that byte and any preceding bytes of the partial line in the next chunk's read operation.

 3. Repeat - read and parse the remainder.

 4. Once parsing is complete, close the file and free any allocated memory (to prevent memory leaks).
}

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cmem, cthreads,
 {$ENDIF}
        SysUtils,
        Classes,
        bufstream;

Procedure SaveChunkToFile (Const filename: string; Const chunkData: pansichar;
Const dataSize: integer; Const chunkIndex: integer);
Var
        chunkFile: TFileStream;
Begin
        // Create a new file for the chunk
        chunkFile := TFileStream.Create(filename + '-chunk-' + IntToStr(ChunkIndex) +
        '.txt', fmCreate);
        Try
                // Write the chunk data to the chunk file
                chunkFile.WriteBuffer(chunkData^, dataSize);
        Finally
                chunkFile.Free;
        End;
End;

Const
        defaultChunkSize: integer = 1048576; // 1 MB in bytes

Var
        fileStream: TFileStream;
        buffer: pansichar;
        bytesRead, totalBytesRead, chunkSize, lineBreakPos, chunkIndex: int64;

Begin

        If not FileExists(ParamStr(1)) Then
        Begin
                WriteLn('Please spefcify a valid text file.');
                Exit;
        End;

        chunkSize := defaultChunkSize * 1;

        // Open the file for reading
        fileStream := TFileStream.Create(ParamStr(1), fmOpenRead);
        Try
                // Allocate memory buffer for reading chunks
                // Ref: https://www.freepascal.org/docs-html/rtl/system/getmem.html
                GetMem(buffer, chunkSize);
                Try
                        totalBytesRead := 0;
                        chunkIndex := 0;

                        // Read and parse chunks of data until EOF
                        While totalBytesRead < fileStream.Size Do
                        Begin
                                bytesRead := fileStream.Read(buffer^, chunkSize);
                                Inc(totalBytesRead, bytesRead);

                                // Find the position of the last newline character in the chunk
                                lineBreakPos := BytesRead;
                                While (lineBreakPos > 0) and (Buffer[lineBreakPos - 1] <> #10) Do
                                        Dec(lineBreakPos);

        { Now, must ensure that if the last byte read in the current chunk
          is not a newline character, the file pointer is moved back to include
          that byte and any preceding bytes of the partial line in the next
          chunk's read operation.

          Also, no need to update the BytesRead variable in this context because
          it represents the actual number of bytes read from the file, including
          any partial line that may have been included due to moving the file
          pointer back.
          Ref: https://www.freepascal.org/docs-html/rtl/classes/tstream.seek.html}
                                If lineBreakPos < bytesRead Then
                                        fileStream.Seek(-(bytesRead - lineBreakPos), soCurrent);

                                // Write the chunk data to a file using the separate procedure
                                SaveChunkToFile('output', buffer, lineBreakPos, chunkIndex);

                                // Display user feedback
                                WriteLn('Chunk ', chunkIndex, ', Total bytes read:', IntToStr(totalBytesRead));

                                // Increase chunk index - a counter
                                Inc(chunkIndex);
                        End;
                Finally
                        // Free the memory buffer
                        FreeMem(buffer);
                End;
        Finally
                // Close the file
                fileStream.Free;
        End;
End.
