clear all
close all

load idata_24.csv
load idata_52.csv
load idata_70.csv
load idata_90.csv
load gps_tx.csv



output=sortrows(idata_70,1);
sort90=sortrows(idata_90,2);
sort24=sortrows(idata_24,2);
sort52=sortrows(idata_52,2);

i=1;
[m,n]=size(output(:,1)-1);
while(i<m)
    
    if(output(i,1)==output(i+1,1))
        output(i,6)=(output(i,6)+output(i+1,6))/2;
        output(i,7)=(output(i,7)+output(i+1,7))/2;
        output(i,8)=(output(i,8)+output(i+1,8));
        output(i,9)=(output(i,9)+output(i+1,9))/2;
        output(i,10)=(output(i,10)+output(i+1,10));
         
        output(i+1,:)=[];
        
        
     

    else
     i=i+1;  
    end
[m,n]=size(output(:,1)-1);
    
end    


output(1:406,6)=output(1:406,6)+20;

i=1;
[m,n]=size(sort24(:,2)-1);
while(i<m)
    
    if(sort24(i,2)==sort24(i+1,2))
        sort24(i,6)=(sort24(i,6)+sort24(i+1,6))/2;
        sort24(i,7)=(sort24(i,7)+sort24(i+1,7))/2;
        sort24(i,8)=(sort24(i,8)+sort24(i+1,8));
        sort24(i,9)=(sort24(i,9)+sort24(i+1,9))/2;
        sort24(i,10)=(sort24(i,10)+sort24(i+1,10));
         
        sort24(i+1,:)=[];
        
        
     

    else
     i=i+1;  
    end
[m,n]=size(sort24(:,1)-1);
    
end    

i=1;
[m,n]=size(sort52(:,2)-1);
while(i<m)
    
    if(sort52(i,2)==sort52(i+1,2))
        sort52(i,6)=(sort52(i,6)+sort52(i+1,6))/2;
        sort52(i,7)=(sort52(i,7)+sort52(i+1,7))/2;
        sort52(i,8)=(sort52(i,8)+sort52(i+1,8));
        sort52(i,9)=(sort52(i,9)+sort52(i+1,9))/2;
        sort52(i,10)=(sort52(i,10)+sort52(i+1,10));
         
        sort52(i+1,:)=[];
        
        
     

    else
     i=i+1;  
    end
[m,n]=size(sort52(:,1)-1);
    
end    

i=1;
[m,n]=size(sort90(:,2)-1);
while(i<m)
    
    if(sort90(i,2)==sort90(i+1,2))
        sort90(i,6)=(sort90(i,6)+sort90(i+1,6))/2;
        sort90(i,7)=(sort90(i,7)+sort90(i+1,7))/2;
        sort90(i,8)=(sort90(i,8)+sort90(i+1,8));
        sort90(i,9)=(sort90(i,9)+sort90(i+1,9))/2;
        sort90(i,10)=(sort90(i,10)+sort90(i+1,10));
         
        sort90(i+1,:)=[];
        
        
     

    else
     i=i+1;  
    end
[m,n]=size(sort90(:,1)-1);
    
end    

% 
% i=1;
% [m,n]=size(gps_tx(:,2)-1);
% while(i<m-1)
%     if(gps_tx(i,1)==gps_tx(i+1,1) && i>1 && gps_tx(i-1,1)<gps_tx(i,1))
%         gps_tx(i+1,1)=gps_tx(i+1,1)+1;
%     end  
%     i=i+1
% [m,n]=size(gps_tx(:,1)-1);
%     
% end    








i=1;
[m,n]=size(output(:,1));
while(i<m)
    index24=find(sort24(:,2)==output(i,2));
    index52=find(sort52(:,2)==output(i,2));
    index90=find(sort90(:,2)==output(i,2));
    indexgps=find(gps_tx(:,1)==output(i,1));
    if(~isempty(index24) && ~isempty(index52) && ~isempty(index90))
        output(i,11:15)=sort24(index24,6:10);
        output(i,16:20)=sort52(index52,6:10);
        output(i,21:25)=sort90(index90,6:10);
        
        
    
        [dim1,dim2]=size(indexgps);
        
        if(dim1>0)
          output(i,26:28)=gps_tx(indexgps(1),2:4);
        else
            indexgps=find(gps_tx(:,1)==output(i-1,1));
            [dim1n,dim2n]=size(indexgps);
            if(dim1n>1)
                output(i,26:28)=gps_tx(max(size(indexgps)),2:4);
            else
                indexgps_h=find(gps_tx(:,1)==output(i+1,1));
                indexgps_l=find(gps_tx(:,1)==output(i-1,1));
                [d1h,d2l]=size(indexgps_h);
                [d1l,d2l]=size(indexgps_l);
                if(d1h>0 && d1l>0)
                output(i,26:28)=(sum(gps_tx(indexgps_h,2:4))+sum(gps_tx(indexgps_l,2:4)))/max((size(indexgps_h)+size(indexgps_l)));
                elseif(d1h==0 && d1l>0)
                    output(i,26:28)=gps_tx(indexgps_l,2:4);
                elseif(d1l==0 && d1h>0)
                    output(i,26:28)=gps_tx(indexgps_h,2:4);
                else
                    indexgps=find(gps_tx(:,1)==output(i+2,1));
                    [dim1n,dim2n]=size(indexgps);
                    if(dim1n>0)
                        output(i,26:28)=gps_tx(max(size(indexgps)),2:4);
                    end
                    
                    
                end
            end
        end
           
           
        
        
        
        
        
        
        
   
           
           i=i+1;
    else
        output(i,:)=[];
        
    end
    
    [m,n]=size(output(:,1));

end


output_s=zeros(size(output));

output_s(:,1:3)=output(:,1:3);
output_s(:,4)=output(:,26);
output_s(:,5)=output(:,4);
output_s(:,6)=output(:,27);
output_s(:,7)=output(:,5);
output_s(:,8)=output(:,28);


output_s(:,9)=output(:,6);




output_s(:,10)=output(:,11);
output_s(:,11)=output(:,16);
output_s(:,12)=output(:,21);


output_s(:,13)=output(:,7);
output_s(:,14)=output(:,12);
output_s(:,15)=output(:,17);
output_s(:,16)=output(:,22);


output_s(:,17)=output(:,9);
output_s(:,18)=output(:,14);
output_s(:,19)=output(:,19);
output_s(:,20)=output(:,24);

output_s(:,21)=output(:,10);
output_s(:,22)=output(:,15);
output_s(:,23)=output(:,20);
output_s(:,24)=output(:,25);


