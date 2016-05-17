% This function is the driver around the actinAlignement.m metric for only
% one image - the original cell. Make sure to hard code in the name of the
% output spreeadsheet. - Taylor Birk 7/23/2012

function [] = actinOrientation_Driver_JohnOriginalCell2(imagefile)

        
        [avg binSizes binCenters] = actinAlignment(imagefile); 
        
        newfilename = 'Output_JCC4003-COI.xls';
        
        xlswrite(newfilename,{'BinCenters'},'Sheet1','A1');
        xlswrite(newfilename,{'BinHeights'},'Sheet1','B1');
        xlswrite(newfilename,binCenters','Sheet1','A2');
        xlswrite(newfilename,binSizes','Sheet1','B2');
        
        
end