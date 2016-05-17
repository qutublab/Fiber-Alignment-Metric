% This function finds the percent fo actin fibers aligned with the cell's
% major axis. THe "error" must be hard coded. "Errror" is degrees allowed
% to be considered aligned. For example, if the major cell axis is oriented
% at 77 degrees, then angles within +/-5 degrees are considered "aligned".
% This metric is designed to be incorporated into Jingzhe's metrics_all.m
% file.
%
% Taylor Birk
% last modified: 26 July 2012

function [stats, statsAlreadyComputed] = computeActinAlignmentToMajorAxis(stats, statsAlreadyComputed, stainImage, cellMask)

actinImg = stainImage{2}; %this metric only looks at the actin stain
actinImg = im2double(actinImg);

for idx_cell = 1:length(cellMask)
    mask = cellMask{idx_cell};
    I=actinImg.*mask;
    
    H1 = fspecial('sobel'); %returns the horizontal sobel filter
    Gh = imfilter(I,H1); %apply horizontal sobel filter
    Gv = imfilter(I,H1'); %apply vertical sobel filter

    %Calculate angles (theta) and edge intensities (R)
    theta = atan2(Gv,Gh).*(180/pi); 
    R = (Gh.^2 + Gv.^2).^0.5;


    %force interval of theta to be [-90,90] instead of [-180,180] originally
    thetaAbove90Bool = theta > 90;
    thetaBelowNeg90Bool = theta < -90;
    thetaCorrectBool = (theta <= 90) & (theta >= -90);
    theta = thetaCorrectBool.*theta + thetaAbove90Bool.*((thetaAbove90Bool.*theta)-180) + thetaBelowNeg90Bool.*((thetaBelowNeg90Bool.*theta)+180);


    %Any angles at -90 are changed to 90
    thetaNearNeg90 = theta==-90;
    thetaNotNearNeg90 = ~thetaNearNeg90;
    theta = thetaNotNearNeg90.*theta + thetaNearNeg90.*90;


    %Use a mask created from thresholding R (edge intensities)
    %to extract the actin's angles from all the angles 
    %(edges assumed to be the actin fibers)
    thresh = graythresh(R) + 0.1;
    actinMask = im2bw(R,thresh);

    %extract the angles of the actin fibers using the mask
    count = sum(sum(actinMask));            
    [nrows ncols] = size(theta);
    actinThetas = zeros(1,count); 
    index = 1;
    for r = 1:nrows
        for c = 1:ncols
            if(actinMask(r,c) == 1)
                actinThetas(index) = theta(r,c);
                index = index + 1;
            end
        end
    end

    %Find orientation of major axis of cell using regionprops.m
    prop = regionprops(mask,'Orientation'); %must pass a BW iamge
    orientationMajAxis = cat(1,prop.Orientation);

    %Find difference of actin fibers from major axis
    diffFromMajAxis = abs(actinThetas-orientationMajAxis);
    %Anything above 90 needs to be adjusted to between [0 90] degrees
    diffAbove90 = diffFromMajAxis>90;
    diffFromMajAxis = ~diffAbove90.*diffFromMajAxis + diffAbove90.*(180-diffFromMajAxis);
    error = 5; %error in degrees - HARD CODED
    %Find the angle differences within the given error
    anglesAligned = diffFromMajAxis<error;
    totalActinThetas = size(actinThetas,1).*size(actinThetas,2);
    percentAligned = sum(anglesAligned)./totalActinThetas.*100;

    stats(idx_cell,1).ActinAlignment = percentAligned;
end
end