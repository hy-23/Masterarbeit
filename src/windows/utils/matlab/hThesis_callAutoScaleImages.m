%%
%% Matlab script to load the filenames in the list.txt file and pass it to 
%% hThesis_AutoScaleImages.m file
%%
%% Author: Harsha Yogeshappa
%%

function hThesis_callAutoScaleImages(width, height, slices, ...
                                     pixelwidth, pixelheight, voxeldepth)
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
    hThesis_AutoScaleImages(filename, width, height, slices, pixelwidth, pixelheight, voxeldepth);
end
end