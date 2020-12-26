function [rr, RR, p, q_aif, q_MYO, MBF, mMBF, MBF_err, mMBF_err, MBF_err_norm, mMBF_err_norm] = Process_DCE(k, Time, AIF, MYO)

%% process time
% This will need to be exported into a RR array
% Later on, you will update to have a specific FP average HR
% You could also add other stats for HR later into this array

[r c] = size(Time);
End_Time = Time(r);

delta_times = zeros(r-1,1);

   for i = 2:r
   delta_times(i) = Time(i) - Time(i-1);
   end
   average_RR = mean(delta_times);

   
   %% Process AIFs using p matrix
   no_time_points = r;
   points_in_window = 3;
   [r c] = size(AIF);
   NumberAifs = c;
   for j = 1:NumberAifs
   [p(j,:)] = AnalyseAIF_V10_Tail(Time, AIF(:,j), points_in_window, no_time_points, End_Time, 2, 10, average_RR);
   average_RR_FP(j) = mean(delta_times(p(j,3): p(j,4)));
   end
   
   
   
   %% First interpolate Time
    pchips = zeros(NumberAifs, 1);
    pchip_time = zeros(NumberAifs, 500);
    time_increment = zeros(NumberAifs, 1);
    for i = 1:NumberAifs
    time_increment(i) = p(i,19); 
    pchips(i) = floor(End_Time/time_increment(i)); 
    pchip_time(i, :) = [0:500-1]*time_increment(i); 
    end
    
  %% Process AIFs using q matrix
  
    points_in_window = 10;

    for i = 1:NumberAifs  
    NoInTail = floor(10.0/time_increment(i));
    aif = AIF(:,i);
    % MIGHT NEED TO REMEMBER THIS ONE BELOW TOO
    AIF_pchip = pchip(Time, aif, pchip_time(i,1:pchips(i)));  
    [q_aif(i,:)] = AnalyseAIF_V10_Tail(pchip_time(i, 1:pchips(i)), AIF_pchip, points_in_window, pchips(i), pchip_time(i,pchips(i)), 2, NoInTail, average_RR);

    end

    %% Now process MYO, but each of the curves needs to be processed by all of the AIFs you are considering
    % First find out how many you need for this
    [r c] = size(MYO);
    NumberMYOs = c;  
    
    for j = 1:NumberAifs
        start_search = max(3, q_aif(j,3)-5);
        end_search = min(pchips(j), q_aif(j,5)+5);
        for i = 1:NumberMYOs
            COLUMN = MYO(:, i);  
            [q_MYO(i,:, j)] = ProcessSegmentsPCHIP_NoTD(Time, COLUMN, pchip_time(j, 1:pchips(j)), pchips(j), start_search, end_search, points_in_window, q_aif(j, :), q_aif(j,19));
                % first line error coding
                scaled_delay(i, j) = q_MYO(i, 17, j)/average_RR_FP(j);
                if(scaled_delay(i, j)<1.0||scaled_delay(i, j)>7.0)
                    q_MYO(i, 25, j)=0;
                    %% Added control
                    if (scaled_delay(i, j)<1.0)
                    [q_MYO(i,:, j)] = ProcessSegmentsPCHIP_NoTD(Time, COLUMN, pchip_time(j, 1:pchips(j)), pchips(j), start_search, end_search, 5, q_aif(j, :), q_aif(j,19));
                    scaled_delay(i, j) = q_MYO(i, 17, j)/average_RR_FP(j);
                    elseif(scaled_delay(i, j)>7.0)
                    [q_MYO(i,:, j)] = ProcessSegmentsPCHIP_NoTD(Time, COLUMN, pchip_time(j, 1:pchips(j)), pchips(j), start_search, end_search-10, points_in_window, q_aif(j, :), q_aif(j,19));
                    scaled_delay(i, j) = q_MYO(i, 17, j)/average_RR_FP(j);    
                    end
                    %% if still rubbish, update please
                    if (scaled_delay(i, j)<1.0||scaled_delay(i, j)>7.0)
                       q_MYO(i, 25, j)=0; 
                    end
                end
        end
    end
    
    %% Now you do your MBFs - strong coffee so that you make no mistakes please God!
    inis = [0.1 0.1 0.1];
    for j = 1:NumberAifs
        % Prepare AIF curve for Fermi
        MAX_TIME = q_aif(j,8) - q_aif(j,7); 
        MAX_TIME = MAX_TIME + 2*q_aif(j,19);  
        END_INDEX = q_aif(j,4)+20;
        
        %% Prepare Time Fermi
        Increment = 2.0*q_aif(j,19); % this is fermi increment
        NoInc = ceil(MAX_TIME/Increment);  
        TIME_fermi = [0:NoInc]*Increment;   % note that the size of interpolated axis is NoInc +1
        
        %% Prepare AIF for Fermi
        Fine_Time = pchip_time(j,1:pchips(j));
        AIF_pchip = pchip(Time, AIF(:,j), Fine_Time);
        
        AIF_temp = AIF_pchip(q_aif(j,3):END_INDEX) - q_aif(j,6); %cookie cutter from start index to end index and base subtracted
        AIF_temp(1) = 0;    % pin down first point to zero
    
        aif_time_temp = Fine_Time(q_aif(j,3):END_INDEX)-q_aif(j,7); % take corresponding time axis and subtract onset time 
        aif_time_temp(1) = 0;   % pin down first point to zero
    
        AIF_fermi = pchip(aif_time_temp, AIF_temp, TIME_fermi);
        
        for i = 1:NumberMYOs 
            %% prepare input MYO curve for Fermi
            MYO_pchip = pchip(Time, MYO(:, i), Fine_Time); 
            plot(Fine_Time, AIF_pchip, Fine_Time, MYO_pchip); 
      
            MYO_temp = MYO_pchip(q_aif(j,3):END_INDEX) - q_MYO(i,6,j); % subtract standard base
            MYO_temp(1) = 0;
            MYO_fermi = pchip(aif_time_temp, MYO_temp, TIME_fermi);

            plot(TIME_fermi,AIF_fermi,  TIME_fermi,MYO_fermi); 
            
            [MBF1(i, j), MBF1_p(i, :, j), MBF1_err(i, j), MBF1_exit(i, j)] = NM_WITH_INIS_fetchf_after_alignment(TIME_fermi, AIF_fermi, MYO_fermi, inis);
            MBF1_err_norm(i, j) = MBF1_err(i, j)./(mean(MYO_fermi)*size(MYO_fermi,2));
            if MBF1_err(i, j)>1.3
                inis_1 = [0.1 0.5 0.00005];
                [MBF1(i, j), MBF1_p(i, :, j), MBF1_err(i, j), MBF1_exit(i, j)] = NM_WITH_INIS_fetchf_after_alignment_FIX(TIME_fermi, AIF_fermi, MYO_fermi, inis_1);
            end

            
            [ok] = PlotFermiCurve(i, j, k, NoInc, MBF1(i, j), MBF1_p(i, :, j), TIME_fermi, AIF_fermi, MYO_fermi, Time, q_aif(j, 7), q_MYO(i,6,j), MYO(:, i));
