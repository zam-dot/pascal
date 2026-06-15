Program RandomNumberBetween;

{$mode objfpc}{$H+}{$J-}

Function RandomBetween (Const min, max: integer): integer;
Begin
        Result := Random(max - min + 1) + min;
End;

Var
        randomNumber: integer;
        min, max: integer;

Begin
        min := 1;
        max := 10;

        // Initialise the randeom number generator
        Randomize;

        randomNumber := RandomBetween(2, 10);

        WriteLn('Random number between ', min, ' and ', max, ' is: ', randomNumber);
End.
