Program StaticArrayDemo01;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cmem, cthreads,
 {$ENDIF}
        Classes;

Type
        // Declaring a static array in the type-section.
        TByteArray = Array [1..5] Of byte; // size is 5

Var
        // Creating an array var based on a type.
        // You can assign initial values here too.
        studentGrades: TByteArray;

        // Declaring an array type in the var section.
        multipleTen: Array [0..9] Of integer; // size is 10

        // Declaring static array and init values in the var-section.
        osChoices: Array [1..3] Of string = ('Linux', 'MacOS', 'Windows');

        index: integer; // a var for loops

Begin
        // Assign a value to an array's element by using a valid index value
        // enclosed in square brackets.
        // Populate student grades
        studentGrades[1] := 95;
        studentGrades[2] := 85;
        studentGrades[3] := 75;
        studentGrades[4] := 55;
        studentGrades[5] := 85;

        // Populate multiple ten
        For index := low(multipleTen) To high(multipleTen) Do
                multipleTen[index] := index * 10;

        // Print the length of the arrays
        WriteLn('The length of grades array     : ', Length(studentGrades));
        WriteLn('The length of osChoices array  : ', Length(osChoices));
        WriteLn('The length of multipleTen array: ', Length(multipleTen));

        WriteLn('-------------------');

        // Print an element from each array
        WriteLn('Grade of student 3 in the array : ', studentGrades[3]);
        WriteLn('First choice of OS the array    : ', osChoices[1]);
        WriteLn('The Last multiple of 10 in array: ', high(multipleTen));

        WriteLn('-------------------');

        // Print all elements from each array
        WriteLn('-- Student grades array');
        For index := low(studentGrades) To high(studentGrades) Do
                WriteLn('Student ', index, ' scored ', studentGrades[index]);

        WriteLn('-- Multiple of ten array');
        For index := low(multipleTen) To high(multipleTen) Do
                WriteLn('Index  ', index, ' contains ', multipleTen[index]);

        WriteLn('-- OS choices array');
        For index := low(osChoices) To high(osChoices) Do
                WriteLn('OS choice no ', index, ' is ', osChoices[index]);

        // Pause console
        WriteLn('-------------------');
        WriteLn('Press enter to quit');
        ReadLn;
End.
