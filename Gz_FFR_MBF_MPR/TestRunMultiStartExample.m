%% Run |MultiStart|
% Consider a function with several local minima.

fun = @(x) x.^2 + 4*sin(5*x);
fplot(fun,[-5,5])
%% 
% To search for the global minimum, run |MultiStart| on 20 instances of 
% the problem using the |fmincon| |'sqp'| algorithm.

rng default % For reproducibility
opts = optimoptions(@FindSRFactor(x,BaseAIF_321, rr_base_stress, R10, TS, DT),'Algorithm','sqp');
problem = createOptimProblem('fmincon','objective',...
    fun,'x0',3,'lb',-5,'ub',5,'options',opts);
ms = MultiStart;
[x,f] = run(ms,problem,20)
%% 
% _Copyright 2012 The MathWorks, Inc._