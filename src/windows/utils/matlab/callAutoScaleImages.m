%%
%% Matlab script to load the filenames in the list.txt file and pass it to 
%% hThesis_AutoScaleImages.m file
%%
%% Author: Harsha Yogeshappa
%%

function callAutoScaleImages(tif_filepath, width, height, slices, ...
                             pixelwidth, pixelheight, voxeldepth, findNPChannel)
warning('off','MATLAB:MKDIR:DirectoryExists');

% pixelwidth = 0.4566360;
% pixelheight = 0.4566360;
% voxeldepth = 2.0000000;

tif_filepath = convertStringsToChars(tif_filepath);
scaled_np_out = join(tif_filepath, 'scaled-np-channel');
mkdir(scaled_np_out);

dir_list = dir(tif_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = join(tif_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.tif'))
            filename = file_or_folder_path;
            fprintf("%s: %d\n", file_or_folder_name, dirIdx);
            autoScaleImages(filename, width, height, slices, ...
                            pixelwidth, pixelheight, voxeldepth, ...
                            scaled_np_out, findNPChannel);
        end
    end
end
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end
