Program DateTimeBenchmark;
{$mode objfpc}{$H+}{$J-}

Uses
        SysUtils;

Var
        startTime, endTime: QWord;

Begin

        // Get start time.
        startTime := GetTickCount64;

        // Simulate a long running task
        Sleep(1000);

        // Get end time
        endTime := GetTickCount64;

        // Display time elapsed
        Writeln('Time elapsed: ', (endTime - startTime), ' ms');

End.
