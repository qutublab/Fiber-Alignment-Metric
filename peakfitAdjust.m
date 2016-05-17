% peakfitAdjust.m takes the table of bin center adn height sizes from the
% actin orientation metrics and puts each cell in an individual file so
% that the histogram data can be fit to a curve using the PeakFit software

function peakfitAdjust
    
    filename = 'Bins_ORG_JCC1010';
    filetype = '.xls';
    fullFilename = strcat(filename,filetype);
    [num,text,raw] = xlsread(fullFilename);
    
    for i=1:2:size(num,1) %go through every odd row (bin centers)
        cellNumber = (i+1)/2;
        newfileNum = sprintf('_%d.xls',cellNumber);
        newfilename = strcat(filename,newfileNum);
        
        xlswrite(newfilename,{'BinCenters'},'Sheet1','A1');
        xlswrite(newfilename,{'BinHeights'},'Sheet1','B1');
        xlswrite(newfilename,num(i:i+1,:)','Sheet1','A2');
    end

end