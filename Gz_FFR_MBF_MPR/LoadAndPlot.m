% 
%   struct with fields:
% 
%           AIF_Rest: [98×9 double]
%         AIF_Stress: [98×9 double]
%       End_TimeRest: 111.2807
%     End_TimeStress: 78.2417
%           FileList: [10×1 struct]
%              MBF_R: [22×9 double]
%           MBF_R_rr: [22×9 double]
%              MBF_S: [22×9 double]
%           MBF_S_rr: [22×9 double]
%                MPR: [22×9 double]
%             MPR_rr: [22×9 double]
%            MPR_rr2: [22×9 double]
%             MPR_tD: [22×9 double]
%          MPR_tD_rr: [22×9 double]
%         MPR_tD_rr2: [22×9 double]
%              MYO_R: [22×26×9 double]
%           MYO_Rest: [98×22 double]
%              MYO_S: [22×26×9 double]
%         MYO_Stress: [98×22 double]
%                  N: 10
%               RR_R: [1.1874 1.1961 1.1744 1.1874 1.1961 1.1744 1.1874 1.1961 1.1744]
%            RR_R_FP: 1.1860
%               RR_S: [0.8306 0.8362 0.8384 0.8306 0.8362 0.8384 0.8306 0.8362 0.8384]
%            RR_S_FP: 0.8350
%           SaveVars: 'gzFFR_026_scan2_stress.txt.AIF_set9_RS.MBF_MPR.mat'
%          Time_Rest: [98×1 double]
%        Time_Stress: [98×1 double]
%                ans: 1
%               data: [98×65 double]
%          extension: '.AIF_set9_RS'
%           filename: 'gzFFR_026_scan2_stress.txt.AIF_set9_RS'
%               fout: 12
%          fout_name: 'gzFFR_026_scan2_stress.txt.AIF_set9_RS.MBF_MPR'
%                  i: 22
%                  k: 10
%             mMBF_R: [22×9 double]
%          mMBF_R_rr: [22×9 double]
%             mMBF_S: [22×9 double]
%          mMBF_S_rr: [22×9 double]
%               mMPR: [22×9 double]
%            mMPR_rr: [22×9 double]
%           mMPR_rr2: [22×9 double]
%               name: 'gzFFR_026_scan2_stress.txt'
%         no_columns: 65
%     no_time_points: 98
%                p_R: [9×26 double]
%                p_S: [9×26 double]
%               path: ''
%            q_aif_R: [9×26 double]
%            q_aif_S: [9×26 double]
%               rr_R: 1.1355
%               rr_S: 0.7984
%               tD_R: [22×9 double]
%            tD_R_rr: [22×9 double]
%               tD_S: [22×9 double]
%            tD_S_rr: [22×9 double]

P17_1_Norm = load('gzFFR_017_scan1_Stress.txt.GzFFR_StressRestNorm.MBF_MPR.mat');
P17_2_Norm = load('gzFFR_017_scan2_Stress.txt.GzFFR_StressRestNorm.MBF_MPR.mat');
P18_1_Norm = load('gzFFR_018_scan1_Stress.txt.GzFFR_StressRestNorm.MBF_MPR.mat');
P18_2_Norm = load('gzFFR_018_scan2_Stress.txt.GzFFR_StressRestNorm.MBF_MPR.mat');
P19_1_Norm = load('gzFFR_019_scan1_Stress.txt.GzFFR_StressRestNorm.MBF_MPR.mat');
P19_2_Norm = load('gzFFR_019_scan2_Stress.txt.GzFFR_StressRestNorm.MBF_MPR.mat');
P20_1_Norm = load('gzFFR_020_scan1_Stress.txt.GzFFR_StressRestNorm.MBF_MPR.mat');
P20_2_Norm = load('gzFFR_020_scan2_Stress.txt.GzFFR_StressRestNorm.MBF_MPR.mat');
P26_1_Norm = load('gzFFR_026_scan1_Stress.txt.GzFFR_StressRestNorm.MBF_MPR.mat');
P26_2_Norm = load('gzFFR_026_scan2_Stress.txt.GzFFR_StressRestNorm.MBF_MPR.mat');


