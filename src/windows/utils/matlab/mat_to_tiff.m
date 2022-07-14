%%
%% Matlab script to write a tiff file out the of the matlab variable. 
%% hThesis_mat_to_tiff.m file
%%
%% Author: Harsha Yogeshappa
%%
function mat_to_tiff(mat_var, filename)
warning('off','MATLAB:MKDIR:DirectoryExists');

out = 'I:\tensorflow_out\out\matlab';
mkdir(out);
% 'mat_var' is output of CNN model and thus the values will be between 0.0
% and 1.0. Therefore, scaling to 255 and casting to uint8 becomes necessary. 
a = uint8(mat_var * 255);
[~, ~, z] = size(a);

for i = 1 : z
    imwrite(a(:,:,i), [out '\' filename '.tif'], "WriteMode", "append");
end
end