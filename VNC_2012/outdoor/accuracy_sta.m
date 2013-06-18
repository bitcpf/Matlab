function out=accuracy_sta(act_data,estimate_data)

i=1;
[m,n]=size(act_data);
out=0;
while (i<=m)
    if(act_data(i)==estimate_data(i))
        out=out+1;
    end
    i=i+1;
end
out=out/m;