f = 0.85;
R = 1/1.8;
TS = 0.09;
tail = 0.065;
rr = 0.77;
Iteration = [0:17]*1 +1;

%% start by asigning amplitude 1
spoil = 0;
Ain = 10;

[A(1), S(1), A_sp(1), S_sp(1)] = SR(Ain,f,R,TS, tail, spoil);
[A(2), S(2), A_sp(2), S_sp(2)] = SR(A(1),f,R,TS, tail, spoil);
[A(3), S(3), A_sp(3), S_sp(3)] = SR(A(2),f,R,TS, rr-3*TS-2*tail, spoil);

for i=1:5

[A(3*i+1), S(3*i+1), A_sp(3*i+1), S_sp(3*i+1)] = SR(A(3*i),f,R,TS, tail, spoil);
[A(3*i+2), S(3*i+2), A_sp(3*i+2), S_sp(3*i+2)] = SR(A(3*i+1),f,R,TS, tail, spoil);
[A(3*i+3), S(3*i+3), A_sp(3*i+3), S_sp(3*i+3)] = SR(A(3*i+2),f,R,TS, rr-3*TS-2*tail, spoil);

end


S(16)/S(17)
S(16)/S(18)
S_sp(16)/S_sp(17)
S_sp(16)/S_sp(18)
% plot(Iteration, A);
plot(Iteration(4:end), S(4:end), 'r'); hold on;
plot(Iteration(4:end), S_sp(4:end), 'x'); 
axis([1, 15, 0, 1]);