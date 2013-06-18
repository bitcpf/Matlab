clear all
close all

load region;
load ideal_24.csv;
load ideal_52.csv;
load ideal_45.csv;
load ideal_90.csv;

i=1;
[m,n]=size(ideal_24);
while(i<=m)
    if(ideal_24(i,1)<-89 && ideal_24(i,2)>3)
        ideal_24(i,:)=[];
%    elseif(ideal_24(i,1)<-85 && ideal_24(i,2)>3.5)
%        ideal_24(i,:)=[];
    else
        i=i+1;
    end
   [m,n]=size(ideal_24); 
end


figure

plot(ideal_24(:,1),ideal_24(:,2),'x');
hold on;
plot(ideal_52(:,1),ideal_52(:,2),'rv');

plot(ideal_45(:,1),ideal_45(:,2),'k*');
plot(ideal_90(:,1),ideal_90(:,2),'go');




snrest=vncdata(:,9:12);

l45=3*10^8/450/10^6;
l90=3*10^8/900/10^6;
l24=3*10^8/2.4/10^9;
l52=3*10^8/5.2/10^9;

db45=10*log10(l45);
db90=10*log10(l90);
db24=10*log10(l24);
db52=10*log10(l52);


%Pathloss exponent calculation
i=1;
[m,n]=size(snrest);
while(i<=m)
    snrest(i,5)=snrest(i,1);
    snrest(i,6)=snrest(i,1)+db24-db45;
    snrest(i,7)=snrest(i,1)-db45+db52;
    snrest(i,8)=snrest(i,1)-db45+db90;
     
    i=i+1;
end
snrest(1666,:)=[];
cont45_h=ceil(max(snrest(1:1665,1)));
cont45_l=floor(min(snrest(1:1665,1)));
cont24_h=ceil(max(snrest(1:1665,2)));
cont24_l=floor(min(snrest(1:1665,2)));
cont52_h=ceil(max(snrest(1:1665,3)));
cont52_l=floor(min(snrest(1:1665,3)));
cont90_h=ceil(max(snrest(1:1665,4)));
cont90_l=floor(min(snrest(1:1665,4)));

%%Make the context snr table
context45(:,1)=cont45_l:cont45_h;


i=1;
[m,n]=size(context45);
while(i<=m)
    index1=find(snrest(:,1)>(context45(i,1)-1));
    index2=find(snrest(index1,1)<(context45(i,1)+1));
    
    context45(i,2)=mean(snrest(index2,2));%2.4GHz context
    context45(i,3)=mean(snrest(index2,3));%2.4GHz context
    context45(i,4)=mean(snrest(index2,4));%2.4GHz context
    i=i+1;
end


context24(:,1)=cont24_l:cont24_h;


i=1;
[m,n]=size(context24);
while(i<=m)
    index1=find(snrest(:,1)>(context24(i,1)-1));
    index2=find(snrest(index1,1)<(context24(i,1)+1));
    
    context24(i,2)=mean(snrest(index2,1));%450MHz context
    context24(i,3)=mean(snrest(index2,3));%52Hz context
    context24(i,4)=mean(snrest(index2,4));%900Hz context
    i=i+1;
end


context52(:,1)=cont52_l:cont52_h;


i=1;
[m,n]=size(context52);
while(i<=m)
    index1=find(snrest(:,1)>(context52(i,1)-1));
    index2=find(snrest(index1,1)<(context52(i,1)+1));
    
    context52(i,2)=mean(snrest(index2,1));%450MHz context
    context52(i,3)=mean(snrest(index2,2));%24GHz context
    context52(i,4)=mean(snrest(index2,4));%900Hz context
    i=i+1;
end

context90(:,1)=cont90_l:cont90_h;


i=1;
[m,n]=size(context90);
while(i<=m)
    index1=find(snrest(:,1)>(context90(i,1)-1));
    index2=find(snrest(index1,1)<(context90(i,1)+1));
    
    context90(i,2)=mean(snrest(index2,1));%450MHz context
    context90(i,3)=mean(snrest(index2,2));%52Hz context
    context90(i,4)=mean(snrest(index2,3));%900Hz context
    i=i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Given 450MHz estimate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%snrest colum 9-12 estimation from 450MHz


i=1;
[m,n]=size(snrest);
while(i<=m)
    in_snr=ceil(snrest(i,1));
    index=find(context45(:,1)==in_snr);
    snrest(i,9:12)=context45(index,:);
    i=i+1;
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Given 2.4GHz estimate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%snrest colum 13-16 estimation from 2.4GHz, 2.4,450,5G,900M


