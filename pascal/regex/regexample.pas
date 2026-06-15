Program RegexExample;

// Program will quit when you give a text input matching regex pattern
// in the program's argument.

// For example.
// $ RegexExample.exe "(\d{1,4})[-/.](\d{1,2}|[a-zA-Z]{3,})[-/.](\d{1,4})"

// Enter a text:24-Mar-2024
// Matches!
// Note! Match[0] is the entire match!
// Match 0 : 24-Mar-2024
// Match 1 : 24
// Match 2 : Mar
// Match 3 : 2024
// $

{$mode objfpc}{$H+}{$J-}

Uses
        RegExpr;

Var
        re: TRegExpr;
        input: string;
        i:  integer;
Begin

        // If user input is '', exit program
        If ParamStr(1) = '' Then Exit;

        // Create the regex object using first argument of the program
        re := TRegExpr.Create(ParamStr(1));
        Try
                // Set regex flag to case-insensitive
                re.ModifierI := True;
                // Keep on asking the user until there is a match
                Repeat
                        WriteLn;
                        Write('Enter a text:');
                        ReadLn(input);
                        // If there is a match, and match[0] (global) is not '', show all matches
                        If re.Exec(input) and (re.Match[0] <> '') Then
                        Begin
                                WriteLn('Matches!');
                                WriteLn('Note! Match[0] is the entire match!');
                                // Loop through matches using re.Matches[i]
                                i := 0;
                                While re.Match[i] <> '' Do
                                Begin
                                        WriteLn('Match ', i, ' : ', re.Match[i]);
                                        Inc(i);
                                End;
                        End
                        Else
                                WriteLn('No match, try again.');
                Until re.Match[0] <> '';
        Finally
                // Free TRegExpr object
                re.Free;
        End;
End.
