
function invertGray(imagefile,newFile)

I = imread(imagefile);
I = uint8((double(I).*-1)+255);
imwrite(I,newFile,'tif')

end