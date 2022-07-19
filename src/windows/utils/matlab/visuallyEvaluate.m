function visuallyEvaluate()
warning('off','MATLAB:MKDIR:DirectoryExists');

%%
% Assumption:
% All the larvalign registered data are in the folder: lrv_mip.
% All the voxelmorph registered data are in the folder: vxm_mip.

%%
str_filepath = 'I:\masterarbeit_results\results\vxm_lrv_res1.0\imshowpair'; % storage file's filepath.
mkdir(str_filepath);

%% rootpaths are the paths where np-channel tif files are available.
vxm_rootpath = 'I:\masterarbeit_results\results\vxm_lrv_res1.0\vxm_registered\npz\mat\tiff\np-channel';
lrv_rootpath = 'I:\masterarbeit_results\results\vxm_lrv_res1.0\lrv_registered\zip\tiff\np-channel';
sub_rootpath = 'I:\masterarbeit_dataset\data\tif';
ats_rootpath = 'I:\masterarbeit_dataset\atlas\tif';

%% mip files
vxm_mip = join(vxm_rootpath, 'mip'); %vxm results
lrv_mip = join(lrv_rootpath, 'mip'); %lar results
sub_mip = join(sub_rootpath, 'mip'); %subject files
ats_mip = join(ats_rootpath, 'mip'); %atlas files

%% tif files
% tif files are present in root directory.

%%
% For every moving file in the 'sub_mip,' check if you have a
% corresponding file in 'vxm_mip' and 'lrv_mip'.
% If not found, then break the iteration and log it as an error in a file
% and continue with other moving files.

sub_mip_list = dir(sub_mip);
len_sub_mip = length(sub_mip_list);

% first 2 indices will be "." and ".."
for subIdx = 3 : len_sub_mip
    % mip's are derived from tif. So if mip is present, tif should also be
    % present, unless you have done something bad.

    % e.g., sub_file = "harsha.tif"
    sub_file = sub_mip_list(subIdx).name;
    % e.g., reg_file = 'harsha.tif'
    reg_file = convertStringsToChars(sub_file);

    %% Assertion checks for files that will get plotted.
    ats_plot_file = [ats_mip '\' 'np_atlas_scaled.tif'];
    sub_plot_file = [sub_mip '\' reg_file];

    vxm_plot_file = [vxm_mip '\' reg_file];
    lrv_plot_file = [lrv_mip '\' reg_file];

    % if any one of the registration is not found then whole process is
    % stopped. Should not be the case.

    % ToDo: Should write the error in file and carry on with the rest.
    assert( (isfile(vxm_plot_file) || isfile(lrv_plot_file)), ...
        ['Registration of moving file %s is not available either in ' ...
        'vxm or lrv'], sub_file);

    %% Assertion checks for files that will compute mmi.
    vxm_mmi_file = [vxm_rootpath '\' reg_file];
    lrv_mmi_file = [lrv_rootpath '\' reg_file];

    % if any one of the registration is not found then whole process is
    % stopped. Should not be the case.

    % ToDo: Should write the error in file and carry on with the rest.
    assert( (isfile(vxm_mmi_file) || isfile(lrv_mmi_file)), ...
        ['Registration of moving file %s is not available either in ' ...
        'vxm or lrv'], sub_file);

    %% Perform RegistrationErrorMeasure.
    fprintf("Performing registration evaluation for vxm: %s\n", vxm_mmi_file);
    [v_mmi, ~] = RegistrationErrorMeasure(vxm_mmi_file);
    fprintf("Performing registration evaluation for lrv: %s\n", lrv_mmi_file);
    [l_mmi, ~] = RegistrationErrorMeasure(lrv_mmi_file);

    %% Plot imshowpair
    plot_imshowpair(ats_plot_file, sub_plot_file, ...
        lrv_plot_file, vxm_plot_file, ...
        l_mmi, v_mmi, str_filepath);

end
end

function plot_imshowpair(ats_plot_file, sub_plot_file, ...
    lrv_plot_file, vxm_plot_file, ...
    l_mmi, v_mmi, str_filepath)

ats_image = imread(ats_plot_file);
sub_image = imread(sub_plot_file);
lrv_image = imread(lrv_plot_file);
vxm_image = imread(vxm_plot_file);

[~, name, ext] = fileparts(sub_plot_file);

fig = figure("Name", name);
subplot(2,4,1);
imshow(ats_image)
title("Atlas Image", "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,2);
imshow(sub_image);
title("Subject Image", "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,3);
imshow(vxm_image);
title("Voxelmorph Registered", "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,4);
imshowpair(ats_image, vxm_image);
v_mmi_title = sprintf("VXM MMI: %d", v_mmi);
title(v_mmi_title);
colorbar();
axis('on');

subplot(2,4,5);
imshow(ats_image)
title("Atlas Image", "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,6);
imshow(sub_image);
title("Subject Image", "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,7);
imshow(lrv_image);
title("Larvalign Registered", "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,8);
imshowpair(ats_image, lrv_image);
l_mmi_title = sprintf("LRV MMI: %d", l_mmi);
title(l_mmi_title);
colorbar();
axis('on');

fig.WindowState = 'maximized';
saveas(fig, [str_filepath '\' name ext])
clear fig;
close all;

end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end