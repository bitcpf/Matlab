%%GPS group
%Need functions:  gps_distance,
%clear all
%close all

%Load  rawdata, input the latitude and longtitude data, to process future
%data, just modify the 3 lines. In the future, should make it as a function
%interface


%function out=gps_group(data_file)
data_file='vnc_826.csv'
rawdata=load(data_file);
latitude_time=rawdata(:,[2,5]);
longtitude_time=rawdata(:,[2,6]);


cnt=1;
%Find the point not repeated in the loop
i=1;
[m,n]=size(rawdata);
while(i<=m)
    loop_f=0;
    for j=i+1:m
        dis=gps_distance(latitude_time(i,2),longtitude_time(i,2),latitude_time(j,2),longtitude_time(j,2));
        time_dif=abs(longtitude_time(i,1)-longtitude_time(j,1));
        if(dis<60 && time_dif>90 && loop_f==0)
            pos_loop(cnt,1:2)=latitude_time(i,:);
            pos_loop(cnt,3)=longtitude_time(i,2);
           % pos_loop(cnt,4)=i;
            cnt=cnt+1;
            loop_f=1;
        end
    end
    
    
    i=i+1;
end





dlmwrite('gpstest.csv',pos_loop,'delimiter',',','precision','%.12f');