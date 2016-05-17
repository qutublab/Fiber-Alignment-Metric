% Saves images of peak fit results.

function getPeakFitImages(dirName, outputDir)
dirContents = dir(dirName);
numDirItems = size(dirContents, 1);
mkdir(outputDir);
for i = 1:numDirItems
    dirItem = dirContents(i);
    if ~dirItem.isdir
        fileName = dirItem.name;
        fullFileName = strcat(dirName, '/', fileName);
        fprintf('Processing file: %s\n', fileName);
        actinAlignment(fullFileName);
        
        % Create file name for peak fit image
        dotFindResult = findstr('.', fileName);
        lastDotIndex = size(dotFindResult, 2);
        if lastDotIndex == 0
            baseFileName = fileName;
        else
            lastDotPosition = dotFindResult(lastDotIndex);
            baseFileName = substring(fileName, 0, lastDotPosition-2);
        end
        peakFitFileName = strcat(outputDir, '/', baseFileName, 'PeakFit.jpg');
        
        h = get(0, 'CurrentFigure');
        saveas(h, peakFitFileName, 'jpg');
        fprintf('Saved peak fit image in file: %s\n', peakFitFileName);
        
    end
end



end