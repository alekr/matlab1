%% Open your twin files here

FileList = dir('*.AIF_set9_RS');
% FileList = dir('*.GzFFR_StressRestScaled');
% FileList = dir('*.GzFFR_StressRestNorm');

% FileList = dir('*.GzFFR_OnlyNorm');
N = size(FileList,1);


for k = 1:N
    
    % Clean everything and tell me where you are
    
    clearvars -except File* N k 
    filename = FileList(k).name;
    disp(filename);   
    [path, name, extension] = fileparts(filename);
          
    fout=strcat(path,name);
    fout=strcat(fout,extension);
    fout_name=strcat(fout,'.MYO_stuff');
    fout=fopen(fout_name, 'w');
    
   
    %% Prepare heading
%     fprintf(fout, 'File\tS_RR\tR_RR\t MBF_S_a1\t MBF_S_a2\t MBF_S_a3\t MBF_S_a4\t MBF_S_a5\t MBF_S_a6\t MBF_S_a7\t MBF_S_a8\t MBF_S_a9\tmMBF_S_a1\tmMBF_S_a2\tmMBF_S_a3\tmMBF_S_a4\tmMBF_S_a5\tmMBF_S_a6\tmMBF_S_a7\tmMBF_S_a8\tmMBF_S_a9\tMBF_R_a1\tMBF_R_a2\tMBF_R_a3\tMBF_R_a4\tMBF_R_a5\tMBF_R_a6\tMBF_R_a7\tMBF_R_a8\tMBF_R_a9\tmMBF_R_a1\tmMBF_R_a2\tmMBF_R_a3\tmMBF_R_a4\tmMBF_R_a5\tmMBF_R_a6\tmMBF_R_a7\tmMBF_R_a8\tmMBF_R_a9\ttD_S_a1\ttD_S_a2\ttD_S_a3\ttD_S_a4\ttD_S_a5\ttD_S_a6\ttD_S_a7\ttD_S_a8\ttD_S_a9\ttD_R_a1\ttD_R_a2\ttD_R_a3\ttD_R_a4\ttD_R_a5\ttD_R_a6\ttD_R_a7\ttD_R_a8\ttD_R_a9\tMPR_a1\tMPR_a2\tMPR_a3\tMPR_a4\tMPR_a5\tMPR_a6\tMPR_a7\tMPR_a8\tMPR_a9\tmMPR_a1\tmMPR_a2\tmMPR_a3\tmMPR_a4\tmMPR_a5\tmMPR_a6\tmMPR_a7\tmMPR_a8\tmMPR_a9\tMPR_rr_a1\tMPR_rr_a2\tMPR_rr_a3\tMPR_rr_a4\tMPR_rr_a5\tMPR_rr_a6\tMPR_rr_a7\tMPR_rr_a8\tMPR_rr_a9\tmMPR_rr_a1\tmMPR_rr_a2\tmMPR_rr_a3\tmMPR_rr_a4\tmMPR_rr_a5\tmMPR_rr_a6\tmMPR_rr_a7\tmMPR_rr_a8\tmMPR_rr_a9\tMPR_rr2_a1\tMPR_rr2_a2\tMPR_rr2_a3\tMPR_rr2_a4\tMPR_rr2_a5\tMPR_rr2_a6\tMPR_rr2_a7\tMPR_rr2_a8\tMPR_rr2_a9\tmMPR_rr2_a1\tmMPR_rr2_a2\tmMPR_rr2_a3\tmMPR_rr2_a4\tmMPR_rr2_a5\tmMPR_rr2_a6\tmMPR_rr2_a7\tmMPR_rr2_a8\tmMPR_rr2_a9\tMPR_tD_a1\tMPR_tD_a2\tMPR_tD_a3\tMPR_tD_a4\tMPR_tD_a5\tMPR_tD_a6\tMPR_tD_a7\tMPR_tD_a8\tMPR_tD_a9\tMPR_tD_rr_a1\tMPR_tD_rr_a2\tMPR_tD_rr_a3\tMPR_tD_rr_a4\tMPR_tD_rr_a5\tMPR_tD_rr_a6\tMPR_tD_rr_a7\tMPR_tD_rr_a8\tMPR_tD_rr_a9\tMPR_tD_rr2_a1\tMPR_tD_rr2_a2\tMPR_tD_rr2_a3\tMPR_tD_rr2_a4\tMPR_tD_rr2_a5\tMPR_tD_rr2_a6\tMPR_tD_rr2_a7\tMPR_tD_rr2_a8\tMPR_tD_rr2_a9\n');
    fprintf(fout, 'Sort heading out on your own ...- details and AnalyseAIF \n');
    
    
