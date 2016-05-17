% Saves images of peak fit results.

function findPeakFitNegatives(dirName)
dirContents = dir(dirName);
numDirItems = size(dirContents, 1);
for i = 1:numDirItems
    dirItem = dirContents(i);
    if ~dirItem.isdir
        fileName = dirItem.name;
        fullFileName = strcat(dirName, '/', fileName);
        fprintf('Processing file: %s\n', fileName);
        actinAlignment(fullFileName);
        
    end
end



end