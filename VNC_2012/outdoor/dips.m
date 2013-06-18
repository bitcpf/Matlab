function out=dips(ideal_cont)


i=1;
[m,n]=size(ideal_cont);
while(i<=m)
    
    if(ideal_cont(i,1)<=-90 && ideal_cont(i,2)>1.2)
        ideal_cont(i,:)=[];
%     elseif(ideal_cont(i,1)<=-92)
%         ideal_cont(i,:)=[];
    elseif(ideal_cont(i,1)>=-80 && ideal_cont(i,2)<2)
        ideal_cont(i,:)=[];
           
    else
    i=i+1;
    end
    [m,n]=size(ideal_cont);
    
end
out=ideal_cont;