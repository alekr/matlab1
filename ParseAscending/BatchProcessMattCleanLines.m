% ***********************************************************************
% Static values
% ***********************************************************************

    % Directory to process
    DIR_TO_PROCESS = '.';
    % Input file search pattern
    FILE_SEARCH_PATTERN = '*.txt';
    % Extension for files once their line endings are cleaned
    % (not used) FILE_EXT_CLEAN_LINE_ENDINGS = '.cleanBlanks';
    
% ***********************************************************************
% Start the script ...
% ***********************************************************************    

numberOfProcessedFiles = batchProcessDir(DIR_TO_PROCESS,FILE_SEARCH_PATTERN);

disp(strcat(string(numberOfProcessedFiles),' processed file(s).'));
