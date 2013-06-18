%Pathloss exponent calculation
%Parameter: 1, input snr of one band,is a 1xn vector 2,path loss of the original band, 3,
%pathloss of the target band

function out=path_snrest(snrest_in,db_original,db_target)


i=1;
[m,n]=size(snrest_in);
while(i<=m)
    out(i)=snrest_in(i,1)-db_original+db_target;     
    i=i+1;
end
clear snrest_in