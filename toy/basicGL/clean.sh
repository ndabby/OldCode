#!/bin/sh
if [[ "$(uname)" = "Darwin" ]]
then
	echo Detected OS as Darwin
	MAKEFILE=makefile.OSX
else
	if [[ "$(uname)" = "Linux" ]]
	then
		echo Detected OS as Linux
		MAKEFILE=makefile.linux
		echo Cleaning  GLE Tubing and Extension library...
		cd gle-3.1.0
		make clean
		cd ..
		echo Done.
	fi
fi
echo Cleaning OpenGL UI...
cd glui_v2_2
make -f $MAKEFILE clean
cd ..
echo Done.
echo Building nuDraw...
make -f $MAKEFILE clean
echo Done.
