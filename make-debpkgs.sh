#!/bin/bash

#
# Get required debian packages.
# 
# Tong Zhang <zhangt@frib.msu.edu>
# 2017-08-18 10:39:29 AM EDT
#

PKGDIR='debian-packages'

! [[ -e $PKGDIR ]] && mkdir $PKGDIR

git clone https://github.com/archman/packages.git $PKGDIR/
mv $PKGDIR/jessie/* $PKGDIR
/bin/rm -rf $PKGDIR/{jessie,trusty,.git} \
            $PKGDIR/scanserver*.deb \
            $PKGDIR/epics*.deb \
            $PKGDIR/libepics*.deb
