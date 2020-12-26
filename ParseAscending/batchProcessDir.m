function numberOfFilesProcessed = batchProcessDir(directory,searchPattern)

    % Change the current directory to the specified one
    cd(directory);
    
    % Scan the same folder in which this code file is, and return the list of
    % input files that match the provided pattern
    fileList = dir(searchPattern);

    % Get the list count (i.e. how many input files to process)
    numberOfFilesToProcess = size(fileList,1);

    % Iterate through all files and process them one at a time
    for fileIndex = 1:numberOfFilesToProcess

        % Get the file name with extension 
        fileName = fileList(fileIndex).name;
        % 	disp(inputFileNameWithExt);
        
        % Process single file
        processSingleFile(fileName);
   
    end
    
    numberOfFilesProcessed = numberOfFilesToProcess;
end
