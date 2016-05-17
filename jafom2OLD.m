% Runs jafom with particular parameters
function jafom2()
fileDirName = 'C:\Users\ebionic\Dropbox\Collaboration_JohnSlater\2012-06-21-JHS\';
coiFileNames = cell(8, 1);
coiFileNames{1} = strcat(fileDirName, 'COLSHAPE\JCC1003\JCC1003-COI\JCC1003-COI-ACT.TIF');
coiFileNames{2} = strcat(fileDirName, 'COLSHAPE\JCC3113\JCC3113-COI\JCC3113-COI-ACT.TIF');
coiFileNames{3} = strcat(fileDirName, 'MIGRATE\JCC1009\JCC1009-COI\JCC1009-COI-ACT.TIF');
coiFileNames{4} = strcat(fileDirName, 'MIGRATE\JCC3119\JCC3119-COI\JCC3119-COI-ACT.TIF');
coiFileNames{5} = strcat(fileDirName, 'ORG\JCC1010\JCC1010COI\JCC1010-COI-ACT.TIF');
coiFileNames{6} = strcat(fileDirName, 'ORG\JCC4003\JCC4003COI\JCC4003-COI-ACT.TIF');
coiFileNames{7} = strcat(fileDirName, 'TEXAS\JCC1008\JCC1008-COI\JCC1008-COI-ACT.TIF');
coiFileNames{8} = strcat(fileDirName, 'TEXAS\JCC3118\JCC3118-COI\JCC3118-COI-ACT.TIF');

patternDirNames = cell(8, 1);
patternDirNames{1} = strcat(fileDirName, 'COLSHAPE\JCC1003\Patterned Cells\ACT');
patternDirNames{2} = strcat(fileDirName, 'COLSHAPE\JCC3113\Patterned Cells\ACT');
patternDirNames{3} = strcat(fileDirName, 'MIGRATE\JCC1009\Patterned Cells\ACT');
patternDirNames{4} = strcat(fileDirName, 'MIGRATE\JCC3119\Patterned Cells\ACT');
patternDirNames{5} = strcat(fileDirName, 'ORG\JCC1010\Patterned Cells\ACT');
patternDirNames{6} = strcat(fileDirName, 'ORG\JCC4003\Patterned Cells\ACT');
patternDirNames{7} = strcat(fileDirName, 'TEXAS\JCC1008\Patterned Cells\ACT');
patternDirNames{8} = strcat(fileDirName, 'TEXAS\JCC3118\Patterned Cells\ACT');


for i = 1:8
   coiFN = coiFileNames{i};
   slashIndices = findstr('\', coiFN);
   numSlashes = size(slashIndices, 2);
   slashIndex1 = slashIndices(numSlashes - 2);
   slashIndex2 = slashIndices(numSlashes - 1);
   coiName = coiFN(slashIndex1+1:slashIndex2-1);
   for j = 1:8
      patternDN = patternDirNames{j};
      slashIndices = findstr('\', patternDN);
      numSlashes = size(slashIndices, 2);
      slashIndex1 = slashIndices(numSlashes - 2);
      slashIndex2 = slashIndices(numSlashes - 1);
      patternName = patternDN(slashIndex1+1:slashIndex2-1);
      outFileName =  strcat('coi', coiName, '-pat', patternName);
      fprintf('Starting: %s\n', outFileName);
      jafom(coiFN, patternDN, outFileName);
   end
end

end