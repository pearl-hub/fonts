#!/usr/bin/env bash

set -e

source $HOME/.bashrc

pearl install test

[ -d $PEARL_HOME/packages/default/test ] || { echo "Error: The package test does not exist after installing it."; exit 1; }

ls -l $HOME/.fonts

if [[ $(uname) == 'Darwin' ]]; then
    ls -l $HOME/Library/Fonts
else
    ls -l $HOME/.local/share/fonts
fi

pearl update test

pearl remove test

ls -l $HOME/.fonts

if [[ $(uname) == 'Darwin' ]]; then
    ls -l $HOME/Library/Fonts
else
    ls -l $HOME/.local/share/fonts
fi
