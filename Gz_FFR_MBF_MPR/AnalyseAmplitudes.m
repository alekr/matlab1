%% Analyse how SI changes with rr and R
TS = 0.09;
tail = 0.065;
f = 0.9;
NoR1s = 202;
T1_inc = 10; % vary T1
T1 = [0:NoR1s-1]* T1_inc + T1_inc;
R = 1000./T1;

NoHRs = 18;
HR = [0:NoHRs-1]*5 + 40;
rr = 60./HR;

%% load reference
load('SI_at_f1.mat')
SI_f1 = SI;
%% compute matrix of SIs
for j = 1:NoR1s
    for i = 1:NoHRs

        [SI(i, j, :), Aout(i, j, :)] = ComputeSR_f_only(f, rr(i), R(j), TS, tail);

    end
end

HR_i = 5;
plot(T1, SI(HR_i, :, 1),'r', T1, SI(HR_i, :, 2),'g', T1, SI(HR_i, :, 3), 'b');hold on;
HR_i = 13;
plot(T1, SI(HR_i, :, 1),'rx', T1, SI(HR_i, :, 2),'gx', T1, SI(HR_i, :, 3), 'bx');hold on;

plot(T1, SI_f1(HR_i, :, 1),'c.', T1, SI_f1(HR_i, :, 2),'c.', T1, SI_f1(HR_i, :, 3), 'c.');hold off;


HR_i = 5;
plot(R(150:end), SI(HR_i, 150:end, 1),'r', R(150:end), SI(HR_i, 150:end, 2),'g', R(150:end), SI(HR_i, 150:end, 3), 'b');hold on;
HR_i = 13;
plot(R(150:end), SI(HR_i, 150:end, 1),'rx', R(150:end), SI(HR_i, 150:end, 2),'gx', R(150:end), SI(HR_i, 150:end, 3), 'bx');hold on;

plot(R(150:end), SI_f1(HR_i, 150:end, 1),'c.', R(150:end), SI_f1(HR_i, 150:end, 2),'c.', R(150:end), SI_f1(HR_i, 150:end, 3), 'c.');hold off;

