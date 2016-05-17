% This funcion automates looping through different number of peaks for the
% peakfit.m function until an rms of at least 0.9 is attained. - Taylor Birk
% 7/26/2012

function [FitResults, rms] = automatePeakFit(X, Y)
center = 0;
window = 180;
NumPeaks=1;
signal = [X' Y'];
rms=100;
maxNumPeaks=10;


while (rms > 10) %need to decide how to pick a good rms value
    %[FitResults,rms]=peakfit(signal,center,window,NumPeaks);
    % Changed to equal-width Gaussians; Byron 8-31-2012
    fprintf('automatePeakFit: Using equal-width gaussians\n');
    [FitResults,rms]=peakfit(signal,center,window,NumPeaks, 6);
    NumPeaks = NumPeaks+1;
    if(NumPeaks>maxNumPeaks)
        fprintf('**Could not find fit (rms<10) with maximum number (%d) of peaks allowed (rms=%f)\n', maxNumPeaks, rms);
        break;
    end
end


end

% Optional output parameters - peakfit.m 
% 1. FitResults: a table of model peak parameters, one row for each peak,
%    listing Peak number, Peak position, Height, Width, and Peak area.
% 2. LowestError/rms: The rms fitting error of the best trial fit.
% 3. BestStart: the starting guesses that gave the best fit.
% 4. xi: vector containing 100 interploated x-values for the model peaks. 
% 5. yi: matrix containing the y values of each model peak at each xi. 
%    Type plot(xi,yi(1,:)) to plot peak 1 or plot(xi,yi) to plot all peaks

