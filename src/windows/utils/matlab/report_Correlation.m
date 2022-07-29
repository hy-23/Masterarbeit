function [t] = report_Correlation(file_template, subject_filepath_before, subject_filepath_after)
warning('off','all');
sub_name = [];
correlation_before = [];
correlation_after = [];
dir_list = dir(subject_filepath_before);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = join(subject_filepath_before, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.tif'))
            file_subject_before = file_or_folder_path;
            file_subject_after  = join(subject_filepath_after, file_or_folder_name);

            M_before = compute_correlation_before(file_template, file_subject_before);
            M_after  = compute_correlation_before(file_template, file_subject_after);
            sub_name = [sub_name, convertCharsToStrings(file_or_folder_name)];
            correlation_before = [correlation_before, M_before];
            correlation_after = [correlation_after, M_after];
            fprintf("%s: %d: %g : %g\n", file_or_folder_name, dirIdx, M_before, M_after);
        end
    end
end
name = sub_name';
corr_before = correlation_before';
corr_after = correlation_after';
t = table(name, corr_before, corr_after);
end

function M = compute_correlation_before(file_template, file_subject_before)
atlas  = read_tiff_stack(file_template);
moving = read_tiff_stack(file_subject_before);

template = single(atlas);
subject  = single(moving);

C = corrcoef(template, subject);
M = mean(C, "all");
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end