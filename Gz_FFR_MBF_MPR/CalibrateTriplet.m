function error = CalibrateTriplet(amplitude, Triplet, alpha, TS, R0);

x = TS;

k = x.*alpha;
a = amplitude;

C = log(a./(a-Triplet))./k';

error = std(C);


