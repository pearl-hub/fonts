#!/bin/sh
set -ex

brew update
brew install bash findutils
# Coreutils should be already installed on OSX 7.3+ images:
#brew install coreutils
