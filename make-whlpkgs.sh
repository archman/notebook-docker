#!/bin/bash

#
# Create cache for PyPI packages.
#
# Tong Zhang <zhangt@frib.msu.edu>
# 2017-07-06 14:40:35 PM EDT
#

PACKAGES=`cat requirements.txt`

WHLROOT="wheel-packages"
! [ -e ${WHLROOT} ] && mkdir ${WHLROOT}

cd ${WHLROOT}

i=1
tot=`echo ${PACKAGES} | wc -w`
for pkg in ${PACKAGES}
do
    if ! [ -e ${pkg} ]; then
        mkdir ${pkg}
        echo "Caching package: [$i/$tot] ${pkg}..."
        sudo pip wheel --wheel-dir=${pkg} ${pkg}
    else
        echo "Cached package: [$i/$tot] ${pkg}"
    fi
    i=$((i+1))
done
