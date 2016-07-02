fmatime = matime = 1.0;
for i in 1:5 matime=min(matime, (@timed muladd(3.0,2.0,1.0))[2]) end;
for i in 1:5 fmatime=min(fmatime, (@timed fma(3.0,2.0,1.0))[2]) end;
const HasFMAonChip = fmatime < 2*matime;
