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
	fi
fi
echo Building Program...
make -f $MAKEFILE
echo Done.