%% Read mega data    
   
   [data,no_time_points, no_columns, End_TimeStress, End_TimeRest] = ReadDataSkipTwo_Twins(filename);

   
%% Split data into matrices

Time_Stress = data(:,1);
MYO_Stress = data(:,2:23);
% AIF_Stress = data(:,24:32); % 9 AIF files
AIF_Stress = data(:,24:24); % 9 AIF files

Time_Rest = data(:,33);
MYO_Rest = data(:,34:55);
% AIF_Rest = data(:,56:64);
AIF_Rest = data(:,56:56);
%% Start your processing here - stress and rest separately but using the same functions

[rr_S, RR_S, p_S, q_aif_S, MYO_S, MBF_S, mMBF_S, MBF_S_err, mMBF_S_err, MBF_S_err_norm, mMBF_S_err_norm] = Process_DCE(k, Time_Stress, AIF_Stress, MYO_Stress);
[rr_R, RR_R, p_R, q_aif_R, MYO_R, MBF_R, mMBF_R, MBF_R_err, mMBF_R_err, MBF_R_err_norm, mMBF_R_err_norm] = Process_DCE(k, Time_Rest, AIF_Rest, MYO_Rest);

RR_S_FP = mean(RR_S);
RR_R_FP = mean(RR_R);

MBF_S_rr = MBF_S*RR_S_FP;
MBF_R_rr = MBF_R*RR_R_FP;

mMBF_S_rr = mMBF_S*RR_S_FP;
mMBF_R_rr = mMBF_R*RR_R_FP;

MPR = MBF_S./MBF_R;
mMPR = mMBF_S./mMBF_R;

MPR_rr = MBF_S./MBF_R_rr;
mMPR_rr = mMBF_S./mMBF_R_rr;

MPR_rr2 = MBF_S_rr./MBF_R_rr;
mMPR_rr2 = mMBF_S_rr./mMBF_R_rr;

tD_S = permute(MYO_S(:, 17, :), [1 3 2]);
tD_R = permute(MYO_R(:, 17, :), [1 3 2]);

tD_S_rr = tD_S/RR_S_FP;
tD_R_rr = tD_R/RR_R_FP;

MPR_tD = tD_R./tD_S;
MPR_tD_rr = tD_R_rr./tD_S;
MPR_tD_rr2 = tD_R_rr./tD_S_rr;

%% Print some details for analysing AIF and MYO SI conversion

% fprintf(fout, '%s\t', fout_name);
% fprintf(fout, '%5.6e\t', rr_S);
% fprintf(fout, '%5.6e\t', q_aif_S);
% fprintf(fout, '%5.6e\t', rr_R);
% fprintf(fout, '%5.6e\t', q_aif_R);
% fprintf(fout, '%5.6e\t', p_S);
% fprintf(fout, '%5.6e\t', p_R);
% fprintf(fout, '\n');


    fprintf(fout, '%s\t', fout_name);
    fprintf(fout, '%5.6e\t', MYO_S);
    fprintf(fout, '%5.6e\t', MYO_R);
    fprintf(fout, '\n');
syms


