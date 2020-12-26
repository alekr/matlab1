function stop = out_MonoExp(x,optimvalues,state,c,amp,handle)

%FITOUTPUT Output function used by FITDEMO

%   Copyright 1984-2004 The MathWorks, Inc. 
%   $Revision: 1.1.6.1 $  $Date: 2004/11/29 23:30:51 $

stop = false;
% Obtain new values of fitted function at 't'
f = x(2) *(1-exp(-x(1).*c));


%% Can comment out the erest of this
% new_myo=conv2(y_aif, f, 'same');

% switch state
%     case 'init'
%         set(handle,'ydata',f)
%         drawnow
%         title('Input data and fitted function');
%     case 'iter'
%         set(handle,'ydata',f)
%         drawnow
%     case 'done'
%         hold off;
% end
% pause(.025)
