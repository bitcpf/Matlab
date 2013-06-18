clear all
close all


%Define step
st=0.1;
%Load data


load pseudo_quan_raw.csv;
pseudo_g=pseudo_quan_raw;
clear pseudo_quan_raw;



%Find the max/min tpt of each band
max_24=max(pseudo_g(:,6));
max_52=max(pseudo_g(:,14));
max_45=max(pseudo_g(:,22));
max_90=max(pseudo_g(:,30));

min_24=min(pseudo_g(:,6));
min_52=min(pseudo_g(:,14));
min_45=min(pseudo_g(:,22));
min_90=min(pseudo_g(:,30));

q_24=(round(min_24*10):st*10:round(max_24*10))/10;
q_52=(round(min_52*10):st*10:round(max_52*10))/10;
q_45=(round(min_45*10):st*10:round(max_45*10))/10;
q_90=(round(min_90*10):st*10:round(max_90*10))/10;

i=1;
[m,n]=size(pseudo_g);

while(i<=m)
    temp=max(q_24(q_24<=pseudo_g(i,6)));
    if(numel(temp))
        temp_24(i)=temp;
    end
  
    temp=max(q_52(q_52<=pseudo_g(i,14)));
    if(numel(temp))
        temp_52(i)=temp;
    end
    
    temp=max(q_45(q_45<=pseudo_g(i,22)));
    if(numel(temp))
        temp_45(i)=temp;
    end
    temp=max(q_90(q_90<=pseudo_g(i,30)));
    if(numel(temp))
        temp_90(i)=temp;
    end
    i=i+1;
end
  pseudo_g(:,6)=temp_24;
  pseudo_g(:,14)=temp_52;
  pseudo_g(:,22)=temp_45;
  pseudo_g(:,30)=temp_90;
  
  
  
% Quantize the delay
%Define step
st=(10000-2000)/100;
  %Find the max/min delay of each band
max_24=max(pseudo_g(:,7));
max_52=max(pseudo_g(:,15));
max_45=max(pseudo_g(:,23));
max_90=max(pseudo_g(:,31));

min_24=min(pseudo_g(:,7));
min_52=min(pseudo_g(:,15));
min_45=min(pseudo_g(:,23));
min_90=min(pseudo_g(:,31));
 
min_delay=min([min_24,min_52,min_45,min_90]);
max_delay=max([max_24,max_52,max_45,max_90]);

q_24=2000:st:10000;
q_52=q_24;
q_45=q_24;
q_90=q_24;

i=1;
[m,n]=size(pseudo_g);

while(i<=m)
    temp=max(q_24(q_24<=pseudo_g(i,7)));
    index=find(q_24==temp);
    temp_24(i)=index;
  
    temp=max(q_52(q_52<=pseudo_g(i,15)));
    if(numel(temp))
        temp_52(i)=temp;
    end
    
    index=find(q_52==temp);
    temp_52(i)=index;
    
    temp=max(q_45(q_45<=pseudo_g(i,23)));
    if(numel(temp))
        temp_45(i)=temp;
    end
    
    index=find(q_45==temp);
    temp_45(i)=index;
    
    temp=max(q_90(q_90<=pseudo_g(i,31)));
    if(numel(temp))
        temp_90(i)=temp;
    end
    index=find(q_90==temp);
    temp_90(i)=index;
    
    
    i=i+1;
end
  pseudo_g(:,7)=temp_24;
  pseudo_g(:,15)=temp_52;
  pseudo_g(:,23)=temp_45;
  pseudo_g(:,31)=temp_90;




dlmwrite('pseudo_group_quatilize.csv',pseudo_g,'delimiter',',','precision','%.12f');


