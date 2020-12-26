function err = CalibrationStep2(x,RAW_AIFS, fout)

flag = 1;
err = 10^6;
%% penalise negativity
 for i=1:length(x) 
     if x(i)<0 
         flag = 0;
     end; 
 end;

aif1 = RAW_AIFS(:, 1);
aif2 = RAW_AIFS(:, 2);
aif3 = RAW_AIFS(:, 3);

if(x(1)<min(aif1)||x(4)<min(aif2)||x(7)<min(aif3))
    flag = 0;
end

if (flag)

R1 = log(x(2)./(x(1)-aif1))./x(3);

R2 = log(x(5)./(x(4)-aif2))./x(6);

R3 = log(x(8)./(x(7)-aif3))./x(9);

err12 = norm(R1-R2);
err23 = norm(R2-R3);
err13 = norm(R1-R3);

err = err12 + err23 + err13;


 
 
fprintf(fout, '%5.6e\t%5.6e\t%5.6e\t%5.6e\n',err12, err23, err13, err);

% %% penalise negativity
%  for i=1:length(p) 
%      if p(i)<0 err=err+10^6; 
%          p(1)=0.5*p(1);
%      end; 
%  end;

else
    return 
end

