%%Make the context snr table
%Find similar snr in one band and estimate other bands snr
function out=context_table(context_info,column1,column2,column3,column4)

low_snr=floor(min(context_info(:,column1)));
high_snr=ceil(max(context_info(:,column1)));


out(:,1)=low_snr:high_snr;


i=1;
[m,n]=size(out);
while(i<=m)
    index1=find(context_info(:,1)>(out(i,1)-1));
    index2=find(context_info(index1,1)<(out(i,1)+1));
    
    out(i,2)=mean(context_info(index2,column2));
    out(i,3)=mean(context_info(index2,column3));
    out(i,4)=mean(context_info(index2,column4));
    i=i+1;
end