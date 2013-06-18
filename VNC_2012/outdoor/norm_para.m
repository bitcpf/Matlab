function out=norm_para(input_cont)
index_1=find(input_cont(:,1)>-70);
index_2=find(input_cont(index_1,1)<-50);

mid_cont=input_cont(index_1(index_2),2);
index=find(mid_cont>0);
out=mean(mid_cont(index));