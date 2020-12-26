function err = conv_function(p,tt,y_aif,y_myo)
f = p(1) ./(1.0+exp(p(2)*tt-p(3)));
new_myo=conv(y_aif, f);
new_myo=new_myo(1: length(tt));
% new_myo=conv2(y_aif, f, 'same');
err = norm(new_myo-y_myo);
%% penalise negativity
 for i=1:length(p) 
     if p(i)<0 err=err+10^6; 
         p(1)=0.5*p(1);
     end; 
 end;



