%% Define c
NoInc = 100;
Increment = 0.2;

a = 2;
b = 2;
alpha = 4.5;
TS = 0.0769836;
f = +  0.03;

c = [0:NoInc]*Increment;


t10 = 2.0;
r0 = 1./t10;

TS_c = TS+f*c;
i = 1;
    while((TS_c(i)>0)&&(i<NoInc)>0)
        i = i+1;
    end


TS_c(i-1:end) = TS_c(i-1);

A = exp(-r0.*TS);
Amalo = A./(1-A);
N0 = Amalo*(1-exp(-alpha*TS.*c));
y = exp(TS_c.*c.*(r0.*f - alpha + alpha*c.*f));
% y = exp(TS_c.*c.*(r0.*f - alpha + alpha*c.*f));

plot(c, TS_c);hold on;

N = Amalo.*(1-y);

% N./Amalo = 1-y
% N./Amalo - 1 = -y
% 1-N/Amalo = y
% (Amalo - N)/Amalo = y
% log((Amalo - N)/Amalo) = log(y)



Nmj = 5.1375;
a0 = log((Amalo - Nmj)/Amalo);
a2 = alpha*f*TS;
a1 = TS*(r0*f-alpha);
a0 = -a0;

D = a1^2 - 4*a0*a2;

d = sqrt(D);

c1 = (-a1-d)/(2*a2)
c2 = (-a1+d)/(2*a2)

