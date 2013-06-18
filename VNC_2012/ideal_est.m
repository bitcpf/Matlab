%snrest colum 9-12 estimation from 450MHz
function out=ideal_est(snr_info,contex_tab)

i=1;
[m,n]=size(snr_info);
while(i<=m)
    in_snr=ceil(snr_info(i));
    index=find(contex_tab(:,1)==in_snr);
    out(i,:)=contex_tab(index,:);
    i=i+1;
end