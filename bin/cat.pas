program cat;
{test}
{$mode objfpc}{$H+}{$J-}

uses
    SysUtils,
    BaseUnix;

const
    BUFFER_SIZE = 8192;  // 8KB buffer - good performance balance
    COLOR_RESET = #27'[0m';
    COLOR_ERROR = #27'[31m';  // Red for errors

var
    i: integer;
    filename: string;
    showLineNumbers: boolean = False;
    showNonPrinting: boolean = False;
    lineNum: integer = 0;

procedure ShowHelp;
begin
    WriteLn('Usage: cat [OPTIONS] [FILE...]');
    WriteLn('Concatenate files to standard output.');
    WriteLn;
    WriteLn('Options:');
    WriteLn('  -n      Number output lines');
    WriteLn('  -v      Show non-printing characters (^A for Ctrl-A, etc.)');
    WriteLn('  -h      Show this help');
    WriteLn('  --help  Show this help');
    WriteLn;
    WriteLn('If no file is specified, reads from standard input.');
end;

procedure WriteWithEscapes (const s: string);
var
    j: integer;
    c: char;
begin
    if not showNonPrinting then
        Write(s)
    else for j := 1 to Length(s) do
        begin
            c := s[j];
            case c of
                #0: Write('^@');
                #1..#26: Write('^', Chr(Ord(c) + 64));
                #27: Write('^[');
                #28: Write('^\');
                #29: Write('^]');
                #30: Write('^^');
                #31: Write('^_');
                #127: Write('^?');
            else
                if (Ord(c) < 32) or (Ord(c) > 126) then
                    Write('M-', Chr(Ord(c) - 128))
                else
                    Write(c);
            end;
        end;
end;

procedure ProcessFile (const fname: string);
var
    f: file of byte;
    totalBytes: int64 = 0;
    buf: array[0..BUFFER_SIZE - 1] of byte;
    Count: longint;
    lineStart: boolean = True;
    s: string;
    j: integer;
begin
    if fname = '-' then
    begin
        // Read from stdin
        while not EOF(input) do
        begin
            ReadLn(input, s);
            if showLineNumbers then
            begin
                Inc(lineNum);
                Write(lineNum: 6, '  ');
            end;
            WriteWithEscapes(s);
            WriteLn;
            lineStart := True;
        end;
        Exit;
    end;

    // Binary file reading with proper buffering
    Assign(f, fname);
    {$I-}
    Reset(f);
    {$I+}

    if IOResult <> 0 then
    begin
        WriteLn(COLOR_ERROR, 'cat: ', fname, ': No such file or directory', COLOR_RESET);
        Exit;
    end;

    try
        while not EOF(f) do
        begin
            BlockRead(f, buf, BUFFER_SIZE, Count);
            if Count > 0 then
            begin
                // Process buffer for line numbers and escapes
                if showLineNumbers or showNonPrinting then
                begin
                    for j := 0 to Count - 1 do
                    begin
                        if showLineNumbers and lineStart then
                        begin
                            Inc(lineNum);
                            Write(lineNum: 6, '  ');
                            lineStart := False;
                        end;

                        if buf[j] = 10 then // Newline
                        begin
                            WriteLn;
                            lineStart := True;
                        end
                        else if showNonPrinting then
                        begin
                            if buf[j] < 32 then
                                Write('^', Chr(buf[j] + 64))
                            else if buf[j] = 127 then
                                Write('^?')
                            else
                                Write(Chr(buf[j]));
                        end
                        else
                            Write(Chr(buf[j]));
                    end;
                end
                else
                    FileWrite(StdOutputHandle, buf, Count)// Fast path - direct write
                ;
                Inc(totalBytes, Count);
            end;
        end;
    finally
        Close(f);
    end;
end;

begin
    // Parse command line arguments
    i := 1;
    while i <= ParamCount do
    begin
        filename := ParamStr(i);

        if (filename = '-h') or (filename = '--help') then
        begin
            ShowHelp;
            Halt(0);
        end
        else if filename = '-n' then
            showLineNumbers := True
        else if filename = '-v' then
            showNonPrinting := True
        else if filename = '--' then
        begin
            // End of options
            Inc(i);
            Break;
        end
        else if filename[1] = '-' then
        begin
            WriteLn(COLOR_ERROR, 'cat: unknown option: ', filename, COLOR_RESET);
            ShowHelp;
            Halt(1);
        end
        else
            Break;  // First non-option is a file

        Inc(i);
    end;

    // Process files
    if i > ParamCount then
        ProcessFile('-')// No files specified - read from stdin

    else while i <= ParamCount do
        begin
            ProcessFile(ParamStr(i));
            Inc(i);
        end;
end.