P17_1_Coil = load('gzFFR_017_scan1_Stress.txt.GzFFR_StressRestScaled.MBF_MPR.mat');
P17_2_Coil = load('gzFFR_017_scan2_Stress.txt.GzFFR_StressRestScaled.MBF_MPR.mat');
P18_1_Coil = load('gzFFR_018_scan1_Stress.txt.GzFFR_StressRestScaled.MBF_MPR.mat');
P18_2_Coil = load('gzFFR_018_scan2_Stress.txt.GzFFR_StressRestScaled.MBF_MPR.mat');
P19_1_Coil = load('gzFFR_019_scan1_Stress.txt.GzFFR_StressRestScaled.MBF_MPR.mat');
P19_2_Coil = load('gzFFR_019_scan2_Stress.txt.GzFFR_StressRestScaled.MBF_MPR.mat');
P20_1_Coil = load('gzFFR_020_scan1_Stress.txt.GzFFR_StressRestScaled.MBF_MPR.mat');
P20_2_Coil = load('gzFFR_020_scan2_Stress.txt.GzFFR_StressRestScaled.MBF_MPR.mat');
P26_1_Coil = load('gzFFR_026_scan1_Stress.txt.GzFFR_StressRestScaled.MBF_MPR.mat');
P26_2_Coil = load('gzFFR_026_scan2_Stress.txt.GzFFR_StressRestScaled.MBF_MPR.mat');

P17_1_Raw = load('gzFFR_017_scan1_Stress.txt.AIF_set9_RS.MBF_MPR.mat');
P17_2_Raw = load('gzFFR_017_scan2_Stress.txt.AIF_set9_RS.MBF_MPR.mat');
P18_1_Raw = load('gzFFR_018_scan1_Stress.txt.AIF_set9_RS.MBF_MPR.mat');
P18_2_Raw = load('gzFFR_018_scan2_Stress.txt.AIF_set9_RS.MBF_MPR.mat');
P19_1_Raw = load('gzFFR_019_scan1_Stress.txt.AIF_set9_RS.MBF_MPR.mat');
P19_2_Raw = load('gzFFR_019_scan2_Stress.txt.AIF_set9_RS.MBF_MPR.mat');
P20_1_Raw = load('gzFFR_020_scan1_Stress.txt.AIF_set9_RS.MBF_MPR.mat');
P20_2_Raw = load('gzFFR_020_scan2_Stress.txt.AIF_set9_RS.MBF_MPR.mat');
P26_1_Raw = load('gzFFR_026_scan1_Stress.txt.AIF_set9_RS.MBF_MPR.mat');
P26_2_Raw = load('gzFFR_026_scan2_Stress.txt.AIF_set9_RS.MBF_MPR.mat');
%% Compare Amplitudes Rest
j = 12;
AifAmplitudesRest17_1 = horzcat(P17_1_Raw.q_aif_R(:, j), P17_1_Coil.q_aif_R(:, j), P17_1_Norm.q_aif_R(:, j));
AifAmplitudesRest17_2 = horzcat(P17_2_Raw.q_aif_R(:, j), P17_2_Coil.q_aif_R(:, j), P17_2_Norm.q_aif_R(:, j));
AifAmplitudesRest18_1 = horzcat(P18_1_Raw.q_aif_R(:, j), P18_1_Coil.q_aif_R(:, j), P18_1_Norm.q_aif_R(:, j));
AifAmplitudesRest18_2 = horzcat(P18_2_Raw.q_aif_R(:, j), P18_2_Coil.q_aif_R(:, j), P18_2_Norm.q_aif_R(:, j));
AifAmplitudesRest19_1 = horzcat(P19_1_Raw.q_aif_R(:, j), P19_1_Coil.q_aif_R(:, j), P19_1_Norm.q_aif_R(:, j));
AifAmplitudesRest19_2 = horzcat(P19_2_Raw.q_aif_R(:, j), P19_2_Coil.q_aif_R(:, j), P19_2_Norm.q_aif_R(:, j));
AifAmplitudesRest20_1 = horzcat(P20_1_Raw.q_aif_R(:, j), P20_1_Coil.q_aif_R(:, j), P20_1_Norm.q_aif_R(:, j));
AifAmplitudesRest20_2 = horzcat(P20_2_Raw.q_aif_R(:, j), P20_2_Coil.q_aif_R(:, j), P20_2_Norm.q_aif_R(:, j));
AifAmplitudesRest26_1 = horzcat(P26_1_Raw.q_aif_R(:, j), P26_1_Coil.q_aif_R(:, j), P26_1_Norm.q_aif_R(:, j));
AifAmplitudesRest26_2 = horzcat(P26_2_Raw.q_aif_R(:, j), P26_2_Coil.q_aif_R(:, j), P26_2_Norm.q_aif_R(:, j));

