%% Check only negative LQR
close all
clear all
clc

%load('shot_47771.mat');% good x0?Klamna filter 
% load('shot_47774.mat'); %shit
% load('shot_47793.mat');% more or less
% load('shot_47794.mat'); % bad
% load('shot_47796.mat'); % good
 load('shot_47797.mat');% good 
%  load('shot_47805.mat');% good
%  load('shot_47812.mat');
%  load('shot_47860.mat');
%  load('shot_47880.mat');  %10
%  load('shot_47939.mat');
%  load('shot_47943.mat');
%  load('shot_47944.mat');
% load('shot_47946.mat');
%  load('shot_47947.mat');
%  load('shot_47951.mat');
%  load('shot_48091.mat');
%  load('shot_48099.mat');
%  load('shot_48119.mat');
%  load('shot_48130.mat');  %20
%  load('shot_48140.mat');
%  load('shot_48153.mat');  %PID
%  load('shot_48155.mat');  %PID,inicio MIMO 1 ms
%  load('shot_48160.mat');
%  load('shot_48161.mat');
%  load('shot_48162.mat');
 load('shot_48182.mat');

 
load('ISTTOK_model_Send_neg.mat');
%%x
% index1=2495;
% index2=2739;

% index1=2692;
% index2=2897;
% 
% index1=1589;
% index2=1816;
% 
% index1=3226;
% index2=3454;
% 
% index1=2802;
% index2=3051;
% 
index1=3334;
index2=3578;
% 
% index1=1805;
% index2=2054;
% 
% index1=949;
% index2=1199;
% 
% index1=807;
% index2=1055;
% 
% index1=876;     %10
% index2=1119;
% 
% 
% index1=816;
% index2=1050;
% 
% index1=821;
% index2=1060;
% 
% index1=809;
% index2=1050;
% 
% index1=717;
% index2=962;
% 
% index1=1241;
% index2=1483;
% 
% index1=1303;
% index2=1460;
% 
% index1=332;
% index2=571;
% 
% 
% index1=1340;
% index2=1576;
% % 
% index1=810;
% index2=1057;
% 
% index1=1354;    %20
% index2=1593;
% 
% index1=1352;
% index2=1590;
% 
% index1=821;
% index2=1065;
% 
% index1=820;
% index2=1064;
% 
% index1=820;
% index2=1064;
% 
% index1=753;
% index2=990;
% 
% index1=1285;
% index2=1534;
% 
% 
% index1=821;
% index2=945;
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
[dummy,dummy1,x0_neg] =compare(ss_neg,exp);
[dummy,dummy1,x0_neg_kal] =compare(ss_neg,exp_kal);

 %% Kalman
 SYS_neg = ss(ss_neg.A,ss_neg.B , ss_neg.C, ss_neg.D, Ts);
B_errorNeg = [ss_neg.B,ss_neg.B];
SYS_neg = ss(ss_neg.A,B_errorNeg, ss_neg.C, zeros(2,4), Ts);

%load('KalmanMAtrixes_neg'); %% FRom Adriano script
%load('KalmanMAtrixes_neg47797.mat');
%%%% Re-calculate Adrianos filter
[Qn,Rn,Nn]=GetKalmanMatrixNeg(Outputs1,Input1,Ts,time,ss_neg.D);
[kest_neg, L_neg] = kalman(SYS_neg, Qn, Rn,Nn);
sys_negKAL=ss(kest_neg.A,kest_neg.B,kest_neg.C,kest_neg.D,Ts);	
%X0neg=[-0.1219579,	0.1357889,	0.8427376,	-0.3916806,	0.3457801,	0.0998817,	-0.0734193,	0.0101452,	-0.4403928,	-0.3972219];
X0neg=[0,0,0,0,0,0,0,0,0,0];
%X0neg=[-0.17493054497,	0.21391897502,	1.24686115017,	-0.44560885444,	0.43737103362,	0.12814892605,	-0.02465469859,	-0.05798413952,	-0.31503640084,	-0.33100846918];

[Y_neg,lsimtime,X_neg_k]=lsim(sys_negKAL,Input,time,X0neg);