i=1;
[m,n]=size(snrest);
while(i<=m)
    in_snr=ceil(snrest(i,2));
    index=find(context24(:,1)==in_snr);
    snrest(i,13:16)=context24(index,:);
    i=i+1;
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Given 5GHz estimate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%snrest colum 17-20 estimation from 5GHz, 5,450,2.4G,900M


i=1;
[m,n]=size(snrest);
while(i<=m)
    in_snr=ceil(snrest(i,3));
    index=find(context52(:,1)==in_snr);
    snrest(i,17:20)=context52(index,:);
    i=i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Given 900MHz estimate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%snrest colum 21-24 estimation from 900MHz, 900,450,2.4G,5G


i=1;
[m,n]=size(snrest);
while(i<=m)
    in_snr=ceil(snrest(i,4));
    index=find(context90(:,1)==in_snr);
    snrest(i,21:24)=context90(index,:);
    i=i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Estimate the performance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

perest_tpt=vncdata(:,13:16);
perest_delay=vncdata(:,17:20);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%without activity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%Make the performance context 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

per_cont45_h=ceil(max(ideal_45(:,1)));
per_cont45_l=floor(min(ideal_45(:,1)));
per_cont24_h=ceil(max(ideal_24(:,1)));
per_cont24_l=floor(min(ideal_24(:,1)));
per_cont52_h=ceil(max(ideal_52(:,1)));
per_cont52_l=floor(min(ideal_52(:,1)));
per_cont90_h=ceil(max(ideal_90(:,1)));
per_cont90_l=floor(min(ideal_90(:,1)));




%Performance context 450M
per_cont45(:,1)=per_cont45_l:per_cont45_h;

i=1;
[m,n]=size(per_cont45);
while(i<=m)
    index1=find(ideal_45(:,1)>(per_cont45(i,1)-1));
    index2=find(ideal_45(index1,1)<(per_cont45(i,1)+1));
    
    per_cont45(i,2)=mean(ideal_45(index2,2));%2.4GHz context
    per_cont45(i,3)=mean(ideal_45(index2,3));%2.4GHz context
    i=i+1;
end


%Performance context 2.4G
per_cont24(:,1)=per_cont24_l:per_cont24_h;

i=1;
[m,n]=size(per_cont24);
while(i<=m)
    index1=find(ideal_24(:,1)>(per_cont24(i,1)-1));
    index2=find(ideal_24(index1,1)<(per_cont24(i,1)+1));
    
    per_cont24(i,2)=mean(ideal_24(index2,2));%2.4GHz context
    per_cont24(i,3)=mean(ideal_24(index2,3));%2.4GHz context
    i=i+1;
end

%Performance context 5G
per_cont52(:,1)=per_cont52_l:per_cont52_h;

i=1;
[m,n]=size(per_cont52);
while(i<=m)
    index1=find(ideal_52(:,1)>(per_cont52(i,1)-1));
    index2=find(ideal_52(index1,1)<(per_cont52(i,1)+1));
    
    per_cont52(i,2)=mean(ideal_52(index2,2));%2.4GHz context
    per_cont52(i,3)=mean(ideal_52(index2,3));%2.4GHz context
    i=i+1;
end

%Performance context 5G
per_cont90(:,1)=per_cont90_l:per_cont90_h;

i=1;
[m,n]=size(per_cont90);
while(i<=m)
    index1=find(ideal_90(:,1)>(per_cont90(i,1)-1));
    index2=find(ideal_90(index1,1)<(per_cont90(i,1)+1));
    
    per_cont90(i,2)=mean(ideal_90(index2,2));%2.4GHz context
    per_cont90(i,3)=mean(ideal_90(index2,3));%2.4GHz context
    i=i+1;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Estimate Performance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% perest_tpt=vncdata(:,13:16);
% perest_delay=vncdata(:,17:20);


