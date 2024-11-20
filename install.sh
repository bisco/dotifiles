#!/bin/bash

CURDIR=$(pwd)
DOTFILES=$(ls | grep -v install.sh)

for i in ${DOTFILES[@]};
do
    ln -s $CURDIR/$i ~/.$i
    echo ln -s $CURDIR/$i ~/.$i
done
