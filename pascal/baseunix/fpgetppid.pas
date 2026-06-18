
program MyProgram;
{$mode objfpc}{$H+}{$J-}

{ FpGetppid returns the process ID of the parent process. }

uses baseunix;

begin
    writeln('Process id: ', fpgetpid, ' Parent process id: ', fpgetppid);
    writeln('OWNER: ', FpGetPriority(PRIO_PROCESS, 0));
    writeln('USER: ', FpGetPriority(PRIO_USER, 0));
end.