%Estimate the pathloss calculation
i=1;
[m,n]=size(snrest);
while(i<=m)
    in_snr45=floor(snrest(i,5));
    in_snr24=floor(snrest(i,6));
    in_snr52=floor(snrest(i,7));
    in_snr90=floor(snrest(i,8));
    if(in_snr45>max(per_cont45(:,1)))
        in_snr45=max(per_cont45(:,1));
    end
    if(in_snr24>max(per_cont24(:,1)))
        in_snr24=max(per_cont24(:,1));
    end
    if(in_snr52>max(per_cont52(:,1)))
        in_snr52=max(per_cont52(:,1));
    end
    if(in_snr90>max(per_cont90(:,1)))
        in_snr90=max(per_cont90(:,1));
    end    
    
    
    
    index=find(per_cont45(:,1)==in_snr45);
    if(isempty(index))    
    perest_tpt(i,5)=0;
    perest_delay(i,5)=30000000000;
    else
    perest_tpt(i,5)=per_cont45(index,2);
    perest_delay(i,5)=per_cont45(index,3);
    end
    
    index=find(per_cont24(:,1)==in_snr24);
    if(isempty(index))    
    perest_tpt(i,6)=0;
    perest_delay(i,6)=30000000000;
    else
    perest_tpt(i,6)=per_cont24(index,2);
    perest_delay(i,6)=per_cont24(index,3);
    end
        
        
        
        
    index=find(per_cont52(:,1)==in_snr52);
    if(isempty(index))    
    perest_tpt(i,7)=0;
    perest_delay(i,7)=30000000000;
    else
    perest_tpt(i,7)=per_cont52(index,2);
    perest_delay(i,7)=per_cont52(index,3);
    end
    
    
    index=find(per_cont90(:,1)==in_snr90);
    if(isempty(index))
    perest_tpt(i,8)=0;
    perest_delay(i,8)=30000000000;
    else
    perest_tpt(i,8)=per_cont90(index,2);
    perest_delay(i,8)=per_cont90(index,3);
    end
    i=i+1;
end



%Estimate based on 450MHz
i=1;
[m,n]=size(snrest);
while(i<=m)
    in_snr45=floor(snrest(i,9));
    in_snr24=floor(snrest(i,10));
    in_snr52=floor(snrest(i,11));
    in_snr90=floor(snrest(i,12));
    if(in_snr45>max(per_cont45(:,1)))
        in_snr45=max(per_cont45(:,1));
    end
    if(in_snr24>max(per_cont24(:,1)))
        in_snr24=max(per_cont24(:,1));
    end
    if(in_snr52>max(per_cont52(:,1)))
        in_snr52=max(per_cont52(:,1));
    end
    if(in_snr90>max(per_cont90(:,1)))
        in_snr90=max(per_cont90(:,1));
    end    
    
    
    
    index=find(per_cont45(:,1)==in_snr45);
    if(isempty(index))    
    perest_tpt(i,9)=0;
    perest_delay(i,9)=30000000000;
    else
    perest_tpt(i,9)=per_cont45(index,2);
    perest_delay(i,9)=per_cont45(index,3);
    end
    
    index=find(per_cont24(:,1)==in_snr24);
    if(isempty(index))    
    perest_tpt(i,10)=0;
    perest_delay(i,10)=30000000000;
    else
    perest_tpt(i,10)=per_cont24(index,2);
    perest_delay(i,10)=per_cont24(index,3);
    end
        
        
        
        
    index=find(per_cont52(:,1)==in_snr52);
    if(isempty(index))    
    perest_tpt(i,11)=0;
    perest_delay(i,11)=30000000000;
    else
    perest_tpt(i,11)=per_cont52(index,2);
    perest_delay(i,11)=per_cont52(index,3);
    end
    
    
    index=find(per_cont90(:,1)==in_snr90);
    if(isempty(index))
    perest_tpt(i,12)=0;
    perest_delay(i,12)=30000000000;
    else
    perest_tpt(i,12)=per_cont90(index,2);
    perest_delay(i,12)=per_cont90(index,3);
    end
    i=i+1;
end


%Estimate based on 2.4GHz
i=1;
[m,n]=size(snrest);
while(i<=m)
    in_snr45=floor(snrest(i,14));
    in_snr24=floor(snrest(i,13));
    in_snr52=floor(snrest(i,15));
    in_snr90=floor(snrest(i,16));
    if(in_snr45>max(per_cont45(:,1)))
        in_snr45=max(per_cont45(:,1));
    end
    if(in_snr24>max(per_cont24(:,1)))
        in_snr24=max(per_cont24(:,1));
    end
    if(in_snr52>max(per_cont52(:,1)))
        in_snr52=max(per_cont52(:,1));
    end
    if(in_snr90>max(per_cont90(:,1)))
        in_snr90=max(per_cont90(:,1));
    end    
    
    
    
    index=find(per_cont45(:,1)==in_snr45);
    if(isempty(index))    
    perest_tpt(i,13)=0;
    perest_delay(i,13)=30000000000;
    else
    perest_tpt(i,13)=per_cont45(index,2);
    perest_delay(i,13)=per_cont45(index,3);
    end
    
    index=find(per_cont24(:,1)==in_snr24);
    if(isempty(index))    
    perest_tpt(i,14)=0;
    perest_delay(i,14)=30000000000;
    else
    perest_tpt(i,14)=per_cont24(index,2);
    perest_delay(i,14)=per_cont24(index,3);
    end
        
        
        
        
    index=find(per_cont52(:,1)==in_snr52);
    if(isempty(index))    
    perest_tpt(i,15)=0;
    perest_delay(i,15)=30000000000;
    else
    perest_tpt(i,15)=per_cont52(index,2);
    perest_delay(i,15)=per_cont52(index,3);
    end
    
    
    index=find(per_cont90(:,1)==in_snr90);
    if(isempty(index))
    perest_tpt(i,16)=0;
    perest_delay(i,16)=30000000000;
    else
    perest_tpt(i,16)=per_cont90(index,2);
    perest_delay(i,16)=per_cont90(index,3);
    end
    i=i+1;
