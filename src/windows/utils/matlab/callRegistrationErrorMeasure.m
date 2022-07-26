function [mmi, brain] = callRegistrationErrorMeasure()

brain = [];

v_mmi = [];
l_mmi = [];


vxm_rootpath = 'I:\masterarbeit_results\results\vxm_lrv_res1.0\vxm_registered\npz\mat\tiff\np-channel';
lrv_rootpath = 'I:\masterarbeit_results\results\vxm_lrv_res1.0\lrv_registered\zip\tiff\np-channel';
sub_rootpath = 'I:\masterarbeit_dataset\data\tif';

%% mip files
sub_mip = join(sub_rootpath, 'mip'); %subject files

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
    [v_tmp_mmi, v_tmp_brain] = RegistrationErrorMeasure(vxm_mmi_file);
    v_mmi = [v_mmi v_tmp_mmi];
    brain = [brain v_tmp_brain];
    
    fprintf("Performing registration evaluation for lrv: %s\n", lrv_mmi_file);
    [l_tmp_mmi, ~] = RegistrationErrorMeasure(lrv_mmi_file);
    l_mmi = [l_mmi l_tmp_mmi];
end
mmi = [v_mmi; l_mmi];
end