#!/bin/bash
noofvar=$#
echo 'no of arguments are '$noofvar
echo ''

open_file='brain'

for ((i=1; i<=$noofvar; i=i+1))
do
	#echo 'open("'$open_file''${!i}'.tif");'
	
	echo 'open("D:\\Harsha\\Masterarbeit\\larvalign_data\\DataSetGoodQual\\brain\\'''$open_file''${!i}'.tif");'
	echo 'run("Split Channels");'
	echo 'close();'
	echo 'selectWindow("C2-'''$open_file''${!i}'.tif");'
	echo 'close();'
	echo 'selectWindow("C1-'''$open_file''${!i}'.tif");'
	echo 'run("Scale...", "x=- y=- z=- width=512 height=1024 depth=144 interpolation=Bicubic average process create title=np_'''$open_file''${!i}'''_scaled.tif");'
	echo 'run("Properties...", "channels=1 slices=144 frames=1 unit=\u00B5m pixel_width=0.4566360 pixel_height=0.4566360 voxel_depth=2.0000000");'
	echo 'run("Save", "save=D:\\Harsha\\Masterarbeit\\larvalign_data\\DataSetGoodQual\\brain\\np_'''$open_file''${!i}'''_scaled.tif");'
	echo 'close();'
	echo 'selectWindow("C1-'''$open_file''${!i}'.tif");'
	echo 'close();'
	echo ''
done
