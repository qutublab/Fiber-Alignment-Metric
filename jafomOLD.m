% JAFOM = John's Actin Fiber Orientation Metric


function jafom(coiImage, dirName, outFileName)

% Get COI data
coiFitResults = actinAlignment(coiImage);
if size(coiFitResults, 1) ~= 1
    fprintf('jafom: File %s yields %d peaks\n', coiImage, size(coiFitResults, 1));
    return;
end
coiPeakLocation = coiFitResults(2);
coiWeight = 100;
%fprintf('jafom: %s peak location: %d\n', coiImage, coiPeakLocation);

% Setup output file
%delete outFileName;
outFileID = fopen(outFileName, 'w');


% Apply metric to each tif file in directory
pattern = strcat(dirName, '/*.TIF');
dirContents = dir(pattern);
numFiles = size(dirContents, 1);
%fprintf('found %d files that matched %s', numFiles, pattern);
for i = 1:numFiles
    fileName = dirContents(i).name;
    fullFileName = strcat(dirName, '/', fileName);
    fprintf('Begin processing: %s\n', fileName);    
    [fitResults rms] = actinAlignment(fullFileName);
    m = metric(fitResults, coiPeakLocation, coiWeight);
    fprintf(outFileID, '%f \r\n', m);        
end

fclose(outFileID);
end

function multiPeak(coiFitResults)
numPeaks = size(coiFitResults, 1);
s = sum(coiFitResults);
totalArea = s(5);
for i =1:numPeaks
    position = coiFitResults(i, 2);
    area = coiFitResults(i, 5);
    weight = (area / totalArea) * 100;
end

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
