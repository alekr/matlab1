function [p] = AnalyseAIF_10_Tail (time, aif, points_in_window, no_time_points, End_Time, colour, NumberInTail, rr);
SKIRT_limit = 2.0; % here you try to adjust onsets wrt skirt - initial gradual rise in signal that is sometimes simply cut off in the normal procedure


start_window_index = 1;
number_of_windows = no_time_points-start_window_index -points_in_window+2;
End_Base_Index = no_time_points; % just to initialise

Inc = time(3)-time(2);
%% When contrast comes in this is based on the assumption that techs count ten hbs before injecting
% you strip 2 points by default, this leaves you with 8 - this is an
% approximation because your HRs will be higher at stress but you can't do
% anything completely robust now, so this is the best you can do at this
% stage

% BolusIndex = ceil(8.0/Inc); 

% having looked at this, I changed my mind and decided to take 4 HBS ahead
% of the arrival in the LV as your starting point

% NumberInTail = ceil(10.0/Inc)
if Inc<0.5
    start_wobble = 8;
else
    start_wobble = 4;
end

for i = start_window_index:number_of_windows
    
    x = time(i: i+points_in_window-1);
    y = aif(i: i+points_in_window-1);
    [p] = polyfit(x, y, 1);
    slope(i) = p(1);
    intercept(i) = p(2);
%     %% add this
%     moving_average(i) = mean(y);
end;

[k, max_slope_index] = max(slope);
n = intercept(max_slope_index);

% number of windows for points = 5
NOW = no_time_points-start_window_index -5+2;

for i =start_window_index :NOW
    temp = aif(i: i+5-1);
    moving_average(i) = mean(temp);
end;

for i = (start_window_index+1):NOW 
     base_wobble(i) = 100 * (moving_average(i)-moving_average(i-1))/moving_average(i-1);
end

i = start_wobble;
while(base_wobble(start_wobble)<10.0)&&(i<NOW)
start_wobble = start_wobble+1;
end

End_Base_Index = start_wobble;

% line up
line = n+k*time;

[kd, min_slope_index] = min(slope);
nd = intercept(min_slope_index); 

% intervention Feb 2019
if (min_slope_index<max_slope_index)
temp = slope(max_slope_index:number_of_windows);
[kd, min_slope_index] = min(temp);
min_slope_index = min_slope_index + max_slope_index - 1;
nd = intercept(min_slope_index); 
end
% line down
line_d = nd+kd*time;

%% Tried to fix this - funny error appears in some parameters when I use transposed inputs
% line_d_FP = nd+kd*time';
%% Added Dec 2020
[r c] = size(line_d);
if (c==1)
temp = horzcat(line_d, aif);
else
    temp = horzcat(line_d', aif');
end

FirstPass = min(temp, [], 2);



% Now that you have identified onset index
% Compute baseline (adn define bs and be parameters)

% base_START = max(0,time(max_slope_index)-10); %% find start base as 10 seconds ahead of aif start or zero if that becomes negative
% i=1;
% while (time(i)<base_START) 
%     i = i+1;
% end;
% bs =max(3, i-1);
% while (time(i)<time(max_slope_index)-2) 
%     i = i+1;
% end;
% be = i-1;

%% NEW way of fixing AIF baseline

base_START = max(0,time(End_Base_Index)-10); %% find start base as 10 seconds ahead of aif start or zero if that becomes negative
i=1;
while (time(i)<base_START) 
    i = i+1;
end;
bs =max(3, i-1);

% sort out the end of your baseline
% this is your old way and is likely to be too long

while (time(i)<time(max_slope_index)-2) 
    i = i+1;
end;

% here you make sure you don't mess things up 
be = min(End_Base_Index, i-1);

%% Now compute your basline

AIF_base = mean(aif(bs:be)); % baseline is an average of aif from base start (bs) to base end (be)

%% FEB 2019 to fix crazy baselines in AIF try this

% base = AIF_base;
% 
% tucked_in_base = mean(aif(bs:be-1));
% base_wobble = 100*(base - tucked_in_base)/tucked_in_base;
% 
% if (base_wobble> 25.0)
%     AIF_base = base_wobble;
%     be = be-1;
% end;
%% compute onset and end as intercepts between max and min slope and
% horizontal baseline line

AIF_onset = (AIF_base-n)/k;
AIF_end = (AIF_base-nd)/kd;




%% relax this in version 10
% AIF_end = AIF_end + 5;

%% FIX3

if AIF_end> time(no_time_points)
    % Intervention Feb 2019 do not tuck this in, last point is okay - you
    % are trying to preserve your data please
%     AIF_end = time(no_time_points - 1);
    AIF_end = time(no_time_points);
end; 

i=1;
while (time(i)<AIF_end) 
    i = i+1;
end;
AIF_end_index = min(i-1, no_time_points);

i=1;
while (time(i)<AIF_onset) 
    i = i+1;
end;
AIF_onset_index = min(i-1, no_time_points);

