Program DateTimeUnix;

Uses
        SysUtils,
        DateUtils;

Var
        unixTime: integer;

Begin
        unixTime := DateTimeToUnix(Now);
        Writeln('Current time in Unix epoch time is: ', unixTime);

        // Pause console;
        ReadLn;
End.
