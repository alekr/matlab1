function error = FindR_f_only(x, B, rr, TS, DT, f)

% x(1) = f;

[SI, Aout] = ComputeSR(f,rr, x, TS, DT);

error = norm(B./B(3)-SI./(SI(3)));
% x(1);

if x(1)<0 
    error = 10^6;
elseif x(1)>0.5
    error = 10^6;
end