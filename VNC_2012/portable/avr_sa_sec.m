function out=avr_sa_sec(sadata)
i=1;
[m,n]=size(sadata);
cnt=1;

while(i<m)
    sec=sadata(1,4);
    index=find(sadata(:,4)==sec);
    temp=mean(sadata(index,2));
    
    out(cnt,:)=[sadata(i,4),temp];
    cnt=cnt+1;
    if(numel(sadata)>0)
        sadata(index,:)=[];
        
    end
    [m,n]=size(sadata);
end
