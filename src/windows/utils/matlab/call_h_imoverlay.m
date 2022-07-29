function call_h_imoverlay(out_filepath)
warning('off','MATLAB:MKDIR:DirectoryExists');

out_filepath = convertStringsToChars(out_filepath);
overlay_out = join(out_filepath, 'overlay');
mkdir(overlay_out);

dir_list = dir(out_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = join(out_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.tif'))
            fprintf("%s \n", file_or_folder_name);
            moving_filepath = 'I:\00.masterarbeit_dataset\04.Affine_Registered\01.larvalign_data-Affine_Registered\tiff\scaled-np-channel\mip';
            atlas = imread('I:\00.masterarbeit_dataset\00.atlas\tif\mip\np_atlas_scaled.tif');
            movin = imread(file_or_folder_path);
            climF = [20,220];
            climB = [0,0.6];
            cmap = 'jet';
            alpha = 0.6;
            haxes= '';
            f = figure;
            subplot(1,2,2);
            imshowpair(atlas, movin);
            title("Overlay of Registered and Atlas Image");
            subplot(1,2,1);
            imshow([moving_filepath '\' file_or_folder_name]);
            title("Unregistered Subject Image");
            saveas(f, [out_filepath '\showpair\' file_or_folder_name]);
            clear f;
            close all;
            %h_imoverlay(atlas, movin, climF,climB,cmap,alpha, file_or_folder_path, haxes);

        end
    end
end
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end