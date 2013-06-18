

%%Input file format: 
% GPS time, Board Time, RX velocity, TX Velocity, RX Latitude, RX
% Longitude, TX latitude, TX longtitude, 4 RSSI(2.4,5.2,450,900), 4 Tpt, 4
% Delay, 4 Activity Level
% 

% Input data should be named as vncdata;

% Output data is tpt accuracy and delay accuracy
% Each metric has 5 value, means input 1 band RSSI for 4 bands, then input
% all four band rssi

clear all
close all

load 3d_data.mat; %%Measured data

[m,n]=size(vncdata)
for i=1:(m-1)
x1=vncdata(i,9);
x2=vncdata(i+1,9);
xt=x1:0.01:x2

y1=vncdata(i,25);
y2=vncdata(i+1,25);

yt=y1:0.01:y2


[x,y] =meshgrid(xt,yt);
z = [vncdata(i,13),vncdata(i+1,13)];
mesh(x,y,z)
hold on;
end