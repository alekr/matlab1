function [Aout, SI, Aout_sp, SI_sp] = SR(Ain,f,R,TS, tail, spoil)

start = Ain*(1-f); % where A is your previous amplitude and f is your coil efficiency
SI = start + (1-start)*(1-exp(-TS*R));
Aout = start + (1-start)*(1-exp(-(TS+tail)*R)); % this is your out file without any complications

%% add spoilage

SI_sp = start + (1-start)*(1-exp(-(TS-spoil)*R));

start = SI; % you start from some smaller value, proportional to R, higher R (shorterT) higher damage you expect?

Aout_sp = start + (1-start)*(1-exp(-(tail-spoil)*R)); % this is your out file without any complications

%% please note that this is a gross simplification
