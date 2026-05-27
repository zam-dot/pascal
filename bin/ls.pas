program ListFiles;

{$mode objfpc}{$H+}

uses
    SysUtils,
    Classes;

const
    ColorDir = #27'[33m';
    ColorFile = #27'[36m';
    ColorReset = #27'[0m';

function MatchesPattern(Filename, Pattern: string): boolean;
var
    i, p: integer;
    patternPart: string;
begin
    Result := True;

    if Pattern = '*' then
        Exit;

    if Pos('?', Pattern) > 0 then
    begin
        if Length(Filename) <> Length(Pattern) then
            Exit(False);
        for i := 1 to Length(Pattern) do
        begin
            if (Pattern[i] <> '?') and (Pattern[i] <> Filename[i]) then
                Exit(False);
        end;
        Exit(True);
    end;

    p := Pos('*', Pattern);
    if p = 0 then
    begin
        Result := (Filename = Pattern);
    end
    else if p = 1 then
    begin
        patternPart := Copy(Pattern, 2, Length(Pattern));
        if patternPart = '' then
            Result := True
        else
            Result := Pos(patternPart, Filename) > 0;
    end
    else if p = Length(Pattern) then
    begin
        patternPart := Copy(Pattern, 1, p - 1);
        Result := Pos(patternPart, Filename) = 1;
    end
    else
    begin
        Result := (Pos(Copy(Pattern, 1, p - 1), Filename) = 1) and
            (Pos(Copy(Pattern, p + 1, Length(Pattern)), Filename) >= p);
    end;
end;

var
    searchRec: TSearchRec;
    targetPath, searchPath, searchPattern: string;
    dirs, files: TStringList;
    i:      integer;
    sizeKB: double;
begin
    // Handle shell-expanded wildcards (multiple parameters)
    if ParamCount > 1 then
    begin
        // Multiple parameters means shell expanded the wildcard
        // Just list each file/directory directly
        for i := 1 to ParamCount do
        begin
            targetPath := ParamStr(i);

            // Expand tilde if present
            if (Length(targetPath) > 0) and (targetPath[1] = '~') then
                targetPath := GetEnvironmentVariable('HOME') + Copy(targetPath, 2, Length(targetPath));

            if DirectoryExists(targetPath) then
                WriteLn(ColorDir + #9'DIR  ' + targetPath + '/' + ColorReset)
            else if FileExists(targetPath) then
            begin
                if FindFirst(targetPath, faAnyFile, searchRec) = 0 then
                begin
                    sizeKB := searchRec.Size / 1024;
                    WriteLn(Format(' %7.1f KB ', [sizeKB]), ' ',
                        ColorFile, ExtractFileName(targetPath), ColorReset);
                    FindClose(searchRec);
                end;
            end
            else
                WriteLn('Warning: ', targetPath, ' does not exist');
        end;
        Exit;
    end;

    // Single parameter case - could be literal pattern or directory
    if ParamCount = 0 then
    begin
        searchPath := '.';
        searchPattern := '*';
    end
    else
    begin
        targetPath := ParamStr(1);

        // Expand tilde
        if (Length(targetPath) > 0) and (targetPath[1] = '~') then
            targetPath := GetEnvironmentVariable('HOME') + Copy(targetPath, 2, Length(targetPath));

        // Check what we have
        if DirectoryExists(targetPath) then
        begin
            // It's a directory - list its contents
            searchPath := targetPath;
            searchPattern := '*';
        end
        else if FileExists(targetPath) then
        begin
            // It's a single file - show just that file
            searchPath := ExtractFilePath(targetPath);
            if searchPath = '' then
                searchPath := '.'
            else
                searchPath := ExcludeTrailingPathDelimiter(searchPath);
            searchPattern := ExtractFileName(targetPath);
        end
        else if (Pos('*', targetPath) > 0) or (Pos('?', targetPath) > 0) then
        begin
            // It's a pattern
            searchPattern := ExtractFileName(targetPath);
            searchPath := ExtractFilePath(targetPath);
            if searchPath = '' then
                searchPath := '.'
            else
                searchPath := ExcludeTrailingPathDelimiter(searchPath);
        end
        else
        begin
            // Doesn't exist - treat as pattern anyway
            WriteLn('Warning: ', targetPath, ' does not exist');
            Halt(1);
        end;
    end;

    dirs := TStringList.Create;
    files := TStringList.Create;

    try
        if FindFirst(searchPath + PathDelim + '*', faAnyFile, searchRec) = 0 then
        begin
            repeat
                if (searchRec.Name <> '.') and (searchRec.Name <> '..') then
                begin
                    if MatchesPattern(searchRec.Name, searchPattern) then
                    begin
                        if (searchRec.Attr and faDirectory) <> 0 then
                            dirs.Add(searchRec.Name)
                        else
                        begin
                            sizeKB := searchRec.Size / 1024;
                            files.Add(searchRec.Name + '|' + FloatToStr(sizeKB));
                        end;
                    end;
                end;
            until FindNext(searchRec) <> 0;
            FindClose(searchRec);

            dirs.Sort;
            files.Sort;

            for i := 0 to dirs.Count - 1 do
                WriteLn(ColorDir + #9'DIR  ' + dirs[i] + '/' + ColorReset);

            for i := 0 to files.Count - 1 do
            begin
                Write(Format(' %7.1f KB ', [StrToFloat(Copy(files[i], Pos('|', files[i]) + 1, MaxInt))]));
                Write(' ');
                WriteLn(ColorFile + Copy(files[i], 1, Pos('|', files[i]) - 1) + ColorReset);
            end;

            if (dirs.Count = 0) and (files.Count = 0) then
                WriteLn('No matches found for: ', searchPattern);
        end
        else
            WriteLn('Error: Could not list directory: ', searchPath);
    finally
        dirs.Free;
        files.Free;
    end;
end.
