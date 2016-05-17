% Runs jafom with particular parameters
function jafom2()
%fileDirName = 'C:\Users\ebionic\Dropbox\Collaboration_JohnSlater\2012-06-21-JHS\';
fileDirName = 'C:\Users\ebionic\Dropbox\TaylorBirk Folder\COI-ACTIN\';
coiFileNames = cell(8, 1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Make sure that coiFileNames{i} and
% patternDirNames{i} refer to the same
% directory, e.g., COLSHAPE\JCC1003
%
% This ensures that that in the call
% to function jafom below, the
% arguments patternDN and patternCoiFN
% agree.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
coiFileNames{1} = strcat(fileDirName, 'JCC1003-COI-ACT.TIF');
coiFileNames{2} = strcat(fileDirName, 'JCC3113-COI-ACT.TIF');
coiFileNames{3} = strcat(fileDirName, 'JCC3118-COI-ACT.TIF');
coiFileNames{4} = strcat(fileDirName, 'JCC3119-COI-ACT.TIF');
coiFileNames{5} = strcat(fileDirName, 'JCC1010-COI-ACT.TIF');
coiFileNames{6} = strcat(fileDirName, 'JCC4003-COI-ACT.TIF');
coiFileNames{7} = strcat(fileDirName, 'JCC1008-COI-ACT.TIF');
coiFileNames{8} = strcat(fileDirName, 'JCC1009-COI-ACT.TIF');

% patternDirNames = cell(8, 1);
% patternDirNames{1} = strcat(fileDirName, 'COLSHAPE\JCC1003\Patterned Cells\ACT');
% patternDirNames{2} = strcat(fileDirName, 'COLSHAPE\JCC3113\Patterned Cells\ACT');
% patternDirNames{3} = strcat(fileDirName, 'MIGRATE_SCALED\JCC1009\Patterned Cells\ACT');
% patternDirNames{4} = strcat(fileDirName, 'MIGRATE_SCALED\JCC3119\Patterned Cells\ACT');
% patternDirNames{5} = strcat(fileDirName, 'ORG\JCC1010\Patterned Cells\ACT');
% patternDirNames{6} = strcat(fileDirName, 'ORG\JCC4003\Patterned Cells\ACT');
% patternDirNames{7} = strcat(fileDirName, 'TEXAS\JCC1008\Patterned Cells\ACT');
% patternDirNames{8} = strcat(fileDirName, 'TEXAS\JCC3118\Patterned Cells\ACT');
patternDirNames = cell(4, 1);
patternDirNames{1} = 'C:\Users\ebionic\Dropbox\Collaboration_JohnSlater\2013-03-26\R001\ACT';
patternDirNames{2} = 'C:\Users\ebionic\Dropbox\Collaboration_JohnSlater\2013-03-26\R002\ACT';
patternDirNames{3} = 'C:\Users\ebionic\Dropbox\Collaboration_JohnSlater\2013-03-26\R003\ACT';
patternDirNames{4} = 'C:\Users\ebionic\Dropbox\Collaboration_JohnSlater\2013-03-26\R123\ACT';



for i = 1:size(coiFileNames, 1)
   coiFN = coiFileNames{i};
   slashIndices = findstr('\', coiFN);
%    numSlashes = size(slashIndices, 2);
%    slashIndex1 = slashIndices(numSlashes - 2);
%    slashIndex2 = slashIndices(numSlashes - 1);
%    coiName = coiFN(slashIndex1+1:slashIndex2-1);
   lastSlashIndex = slashIndices(end);
   coiName = coiFN(lastSlashIndex+1:lastSlashIndex+1+6);
   for j = 1:size(patternDirNames, 1)
      patternDN = patternDirNames{j};
%       patternCoiFN = coiFileNames{j};
      % Create output file name
      slashIndices = findstr('\', patternDN);
      numSlashes = size(slashIndices, 2);
%       slashIndex1 = slashIndices(numSlashes - 2);
%       slashIndex2 = slashIndices(numSlashes - 1);
%       patternName = patternDN(slashIndex1+1:slashIndex2-1);
      slashIndex1 = slashIndices(end);
      slashIndex2 = slashIndices(end-1);
      patternName = patternDN(slashIndex2+1:slashIndex1-1);
      outFileName =  strcat('coi', coiName, '-pat', patternName);
      fprintf('Starting: %s\n', outFileName);
%       jafom(coiFN, patternDN, patternCoiFN, outFileName);
      jafom(coiFN, patternDN, outFileName);
   end
end

end