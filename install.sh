#!/bin/bash

CURDIR=$(pwd)
DOTFILES=$(ls | grep -v install.sh)

for i in ${DOTFILES[@]};
do
    if [ -d $i ]; then
        # fish-config 
        ln -s $CURDIR/$i ~/.config
        echo ln -s $CURDIR/$i ~/.config
    else
        ln -s $CURDIR/$i ~/.$i
        echo ln -s $CURDIR/$i ~/.$i
    fi
done
