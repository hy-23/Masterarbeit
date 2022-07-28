function callSplitChannels_and_saveNP(tif_filepath)
warning('off','MATLAB:MKDIR:DirectoryExists');

tif_filepath = convertStringsToChars(tif_filepath);
np_out = join(tif_filepath, 'np-channel');
mkdir(np_out);

dir_list = dir(tif_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = join(tif_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.tif'))
            splitChannels_and_saveNP(file_or_folder_path);
        end
    end
end
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end