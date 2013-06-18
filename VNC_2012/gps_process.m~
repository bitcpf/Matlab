clear all
load vncdata

temp=vncdata(:,6);
vncdata(:,6)=vncdata(:,7);
vncdata(:,7)=temp;

dg=ceil(vncdata(:,5)/100);
dot=mod(vncdata(:,5),100)/60;
vncdata(:,5)=(dg+dot);

dg=ceil(vncdata(:,6)/100);
dot=mod(vncdata(:,6),100)/60;
vncdata(:,6)=(dg+dot);


dg=ceil(vncdata(:,7)/100);
dot=mod(vncdata(:,7),100)/60;
vncdata(:,7)=(dg+dot);


dg=ceil(vncdata(:,8)/100);
dot=mod(vncdata(:,8),100)/60;
vncdata(:,8)=(dg+dot);

vncdata(:,6)=vncdata(:,6)*(-1)+1;
vncdata(:,8)=vncdata(:,8)*(-1)+1;

vncdata(:,7)=vncdata(:,7)-1;
vncdata(:,5)=vncdata(:,5)-1;

[m,n]=size(vncdata);
i=1;
while(i<=m)
    temp=vncdata(i,13:16);
    index=find(temp==max(temp));
    if(numel(index)>1)
        index=min(index);
    end
    vncdata(i,1)=index;
    i=i+1;
end