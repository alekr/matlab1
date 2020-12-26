function err = CalibrationStep1(x,N1, fout)


AIF1 = N1(:,23);
AIF2 = N1(:,24);
AIF3 = N1(:,25);

TailS1 = mean(AIF1(91:100));
TailS2 = mean(AIF2(91:100));
TailS3 = mean(AIF3(91:100));

BaseR1 = mean(AIF1(101:110));
BaseR2 = mean(AIF2(101:110));
BaseR3 = mean(AIF3(101:110));

TailR1 = mean(AIF1(191:200));
TailR2 = mean(AIF2(191:200));
TailR3 = mean(AIF3(191:200));

CTailS1 = log(x(1)./(x(1)-TailS1))./x(2);
CTailS2 = log(x(3)./(x(3)-TailS2))./x(4);
CTailS3 = log(x(5)./(x(5)-TailS3))./x(6);

CBaseR1 = log(x(1)./(x(1)-BaseR1))./x(2);
CBaseR2 = log(x(3)./(x(3)-BaseR2))./x(4);
CBaseR3 = log(x(5)./(x(5)-BaseR3))./x(6);

CTailR1 = log(x(1)./(x(1)-TailR1))./x(2);
CTailR2 = log(x(3)./(x(3)-TailR2))./x(4);
CTailR3 = log(x(5)./(x(5)-TailR3))./x(6);




err1 = norm(CTailS1-CTailS2)+norm(CTailS1-CTailS3)+norm(CTailS2-CTailS3);
err2 = norm(CBaseR1-CBaseR2)+norm(CBaseR1-CBaseR3)+norm(CBaseR2-CBaseR3);
err3 = norm(CTailR1-CTailR2)+norm(CTailR1-CTailR3)+norm(CTailR2-CTailR3);


err = 10*err1 + err2 + 10*err3;
fprintf(fout, '%5.6e\t%5.6e\t%5.6e\t%5.6e\n',err1, err2, err3, err);

% %% penalise negativity
%  for i=1:length(p) 
%      if p(i)<0 err=err+10^6; 
%          p(1)=0.5*p(1);
%      end; 
%  end;



