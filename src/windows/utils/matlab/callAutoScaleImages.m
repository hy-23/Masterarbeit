%%
%% Matlab script to load the filenames in the list.txt file and pass it to 
%% hThesis_AutoScaleImages.m file
%%
%% Author: Harsha Yogeshappa
%%

function callAutoScaleImages(width, height, slices, ...
                                     pixelwidth, pixelheight, voxeldepth)

% pixelwidth = 0.4566360;
% pixelheight = 0.4566360;
% voxeldepth = 2.0000000;

fileId = fopen('I:\masterarbeit_dataset\larvalign_data-affine_registered\DataSetRandomQual\list.txt', 'r');
fileList = {};
fileCount = 0;
tline = fgetl(fileId);

while ischar(tline)
    % https://de.mathworks.com/matlabcentral/answers/87549-append-to-an-array
    fileList = [fileList, tline];
    fileCount = fileCount + 1;
    tline = fgetl(fileId);
end

for i = 1 : fileCount
    filename = fileList{i};
    autoScaleImages(filename, width, height, slices, pixelwidth, pixelheight, voxeldepth);
end
end