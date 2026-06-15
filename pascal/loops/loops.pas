Program Loops;

  {$mode objfpc}{$H+}{$J-}

Var
        intArray: Array [0..2] Of integer = (10, 20, 30);
        strArray: Array Of string = ('Apple', 'Banana', 'Cirtus');
        i, j: integer; // vars for iteration
        item: string;  // var for iterating a collection of string
        c: char = char(0);
Begin

        // 1a. For Loop -------------------------------
        For i := 0 To 2 Do
                WriteLn('For Loop: Value of i is ', intArray[i]);

        WriteLn('--------------------');

        // 1b. For Loop using low & high --------------
        For i := low(intArray) To high(intArray) Do
                WriteLn('For Loop with low & high: ', intArray[i]);

        WriteLn('--------------------');

        //2a. For-In Loop -----------------------------
        For i in intArray Do
                WriteLn('For-In Loop - integer: ', i);

        //2b. For-In Loop -----------------------------
        For item in strArray Do
                WriteLn('For-In Loop - string: ', item);

        WriteLn('--------------------');

        // 3. While Loop ------------------------------
        j := 0;
        While j <= 5 Do
        Begin
                WriteLn('While Loop from 0 until 5: ', j);
                Inc(j);
        End;

        WriteLn('--------------------');

        // 4. Repeat Until Loop -----------------------
        Repeat
                Write('Repeat Until Loop: What is the next letter after ''a''? ');
                ReadLn(c);
        Until c = 'b';
        WriteLn('Yes, b is the correct answer');

        WriteLn('--------------------');

        // 5. An example of a Nested Loops
        For item in strArray Do
                For i := low(intArray) To high(intArray) Do
                        Writeln('Nested Loops: For ', item, ', You can buy in pack of ', intArray[i]);

        WriteLn('--------------------');

        // Pause console
        ReadLn;
End.
