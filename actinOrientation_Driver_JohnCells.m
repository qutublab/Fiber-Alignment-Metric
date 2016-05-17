% This driver function automates running the Actin Orientation metric
% on all of John's cell images. The function returns two text files, one 
% with the average orientations and the other with the confidence interval. 
% The images are all single cells and the
% actin channel only. The format is tiff, and are of Colotype 'indexed',
% which imreadG16.m has not been modified to handle yet. The number of
% images is hard-coded into this source code. The names of the cells are
% all the same until the last number. A wildcard '%' is used to loop
% through the images.

% Taylor Birk
% Trying to model this code after David's metrics_FINAL_driver_JS.m

function [] = actinOrientation_Driver_JohnCells(numberOfImages,outputFilename)

    %outputFilename = 'Output_FitResults_ORG_JCC1010.xlsx';

    firstImageNumber = 1;
    %numberOfImages = 106; %Last image number
    maxNumPeaks = 4;

    index = 2+maxNumPeaks; %first cell is in row 6 (COI is in row 2)
    xlswrite(outputFilename,{'Cell #'},'Sheet1','A1');
    xlswrite(outputFilename,{'Peak Number'},'Sheet1','B1');
    xlswrite(outputFilename,{'Peak Position (degrees)'},'Sheet1','C1');
    xlswrite(outputFilename,{'Height'},'Sheet1','D1');
    xlswrite(outputFilename,{'Width'},'Sheet1','E1');
    xlswrite(outputFilename,{'Peak Area'},'Sheet1','F1');
     xlswrite(outputFilename,{'LowestError (rms)'},'Sheet1','G1');

    for i = firstImageNumber:numberOfImages
        
        if(i<10)
            imagefile = sprintf('SEQ000%d.TIF',i); 
        elseif(i<100)
            imagefile = sprintf('SEQ00%d.TIF',i);
        else
            imagefile = sprintf('SEQ0%d.TIF',i);
        end
        
        [FitResults LowestError] = actinAlignment(imagefile); 
        
        
        %Write fit results to the xls file
        % In the future: this should write to a MATRIX so that all
        % calculations can be done in MATLAB
        range = sprintf('A%d',index);
        xlswrite(outputFilename,i,'Sheet1',range);
        range = sprintf('B%d',index);
        xlswrite(outputFilename,FitResults,'Sheet1',range);
        range = sprintf('G%d',index);
        xlswrite(outputFilename,LowestError,'Sheet1',range);
        index = index + maxNumPeaks;
        

    end
    

end