end


%Estimate based on 5GHz
i=1;
[m,n]=size(snrest);
while(i<=m)
    in_snr45=floor(snrest(i,18));
    in_snr24=floor(snrest(i,19));
    in_snr52=floor(snrest(i,17));
    in_snr90=floor(snrest(i,20));
    if(in_snr45>max(per_cont45(:,1)))
        in_snr45=max(per_cont45(:,1));
    end
    if(in_snr24>max(per_cont24(:,1)))
        in_snr24=max(per_cont24(:,1));
    end
    if(in_snr52>max(per_cont52(:,1)))
        in_snr52=max(per_cont52(:,1));
    end
    if(in_snr90>max(per_cont90(:,1)))
        in_snr90=max(per_cont90(:,1));
    end    
    
    
    
    index=find(per_cont45(:,1)==in_snr45);
    if(isempty(index))    
    perest_tpt(i,17)=0;
    perest_delay(i,17)=30000000000;
    else
    perest_tpt(i,17)=per_cont45(index,2);
    perest_delay(i,17)=per_cont45(index,3);
    end
    
    index=find(per_cont24(:,1)==in_snr24);
    if(isempty(index))    
    perest_tpt(i,18)=0;
    perest_delay(i,18)=30000000000;
    else
    perest_tpt(i,18)=per_cont24(index,2);
    perest_delay(i,18)=per_cont24(index,3);
    end
        
        
        
        
    index=find(per_cont52(:,1)==in_snr52);
    if(isempty(index))    
    perest_tpt(i,19)=0;
    perest_delay(i,19)=30000000000;
    else
    perest_tpt(i,19)=per_cont52(index,2);
    perest_delay(i,19)=per_cont52(index,3);
    end
    
    
    index=find(per_cont90(:,1)==in_snr90);
    if(isempty(index))
    perest_tpt(i,20)=0;
    perest_delay(i,20)=30000000000;
    else
    perest_tpt(i,20)=per_cont90(index,2);
    perest_delay(i,20)=per_cont90(index,3);
    end
    i=i+1;
end

%Estimate based on 900MHz
i=1;
[m,n]=size(snrest);
while(i<=m)
    in_snr45=floor(snrest(i,22));
    in_snr24=floor(snrest(i,23));
    in_snr52=floor(snrest(i,24));
    in_snr90=floor(snrest(i,21));
    if(in_snr45>max(per_cont45(:,1)))
        in_snr45=max(per_cont45(:,1));
    end
    if(in_snr24>max(per_cont24(:,1)))
        in_snr24=max(per_cont24(:,1));
    end
    if(in_snr52>max(per_cont52(:,1)))
        in_snr52=max(per_cont52(:,1));
    end
    if(in_snr90>max(per_cont90(:,1)))
        in_snr90=max(per_cont90(:,1));
    end    
    
    
    
    index=find(per_cont45(:,1)==in_snr45);
    if(isempty(index))    
    perest_tpt(i,21)=0;
    perest_delay(i,21)=30000000000;
    else
    perest_tpt(i,21)=per_cont45(index,2);
    perest_delay(i,21)=per_cont45(index,3);
    end
    
    index=find(per_cont24(:,1)==in_snr24);
    if(isempty(index))    
    perest_tpt(i,22)=0;
    perest_delay(i,22)=30000000000;
    else
    perest_tpt(i,22)=per_cont24(index,2);
    perest_delay(i,22)=per_cont24(index,3);
    end
        
        
        
        
    index=find(per_cont52(:,1)==in_snr52);
    if(isempty(index))    
    perest_tpt(i,23)=0;
    perest_delay(i,23)=30000000000;
    else
    perest_tpt(i,23)=per_cont52(index,2);
    perest_delay(i,23)=per_cont52(index,3);
    end
    
    
    index=find(per_cont90(:,1)==in_snr90);
    if(isempty(index))
    perest_tpt(i,24)=0;
    perest_delay(i,24)=30000000000;
    else
    perest_tpt(i,24)=per_cont90(index,2);
    perest_delay(i,24)=per_cont90(index,3);
    end
    i=i+1;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Got all the one band estimation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate the accuracy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i=1;
