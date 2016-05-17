% JAFOM = John's Actin Fiber Orientation Metric


function jafom(coiImage, dirName, coiImageForDir, outFileName)

% Get COI data
[coiFitResults error]= actinAlignment(coiImage);

if error > 10 
    fprintf('Unable to fit COI data\n');
    return;
end
    
numCOIPeaks = size(coiFitResults, 1);

% Store individual COI peak data in coiPositionWeight
coiPositionWeight = zeros(numCOIPeaks, 2);
if numCOIPeaks == 1
    position = coiFitResults(2);
    weight = 100;
    coiPositionWeight(1, :) = [position, weight];
else
    s = sum(coiFitResults);
    totalArea = s(5);
    for i =1:numCOIPeaks
        position = coiFitResults(i, 2);
        area = coiFitResults(i, 5);
        weight = (area / totalArea) * 100;
        coiPositionWeight(i, :) = [position, weight];
    end
end

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
    [fitResults rms] = actinAlignment(fullFileName);
    for j = 1:numCOIPeaks
        coiPeakLocation = coiPositionWeight(j, 1);
        coiWeight = coiPositionWeight(j, 2);
        m = metric(fitResults, coiPeakLocation, coiWeight);
        fprintf(outFileID, '%f  ', m);
    end
    fprintf(outFileID, '\r\n', m);
end

fprintf('Last score is COI scored against COI for directory.\n');
[fitResults rms] = actinAlignment(coiImageForDir);
for j = 1:numCOIPeaks
    coiPeakLocation = coiPositionWeight(j, 1);
    coiWeight = coiPositionWeight(j, 2);
    m = metric(fitResults, coiPeakLocation, coiWeight);
    fprintf(outFileID, '%f  ', m);
end

fclose(outFileID);
end


function p = preComponent(position, weight, coiPeakPosition, coiPeakWeight)
locationDiff = coiPeakPosition - position;
weightDiff = coiPeakWeight - weight;
p = ((1 / (1 - ((weightDiff / 100)^2))) * locationDiff)^2;
end



function m = metric(FitResults, coiPeakLocation, coiPeakWeight)
numPeaks = size(FitResults, 1);
%fprintf('numPeaks=%d\n', numPeaks);
if numPeaks == 1
    position = FitResults(2);
    acc = preComponent(position, 100, coiPeakLocation, coiPeakWeight);
%    fprintf('position=%f\n', position);
else
%    FitResults
    s = sum(FitResults);
    totalArea = s(5);
    acc = 0;
    for i = 1:numPeaks
        %    [num position height width area]
        position = FitResults(i, 2);
        area = FitResults(i, 5);
        weight = (area / totalArea) * 100;
        pc = preComponent(position, weight, coiPeakLocation, coiPeakWeight);
        acc = acc + pc;
%        fprintf('area=%f totalArea=%f\n', area, totalArea);
    end
end
m = sqrt(acc);
end
