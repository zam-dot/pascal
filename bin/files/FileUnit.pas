unit FileUnit;
{$mode objfpc}{$H+}
{$WARN 6058 off}

interface

uses
        BaseUnix,
        Unix;

type
        TFile = record
                Handle: cint;
        end;

{ --- Utility Functions: Low-level wrappers for Kernel operations --- }
function FileOpen (const Path: string; Flags: integer): TFile;
procedure FileClose (var F: TFile);
function FileRead (var F: TFile; Buffer: Pointer; Count: SizeInt): SizeInt;
function FileWrite (var F: TFile; Buffer: Pointer; Count: SizeInt): SizeInt;

function OctalToCardinal (s: string): cardinal;
function ChangePermission (const AFileName: string; AMode: cardinal): boolean; overload;
function ChangePermission (const AFileName: string; AModeStr: string): boolean; overload;
function CheckFileAccess (pathname: string; mode: integer): boolean;

{ --- Task Functions: High-level operations that manage file lifecycles --- }
procedure ReadFromHandle (const Path: string);
procedure PrintFileContents (var F: TFile);

const
        F_OK = 0;        // File exists.
        X_OK = 1;        // Execute permission.
        W_OK = 2;        // Write permission.
        R_OK = 4;        // Read permission.
        O_APPEND = 1024; // Open for append.

implementation

function FileOpen (const Path: string; Flags: integer): TFile;
begin
        Result.Handle := fpOpen(Path, Flags);
end;

procedure FileClose (var F: TFile);
begin
        if F.Handle >= 0 then
        begin
                fpClose(F.Handle);
                F.Handle := -1;
        end;
end;

function FileRead (var F: TFile; Buffer: Pointer; Count: SizeInt): SizeInt;
begin
        if F.Handle < 0 then
                Exit(-1);
        Result := fpRead(F.Handle, Buffer^, Count);
end;

function FileWrite (var F: TFile; Buffer: Pointer; Count: SizeInt): SizeInt;
begin
        if F.Handle >= 0 then
                Result := fpWrite(F.Handle, Buffer^, Count)
        else
                Result := -1;
end;

procedure ReadFromHandle (const Path: string);
var
        F: TFile;
begin
        F := FileOpen(Path, R_OK);

        if F.Handle < 0 then
                WriteLn('Error: Could not open ', Path, ' (Errno: ', fpGetErrno, ')')
        else begin
                PrintFileContents(F);
                FileClose(F);
        end;
end;

procedure PrintFileContents (var F: TFile);
var
        Buffer: array[0..4095] of byte;
        BytesRead: SizeInt;
begin
        if F.Handle < 0 then Exit;
        repeat
                BytesRead := FileRead(F, @Buffer[0], SizeOf(Buffer));
                if BytesRead > 0 then
                        fpWrite(1, @Buffer[0], BytesRead);
        until BytesRead <= 0;
end;

function OctalToCardinal (s: string): cardinal;
var i: integer;
begin
        Result := 0;
        for i := 1 to Length(s) do
                if (s[i] in ['0'..'7']) then
                        Result := (Result * 8) + (ord(s[i]) - ord('0'));
end;

function ChangePermission (const AFileName: string; AMode: cardinal): boolean;
begin
        Result := (fpChmod(AFileName, AMode) = 0);
end;

function ChangePermission (const AFileName: string; AModeStr: string): boolean;
begin
        // This calls the version above it!
        Result := ChangePermission(AFileName, OctalToCardinal(AModeStr));
end;

function CheckFileAccess (pathname: string; mode: integer): boolean;
begin
        Result := (fpAccess(pathname, mode) = 0);
end;

end.
