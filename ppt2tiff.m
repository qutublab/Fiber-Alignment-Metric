% Taylor Birk
% TIFF files saved from powerpoint have 3rd dimension of length 4.
% This method extraxts the 1st plane of the 3rd dimension and writes it to
% a new file so that I can use the images to test the actin alignment
% metric

function ppt2tiff(imagefile,newName)

I = imread(imagefile);
imwrite(I(:,:,1),newName+'.tif','tif');

end