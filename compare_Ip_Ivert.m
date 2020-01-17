%%
figure(2)
subplot(3,1,1)
plot(data.Ip_magn)
hold on
grid on
subplot(3,1,2)
plot(data.vert)
hold on
plot(data.SendToVertical)
subplot(3,1,3)
plot(data.Dis_stat)

% figure(3)
% plot(data.R0)
% hold on
% grid on
% plot(data.R0_Kalman)