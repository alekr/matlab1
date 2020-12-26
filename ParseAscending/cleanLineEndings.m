% ************************************************************************
% This function cleans wrongly formatted input files which have 
%   CR CR LF
% instead of 
%   CR LF
% as line endings
% ************************************************************************
function cleanLineEndings(inputFileNameWithExt)
    % Get path and name of the input file 
    % Note: extension is of no interest here (hence the use of '~')
    % [inputFilePath, inputFileName, ~] = fileparts(inputFileNameWithExt);

    % Generate the output file name using the provided extension    
    % outputFullFileName = strcat(inputFilePath,inputFileName,newExt);

	% Read the input file
    inputFileContent = fileread(inputFileNameWithExt);
    
	% Replace any CRLFLF (0x0D0D0A) with CRLF (0x0D0A)
    % You can use https://hexed.it/ to view file as a binary stream
    cleanedFileContent = regexprep(inputFileContent, {'\r\r\n'}, {'\r\n'});
    
    % Open or create a new file for writing, discarding any existing
    % content (if the file already exists)
    outputFileHandle = fopen(inputFileNameWithExt, 'w+');

        % Write the cleaned content into the new output file
        fwrite(outputFileHandle, cleanedFileContent);
        
    % Close the output file making sure the contents are flushed to the
    % disk
    fclose(outputFileHandle);
end
