% ************************************************************************
% This function processes a single file 
% ************************************************************************

function processSingleFile(fileName)
    % Clean any errors in line endings 
    cleanLineEndings(fileName);

    % process ???
	ParseFilesqMASS_asc(fileName);
end