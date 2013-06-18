clear all
close all
data_rssi=load('set2.csv');

plot(data_rssi(:,1))
hold on
plot(data_rssi(:,2),'r')
