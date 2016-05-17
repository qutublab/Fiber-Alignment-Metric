% JAFOM = John's Actin Fiber Orientation Metric


%function jafom(coiImage, dirName, coiImageForDir, outFileName)
function jafom(coiImage, dirName, outFileName)

% Get COI data and create histogram
[coiActinAngles coiNumBins]= actinAlignment(coiImage);
coiHistBinSizes = hist(coiActinAngles, coiNumBins);
coiNormHistBinSizes = coiHistBinSizes / sum(coiHistBinSizes(:));


%coiBinSizesNormalized = coiHistBinSize/size(coiActinAngles, 2);



outFileID = fopen(outFileName, 'w');


% If dirName is not the name of a directory, then assume that is
% the name of a single file.


pattern = strcat(dirName, '/*.TIF');
dirContents = dir(pattern);
numFiles = size(dirContents, 1);
% Apply metric to each tif file in directory
for i = 1:numFiles
    fileName = dirContents(i).name;
    fullFileName = strcat(dirName, '/', fileName);
    fprintf('Begin processing: %s\n', fileName);    
    [actinAngles numBins]= actinAlignment(fullFileName);
    patternHistBinSizes = hist(actinAngles, coiNumBins);
    patternNormHistBinSizes = patternHistBinSizes / sum(patternHistBinSizes(:));
    m = distanceMetric(coiNormHistBinSizes, patternNormHistBinSizes);
    fprintf(outFileID, '%f\r\n', m);
    close all;
%     figure, hist(actinAngles, numBins);
%     figure, hist(actinAngles, coiNumBins);
%     pause(5);
end

% fprintf('Last score is COI scored against COI for directory.\n');
% actinAngles = actinAlignment(coiImageForDir);
% patternHistBinSizes = hist(actinAngles, coiNumBins);
% patternNormHistBinSizes = patternHistBinSizes / sum(patternHistBinSizes(:));
% m = distanceMetric(coiNormHistBinSizes, patternNormHistBinSizes);
% fprintf(outFileID, '%f\r\n', m);

fclose(outFileID);
end


function d = distanceMetric(v1, v2)
diff = v1 - v2;
sumSqr = sum(diff .* diff);
d = sqrt(sumSqr);
end

