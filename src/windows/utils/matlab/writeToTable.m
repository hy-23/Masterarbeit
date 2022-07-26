function t = writeToTable(mmi, brain)
vxm = mmi(1,:)';
lrv = mmi(2,:)';

dif = vxm - lrv;
name = brain';
t = table(name, vxm, lrv, dif);

fprintf("worst mmi from vxm: %d\n", min(vxm));
fprintf("worst mmi from lrv: %d\n", min(lrv));

writetable(t, 'I:\03.masterarbeit_out\out\mmi.csv');
end