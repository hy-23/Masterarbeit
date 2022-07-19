function traverse_and_find_tif(rootpath)
warning('off','MATLAB:MKDIR:DirectoryExists');
% rootpath should be a folder.

dir_list = dir(rootpath);
len_dir  = length(dir_list);

mip_out = join(rootpath, 'mip');
mkdir(mip_out);

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
            mip_zprojection(file_or_folder, 'mip');
        else
            % any other file
        end
    end
end
end

function mip_zprojection(filename, out)
info            = imfinfo(filename);
frames          = length(info);
width           = info.Width;
height          = info.Height;
tiff_link       = Tiff(filename,'r');
no_of_channels  = info.SamplesPerPixel;

if (no_of_channels == 3)
    M           = uint8(zeros(height, width, no_of_channels, frames));
    for slice = 1:frames
        tiff_link.setDirectory(slice);
        M(:,:,:,slice) = uint8(tiff_link.read());
    end
    N               = M(:,:,3,:); % NP channel
    Max_N           = max(N, [], 4);
elseif (no_of_channels == 1)
    fprintf("Channel 1\n");
    M           = uint8(zeros(height, width, frames));
    for slice = 1:frames
        tiff_link.setDirectory(slice);
        M(:,:,slice) = uint8(tiff_link.read());
    end
    N               = M(:,:,:); % NP channel
    Max_N           = max(N, [], 3);
else
    % nothing
end
[filepath, name, ext] = fileparts(filename);
mip_out = join(filepath, out);
out_file = [mip_out '\' name ext];
imwrite(Max_N, out_file);
end

function strRes = join(str1, str2)
strRes = [str1 '\' str2];
end