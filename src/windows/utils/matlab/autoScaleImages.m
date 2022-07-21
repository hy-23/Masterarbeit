%%
%% Matlab script to generate Fiji macro to load the 3-channel image and rescale only the NP channel.
%%
%% Author: Harsha Yogeshappa
%%

function autoScaleImages(filename, width, height, slices, ...
                         pixel_width, pixel_height, voxel_depth, ...
                         scaled_np_out)

% variables

[filepath, name, ext] = fileparts(filename);
scanID = [name ext];

stmt1 = ['open("' filepath '\' scanID '");'];
stmt2 = 'run("Split Channels");';
stmt3 = ['selectWindow("C2-' scanID '");'];
stmt4 = 'close();';
stmt5 = ['selectWindow("C1-' scanID '");'];
stmt6 = 'close();';
stmt7 = ['selectWindow("C3-' scanID '");'];
stmt8 = ['run("Scale...", "x=- y=- z=- width=' int2str(width) ' height=' int2str(height) ' depth=' int2str(slices) ' interpolation=Bicubic average process create title=np_' name '_scaled.tif");'];
stmt9 = ['run("Properties...", "channels=1 slices=' int2str(slices) ' frames=1 unit=mm pixel_width=' num2str(pixel_width) ' pixel_height=' num2str(pixel_height) ' voxel_depth=' num2str(voxel_depth) '");'];

stmt10 = ['run("Save", "save=' scaled_np_out '\' 'np_' name '_scaled.tif");'];
stmt11 = 'close();';
stmt12 = ['selectWindow("C3-' scanID '");'];
stmt13 = 'close();';

%% For some reason, calling these lines from matlab script on Fiji does not work.
%% So, the lines are printed and then saved on Fiji.

%{
rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
FijiExe = ['"' rootpath '\resources\exe\Fiji\ImageJ-win64.exe" ' ];

fileID = fopen([sepStr([filepath '\']) name '_lsm2mhd.txt'],'w');
fprintf(fileID,'%s\n',sepStr(stmt1));
fprintf(fileID,'%s\n',sepStr(stmt2));
fprintf(fileID,'%s\n',sepStr(stmt3));
fprintf(fileID,'%s\n',sepStr(stmt4));
fprintf(fileID,'%s\n',sepStr(stmt5));
fprintf(fileID,'%s\n',sepStr(stmt6));
fprintf(fileID,'%s\n',sepStr(stmt7));
fprintf(fileID,'%s\n',sepStr(stmt8));
fprintf(fileID,'%s\n',sepStr(stmt9));
fprintf(fileID,'%s\n',sepStr(stmt10));
fprintf(fileID,'%s\n',sepStr(stmt11));
fprintf(fileID,'%s\n',sepStr(stmt12));
fprintf(fileID,'%s\n',sepStr(stmt13));
fclose(fileID);

[status,cmdout] = system([FijiExe ' --headless -macro "' sepStr([filepath '\']) name '_lsm2mhd.txt"']);
%}

fprintf('%s\n',sepStr(stmt1));
fprintf('%s\n',sepStr(stmt2));
fprintf('%s\n',sepStr(stmt3));
fprintf('%s\n',sepStr(stmt4));
fprintf('%s\n',sepStr(stmt5));
fprintf('%s\n',sepStr(stmt6));
fprintf('%s\n',sepStr(stmt7));
fprintf('%s\n',sepStr(stmt8));
fprintf('%s\n',sepStr(stmt9));
fprintf('%s\n',sepStr(stmt10));
fprintf('%s\n',sepStr(stmt11));
fprintf('%s\n',sepStr(stmt12));
fprintf('%s\n',sepStr(stmt13));
fprintf('\n');
end