plot(c, N, c, N0,'b');
hold off;
% 
% N_calc = (exp(-r0.*TS)*(exp(r0.*TS.*c.*f)*exp(TS.*alpha.*c.^2.*f)*exp(-TS.*alpha.*c) - 1))/(exp(-r0.*TS) - 1);
% % plot(c, NormMinus1(i, :)); hold on;
% % pause(0.1);
% Amplitude(i) = -b./(b - a*exp(TS*r0(i)));
% fun = @(x)norm((x(1).*(1-exp(-x(2)*c)) - NormMinus1(i, :)));
% x0 = [Amplitude(i),0.1];
% x(i, :) = fminsearch(fun,x0);
% 
% y = x(i,1).*(1-exp(-x(i,2)*c));
% % plot(c, NormMinus1(i, :), 'b', c,y, 'rx' );
% % pause(0.5);
% % inis = [Amplitude(i), TS];
% %  [p(i,:), approx(i,:), error(i, :)]=FindSimplifiedConversionCurve(c, NormMinus1(i,:), Amplitude(i), inis);
% end
% hold off;
% 
% %% try fitting once again
% 
% % fun = @(x)norm((x(1).*(1-exp(-x(2)*c)) - NormMinus1(1, :)));
% % x0 = [20,0.1];
% % x = fminsearch(fun,x0)
% % 
% % y = x(1).*(1-exp(-x(2)*c));
% % plot(c, NormMinus1(1, :), 'b', c,y, 'rx' );
% 
% 
% % fun = @(x)100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
% % x0 = [-1.2,1];
% % x = fminsearch(fun,x0)
% 
% % inis = random('norm', 0.5, 1, 1, 100);
% % inis = inis.^2;
% % for i=1:100
% % [p(i,:), approx(i,:), error(i, :)]=FindSimplifiedConversionCurve(c, NormMinus1(1), Amplitude(21), inis(i));
% % end
% 
% %% return a, b, TS and r0 that satisfy your requirements, minimise departures between what you have and what you get after conversion
% % what you may wish to calibrate, for example initial amplitude to be vb
% % Inital amplitude =0.05BW/0.04BW*(1-0.45)
% % second amplitude = 0.05/0.24BW*(1-0.45)
% 
% % plot (c, NormMinus1, c, approx);
% % pause(2);
% 
% % plot(r0, Amplitude'); hold on;
% % pause(1);
% 
% load('TWINS_P17_1_data.mat');
% fout = fopen('temp.txt', 'w');
% options = optimset('TolX',1e-12, 'MaxFunEvals', 60000, 'MaxIter', 10000);
% time = data(:, 1) - data(1, 1);
% size(data);
% BaseStress = mean(data(1:10, 2:32));
% NormCurves = data(:, 2:32);
% N1 = NormCurves./BaseStress - 1;
% Max_N1 = max(N1);
% Max_N1 = max(Max_N1);
% B = exp(-TS*alpha);
% % u = B/(1-B);
% % v = TS*alpha;
% u = 1.1*Max_N1;
% v = 0.2;
% 
% %% step zero - flatten your baselines before you do anythig else
% %% trio at baseline stress
% TRIO = mean(data(1:10, 24:26));
% 
% start = [0.09, 0.09, 0.09, 1];
% 
% % fun0 = @(x)CalibrationStep0(x,data(:, 2:32), fout);
% base = fminsearch(@(x)CalibrationStep0(x,TRIO, fout), start);
% 
% start00 = [0.09, 0.09, 0.09];
% R10 = 1./2.076;
% 
% % fun0 = @(x)CalibrationStep00(x,data(:, 2:32),R10, fout);
% base3 = fminsearch(@(x)CalibrationStep00(x,TRIO,R10, fout), start00);
% 
% AIF1 = data(:, 24);
% AIF2 = data(:, 25);
% AIF3 = data(:, 26);
% 
% AIF1_base_corrected = AIF1;
% AIF2_base_corrected = AIF2.*(1-exp(-base3(1)*R10))./(1-exp(-base3(2)*R10));
% AIF3_base_corrected = AIF3.*(1-exp(-base3(1)*R10))./(1-exp(-base3(3)*R10));
% plot(time, AIF1_base_corrected, time, AIF2_base_corrected, time, AIF3_base_corrected);
% % pause(5);
% 
% aif1_base_corr = mean(AIF1_base_corrected(1:10));
% aif2_base_corr = mean(AIF2_base_corrected(1:10));
% aif3_base_corr = mean(AIF3_base_corrected(1:10));
% 
% aif1_norm_corr = AIF1_base_corrected./aif1_base_corr;
% aif2_norm_corr = AIF2_base_corrected./aif1_base_corr;
% aif3_norm_corr = AIF3_base_corrected./aif1_base_corr;
% 
% plot(time, aif1_norm_corr, time, aif2_norm_corr, time, aif3_norm_corr);
% % pause(5);
% 
% %% trio at baseline rest
% 
% TRIO = mean(data(101:110, 24:26));
% 
% start = [0.09, 0.09, 0.09, 1];
% 
% % fun0 = @(x)CalibrationStep0(x,data(:, 2:32), fout);
% base_rest = fminsearch(@(x)CalibrationStep0(x,TRIO, fout), start);
% 
% start00 = [0.09, 0.09, 0.09];
% R10 = 1./2.076;
% 
% % fun0 = @(x)CalibrationStep00(x,data(:, 2:32),R10, fout);
% base3_rest = fminsearch(@(x)CalibrationStep00(x,TRIO,R10, fout), start00);
%   
% %% trio at tail stress
% 
% TRIO = mean(data(91:100, 24:26));
% 
% start = [0.09, 0.09, 0.09, 1];
% 
% % fun0 = @(x)CalibrationStep0(x,data(:, 2:32), fout);
% tail_stress = fminsearch(@(x)CalibrationStep0(x,TRIO, fout), start);
% 
% start00 = [0.09, 0.09, 0.09];
% R10 = 1./2.076;
% 
% % fun0 = @(x)CalibrationStep00(x,data(:, 2:32),R10, fout);
% tail3_stress = fminsearch(@(x)CalibrationStep00(x,TRIO,R10, fout), start00);
% 
% 
% 
% fun1 = @(x)norm(max((log(x(1)./(x(1)-N1(:,23)))./x(2)))-10);
% x0 = [u,v];
% x = fminsearch(fun1,x0);
% 
% 
% %% here you find the parameters for each of the AIFs that will make them aligh bases and tails, no other requirements at this point
% AIF1 = N1(:,23);
% AIF2 = N1(:,24);
% AIF3 = N1(:,25);
% 
% TailS1 = AIF1(91:100);
% TailS2 = AIF2(91:100);
% TailS3 = AIF3(91:100);
% 
% BaseR1 = AIF1(101:110);
% BaseR2 = AIF1(101:110);
% BaseR3 = AIF1(101:110);
% 
% TailR1 = AIF1(191:200);
% TailR2 = AIF2(191:200);
% TailR3 = AIF3(191:200);
% 
% 
% u = 1.1*Max_N1;
% v = 0.2;
% 
% y0 = [100, 0.2, 200, 0.5, 300, 0.6];
% fout = fopen('temp.txt', 'w');
% 
% CurrentError = CalibrationStep1(y0,N1, fout);
% 
% % fun2 = @(x)(CalibrationStep1(y0,N1));
% options = optimset('TolX',1e-12, 'MaxFunEvals', 60000, 'MaxIter', 10000);
% [NewCalFactors, error, exitflag] = fminsearch(@(x)CalibrationStep1(x,N1, fout), y0, options);
% p = NewCalFactors;
% C1 = log(p(1)./(p(1)-AIF1))./p(2);
% C2 = log(p(3)./(p(3)-AIF2))./p(4);
% C3 = log(p(5)./(p(5)-AIF3))./p(6);
% 
% % top = u./(u-N1);
% % top = log(top);
% % C = top./v;
% 
% C = log(x(1)./(x(1)-N1))./x(2);
% 
% % plot(time, C(:, 17));
% % hold off;
% 
% %% here you try to fix the baselines for differences in TS and gains
% 
% RAW_AIFs = data(:, 24:26);
% z0 = [10, 10, 0.09, 10, 10, 0.09, 10, 10, 0.09];
% 
% Base_Params = fminsearch(@(x)CalibrationStep2(x,RAW_AIFs, fout), z0, options);
% 
% plot(time, N1(:, 23), time, N1(:, 24), time, N1(:, 25));
% plot(time, C1, time, C2, time, C3);
% fclose('all');
% % clear all;