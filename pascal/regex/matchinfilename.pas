Program MatchingFilename;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cthreads,
 {$ENDIF}
        Classes,
        SysUtils,
        RegExpr;

Var
        regex: TRegExpr;
        regexPattern: string = '\w*.txt$';
        filename: string = 'hello-text.txt';

Begin
        // Create TRegExpr
        regex := TRegExpr.Create;
        Try
                // Set the regex to case-insensitive
                regex.ModifierI := True;
                // Apply the regex pattern
                regex.Expression := regexPattern;
                // Check for a match
                If regex.Exec(filename) Then
                        WriteLn(Format('''%s'' matches %s!', [regexPattern, filename]))
                Else
                        WriteLn(Format('''%s'' does not match %s!', [regexPattern, filename]));
        Finally
                // Free TRegExpr
                regex.Free;
        End;

        // Pause console
        WriteLn('Press Enter key to exit ...');
        ReadLn;
End.
