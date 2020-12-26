function [q] = ProcessSegmentsPCHIP_NoTD(time, SI, pchip_time, pchips, start_search, end_search, points_in_window, p, margin)
% margin = 0.5; % in version 9 and later
% margin = 1.0; % in version 8 and earlier

%% Version 16
% margin = 0;
% margin = 1.0; %version 17

% margin = 2*p(19); %version 18
% margin = p(19); %version 19

SI_pchip = pchip(time, SI, pchip_time);
pchip_time_input = pchip_time;


points_for_slope = points_in_window;

for i = start_search:end_search
    
    x = pchip_time(i: i+points_for_slope-1);
    y = SI_pchip(i: i+points_for_slope-1);
    [p_line] = polyfit(x, y, 1);
    slope(i-start_search+1) = p_line(1);
    intercept(i-start_search+1) = p_line(2);
    
end;

[k, max_slope_index] = max(slope);
n = intercept(max_slope_index); 
line = n+k*pchip_time;
absolute_start_index  = start_search+max_slope_index - 1;

 a = max(1, absolute_start_index - 5);
 b = max(1, absolute_start_index - 1);

base_short = mean(SI_pchip(a:b));
SI_onset_short = (base_short-n)/k;


% longer baseline fixed start to point 4 and end b extended not within -1
% of max slope index but -3 points ahead
base_long = mean(SI_pchip(4:absolute_start_index-3));
SI_onset_long = (base_long-n)/k;

%% QA - you have two options for baseline
% one is to have a fixed number of points e.g. 5 and another option is to
% have a long train going all the way to the foot of the upslope. 


q(25) = 1;
BASE = base_long;
ONSET = SI_onset_long;
q(1) = 4;
q(2) = absolute_start_index-1;

if (SI_onset_long<p(7))
    if(SI_onset_short<p(7))
        q(25) = 0;
        plot(pchip_time, SI_pchip, pchip_time((absolute_start_index - 2):(absolute_start_index + 15) ), line((absolute_start_index - 2):(absolute_start_index + 15) ) );
    else
        q(25) = 2;
        BASE = base_short;
        ONSET = SI_onset_short;
        q(1) = 4;
        q(2) = absolute_start_index-1;
    end;
end;


Clean_SI = SI_pchip - BASE;
Time_SI = pchip_time - ONSET;

i = 1;
while(Time_SI(i)<0)
    i = i+1;
end;

onset_index = i-1;

%% find more conservative onset index
% subtract one second at least to push the myo curve away from aif by 1
% second
Time_SI = pchip_time - (ONSET - margin);

i = 1;
while(Time_SI(i)<0)
    i = i+1;
end

onset_index_minus_1 = i-1;

i = 1;
while(pchip_time(i)<p(8))
    i = i+1;
end
short_end_index = i-1; 

% search amplitude
WINDOW_a = 5;
START_a = absolute_start_index - 1;
END_a = pchips - WINDOW_a;
NUMBER_a = END_a-START_a+1;

for i = 1:NUMBER_a
    
    running_a(i) = mean(SI_pchip(START_a+i-1:START_a+i-1+WINDOW_a-1));
    
end;
[max_SI, max_SI_index] = max(running_a);

SI_max_index = max_SI_index + START_a - 1 + 3;
SI_end_index = min(SI_max_index+points_for_slope, pchips);
SI_end = pchip_time(SI_end_index);


%% export stuff
i=1;
temp = pchip_time_input - ONSET;
while  (temp(i)<0)
    i = i+1;
end
onset_index = i-1;

i=1;
temp = pchip_time_input - (ONSET - margin);
while  (temp(i)<0)
    i = i+1;
end
onset_index_minus_1 = i-1;


% if (pchip_time_input(onset_index +1)<ONSET)
% onset_index = onset_index +1;    
% end
% 
% if (pchip_time_input(onset_index_minus_1 +1)<(ONSET-1))
% onset_index_minus_1 = onset_index_minus_1 +1;    
% end


% first do the indices

q(3) = onset_index; %SI_onset_index;
q(4) = SI_end_index;
q(5) = SI_max_index;

% next do the floating point stuff

q(6) = BASE;
q(7) = ONSET;
q(8) = SI_end;
q(9) = SI_end - ONSET; %new end time 
q(10) = max_SI;
q(11) = max_SI-BASE;
q(12) = base_short;
q(13) = SI_onset_short;
% peak times
q(14) = pchip_time(SI_max_index);
q(15) = q(14) - p(7);
q(16) = q(14) - q(7);
q(17) = q(7)-p(7); % this is your absolute delay time between AIF and myo

q(18) = onset_index_minus_1;
q(19) = ONSET - margin;
q(20) = k;
q(21) = n;
q(23) = pchip_time(SI_end_index) - ONSET;
q(24) = absolute_start_index;
q(26) = points_in_window;


%%% Added Tail Slope
    x = pchip_time(round(pchips/2): pchips);
    y = SI_pchip(round(pchips/2): pchips);
    [p_tail] = polyfit(x, y, 1);
    
    q(27) = p_tail(1);
    q(28) = p_tail(2);
    line_t = pchip_time*q(27)+q(28);
    plot(pchip_time,line_t,  pchip_time, SI_pchip);
    
% alpha = [q(7), q(7)];
% beta = [q(6)-5, q(6)+5];
% gamma = [p(7), p(7)];
% delta = [q(6)-5, q(6)+5];
% if (q(17)/p(19))<1.2
% %     hold off;
% %     plot(time, SI, 'r.', alpha, beta, gamma, delta);
%     q(25) = 0;
% elseif (q(17)/p(19))>12.0
% %     hold off;
% %     plot(time, SI, 'gx', alpha, beta, gamma, delta);
%     q(25) = 0;
% end


clear slope;
clear running_a;


