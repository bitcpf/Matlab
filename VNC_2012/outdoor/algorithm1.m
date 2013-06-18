clear all
close all
load vnc_826.csv;
load ideal_24.csv;
load ideal_52.csv;
%load ideal_45.csv;
%load ideal_90.csv;


per_cont24=performance_context(ideal_24);
per_cont52=performance_context(ideal_52);

perest_tpt(:,1:4)=vnc_826(:,[1 9:11]);
perest_delay(:,1:4)=vnc_826(:,[21 9:11]);


[perest_tpt(:,5),perest_delay(:,5)]=performance_estimate(perest_tpt(:,2),per_cont24);
[perest_tpt(:,6),perest_delay(:,6)]=performance_estimate(perest_tpt(:,3),per_cont24);
[perest_tpt(:,7),perest_delay(:,7)]=performance_estimate(perest_tpt(:,4),per_cont52);

%%%Consider the activity level

perest_tpt(:,8)=activity_tpt(vnc_826(:,18),perest_tpt(:,5));
perest_tpt(:,9)=activity_tpt(vnc_826(:,19),perest_tpt(:,6));
perest_tpt(:,10)=activity_tpt(vnc_826(:,20),perest_tpt(:,7));

%%%%Find the max tpt and out put to the 11 & 12 column
i=1;
[m,n]=size(perest_tpt);
while(i<=m)
    index=find(perest_tpt(i,5:7)==max(perest_tpt(i,5:7)));
    if(numel(index)==1)
    perest_tpt(i,11)=index;
    else
        perest_tpt(i,11)=index(1);
    end

    i=i+1;
end





i=1;
[m,n]=size(perest_tpt);
while(i<=m)
    index=find(perest_tpt(i,8:10)==max(perest_tpt(i,8:10)));
    if(numel(index)==1)
    perest_tpt(i,12)=index;
    else
        perest_tpt(i,12)=index(1);
    end

    i=i+1;
end

perest_delay(:,8)=activity_delay(vnc_826(:,18),perest_delay(:,5));
perest_delay(:,9)=activity_delay(vnc_826(:,19),perest_delay(:,6));
perest_delay(:,10)=activity_delay(vnc_826(:,20),perest_delay(:,7));

% %%%%Find the min delay and out put to the 21 column
i=1;
[m,n]=size(perest_delay);
while(i<=m)
    index=find(perest_delay(i,5:7)==min(perest_delay(i,5:7)));
    if(numel(index)==1)
    perest_delay(i,11)=index;
    else
        perest_delay(i,11)=index(1);
    end

    i=i+1;
end

i=1;
[m,n]=size(perest_delay);
while(i<=m)
    index=find(perest_delay(i,8:10)==min(perest_delay(i,8:10)));
    if(numel(index)==1)
    perest_delay(i,12)=index;
    else
        perest_delay(i,12)=index(1);
    end

    i=i+1;
end

tpt_ideal_acc=accuracy_sta(perest_tpt(:,1),perest_tpt(:,11))
tpt_act_acc=accuracy_sta(perest_tpt(:,1),perest_tpt(:,12))


delay_ideal_acc=accuracy_sta(perest_delay(:,1),perest_delay(:,11))
delay_act_acc=accuracy_sta(perest_delay(:,1),perest_delay(:,12))


i=1;
[m,n]=size(perest_delay);
while(i<=m)
    index=find(perest_delay(i,8:10)==min(perest_delay(i,8:10)));
    if(max(index)==3)
    perest_delay(i,13)=index;
    else
        perest_delay(i,13)=1;
    end

    i=i+1;
end

i=1;
[m,n]=size(perest_delay);
while(i<=m)
    
    if(perest_delay(i)<3)
    perest_delay(i,14)=1;
    else
        perest_delay(i,14)=3;
    end

    i=i+1;
end



i=1;
[m,n]=size(perest_delay);
while(i<=m)
    index=find(perest_delay(i,5:7)==min(perest_delay(i,5:7)));
    if(max(index)==3)
    perest_delay(i,15)=index;
    else
        perest_delay(i,15)=1;
    end

    i=i+1;
end

acc_norm=accuracy_sta(perest_delay(:,14),perest_delay(:,13))
acc_norm_no=accuracy_sta(perest_delay(:,14),perest_delay(:,15))


i=1;
[m,n]=size(perest_tpt);
while(i<=m)
    index=find(perest_tpt(i,5:7)==max(perest_tpt(i,5:7)));
    if(max(index)==3)
    perest_tpt(i,15)=index;
    else
        perest_tpt(i,15)=1;
    end

    i=i+1;
end

i=1;
[m,n]=size(perest_tpt);
while(i<=m)
    index=find(perest_tpt(i,8:10)==max(perest_tpt(i,8:10)));
    if(max(index)==3)
    perest_tpt(i,13)=index;
    else
        perest_tpt(i,13)=1;
    end

    i=i+1;
end




i=1;
[m,n]=size(perest_tpt);
while(i<=m)
    
    if(perest_tpt(i)<3)
    perest_tpt(i,14)=1;
    else
        perest_tpt(i,14)=3;
    end

    i=i+1;
end





acc_norm_tpt=accuracy_sta(perest_tpt(:,14),perest_tpt(:,13))
acc_norm_no_tpt=accuracy_sta(perest_tpt(:,14),perest_tpt(:,15))

