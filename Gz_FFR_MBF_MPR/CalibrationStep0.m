function err = CalibrationStep0(x,TRIO, fout)


TwoOverOne = TRIO(2)./TRIO(1);
ThreeOverOne = TRIO(3)./TRIO(1);

R21 = (1-exp(-x(2)*x(4)))./(1-exp(-x(1)*x(4)));
R31 = (1-exp(-x(3)*x(4)))./(1-exp(-x(1)*x(4)));

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



