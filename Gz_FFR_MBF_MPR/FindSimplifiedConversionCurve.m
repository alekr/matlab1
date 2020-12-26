function [p, approx, error]=FindSimplifiedConversionCurve(c, Minus1, Amplitude, inis)


% start=[0.1, 0.1, 0.1];%0.1 times three
% start = inis;
% inis = [0.09];
start = inis;
plot(c,Minus1,'ro'); hold on; h = plot(c,Minus1,'g'); hold off;

%% copied from earlier NM code
outputFcn = @(x,optimvalues,state) out_MonoExp(x,optimvalues,state,c,Amplitude,h);
options = optimset('OutputFcn',outputFcn,'TolX',1e-12, 'MaxFunEvals', 60000, 'MaxIter', 10000);%changed from 0.1
% options = optimset('OutputFcn',outputFcn,'TolX',1e-12, 'MaxFunEvals', 600000, 'MaxIter', 100000);%changed from 0.1
[estimated_lambda, error, exitflag] = fminsearch(@(x)MonoExp(x,c,Amplitude),start,options);

% results of the search
p=estimated_lambda';
% pause(10);
approx = p(2)*(1-exp(-p(1).*c));
plot(c, Minus1,'b', c, approx, 'rx');
pause(0.0022);
return;
