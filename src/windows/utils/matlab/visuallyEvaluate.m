function visuallyEvaluate()

%%
% Assumption:
% All the larvalign registered data are in the folder: lrv_filepath.
% All the voxelmorph registered data are in the folder: vxm_filepath.

%%
vxm_filepath = 'I:\tensorflow_out\out\matlab\Max_Projection_Voxelmorph'; % voxelmorph registered filepath.
lrv_filepath = 'D:\Harsha\Files_Hiwi\Output\RegisteredScans\TIFF\Max_Projection_Larvalign'; % larva registered filepath.
mov_filepath = 'I:\masterarbeit_dataset\data\tif\Max_Projection'; % moving  file's filepath.
str_filepath = 'I:\tensorflow_out\out\matlab\imshowpair'; % storage file's filepath.
tar_filepath = 'I:\masterarbeit_dataset\atlas'; % target  file's filepath.

tar_img = imread([tar_filepath '\' 'MAX_np_atlas_scaled.tif']);
vxm_search_pfx = 'MAX_moved_';
lrv_search_pfx = 'MAX_moved_';

%%
% For every moving file in the 'mov_filepath,' check if you have a
% corresponding file in 'vxm_filepath' and 'lrv_filepath'.
% If not found, then break the iteration and log it as an error in a file
% and continue with other moving files.

mov_filelist = dir(mov_filepath);
len_filelist = length(mov_filelist);

 % first 2 indices will be "." and ".."
for mvIdx = 3 : len_filelist
    mov_file = mov_filelist(mvIdx).name; % mov_file = "MAX_harsha.tif"
    mov_file = convertStringsToChars(mov_file); % mov_file = 'MAX_harsha.tif'
    reg_file = mov_file(5:end); % reg_file = harsha.tif
    vxm_search_file = [vxm_filepath '\' vxm_search_pfx reg_file];
    lrv_search_file = [lrv_filepath '\' lrv_search_pfx reg_file];

    % if any one of the registration is not found then whole process is
    % stopped. Should not be the case.
    
    % ToDo: Should write the error in file and carry on with the rest.
    assert( (isfile(vxm_search_file) || isfile(lrv_search_file)), ...
        ['Registration of moving file %s is not available either in ' ...
        'vxm or lrv'], mov_file);

    vxm_img = imread(vxm_search_file);
    lrv_img = imread(lrv_search_file);
    mov_img = imread([mov_filepath '\' mov_file]);

    [~, name, ext] = fileparts(mov_file);
    
    fig = figure("Name", name);

    subplot(2,4,1);
    imshow(tar_img)
    title("Atlas Image", "Interpreter", "none");
    colorbar();
    axis('on');

    subplot(2,4,2);
    imshow(mov_img);
    title("Subject Image", "Interpreter", "none");
    colorbar();
    axis('on');

    subplot(2,4,3);
    imshow(vxm_img);
    title("Voxelmorph Registered", "Interpreter", "none");
    colorbar();
    axis('on');

    subplot(2,4,4);
    imshowpair(tar_img, vxm_img);
    title("Voxelmorph Registration Evaluation" ,"Interpreter", "none");
    colorbar();
    axis('on');

    subplot(2,4,5);
    imshow(tar_img)
    title("Atlas Image", "Interpreter", "none");
    colorbar();
    axis('on');

    subplot(2,4,6);
    imshow(mov_img);
    title("Subject Image", "Interpreter", "none");
    colorbar();
    axis('on');

    subplot(2,4,7);
    imshow(lrv_img);
    title("Larvalign Registered", "Interpreter", "none");
    colorbar();
    axis('on');

    subplot(2,4,8);
    imshowpair(tar_img, lrv_img);
    title("Larvalign Registration Evaluation" ,"Interpreter", "none");
    colorbar();
    axis('on');

    fig.WindowState = 'maximized';
    saveas(fig, [str_filepath '\' name ext])
    clear fig;
    close all;
end
end