function error = CalibrateBaseAndTail(x, Base, Tail, TS, R0)


TS_A = TS.*(1-x(1:3)); % each TS is represented as a nominal times x where x is a positive number and also can have some bounds

TS_D = TS.*(1-x(4:6));

g = x(7:9);

b = g.*(1-exp(-TS_A.*R0));

t = g.*(1-exp(-TS_D.*(x(10)*R0)));

% Y = norm(b-Base)+norm(t-Tail)+std(b)+std(t);
Y = norm(b-Base)+std(b)+std(t)./mean(t);

error = Y;

if min(x)<0
    error = error*2;
end

if max(x(1:6))>0.5
    error = error*2;
end

if x(10)>2
    error = error*2;
elseif x(10)<1.2
    error = error*2;
end;



