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
% index1=1053;
% index2=1285;
% index1=1077;
% index2=1315;
% index1=1090;
% index2=1335;
index1=1052;
index2=1285;


ISTTOK.I_horS=double(data.SendToHorizontal(index1:index2));
ISTTOK.I_vertS=double(data.SendToVertical(index1:index2));

ISTTOK.I_hor=double(data.hor(index1:index2));
ISTTOK.I_vert=double(data.vert(index1:index2));
ISTTOK.Rc=double(data.R0(index1:index2));
ISTTOK.Zc=double(data.z0(index1:index2));

%% LETS smoothe the signals
%Nsmooth_u = max(round(5e-4/dt), 10);
dt=100e-6;
    Nsmooth_y = max(round(1e-4/dt), 10);
    
        
        Rc_smooth = smooth(ISTTOK.Rc,Nsmooth_y);
        Zc_smooth = smooth(ISTTOK.Zc,Nsmooth_y);


%%

inputs=[ISTTOK.I_vertS,ISTTOK.I_horS];
outputs=[ISTTOK.Rc,ISTTOK.Zc];
outputsSm=[Rc_smooth,Zc_smooth];
Ts=100e-6;
expP13=iddata(outputs,inputs,Ts);
expP13s=iddata(outputsSm,inputs,Ts);
