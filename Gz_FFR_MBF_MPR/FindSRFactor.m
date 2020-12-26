function error = FindSRFactor(x,B, rr, R, TS, DT)

% x(1) = f;

ratios = B./B(:,3);
for i = 1:10
[SI(i, :), Aout(i, :)] = ComputeSR_f_only(x(1), rr, R, TS, DT);
end
computed_ratios = SI./SI(:,3);

% NewBase = 10*SI.*B(1);
% error1 = norm(B - NewBase); 

error = norm(ratios-computed_ratios);



% error = norm(B./B(1)-SI./(SI(1)));

if x(1)<0.80 
    error = 10^6;
    x(1) = 0.98;
elseif x(1)>0.99
    error = 10^6;
    x(1) = 0.88;
elseif min(x)<0
    error = 10^6;
end