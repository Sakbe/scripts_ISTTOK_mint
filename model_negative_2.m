close all 
clear all


%%%% Re-do negative model

%load('shot_48182.mat')
% load('shot_48162.mat');
% load('shot_48161.mat');
% load('shot_47771.mat');
% load('shot_47805.mat');
% load('shot_48153.mat');  %PID
% load('shot_48119.mat');
load('shot_48155.mat'); 
load('shot_48161.mat');
%%
% 
% index1=821;
% index2=945;
% index1=1285;
% index2=1534;
% index1=753;
% index2=990;
% index1=2495;
% index2=2739;
% index1=1805;
% index2=2054;
% index1=821;
% index2=1065;
% index1=810;
% index2=1057;
index1=820;
index2=1064;
index1=753;
index2=990;


ISTTOK.I_horS=double(data.SendToHorizontal(index1:index2));
ISTTOK.I_vertS=double(data.SendToVertical(index1:index2));

ISTTOK.I_hor=double(data.hor(index1:index2));
ISTTOK.I_vert=double(data.vert(index1:index2));
ISTTOK.Rc=double(data.R0(index1:index2));
ISTTOK.Zc=double(data.z0(index1:index2));

inputs=[ISTTOK.I_vertS,ISTTOK.I_horS];
outputs=[ISTTOK.Rc,ISTTOK.Zc];
Ts=100e-6;
expN9=iddata(outputs,inputs,Ts);

%% Re-do model including the plasma current in the outputs

close all 
clear all


%%%% Re-do negative model

%load('shot_48182.mat')
% load('shot_48162.mat');
% load('shot_48161.mat');
% load('shot_47771.mat');
% load('shot_47805.mat');
% load('shot_48153.mat');  %PID
% load('shot_48119.mat');
load('shot_48155.mat'); 
load('shot_48161.mat');

% 
% index1=821;
% index2=945;
% index1=1285;
% index2=1534;
% index1=753;
% index2=990;
% index1=2495;
% index2=2739;
% index1=1805;
% index2=2054;
% index1=821;
% index2=1065;
% index1=810;
% index2=1057;
index1=820;
index2=1064;
index1=753+17;
index2=990;


ISTTOK.I_horS=double(data.SendToHorizontal(index1:index2));
ISTTOK.I_vertS=double(data.SendToVertical(index1:index2));
ISTTOK.I_prim=double(data.prim(index1:index2));

ISTTOK.I_hor=double(data.hor(index1:index2));
ISTTOK.I_vert=double(data.vert(index1:index2));
ISTTOK.Rc=double(data.R0(index1:index2));
ISTTOK.Zc=double(data.z0(index1:index2));
ISTTOK.Ip=double(data.Ip_magn(index1:index2));

inputs=[ISTTOK.I_vertS,ISTTOK.I_horS,ISTTOK.I_prim];
outputs=[ISTTOK.Rc,ISTTOK.Zc,ISTTOK.Ip];
Ts=100e-6;
expN8=iddata(outputs,inputs,Ts);
