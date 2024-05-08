%% main script

%
clear all; clc; close all;

%% training

% 
ref = load("squaretrajectory.mat");
ref.ref = [[0; 0; 1.5;], ref.ref];
weights = [0.001; 0.001; 0.001; 0.001; 0.001; 0.001];
numIterations = 10;
training = 0;

% 
model = 'classprojectfinal'; 
totalSimulationTime = 10; % 75/4 + 75/8; 
set_param(model, 'StopTime', num2str(totalSimulationTime));
ts = timeseries(weights, 0);
f = timeseries(training, 0);
assignin('base', 'training', f');

% 
for i = 1:numIterations
    
    %
    ts.Time = i;  
    ts.Data = weights;

    % 
    assignin('base', 'weights', ts');
    simOut = sim(model);
    
    % weights = simOut.weights.Data(:, :, end);
    bookmark = simOut.weights;
    w_data = bookmark.Data;
    weights = w_data(:, :, end)
    [sz, ~] = size(simOut.y);
    reef = ref.ref';
    error = getErr(simOut.y, reef(1:sz, :), simOut.tout);
    
end

%% actual run

% run this if you want to skip training
% weights = [0.15; 0.4; 0.001; 0.001; 0.001; 0.001];
% weights = [0.0181; 0.0008; 0.0008; 0.0011; 0.0011; 0.0011];
weights = [0.001; 0.001; 0.001; 0.001; 0.001; 0.001];
ref = load("squaretrajectory.mat");
ref.ref = [[0; 0; 1.5;], ref.ref];
model = 'classprojectfinal'; 

%
training = 1;
totalSimulationTime = 75; 
set_param(model, 'StopTime', num2str(totalSimulationTime));
ts = timeseries(weights, 0);
f = timeseries(training, 0);
assignin('base', 'training', f');

%
ts.Data = weights;
assignin('base', 'weights', ts');
simOut = sim(model);

% results = simOut.y; % 3001x6
error = getErr(simOut.y, ref.ref', simOut.tout)

%%

%%

%%

%%

%%