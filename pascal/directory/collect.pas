Program CollectFilePaths;

{$mode objfpc}{$H+}{$J-}

// Collects file paths from command line arguments
// Usage: CollectFilePaths <file|directory> [file|directory] ...
// Example: CollectFilePaths test.txt src/ libs/

Uses
        SysUtils, Generics.Collections;

Type
        // Generic list to store file paths
        TFilePathList = Specialize TList<string>;

// Recursively collects file paths from a directory and its subdirectories
// @param BaseDir: Directory to scan
// @param Files: List to store the found file paths
Procedure CollectFilesFromDirectory (Const BaseDir: string; Files: TFilePathList);
Var
        searchRec: TSearchRec;
        findResult: Integer;
        fullPath:  string;
Begin
        // Ensure directory path ends with path separator
        fullPath := IncludeTrailingPathDelimiter(BaseDir);

        // Start directory scan
        findResult := FindFirst(fullPath + '*.*', faAnyFile, searchRec);
        Try
                While findResult = 0 Do
                Begin
                        // Skip current and parent directory entries
                        If (searchRec.Name <> '.') and (searchRec.Name <> '..') Then
                                If (searchRec.Attr and faDirectory) = faDirectory Then
                                        CollectFilesFromDirectory(fullPath + searchRec.Name, Files)// Recursively process subdirectories

                                Else
                                        Files.Add(fullPath + searchRec.Name)// Add file path to the list
                                // Check if current item is a directory
                        ;
                        findResult := FindNext(searchRec);
                End;
        Finally
                // Always close the search handle
                FindClose(searchRec);
        End;
End;

Var
        filePaths: TFilePathList;
        index: integer;
        path:  string;

// Main Block
Begin
        // Create list to store all file paths
        filePaths := TFilePathList.Create;
        Try
                // Validate command line parameters
                If ParamCount < 1 Then
                Begin
                        WriteLn('Usage: ', ExtractFileName(ParamStr(0)), ' <file|directory> [file|directory] ...');
                        Exit;
                End;

                // Process each command line argument
                For index := 1 To ParamCount Do
                Begin
                        path := ParamStr(index);

                        // Skip invalid paths
                        If not FileExists(path) and not DirectoryExists(path) Then
                        Begin
                                WriteLn('Warning: ''', path, ''' does not exist. Skipping...');
                                Continue;
                        End;

                        // Handle directories and files differently
                        If DirectoryExists(path) Then
                                CollectFilesFromDirectory(path, filePaths)// Recursively collect all files from directory

                        Else
                                filePaths.Add(ExtractFileName(path))// Add single file to list (filename only)
                        ;
                End;

                // Output results
                WriteLn('Collected paths:');
                WriteLn('---------------');
                For path in filePaths Do
                        WriteLn(path);

                WriteLn;
                WriteLn('Total files found: ', filePaths.Count);

        Finally
                // Clean up
                filePaths.Free;
        End;
End.