%%%%% Control design
close all
time=0:100e-6:0.03;
%R=[1e-6,1e-7];
%%
R=[1e-6,5e-4]; %This is on the GAM
R=[1e-10,7e-8]; %This is also on the GAM


R=diag(R);
%Q=[2e4,1e2,1e2,1,1,1,1,1,1,1];
Q=[8e1,1e-1,1e-2,1e-2,1e-2,1e1,1e1,1e-1,1e-2,1e-2]; %This is on the GAM
Q=[1e2,0.5,3e-2,1e-9,1e-9,1e-9,1e-9,1e-9,1e-9,1e-9]; %This is also on the
%Q=ss_neg.C'*ss_neg.C;
%GAM

Q=1e1*diag(Q);
%Q = ss_pos.C'*ss_pos.C;

[K_neg,S,e] = dlqr(ss_neg.A,ss_neg.B,Q,R) ;
Ac = [(ss_neg.A-ss_neg.B*K_neg)];

N_neg=rscale(ss_neg.A,ss_neg.B,ss_neg.C,ss_neg.D,K_neg);
%%
x0_GAM=pinv(ss_neg.C)*Outputs1(1,:)';
sys_cl_neg = ss(Ac,ss_neg.B,ss_neg.C,ss_neg.D,Ts);
ref=([0.025,0.001])'*ones(size(time));
[y_cntrl,timel,x_neg]=lsim(sys_cl_neg,N_neg*ref,time,ss_neg.X0);
inputs_neg=N_neg*ref-K_neg*x_neg';


%% Check the states

%%%%%positive
time=1e-6*data.time(index1:index2);
[yl,timel,x]=lsim(ss_neg,Input1,time,X0neg);

figure(2)
suptitle('States comparision')
subplot(2,2,1)
plot(Y_neg(:,7),'LineWidth',2)
hold on
plot(X_neg_k(:,5),'LineWidth',2)
grid on
subplot(2,2,2)
plot(Y_neg(:,8),'LineWidth',2)
hold on
plot(x(:,6),'LineWidth',2)
grid on
subplot(2,2,3)
plot(Y_neg(:,9),'LineWidth',2)
hold on
plot(x(:,7),'LineWidth',2)
grid on
subplot(2,2,4)
plot(Y_neg(:,10),'LineWidth',2)
hold on
plot(x(:,8),'LineWidth',2)
grid on

%% plotting
%%
R=double(data.R0(index1:index2));


figure(1)
subplot(2,1,1)
title('Radial Centroid Position')
plot(Y_neg(:,1),'LineWidth',2)
hold on
plot(R)
hold on
plot(R_kal,'.-')
grid on
legend('Kalman','Real','Kalman_GAM')
subplot(2,1,2)
plot(Y_neg(:,2),'LineWidth',2)
hold on
plot(Z)
plot(Z_kal,'.-')
legend('Kalman','Real','KAlman_GAM')
 grid on
 return
 %% Check GAM algorithm
 buff=zeros(length(index1:index2),1);
 %X0neg=[-0.17493054497,	0.21391897502,	1.24686115017,	-0.44560885444,	0.43737103362,	0.12814892605,	-0.02465469859,	-0.05798413952,	-0.31503640084,	-0.33100846918];

 for x=1:length(index1:index2)
 
     for j=1:2
         for i=1:10
             	
             buff(x)=buff(x)+kest_neg.C(j,i)*X0neg(i)';
         end
         y_est(x,j) = buff(x);
     end
     y_est(x,1)=kest_neg.D(1,3)*Input(x,3)+kest_neg.D(1,4)*Input(x,4);
     y_est(x,1) =y_est(x,1)+ buff(x);
      y_est(x,2)=kest_neg.D(2,3)*Input(x,3)+kest_neg.D(2,4)*Input(x,4);
       y_est(x,2) =y_est(x,2)+ buff(x);
 end
 
 %% Lets try some pole placement
 p=[-0.5,-0.2,0.2,0.1+0.1i,0.1-0.1i,-0.7,0.9,-0.3+0.5i,-0.3-0.5i,0.5];
  p=[0.1,0.2,0.3,0.4,0.5,-0.1-0.1i,-0.1+0.1i,-0.33,-0.66,-0.99];

 K_neg_pol=place(ss_neg.A,ss_neg.B,p);