AIF_Amp_Rest_1 = vertcat(AifAmplitudesRest17_1, AifAmplitudesRest18_1, AifAmplitudesRest19_1, AifAmplitudesRest20_1, AifAmplitudesRest26_1);
AIF_Amp_Rest_2 = vertcat(AifAmplitudesRest17_2, AifAmplitudesRest18_2, AifAmplitudesRest19_2, AifAmplitudesRest20_2, AifAmplitudesRest26_2);
plot(AIF_Amp_Rest_1, AIF_Amp_Rest_2, 'x');
%% Compare Amplitudes Stress
j = 12;
AifAmplitudesStress17_1 = horzcat(P17_1_Raw.q_aif_S(:, j), P17_1_Coil.q_aif_S(:, j), P17_1_Norm.q_aif_S(:, j));
AifAmplitudesStress17_2 = horzcat(P17_2_Raw.q_aif_S(:, j), P17_2_Coil.q_aif_S(:, j), P17_2_Norm.q_aif_S(:, j));
AifAmplitudesStress18_1 = horzcat(P18_1_Raw.q_aif_S(:, j), P18_1_Coil.q_aif_S(:, j), P18_1_Norm.q_aif_S(:, j));
AifAmplitudesStress18_2 = horzcat(P18_2_Raw.q_aif_S(:, j), P18_2_Coil.q_aif_S(:, j), P18_2_Norm.q_aif_S(:, j));
AifAmplitudesStress19_1 = horzcat(P19_1_Raw.q_aif_S(:, j), P19_1_Coil.q_aif_S(:, j), P19_1_Norm.q_aif_S(:, j));
AifAmplitudesStress19_2 = horzcat(P19_2_Raw.q_aif_S(:, j), P19_2_Coil.q_aif_S(:, j), P19_2_Norm.q_aif_S(:, j));
AifAmplitudesStress20_1 = horzcat(P20_1_Raw.q_aif_S(:, j), P20_1_Coil.q_aif_S(:, j), P20_1_Norm.q_aif_S(:, j));
AifAmplitudesStress20_2 = horzcat(P20_2_Raw.q_aif_S(:, j), P20_2_Coil.q_aif_S(:, j), P20_2_Norm.q_aif_S(:, j));
AifAmplitudesStress26_1 = horzcat(P26_1_Raw.q_aif_S(:, j), P26_1_Coil.q_aif_S(:, j), P26_1_Norm.q_aif_S(:, j));
AifAmplitudesStress26_2 = horzcat(P26_2_Raw.q_aif_S(:, j), P26_2_Coil.q_aif_S(:, j), P26_2_Norm.q_aif_S(:, j));

AIF_Amp_Stress_1 = vertcat(AifAmplitudesStress17_1, AifAmplitudesStress18_1, AifAmplitudesStress19_1, AifAmplitudesStress20_1, AifAmplitudesStress26_1);
AIF_Amp_Stress_2 = vertcat(AifAmplitudesStress17_2, AifAmplitudesStress18_2, AifAmplitudesStress19_2, AifAmplitudesStress20_2, AifAmplitudesStress26_2);

%% Compare Baselines Rest
j = 6;
AifBaseRest17_1 = horzcat(P17_1_Raw.q_aif_R(:, j), P17_1_Coil.q_aif_R(:, j), P17_1_Norm.q_aif_R(:, j));
AifBaseRest17_2 = horzcat(P17_2_Raw.q_aif_R(:, j), P17_2_Coil.q_aif_R(:, j), P17_2_Norm.q_aif_R(:, j));
AifBaseRest18_1 = horzcat(P18_1_Raw.q_aif_R(:, j), P18_1_Coil.q_aif_R(:, j), P18_1_Norm.q_aif_R(:, j));
AifBaseRest18_2 = horzcat(P18_2_Raw.q_aif_R(:, j), P18_2_Coil.q_aif_R(:, j), P18_2_Norm.q_aif_R(:, j));
AifBaseRest19_1 = horzcat(P19_1_Raw.q_aif_R(:, j), P19_1_Coil.q_aif_R(:, j), P19_1_Norm.q_aif_R(:, j));
AifBaseRest19_2 = horzcat(P19_2_Raw.q_aif_R(:, j), P19_2_Coil.q_aif_R(:, j), P19_2_Norm.q_aif_R(:, j));
AifBaseRest20_1 = horzcat(P20_1_Raw.q_aif_R(:, j), P20_1_Coil.q_aif_R(:, j), P20_1_Norm.q_aif_R(:, j));
AifBaseRest20_2 = horzcat(P20_2_Raw.q_aif_R(:, j), P20_2_Coil.q_aif_R(:, j), P20_2_Norm.q_aif_R(:, j));
AifBaseRest26_1 = horzcat(P26_1_Raw.q_aif_R(:, j), P26_1_Coil.q_aif_R(:, j), P26_1_Norm.q_aif_R(:, j));
AifBaseRest26_2 = horzcat(P26_2_Raw.q_aif_R(:, j), P26_2_Coil.q_aif_R(:, j), P26_2_Norm.q_aif_R(:, j));

