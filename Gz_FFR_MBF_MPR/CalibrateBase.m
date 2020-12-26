function error = CalibrateBase(x, Base, TS, R0)
TS_c(1) = TS;
TS_c(2) = TS.*x(1); % each TS is represented as a nominal times x where x is a positive number and also can have some bounds
TS_c(3) = TS.*x(2);

g = x(3:5);

b = g.*(1-exp(-TS_c.*R0));

Y = norm(b-Base);

error = Y;


