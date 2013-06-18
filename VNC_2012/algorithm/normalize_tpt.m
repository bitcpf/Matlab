function [out,out2,out3]=normalize_tpt(input)

%Input ideal data from emulator, normalize the throughput, output the
%normalized throughput with RSSI and delay

%% To do: fix the delay normalize


%Set the dalay upper bound
input(input(:,3)>12000,3)=12000;


i=1;
[m,n]=size(input);
while(i<=m)
    %Delete some points based on tpt
    if(input(i,1)<-89 && input(i,2)>3)
        input(i,:)=[];
    elseif(input(i,1)>-85 && input(i,2)<4.5)
        input(i,:)=[];
    elseif(input(i,1)>-91 && input(i,2)<0.2)
        input(i,:)=[];
    %Delete some points based on delay
    elseif(input(i,1)>-89 && input(i,3)>750)
        input(i,:)=[];     
        
    else
        i=i+1;
    end
    
  
    

    
    
   [m,n]=size(input); 
end
temp=input(input(:,1)>-75,:);
temp2=temp(temp(:,1)<-50,:);

m_tpt=mean(temp2(:,2));
m_delay=mean(temp2(:,3));

out=input;
out(:,2)=out(:,2)/m_tpt;
out(:,3)=out(:,3)/m_delay;

out2=m_tpt;
out3=m_delay;