%%
%% Matlab script to write a tiff file out the of the matlab variable.
%% mat_to_tiff.m file
%%
%% Author: Harsha Yogeshappa
%%

function mat_to_tiff(mat_filepath)
warning('off','MATLAB:MKDIR:DirectoryExists');

mat_filepath = convertStringsToChars(mat_filepath);

tif_out = join(mat_filepath, 'tiff');
mkdir(tif_out);

dir_list = dir(mat_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = join(mat_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.mat'))
            fprintf("mat_file: %s\n", file_or_folder_path)
            write_tif(file_or_folder_path, tif_out)
        end
    end
end
end

function write_tif(filename, tifout)
mat_var = load(filename);
cel_var = struct2cell(mat_var);

% 'mat_var' is output of CNN model and thus the values will
% be between 0.0 and 1.0. Therefore, scaling to 255 and casting
% to 'uint8' becomes necessary.
a = uint8(cel_var{1} * 255);
[~, ~, z] = size(a);
[~, name, ~] = fileparts(filename);
pfx = 'moved_';
[~, c] = size(pfx);
name = name(1, c+1:end);
for i = 1 : z
    imwrite(a(:,:,i), [tifout '\' name '.tif'], "WriteMode", "append");
end
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end