% This function takes the PeakFit data from an Excel spreadsheet that
% contains the data from ALL the peaks. The first row is assumed to be a
% row of text. Each cell is 4 rows. Each cell may have 1-4 peaks. The first row is the original cell.

% Taylor Birk - 7/23/2012


function sumOfSquaresAll = peaksSumOfSquares(excelfile)
% This function finds the sum of quares of difference between peaks of the
% original cell and peaks of the patterened cell. Taylor Birk 7/23/2012

data = xlsread(excelfile); %numerical data from excel file
%numCells = ((size(data,1)+1)/4)-1; %not working because last cell #rows
numCells = 73;
%sumOfSquaresAll = zeros(1,numCells); %pre-allocate space
sumOfSquaresAll = [];

[peaksLocOrig wOrig] = getPeaksInfo(1,data);



maxNumPeaks=4;
for i = (2+maxNumPeaks):maxNumPeaks:numCells*maxNumPeaks+2 %1st patterned cell is in row 2+maxNumPeaks
    [peaksLocPatt wPatt] = getPeaksInfo(i,data);

    sumOfSquaredDiff = sumOfSquaredDiffOneCell(peaksLocOrig, peaksLocPatt, wOrig, wPatt); %shifted?   
    %sumOfSquaresAll((i+1)/4-1) = sumOfSquares; %need if pre-allocate space
    sumOfSquaresAll = [sumOfSquaresAll sumOfSquaredDiff]; %if space not pre-allocated

end

end

function sumOfSquaredDiff = sumOfSquaredDiffOneCell(peakLocOrig, peakLocPatt, wOrig, wPatt)
% Finds the sum of squared differences between patterned cell peaks and the
% original cell's peak. Currently, the code only works when the original
% cell has ONE peak only (as in the set ORG_JCC4003)

numPeaksOrig = size(peakLocOrig,2); % assumes both are row vectors
numPeaksPatt = size(peakLocPatt,2);
sumOfSquaredDiff=[];

if(numPeaksOrig~=1)
    disp('**Only the case where the original cell has one peak is being considered at this time.');
else
    weightedDiffOnePeak = zeros(1,numPeaksPatt);
    for i =1:numPeaksPatt
        weightedDiffOnePeak(i) = (1./(1-(wOrig-wPatt(i))./100)).*((peakLocOrig-peakLocPatt(i))./peakLocOrig).^2;
    end
    sumOfSquaredDiff = sum(weightedDiffOnePeak.^2).^0.5;
end


end


% function sumOfSquares = peaksSumOfSquaresOneCell(peakLocOrig,peakLocPatt, weightsOriginal, weightsPatterned)
% % This was the previous equation adn the idea of "fake peaks" (may need
% % this if original cell has more than one peak
% 
% %finds the sum of the squared differences for one cell
% 
% numPeaksOrig = size(peakLocOrig,2); % assumes both are row vectors
% numPeaksPatt = size(peakLocPatt,2);
% nearestPeak = zeros(numPeaksOrig,1); %pre-allocate space
% 
% %if numPeaksOrig>numPeaksPatt ...this has not been dealth with
% 
% for i = 1:numPeaksOrig
%    nearestPeak(i) = findNearestPeak(peakLocOrig(i),peakLocPatt);
% end
% 
% 
% if(numPeaksOrig>1)
%     for i =1:(size(nearestPeak,2)-1)
%         for j = (i+1):size(nearestPeak,2)
%             if(nearestPeak(i) == nearestPeak(j))
%                 disp('Competing peak pairs - PLEASE FIGUREO OUT!');
%                 %THIS HAS NOT BEEN DEALT WITH
%             end
%         end
%     end
% end
% 
% weightedDiffAll = []; %pre-allocate space? size = greatest num peaks
% if numPeaksOrig < numPeaksPatt
%     for i=1:numPeaksOrig
%         weightedDiff = weightsOriginal(i)./100.*peakLocOrig(i)-weightsPatterned(nearestPeak(i))./100.*peakLocPatt(nearestPeak(i));
%         weightedDiffAll = [weightedDiffAll weightedDiff];
%     end
% 
%     
%     unmatchedWeights = zeros(1,(numPeaksPatt-numPeaksOrig)); %pre-allocate
%     index = 1;
%    for i=1:numPeaksPatt
%        if(~ismember(i,nearestPeak))
%            unmatchedWeights(index) = weightsPatterned(i);
%            index = index+1;
%        end
%    end
%    
%   weightedDiffFakePeaks = unmatchedWeights./100.*90;
%   weightedDiffAll = [weightedDiffAll weightedDiffFakePeaks];
%   sumOfSquares = sum(weightedDiffAll.^2);
% end
% 
% if  numPeaksOrig == numPeaksPatt %no "fake" peaks
%     for i=1:numPeaksOrig
%         weightedDiff = weightsOriginal(i)./100.*peakLocOrig(i)-weightsPatterned(nearestPeak(i))./100.*peakLocPatt(nearestPeak(i));
%         weightedDiffAll = [weightedDiffAll weightedDiff];
%     end
%     sumOfSquares = sum(weightedDiffAll.^2);
% end
% 
% end


function nearestPeak = findNearestPeak(peakLocOrig, peaksLocPatt)
%finds the nearest Patterned Cell's peak to an Original Cell's peak Does
%NOT find using weighted difference - this may need to change

    %should this consider WEIGHTED distance?
    % For now this only considers the angle difference, not weighted
    % WHAT IF TWO PEAKS EQUIDISTANCE?? - not considered... just grabs first
    % peak it finds
    nearestPeak = -1;
    minDist = 100;
    
    for i=1:size(peaksLocPatt,2)
        dist = abs(peakLocOrig-peaksLocPatt(i));
        if(dist<minDist)
            nearestPeak = i;
            minDist = dist;
        end
    end
    
end

function [peaksLoc peaksW] = getPeaksInfo(startRow,numerical_data)
%returns the peak location and weight (from percent area) of one cell

% peak data is in the starting row to the starting row + 3 row
% column 'C'=3 contains peak location
% column 'F'=6 contains % Area (weight)

maxNumPeaks=4;
numRows = size(numerical_data,1);

    peaksLoc = [];
    peaksW=[];
    for i=startRow:startRow+maxNumPeaks-1
        if(i<=numRows)
            if(~isequalwithequalnans(numerical_data(i,3),NaN))
                peaksLoc = [peaksLoc numerical_data(i,3)];
                peaksW = [peaksW numerical_data(i,6)];
            end
        end
    end
end

