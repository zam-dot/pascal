program example28;
uses BaseUnix, DateUtils, SysUtils;

{ ===================================

  FILENAME: lstat.pas
  AUTHOR: rtl

  DESTRIPTION:
  create a file called test.fil and add a symlink 
  to it, like ln -s in linux.

  atime = Access time:       last time the file was read or opened by a program.
  mtime = Modification time: last time the actual contents where changed or saved. *
  ctime = Change time:       last time the files metadata like permission, owner or name was changed.

  =================================== }
var f: text;
    i: byte;
    info: stat;
begin

    assign(f, 'test.fil');
    rewrite(f);
    for i := 1 to 10 do writeln(f, 'Testline #', i);
    close(f);

    if fpstat('test.fil', info) <> 0 then
    begin
        writeln('Fstat failed. Errno: ', fpgeterrno);
        halt(1);
    end;

    writeln;
    writeln('Result of fstat on file ''test.fil''.');
    writeln('Inode: ', #9, info.st_ino);
    writeln('Mode:  ', #9, info.st_mode);
    writeln('nlink: ', #9, info.st_nlink);
    writeln('uid:   ', #9, info.st_uid);
    writeln('gid:   ', #9, info.st_gid);
    writeln('rdev   ', #9, info.st_rdev);
    writeln('Size   ', #9, info.st_size);
    writeln('Blksize', #9, info.st_blksize);
    writeln('Blocks ', #9, info.st_blocks);
    writeln('atime  ', #9, info.st_atime);
    writeln('mtime  ', #9, info.st_mtime);
    writeln('ctime  ', #9, info.st_ctime);
    writeln('atime  ', #9, FormatDateTime('yyyy-mm-dd hh:nn:ss', UnixToDateTime(info.st_atime)));
    writeln('mtime  ', #9, FormatDateTime('yyyy-mm-dd hh:nn:ss', UnixToDateTime(info.st_mtime)));
    writeln('ctime  ', #9, FormatDateTime('yyyy-mm-dd hh:nn:ss', UnixToDateTime(info.st_ctime)));

    if fpSymLink('test.fil', 'test.lnk') <> 0 then
        writeln('Link failed! Errno: ', fpgeterrno);

    if fplstat('test.lnk', @info) <> 0 then
    begin
        writeln('LStat failed. Errno: ', fpgeterrno);
        halt(1);
    end;
    erase(f);
    fpunlink('test.lnk');
end.
