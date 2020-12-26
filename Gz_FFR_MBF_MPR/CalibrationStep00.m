function err = CalibrationStep00(x,TRIO,R10, fout)


TwoOverOne = TRIO(2)./TRIO(1);
ThreeOverOne = TRIO(3)./TRIO(1);

R21 = (1-exp(-x(2)*R10))./(1-exp(-x(1)*R10));
R31 = (1-exp(-x(3)*R10))./(1-exp(-x(1)*R10));






err21 = norm(R21-TwoOverOne);
err31 = norm(R31-ThreeOverOne);



err = err21 + err31;

fprintf(fout, '%5.6e\t%5.6e\t%5.6e\n',err21, err31, err);

% %% penalise negativity
%  for i=1:length(p) 
%      if p(i)<0 err=err+10^6; 
%          p(1)=0.5*p(1);
%      end; 
%  end;



