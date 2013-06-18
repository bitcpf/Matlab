load vncdata

index=find(vncdata(:,4)>100);


%Region
r1_lat_h=max(vncdata(1:159,5));
r1_lat_l=min(vncdata(1:159,5));
r1_long_h=max(vncdata(1:159,7));
r1_long_l=min(vncdata(1:159,7));

r2_lat_h=max(vncdata(160:318,5));
r2_lat_l=min(vncdata(160:318,5));
r2_long_h=max(vncdata(160:318,7));
r2_long_l=min(vncdata(160:318,7));

r3_lat_h=max(vncdata(319:477,5));
r3_lat_l=min(vncdata(319:477,5));
r3_long_h=max(vncdata(319:477,7));
r3_long_l=min(vncdata(319:477,7));

r4_lat_h=max(vncdata(478:636,5));
r4_lat_l=min(vncdata(478:636,5));
r4_long_h=max(vncdata(478:636,7));
r4_long_l=min(vncdata(478:636,7));

r5_lat_h=max(vncdata(637:797,5));
r5_lat_l=min(vncdata(637:797,5));
r5_long_h=max(vncdata(637:797,7));
r5_long_l=min(vncdata(637:797,7));


% r6_lat_h1=max(vncdata(798:957,6));
% r6_lat_l1=min(vncdata(798:957,6));
% r6_long_h1=max(vncdata(798:957,8));
% r6_long_l1=min(vncdata(798:957,8));
% 
% r6_lat_h2=max(vncdata(798:957,5));
% r6_lat_l2=min(vncdata(798:957,5));
% r6_long_h2=max(vncdata(798:957,7));
% r6_long_l2=min(vncdata(798:957,7));

r6_lat_h=3304.06;
r6_lat_l=3304.05;
r6_long_h=9641.733;
r6_long_l=9641.730;





[m,n]=size(vncdata);
for i=1:m
    
    
    %Region limit
    %1:133
    if(vncdata(i,5)>=r1_lat_l && vncdata(i,5)<=r1_lat_h && vncdata(i,6)>=r1_lat_l && vncdata(i,6)<=r1_lat_h && vncdata(i,7)>=r1_long_l && vncdata(i,7)<=r1_long_h && vncdata(i,8)>=r1_long_l && vncdata(i,8)<=r1_long_h)
        vncdata(i,25)=1;
    elseif(vncdata(i,5)>=r2_lat_l && vncdata(i,5)<=r2_lat_h && vncdata(i,6)>=r2_lat_l && vncdata(i,6)<=r2_lat_h && vncdata(i,7)>=r2_long_l && vncdata(i,7)<=r2_long_h && vncdata(i,8)>=r2_long_l && vncdata(i,8)<=r2_long_h)
        vncdata(i,25)=2;
    elseif(vncdata(i,5)>=r3_lat_l && vncdata(i,5)<=r3_lat_h && vncdata(i,6)>=r3_lat_l && vncdata(i,6)<=r3_lat_h && vncdata(i,7)>=r3_long_l && vncdata(i,7)<=r3_long_h && vncdata(i,8)>=r3_long_l && vncdata(i,8)<=r3_long_h)
        vncdata(i,25)=3;    
    elseif(vncdata(i,5)>=r4_lat_l && vncdata(i,5)<=r4_lat_h && vncdata(i,6)>=r4_lat_l && vncdata(i,6)<=r4_lat_h && vncdata(i,7)>=r4_long_l && vncdata(i,7)<=r4_long_h && vncdata(i,8)>=r4_long_l && vncdata(i,8)<=r4_long_h)
        vncdata(i,25)=4;    
    elseif(vncdata(i,5)>=r5_lat_l && vncdata(i,5)<=r5_lat_h && vncdata(i,6)>=r5_lat_l && vncdata(i,6)<=r5_lat_h && vncdata(i,7)>=r5_long_l && vncdata(i,7)<=r5_long_h && vncdata(i,8)>=r5_long_l && vncdata(i,8)<=r5_long_h)
        vncdata(i,25)=5;
    elseif(vncdata(i,5)>=r6_lat_l && vncdata(i,5)<=r6_lat_h && vncdata(i,6)>=r6_lat_l && vncdata(i,6)<=r6_lat_h && vncdata(i,7)>=r6_long_l && vncdata(i,7)<=r6_long_h && vncdata(i,8)>=r6_long_l && vncdata(i,8)<=r6_long_h)
        vncdata(i,25)=6;
    end
    end