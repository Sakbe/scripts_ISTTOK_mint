close all 
clear all


%%%% Re-do positive model

% load('shot_48357.mat')   %PID -CC
%  load('shot_48359.mat');   %PID - CC
%   load('shot_48365.mat');   %MIMO
 %load('shot_48366.mat');   %MIMO
%load('shot_48367.mat');   %PID
%load('shot_48369.mat');  %MIMO
% load('shot_48371.mat');   %PID
%load('shot_48375.mat');     %MIMO
% load('shot_48372.mat');     %PID
%load('shot_48376.mat');     %MIMO         %10
%  load('shot_48386.mat');     %MIMO
% load('shot_48389.mat');     %PID
 load('shot_48391.mat');     %MIMO
%%% shots no used for modelling
 load('shot_48392.mat');   


%%
% 
% index1=1046;
% index2=1293;
% index1=1045;
% index2=1294;
% index1=995;
% index2=1237;
% index1=1029;
% index2=1260;
% index1=1089;
% index2=1335;
% index1=1025;
% index2=1243;
% index1=1089;
% index2=1335;
%  index1=1045;
%  index2=1280;
% index1=1022;
% index2=1266;
% index1=1053;      %10
% index2=1285;
% index1=1077;
% index2=1315;
% index1=1090;
% index2=1335;
index1=1052;
index2=1285;
%%% shots didnt use the modelling
index1=
index2=

%%%%
%%%%% decide to do it wt send or not sent

R=double(data.R0(index1:index2));
Z=double(data.z0(index1:index2));
R_kal=data.R0_Kalman(index1:index2);
Z_kal=data.z0_Kalman(index1:index2);
I_vert=data.SendToVertical(index1:index2);
 I_hor=data.SendToHorizontal(index1:index2);
%    I_vert=double(data.vert(index1:index2));
%    I_hor=double(data.hor(index1:index2));
time=1e-6*data.time(index1:index2);
Ts=100e-6;

Vert_smlnk=[time',I_vert];
Hor_smlnk=[time',I_hor];
Vert_smlnk=double(Vert_smlnk);
Hor_smlnk=double(Hor_smlnk);
startTime=time(1);
stopTime=time(end);
startTimesmlk=0;
stopTimesmlk=0.03;

ref=[1,1]'*ones(size(time));
refR=[time',ref(1,:)'];
refz=[time',ref(2,:)'];
Z_smlnk=[time',Z];
R_smlnk=[time',R];
%%% inputs
Input=[I_vert,I_hor,R,Z];
Input=double(Input);
Input1=[I_vert,I_hor];
Input1=double(Input1);
Outputs1=[R,Z];
Outputs1_k=[R_kal,Z_kal];
Outputs1=double(Outputs1);
Outputs1_k=double(Outputs1_k);
exp=iddata(Outputs1,Input1,Ts);
exp_kal=iddata(Outputs1_k,Input,Ts);

%%% load model 

load('ISTTOK_model_Send_pos2.mat');
ss_pos=ss_pos2;

[dummy,dummy1,x0_neg] =compare(ss_pos,exp);
[dummy,dummy1,x0_neg_kal] =compare(ss_pos,exp_kal);
