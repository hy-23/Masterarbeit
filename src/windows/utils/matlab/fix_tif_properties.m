%%
% open("I:\\masterarbeit_results\\results\\vxm_lrv_res1.0\\vxm_registered\\npz\\tiff\\moved_np_brain0_scaled.tif");
% run("Properties...", "channels=1 slices=64 frames=1 unit=mm pixel_width=0.4566402 pixel_height=0.4566402 voxel_depth=2.0000 frame=[0 sec]");
% run("Save", "save=I:\\masterarbeit_results\\results\\vxm_lrv_res1.0\\vxm_registered\\npz\\tiff\\np-channel\\vxm_moved_np_brain0_scaled.tif");
% close();
%%

function fix_tif_properties(filename)
[filepath, name, ext] = fileparts(filename);
out_filepath = [filepath '\np-channel'];
scanID = [name ext];

stmt1 = ['open("' filepath '\' scanID '");'];
stmt2 = 'run("Properties...", "channels=1 slices=64 frames=1 unit=mm pixel_width=0.4566402 pixel_height=0.4566402 voxel_depth=2.0000 frame=[0 sec]");';
stmt3 = ['run("Save", "save=' out_filepath '\' name ext '");'];
stmt4 = 'close();';

fprintf('%s\n',sepStr(stmt1));
fprintf('%s\n',sepStr(stmt2));
fprintf('%s\n',sepStr(stmt3));
fprintf('%s\n',sepStr(stmt4));
fprintf('\n');
end
