function out=gpgga(input)


dg=floor(input/100);
dot=mod(input,100)/60;
out=dg+dot;