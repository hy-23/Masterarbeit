function validate_slice_size(tif_filepath)

tif_filepath = convertStringsToChars(tif_filepath);

dir_list = dir(tif_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = join(tif_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.tif'))
            fprintf("%s: %d\n", file_or_folder_name, dirIdx),
            M = read_tiff_stack(file_or_folder_path);
            [h, w, z] = size(M);
            assert(h==512, w==256, z==64, "file: %s has problem", file_or_folder_name);
        end
    end
end
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end