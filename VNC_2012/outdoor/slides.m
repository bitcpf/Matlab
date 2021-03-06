%%Generate graph for slides

clear all
close all
load region;
load ideal_24.csv;
load ideal_52.csv;
load ideal_45.csv;
load ideal_90.csv;
load ideal_70.csv;

ideal_24=dips(ideal_24);
ideal_52=dips(ideal_52);
ideal_45=dips(ideal_45);
ideal_90=dips(ideal_90);
ideal_70=dips(ideal_70);


%per_cont24=performance_context(ideal_24);
%per_cont52=performance_context(ideal_52);
%per_cont45=performance_context(ideal_45);
%per_cont90=performance_context(ideal_90);

per_cont24=ideal_24;
per_cont52=ideal_52;
per_cont45=ideal_45;
per_cont90=ideal_90;


% max_t_24=max(per_cont24(:,2));
% max_t_52=max(per_cont52(:,2));
% max_t_45=max(per_cont45(:,2));
% max_t_90=max(per_cont90(:,2));
% 
% per_cont24(:,2)=per_cont24(:,2)/max_t_24;
% per_cont52(:,2)=per_cont52(:,2)/max_t_52;
% per_cont45(:,2)=per_cont45(:,2)/max_t_45;
% per_cont90(:,2)=per_cont90(:,2)/max_t_90;


% per_cont24=dips(per_cont24);
% per_cont45=dips(per_cont45);
% per_cont52=dips(per_cont52);
% per_cont90=dips(per_cont90);
figure
plot(per_cont24(:,1),per_cont24(:,2),'.')
hold on

 plot(per_cont45(:,1),per_cont45(:,2),'c*')

index=find(per_cont90(:,1)>-85);
index2=find(per_cont90(index,2)<0.5);
per_cont90(index(index2),:)=[];
 plot(per_cont90(:,1),per_cont90(:,2),'ko')
 % plot(ideal_70(:,1),ideal_70(:,2),'rs')
plot(per_cont52(:,1),per_cont52(:,2),'r+')

%legend('2.4GHz','450MHz','900MHz','700MHz','Location','Southeast');
legend('2.4GHz','450MHz','900MHz','5GHz','Location','Southeast');
title('Raidos Performance');
xlabel('RSSI')
ylabel('Measured Throughput(MBps)')

%set(gca, 'ylim', [0, 1.2])
