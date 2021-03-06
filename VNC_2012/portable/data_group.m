clear all
close all

%Load data

band_info=['24';'52';'45';'90'];
[N,n]=size(band_info);
context_info=char('portable');
[M,n]=size(context_info);
cnt=1;

for i=1:M
    
    for j=1:N
        ld_file=strcat(context_info(i,:),'_',band_info(j,:),'.csv');
        load(ld_file);
        %Normalize the GPS latitude and longitude
        eval(['temp_d=floor(',context_info(i,:),'_',band_info(j,:),'(:,2:5)/100);']);
        eval(['temp_c=mod(',context_info(i,:),'_',band_info(j,:),'(:,2:5),100)/60;']);
        eval([context_info(i,:),'_',band_info(j,:),'(:,2:5)=temp_d+temp_c;']);
        
        %msize=strcat('ms_',band_info(j,:));
        eval(['[amnt(',num2str(cnt),'),n]=size(',context_info(i,:),'_',band_info(j,:),');']);
        
        cnt=cnt+1;
    end    
end
index=find(amnt==min(amnt));
index_c=ceil(index/N);
index_b=mod(index,N);

baseset=eval([context_info(index_c,:),'_',band_info(index_b,:)]);


%Finde the minimum distance in 1 band data
i=1;
[m,n]=size(baseset);


while(i<=m)
    comp_d=gps_distance(baseset(i,2),baseset(i,3),baseset(i,4),baseset(i,5));
    
    for k=1:M
        temp_out=[];
        for j=1:N
            eval(['temp_data=',context_info(k,:),'_',band_info(j,:),';']);
            [temp_n,n]=size(temp_data);
            
            for l=1:temp_n
                temp_distance_s(l)=gps_distance(temp_data(l,2),temp_data(l,3),temp_data(l,4),temp_data(l,5));
                %The distance between the baseset and the temp set
                temp_distance_b(l)=gps_distance(baseset(i,2),baseset(i,3),temp_data(l,2),temp_data(l,3));
                
            end
            index=find(temp_distance_b(:)==min(temp_distance_b));
            temp_out=[temp_out,temp_data(index(1),6:12),temp_distance_s(index(1))];
            
            clear temp_distance_s;
            clear temp_distance_b;

        end
        out(i,:)=temp_out;
    end
    
    
    
    i=i+1;
end

outnew(:,1)=mean([out(:,1),out(:,9),out(:,17),out(:,25)],2);
outnew(:,2)=mean([out(:,2),out(:,10),out(:,18),out(:,26)],2);
outnew(:,3:6)=[out(:,3),out(:,11),out(:,19),out(:,27)];
outnew(:,7:10)=[out(:,4),out(:,12),out(:,20),out(:,28)];
outnew(:,11:14)=[out(:,5),out(:,13),out(:,21),out(:,29)];
outnew(:,15:18)=[out(:,6),out(:,14),out(:,22),out(:,30)];
outnew(:,19:22)=[out(:,7),out(:,15),out(:,23),out(:,31)];
outnew(:,23:26)=[out(:,8),out(:,16),out(:,24),out(:,32)];


clear i;
clear j;
for i=0:3
    j=(i*8+1);
        out_qua(:,j)=out(:,j+1);
        out_qua(:,j+1)=out(:,j);
        out_qua(:,j+2)=out(:,j+3);
        out_qua(:,j+3)=out(:,j+5);
        out_qua(:,j+4)=out(:,j+6);
        out_qua(:,j+5)=out(:,j+2);
        out_qua(:,j+6)=out(:,j+4);
        out_qua(:,j+7)=0;
    
end

%For algorithm1 test
out_temp(:,1)=outnew(:,1);
out_temp(:,1)=222;
out_temp(:,2)=333;
out_temp(:,3:4)=outnew(:,1:2);
out_temp(:,5:8)=97.00;
%RSSI
out_temp(:,9:12)=outnew(:,7:10);
%TPT
out_temp(:,13:16)=outnew(:,3:6);
%Delay
out_temp(:,17:20)=outnew(:,11:14);
%ACT
out_temp(:,21:24)=outnew(:,15:18);
%SA data
out_temp(:,25:28)=outnew(:,19:22);

vncdata=out_temp;

dlmwrite('pseudo_group_avr.csv',outnew,'delimiter',',','precision','%.12f');
dlmwrite('pseudo_quan_raw.csv',out_qua,'delimiter',',','precision','%.12f');
