#!/bin/bash

MODULES=(geom2d polynomialCurves2d polygons2d geom3d meshes3d graphs)

for MODULE in "${MODULES[@]}"
do
  MODULEFOLDER="matgeom-${MODULE}"
  echo "Creating module ${MODULEFOLDER} ..."
  rm -rf ${MODULEFOLDER}

  echo "Creating package structure ..."
  mkdir -p "${MODULEFOLDER}/inst"
  cp "DESCRIPTION_${MODULE}" "${MODULEFOLDER}/DESCRIPTION"
  cp "../matGeom/license.txt" "${MODULEFOLDER}/COPYING"
  cp Makefile "${MODULEFOLDER}/"

  echo "Reorganizing program files ..."
  cp -R "../matGeom/${MODULE}/" "${MODULEFOLDER}/inst/"

  echo "Renaming help files ..."
  mv "${MODULEFOLDER}/inst/{,${MODULE}_}Contents.m"

  echo "Remove unnecesary files"
  rm -f "${MODULEFOLDER}/inst/readme.txt"
  rm -f "${MODULEFOLDER}/inst/changelog.txt"
done
