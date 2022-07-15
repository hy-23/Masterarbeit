#!/bin/bash
noofvar=$#
#echo 'no of arguments are '$noofvar
echo ''

open_file='brain'

for ((i=1; i<=$noofvar; i=i+1))
do
	#echo 'open("'$open_file''${!i}'.tif");'
	
	echo 'open("I:\masterarbeit_dataset\\larvalign_data-affine_registered\\DataSetGoodQual\\'''$open_file''${!i}'.tif\\'''$open_file''${!i}'.tif");'
	echo 'run("Split Channels");'
	echo 'selectWindow("C2-'''$open_file''${!i}'.tif");'
	echo 'close();'
	echo 'selectWindow("C1-'''$open_file''${!i}'.tif");'
	echo 'close();'
	echo 'run("Scale...", "x=- y=- z=- width=64 height=128 depth=64 interpolation=Bicubic average process create title=np_'''$open_file''${!i}'''_scaled.tif");'
	echo 'run("Properties...", "channels=1 slices=64 frames=1 unit=mm pixel_width=0.4566360 pixel_height=0.4566360 voxel_depth=2.0000000");'
	echo 'run("Save", "save=I:\masterarbeit_dataset\\larvalign_data-affine_registered\\DataSetGoodQual\\'''$open_file''${!i}'.tif\\np_'''$open_file''${!i}'''_scaled.tif");'
	echo 'close();'
	echo 'selectWindow("C3-'''$open_file''${!i}'.tif");'
	echo 'close();'
	echo ''
done
