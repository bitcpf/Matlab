function out=activity_delay(in_activity,ideal_delay)

i=1;
[m,n]=size(in_activity);
while(i<=m)
    out(i)=1/(1-in_activity(i))*ideal_delay(i);
    i=i+1;
end
