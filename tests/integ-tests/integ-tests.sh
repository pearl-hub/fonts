#!/usr/bin/env bash

set -ex

source $HOME/.bashrc

echo -e "y\n\n\n\n\n" | pearl --verbose install test

[ -d $PEARL_HOME/packages/local/test ] || { echo "Error: The package test does not exist after installing it."; exit 1; }

if [[ $(uname) == 'Darwin' ]]; then
    ls -l $HOME/Library/Fonts
else
    [[ -e $HOME/.fonts ]] && ls -l $HOME/.fonts
    [[ -e $HOME/.local/share/fonts ]] && ls -l $HOME/.local/share/fonts
fi

echo -e "y\n\n\n\n\n" | pearl --verbose update test

pearl --no-confirm remove test

if [[ $(uname) == 'Darwin' ]]; then
    ls -l $HOME/Library/Fonts
else
    [[ -e $HOME/.fonts ]] && ls -l $HOME/.fonts
    [[ -e $HOME/.local/share/fonts ]] && ls -l $HOME/.local/share/fonts
fi
