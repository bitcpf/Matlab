

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
x1=vncdata(1,9)
x2=vncdata(2,9)
xt=x1:0.1:x2

y1=vncdata(1,25)
y2=vncdata(2,26)

yt=y1:0.1:y2


[x,y] =meshgrid(xt,yt);
z = vncdata(1,1:2);
mesh(x,y,z)