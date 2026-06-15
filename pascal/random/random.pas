Program RandomNumberSimple;

{$mode objfpc}{$H+}{$J-}

Uses
        Math;

Var
        i: integer;

Begin

        // Init the random number generator.
        Randomize;

        // Generate a random number betwen 0 to 100
        i := Random(101);
        WriteLn(i);

        // Pause console
        ReadLn;
End.
