function [mmi, brain] = call_RegistrationErrorMeasure()

file_vxm = "I:\masterarbeit_results\results\vxm_lrv_res1.0\vxm_registered\npz\tiff\np-channels\list.txt";
file_lrv = "I:\masterarbeit_results\results\vxm_lrv_res1.0\lrv_registered\zip\tif\np-channel\list.txt";

file_str = [file_vxm, file_lrv];

mmi = [];
brain = [];
[~, fsize] = size(file_str);
for fileIdx = 1:fsize
    fileList = {};
    fileCount = 0;
    f = convertStringsToChars(file_str(fileIdx));
    fprintf("%s\n", f);
    fileId = fopen(file_str(fileIdx));
    tline = fgetl(fileId);
    mmi_tmp = [];
    brain_tmp = [];
    while ischar(tline)
        % https://de.mathworks.com/matlabcentral/answers/87549-append-to-an-array
        fileList = [fileList, tline];
        fileCount = fileCount + 1;
        tline = fgetl(fileId);
    end

    for i = 1 : fileCount
        filename = fileList{i};
        [m, b] = RegistrationErrorMeasure(filename);
        mmi_tmp = [mmi_tmp m];
        brain_tmp = [brain_tmp b];
    end
    size(mmi)
    mmi = [mmi; mmi_tmp];
    size(mmi)
end
brain = brain_tmp;
end