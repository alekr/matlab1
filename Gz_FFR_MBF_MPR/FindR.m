function error = FindR(x, B, rr, TS, DT, f, k1, k2, k3)

% x(1) = f;
% x(2) = k1
% x(2) = k2
% x(3) = k3;


[SI] = ComputeSR(f, k1, k2, k3, rr, x, TS, DT);

B_scaled(1) = B(1)/k1;
B_scaled(2) = B(2)/k2;
B_scaled(3) = B(3)/k3;

SI_scaled(1) = SI(1)/k1;
SI_scaled(2) = SI(2)/k2;
SI_scaled(3) = SI(3)/k3;

error = norm(B_scaled./B_scaled(1)-SI_scaled./(SI_scaled(1)));
% x(1);

if x(1)<0 
    error = 10^6;
elseif x(1)>0.5
    error = 10^6;
end