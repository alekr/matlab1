function [ROIS] = ParseFiles_3Slices_asc (filename, mass_name);


% open the file
fid = fopen(filename);
[path, name, extension] = fileparts(filename);

fout=strcat(path,filename);

fout=strcat(fout,'.temp');
temp_file_name = fout;
fout_id=fopen(fout, 'w');
time1 = 0;
time2 = 0;
roi1_OK = 0;
roi2_OK = 0;
% make sure the file is not empty
finfo = dir(filename);
fsize = finfo.bytes;
NO_PHASES = 1;

replace_this = '  ';
with_this = '';
if fsize > 0 

    % read the file
    while ~feof(fid)
        line = fgets(fid);
        
        m1 = strfind(line, 'Nr phases:');
        if (m1>0) 
            [token, remain] = strtok(line);
            [token, remain] = strtok(remain);
            [token, remain] = strtok(remain);
            NO_PHASES = uint16(str2num(token));
             
        end
 
        m2 = strfind(line, 'PHASE	TIME [ms]'); 
        if (m2>0)
             
            fprintf(fout_id,'Time\t');
            for i=1:NO_PHASES-1
                 line = fgets(fid);

                 [token, remain] = strtok(line);
                 [token, remain] = strtok(remain);
                 if (strfind(token,',')>0)
                     [bit1 bit2]=strtok(token, ',');
                     [bit3 bit4]=strtok(bit2, ',');

                     token = strcat(bit1,bit3);
                     
                 end
                 temp=str2num(token)/1000.0;
                 fprintf(fout_id,'%5.6e\t', temp);
            end
            line = fgets(fid);
                 
                 [token, remain] = strtok(line);
                 [token, remain] = strtok(remain);
                 if (strfind(token,',')>0)
                     [bit1 bit2]=strtok(token, ',');
                     [bit3 bit4]=strtok(bit2, ',');

                     token = strcat(bit1,bit3);
                     
                 end
                 temp=str2num(token)/1000.0;
                 fprintf(fout_id,'%5.6e\n', temp);
        end % end time block
 %% WHEN delimiter is space not tab
         m2_space = strfind(line, 'PHASE TIME [ms]'); 
        if (m2_space>0)
             
            fprintf(fout_id,'Time\t');
            for i=1:NO_PHASES-1
                 line = fgets(fid);

                 [token, remain] = strtok(line);
                 [token, remain] = strtok(remain);
                 if (strfind(token,',')>0)
                     [bit1 bit2]=strtok(token, ',');
                     [bit3 bit4]=strtok(bit2, ',');

                     token = strcat(bit1,bit3);
                     
                 end
                 temp=str2num(token)/1000.0;
                 fprintf(fout_id,'%5.6e\t', temp);
            end
            line = fgets(fid);
                 
                 [token, remain] = strtok(line);
                 [token, remain] = strtok(remain);
                 if (strfind(token,',')>0)
                     [bit1 bit2]=strtok(token, ',');
                     [bit3 bit4]=strtok(bit2, ',');

                     token = strcat(bit1,bit3);
                     
                 end
                 temp=str2num(token)/1000.0;
                 fprintf(fout_id,'%5.6e\n', temp);
        end % end time block
% end of time block for spaces
        m3 = strfind(line, 'LV Blood');        
        if (m3>0) 
            [token, remain] = strtok(line);
            fprintf(fout_id,'LV');
            [token, remain] = strtok(remain);      
            
            fprintf(fout_id,'%s', remain);
            for i=1:7
                line = fgets(fid);
                fprintf(fout_id,'%s', line);
            end
         end % end SI1 block
 

%% ROI BLOCK

        m4 = strfind(line, 'ROI1 mean gray values');        
        if (m4>0) 
            roi1_OK = 1;
             line = fgets(fid);
             line = fgets(fid);
            
            fprintf(fout_id,'AIFROI1');
            [token, remain] = strtok(line); 
            
            expression = '-';
            replace = '0';
            %replace = remain;

            new_remain = regexprep(remain,expression,replace);
            new_remain = regexprep(new_remain,'   ',' ');
            fprintf(fout_id,'%s', new_remain);
        %fprintf(fout_id, '\n');
        end % end ROI block

         m5 = strfind(line, 'ROI2 mean gray values');        
        if (m5>0) 
            roi2_OK = 1;
             line = fgets(fid);
             line = fgets(fid);
            
            fprintf(fout_id,'ROI2');
            [token, remain] = strtok(line); 
            expression = '-';
            replace = '0';

            new_remain = regexprep(remain,expression,replace);
            new_remain = regexprep(new_remain,'   ',' ');
            fprintf(fout_id,'%s', new_remain);
      %fprintf(fout_id, '\n');
        end % end ROI block
 %% ROI2 block - spleen in this case
 %% don't understand this at all
        
    end % end while you have something to read
