function traverse_and_find_tif(rootpath)
% rootpath should be a folder.

dir_list = dir(rootpath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder = dir_list(dirIdx).name;
    file_or_folder = join(rootpath, file_or_folder);
    if isfolder(file_or_folder)
        traverse_and_find_tif(file_or_folder);
    else
        if(endsWith(file_or_folder, '.tif'))
            % is a tif file, so call max_projection
            fprintf("tif file: %s\n", file_or_folder);
            mip_zprojection(file_or_folder);
        else
            % any other file
        end
    end
end
end

function mip_zprojection(filename)
info            = imfinfo(filename);
frames          = length(info);
width           = info.Width;
height          = info.Height;
tiff_link       = Tiff(filename,'r');
no_of_channels  = info.SamplesPerPixel;

if (no_of_channels > 1)
    M           = uint8(zeros(height, width, no_of_channels, frames));
    for slice = 1:frames
        tiff_link.setDirectory(slice);
        M(:,:,:,slice) = uint8(tiff_link.read());
    end
    N               = M(:,:,3,:); % NP channel
    Max_N           = max(N, [], 4);
else
    M           = uint8(zeros(height, width, frames));
    for slice = 1:frames
        tiff_link.setDirectory(slice);
        M(:,:,slice) = uint8(tiff_link.read());
    end
    N               = M(:,:,:); % NP channel
    Max_N           = max(N, [], 3);
end

[filepath, name, ext] = fileparts(filename);
out_file = [filepath '\MAX_' name ext];
imwrite(Max_N, out_file);
end

function strRes = join(str1, str2)
strRes = [str1 '\' str2];
end