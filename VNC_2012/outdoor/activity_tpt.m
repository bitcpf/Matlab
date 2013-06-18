function out=activity_tpt(in_activity,ideal_tpt)

i=1;
[m,n]=size(in_activity);
while(i<=m)
    out(i)=(1-in_activity(i))*ideal_tpt(i);
    i=i+1;
end