%% add skirt control here
% if Inc<0.5
% skirt = (aif(AIF_onset_index)-AIF_base)/AIF_base;
% i = 1;
% while skirt>SKIRT_limit &&(i>0)
%     skirt = (aif(AIF_onset_index-i)-AIF_base)/AIF_base;
%     i = i+1;
% end
% AIF_onset_index = AIF_onset_index - (i-1);
% AIF_onset = time(AIF_onset_index);
% end

% A = [AIF_end, AIF_end];
% B = [AIF_base-20, AIF_base+20];
% 
% C = [time(bs), End_Time];
% D = [AIF_base, AIF_base];
% 
% E = [AIF_onset, AIF_onset];
% F = [AIF_base-20, AIF_base+20];

end_index = min(min_slope_index+5, no_time_points);
% %  hold off;
% if (colour == 1)
% plot(time, aif, '.', time(max_slope_index-1:max_slope_index+3), line(max_slope_index-1:max_slope_index+3), 'c', C, D, 'c', time(min_slope_index-1:end_index),line_d(min_slope_index-1:end_index),'c', A, B, 'c', E, F, 'c' );
% else
% plot(time, aif, '.', time(max_slope_index-1:max_slope_index+3), line(max_slope_index-1:max_slope_index+3), 'r', C, D, 'r', time(min_slope_index-1:end_index),line_d(min_slope_index-1:end_index),'r', A, B, 'r', E, F, 'r' );   
% end;
% % pause(2);
%  hold on;

AIF_triangle_peak_time = -(n - nd)/(k - kd);
AIF_triangle_peak = (k*nd - kd*n)/(k - kd);

AIF_triangle_start = -n/k;
AIF_triangle_end = -nd/kd;

AIF_triangle_area = 0.5*(AIF_triangle_end - AIF_triangle_start)*AIF_triangle_peak;

AIF_AUC = 0.5*(AIF_end-AIF_onset)*(AIF_triangle_peak-AIF_base);

[AIF_max, AIF_max_index] = max(aif);
AIF_max_time = time(AIF_max_index);

AIF_amplitude = (AIF_max - AIF_base);

AIF_amplitude_triangle = (AIF_triangle_peak - AIF_base);
AIF_IN_AUC = 0.5*(AIF_triangle_peak_time-AIF_onset)*(AIF_triangle_peak-AIF_base);
AIF_OUT_AUC = 0.5*(AIF_end-AIF_triangle_peak_time)*(AIF_triangle_peak-AIF_base);

AIF_triangle_peak_time_abs = AIF_triangle_peak_time-AIF_onset;
AIF_max_time_abs = AIF_max_time - AIF_onset;

%% new in Gz - compute tail and use to calibrate your AIF curves prior to pchip processing
AIF_tail = mean(aif(no_time_points-NumberInTail+1:no_time_points));

% down_line = time(AIF_max_index:AIF_end_index)*kd + nd;
% 
% plot(time(AIF_max_index:AIF_end_index), down_line, 'c');
% pause(1);

%% Here you ad tail SLOPE

    x = time(round(2*no_time_points/3): no_time_points);
    y = aif(round(2*no_time_points/3): no_time_points);
    [p] = polyfit(x, y, 1);
    kt = p(1);
    nt = p(2);


line_t = nt+kt*time;
plot(time, aif, x, y, time, line_t);

%% export stuff
% first do the indices
p(1) = bs;
p(2) = be;
p(3) = AIF_onset_index;
p(4) = AIF_end_index;
p(5) = AIF_max_index;

% next do the floating point stuff

p(6) = AIF_base;
p(7) = AIF_onset;
p(8) = AIF_end;
p(9) = AIF_end - AIF_onset; %new end time 
p(10) = AIF_max;
p(11)  = AIF_triangle_peak;
p(12) = AIF_amplitude;
p(13) = AIF_amplitude_triangle;

% peak times
p(14) = AIF_max_time_abs;
p(15) = AIF_triangle_peak_time_abs;

% AUC stuff
p(16) = AIF_AUC;
p(17) = AIF_IN_AUC;
p(18) = AIF_OUT_AUC;
p(19) = p(15)/9.0; % increment for pchip that gives 10 points over upslope

p(20) = k;
p(21) = n;
p(22) = kd;
p(23) = nd;

p(24) =max_slope_index;
p(25) =min_slope_index;
%% New in Gz
p(26) = AIF_tail;

%% first pass area added and updetd Dec 2020

FirstPass = FirstPass - p(6);
FirstPass = FirstPass(p(3): p(4));
FirstPass(1) = 0;
FirstPassTime = time(p(3): p(4)) - p(7);
FirstPassTime(1) = 0;
AUC_sum = sum(FirstPass);

AUC = trapz(FirstPassTime, FirstPass);
plot(time, aif, FirstPassTime+p(7), FirstPass+p(6));
p(17) = AUC;
p(18) = AUC/Inc;
p(27) = kt;
p(28) = nt;
p(29) = AUC_sum;

% AIF_onset_index
p(30) = p(7)-4*rr; 
p(31) = nt+kt*p(30);
p(32) = time(8); %this one only works for p matrix, this is your 8th beat when you think your bolus was admininistered
p(33) = nt+kt*p(32);
p(34) = time(no_time_points); % your tail time