[m,n]=size(perest_tpt);

while(i<=m)
    tpt_real=perest_tpt(i,1:4);
    delay_real=perest_delay(i,1:4);
    tpt_a1_path=perest_tpt(i,5:8);
    delay_a1_path=perest_delay(i,5:8);
    tpt_a1_45=perest_tpt(i,9:12);
    delay_a1_45=perest_delay(i,9:12);
    tpt_a1_24=perest_tpt(i,13:16);
    delay_a1_24=perest_delay(i,13:16);
    tpt_a1_52=perest_tpt(i,17:20);
    delay_a1_52=perest_delay(i,17:20);
    tpt_a1_90=perest_tpt(i,21:24);
    delay_a1_90=perest_delay(i,21:24);
    
    index_tpt_real=find(tpt_real==max(tpt_real));
    index_tpt_path=find(tpt_a1_path==max(tpt_a1_path));
    index_tpt_45=find(tpt_a1_45==max(tpt_a1_45));
    index_tpt_24=find(tpt_a1_24==max(tpt_a1_24));
    index_tpt_52=find(tpt_a1_52==max(tpt_a1_52));
    index_tpt_90=find(tpt_a1_90==max(tpt_a1_90));

    index_delay_real=find(delay_real==max(delay_real));
    index_delay_path=find(delay_a1_path==max(delay_a1_path));
    index_delay_45=find(delay_a1_45==max(delay_a1_45));
    index_delay_24=find(delay_a1_24==max(delay_a1_24));
    index_delay_52=find(delay_a1_52==max(delay_a1_52));
    index_delay_90=find(delay_a1_90==max(delay_a1_90));    
    
    
    if(index_tpt_real==index_tpt_path)
        acc_tpt(i,1)=1;
    else
        acc_tpt(i,1)=0;
    end
    if(index_tpt_real==index_tpt_45)
        acc_tpt(i,2)=1;
    else
        acc_tpt(i,2)=0;
    end
    
    if(index_tpt_real==index_tpt_24)
        acc_tpt(i,3)=1;
    else
        acc_tpt(i,3)=0;
    end
    
    
    if(index_tpt_real==index_tpt_52)
        acc_tpt(i,4)=1;
    else
        acc_tpt(i,4)=0;
    end
    
    
    if(index_tpt_real==index_tpt_90)
        acc_tpt(i,5)=1;
    else
        acc_tpt(i,5)=0;
    end
    
    %%Calculate delay accuracy
    
    
   if(index_delay_real==index_delay_path)
        acc_delay(i,1)=1;
    else
        acc_delay(i,1)=0;
    end
    if(index_delay_real==index_delay_45)
        acc_delay(i,2)=1;
    else
        acc_delay(i,2)=0;
    end
    
    if(index_delay_real==index_delay_24)
        acc_delay(i,3)=1;
    else
        acc_delay(i,3)=0;
    end
    
    
    if(index_delay_real==index_delay_52)
        acc_delay(i,4)=1;
    else
        acc_delay(i,4)=0;
    end
    
    
    if(index_delay_real==index_delay_90)
        acc_delay(i,5)=1;
    else
        acc_delay(i,5)=0;
    end    
    
    
    
    
    
    
    
    
    i=i+1;
end


[accuracy_path,n]=size(find(acc_tpt(:,1)==1));
[accuracy_45,n]=size(find(acc_tpt(:,2)==1));
[accuracy_24,n]=size(find(acc_tpt(:,3)==1));
[accuracy_52,n]=size(find(acc_tpt(:,4)==1));
[accuracy_90,n]=size(find(acc_tpt(:,5)==1));

tpt_out(1)=accuracy_path/1666;
tpt_out(2)=accuracy_45/1666;
tpt_out(3)=accuracy_24/1666;
tpt_out(4)=accuracy_52/1666;
tpt_out(5)=accuracy_90/1666;


[accuracy_path,n]=size(find(acc_delay(:,1)==1));
[accuracy_45,n]=size(find(acc_delay(:,2)==1));
[accuracy_24,n]=size(find(acc_delay(:,3)==1));
[accuracy_52,n]=size(find(acc_delay(:,4)==1));
[accuracy_90,n]=size(find(acc_delay(:,5)==1));

delay_out(1)=accuracy_path/1666;
delay_out(2)=accuracy_45/1666;
delay_out(3)=accuracy_24/1666;
delay_out(4)=accuracy_52/1666;
delay_out(5)=accuracy_90/1666;
delay_out


