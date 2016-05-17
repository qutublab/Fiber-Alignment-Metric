% This function is the driver around the actinAlignement.m metric for only
% one image - the original cell. Make sure to hard code in the name of the
% output spreeadsheet. - Taylor Birk 7/23/2012

function [] = actinOrientation_Driver_JohnOriginalCell(imagefile,outputFilename)

        [FitResults LowestError] = actinAlignment(imagefile); 
        
        xlswrite(outputFilename,0,'Sheet1','A2');
        xlswrite(outputFilename,FitResults,'Sheet1','B2');
        xlswrite(outputFilename,LowestError,'Sheet1','G2');

        
end