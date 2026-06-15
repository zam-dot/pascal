Program RandomRealNumberBetween;
{$mode objfpc}{$H+}{$J-}

Function RandomNumberBetween (Const min, max: real): real;
Begin
        Result := Random * (max - min) + min;
End;

Var
        randomRealNumber: real;
        min, max: real;

Begin
        min := 1.0;
        max := 10.0;

        // Initialise random number generator
        Randomize;

        // Get a random (real) number between min and max
        randomRealNumber := RandomNumberBetween(min, max);

        WriteLn('Random real number between ', min: 0: 6, ' and ', max: 0: 6, ' is: ', randomRealNumber: 0: 6);

End.
