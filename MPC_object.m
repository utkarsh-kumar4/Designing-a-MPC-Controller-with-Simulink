% Continuous plant transfer function definition
s = tf('s');
K = 0.05;
tau = 1000;
plant = K / (tau*s + 1);

% Discretized the plant with sample time Ts = 10 sec
Ts = 10;
plant_d = c2d(plant, Ts);

% Created the MPC object
mpc_object = mpc(plant_d, Ts);

% Set Prediction and Control horizons
mpc_object.PredictionHorizon = 12;
mpc_object.ControlHorizon = 3;

% Set weights
mpc_object.Weights.OutputVariables = 1;         % Weight on temperature tracking error
mpc_object.Weights.ManipulatedVariables = 0.1;  % Weight on control effort (u)

% Set constraints on input u (heater power %)
mpc_object.MV = struct('Min', 0, 'Max', 100);

save('MPC_object.m', 'mpc_object');
