%%
close all; clc;

%%

clearvars -except ref;

%%

% ref = [ref, [0; 0; 0;]];

%% 

% open('classprojectMPCmodel');
plant = linearize('classprojectMPCmodel');
plant = minreal(plant);

%%

Ts = 0.025;
p = 5;
m = 2;
mpcobj = mpc(plant, Ts, p, m);

%%

%
min1 = -0.01; % -0.0627
min2 = -0.02; % -0.0777

%
max1 = 0.01; % 0.0627
max2 = 0.02; % 0.0777

%
minrate = -1000; % -1000

% 
mpcobj.MV = struct('Min', {min1; min1; min1; min2; min2; min2}, ...
    'Max', {max1; max1; max1; max2; max2; max2}, ...
    'RateMin', {minrate; minrate; minrate; minrate; minrate; minrate});

%%

% mpcobj.Weights = struct('MV', [0 0 0 0 0 0], 'MVRate', [0.1 0.1 0.1 0.1 0.1 0.1], 'OV', [1 1 1 1 1 1]);
mpcobj.Weights = struct('MV', [0 0 0 0 0 0], 'MVRate', [0.01, 0.01, 0.01, 0.01, 0.01, 0.01], 'OV', [1 1 1 1 1 1]);

%%

mdl1 = 'classprojectPART2';
open_system(mdl1)
sim(mdl1)

%%

%
out = ans;
time = out.tout;
u = out.u;
y = out.y;

%%

refx1 = xTrap(ref(1, :), y(:, 1));
refx2 = xTrap(ref(2, :), y(:, 2));
refx3 = xTrap(ref(3, :), y(:, 3));
% refx = [refx1; refx2; refx3];

%%

%
err_x = errorr(refx1, y(:, 1));
err_y = errorr(refx2, y(:, 2));
err_z = errorr(refx3, y(:, 3));

%%

%
figure(2)
hold on
grid on

plot(time, y(:, 1), 'LineWidth', 1.5)
plot(time, refx1, 'LineWidth', 1.5)
title('Intertial X Quadrotor Position')
xlabel('Time [s]')
ylabel('Position')
legend('Actual Response', 'Desired Resposne')

hold off

%
figure(3)
hold on
grid on

plot(time, y(:, 2), 'LineWidth', 1.5)
plot(time, refx2, 'LineWidth', 1.5)
title('Intertial Y Quadrotor Position')
xlabel('Time [s]')
ylabel('Position')
legend('Actual Response', 'Desired Resposne')

hold off

%
figure(4)
hold on
grid on

plot(time, y(:, 3), 'LineWidth', 1.5)
plot(time, refx3, 'LineWidth', 1.5)
title('Intertial Z Quadrotor Position')
xlabel('Time [s]')
ylabel('Position')
legend('Actual Response', 'Desired Resposne')

hold off

%%


% mean square error

% video visualization

% show non-saturated control signals in appendix








%%