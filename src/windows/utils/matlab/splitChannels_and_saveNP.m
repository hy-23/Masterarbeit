%%
% open("I:\\masterarbeit_results\\results\\vxm_lrv_res1.0\\lrv_registered\\zip\\tif\\np_brain3_scaled.tif");
% //run("Channels Tool...");
% Stack.setDisplayMode("grayscale");
% run("Split Channels");
% selectWindow("C1-np_brain3_scaled.tif");
% selectWindow("C2-np_brain3_scaled.tif");
% selectWindow("C1-np_brain3_scaled.tif");
% selectWindow("C2-np_brain3_scaled.tif");
% selectWindow("C3-np_brain3_scaled.tif");
% selectWindow("C2-np_brain3_scaled.tif");
% selectWindow("C3-np_brain3_scaled.tif");
% run("Properties...", "channels=1 slices=64 frames=1 unit=mm pixel_width=0.4566402 pixel_height=0.4566402 voxel_depth=2.0000000");
% run("Save", "save=I:\\masterarbeit_results\\results\\vxm_lrv_res1.0\\lrv_registered\\zip\\tif\\np-channel\\lrv_np_brain3_scaled.tif");
% close();
% selectWindow("C2-np_brain3_scaled.tif");
% close();
% selectWindow("C1-np_brain3_scaled.tif");
% close();
% run("Close");

%%

function splitChannels_and_saveNP(filename)
[filepath, name, ext] = fileparts(filename);
out_filepath = [filepath '\np-channel'];
scanID = [name ext];

stmt1 = ['open("' filepath '\' scanID '");'];
stmt2 = '//run("Channels Tool...");';
stmt3 = 'Stack.setDisplayMode("grayscale");';
stmt4 = 'run("Split Channels");';
stmt5 = ['selectWindow("C1-' scanID '");'];
stmt6 = ['selectWindow("C2-' scanID '");'];
stmt7 = ['selectWindow("C1-' scanID '");'];
stmt8 = ['selectWindow("C2-' scanID '");'];
stmt9 = ['selectWindow("C3-' scanID '");'];
stmt10 = ['selectWindow("C2-' scanID '");'];
stmt11 = ['selectWindow("C3-' scanID '");'];
stmt12 = 'run("Properties...", "channels=1 slices=64 frames=1 unit=mm pixel_width=0.4566402 pixel_height=0.4566402 voxel_depth=2.0000000");';
stmt13 = ['run("Save", "save=' out_filepath '\' name ext '");'];
stmt14 = 'close();';
stmt15 = ['selectWindow("C2-' scanID '");'];
stmt16 = 'close();';
stmt17 = ['selectWindow("C1-' scanID '");'];
stmt18 = 'close();';

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
fprintf('%s\n',sepStr(stmt14));
fprintf('%s\n',sepStr(stmt15));
fprintf('%s\n',sepStr(stmt16));
fprintf('%s\n',sepStr(stmt17));
fprintf('%s\n',sepStr(stmt18));
fprintf('\n');

end