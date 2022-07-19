function [ESnormedMMI, brain_name] = RegistrationErrorMeasure(filename)

[RegOutputDir, scanID, ext] = fileparts(filename);

rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
TemplateImagePFN = [rootpath '\resources\Templates\Neuropil\AtlasImgMedian.tif'];
REDPN = [ rootpath '\resources\RED\'];

IR_PFN = [ RegOutputDir '\' scanID ext ];

%% Preprocessing
c3d = ['"' rootpath '\resources\exe\c3d.exe" '];
[status,cmdout] = system([  c3d '"' IR_PFN '"  -info-full ']);
assert(status==0, 'Processing failure.')

Ctmp=textscan(cmdout,'%s','Delimiter',{'  Mean Intensity     : '});
lowclip=num2str(ceil(cell2mat(textscan(Ctmp{1,1}{7,1},'%f'))));

IRN_PFN = [RegOutputDir  scanID '_processed.tif'];
[status,~] = system([  c3d '"' IR_PFN '"  -clip ' lowclip ' 255  -replace ' lowclip ' 0  -type uchar -compress -o ' '"' IRN_PFN '"' ]);
assert(status==0, 'Processing failure.')
IR_PFN = IRN_PFN;
matName='MaskedMetricEntireScan';
MaskPFN = [REDPN 'CNS\CNS_Mask.tif'];

% MMI
[status,cmdout] = system([c3d '"' TemplateImagePFN '"' ' ' '"' IR_PFN '"' ' ' '"' MaskPFN '"' ' -popas fmask -mmi']);
assert(status==0, 'MMI computation failure.')
res=textscan(cmdout,'%s','Delimiter',{'='});
MaskedMetricValue(1) = nan;
MaskedMetricValue(2) = nan;
MaskedMetricValue(2) = str2double(res{1,1}{2,1});
MaskedMetricValueScan = {scanID, MaskedMetricValue };
save([RegOutputDir  matName '.mat' ], 'MaskedMetricValueScan');
load([RegOutputDir  'MaskedMetricEntireScan.mat'])
NCC_MI = -cell2mat(MaskedMetricValueScan(:,2));
NCC_MI = roundn(-cell2mat(MaskedMetricValueScan(:,2))*100,0);
MMI = NCC_MI(:,2);
maxMMI = 89;
ESnormedMMI = roundn(MMI/maxMMI*100, 0);
if ESnormedMMI>100, ESnormedMMI=100; end

fprintf("mmi for %s: %d\n", scanID, ESnormedMMI);
brain_name = convertCharsToStrings(scanID(1,5:end));
delete(IRN_PFN);

end