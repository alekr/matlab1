function [F, p, error, exitflag]=NM_WITH_INIS_fetchf_after_alignment(fit_time, fit_aif, fit_myo, inis)

%% fit
tinc=fit_time(2)-fit_time(1);

% start=[0.1, 0.1, 0.1];%0.1 times three
start = inis;

plot(fit_time,fit_myo,'ro'); hold on; h = plot(fit_time,fit_myo,'g'); hold off;

%% copied from earlier NM code
outputFcn = @(x,optimvalues,state) out_conv_function(x,optimvalues,state,fit_time,fit_aif,fit_myo,h);
options = optimset('OutputFcn',outputFcn,'TolX',1e-12, 'MaxFunEvals', 60000, 'MaxIter', 10000);%changed from 0.1
% options = optimset('OutputFcn',outputFcn,'TolX',1e-12, 'MaxFunEvals', 600000, 'MaxIter', 100000);%changed from 0.1
[estimated_lambda, error, exitflag] = fminsearch(@(x)conv_function(x,fit_time,fit_aif,fit_myo),start,options);

% results of the search
p=estimated_lambda';
% pause(10);
%% get fitting - MJH says LM algorithm is robust enough?
% the fits I saw were less than impressive
% JDBfit=conv2(fit_aif, (p(1) ./(1.0+exp(p(2)*fit_time-p(3)))),'same');
% JDBfit=conv(fit_aif, (p(1) ./(1.0+exp(p(2)*fit_time-p(3)))));
% JDBfit=JDBfit(1:length(fit_time));
% figure,plot(fit_time,fit_myo,'go',fit_time,JDBfit,'r-');
% pause;
% F=p(1)/(tinc*1.05)*60/(1+exp(-p(3))); % 1.05 is multiplied by tinc??
F=p(1)/(tinc*1.05)*60/(1+exp(-p(3))); % 1.05 is multiplied by tinc??
% F
return;
