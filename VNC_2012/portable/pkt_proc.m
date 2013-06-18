function out=pkt_proc(pktdata)
%pktdata(:,2)=round(mod(pktdata(:,2),1)*1000000);
i=1;
[m,n]=size(pktdata);
pre_gps=pktdata(1,1);
pre_st_ms=round(mod(pktdata(1,2),1)*1000000);
while(i<m)
    if(pktdata(i,1)==pre_gps)
        pktdata(i,2)=round(mod(pktdata(i,2),1)*1000000)-pre_st_ms;
        if(pktdata(i,2)<0)
            pktdata(i,2)=pktdata(i,2)+1000000;
        end
    
    else
        pre_gps=pktdata(i,1);
        pre_st_ms=round(mod(pktdata(i,2),1)*1000000);
        pktdata(i,2)=round(mod(pktdata(i,2),1)*1000000)-pre_st_ms;
        
    end
    i=i+1;
    
end

out=pktdata;
