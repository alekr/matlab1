function [SI, Aout] = ComputeSR_f_only(f, rr, R, TS, tail)

% BaseAIF_321
% rr
% R10
% TS
% DT

% start by tryinf for f = 1 and k = 1 1 1

spoil = 0.1*TS;
Ain = 1;

[A(1), S(1), A_sp(1), S_sp(1)] = SR(Ain,f,R,TS, tail, spoil);
[A(2), S(2), A_sp(2), S_sp(2)] = SR(A(1),f,R,TS, tail, spoil);
[A(3), S(3), A_sp(3), S_sp(3)] = SR(A(2),f,R,TS, rr-3*TS-2*tail, spoil);

for i=1:5

[A(3*i+1), S(3*i+1), A_sp(3*i+1), S_sp(3*i+1)] = SR(A(3*i),f,R,TS, tail, spoil);
[A(3*i+2), S(3*i+2), A_sp(3*i+2), S_sp(3*i+2)] = SR(A(3*i+1),f,R,TS, tail, spoil);
[A(3*i+3), S(3*i+3), A_sp(3*i+3), S_sp(3*i+3)] = SR(A(3*i+2),f,R,TS, rr-3*TS-2*tail, spoil);

end

SI(1) = S(16);
SI(2) = S(17);
SI(3) = S(18);

Aout(1) = A(16);
Aout(2) = A(17);
Aout(3) = A(18);

% SI(1) = S_sp(16);
% SI(2) = S_sp(17);
% SI(3) = S_sp(18);
% 
% Aout(1) = A_sp(16);
% Aout(2) = A_sp(17);
% Aout(3) = A_sp(18);


%% minimise difference between what you found in baselines at this R10 and what your imperfect SR predicts
%% to do this you need to minimise a function that calulates norm between your measurements and the values you are getting from simulation
% you will no doubt find that you need to feed another set of info (e.g.
% your tail data into this to be able to get k values too


