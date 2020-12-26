function stop = out_conv_function(x,optimvalues,state,tt,y_aif,y_myo,handle)

%FITOUTPUT Output function used by FITDEMO

%   Copyright 1984-2004 The MathWorks, Inc. 
%   $Revision: 1.1.6.1 $  $Date: 2004/11/29 23:30:51 $

stop = false;
% Obtain new values of fitted function at 't'

f = x(1) ./(1.0+exp(x(2)*tt-x(3)));
new_myo=conv(y_aif, f);
new_myo=new_myo(1: length(tt));

%% Can comment out the erest of this
% new_myo=conv2(y_aif, f, 'same');

% switch state
%     case 'init'
%         set(handle,'ydata',new_myo)
%         drawnow
%         title('Input data and fitted function');
%     case 'iter'
%         set(handle,'ydata',new_myo)
%         drawnow
%     case 'done'
%         hold off;
% end
% pause(.025)
