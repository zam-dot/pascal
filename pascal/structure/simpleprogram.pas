Program SimpleProgram;

{$mode objfpc}{$H+}{$J-}

Uses
 {$IFDEF UNIX}
        cthreads,
 {$ENDIF}
        Classes,
        SysUtils;

Const
        student_id_prefix: string = 'ua-';

Type
        TStudent = Record
                studentId: string;
                firstname: string;
                lastname: string;
        End;

// Prints the contents of a TStudent var
Procedure PrintStudentInfo (student: TStudent);
Begin
        WriteLn(student.studentId);
        WriteLn(student.firstname, ' ', student.lastname);
End;

Var
        test: integer; // test
        myStudent: TStudent; // test

Begin
        // The Main block/entry of the program

        WriteLn('Now : ', DateToStr(Now));

        myStudent.firstname := 'John';
        myStudent.lastname := 'Costco';
        myStudent.studentId := student_id_prefix + '2227209';
        PrintStudentInfo(myStudent);

        // Pause console
        WriteLn('Press Enter key to quit ...');
        ReadLn();
End.
