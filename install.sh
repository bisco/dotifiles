#!/bin/bash

CURDIR=$(pwd)
DOTFILES=$(ls | grep -v install.sh)

for i in ${DOTFILES[@]};
do
    if [ -d $i ]; then
        # fish-config 
        mkdir -p ~/.config/fish
        echo mkdir -p ~/.config/fish
        ln -s $CURDIR/$i/fish/config.fish ~/.config/fish/config.fish
        echo ln -s $CURDIR/$i/fish/config.fish ~/.config/fish/config.fish
        mkdir -p ~/.config/fish/functions
        echo mkdir -p ~/.config/fish/functions
        for j in $i/fish/functions/*
        do
            ln -s $(readlink -f $j) ~/.config/fish/functions/$(basename $j)
            echo ln -s $(readlink -f $j) ~/.config/fish/functions/$(basename $j)
        done
    else
        ln -s $CURDIR/$i ~/.$i
        echo ln -s $CURDIR/$i ~/.$i
    fi
done
