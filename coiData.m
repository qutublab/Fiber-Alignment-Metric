% ../../Collaboration_JohnSlater/2012-06-21-JHS/


function coiData(dirName)

% Descend into file structure
path1 = dirName;
dirContents = dir(path1);
numDirItems = size(dirContents, 1);
% Skip first two listings which are current and parent directories
for i = 3:numDirItems
    dirItem = dirContents(i);
    if dirItem.isdir == 1
        subDirName = dirItem.name;
        path2 = strcat(path1, '/', subDirName);
%        fprintf('%s\n', subDirName);
        subDirContents = dir(path2);
        numSubDirItems = size(subDirContents, 1);
        % skip current and parent directories
        for j = 3:numSubDirItems
            subDirItem = subDirContents(j);
            if subDirItem.isdir == 1
                sub2DirName = subDirItem.name;
%                fprintf('  %s\n', sub2DirName);
                path3 = strcat(path2, '/', sub2DirName);
                sub2DirContents = dir(strcat(path3, '/*COI'));
                numSub2DirContents = size(sub2DirContents, 1);
                for k = 1:numSub2DirContents
                    sub2DirItem = sub2DirContents(k);
                    if sub2DirItem.isdir == 1
                        sub3DirName = sub2DirItem.name;
%                        fprintf('    %s\n', sub3DirName);
                        
                        sub3DirContents = dir(strcat(dirName, '/', subDirName, '/', sub2DirName, '/', sub3DirName, '/*COI-ACT.TIF'));
                        numSub3DirContents = size(sub3DirContents, 1);
                        for l = 1:numSub3DirContents
                            sub3DirItem = sub3DirContents(l);
                            fprintf('      %s\n', sub3DirItem.name);
                        end
                    end
                end
            end
        end
    end
end
    



end