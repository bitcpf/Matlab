function out=syn_tpt_delay(tpt,delay)


i=1;
[m,n]=size(tpt);
while(i<m)
    index=find(throughput_90(:,1)==throughput_70(i,1)); %Synchronize 90
    if(numel(index)>0)
    throughput_70(i,6)=mean(throughput_90(index,5));
    end
    index=find(throughput_24(:,1)==throughput_70(i,1)); %Synchronize 24
    
    if(numel(index)>0)
    throughput_70(i,7)=mean(throughput_24(index,5));
    throughput_70(i,2)=(throughput_70(i,2)+mean(throughput_24(index,2)))/2;
    throughput_70(i,3)=(throughput_70(i,3)+mean(throughput_24(index,3)))/2;
    throughput_70(i,4)=(throughput_70(i,4)+mean(throughput_24(index,4)))/2;
    end
    
    index=find(throughput_52(:,1)==throughput_70(i,1)); %Synchronize 52
    if(numel(index)>0)
        throughput_70(i,8)=mean(throughput_52(index,5));
    end
end