AIF_Base_Rest_1 = vertcat(AifBaseRest17_1, AifBaseRest18_1, AifBaseRest19_1, AifBaseRest20_1, AifBaseRest26_1);
AIF_Base_Rest_2 = vertcat(AifBaseRest17_2, AifBaseRest18_2, AifBaseRest19_2, AifBaseRest20_2, AifBaseRest26_2);

%% Compare Baselines Stress
j = 6;
AifBaseStress17_1 = horzcat(P17_1_Raw.q_aif_S(:, j), P17_1_Coil.q_aif_S(:, j), P17_1_Norm.q_aif_S(:, j));
AifBaseStress17_2 = horzcat(P17_2_Raw.q_aif_S(:, j), P17_2_Coil.q_aif_S(:, j), P17_2_Norm.q_aif_S(:, j));
AifBaseStress18_1 = horzcat(P18_1_Raw.q_aif_S(:, j), P18_1_Coil.q_aif_S(:, j), P18_1_Norm.q_aif_S(:, j));
AifBaseStress18_2 = horzcat(P18_2_Raw.q_aif_S(:, j), P18_2_Coil.q_aif_S(:, j), P18_2_Norm.q_aif_S(:, j));
AifBaseStress19_1 = horzcat(P19_1_Raw.q_aif_S(:, j), P19_1_Coil.q_aif_S(:, j), P19_1_Norm.q_aif_S(:, j));
AifBaseStress19_2 = horzcat(P19_2_Raw.q_aif_S(:, j), P19_2_Coil.q_aif_S(:, j), P19_2_Norm.q_aif_S(:, j));
AifBaseStress20_1 = horzcat(P20_1_Raw.q_aif_S(:, j), P20_1_Coil.q_aif_S(:, j), P20_1_Norm.q_aif_S(:, j));
AifBaseStress20_2 = horzcat(P20_2_Raw.q_aif_S(:, j), P20_2_Coil.q_aif_S(:, j), P20_2_Norm.q_aif_S(:, j));
AifBaseStress26_1 = horzcat(P26_1_Raw.q_aif_S(:, j), P26_1_Coil.q_aif_S(:, j), P26_1_Norm.q_aif_S(:, j));
AifBaseStress26_2 = horzcat(P26_2_Raw.q_aif_S(:, j), P26_2_Coil.q_aif_S(:, j), P26_2_Norm.q_aif_S(:, j));

AIF_Base_Stress_1 = vertcat(AifBaseStress17_1, AifBaseStress18_1, AifBaseStress19_1, AifBaseStress20_1, AifBaseStress26_1);
AIF_Base_Stress_2 = vertcat(AifBaseStress17_2, AifBaseStress18_2, AifBaseStress19_2, AifBaseStress20_2, AifBaseStress26_2);

%% plot MPRs to get some idea onwhat is going on
bar(P17_1_Norm.MPR(17:19, :)')
%%
bar(P17_2_Norm.MPR(17:19, :)')
%%
bar(P18_1_Norm.MPR(17:19, :)')
%%
bar(P18_2_Norm.MPR(17:19, :)')
%%
bar(P19_1_Norm.MPR(17:19, :)')
%% 
bar(P19_2_Norm.MPR(17:19, :)')
%%
bar(P20_1_Norm.MPR(17:19, :)')
%%
bar(P20_2_Norm.MPR(17:19, :)')
%%
bar(P26_1_Norm.MPR(17:19, :)')
%%
bar(P26_2_Norm.MPR(17:19, :)')
%% plot MPRs in coil corrected

bar(P17_1_Coil.MPR(17:19, :)')
%%
bar(P17_2_Coil.MPR(17:19, :)')
%%
bar(P18_1_Coil.MPR(17:19, :)')
%%
bar(P18_2_Coil.MPR(17:19, :)')
%%
bar(P19_1_Coil.MPR(17:19, :)')
%% 
bar(P19_2_Coil.MPR(17:19, :)')
%%
bar(P20_1_Coil.MPR(17:19, :)')
%%
bar(P20_2_Coil.MPR(17:19, :)')
%%
bar(P26_1_Coil.MPR(17:19, :)')
%%
bar(P26_2_Coil.MPR(17:19, :)')
