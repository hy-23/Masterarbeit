function unzip_larvalign_output(zip_filepath)
warning('off','MATLAB:MKDIR:DirectoryExists');

zip_filepath = convertStringsToChars(zip_filepath);

zip_out = join(zip_filepath, 'tiff');
mkdir(zip_out);

dir_list = dir(zip_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = join(zip_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.zip'))
            fprintf("zip_file: %s\n", file_or_folder_path)
            unzip(file_or_folder_path, zip_out)
        end
    end
end
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end