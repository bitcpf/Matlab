function out=avr_tpt(tpt)

i=1;
cnt=1;
[m,n]=size(tpt);
while(i<m)
    index=find(tpt(:,1)==tpt(i,1));
    if(size(index)==1)
        out(cnt,:)=tpt(index,:);
    else
        out(cnt,:)=mean(tpt(index,:));
    end
    tpt(index,:)=[];
    cnt=cnt+1;
       
    
    [m,n]=size(tpt);
end