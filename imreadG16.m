% imreadG16() returns a 16-bit grayscale image regardless of
% the original image file type. This standardizes the functions used to
% manipulate greyscale images.


function I = imreadG16(filename, fileInfo, index)
  if ((index < 1) | (index > size(fileInfo, 1)))
      fprintf('File %s does not contain %d images\n', filename, index);
      I = -1;
      return;
  end
  
  % More than one image might be stored in the file.  Get the information
  % for the requested image
  info = fileInfo(index);
  colorType = info.ColorType;
  bitsPerPixel = info.BitDepth;
  
  % Currently only RGB (truecolor) and grayscale images are supported
  if (~strcmp(colorType, 'truecolor') & ~strcmp(colorType, 'grayscale')  & ~strcmp(colorType, 'indexed'))
      fprintf('File %s has unsupported color type: %s\n', filename, colorType);
      I = -1;
      return;
  end
  
  % Indexing not allowed for all file types, but we can fake it when
  % the index is 1.
  if (index == 1)
      I = imread(filename);
  else
      I = imread(filename, 'Info', fileInfo, 'Index', index);
  end
  
  % Convert color to grayscale
  if (strcmp(colorType, 'truecolor'))
      I = rgb2gray(I);
      pixelClass = class(I);
      % Support for single and double can be done by multiplying each
      % single or double value by the maximum uint16 value.
      if (strcmp(pixelClass, 'single') | strcmp(pixelClass, 'double'))
          fprintf('File %s has unsupported pixel class: %s\n', filename, pixelClass);
          I = -1;
          return;
      end
      % RGB uses 3 times as many bits as the converted grayscale image.
      bitsPerPixel = bitsPerPixel / 3;
  end
  
  if (bitsPerPixel == 16)
      return;
  end
  
  % Convert to uint16.  Note that the largest unsigned number that can be
  % stored in n bits is (2^n - 1).
  scale = double(((2^16) - 1) / ((2^bitsPerPixel) - 1));
  I = uint16(double(I) * scale);
end