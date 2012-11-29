#!/bin/bash -xe

# NOTE: $WORKSPACE is the root of the project git repo

STAGING_AREA="$1"

#force a clean build if indicated
if [ -d $STAGING_AREA/clean.build ]; then
   echo "Performing CLEAN build."
   git clean -fdx
else
   echo "Performing INCREMENTAL build."
fi

#remove and recreate old staging area
rm -rf $STAGING_AREA/workspace/swc2swf
mkdir $STAGING_AREA/workspace/swc2swf

ant

#move build artifacts to staging area
cp $WORKSPACE/swc2swf.jar $STAGING_AREA/workspace/swc2swf/

#save change documentation to staging area
$SP_SCRIPTS/copy_component_changes.py $WORKSPACE/../builds/$BUILD_NUMBER/changelog.xml $STAGING_AREA/changes/swc2swf.txt

