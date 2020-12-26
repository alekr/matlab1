%% how to get R values from three AIFs that you feed into a script
% a function takes three values taken at the same time x[1 2 3]
% where they are taken from slice 3 2 1 in that order
% your question is first: what is the most likely optimised and averaged f
% = saturation efficiency 
% to do this initially, you feed R0 and rr into equations and the only parameters
% you are interested in is k [1 2 3] coil gains and f. To make sure you have enough data for this you can also use the tail of the AIF where you 
% don't have the R but you know that the values you get for R must be the
% same for all three curves. You can then use baseline from the rest scan
% with updated rrs and also tail values from the rest using the same
% function 
% so you essentially have two different objectives - first to match baseline
% to known R0 - this is your function with input (x = SI 3 2 1 and rr) to
% return f and k1 2 3 - you may not have enough data for this?
% then you have a function that only looks for equivalence of extracted Rs
% in three slices - this is going to be well hard.

%% How to do this?
%% start from what you have - three baseline values, R10
%% TS,DT (dead tail time), rr in scan
%% what you don't know and are trying to fit: f and coil factors 
TS = 0.09;
DT = 0.065;
rr = 0.70;
R10 = 1/1.897;

load('TWINS_P17_1_data.mat');

time = D(:, 1);
for i = 2:100
    delta_t_stress(i-1) = time(i) - time(i-1);
    delta_t_rest(i-1) = time(i+100) - time(i+99);
end
rr_base_stress = mean(delta_t_stress(1:10));
rr_base_rest = mean(delta_t_rest(1:10));

rr_tail_stress = mean(delta_t_stress(90:99));
rr_tail_rest = mean(delta_t_rest(90:99));



AIFs = D(:, 24:26);
Base_Stress = mean(AIFs(1:10, :));
Tail_Stress = mean(AIFs(91:100, :));
Base_Rest = mean(AIFs(101:110, :));
Tail_Rest = mean(AIFs(191:200, :));

BaseAIF_321(1) = Base_Stress(3);
BaseAIF_321(2) = Base_Stress(2);
BaseAIF_321(3) = Base_Stress(1);

TailAIF_321(1) = Tail_Stress(3);
TailAIF_321(2) = Tail_Stress(2);
TailAIF_321(3) = Tail_Stress(1);

RestBaseAIF_321(1) = Base_Rest(3);
RestBaseAIF_321(2) = Base_Rest(2);
RestBaseAIF_321(3) = Base_Rest(1);

RestTailAIF_321(1) = Tail_Rest(3);
RestTailAIF_321(2) = Tail_Rest(2);
RestTailAIF_321(3) = Tail_Rest(1);


f = 1;
k = ones(1,3);

x0 = [0.8];

[SI] = ComputeSR(f, k(1), k(2), k(3), rr, R10, TS, DT);

options = optimset('TolX',1e-12, 'MaxFunEvals', 60000, 'MaxIter', 10000);
[NewCalFactors, error, exitflag] = fminsearch(@(x)FindSRFactor(x,BaseAIF_321, rr_base_stress, R10, TS, DT), x0, options);

f = NewCalFactors(1);

%% get R1 in tail please

% GetR()
y0 = 2.5*R10;

[R1_at_C, error, exitflag] = fminsearch(@(x)FindR(x, TailAIF_321, rr_tail_stress, TS, DT, f, k1, k2, k3), y0, options);

T1_at_C = 1./R1_at_C

%% now for rest base

[R1_at_D, error, exitflag] = fminsearch(@(x)FindR(x, RestBaseAIF_321, rr_base_rest, TS, DT, f, k1, k2, k3), y0, options);

T1_at_D = 1./R1_at_D

%% PLEASE CAN YOU DO THE BEST YOU CAN WITH FITTING F ONLY
x0 = 0.9;
options = optimset('TolX',1e-12, 'MaxFunEvals', 60000, 'MaxIter', 10000);
[F, error, exitflag] = fminsearch(@(x)FindSRFactor(x,BaseAIF_321, rr_base_stress, R10, TS, DT), x0, options);

x0 = 0.5;
[F1, error, exitflag] = fminsearch(@(x)FindSRFactor(x,BaseAIF_321, rr_base_stress, R10, TS, DT), x0, options);
