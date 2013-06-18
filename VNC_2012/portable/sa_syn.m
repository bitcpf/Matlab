function out=sa_syn(sadata,pkt)
i=1;
out=sadata;
[m,n]=size(out);
% stp=666666666
while(i<m)
    index_sec=find(pkt(:,1)==out(i,4));
    index_1=find(pkt(index_sec,2)>(out(i,5)-2200));
    temp=pkt(index_sec(index_1),:);
    index=find(temp(:,2)<(out(i,5)+2200));
    temp2=temp(index,:);
    if(numel(temp2)>0)
%         stp
%         out(i,2)
%         mean(temp2(:,3))
        out(i,:)=[];
        %out(i,6)=mean(temp2(:,3))-out(i,2);
        [m,n]=size(out);
    else
     %   out(i,7)=555;
     i=i+1;
    end
    
%     if(numel(index_ms)>0)
%         out(i,:)=[];
%         [m,n]=size(out);
%     else
%         i=i+1;
%     end
    
    
end




