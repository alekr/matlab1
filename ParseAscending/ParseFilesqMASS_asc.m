function ParseFilesqMASS_asc(filename);

% open the file
fid = fopen(filename, 'r');
[path, name, extension] = fileparts(filename);

% make sure the file is not empty
finfo = dir(filename);
fsize = finfo.bytes;
% NO_PHASES = 1;
slices = 0;
SLICE1 = 0;
SLICE2 = 0;
SLICE3 = 0;
TIME_FLAG = 0;
TRANSMURAL = 0; % try to initialise
if fsize > 0 

    % read the file
    while ~feof(fid)
        line = fgets(fid);
        
        z1 = strfind(line, 'Generated:');
        if (z1>0) 
            [token, remain] = strtok(line);
            [token, remain] = strtok(remain);
            
            Report_DATE = strtrim(token); 
            Report_TIME = strtrim(remain);
            date_token = regexprep(token, '/', ' '); 
            [day, remain] = strtok(date_token);
            [month, remain] = strtok(remain);
            [year, remain] = strtok(remain);
            new_date = strcat(year, '_');
            new_date = strcat(new_date, month);
            new_date = strcat(new_date, '_');
            new_date = strcat(new_date, day);
            
        end % end if generated
        
        m1 = strfind(line, 'Patient name:');
        if (m1>0) 
            [token, remain] = strtok(line);
            [token, remain] = strtok(remain);
            [token, remain] = strtok(remain);
            PATIENT = token;             
        end % end if patient name

        n1 = strfind(line, 'Study date:');
        if (n1>0) 
            [token, remain] = strtok(line);
            [token, remain] = strtok(remain);
            [token, remain] = strtok(remain);
            DATE = token;   
            date_token = regexprep(token, '/', ' '); 
            [day, remain] = strtok(date_token);
            [month, remain] = strtok(remain);
            [year, remain] = strtok(remain);
            new_date = strcat(year, '_');
            new_date = strcat(new_date, month);
            new_date = strcat(new_date, '_');
            new_date = strcat(new_date, day);
            
        end % end if patient name
        l1 = strfind(line, 'Series description:');
        if (l1>0) 
            [token, remain] = strtok(line);
            [token, remain] = strtok(remain);
            
            [token, remain] = strtok(remain);
            SERIES_DESC = strcat(token, remain);
            % SERIES_DESC = token; 
             
            
        end % end if patient name

        o1 = strfind(line, 'Manufacturer model:');
        if (o1>0) 
            [token, remain] = strtok(line);
            [token, remain] = strtok(remain);
            [token, remain] = strtok(remain);
            MODEL = token;             
        end % end if patient name

        q1 = strfind(line, 'Sampling range (endo-epi):');
        if (q1>0) 
            [token, remain] = strtok(line);
            [token, remain] = strtok(remain);
            [token, remain] = strtok(remain);
            TRANSMURAL = strtrim(remain);             
        end % end if sampling range

        r1 = strfind(line, 'Calibration method:');
        if (r1>0) 
            [token, remain] = strtok(line);
            [token, remain] = strtok(remain);
            NORMALISATION = strtrim(remain);             
        end % end if normalisation
        
        
        times = strfind(line, 'PHASE	TIME [ms]'); 
        if(times>0)
            TIME_FLAG = 1;
        end
        times_space = strfind(line, 'PHASE TIME [ms]');
        if(times_space>0)
            TIME_FLAG = 1;
        end
        
        s1 = strfind(line, 'Slice number 1');
        if (s1>0) 
            slices = 1; 
            SLICE1 = 1;
        end % end if slice1
        s2 = strfind(line, 'Slice number 2');
        if (s2>0) 
            slices = slices+1;  
            SLICE2 = 1;
        end % end if slice1
        s3 = strfind(line, 'Slice number 3');
        if (s3>0) 
            slices = slices+1; 
            SLICE3 = 1;
        end % end if slice1

    end % while read
end % end if size

% fout=strcat(path,PATIENT);
% fout=strcat(fout,'_');
% fout=strcat(fout,new_date);
% fout=strcat(fout,'_');
% fout=strcat(fout, name);
% fout=strcat(fout,'_');
% fout=strcat(fout, filename);
fout_name=strcat(name,'.ADV_INFO');
mass_name = strcat(name,'.TTIME_MASS');
% March 2019 process everything? even if you don't have full 3 slices
if(TIME_FLAG>0)&&(slices>0)
    roi_status = ParseFiles_3Slices_asc(filename, mass_name);
    
end;


fclose(fid);

%% write something out

fid_out=fopen(fout_name, 'w');

fprintf(fid_out, 'File\tPatient\tScanDate\tReportDate\tReportTime\tSeries\tModel\tTransmural\tNormalisation\tSlices\tTimes_OK\tSlice1\tSlice2\tSlice3\n');

if (TRANSMURAL) 
    fprintf(fid_out, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%d\t%d\t%d\t%d\t%d\n', filename, PATIENT, DATE, Report_DATE, Report_TIME, SERIES_DESC, MODEL, TRANSMURAL, NORMALISATION, slices, TIME_FLAG, SLICE1, SLICE2, SLICE3);
else
    fprintf(fid_out, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', filename, PATIENT, DATE, Report_DATE, Report_TIME, SERIES_DESC, MODEL);
end;

fclose(fid_out);
%% now try to extract your SI data
