%% Try to figure out best TSs in stress
load('gzFFR_017_scan1_Stress.txt.AIF_set9_RS.AIF_stuff.mat');
SI_A = q_aif_S(:, 6);
SI_B = q_aif_S(:, 10);
SI_C = q_aif_S(:, 26);

SI_D = q_aif_R(:, 6);
SI_E = q_aif_R(:, 10);
SI_F = q_aif_R(:, 26);

c = [0:30]*0.5;

TS = 0.09; %nominal SR prep time
alpha = 4.5;% T1 relaxivity
R0 = 1/1.897;
k = alpha*R0;
delta = 0.05;

ME = SI_B./SI_A-1; % Max enhancement
TE = SI_C./SI_A-1; % Tail Enhancement

A = exp(-TS*R0);
a = A./(1-A);

ME_ceil = (1+delta)*ME;

A_ceil = ME_ceil./(1+ME_ceil);

TS_ceil = log(1./A_ceil)./R0

a_ceil = A_ceil./(1-A_ceil);
k_ceil = TS_ceil*alpha;

Comp_N1 = a_ceil.*(1-exp(-k_ceil.*c));
Nom_N1 = a.*(1-exp(-k.*c));
plot(c, Nom_N1, c, Comp_N1);


C_max = log(a_ceil./(a_ceil - ME))./k_ceil
C_tail = log(a_ceil./(a_ceil - TE))./k_ceil

PointA_Gains = SI_A./(1-A_ceil)

Comp_A = PointA_Gains.*(1-A_ceil)

%% do the same for rest
rk = k;

rME = SI_E./SI_D-1; % Max enhancement
rTE = SI_E./SI_D-1; % Tail Enhancement

rA = exp(-TS*R0);
ra = rA./(1-rA);

rME_ceil = (1+delta)*rME;

rA_ceil = rME_ceil./(1+rME_ceil);

rTS_ceil = log(1./rA_ceil)./R0

ra_ceil = rA_ceil./(1-rA_ceil);
rk_ceil = rTS_ceil*alpha;

rComp_N1 = ra_ceil.*(1-exp(-rk_ceil.*c));
rNom_N1 = ra.*(1-exp(-rk.*c));
plot(c, rNom_N1, c, rComp_N1);


rC_max = log(ra_ceil./(ra_ceil - rME))./rk_ceil
rC_tail = log(ra_ceil./(ra_ceil - rTE))./rk_ceil

rPointA_Gains = SI_D./(1-rA_ceil)

rComp_D = rPointA_Gains.*(1-rA_ceil)

%% attempt to compute all stress concentration using this set
a_ceil_matrix = AIF_Stress; %% initialise
N1 = AIF_Stress./SI_A'-1;
cal = abs(N1./ME')
a_ceil_matrix(:, 1) = a_ceil(1);
a_ceil_matrix(:, 2) = a_ceil(2);
a_ceil_matrix(:, 3) = a_ceil(3);

k_ceil_matrix = AIF_Rest; %% initialise
k_ceil_matrix(:, 1) = k_ceil(1);
k_ceil_matrix(:, 2) = k_ceil(2);
k_ceil_matrix(:, 3) = k_ceil(3);

C_stress = log(a_ceil_matrix./(a_ceil_matrix - (N1)))./k_ceil_matrix

plot(Time_Stress, C_stress);
plot(Time_Stress, N1);
% plot(Time_Stress(50:98), C_stress(50:98, :));

amplitude = a_ceil;
Triplet = SI_C./SI_A - 1;
test = CalibrateTriplet(amplitude, Triplet, alpha, TS, R0);

options = optimset('TolX',1e-12, 'MaxFunEvals', 600000, 'MaxIter', 100000);

start = [0.03, 0.09, 0.12];

% fun0 = @(x)CalibrationStep0(x,data(:, 2:32), fout);
d = fminsearch(@(x)CalibrateTriplet(amplitude, Triplet, alpha, x, R0), start);

Triplet  = SI_B./SI_A - 1;
start = [0.03, 0.09, 0.12];
b = fminsearch(@(x)CalibrateTriplet(amplitude, Triplet, alpha, x, R0), start);

% for i = 1:1000
%     start = abs(random('Normal', 0.09, 0.09, [1, 3]));
%     [B(i, :), Berror(i)] = fminsearch(@(x)CalibrateTriplet(amplitude, Triplet, alpha, x, R0), start);
% end
% 
% for i = 1:1000
%     start = abs(random('Normal', 0.09, 0.09, [1, 3]));
%     [D(i, :), Derror(i)] = fminsearch(@(x)CalibrateTriplet(amplitude, Triplet, alpha, x, R0), start);
% end
inis = [1 1 100 100 100];
base_p = fminsearch(@(x)CalibrateBase(x, SI_A, TS, R0), inis, options);
tail_p = fminsearch(@(x)CalibrateBase(x, SI_D, TS, 2*R0), inis, options);




inis_bt = [0.05 0.05 0.05 0.05 0.05 0.05 100 100 100 1];
bt_p = fminsearch(@(x)CalibrateBaseAndTail(x, SI_A, SI_C, TS, R0), inis_bt, options);

