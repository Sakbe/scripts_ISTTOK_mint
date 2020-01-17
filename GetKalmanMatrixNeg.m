%% Design kalman filter

function [Q,R,N]=GetKalmanMatrixNeg(y,u,dt,t,H)


Ns = length(t);
Nx = 10;
Ny = 2;
Nu = 2;

% if loadflag == 0


    % Smooth u,y
    Nsmooth_u = max(round(5e-4/dt), 10);%this is in the GAM
    Nsmooth_y = max(round(1e-4/dt), 10); %this is in the GAM
%     Nsmooth_u = max(round(4e-5/dt), 5);
%     Nsmooth_y = max(round(4e-5/dt), 5);
    for i = 1 : Nu;
        usmooth(:,i) = smooth(u(:,i),Nsmooth_u);
    end
    % usmooth(:,Nu) = smooth(u(:,Nu),Nsmooth_u*10); % plasma current

    for i = 1 : Ny;
        ysmooth(:,i) = smooth(y(:,i),Nsmooth_y);
    end

    % % Filter u, y - alternativo
    % ysmooth = lsim(tf(1, [5e-2,1])*eye(Ny), y, t);
    % usmooth = lsim(tf(1, [1e-4,1])*eye(Nu), u, t);

    % Inputs covariance matrix
    vu = u-usmooth;
    vu=u;
    Q = zeros(Nu);
    for i = 1 : Ns
        Q = Q + 1/Ns * vu(i,:)'*vu(i,:);
    end

    % Outputs covariance matrix
    
    vy = (y-ysmooth)-(H*vu')';
   % vy = (y)-(H*vu')';
    R = zeros(Ny);
    for i = 1 : Ns
        R = R + 1/Ns * vy(i,:)'*vy(i,:);
    end

    % I/O covariance matrix
    N = zeros(Nu,Ny);
    for i = 1 : Ns
        N = N + 1/Ns * vu(i,:)'*vy(i,:);
    end      

