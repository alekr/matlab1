k = 1;
M0 = 1;
R = 1.5;
inc = 0.01;
srTime = [0:9]*inc;
tdTime = [0:15]*inc;
deadTime = [0:6]*inc;
deadTime(1) = 0.000001; 
deadTime(7) = 0.06-0.000001; 


start1 = 0;
Mz = start1 + (k*M0-start1)*(1-exp(-R*srTime));

MZtdInit = k*M0*ones(1, 7);
MzOverDead = MZtdInit;

MzOverTD =horzcat(MzOverDead, Mz);
BlockTime = horzcat(deadTime, srTime+0.06)';
%% second block
start2 = Mz(10);

MzOverDead2 = start2 + (k*M0-start2)*(1-exp(-R*deadTime));

MzOverTD2 =horzcat(MzOverDead2, Mz);

MzOverTD2 = horzcat(MzOverTD, MzOverTD2);
BlockTime2 = vertcat(BlockTime, BlockTime+0.15);

plot(BlockTime2, MzOverTD2);hold on;

%% third block
start3 = Mz(10);

MzOverDead3 = start3 + (k*M0-start3)*(1-exp(-R*deadTime));

MzOverTD3 =horzcat(MzOverDead3, Mz);

MzOverTD3 = horzcat(MzOverTD2, MzOverTD3);
BlockTime3 = vertcat(BlockTime2, BlockTime+0.30);

plot(BlockTime3, MzOverTD3);hold on;

%% end
rr = 1;

tail_time = rr-0.45;
no_tail = round(tail_time/inc);
FinalTime =[0: no_tail]*inc;
start4 = Mz(10);

FinalTime(1) = 0.000001; 
FinalTime(no_tail+1) = tail_time-0.000001;


MzOverDead4 = start4 + (k*M0-start4)*(1-exp(-R*FinalTime));

MzOverTD4 =horzcat(MzOverDead4, Mz);

MzOverTD4 = horzcat(MzOverTD3, MzOverTD4);
BlockTime4 = vertcat(BlockTime3, BlockTime+0.45);

plot(BlockTime4, MzOverTD4);hold on;

% start = 0.02;
% Mz = start + (k*M0-start)*(1-exp(-R*srTime));
% plot(srTime, Mz);

hold off;