%             pause(2.25);
            %% now do shifted curves for mMBF
            
            myo_onset_index = q_MYO(i, 18, j);
            myo_onset = q_MYO(i,19,j);
            myo_base = q_MYO(i,6, j);  
            shift = max(0,myo_onset_index - q_aif(j,3));
            shift_time = Fine_Time(myo_onset_index) - Fine_Time(q_aif(j,3));
            no_fermis = round(shift_time/Increment);
            
                MYO_temp = MYO_pchip(myo_onset_index:END_INDEX) - myo_base;
                MYO_temp(1) = 0;
                myo_time_temp = Fine_Time(myo_onset_index:END_INDEX)-myo_onset;
                myo_time_temp(1)=0;
                MYO_fermi = pchip(myo_time_temp, MYO_temp, TIME_fermi);

                    TIME_fermi_crop = TIME_fermi(1:NoInc+1-no_fermis);
                    MYO_fermi_crop = MYO_fermi(1:NoInc+1-no_fermis);
                    AIF_fermi_crop = AIF_fermi(1:NoInc+1-no_fermis);
         
            [MBF2(i, j), MBF2_p(i, :, j), MBF2_err(i, j), MBF2_exit(i, j)] = NM_WITH_INIS_fetchf_after_alignment(TIME_fermi_crop, AIF_fermi_crop, MYO_fermi_crop, inis);
            MBF2_err_norm(i, j) = MBF2_err(i, j)./(mean(MYO_fermi_crop)*size(MYO_fermi_crop,2));
            
            if MBF2_err(i, j)>1.0
                inis_1 = [0.1 0.5 0.00005];
                [MBF2(i, j), MBF2_p(i, :, j), MBF2_err(i, j), MBF2_exit(i, j)] = NM_WITH_INIS_fetchf_after_alignment_FIX(TIME_fermi_crop, AIF_fermi_crop, MYO_fermi_crop, inis_1);
            end
            [ok] = PlotFermiCurve(i, j, k, NoInc-no_fermis, MBF2(i, j), MBF2_p(i, :, j), TIME_fermi_crop, AIF_fermi_crop, MYO_fermi_crop, Time, myo_onset, q_MYO(i,6,j), MYO(:, i));
            pause(0.002);
           
        end
    end
    
 %% return measurements
 RR = average_RR_FP;
 rr = average_RR;
 MBF = MBF1;
 MBF_err = MBF1_err;
 mMBF = MBF2;
 MBF_err = MBF1_err;
 mMBF_err = MBF2_err;
 
 MBF_err_norm = MBF1_err_norm;
 mMBF_err_norm = MBF2_err_norm;