% for i = 1:22
%     fprintf(fout, '%s\t', fout_name);
%     fprintf(fout, '%5.6e\t', rr_S);
%     fprintf(fout, '%5.6e\t', rr_R);
%     
%     fprintf(fout, '%5.6e\t', MBF_S(i, :), mMBF_S(i, :), MBF_R(i, :), mMBF_R(i, :));
%     fprintf(fout, '%5.6e\t', MBF_S_err(i, :), mMBF_S_err(i, :), MBF_R_err(i, :), mMBF_R_err(i, :));
%     fprintf(fout, '%5.6e\t', MBF_S_err_norm(i, :), mMBF_S_err_norm(i, :), MBF_R_err_norm(i, :), mMBF_R_err_norm(i, :));
%     fprintf(fout, '\n');
% end


% for j = 1:9
%     for i = 1:22
%         tD_S(i, j) = MYO_S(i, 17, j);
%         tD_R(i, j) = MYO_R(i, 17, j);
%         tD_S_rr(i, j) = MYO_S(i, 17, j)*rr_S;
%         tD_R_rr(i, j) = MYO_R(i, 17, j)*rr_R;
%         
%         tD_MPR(i, j) = tD_R(i, j)./tD_S(i, j);
%         tD_MPR_rr(i, j) = tD_R_rr(i, j)./tD_S(i, j);
%         tD_MPR_rr2(i, j) = tD_R_rr(i, j)./tD_S_rr(i, j);
%         
%         MBF_S_rr(i, j) = MBF_S(i, j)./rr_S;
%         MBF_R_rr(i, j) = MBF_R(i, j)./rr_R;
%         mMBF_S_rr(i, j) = mMBF_S(i, j)./rr_S;
%         mMBF_R_rr(i, j) = mMBF_R(i, j)./rr_R;
%         
%         MPR(i, j) = MBF_S(i, j)./MBF_R(i, j);
%         mMPR(i, j) = mMBF_S(i, j)./mMBF_R(i, j);
%         MPR_rr(i, j) = MBF_S(i, j)./MBF_R_rr(i, j);
%         mMPR_rr(i, j) = mMBF_S(i, j)./mMBF_R_rr(i, j);
%         MPR_rr2(i, j) = MBF_S_rr(i, j)./MBF_R_rr(i, j);
%         mMPR_rr2(i, j) = mMBF_S_rr(i, j)./mMBF_R_rr(i, j);
% 
%     end
% end

% for i = 1:22
%     fprintf(fout, '%s\t', fout_name);
%     fprintf(fout, '%5.6e\t', rr_S);
%     fprintf(fout, '%5.6e\t', rr_R);
%     
%     fprintf(fout, '%5.6e\t', MBF_S(i, :), mMBF_S(i, :), MBF_R(i, :), mMBF_R(i, :));
%     fprintf(fout, '%5.6e\t', MBF_S_err(i, :), mMBF_S_err(i, :), MBF_R_err(i, :), mMBF_R_err(i, :));
%     fprintf(fout, '%5.6e\t', tD_S(i, :), tD_R(i, :));
%     
%     
    
% %     fprintf(fout, '%5.6e\t', MPR(i, :), mMPR(i, :), MPR_rr(i, :), mMPR_rr(i, :), MPR_rr2(i, :), mMPR_rr2(i, :));
% %     fprintf(fout, '%5.6e\t', MPR_tD(i, :), MPR_tD_rr(i, :), MPR_tD_rr2(i, :));
% %     for j = 1:9
% %     fprintf(fout, '%5.6e\t', q_aif_S(j, :));
% %     fprintf(fout, '%5.6e\t', MYO_S(i, :, j));
% %     fprintf(fout, '%5.6e\t', MBF_S(i, j));
% %     fprintf(fout, '%5.6e\t', mMBF_S(i, j));
% %     end
    
    
%     for j = 1:9
%     fprintf(fout, '%5.6e\t', q_aif_R(j, :));
%     fprintf(fout, '%5.6e\t', MYO_R(i, :, j));
%     fprintf(fout, '%5.6e\t', MBF_R(i, j));
%     fprintf(fout, '%5.6e\t', mMBF_R(i, j));

%     fprintf(fout, '\n');
%     end

SaveVars = strcat(fout_name, '.mat');
save(SaveVars);
end

fclose('all');       
clear all;
