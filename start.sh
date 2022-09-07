#!/bin/sh

d=`dirname $0`
r=`readlink -f $d`

cd $r

jupyter notebook --config=config.py --no-browser
