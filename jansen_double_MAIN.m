%CODED BY : PUNEET DHEER
%DATE : 07-03-2017
%DOUBLE CORTICAL COLUMN MODEL
%REFERNCES
%[1]Jansen BH, Zouridakis G, Brandt ME (1993)
%   A neurophysiologically-based mathematical model of flash visual evoked potentials. 
%   Biol Cybern 68: 275-283
%[2]Jansen  BH,  Rit  VG  (1995)  Electroencephalogram  and  visual evoked potential 
%   generation in a mathematical model of coupled cortical columns. Biol Cybern 73: 357-366

function jansen_double_MAIN

tic
time=1:0.001:10; %in sec


% options = odeset('RelTol',1e-4,'AbsTol',1e-01)
options = odeset('RelTol',1e-01);

[t,y] = ode45(@jansen_double_F,[time],[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0],options);

%disp([y(end,1);y(end,2);y(end,3);y(end,4);y(end,5);y(end,6)])
%[t,y] = ode45(@jansen_F,[time],[y(end,1);y(end,2);y(end,3);y(end,4);y(end,5);y(end,6)],options);
% c=length(y);
% MEAN = 120; 
% SIGMA = 200;
% p= MEAN+(randn(c,1)*SIGMA);

EEG1 = y(:,2)-y(:,3); %PSP MAIN OUTPUT 1
EEG2 = y(:,8)-y(:,9); %PSP MAIN OUTPUT 2

% save('ALL_PSP.mat','y')
% save('EEG1.mat','EEG1')
% save('EEG2.mat','EEG2')

figure
plot(t,EEG1)
axis tight
title('ALPHA')
xlabel('Time Points (sec)')
ylabel('mV')

figure
plot(t,EEG2)
axis tight
title('BETA')
xlabel('Time Points (sec)')
ylabel('mV')

% figure
% plot(t,y)
% axis tight


%-----------------DISPLAY ALL----------------------------
figure
for jj=1:12
subplot(12,1,jj)
plot(t,y(:,jj))
axis tight
end
%--------------------------------------------------------

toc
end