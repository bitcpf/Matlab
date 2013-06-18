%%%%Find the max tpt and out put to the 11 & 12 column
function out=stat_min(in_matrix)


i=1;
[m,n]=size(in_matrix);
while(i<=m)
    index=find(in_matrix(i,:)==min(in_matrix(i,:)));
    if(numel(index)==1)
    out(i)=index;
    else
        out(i)=index(1);
    end

    i=i+1;
end
