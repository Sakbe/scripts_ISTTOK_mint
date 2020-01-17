%%%% For checking the PIDs
close all
clear all
load('shot_48355.mat');
index1=1015;         
index2=1260;

% Negative flat-top
index3=1280;         
index4=1530;

R=double(data.R0(index1:index2));
Z=double(data.z0(index1:index2));
I_vert=data.SendToVertical(index1:index2);
 I_hor=data.SendToHorizontal(index1:index2);
%    I_vert=double(data.vert(index1:index2));
%    I_hor=double(data.hor(index1:index2));

Rn=double(data.R0(index3:index4));
Zn=double(data.z0(index3:index4));
I_vertn=data.SendToVertical(index3:index4);
 I_horn=data.SendToHorizontal(index3:index4);
time=1e-6*data.time(index1:index2);
Ts=100e-6;

startTime=time(1);
stopTime=time(end);
Input1=[I_vert,I_hor];
Input1=double(Input1);
Outputs1=[R,Z];
Outputs1=double(Outputs1);


Input1n=[I_vertn,I_horn];
Input1n=double(Input1n);
Outputs1n=[Rn,Zn];
Outputs1n=double(Outputs1n);

Outputs2_SISO=Outputs1(:,2);
Outputs1_SISO=Outputs1(:,1);
 Input2_SISO=Input1(:,2);
  Input1_SISO=Input1(:,1);
  
  Outputs2_SISOn=Outputs1n(:,2);
Outputs1_SISOn=Outputs1n(:,1);
 Input2_SISOn=Input1n(:,2);
  Input1_SISOn=Input1n(:,1);