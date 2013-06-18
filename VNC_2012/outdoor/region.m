

function out=region(time1,time2,time3,time4,file1,file2)
%  time1=213653
%  time2=214021
%  time3=215445
%  time4=215707

data_file='region.csv';
rawdata=load(data_file);

index_pre=find(rawdata(:,2)>=time1);
index=find(rawdata(index_pre,2)<=time2);

out_train=rawdata(index_pre(index),:);

rawdata(index_pre(index),:)=[];

index_pre=find(rawdata(:,2)>=time3);
index=find(rawdata(index_pre,2)<=time4);

out_test=rawdata(index_pre(index),:);
rawdata(index_pre(index),:)=[];

dlmwrite(file1,out_train,'delimiter',',','precision','%.12f');
dlmwrite(file2,out_test,'delimiter',',','precision','%.12f');
dlmwrite('region.csv',rawdata,'delimiter',',','precision','%.12f');