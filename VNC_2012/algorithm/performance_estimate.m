%Estimate based on 5GHz
function [out1,out2]=performance_estimate(snr_input,context_info)


i=1;
[m,n]=size(snr_input);
while(i<=m)
    in_snr45=floor(snr_input(i));
%     in_snr24=floor(snrest(i,19));
%     in_snr52=floor(snrest(i,17));
%     in_snr90=floor(snrest(i,20));
    if(in_snr45>max(context_info(:,1)))
        in_snr45=max(context_info(:,1));
    end
%     if(in_snr24>max(per_cont24(:,1)))
%         in_snr24=max(per_cont24(:,1));
%     end
%     if(in_snr52>max(per_cont52(:,1)))
%         in_snr52=max(per_cont52(:,1));
%     end
%     if(in_snr90>max(per_cont90(:,1)))
%         in_snr90=max(per_cont90(:,1));
%     end    
    
    
    
    index=find(context_info(:,1)==in_snr45);
    if(isempty(index))    
    out1(i,1)=0;
    out2(i,1)=30000000000;
    else
    out1(i,1)=context_info(index,2);
    out2(i,1)=context_info(index,3);
    end
    
%     index=find(per_cont24(:,1)==in_snr24);
%     if(isempty(index))    
%     perest_tpt(i,18)=0;
%     perest_delay(i,18)=30000000000;
%     else
%     perest_tpt(i,18)=per_cont24(index,2);
%     perest_delay(i,18)=per_cont24(index,3);
%     end
%         
%         
%         
%         
%     index=find(per_cont52(:,1)==in_snr52);
%     if(isempty(index))    
%     perest_tpt(i,19)=0;
%     perest_delay(i,19)=30000000000;
%     else
%     perest_tpt(i,19)=per_cont52(index,2);
%     perest_delay(i,19)=per_cont52(index,3);
%     end
%     
%     
%     index=find(per_cont90(:,1)==in_snr90);
%     if(isempty(index))
%     perest_tpt(i,20)=0;
%     perest_delay(i,20)=30000000000;
%     else
%     perest_tpt(i,20)=per_cont90(index,2);
%     perest_delay(i,20)=per_cont90(index,3);
%     end
    i=i+1;
end
