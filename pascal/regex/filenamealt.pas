Program MatchingFilenameAlt;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cthreads,
 {$ENDIF}
        Classes,
        SysUtils,
        RegExpr;

// A function for matching filename against a regex pattern
Function IsFileNameMatching (Const fileName: string; Const regexPattern: string): boolean;
Var
        regex: TRegExpr;
Begin
        regex := TRegExpr.Create;
        Try
                // Set the regex to case-insensitive
                regex.ModifierI := True;
                // Apply the regex pattern
                regex.Expression := regexPattern;
                // Check for a match
                If regex.Exec(filename) Then
                        Result := True
                Else
                        Result := False;
        Finally
                // Free TRegExpr
                regex.Free;
        End;
End;

Var
        regexPattern: string = '\w*.txt$';
        filename: string = 'hello-text.txt';

Begin
        If IsFileNameMatching(filename, regexPattern) Then
                WriteLn(Format('%s matches %s!', [regexPattern, filename]))
        Else
                WriteLn(Format('%s does not match %s!', [regexPattern, filename]));

        //Pause console
        WriteLn('Press Enter kay to exit ...');
        ReadLn;
End.
