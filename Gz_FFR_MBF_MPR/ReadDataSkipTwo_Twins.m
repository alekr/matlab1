function [data, no_time_points, no_columns, End_Time_S, End_Time_R] = ReadDataSkipTwo_Twins(file);


%% assuming you have one header line
%% read data from a file organised in columns
%% this is study specific and needs to be customised
%% you strip 3 rows - one header and 2 data points - this is to avoid the PD weird points that sometimes appear at the front
% this could be problematic when you have unusually short baseline 
% this would throw different issues, you will have to deal with them
% separately

data = dlmread(file, '\t', 3, 0);

%% examine dimensions of input and load vectors
% here you have a stupid legacy column number 19 that is empty but recoded
% in this data array - doesn't cause any issues so far so don't waste time
% going back to parsing program where you create AHA 16 conversion file

[l m]=size(data);
no_time_points = l;
no_columns = m;
%% take first column and read into a vector

time=data(:,1);

% make sure you start from zero -  in some input files the start is offset
% for some reason
% you need to do this anyway if you start by stripping initial frames
% anyway

time = time - time(1);

% return new time into data
data(:,1) = time;

End_Time_S = time(no_time_points);

%% Now for rest

time = data(:,33);

time = time - time(1);

data(:,33) = time;

End_Time_R = time(no_time_points);
% this is some legacy check - initial frames were left as zeros and this
% causes problems, so you avoid initial 2 zeros by replacing them by the
% tird row data - you only do this from columns 2 (AIF) to the last segment
% number 16, so column indices 2 to 18 in this case

% for i = 2:(no_columns - 1)
%     if (data(1, i)==0)
%         data(1, i) = data(3, i);
%         data(2, i) = data(3, i);
%     end;
% end;

