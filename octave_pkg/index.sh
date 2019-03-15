#!/bin/bash

DIR=$1
PACKAGE=$(sed -n -e 's/^Title: *\(\w\+\)/\1/p' $DIR/DESCRIPTION)
echo "matgeom >> " "$PACKAGE"

for dir in geom3d polygons2d geom2d meshes3d utils graphs polynomialCurves2d;
do
 names=$(ls $DIR/inst/$dir | sed -n -e 's/\(\w\+\).m$/ \1/p')
 echo "$dir"
 echo "$names"
done


