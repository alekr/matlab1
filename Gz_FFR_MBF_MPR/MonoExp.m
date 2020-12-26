function err = MonoExp(p,c,amp)
f = p(2) *(1-exp(-p(1).*c));

err = norm(c-f);
%% penalise negativity
 for i=1:length(p) 
     if p(i)<0 err=err+10^6; 
         p(1)=0.5*p(1);
     end; 
 end;