end % end if size
fclose(fout_id);

fout1 = fopen(temp_file_name, 'r');
ftemp = fopen('temp.temp', 'w');
i = 0;
while ~feof(fout1)
line = fgets(fout1);
line=regexprep(line,'\s+','\t');
fprintf(ftemp,'%s\n', line);
i = i+1;
end

range = [0 1 i-1 NO_PHASES];

%data = dlmread('temp.temp', '\t', 0, 1);
data = dlmread('temp.temp', '\t', range);
fclose(ftemp);
%data
Table = data';

ROIS(1) =  roi1_OK;
ROIS(2) = roi2_OK;

% if(ROIS(1)<1)
%     mass_name = strcat(mass_name, '_NOAIF');
% end;
% if (ROIS(2)<1)&&(ROIS(1)>0)
%     mass_name = strcat(mass_name, '_NOROI2.MASS');
% end;


fclose(fout1);
% fout2=strcat(filename,'.MASS');
% fout2=strcat(filename,'.MASS');
fout2 = fopen(mass_name, 'w');

fprintf(fout2, 'time\tAIF1\tS1_S1\tS1_S2\tS1_S3\tS1_S4\tS1_S5\tS1_S6\tS1_mean\tAIF2\tS2_S1\tS2_S2\tS2_S3\tS2_S4\tS2_S5\tS2_S6\tS2_mean\tAIF3\tS3_S1\tS3_S2\tS3_S3\tS3_S4\tS3_S5\tS3_S6\tS3_mean\n');
[l m]=size(Table);

% Modified Feb 2019 to remove tail portions where no recordings were made

% form a new table where first row is copied by default but other rows are
% copied only if there is a time stamp recorded - it must not be left empty
% otherwise it will generate errors. 

NewTable(1,:) = Table(1, :);
for i = 2:l
    if (Table(i, 1))
        NewTable(i,:) = Table(i, :); 
    end;
end;

[l m]=size(NewTable);

for i = 1:l
    
    for j = 1:m
        % If you are not in the first row, thenif you encouter a zero
        % somewhere, copy the previous measurement into that field - not
        % ideal and can cause some problems in certain situations
        
        if (NewTable(i, j)==0)&& (i>1) 
            if (NewTable(1, j)) 
                NewTable(i,j) = NewTable(i-1, j);
            end;

        end;
        fprintf(fout2, '%5.6e\t', NewTable(i,j));
    end
    fprintf(fout2, '\n');

end

%% this part will be different depending on the slice orientation 
% The setup down below is for the default system where 3 = basal slice and
% this is where AIF is taken from

fclose(fout2);

if m == 25
    
    plot(NewTable (:, 1), NewTable (:, 2), 'r',NewTable (:, 1), NewTable (:, 10), 'g',NewTable (:, 1), NewTable (:, 18), 'b');
    hold on;
    plot(NewTable (:, 1), NewTable (:, 9), '.r',NewTable (:, 1), NewTable (:, 17), '.g',NewTable (:, 1), NewTable (:, 25), '.b');
    hold off;
    pause(2);
    
    % Optional save figures for later
    
        [path, name, extension] = fileparts(filename);
        figure_out1=strcat(path,name);
        figure_out1=strcat(figure_out1,'-SI.jpeg'); 

        temp_title =  regexprep(name,'_','-');
        temp_title1 =  regexprep(name,'_','-');
        
        
        title(['SI: ', temp_title1]);  
        export_fig temp1.jpeg
        movefile ('temp1.jpg', figure_out1);
    
      % End of optional  
    
NEW_data = zeros(l, 26);

