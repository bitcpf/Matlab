function out=syn_gpstime(data_matrix1,gpsposition1,data_matrix2,gpsposition2)

i=1;
cnt=1;
[m,n]=size(data_matrix1);
while(i<m)
    index=find(data_matrix2(:,gpsposition2)==data_matrix1(i,gpsposition1));
    if(numel(index)==1)
        out(cnt,:)=[data_matrix1(i,:),data_matrix2(index,:)];
        cnt=cnt+1;
    elseif(numel(index)>1)
        out(cnt,:)=[data_matrix1(i,:),mean(data_matrix2(index,:))];
        cnt=cnt+1;
    end
    i=i+1;
end