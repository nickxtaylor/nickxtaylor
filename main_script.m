%% main script

%
clear all; clc; close all;

%% training

% 
weights = [0.15; 0.4; 0.001; 0.001; 0.001; 0.001];
numIterations = 5;
training = 0;

% 
model = 'classprojectfinal'; 
totalSimulationTime = 75/4 + 75/8; 
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
    
end

%% actual run

% run this if you want to skip training
weights = [0.15; 0.4; 0.001; 0.001; 0.001; 0.001];
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
ref = load("squaretrajectory.mat");
ref.ref = [[0; 0; 1.5;], ref.ref];
error = getErr(simOut.y, ref.ref', simOut.tout)

%%

%%

%%

%%

%%