NEW_data(:, 1) = NewTable (:, 1); % time
%% AHA 1 to 6
NEW_data(:, 2) = NewTable (:, 22); % AHA1 and so on
NEW_data(:, 3) = NewTable (:, 23);
NEW_data(:, 4) = NewTable (:, 24);
NEW_data(:, 5) = NewTable (:, 19);
NEW_data(:, 6) = NewTable (:, 20);
NEW_data(:, 7) = NewTable (:, 21);
%% AHA 7 to 12
NEW_data(:, 8) = NewTable (:, 14);
NEW_data(:, 9) = NewTable (:, 15);
NEW_data(:, 10) = NewTable (:, 16);
NEW_data(:, 11) = NewTable (:, 11);
NEW_data(:, 12) = NewTable (:, 12);
NEW_data(:, 13) = NewTable (:, 13);
%% AHA 13 to 16
NEW_data(:, 14) = 2.0/3.0*NewTable (:, 6) + 1.0/6.0*(NewTable(:,5) + NewTable(:,7));
NEW_data(:, 15) = 1.0/2.0*NewTable (:, 7) + 1.0/2.0*NewTable (:, 8);
NEW_data(:, 16) = 2.0/3.0*NewTable (:, 3) + 1.0/6.0*(NewTable(:,4) + NewTable(:,8));
NEW_data(:, 17) = 1.0/2.0*NewTable (:, 4) + 1.0/2.0*NewTable (:, 5);

% LAD RCA and LCX curves
% Indices are always +1 wrt AHA

NEW_data(:, 18) = 1.0/6.0 *(NEW_data(:, 2) + NEW_data(:, 3) + NEW_data(:, 8) + NEW_data(:, 9) + NEW_data(:, 14) + NEW_data(:, 15));
NEW_data(:, 19) = 1.0/5.0 *(NEW_data(:, 4) + NEW_data(:, 5) + NEW_data(:, 10) + NEW_data(:, 11) + NEW_data(:, 16));
NEW_data(:, 20) = 1.0/5.0 *(NEW_data(:, 6) + NEW_data(:, 7) + NEW_data(:, 12) + NEW_data(:, 13) + NEW_data(:, 17));



%% Slices Block
NEW_data(:, 21) = mean(NEW_data(:, 2:7), 2); 
NEW_data(:, 22) = mean(NEW_data(:, 8:13), 2); 
NEW_data(:, 23) = mean(NEW_data(:, 14:17), 2); 

%% AIF block

NEW_data(:, 24) = NewTable (:, 18); % slice 3 in medis but this is slice 1 in AHA model 
NEW_data(:, 25) = NewTable (:, 10); % slice 2 in both
NEW_data(:, 26) = NewTable (:, 2); % slice 1 in medis but slice 3 in AHA model

%% Find Favoured AIF here and write it in the last column 
for i = 1:3
    AIF_peak(i) = max(NEW_data(:, 23+i));
end;

[max_AIF, max_AIF_index] = max (AIF_peak);

   switch max_AIF_index
       case 1
            max_AIF_col = 24
       case 2
            max_AIF_col = 25
       case 3
           max_AIF_col = 26
   end;
 
NEW_data(:, 27) = NEW_data(:, max_AIF_col); % this is your favoured AIF
   
% Up until here, you need to modify code to include NewTable

FileAHA16name = strcat(filename,'.AHA16_full')
fout3 = fopen(FileAHA16name, 'w');

fprintf(fout3, 'time\tAHA01\tAHA02\tAHA03\tAHA04\tAHA05\tAHA06\tAHA07\tAHA08\tAHA09\tAHA10\tAHA11\tAHA12\tAHA13\tAHA14\tAHA15\tAHA16\tLAD\tRCA\tLCX\tSlice1\tSlice2\tSlice3\tAIF1\tAIF2\tAIF3\tAIFmax\n');
[l m]=size(NEW_data);
for i = 1:l
    for j = 1:m
        if (NEW_data(i, j)==0)&& (i>1) 
            NEW_data(i,j) = NEW_data(i-1, j);
        end;
        fprintf(fout3, '%5.6e\t', NEW_data(i,j));
    end
    fprintf(fout3, '\n');

end
fclose(fout3);
end % if m = 18

% while ~feof(fout1)
%     line = fgets(fout1);
%     for i=1:NO_PHASES+1
%         
%     end
%     
% end
% close the file
fclose(fid);


