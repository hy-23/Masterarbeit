%%
%% Matlab script to generate Fiji macro to load the 3-channel image and rescale only the NP channel.
%%
%% Author: Harsha Yogeshappa
%%

function [status,cmdout] = autoScaleImages(filename, width, ...
                                           height, slices, ...
                                           pixel_width, pixel_height, ...
                                           voxel_depth, scaled_np_out, ...
                                           findNPChannel)

% variables
tbd_filepath = 'D:\Harsha\tbd';
[filepath, name, ext] = fileparts(filename);
scanID = [name ext];

if (findNPChannel)
    rootdir = 'I:\00.masterarbeit_dataset\02.Additional_Data_Larvalign-original';
    filelist = dir(fullfile(rootdir, ['**\' name '.lsm']));
    LSM_PFN = [filelist.folder '\' filelist.name];

    [~, scaninf, ~] = lsminfo(LSM_PFN);
    index = find([scaninf.WAVELENGTH{:}] == 633);
    tmp_a = [1,2,3];
    tmp_b = tmp_a(tmp_a~=index);

    LSMchannelNP = int2str(index);
    LSMchannelNT = int2str(tmp_b(1));
    LSMchannelGE = int2str(tmp_b(2));
else
    LSMchannelNP = '3';
    LSMchannelNT = '2';
    LSMchannelGE = '1';
end

stmt_close = 'close();';

stmt0 = 'run("ImageJ2...", "scijavaio=true");';
stmt1 = ['open("' filepath '\' scanID '");'];
stmt2 = 'run("Split Channels");';
stmt3 = ['selectWindow("C' LSMchannelNT '-' scanID '");'];
stmt4 = ['selectWindow("C' LSMchannelGE '-' scanID '");'];
stmt5 = ['selectWindow("C' LSMchannelNP '-' scanID '");'];
stmt6 = ['run("Scale...", "x=- y=- z=- width=' int2str(width) ' height=' int2str(height) ' depth=' int2str(slices) ' interpolation=Bicubic average process create title=np_C' LSMchannelNP '-' name '_scaled.tif");'];
stmt7 = ['run("Properties...", "channels=1 slices=' int2str(slices) ' frames=1 unit=mm pixel_width=' num2str(pixel_width) ' pixel_height=' num2str(pixel_height) ' voxel_depth=' num2str(voxel_depth) '");'];
stmt8 = ['run("Save", "save=' scaled_np_out '\' 'np_C' LSMchannelNP '-' name '_scaled.tif");'];
stmt9 = ['selectWindow("C' LSMchannelNP '-' scanID '");'];

%rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
% Fiji in the root path does not work. I don't know why, but the updated FijiExe works.
FijiExe = '"D:\fiji-win64\Fiji.app\ImageJ-win64.exe" ';

fileID = fopen([sepStr([tbd_filepath '\']) name '_lsm2mhd.ijm'],'w');
fprintf(fileID,'%s\n',sepStr(stmt0));
fprintf(fileID,'%s\n',sepStr(stmt1));
fprintf(fileID,'%s\n',sepStr(stmt2));
fprintf(fileID,'%s\n',sepStr(stmt3));
fprintf(fileID,'%s\n',sepStr(stmt_close));
fprintf(fileID,'%s\n',sepStr(stmt4));
fprintf(fileID,'%s\n',sepStr(stmt_close));
fprintf(fileID,'%s\n',sepStr(stmt5));
fprintf(fileID,'%s\n',sepStr(stmt6));
fprintf(fileID,'%s\n',sepStr(stmt7));
fprintf(fileID,'%s\n',sepStr(stmt8));
fprintf(fileID,'%s\n',sepStr(stmt_close));
fprintf(fileID,'%s\n',sepStr(stmt9));
fprintf(fileID,'%s\n',sepStr(stmt_close));
fclose(fileID);

[status,cmdout] = system([FijiExe ' --headless -macro "' sepStr([tbd_filepath '\']) name '_lsm2mhd.ijm"']);
[~,~] = system([ 'del  /Q  "' [tbd_filepath '\'] name '_lsm2mhd.ijm"']); 
end